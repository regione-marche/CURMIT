ad_page_contract {

    @author Claudio Pasolini
    @cvs-id maintainer-edit.tcl

} {
    {mode "edit"}
}

set inspector_id [auth::require_login]

if {![db_0or1row check_inspector "select validated_p, approved_p from iter_inspectors where inspector_id = :inspector_id"]} {
    ad_returnredirect -message "Spiacente, ma questa pagina è riservata agli Ispettori registrati." /
    ad_script_abort
}

if {$approved_p} {
    ad_returnredirect -message "Operazione non consentita." /
    ad_script_abort
}

if {$validated_p && $approved_p} {
    set to_approve_p "f"
} else {
    set to_approve_p "t"
}

if {[string equal $mode "edit"]} {
    set page_title "Modifica Dati Registrati"
    set buttons [list [list "Modifica Dati Registrati" edit]]
    set field_mode display
} else {
    set page_title "Visualizza Dati Registrati"
    set buttons [list [list "OK" view]]
    set field_mode display
}

set user_id $inspector_id

set context [list "Modifica Dati Registrati"]

ad_form -name addedit \
    -mode $mode \
    -edit_buttons $buttons \
    -has_edit 1 \
    -form {
	
	inspector_id:key

	# Start section2
	{-section "sec2" {legendtext "Dati Anagrafici"} {fieldset {class legend}}}
        {name:text 
            {label {Cognome/Ragione sociale}}
            {html {size 50 maxlength 200}}
        }
        {first_name:text 
            {label {Nome}}
            {html {size 50 maxlength 200}}
        }
	{address1:text
	    {label {Indirizzo}}
	    {html {size 50 maxlength 200}}
	}
	{city:text
	    {label {Comune}}
	    {html {size 50 maxlength 40}}
	}
	{address2:text,optional 
	    {label {Località}}
	    {html {size 50 maxlength 40}}
	}
	{province:text
	    {label {Provincia}}
	    {html {size 5 maxlength 2}}
	}
	{zipcode:text
	    {label {C.A.P.}}
	    {html {size 10 maxlength 5}}
	}
	{course_type:text(radio)
	    {label {Tipo corso frequentato}}
	    {options { {"Enea" E} {"Ente Locale" L} }}
	}
	{course_resp:text,optional
	    {label {Ente responsabile del corso}}
	    {help_text {Obbligatorio se il corso è stato organizzato da un Ente Locale}}
	}
	{course_certif:text
	    {label {Attestato del corso}}
	}
        {fiscal_code:text
            {label {Codice fiscale}}
            {html {maxlength 16}}
        }
        {iva_code:text
            {label {P.IVA}}
            {html {maxlength 11}}
        }
	{email:email
	    {label Email}
	    {html {size 30}}
	}
	{phone:text
	    {label {Telefono}}
	}
	{fax:text,optional 
	    {label {Fax}}
	}
	{mobile:text,optional 
	    {label {Cellulare}}
	}
        {notes:text(textarea),optional,nospell 
            {label Note}
            {html {rows 5 cols 50 wrap soft}}
        }


	{-section ""}

    } -edit_request {

	db_1row get_inspector "
        select *
        from iter_inspectors
        where inspector_id = :inspector_id"

    } -on_submit {

        set errnum 0

        # check email
        if {[db_0or1row query "select 1 from parties where email = :email and party_id <> :inspector_id"]} {
            template::form::set_error addedit email "Utente già registrato (E-mail già presente in archivio)."
	    incr errnum
        }

        if {$course_type eq "L" && $course_resp eq ""} {
            template::form::set_error register course_resp "Campo obbligatorio"
            incr errnum
        }

	set l [string length $fiscal_code]
	if {$l != 16 && $l != 11} {
	    template::form::set_error addedit fiscal_code "Lunghezza errata."
	    incr errnum
	}
	if {[db_0or1row query "select 1 from iter_inspectors where fiscal_code = :fiscal_code and inspector_id <> :inspector_id"]} {
	    template::form::set_error addedit fiscal_code "Codice fiscale già presente in archivio."
	    incr errnum
	}

	set l [string length $iva_code]
	if {$l != 11} {
	    template::form::set_error register iva_code "Lunghezza errata."
	    incr errnum
	} else {
	    if {[db_0or1row query "select 1 from iter_inspectors where iva_code = :iva_code and inspector_id <> :inspector_id"]} {
		template::form::set_error register iva_code "Partita IVA già presente in archivio."
		incr errnum
	    }
	}


	if {$errnum > 0} {
	    break
	}

    } -edit_data {


	db_transaction {

	    db_dml inspector_edit "
            update iter_inspectors set
                 name              = upper(:name)
               , first_name        = upper(:first_name)
               , email             = :email
               , address1          = upper(:address1)
               , address2          = upper(:address2)
               , city              = upper(:city)
               , province          = upper(:province)
               , course_type       = :course_type
               , course_resp       = upper(:course_resp)
               , course_certif     = :course_certif
               , zipcode           = :zipcode
               , fiscal_code       = upper(:fiscal_code)
               , iva_code          = :iva_code
               , phone             = :phone
               , mobile            = :mobile
               , fax               = :fax
               , notes             = upper(:notes)
               , editing_date      = current_date
               , editing_user      = :user_id
             where inspector_id = :inspector_id"

            # aggiorno utente OpenACS
	    db_dml party "
            update parties set
                email = :email
            where party_id = :inspector_id"
            

	} on_error {
	    ah::transaction_error
	}

    } -after_submit {

	ad_returnredirect services
	ad_script_abort
    }



