ad_page_contract {

  @author Serena Saccani
  @cvs-id pay-type-add-edit.tcl

} {
    pay_type_id:integer,optional
    {mode "edit"}
}

ah::script_init -script_name wallet/pay-type-add-edit

if {[ad_form_new_p -key pay_type_id]} { 
    set page_title "Crea Tipo Pagamento"
    set buttons [list [list "Crea Tipo Pagamento" new]]
    set field_mode edit
} else {
    if {[string equal $mode "edit"]} {
        set page_title "Modifica Tipo Pagamento"
        set buttons [list [list "Modifica Tipo Pagamento" edit]]
        set field_mode display
    } else {
        set page_title "Visaualizza Tipo Pagamento"
        set buttons [list [list "OK" view]]
        set field_mode display
    }
}

set context [list [list pay-types-list {Lista Tipi Pagamento}] $page_title]

ad_form -name addedit \
        -mode $mode \
        -edit_buttons $buttons \
        -has_edit 1 \
        -form {
   
    pay_type_id:key

    {pay_type_name:text
	{label {Tipi Pagamento}}
        {html {size 50}}
    }

} -new_request {
 

} -edit_request {

    db_1row get_body_data "select pay_type_id,
                                  pay_type_name
                             from wal_payment_types
                            where pay_type_id = :pay_type_id"

} -on_submit {

    set errnum 0

    if {$pay_type_name eq ""} {
	template::form::set_error addedit pay_type_name "Il Tipo Pagamento deve essere valorizzato."
	incr errnum
    }

    if {$errnum > 0} {
        break
    }

} -new_data {

    if {[db_0or1row query "
        select 1 
          from wal_payment_types
         where pay_type_name = :pay_type_name"]} {
	template::form::set_error addedit pay_type_name "Tipo Pagamento gia' presente."
	break
    }

    db_transaction {
	
	set pay_type_id [db_string query "select coalesce(max(pay_type_id) + 1, 1) from wal_payment_types"]

	db_dml query "
        insert into wal_payment_types (  pay_type_id
                                        ,pay_type_name
                             ) values ( :pay_type_id
                                       ,:pay_type_name
                             )"

    } on_error {
          ah::transaction_error
    }
    
} -edit_data {

    db_transaction {
	
        db_dml query "update wal_payment_types set pay_type_name = :pay_type_name where pay_type_id = :pay_type_id"

    } on_error {
	ah::transaction_error
    }

} -after_submit {

    ad_returnredirect "pay-types-list?search_word=$pay_type_name"
    ad_script_abort
}

