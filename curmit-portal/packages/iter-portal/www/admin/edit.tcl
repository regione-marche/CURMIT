ad_page_contract {

    @author Claudio Pasolini
    @cvs-id edit.tcl

     USER  DATA       MODIFICHE
     ===== ========== ==============================================================================
     but02  18/04/2024 commentato le variabile settate distributor_id per visualizzare la
     but02              modifica di distributori nel portale

    but01 08/03/2024 Aggiunto il campo f_rete_o_extrarete.
    
} {
    {mode "edit"}
    {distributor_id ""}
}

#but02 set distributor_id [auth::require_login]
set user_id [auth::require_login]

if {[string equal $mode "edit"]} {
    set page_title "Modifica Dati Registrati"
    set buttons [list [list "Modifica Dati Registrati" edit]]
    set field_mode display
} else {
    set page_title "Visualizza Dati Registrati"
    set buttons [list [list "OK" view]]
    set field_mode display
}

set context [list "Modifica Dati Registrati"]
ad_form -name addedit \
    -mode $mode \
    -edit_buttons $buttons \
    -has_edit 1 \
    -form {
	
	distributor_id:key

	# Start section2
	{-section "sec2" {legendtext "Dati Distributore"} {fieldset {class legend}}}
        {name:text 
            {label {Ragione sociale}}
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
        {fiscal_code:text,optional
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
	{f_rete_o_extrarete:text(select)
	    {label {Rete/Extra rete}}
	    {options {{{} {}} {"RETE" r} {"EXTRA RETE" e}}}
	}
        {notes:text(textarea),optional,nospell 
            {label Note}
            {html {rows 5 cols 50 wrap soft}}
        }

        {representative_id:integer(hidden)}

	# Start section3
	{-section "sec3" {legendtext "Rappresentante Legale"} {fieldset {class legend}}}
        
        {rep_name:text 
            {label {Cognome}}
            {html {size 50 maxlength 200}}
        }
        {rep_first_name:text 
            {label {Nome}}
            {html {size 50 maxlength 200}}
        }
	{rep_address1:text
	    {label {Indirizzo}}
	    {html {size 50 maxlength 200}}
	}
	{rep_city:text
	    {label {Comune}}
	    {html {size 50 maxlength 40}}
	}
	{rep_address2:text,optional 
	    {label {Località}}
	    {html {size 50 maxlength 40}}
	}
	{rep_province:text
	    {label {Provincia}}
	    {html {size 5 maxlength 2}}
	}
	{rep_zipcode:text
	    {label {C.A.P.}}
	    {html {size 10 maxlength 5}}
	}
        {rep_fiscal_code:text,optional
            {label {Codice fiscale}}
            {html {maxlength 16}}
        }

	{-section ""}

    } -edit_request {

	db_1row get_distributor "
        select d.*, 
               p.name as rep_name, 
               p.first_name as rep_first_name, 
               p.address1 as rep_address1, 
               p.city as rep_city, 
               p.address2 as rep_address2, 
               p.province as rep_province, 
               p.zipcode as rep_zipcode, 
               p.fiscal_code as rep_fiscal_code
        from iter_distributors d, iter_parties p
        where d.distributor_id    = :distributor_id
          and d.representative_id = p.party_id"

    } -on_submit {

        set errnum 0

        # check email
        if {[db_0or1row query "select 1 from parties where email = :email and party_id <> :distributor_id"]} {
            template::form::set_error addedit email "Utente già registrato (E-mail già presente in archivio)."
	    incr errnum
        }

	# controllo codice fiscale del distributore
	set l [string length $fiscal_code]
#	if {$l != 16 && $l != 11} {
#	    template::form::set_error addedit fiscal_code "Lunghezza errata."
#	    incr errnum
#	}
#	if {[db_0or1row query "select 1 from iter_distributors where fiscal_code = :fiscal_code and distributor_id <> :distributor_id"]} {
#	    template::form::set_error addedit fiscal_code "Codice fiscale già presente in archivio."
#	    incr errnum
#	}

	set l [string length $iva_code]
#	if {$l != 11} {
#	    template::form::set_error register iva_code "Lunghezza errata."
#	    incr errnum
#	} else {
#	    if {[db_0or1row query "select 1 from iter_distributors where iva_code = :iva_code and distributor_id <> :distributor_id"]} {
#		template::form::set_error register iva_code "Partita IVA già presente in archivio."
#		incr errnum
#	    }
#	}

	# controllo codice fiscale del rappresentante legale
#	set l [string length $fiscal_code]
#	if {$l != 16 && $l != 11} {
#	    template::form::set_error addedit rep_fiscal_code "Lunghezza errata."
#	    incr errnum
#	}

#	if {[db_0or1row query "select 1 from iter_parties where fiscal_code = :fiscal_code and party_id <> :representative_id"] > 1} {
#	    template::form::set_error addedit fiscal_code "Codice fiscale già presente in archivio."
#	    incr errnum
#	}

	if {$errnum > 0} {
	    break
	}

    } -edit_data {


	db_transaction {

	    # modifico distributore
	    db_dml distributor_edit "
            update iter_distributors set
                 name              = upper(:name)
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
               , f_rete_o_extrarete = :f_rete_o_extrarete     --but01
             where distributor_id = :distributor_id"

	    # modifico rappresentante legale
	    db_dml rep_edit "
            update iter_parties set
                name          = upper(:rep_name)
               ,first_name    = upper(:rep_first_name)
               ,address1      = upper(:rep_address1)
               ,address2      = upper(:rep_address2)
               ,city          = upper(:rep_city)
               ,province      = upper(:rep_province)
               ,zipcode       = :rep_zipcode
               ,fiscal_code   = upper(:rep_fiscal_code)
               ,editing_user  = :user_id
               ,editing_date  = current_date
            where party_id = :representative_id"

            # aggiorno utente OpenACS
	    db_dml party "
            update parties set
                email = :email
            where party_id = :distributor_id"
            

	} on_error {
	    ah::transaction_error
	}

    } -after_submit {

	ad_returnredirect list-distr
	ad_script_abort
    }

