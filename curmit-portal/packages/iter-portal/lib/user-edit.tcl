# Expects parameters:
#
# maintainer_id     

# l'utente ha diritti di admin sul package?
set admin_p [permission::permission_p \
                 -no_login \
                 -object_id [ad_conn package_id] \
                 -privilege admin
	    ]

ad_form -name edit \
    -export { maintainer_id return_url} \
    -edit_buttons [list [list "Torna ai Servizi" edit]] \
    -has_edit 1 \
    -form {

	# Start section2
	{-section "sec2" {legendtext "Dati Anagrafici"} {fieldset {class legend}}}
        {name:text(inform) 
            {label {Ragione sociale}}
            {html {size 50 maxlength 200}}
        }
	{address1:text(inform)
	    {label {Indirizzo}}
	    {html {size 50 maxlength 200}}
	}
	{city:text(inform)
	    {label {Comune}}
	    {html {size 50 maxlength 40}}
	}
	{address2:text(inform)
	    {label {Località}}
	    {html {size 50 maxlength 40}}
	}
	{province:text(inform)
	    {label {Provincia}}
	    {html {size 5 maxlength 4}}
	}
	{zipcode:text(inform)
	    {label {C.A.P.}}
	    {html {size 10 maxlength 5}}
	}
        {fiscal_code:text(inform)
            {label {Codice fiscale}}
            {html {maxlength 16}}
        }
        {iva_code:text(inform)
            {label {P.IVA}}
            {html {maxlength 11}}
        }
	{phone:text(inform)
	    {label {Telefono}}
	}
	{fax:text(inform)
	    {label {Fax}}
	}
	{email:text(inform) 
	    {label {Email}}
	}
	{mobile:text(inform) 
	    {label {Cellulare}}
	}
	{where_registered:text(inform)
	    {label {Località Registro Imprese}}
	    {html {size 50}}
	}
	{registration_no:text(inform)
	    {label {N. Registro Imprese}}
	    {html {size 50}}
	}
	{where_rea:text(inform)
	    {label {Località REA}}
	    {html {size 50}}
	}
	{rea_no:text(inform)
	    {label {N. REA}}
	    {html {size 50 maxlength 15}}
	}
	{albo_artigiani:text(inform)
	    {label {Albo Artigiani}}
	    {html {size 50 maxlength 15}}
	}
	{role:text(inform)
	    {label {Ruolo}}
	    {options { {"Manutentore" 1} {"Installatore" 0} {"Installatore/Manutentore" 2}}}
	}
	{op_number_pretty:text(inform)
	    {label {N° Operatori impegnati:}}
	    {html {size 10}}
	}
	{an_number_pretty:text(inform)
	    {label {N° Analizzatori utilizzati:}}
	    {html {size 10}}
	}
	{de_number_pretty:text(inform)
	    {label {N° Deprimometri utilizzati:}}
	    {html {size 10}}
	}
	{associated_to:text(inform)
	    {label {Associazione di riferimento:}}
	    {html {size 50}}
	}
	{capital_pretty:text(inform)
	    {label {Capitale versato}}
	}
        {notes:text(inform)
            {label Note}
            {html {rows 5 cols 50 wrap soft}}
        }

	# Start section3
	{-section "sec3" {legendtext "Rappresentante Legale"} {fieldset {class legend}}}

        {rep_name:text(inform) 
            {label {Cognome}}
            {html {size 50 maxlength 200}}
        }
        {rep_first_name:text(inform) 
            {label {Nome}}
            {html {size 50 maxlength 200}}
        }
	{rep_address1:text(inform)
	    {label {Indirizzo}}
	    {html {size 50 maxlength 200}}
	}
	{rep_city:text(inform)
	    {label {Comune}}
	    {html {size 50 maxlength 40}}
	}
	{rep_address2:text(inform)
	    {label {Località}}
	    {html {size 50 maxlength 40}}
	}
	{rep_province:text(inform)
	    {label {Provincia}}
	    {html {size 5 maxlength 4}}
	}
	{rep_zipcode:text(inform)
	    {label {C.A.P.}}
	    {html {size 10 maxlength 5}}
	}
        {rep_fiscal_code:text(inform)
            {label {Codice fiscale}}
            {html {maxlength 16}}
        }


	# Reset section
	{-section ""}
    }


