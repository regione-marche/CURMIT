ad_page_contract {

    @author Claudio Pasolini
    @cvs-id trustee-new.tcl

} {
    trustee_id:integer,optional
    {mode "edit"}
}

set office_id [iter::office_script_init]

set page_title "Registra Amministratore"
set buttons [list [list "Registra Amministratore" new]]
set field_mode edit

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

    } -new_request {


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

    } -new_data {

	db_transaction {

	
	set trustee_id [db_string query "select coalesce(max(trustee_id) + 1, 1) from iter_trustees"]

	# inserisco amministratore
	db_dml trustee_add "
            insert into iter_trustees (
                 trustee_id
               , name
               , first_name
               , address1
               , address2
               , city
               , province
               , zipcode
               , jtype
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
               , office_id
            ) values (
                 :trustee_id
               , upper(:name)
               , upper(:first_name)
               , upper(:address1)
               , upper(:address2)
               , upper(:city)
               , upper(:province)
               , upper(:zipcode)
               , :jtype
               , upper(:fiscal_code)
               , :iva_code
               , :phone
               , :mobile
               , '.'
               , :fax
               , 't'
               , upper(:notes)
               , current_date                                                                
               , 'f'
               , 'f'
               , :office_id
            )"

	} on_error {
	    ah::transaction_error
	}

    } -after_submit {

	ad_returnredirect services
	ad_script_abort
    }



