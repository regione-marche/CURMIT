ad_page_contract {

    @author Serena Saccani
    @cvs-id coimtdoc-add-edit.tcl

} {
    id_tipo_documento:integer,optional
    {tipo_documento   ""}
    {f_descrizione    ""}
    {is_admin_p       ""}
    {mode         "edit"}
}

set user_id [auth::require_login]

set link_list [export_url_vars f_descrizione is_admin_p]

if {[ad_form_new_p -key id_tipo_documento]} {
    set page_title "Crea nuovo Tipo Documento"
    set buttons [list [list "Crea" new]]
    set field_mode edit
} else {
    if {[string equal $mode "edit"]} {
        set page_title "Modifica Tipo Documento"
        set buttons [list [list "Modifica" edit]]
        set field_mode display
    } else {
        set page_title "Visualizza Tipo Documento"
        set buttons [list [list "OK" view]]
        set field_mode display
    }
}

set context [list [list coimtdoc-list {Lista Tipi Documento}] $page_title]

ad_form -name addedit \
    -mode $mode \
    -edit_buttons $buttons \
    -has_edit 1 \
    -form {
	
	id_tipo_documento:key

        {tipo_documento:text 
            {label "Codice"}
            {html {size 2 maxlength 2}}
        }
        {descrizione:text 
            {label "Descrizione"}
            {html {size 50 maxlength 50}}
        }
	
    } -new_request {

    } -edit_request {

	db_1row query "
           select descrizione
                , tipo_documento
             from coimtdoc
            where id_tipo_documento = :id_tipo_documento"

    } -on_submit {

	set errnum 0

	if {$errnum > 0} {
	    break
	}
	
    } -new_data {

	db_transaction {
	    
	    set id_tipo_documento [db_string query "select coalesce(max(id_tipo_documento) + 1, 1) from coimtdoc"]
	    db_dml operator_add "
                insert into coimtdoc 
                     ( id_tipo_documento
                     , tipo_documento
                     , descrizione)
                values 
                     (:id_tipo_documento
                     ,:tipo_documento
                     ,:descrizione)"

	} on_error {
	    ah::transaction_error
	}
	
    } -edit_data {

	db_transaction {
	    
	    # aggiorno (tranne var e num_protocollo in quanto impostati automaticamente in inserimento)
	    db_dml query "
                update coimtdoc
                   set descrizione = :descrizione
                 where id_tipo_documento = :id_tipo_documento"

	} on_error {
	    ah::transaction_error
	}

    } -after_submit {

	ad_returnredirect "coimtdoc-list"
	ad_script_abort
    }

