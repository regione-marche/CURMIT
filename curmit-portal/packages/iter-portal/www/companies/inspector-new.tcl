ad_page_contract {

    @author Claudio Pasolini
    @cvs-id inspector-new.tcl

} {
    inspector_id:integer,optional
    {mode "edit"}
}

set company_id [auth::require_login]

if {![db_0or1row check_maint "select 1 from iter_inspecting_companies where company_id = :company_id"]} {
    ad_returnredirect -message "Spiacente, ma questa pagina è riservata alle aziende di ispezione registrate." /
    ad_script_abort
}


set page_title "Registra Ispettore"
set buttons [list [list "Registra Ispettore" new]]
set field_mode edit

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
    {inspector_no:text 
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
    {email:email(text),optional
	{label Email}
	{html {size 30}}
    }
    {fiscal_code:text
	{label {Codice fiscale}}
	{html {maxlength 16}}
    }
    {iva_code:text
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

    } -new_request {


    } -on_submit {

    set errnum 0

    # check email
    if {[db_0or1row query "select 1 from parties where email = :email"]} {
        template::form::set_error addedit email "Utente già registrato (E-mail già presente in archivio)."
	incr errnum
    }

    if {$email eq ""} {
	set email .
    }

    if {$fiscal_code ne ""} {
	set l [string length $fiscal_code]
	if {$l != 16 && $l != 11} {
	    template::form::set_error addedit fiscal_code "Lunghezza errata."
	    incr errnum
	} else {
	    if {[db_0or1row check_fiscal_code "select 1 from iter_inspectors where fiscal_code = :fiscal_code"]} {
		template::form::set_error addedit fiscal_code "Codice fiscale già presente in archivio."
		incr errnum
	    }
	}
    }

    if {$iva_code ne ""} {
	set l [string length $iva_code]
	if {$l != 11} {
	    template::form::set_error addedit iva_code "Lunghezza errata."
	    incr errnum
	} else {
	    if {[db_0or1row check_iva_code "select 1 from iter_inspectors where iva_code = :iva_code"]} {
		template::form::set_error addedit iva_code "Partita IVA già presente in archivio."
		incr errnum
	    }
	}
    }

    if {$errnum > 0} {
	break
    }

    } -new_data {


	db_transaction {

	db_dml query "
            insert into iter_inspectors (
                 inspector_id
               , name
               , first_name
               , inspector_no
               , address1
               , address2
               , city
               , province
               , zipcode
               , fiscal_code
               , iva_code
               , phone
               , mobile
               , email
               , fax
               , is_active_p
               , notes
               , creation_date                                                                
               , validated_p
               , approved_p
               , company_id
            ) values (
                 [db_nextval acs_object_id_seq]
               , upper(:name)
               , upper(:first_name)
               , upper(:inspector_no)
               , upper(:address1)
               , upper(:address2)
               , upper(:city)
               , upper(:province)
               , upper(:zipcode)
               , upper(:fiscal_code)
               , :iva_code
               , :phone
               , :mobile
               , :email
               , :fax
               , 't'
               , upper(:notes)
               , current_date                                                                
               , 'f'
               , 'f'
               , :company_id
            )"

	} on_error {
	    ah::transaction_error
	}

    } -after_submit {

	ad_returnredirect -message "L'ispettore è stato registrato." inspectors-list
	ad_script_abort
    }



