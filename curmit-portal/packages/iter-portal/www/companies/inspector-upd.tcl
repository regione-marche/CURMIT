ad_page_contract {

    @author Claudio Pasolini
    @cvs-id inspector-upd.tcl

} {
    inspector_id
    {mode "edit"}
}

set company_id [auth::require_login]

if {![db_0or1row check_company "select 1 from iter_inspecting_companies where company_id = :company_id"]} {
    ad_returnredirect -message "Spiacente, ma questa pagina è riservata alle aziende di ispezione registrate." /
    ad_script_abort
}


if {![db_0or1row check_inspector "select approved_p, validated_p, name as inspector_name from iter_inspectors where company_id = :company_id and inspector_id = :inspector_id"]} {
    ad_returnredirect -message "Spiacente, ma l'ispettore non è tra quelli registrati dall'azienda." inspectors-list
    ad_script_abort
}

set to_approve_p $approved_p

if {$approved_p} {
    ad_returnredirect -message "Funzione non disponibile per questo ispettore, in quanto già approvato." inspectors-list
    ad_script_abort
}

set page_title "Modifica Dati Anagrafici"
set buttons [list [list "Modifica" edit]]
set field_mode display

set user_id $company_id

set context [list "$page_title"]

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
    {inspector_no:text,optional 
	{label {Matricola}}
	{html {size 20 maxlength 30}}
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
    {email:text(text),optional
	{label Email}
	{html {size 30}}
    }
    {fiscal_code:text,optional
	{label {Codice fiscale}}
	{html {maxlength 16}}
    }
    {iva_code:text,optional
	{label {P.IVA}}
	{html {maxlength 11}}
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
        template::form::set_error register email "Utente già registrato (E-mail già presente in archivio)."
	incr errnum
    }

    if {$fiscal_code ne ""} {
	set l [string length $fiscal_code]
	if {$l != 16 && $l != 11} {
	    template::form::set_error register fiscal_code "Lunghezza errata."
	    incr errnum
	} else {
	    if {[db_0or1row check_fiscal_code "select 1 from iter_inspectors where fiscal_code = :fiscal_code and inspector_id <> :inspector_id"]} {
		template::form::set_error register fiscal_code "Codice fiscale già presente in archivio."
		incr errnum
	    }
	}
    }

    if {$iva_code ne ""} {
	set l [string length $iva_code]
	if {$l != 11} {
	    template::form::set_error register iva_code "Lunghezza errata."
	    incr errnum
	} else {
	    if {[db_0or1row check_iva_code "select 1 from iter_inspectors where iva_code = :iva_code and inspector_id <> :inspector_id"]} {
		template::form::set_error register iva_code "Partita IVA già presente in archivio."
		incr errnum
	    }
	}
    }

    if {$errnum > 0} {
	break
    }

    } -edit_data {


	db_transaction {

	    # modifico ispettore
	    db_dml inspector_edit "
            update iter_inspectors set
                 name              = upper(:name)
               , first_name        = upper(:first_name)
               , inspector_no      = upper(:inspector_no)
               , email             = :email
               , address1          = upper(:address1)
               , address2          = upper(:address2)
               , city              = upper(:city)
               , province          = upper(:province)
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

	} on_error {
	    ah::transaction_error
	}

    } -after_submit {

	ad_returnredirect "inspector-services?inspector_id=$inspector_id"
	ad_script_abort
    }



