ad_page_contract {
    
    @author Gacalin Lufi
    @cvs-id citizen-edit.tcl
    
} {
    {mode "edit"}
}

set citizen_id [iter::script_init_cittadino]

if {[string equal $mode "edit"]} {
    set page_title "Modifica Dati Registrati"
    set buttons [list [list "Modifica Dati Registrati" edit]]
    set field_mode display
} else {
    set page_title "Visualizza Dati Registrati"
    set buttons [list [list "OK" view]]
    set field_mode display
}

#set user_id    [auth::require_login]
set user_id    [iter::script_init_cittadino]

set context [list "Modifica Dati Registrati"]

ad_form -name addedit \
    -mode $mode \
    -edit_buttons $buttons \
    -has_edit 1 \
    -form {
	citizen_id:key
	
	{-section "sec1" {legendtext "Dati Anagrafici"} {fieldset {class legend}}}
        {first_name:text 
            {label {Nome}}
            {html {size 50 maxlength 200}}
        }
	{last_name:text
            {label {Cognome}}
            {html {size 50 maxlength 200}}
        }
	{legal_nature:text(select),optional
            {label {Natura Giuridica}}
	    {options {{} {Fisica F} {Giuridica G}}}
        }
	{address1:text,optional
	    {label {Indirizzo}}
	    {html {size 50 maxlength 200}}
	}
	{city:text,optional
	    {label {Comune}}
	    {html {size 50 maxlength 40}}
	}
	{address2:text,optional 
	    {label {Località}}
	    {html {size 50 maxlength 40}}
	}
	{province:text,optional
	    {label {Provincia}}
	    {html {size 5 maxlength 2}}
	}
	{cap:text,optional
	    {label {C.A.P.}}
	    {html {size 10 maxlength 5}}
	}
	{sex:text(select),optional
	    {label {Sesso}}
	    {options {{} {Maschio M} {Femmina F}}}
        }
        {fiscal_code:text
            {label {Codice fiscale}}
            {html {maxlength 16}}
        }
	{cod_piva:text,optional
            {label {P.Iva}}
            {html {maxlength 11}}
        }
	{email:email
	    {label {Email}}
	    {html {size 30}}
	}
	{mobile:text 
	    {label {Cellulare}}
            {html {maxlength 11}}
	}
	{phone:text,optional
	    {label {Telefono}}
	    {html {maxlength 11}}
	}
	{fax:text,optional 
	    {label {Fax}}
            {html {maxlength 30}}
	}
	
	{-section ""}
	
    } -edit_request {
	
	db_1row get_citizen "select *
                               from iter_citizens
                              where citizen_id = :citizen_id"
	
    } -on_submit {

        set errnum 0
	
        # check email
        if {[db_0or1row query "select 1 from iter_citizens where email = :email and citizen_id <> :citizen_id"]} {
            template::form::set_error addedit email "Utente già registrato (E-mail già presente in archivio)."
	    incr errnum
        }
	
	if {[db_0or1row query "select 1 from parties where email = :email and party_id <> :citizen_id"]} {
            template::form::set_error addedit email "Utente già registrato (E-mail già presente in archivio)."
	    incr errnum
        }
	
	# controllo codice fiscale del cittadino
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
	if {[db_0or1row query "select 1 from iter_citizens where fiscal_code = :fiscal_code and citizen_id <> :citizen_id"]} {
	    template::form::set_error addedit fiscal_code "Codice fiscale già presente in archivio."
	    incr errnum
	}
	
	if {![string is space $cod_piva]} {
	    set l [string length $cod_piva]
	    if {$l != 11} {
		template::form::set_error addedit cod_piva "Lunghezza errata."
		incr errnum
	    } elseif {[iter::verifyvc -xcodfis $cod_piva] == 0} {
		template::form::set_error addedit cod_piva "Partita IVA errata."
		incr errnum
	    } else {
		if {[db_0or1row query "select 1 from iter_citizens where cod_piva = :cod_piva and citizen_id <> :citizen_id"]} {
		    template::form::set_error addedit cod_piva "Partita IVA già presente in archivio."
		    incr errnum
		}
	    }
	}
	
	if {$errnum > 0} {
	    break
	}
	
    } -edit_data {

	
	db_transaction {

	    db_dml citizen_edit "
            update iter_citizens set
                 last_name         = upper(:last_name)
               , first_name        = upper(:first_name)
               , legal_nature      = :legal_nature 
               , email             = :email
               , address1          = upper(:address1)
               , address2          = upper(:address2)
               , city              = upper(:city)
               , province          = upper(:province)
               , cap               = :cap
               , fiscal_code       = upper(:fiscal_code)
               , cod_piva          = :cod_piva
               , phone             = :phone
               , mobile            = :mobile
               , fax               = :fax
               , editing_date      = current_date
               , editing_user      = :user_id
               , sex               = :sex
             where citizen_id = :citizen_id"
	    
	    db_dml party "
            update parties set
                email = :email
            where party_id = :citizen_id"
            
	    
	} on_error {
	    ah::transaction_error
	}
	
    } -after_submit {

	ad_returnredirect citizen-services
	ad_script_abort
    }
	
