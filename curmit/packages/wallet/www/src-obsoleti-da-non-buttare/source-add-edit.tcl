ad_page_contract {

  @author Serena Saccani
  @cvs-id source-add-edit.tcl

} {
    source_id:integer,optional
    {mode "edit"}
}

ah::script_init -script_name wallet/source-add-edit

if {[ad_form_new_p -key source_id]} { 
    set page_title "Crea Provenienza"
    set buttons [list [list "Crea Provenienza" new]]
    set field_mode edit
} else {
    if {[string equal $mode "edit"]} {
        set page_title "Modifica Provenienza"
        set buttons [list [list "Modifica Provenienza" edit]]
        set field_mode display
    } else {
        set page_title "Visaualizza Provenienza"
        set buttons [list [list "OK" view]]
        set field_mode display
    }
}

set context [list [list sources-list {Lista Provenienze}] $page_title]

ad_form -name addedit \
        -mode $mode \
        -edit_buttons $buttons \
        -has_edit 1 \
        -form {
   
    source_id:key

    {source_name:text
	{label {Provenienza}}
        {html {size 50}}
    }

} -new_request {
 

} -edit_request {

    db_1row get_body_data "select source_id,
                                  source_name
                             from wal_sources
                            where source_id = :source_id"

} -on_submit {

    set errnum 0

    if {$source_name eq ""} {
	template::form::set_error addedit source_name "La Provenienza deve essere valorizzata."
	incr errnum
    }

    if {$errnum > 0} {
        break
    }

} -new_data {

    if {[db_0or1row query "
        select 1 
          from wal_sources 
         where source_name = :source_name"]} {
	template::form::set_error addedit source_name "Provenienza gia' presente."
	break
    }

    db_transaction {
	
	set body_id [db_string query "select coalesce(max(source_id) + 1, 1) from wal_sources"]

	db_dml query "
        insert into wal_sources ( source_id
                                 ,source_name
                      ) values ( :source_id
                                ,:source_name
                      )"

    } on_error {
          ah::transaction_error
    }
    
} -edit_data {

    db_transaction {
	
        db_dml query "update wal_sources set source_name = :source_name where source_id = :source_id"

    } on_error {
	ah::transaction_error
    }

} -after_submit {

    ad_returnredirect "sources-list?search_word=$source_name"
    ad_script_abort
}

