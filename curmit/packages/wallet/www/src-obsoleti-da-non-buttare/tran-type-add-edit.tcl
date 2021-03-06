ad_page_contract {

  @author Serena Saccani
  @cvs-id tran-type-add-edit.tcl

} {
    tran_type_id:integer,optional
    {mode "edit"}
}

ah::script_init -script_name wallet/tran-type-add-edit

if {[ad_form_new_p -key tran_type_id]} { 
    set page_title "Crea Tipo Movimento"
    set buttons [list [list "Crea Tipo Movimento" new]]
    set field_mode edit
} else {
    if {[string equal $mode "edit"]} {
        set page_title "Modifica Tipo Movimento"
        set buttons [list [list "Modifica Tipo Movimento" edit]]
        set field_mode display
    } else {
        set page_title "Visaualizza Tipo Movimento"
        set buttons [list [list "OK" view]]
        set field_mode display
    }
}

set context [list [list tran-types-list {Lista Tipi Movimento}] $page_title]

ad_form -name addedit \
        -mode $mode \
        -edit_buttons $buttons \
        -has_edit 1 \
        -form {
   
    tran_type_id:key

    {tran_type_name:text
	{label {Tipo Movimento}}
        {html {size 50}}
    }

    {sign:text
	{label {Segno del Movimento}}
        {html {size 5}}
    }

} -new_request {
 

} -edit_request {

    db_1row get_body_data "select tran_type_id,
                                  tran_type_name,
                                  sign
                             from wal_transaction_types
                            where tran_type_id = :tran_type_id"

} -on_submit {

    set errnum 0

    if {$tran_type_name eq ""} {
	template::form::set_error addedit tran_type_name "Il Tipo Movimento deve essere valorizzato."
	incr errnum
    }

    if {$errnum > 0} {
        break
    }

} -new_data {

    if {[db_0or1row query "
        select 1 
          from wal_transaction_types 
         where tran_type_name = :tran_type_name"]} {
	template::form::set_error addedit tran_type_name "Tipo Movimento gia' presente."
	break
    }

    db_transaction {
	
	set tran_type_id [db_string query "select coalesce(max(tran_type_id) + 1, 1) from wal_transaction_types"]

	db_dml query "
        insert into wal_transaction_types (  tran_type_id
                                            ,tran_type_name
                                            ,sign
                                 ) values ( :tran_type_id
                                           ,:tran_type_name
                                           ,:sign
                                 )"

    } on_error {
          ah::transaction_error
    }
    
} -edit_data {

    db_transaction {
	
        db_dml query "update wal_transaction_types set tran_type_name = :tran_type_name, 
                                                                 sign = :sign 
                                                   where tran_type_id = :tran_type_id"

    } on_error {
	ah::transaction_error
    }

} -after_submit {

    ad_returnredirect "tran-types-list?search_word=$tran_type_name"
    ad_script_abort
}

