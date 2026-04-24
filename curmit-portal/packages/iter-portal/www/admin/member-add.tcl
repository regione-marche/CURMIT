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

set context [list [list bodies-list {Lista Enti}] [list group-members-list?group_id=$group_id {Membri}] $page_title]

# trovo il subsite
array set arr [site_node::get_from_url -url /]
set context_id $arr(package_id)

# ottengo il gruppo a cui appartengono, con relazione di
# composizione, tutti gli altri gruppi 
set subsite_group_id [application_group::group_id_from_package_id -package_id $context_id]

# trovo i gruppi corrispondenti agli enti
set groups_list [db_list groups "
    select g.group_id
    from acs_rels r, groups g
    where r.rel_type='composition_rel' and 
          r.object_id_one = :subsite_group_id and 
          r.object_id_two = g.group_id"]

ad_form -name addedit \
    -mode $mode \
    -edit_buttons $buttons \
    -has_edit 1 \
    -export {group_id} \
    -form {

	{user_id:integer(select)
	    {options { {"Scegli ..." ""} [db_list_of_lists query "
            select last_name || ' ' || first_names || '(' || email || ')', person_id
            from acs_rels r, persons p, parties pa
            where person_id     = party_id and
                  object_id_one = :subsite_group_id and
                  person_id     = object_id_two and
                  rel_type      = 'membership_rel' and
                  person_id not in (
                      select object_id_two 
                      from acs_rels 
                      where object_id_one in ([join $groups_list ,])
                  )
            order by upper(last_name), upper(first_names)
            "] }}
	    {label {Scegli utente}}
            {help_text {Ricorda che per aggiungere un membro ad un Ente, devi prima registrare l'utente.}}
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




