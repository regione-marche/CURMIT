ad_page_contract {

  @author Claudio Pasolini

} {
    {group_id ""}
    {mode "edit"}
}

set user_id    [ad_conn user_id]


if {[exists_and_not_null group_id]} {
    set select_clause "and object_id_two != :group_id"
    set page_title "Modifica Ente"
    set buttons [list [list "$page_title" new]]
    set field_mode display
} else {
    set select_clause ""
    set page_title "Crea Ente"
    set buttons [list [list "$page_title" new]]
    set field_mode edit
}

set context [list [list bodies-list {Lista Enti}] $page_title]

# trovo il subsite 
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
	    {label {Nome Ente}}
	    {html {size 50 maxlength 200}}
	    {mode $field_mode}
	}
	{email:email
	    {label {Email}}
	    {html {size 50 maxlength 100}}
	    {help_text "Indirizzo al quale verranno inviate le notifiche ed i file dei distributori."}
	}
	{url:text
	    {label {URL}}
	    {html {size 50 maxlength 200}}
	    {help_text "Indirizzo per l'accesso ad ITER da parte dell'Ente."}
	}
	{instance_name:text
	    {label {Nome istanza ITER}}
	    {html {size 50 maxlength 40}}
	}

} -on_request {

    if {[exists_and_not_null group_id]} {
        db_1row query "
            select group_name, object_id_one as parent_id, email, url, instance_name
            from groups g, acs_rels r, parties p, iter_instances i 
            where g.group_id       = :group_id and 
                  r.object_id_two  = :group_id and
                  group_id         = party_id  and
                  group_id         = instance_id
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

	    # aggiorno la email e la url del gruppo
	    party::update -party_id $group_id -email $email -url $url

            # inserisco istanza
	    db_dml instance_add "insert into iter_instances values (:group_id, :instance_name)"

	} on_error {
	    ah::transaction_error
	}

    } else {

	db_transaction {

  	    # aggiorno la email del gruppo
	    party::update -party_id $group_id -email $email -url $url

	    # aggiorno istanza
	    db_dml instance_edit "update iter_instances set instance_name = :instance_name where instance_id = :group_id"

	} on_error {
	    ah::transaction_error
	}

    }

} -after_submit { 

    ad_returnredirect "bodies-list"
    ad_script_abort
}




