ad_page_contract {

  @author Claudio Pasolini
  @cvs-id iban.tcl

} {
    {mode "edit"}
}


if {[string equal $mode "edit"]} {
    set page_title "Login per Registrazione IBAN"
    set buttons [list [list "Accedi" edit]]
    set field_mode display
} else {
    set page_title "Visualizza Registrazione"
    set buttons [list [list "OK" view]]
    set field_mode display
}

set context [list [list trustees-services "Servizi per gli amministratori"] ]

ad_form -name addedit \
        -mode $mode \
        -edit_buttons $buttons \
        -has_edit 1 \
        -form {
   
        {wallet_id:text
            {label {Codice Portafoglio Amministratore}}
            {html {size 50 maxlength 18}}
        }
        {iter_code:text 
            {label {Codice ITER}}
            {html {size 50 maxlength 8}}
        }

} -edit_request {


} -on_submit {

    

    if {![db_0or1row query "select trustee_id, office_id from iter_trustees where wallet_id = :wallet_id"]} {
	template::form::set_error addedit wallet_id "Codice Portafoglio Amministratore errato."
	break
    } elseif {[string equal $office_id ""]}  {
	template::form::set_error addedit wallet_id "La pagina ÅË riservata ai amministratori associati ad uno Studio."
	break
    }

    if {![db_0or1row query "select trustee_id as trustee_id_c from iter_trustees where iter_code = :iter_code"]} {
	template::form::set_error addedit iter_code "Codice ITER errato."
	break
    }
    if {![string equal $trustee_id $trustee_id_c]} {
	template::form::set_error addedit wallet_id "Il Codice Portafoglio ed il Codice ITER non appartengono allo stesso amministratore."
	break
    }

} -after_submit {

    ad_returnredirect "iban-2?wallet_id=$wallet_id&iter_code=$iter_code"
    ad_script_abort
}



