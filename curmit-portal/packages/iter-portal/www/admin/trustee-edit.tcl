ad_page_contract {

    @author Claudio Pasolini
    @cvs-id trustee-edit.tcl

} {
    trustee_id:integer,optional
    {mode "edit"}
}

if {[string equal $mode "edit"]} {
    set page_title "Modifica Amministratore"
    set buttons [list [list "Modifica Amministratore" edit]]
    set field_mode display
} else {
    set page_title "Visualizza Amministratore"
    set buttons [list [list "OK" view]]
    set field_mode display
}

set user_id [auth::require_login] 

set context [list [list trustees-list {Lista Amministratori}] "Lista Amministratori"]

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
	    {html {size 5 maxlength 4}}
	}
	{zipcode:text
	    {label {C.A.P.}}
	    {html {size 10 maxlength 5}}
	}
        {fiscal_code:text
            {label {Codice fiscale}}
            {html {maxlength 16}}
        }
        {iva_code:text,optional
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
        {jtype:text(radio)
            {label {Ruolo}}
	    {options { {"Persona giuridica" 0} {"Persona fisica" 1} }}
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

        # check email
        if {[db_0or1row query "select 1 from parties where email = :email and party_id <> :trustee_id"]} {
            template::form::set_error addedit email "Utente già registrato (E-mail già presente in archivio)."
	    incr errnum
        }

	# controllo codice fiscale del amministratore

	if {[regexp {[^A-Za-z0-9]+} $fiscal_code] > 0 } {
	    template::form::set_error addedit fiscal_code "Contiene caratteri non validi."
	    incr errnum
	}
	set l [string length $fiscal_code]
	if {$l != 16 && $l != 11} {
	    template::form::set_error addedit fiscal_code "Lunghezza errata."
	    incr errnum
	} elseif {$l == 16 && [iter::verifyfc -xcodfis $fiscal_code] == 0} {
	    template::form::set_error addedit fiscal_code "Codice Fiscale errato."
	    incr errnum
	} elseif {$l == 11 && [iter::verifyvc -xcodfis $fiscal_code] == 0} {
	    template::form::set_error addedit fiscal_code "Codice Fiscale errato."
	    incr errnum
	}
	if {[db_0or1row query "select 1 from iter_trustees where fiscal_code = :fiscal_code and trustee_id <> :trustee_id"]} {
	    template::form::set_error addedit fiscal_code "Codice fiscale già presente in archivio."
	    incr errnum
	}

	if {[string equal $iva_code ""] && [string equal $jtype "0"]} {
	    template::form::set_error addedit iva_code "Campo Obbligatoro."
	    incr errnum
	}

	if {![string equal $iva_code ""]} {
	    set l [string length $iva_code]
	    if {$l != 11} {
		template::form::set_error addedit iva_code "Lunghezza errata."
		incr errnum
	    } elseif {[iter::verifyvc -xcodfis $iva_code] == 0} {
		template::form::set_error addedit iva_code "Partita IVA errata."
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
               , jtype             = :jtype
               , notes             = upper(:notes)
               , editing_date      = current_date
               ,editing_user       = :user_id
             where trustee_id = :trustee_id"


            # aggiorno utente OpenACS
	    db_dml party "
            update parties set
                email = :email
            where party_id = :trustee_id"
            

	} on_error {
	    ah::transaction_error
	}

    } -after_submit {

	ad_returnredirect "trustees-list"
	ad_script_abort
    }



