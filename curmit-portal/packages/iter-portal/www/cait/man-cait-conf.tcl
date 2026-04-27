ad_page_contract {

  @author Claudio Pasolini
  @cvs-id wcodes-add-edit.tcl

} {
    wallet_id
    iter_code
    {mode "edit"}
}

if {![db_0or1row query "select name from iter_maintainers where wallet_id = :wallet_id and iter_code = :iter_code"]} {
    ad_returnredirect -message "Manutentore non trovato." /
    ad_script_abort
}

if {[string equal $mode "edit"]} {
    set page_title "Conferma Login per Registrazione per bonifici"
    set buttons [list [list "Conferma" edit]]
    set field_mode display
} else {
    set page_title "Visaualizza Registrazione"
    set buttons [list [list "OK" view]]
    set field_mode display
}

set context [list [list services "Servizi per i manutentori"] ]

ad_form -name addedit \
        -mode $mode \
        -edit_buttons $buttons \
        -has_edit 1 \
        -form {
   
        {wallet_id:text
            {label {Codice Portafoglio Manutentore}}
            {html {size 50 maxlength 18 readonly ""}}
        }
        {iter_code:text 
            {label {Codice ITER}}
            {html {size 50 maxlength 8 readonly ""}}
        }

} -on_request {

    db_1row query "select *  from iter_maintainers where wallet_id = :wallet_id and iter_code = :iter_code"

} -on_submit {

    if {![db_0or1row query "select maintainer_id, cait_id from iter_maintainers where wallet_id = :wallet_id"]} {
	template::form::set_error addedit wallet_id "Codice Portafoglio Manutentore errato."
	break
    } elseif {[string equal $cait_id ""]}  {
	template::form::set_error addedit wallet_id "La pagina ÅË riservata ai manutentori associati ad un CAIT."
	break
    }
    if {![db_0or1row query "select maintainer_id as maintainer_id_c from iter_maintainers where iter_code = :iter_code"]} {
	template::form::set_error addedit iter_code "Codice ITER errato."
	break
    }
    if {![string equal $maintainer_id $maintainer_id_c]} {
	template::form::set_error addedit wallet_id "Il Codice Portafoglio ed il Codice ITER non appartengono allo stesso manutentore."
	break
    }
    
    
    
} -after_submit {

    ad_returnredirect "../welcome?maintainer_id=$maintainer_id"
    ad_script_abort
}