ad_form -extend -name edit -on_request {
    # Populate elements from local variables
    db_1row get_maintainer "
        select m.*, ah_edit_num(op_number, 0) as op_number_pretty, ah_edit_num(an_number, 0) as an_number_pretty, ah_edit_num(de_number, 0) as de_number_pretty, ah_edit_num(capital, 2) as capital_pretty, case when m.role = '0' then 'Installatore' when m.role = '0' then 'Manutentore' else 'Installatore/Manutentore' end as role, p.name as rep_name, p.first_name as rep_first_name, p.address1 as rep_address1, p.city as rep_city, p.address2 as rep_address2, p.province as rep_province, p.zipcode as rep_zipcode, p.fiscal_code as rep_fiscal_code, albo_artigiani
        from iter_maintainers m, iter_parties p
        where m.maintainer_id = :maintainer_id
          and m.representative_id = p.party_id"

} -on_submit {

    ad_returnredirect services
    ad_script_abort
    set errnum 0

    # partita IVA o codice fiscale devono essere presenti
    if {$fiscal_code eq "" && $iva_code eq ""} {
        template::form::set_error edit iva_code "Almeno uno fra codice fiscale e partita IVA deve essere presente."
	incr errnum
    } else {
	if {$fiscal_code ne ""} {
	    set l [string length $fiscal_code]
	    if {$l != 16 && $l != 11} {
		template::form::set_error edit fiscal_code "Lunghezza errata."
		incr errnum
	    } elseif {$l == 16 && [iter::verifyfc -xcodfis $fiscal_code] == 0} {
		template::form::set_error edit fiscal_code "Codice Fiscale errato."
		incr errnum
	    } elseif {$l == 11 && [iter::verifyvc -xcodfis $fiscal_code] == 0} {
		template::form::set_error edit fiscal_code "Codice Fiscale errato."
		incr errnum
	    } else {
		if {[db_string fiscal_code "select count(*) from iter_maintainers where fiscal_code = :fiscal_code"] > 1} {
		    template::form::set_error edit fiscal_code "Codice fiscale già presente in archivio."
		    incr errnum
		}
	    }
	}

	if {$iva_code ne ""} {
	    set l [string length $iva_code]
	    if {$l != 11} {
		template::form::set_error edit iva_code "Lunghezza errata."
		incr errnum
	    } elseif {[iter::verifyvc -xcodfis $iva_code] == 0} {
		template::form::set_error edit iva_code "Partita IVA errata."
		incr errnum
	    } else {
		if {[db_0or1row iva_code "select count(*) from iter_maintainers where iva_code = :iva_code"] > 1} {
		    template::form::set_error edit iva_code "Partita IVA già presente in archivio."
		    incr errnum
		}
	    }
	}
    }

    if  {$capital_pretty ne ""} {
	set capital [ah::check_num $capital_pretty 2]
	if {$capital eq "Error"} {
	    template::form::set_error edit capital_pretty  "Capitale errato."
	    incr errnum
	}
    } else {
        set capital ""
    }

    # telefono o cellulare devono essere presenti
    if {$phone eq "" && $mobile eq ""} {
        template::form::set_error edit phone "Almeno uno fra telefono e cellulare deve essere presente."
	incr errnum
    }

    # controllo codice fiscale del rappresentante legale
    set l [string length $rep_fiscal_code]
    if {$l != 16 && $l != 11} {
	template::form::set_error edit rep_fiscal_code "Lunghezza errata."
	incr errnum
    } elseif {$l == 16 && [iter::verifyfc -xcodfis $rep_fiscal_code] == 0} {
	template::form::set_error edit rep_fiscal_code "Codice Fiscale errato."
	incr errnum
    } elseif {$l == 11 && [iter::verifyvc -xcodfis $rep_fiscal_code] == 0} {
	template::form::set_error edit rep_fiscal_code "Codice Fiscale errato."
	incr errnum
    }
    
    if {[db_0or1row query "select 1 from iter_parties where fiscal_code = :rep_fiscal_code and party_id <> :representative_id"] > 1} {
	template::form::set_error edit rep_fiscal_code "Codice fiscale già presente in archivio."
	incr errnum
    }

    # questi campi sono obbligatori nel caso di inserimento o modifica da parte del manutentore
    if {$admin_p ne "1"} {
	if {$where_registered eq ""} {
	    template::form::set_error edit where_registered "Campo obbligatorio"
	    incr errnum
	}
	if {$registration_no eq ""} {
	    template::form::set_error edit registration_no "Campo obbligatorio"
	    incr errnum
	}
	if {$where_rea eq ""} {
	    template::form::set_error edit where_rea "Campo obbligatorio"
	    incr errnum
	}
	if {$rea_no eq ""} {
	    template::form::set_error edit rea_no "Campo obbligatorio"
	    incr errnum
	}
    }

    if {$errnum > 0} {
	break
    }

    db_transaction {

	# modifico manutentore
	db_dml maintainer_edit "
            update iter_maintainers set
                 name              = :name
               , address1          = :address1
               , address2          = :address2
               , city              = :city
               , province          = :province
               , zipcode           = :zipcode
               , fiscal_code       = :fiscal_code                                                                              
               , iva_code          = :iva_code
               , phone             = :phone
               , mobile            = :mobile
               , email             = :email
               , fax               = :fax
               , associated_to     = :associated_to                                                     
               , where_registered  = :where_registered
               , registration_no   = :registration_no          
               , where_rea         = where_rea
               , rea_no            = :rea_no
               , capital           = :capital
               , role              = :role
               , representative    = :representative                                     
               , notes             = :notes
               , editing_date      = current_date
               , albo_artigiani    = :albo_artigiani
             where maintainer_id   = :maintainer_id"
    }
    
} -after_submit {
    
    ad_returnredirect services
    ad_script_abort

}
