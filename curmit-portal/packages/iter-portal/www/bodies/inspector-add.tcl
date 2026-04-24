ad_page_contract {

    @author Claudio Pasolini

} {
    group_id
    {mode "edit"}
}

set user_id    [ad_conn user_id]

set group_name [db_string query "select group_name from groups where group_id=:group_id"]

set page_title "Aggiungi ispettore a $group_name"
set buttons [list [list "Aggiungi Ispettore" new]]
set context [list [list index {Lista Enti}] [list group-inspectors-list?group_id=$group_id {Membri}] $page_title]

ad_form -name addedit \
    -mode $mode \
    -edit_buttons $buttons \
    -has_edit 1 \
    -export {group_id} \
    -form {

	{inspector_id:integer(select)
	    {options { {"Scegli ..." ""} [db_list_of_lists query "
            select name || ' ' || first_name || '(' || email || ')', inspector_id
            from iter_inspectors
            order by upper(name), upper(first_name)
            "] }}
	    {label {Scegli Ispettore}}
	}
	{is_active_p:boolean(radio)
	    {options {{SI t} {NO f}}}
	    {label "Incarico attivo?"}
	}
	{company_id:integer(select),optional
	    {options { {"Scegli ..." ""} [db_list_of_lists query "
            select name || '(' || email || ')', company_id
            from iter_inspecting_companies
            order by upper(name)
            "] }}
	    {label {Scegli Azienda di ispezione}}
            {help_text {Indicare l'azienda solo se l'incarico all'Ispettore è assegnato dalla stessa.}}
	}
    } -on_submit {

	if {$inspector_id eq ""} {
	    template::form::set_error addedit inspector_id "Ispettore obbligatorio."
	    break
	}

	db_transaction {

	    # creo mapping Ente/Ispettore
	    db_dml map_new "
            insert into iter_bodies_inspectors_map (
                 map_id
                ,body_id
                ,inspector_id
                ,company_id
                ,is_active_p
            ) values (
                 [db_nextval acs_object_id_seq]
                ,:group_id
                ,:inspector_id
                ,:company_id
                ,:is_active_p
            )"

	} on_error {
	    ah::transaction_error
	}

	
    } -after_submit { 

	ad_returnredirect "group-inspectors-list?group_id=$group_id"
	ad_script_abort
    }
