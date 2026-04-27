ad_page_contract {

    @author Claudio Pasolini
    @cvs-id maintainer-edit.tcl

} {
    maintainer_id:integer,optional
    {mode "edit"}
}

set cait_id [auth::require_login]

if {![db_0or1row check_maint "select 1 from iter_cait where cait_id = :cait_id"]} {
    ad_returnredirect -message "Spiacente, ma questa pagina è riservata ai CAIT registrati." /
    ad_script_abort
}


if {[ad_form_new_p -key maintainer_id]} { 
    set page_title "Registra Manutentore"
    set buttons [list [list "Registra Manutentore" new]]
    set field_mode edit
} else {
    if {[string equal $mode "edit"]} {
        set page_title "Modifica Operatore"
        set buttons [list [list "Modifica Operatore" edit]]
        set field_mode display
    } else {
        set page_title "Visaualizza Operatore"
        set buttons [list [list "OK" view]]
        set field_mode display
    }
}

set user_id [auth::require_login] 

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

    # Start section4
    {-section "sec4" {legendtext "Operatore (Registrarne almeno 1)"} {fieldset {class legend}}}

        {op_name:text 
            {label {Cognome}}
            {html {size 50 maxlength 200}}
        }
        {op_first_name:text 
            {label {Nome}}
            {html {size 50 maxlength 100}}
        }
        {op_no:text 
            {label {Matricola}}
            {html {size 50}}
        }
        {op_fiscal_code:text
            {label {Codice fiscale}}
            {html {maxlength 16}}
        }
        {op_phone:text,optional 
            {label {Telefono}}
        }
        {op_mobile:text,optional 
            {label {Cellulare}}
        }
        {op_address:text,optional
            {label {Recapito}}
            {html {size 50 maxlength 200}}
        }
        {op_notes:text(textarea),optional,nospell 
            {label Note}
            {html {rows 5 cols 50 wrap soft}}
        }

    # Start section5
    {-section "sec5" {legendtext "Analizzatori di Combustione (registrarne almeno 1)"} {fieldset {class legend}}}

        {an_brand:text 
            {label {Marca}}
            {html {size 50 maxlength 200}}
        }
        {an_model:text 
            {label {Modello}}
            {html {size 50 maxlength 200}}
        }
        {an_no:text 
            {label {Matricola}}
            {html {size 50 maxlength 200}}
        }
        {an_last_calibration_date_pretty:text 
            {label {Data Ultima Taratura (gg/mm/aaaa)}}
            {html {size 10 maxlength 10}}
        }

    # Start section6
    {-section "sec6" {legendtext "Deprimometri (registrarne almeno 1)"} {fieldset {class legend}}}

        {de_brand:text 
            {label {Marca}}
            {html {size 50 maxlength 200}}
        }
        {de_model:text 
            {label {Modello}}
            {html {size 50 maxlength 200}}
        }
        {de_no:text 
            {label {Matricola}}
            {html {size 50 maxlength 200}}
        }
        {de_last_calibration_date_pretty:text 
            {label {Data Ultima Taratura (gg/mm/aaaa)}}
            {html {size 10 maxlength 10}}
        }

	{-section ""}

    } -new_request {


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
		template::form::set_error addedit de_number_pretty  "Il numero di deprimometri deve essere maggiore di zero."
		incr errnum
	    }
	}

	# controllo codice fiscale del rappresentante legale
	set l [string length $fiscal_code]
	if {$l != 16 && $l != 11} {
	    template::form::set_error addedit rep_fiscal_code "Lunghezza errata."
	    incr errnum
	}

	# controllo codice fiscale dell'operatore
	set l [string length $op_fiscal_code]
	if {$l != 16} {
	    template::form::set_error addedit op_fiscal_code "Lunghezza errata."
	    incr errnum
	} else {
#	    if {[db_0or1row check_op_fiscal_code "select 1 from iter_operators where fiscal_code = :op_fiscal_code"]} {
#		template::form::set_error addedit op_fiscal_code "Codice fiscale già presente in archivio."
#		incr errnum
#	    }
	}
	
	set an_last_calibration_date [ah::check_date -input_date $an_last_calibration_date_pretty]
	if {$an_last_calibration_date eq "0"} {
	    template::form::set_error addedit an_last_calibration_date_pretty  "Data errata."
	    incr errnum
	}
	
	set de_last_calibration_date [ah::check_date -input_date $de_last_calibration_date_pretty]
	if {$de_last_calibration_date eq "0"} {
	    template::form::set_error addedit de_last_calibration_date_pretty  "Data errata."
	    incr errnum
	}
	
	if {$errnum > 0} {
	    break
	}

    } -new_data {


	db_transaction {

	set party_id [db_string query "select coalesce(max(party_id) + 1, 1) from iter_parties"]
	# inserisco rappresentante legale
	db_dml query "
            insert into iter_parties (
                 party_id
               , name
               , first_name
               , address1
               , address2
               , city
               , province
               , zipcode
               , fiscal_code                                                                                                
               , creation_date                                                                
            ) values (
                 :party_id
               , upper(:rep_name)
               , upper(:rep_first_name)
               , upper(:rep_address1)
               , upper(:rep_address2)
               , upper(:rep_city)
               , upper(:rep_province)
               , :rep_zipcode
               , upper(:rep_fiscal_code) 
               , current_date                                                                
            )"
	
	
	set maintainer_id [db_string query "select coalesce(max(maintainer_id) + 1, 1) from iter_maintainers"]
	# inserisco manutentore
	db_dml maintainer_add "
            insert into iter_maintainers (
                 maintainer_id
               , name
               , address1
               , address2
               , city
               , province
               , zipcode
               , fiscal_code                                                                                                
               , iva_code
               , phone
               , mobile
               , fax
               , email
               , associated_to                                                                
               , where_registered                
               , registration_no                                
               , where_rea
               , rea_no
               , capital
               , role
               , op_number
               , an_number
               , de_number
               , is_active_p
               , representative_id                                                
               , notes
               , creation_date                                                                
               , validated_p
               , approved_p
               , cait_id
            ) values (
                 :maintainer_id
               , upper(:name)
               , upper(:address1)
               , upper(:address2)
               , upper(:city)
               , upper(:province)
               , upper(:zipcode)
               , upper(:fiscal_code)
               , :iva_code
               , :phone
               , :mobile
               , :fax
               , '.'
               , upper(:associated_to)
               , upper(:where_registered)
               , upper(:registration_no)
               , upper(:where_rea)
               , upper(:rea_no)
               , :capital
               , :role
               , :op_number
               , :an_number
               , :de_number
               , 't'
               , :party_id
               , upper(:notes)
               , current_date                                                                
               , 'f'
               , 'f'
               , :cait_id
            )"
	
	set operator_id [db_string query "select coalesce(max(operator_id) + 1, 1) from iter_operators"]
	# inserisco operatore
	db_dml operator_add "
            insert into iter_operators (
                 operator_id   
               , maintainer_id 
               , name          
               , first_name    
               , no            
               , phone         
               , mobile        
               , address       
               , is_active_p   
               , fiscal_code   
               , notes         
            ) values (
                 :operator_id
               , :maintainer_id 
               , upper(:op_name)          
               , upper(:op_first_name)
               , upper(:op_no)            
               , :op_phone         
               , :op_mobile        
               , upper(:op_address)
               , 't'
               , upper(:op_fiscal_code)
               , upper(:op_notes)
            )"

	set tool_id [db_string query "select coalesce(max(tool_id) + 1, 1) from iter_tools"]
	# inserisco analizzatore di combustione
	db_dml query "
            insert into iter_tools (
                 tool_id   
               , type
               , maintainer_id
               , brand
               , model
               , no
               , last_calibration_date
               , creation_date
            ) values (
                 :tool_id
               , '0'
               , :maintainer_id 
               , upper(:an_brand)
               , upper(:an_model)
               , upper(:an_no)            
               , :an_last_calibration_date
               , current_date
            )"

	set tool_id [db_string query "select coalesce(max(tool_id) + 1, 1) from iter_tools"]
	# inserisco analizzatore di combustione
	db_dml query "
            insert into iter_tools (
                 tool_id   
               , type
               , maintainer_id
               , brand
               , model
               , no
               , last_calibration_date
               , creation_date
            ) values (
                 :tool_id
               , '1'
               , :maintainer_id 
               , upper(:de_brand)
               , upper(:de_model)
               , upper(:de_no)            
               , :de_last_calibration_date
               , current_date
            )"
            

	} on_error {
	    ah::transaction_error
	}

    } -after_submit {

	ad_returnredirect servcait
	ad_script_abort
    }



