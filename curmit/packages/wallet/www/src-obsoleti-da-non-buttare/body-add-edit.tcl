ad_page_contract {

  @author Serena Saccani
  @cvs-id body-add-edit.tcl

} {
    body_id:integer,optional
    {mode "edit"}
}

ah::script_init -script_name wallet/body-add-edit

if {[ad_form_new_p -key body_id]} { 
    set page_title "Crea Ente"
    set buttons [list [list "Crea Ente" new]]
    set field_mode edit
} else {
    if {[string equal $mode "edit"]} {
        set page_title "Modifica Ente"
        set buttons [list [list "Modifica Ente" edit]]
        set field_mode display
    } else {
        set page_title "Visaualizza Ente"
        set buttons [list [list "OK" view]]
        set field_mode display
    }
}

set context [list [list bodies-list {Lista Enti}] $page_title]

ad_form -name addedit \
        -mode $mode \
        -edit_buttons $buttons \
        -has_edit 1 \
        -form {
   
    body_id:key

    {body_name:text
	{label {Nome Ente}}
        {html {size 50}}
    }

} -new_request {
 

} -edit_request {

    db_1row get_body_data "select body_id,
                                  body_name
                             from wal_bodies
                            where body_id = :body_id"

} -on_submit {

    set errnum 0

    if {$body_name eq ""} {
	template::form::set_error addedit body_name "L'ente deve essere valorizzato."
	incr errnum
    }

    if {$errnum > 0} {
        break
    }

} -new_data {

    if {[db_0or1row query "
        select 1 
          from wal_bodies 
         where body_name = :body_name"]} {
	template::form::set_error addedit body_name "Ente gia' inserito."
	break
    }

    db_transaction {
	
	set body_id [db_string query "select coalesce(max(body_id) + 1, 1) from wal_bodies"]

	db_dml query "
        insert into wal_bodies (  body_id
                                 ,body_name
                      ) values ( :body_id
                                ,:body_name
                      )"

    } on_error {
          ah::transaction_error
    }
    
} -edit_data {

    db_transaction {
	
        db_dml query "update wal_bodies set body_name = :body_name where body_id = :body_id"

    } on_error {
	ah::transaction_error
    }

} -after_submit {

    ad_returnredirect "bodies-list?search_word=$body_name"
    ad_script_abort
}
