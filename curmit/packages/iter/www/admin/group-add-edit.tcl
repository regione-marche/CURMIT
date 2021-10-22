ad_page_contract {

  @author Claudio Pasolini

} {
    {group_id ""}
    {parent_id ""}
    {mode "edit"}
}

set user_id    [ad_conn user_id]

if {[exists_and_not_null group_id]} {
    set select_clause "and object_id_two != :group_id"
    set page_title "Modifica Unità Organizzativa"
    set buttons [list [list "$page_title" new]]
    set field_mode display
} else {
    set select_clause ""
    set page_title "Crea Unità Organizzativa"
    set buttons [list [list "$page_title" new]]
    set field_mode edit
}

# l'utente ha diritti di admin sul package?
set admin_p [permission::permission_p \
		 -no_login \
		 -object_id [ad_conn package_id] \
		 -privilege admin]

if {!$admin_p} {
    ad_return_complaint 1 "Spiacente, ma questa funzione è riservata all'amministratore di ALTER"
    ad_script_abort
}

if {[exists_and_not_null group_id]} {
    set select_clause "and object_id_two != :group_id"
    set page_title "Modifica Unità Organizzativa"
    set buttons [list [list "$page_title" new]]
    set field_mode edit
} else {
    set select_clause ""
    set page_title "Crea Unità Organizzativa"
    set buttons [list [list "$page_title" new]]
    set field_mode edit
}

set context    [iter_context_bar \
		    [list /iter/main "Home"] \
		    [list index "Amministrazione Iter"] \
		    [list groups-list "Unità organizzative"] \
		    "$page_title"]


# trovo il subsite della intranet
array set arr [site_node::get_from_url -url /]
set context_id $arr(package_id)

# ottengo il gruppo a cui appartengono, con relazione di
# composizione, tutti gli altri gruppi 
set subsite_group_id [application_group::group_id_from_package_id -package_id $context_id]

ad_form -name addedit \
    -mode $mode \
    -edit_buttons $buttons \
    -export group_id \
    -has_edit 1 \
    -form {

	{group_name:text
	    {label {Nome Unità Organizzativa}}
	    {mode $field_mode}
	    {help_text "Digitare il nome, eventualmente abbreviato, dell'Unità Organizzativa."}
	}

	{parent_id:text(select),optional
	    {options { {"Scegli" ""} [db_list_of_lists query "
            select group_name, group_id
            from acs_rels r, groups g
            where rel_type      = 'composition_rel' and 
                  object_id_one = :subsite_group_id and
                  group_id      = object_id_two
                  $select_clause
            order by group_name
            "] }}
	    {label {Unità Organizzativa gerarchicamente superiore}}
	}
	{email:email,optional
	    {label {Email}}
	}
} -on_request {

    if {[exists_and_not_null group_id]} {
        db_1row query "
            select group_name, object_id_one as parent_id, email 
            from groups g, acs_rels r, parties p 
            where g.group_id       = :group_id and 
                  r.object_id_two  = :group_id and
                  group_id         = party_id
            order by object_id_one desc
            limit 1"
    }

} -on_submit {

    if {![exists_and_not_null group_id]} {

	db_transaction {
	    # aggiungo gruppo
	    set group_id [group::new \
			      -group_name $group_name \
			      -context_id $context_id \
			      "application_group" \
			     ]
	    # creo relazione di composizione con lo applicationgroup del subsite
	    relation_add  composition_rel $subsite_group_id $group_id

	    if {$parent_id ne ""} {
		# se è stato specificato un superiore gerarchico creo relazione
		relation_add  composition_rel $parent_id $group_id
	    }

	    if {$email ne ""} {
  	        # aggiorno la email del gruppo
	        party::update -party_id $group_id -email $email
	    }

	} on_error {
	    ah::transaction_error
	}

    } else {

	db_transaction {

	    # Se è specificato un parent, verifico innanzitutto se esiste già una
	    # relazione con un altro parent e la rimuovo, dopo di che inserisco la
	    # relazione con il nuovo parent.
	    if {$parent_id ne ""} {
		set rel_id [db_string get_old_parent "
                select rel_id from acs_rels where object_id_two=:group_id and object_id_one!=:subsite_group_id" -default ""]
		if {$rel_id ne ""} {
		    relation_remove $rel_id
		}
		relation_add  composition_rel $parent_id $group_id
	    }
	    db_dml query "update groups set group_name = :group_name where group_id = :group_id"
	    db_dml query "update acs_objects set title = :group_name where object_id = :group_id"
	    if {$email ne ""} {
  	        # aggiorno la email del gruppo
	        party::update -party_id $group_id -email $email
	    }

	} on_error {
	    ah::transaction_error
	}

    }

} -after_submit { 

    ad_returnredirect "groups-list"
    ad_script_abort
}




