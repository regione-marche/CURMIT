ad_page_contract {

  @author Claudio Pasolini

} {
    group_id
    {mode "edit"}
}

set user_id    [ad_conn user_id]

set group_name [db_string query "select group_name from groups where group_id=:group_id"]
set page_title "Aggiungi membro di $group_name"
set buttons [list [list "$page_title" new]]

set context [list [list groups-list {Elenco Unità Organizzative}] [list group-members-list?group_id=$group_id {Membri}] $page_title]
set context    [iter_context_bar \
		    [list /tosap/main "Home"] \
		    [list index "Amministrazione Viae"] \
		    [list group-list "Unità Organizzative"] \
		    [list group-members-list?group_id=$group_id "Membri"] \
		    "$page_title"]

# trovo il subsite della intranet
array set arr [site_node::get_from_url -url /]
set context_id $arr(package_id)

# ottengo il gruppo a cui appartengono, con relazione di
# composizione, tutti gli altri gruppi 
set subsite_group_id [application_group::group_id_from_package_id -package_id $context_id]

# trovo i gruppi corrispondenti agli enti
set groups_list [iter_subsite_group_list -url ""]
set groups_list [join $groups_list ,]

ad_form -name addedit \
    -mode $mode \
    -edit_buttons $buttons \
    -has_edit 1 \
    -export {group_id} \
    -form {

	{user_id:integer(select)
	    {options { {"Scegli ..." ""} [db_list_of_lists query "
            select first_names || ' ' || last_name, person_id
            from acs_rels r, persons p
            where object_id_one = :subsite_group_id and
                  person_id     = object_id_two and
                  rel_type      = 'membership_rel' and
                  person_id not in (
                      select object_id_two 
                      from acs_rels 
                      where object_id_one in ($groups_list)
                  )
            "] }}
	    {label {Scegli utente}}
	}

} -on_submit {

    db_transaction {

	# creo relazione di membership
        relation_add -member_state approved membership_rel $group_id $user_id

    } on_error {
        ah::transaction_error
    }

} -after_submit { 

    ad_returnredirect "group-members-list?group_id=$group_id"
    ad_script_abort
}




