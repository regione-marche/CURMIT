ad_page_contract {

  Registrazione codice IBAN.
  Il programma accetta in ingresso il codice maintainer_id o trustee_id.   

  @author Claudio Pasolini
  @cvs-id wcodes-add-edit.tcl

} {
    {maintainer_id ""}
    {trustee_id ""}
    {mode "edit"}
}

if {$maintainer_id ne ""} {
    db_1row query "
    select name, wallet_id, validated_p, approved_p, cait_id 
    from iter_maintainers 
    where maintainer_id = :maintainer_id"

    if {$cait_id eq ""} {
	set party_type maintainer
        set return_url "services"
    } else {
	set party_type cait
        set return_url "cait/services"
    }

    set table iter_maintainers
    set pkey  maintainer_id
    set user_id $maintainer_id
} elseif {$trustee_id ne ""} {
    db_1row query "
    select name, wallet_id, 1 as validated_p, approved_p, office_id
    from iter_trustees
    where trustee_id = :trustee_id"

    if {$office_id eq ""} {
	set party_type trustee
        set return_url "jbuild/servtrust"
    } else {
	set party_type office
        set return_url "offices/trustees-services"
    }

    set table iter_trustees
    set pkey  trustee_id
    set user_id $trustee_id
} else {
    set return_url "services"
    ad_returnredirect -message "La registrazione del codice IBAN richiede in ingresso il codice manutentore o amministratore." $return_url
    ad_script_abort
}

if {!$validated_p} {
    ad_returnredirect -message "La registrazione del codice IBAN è riservata ai soggetti già convalidati." $return_url
    ad_script_abort
}

set wallet_credit_pretty "0,00"

if {[string equal $mode "edit"]} {
    set page_title "Registrazione per bonifici"
    set buttons [list [list "Registra" edit]]
    set field_mode display
} else {
    set page_title "Visualizza Registrazione"
    set buttons [list [list "OK" view]]
    set field_mode display
}

set context [list [list services "Servizi per i manutentori"] $page_title]

ad_form -name addedit \
        -mode $mode \
        -export {maintainer_id trustee_id} \
        -edit_buttons $buttons \
        -has_edit 1 \
        -form {
   
	user_id:key

        {cc_name:text
            {label {Intestatario Conto Corrente}}
            {html {size 50 maxlength 27}}
        }
        {iban_code:text 
            {label {Codice IBAN}}
            {html {size 50 maxlength 27}}
        }
        {iban_code_c:text 
            {label {Conferma Codice IBAN}}
            {html {size 50 maxlength 27}}
        }

} -edit_request {
    
    db_1row query "
        select * 
        from $table 
        where $pkey = :user_id"

} -on_submit {
    
    # controllo IBAN
    if {![string equal $iban_code ""]} {
	set l [string length $iban_code]
	if {$l != 27} {
	    template::form::set_error addedit iban_code "Codice IBAN incompleto."
	    break
	}
    }
    if {![string equal $iban_code $iban_code_c]} {
	template::form::set_error addedit iban_code "Il Codice IBAN e la conferma del Codice IBAN sono diversi."
	break
    }
    set ibanp [string range $iban_code 0 1]
    if {![regexp {^[A-Za-z]+$} $ibanp]} {
	template::form::set_error addedit iban_code "I primi due caratteri del Codice IBAN devono essere delle lettere"
	break
    }
    set ibanp [string range $iban_code 2 3]
    if {![regexp {^[0-9]+$} $ibanp]} {
	template::form::set_error addedit iban_code "Il terzo e quarto carattere del codice IBAN devono essere delle cifre"
	break
    }
    set ibanp [string range $iban_code 4 4]
    if {![regexp {^[A-Za-z]+$} $ibanp]} {
	template::form::set_error addedit iban_code "Il quinto carattere del codice IBAN deve essere una lettera"
	break
    }
#    set ibanp [string range $iban_code 5 23]
#    if {![regexp {^[0-9]+$} $ibanp]} {
#	template::form::set_error addedit iban_code "Gli ultimi 22 caratteri del codice IBAN tranne gli ultimi 3 devono essere delle cifre"
#	break
#    }

    db_transaction {
	
	db_dml query "
            update $table set
                 iban_code = upper(:iban_code)          
                ,cc_name   = upper(:cc_name)          
            where $pkey = :user_id
      "
    } on_error {
	ah::transaction_error
    }

} -after_submit {

    ad_returnredirect [export_vars -base wcodes-return {party_type}]
    ad_script_abort

}
