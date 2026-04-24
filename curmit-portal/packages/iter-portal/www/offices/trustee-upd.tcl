ad_page_contract {

    @author Claudio Pasolini
    @cvs-id trustee-edit.tcl

} {
    trustee_id
    {mode "edit"}
}

set office_id [iter::office_script_init]

if {![db_0or1row check_trustee "select approved_p, validated_p, name as trustee_name from iter_trustees where office_id = :office_id and trustee_id = :trustee_id"]} {
    ad_returnredirect -message "Spiacente, ma il manutentore non è tra quelli registrati dallo Studio." /
    ad_script_abort
}

if {$approved_p && !$validated_p} {
    ad_returnredirect -message "Funzione non disponibile per questo manutentore." /
    ad_script_abort
}

if {!$validated_p && !$approved_p} {
    set to_approve_p "t"
} else {
    set to_approve_p "f"
}

set reg_msg [iter::get_reg_msg -validated_p $validated_p -approved_p $approved_p -num_msg ""]

set page_title "Modifica Dati Anagrafici"
set buttons [list [list "Modifica" edit]]
set field_mode display

set context [list "Dati Registrati"]

ad_form -name addedit \
    -mode $mode \
    -edit_buttons $buttons \
    -has_edit 1 \
    -form {
	
	trustee_id:key

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
    {jtype:text(radio)
	{label {Natura Giuridica}}
	{options { {"Persona Fisica" 1} {"Persona Giuridica" 0}}}
    }
    {fiscal_code:text
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

	db_1row get_trustee "
        select *
        from iter_trustees
        where trustee_id = :trustee_id"

    } -on_submit {

        set errnum 0

	# controllo codice fiscale del amministratore
	set l [string length $fiscal_code]
	if {$l != 16 && $l != 11} {
	    template::form::set_error addedit fiscal_code "Lunghezza errata."
	    incr errnum
	}
	if {[db_0or1row query "select 1 from iter_trustees where fiscal_code = :fiscal_code and trustee_id <> :trustee_id"]} {
	    template::form::set_error addedit fiscal_code "Codice fiscale già presente in archivio."
	    incr errnum
	}

        if {$jtype == 0} {
	    set l [string length $iva_code]
	    if {$l != 11} {
		template::form::set_error addedit iva_code "Lunghezza errata."
		incr errnum
	    } else {
		if {[db_0or1row query "select 1 from iter_trustees where iva_code = :iva_code and trustee_id <> :trustee_id"]} {
		    template::form::set_error addedit iva_code "Partita IVA già presente in archivio."
		    incr errnum
		}
	    }
	}
	
	if {$errnum > 0} {
	    break
	}

    } -edit_data {


	db_transaction {

	    # modifico amministratore
	    db_dml trustee_edit "
            update iter_trustees set
                 name              = upper(:name)
               , first_name        = upper(:first_name)
               , address1          = upper(:address1)
               , address2          = upper(:address2)
               , city              = upper(:city)
               , province          = upper(:province)
               , zipcode           = :zipcode
               , jtype             = :jtype
               , fiscal_code       = upper(:fiscal_code)
               , iva_code          = :iva_code
               , phone             = :phone
               , mobile            = :mobile
               , fax               = :fax
               , notes             = upper(:notes)
               , editing_date      = current_date
               ,editing_user       = :office_id

             where trustee_id = :trustee_id"

	} on_error {
	    ah::transaction_error
	}

    } -after_submit {

	ad_returnredirect "trustees-services?trustee_id=$trustee_id"
	ad_script_abort
    }



