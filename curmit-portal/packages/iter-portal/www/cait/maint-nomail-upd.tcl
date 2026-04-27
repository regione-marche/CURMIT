ad_page_contract {

    @author Claudio Pasolini
    @cvs-id maintainer-edit.tcl

} {
    {cait_id ""}
    maintainer_id
    {mode "edit"}
}

if {$cait_id eq ""
    set cait_id [auth::require_login]
    set user_id [auth::require_login] 
} else {
    set user_id $cait_id
}

if {![db_0or1row check_maint "select 1 from iter_cait where cait_id = :cait_id"]} {
    ad_returnredirect -message "Spiacente, ma questa pagina è riservata ai CAIT registrati." /
    ad_script_abort
}
if {![db_0or1row check_maint "select approved_p, validated_p, name as maintainer_name from iter_maintainers where cait_id = :cait_id and maintainer_id = :maintainer_id"]} {
    ad_returnredirect -message "Spiacente, ma il manutentore non è tra quelli registrati dal CAIT." /
    ad_script_abort
}
if {[string equal $approved_p "t"] && [string equal $validated_p "f"]} {
    ad_returnredirect -message "Funzione non disponibile per questo manutentore." /
    ad_script_abort
}

set num_msg [iter::check_reg -maintainer_id $maintainer_id]
if {[string equal $num_msg ""] && ![string equal $validated_p "t"] && ![string equal $approved_p "t"]} {
    set to_approve_p "t"
} else {
    set to_approve_p "f"
}

set reg_msg [iter::get_reg_msg -validated_p $validated_p -approved_p $approved_p -num_msg $num_msg]



if {[ad_form_new_p -key maintainer_id]} { 
    set page_title "Registra Manutentore"
    set buttons [list [list "Registra Manutentore" new]]
    set field_mode edit
} else {
    if {[string equal $mode "edit"]} {
        set page_title "Modifica Dati Anagrafici"
        set buttons [list [list "Modifica" edit]]
        set field_mode display
    } else {
        set page_title "Visaualizza Operatore"
        set buttons [list [list "OK" view]]
        set field_mode display
    }
}


set context [list "Dati Registrati"]

ad_form -name addedit \
    -mode $mode \
    -edit_buttons $buttons \
    -has_edit 1 \
    -form {
	
	maintainer_id:key

	# Start section2
	{-section "sec2" {legendtext "Dati Anagrafici"} {fieldset {class legend}}}
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
	{where_registered:text,optional
	    {label {Località Registro Imprese}}
	    {html {size 50}}
	}
	{registration_no:text,optional
	    {label {N. Registro Imprese}}
	    {html {size 50}}
	}
	{where_rea:text,optional
	    {label {Località REA}}
	    {html {size 50}}
	}
	{rea_no:text,optional
	    {label {N. REA}}
	    {html {size 50 maxlength 15}}
	}
        {role:text(radio)
            {label {Ruolo}}
	    {options { {"Manutentore" 1} {"Installatore" 0} {"Installatore/Manutentore" 2}}}
        }
	{op_number_pretty:text
	    {label {N° Operatori impegnati:}}
	    {html {size 10}}
	}
	{an_number_pretty:text
	    {label {N° Analizzatori utilizzati:}}
	    {html {size 10}}
	}
	{de_number_pretty:text
	    {label {N° Deprimometri utilizzati:}}
	    {html {size 10}}
	}
	{associated_to:text,optional
	    {label {Associazione di riferimento:}}
	    {html {size 50}}
	}
	{capital_pretty:text,optional
	    {label {Capitale versato}}
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
	    {html {size 5 maxlength 4}}
	}
	{rep_zipcode:text
	    {label {C.A.P.}}
	    {html {size 10 maxlength 5}}
	}
        {rep_fiscal_code:text
            {label {Codice fiscale}}
            {html {maxlength 16}}
        }

	{-section ""}

    } -edit_request {

	db_1row get_maintainer "
        select *
        from iter_maintainers_view
        where maintainer_id = :maintainer_id"


    } -on_submit {

        set errnum 0

	# controllo codice fiscale del manutentore
	set l [string length $fiscal_code]
	if {$l != 16 && $l != 11} {
	    template::form::set_error addedit fiscal_code "Lunghezza errata."
	    incr errnum
	}
	if {[db_0or1row query "select 1 from iter_maintainers where fiscal_code = :fiscal_code and maintainer_id <> :maintainer_id"]} {
	    template::form::set_error addedit fiscal_code "Codice fiscale già presente in archivio."
	    incr errnum
	}

	set l [string length $iva_code]
	if {$l != 11} {
	    template::form::set_error addedit iva_code "Lunghezza errata."
	    incr errnum
	} else {
	    if {[db_0or1row query "select 1 from iter_maintainers where iva_code = :iva_code and maintainer_id <> :maintainer_id"]} {
		template::form::set_error addedit iva_code "Partita IVA già presente in archivio."
		incr errnum
	    }
	}

	if  {$capital_pretty ne ""} {
	    set capital [ah::check_num $capital_pretty 2]
	    if {$capital eq "Error"} {
		template::form::set_error addedit capital_pretty  "Importo errato."
		incr errnum
	    }
	} else {
	    set capital ""
	}

	set op_number [ah::check_num $op_number_pretty 0]
	if {$op_number eq "Error"} {
	    template::form::set_error addedit op_number_pretty  "Numero errato."
	    incr errnum
	} elseif {$op_number == 0} {
	    template::form::set_error addedit op_number_pretty  "Il numero di operatori deve essere maggiore di zero."
	    incr errnum
	}

	set an_number [ah::check_num $an_number_pretty 0]
	if {$an_number eq "Error"} {
	    template::form::set_error addedit an_number_pretty  "Numero errato."
	    incr errnum
	} elseif {$an_number == 0} {
	    if {![string equal $role "0"]} {
		template::form::set_error addedit an_number_pretty  "Il numero di analizzatori deve essere maggiore di zero."
		incr errnum
	    }
	}

	set de_number [ah::check_num $de_number_pretty 0]
	if {$de_number eq "Error"} {
	    template::form::set_error addedit de_number_pretty  "Numero errato."
	    incr errnum
	} elseif {$de_number == 0} {
	    if {![string equal $role "0"]} {
		template::form::set_error addedit de_number_pretty  "Il numero di analizzatori deve essere maggiore di zero."
		incr errnum
	    }
	}

	# controllo codice fiscale del rappresentante legale
	set l [string length $fiscal_code]
	if {$l != 16 && $l != 11} {
	    template::form::set_error addedit rep_fiscal_code "Lunghezza errata."
	    incr errnum
	}

	
	if {$errnum > 0} {
	    break
	}

    } -edit_data {


	db_transaction {

	    # modifico manutentore
	    db_dml maintainer_edit "
            update iter_maintainers set
                 name              = upper(:name)
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
               , associated_to     = upper(:associated_to)
               , where_registered  = upper(:where_registered)
               , registration_no   = upper(:registration_no)          
               , where_rea         = upper(where_rea)
               , rea_no            = upper(:rea_no)
               , capital           = :capital
               , role              = :role
               ,op_number          = :op_number
               ,an_number          = :an_number
               ,de_number          = :de_number
               , notes             = upper(:notes)
               , editing_date      = current_date
               ,editing_user       = :user_id
             where maintainer_id = :maintainer_id"

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

	} on_error {
	    ah::transaction_error
	}

    } -after_submit {

	ad_returnredirect "/iter-portal/admin/maintainers-list?search_name=$name"
	ad_script_abort
    }



