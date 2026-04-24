ad_page_contract {

    @author Claudio Pasolini
    @cvs-id operator-add-edit.tcl

    USER  DATA       MODIFICHE
    ===== ========== =========================================================================
    ric01 11/09/2025 Punto "Nuova richiesta 2025" MEV regione Marche, aggiunto nuovo campo
    ric01            abilitazione_giuridica_p (upgrade-2.1.22-2.1.23). Solo per regione Marche.

    rom03 21/10/2024 Su richiesta di Sandro non do piu' la possibilita' alle ditte di modificare
    rom03            nome e cognome degli operatori.

    but01 30/09/2024 Aggiunto il campo email_operator .
    
    rom02 16/10/2020 Su richiesta di Sandro blocco la registrazione di un nuovo operatore solo
    rom02            se il suo codice fiscale e' gia' presente per lo stesso manutentore.
    rom02            Lo stesso operatore puo'essere presente su piu' ditte di manutenzione.
    rom02            La modifica e' gia' presente per gli amministratori e entrambe vanno
    rom02            bene su tutti gli enti come ha detto Sandro

    sim01 13/02/2020 Patentino e Patentino Fgas devono essere  visibili su tutti gli enti

    rom01 27/06/2018 Modificate le label e le diciture contententi Operatore in Tecnici.

    gac01 15/02/2018 Aggiunti campi Patentino e Patentino Fgas

} {
    operator_id:integer,optional
    {mode "edit"}
}

#ric01 set maintainer_id [iter::script_init]
set maintainer_id [iter::script_init -caller "operators"];#ric01

if {[string equal $maintainer_id "0"]} {
    ad_returnredirect services
}

set field_readonly "";#rom03
if {[ad_form_new_p -key operator_id]} { 
    #rom01    set page_title "Crea Operatore"
    #rom01    set buttons [list [list "Crea Operatore" new]]
    set page_title "Crea Tecnico" ;#rom01
    set buttons [list [list "Crea Tecnico"]] ;#rom01

    set field_mode edit
} else {
    if {[string equal $mode "edit"]} {
	#rom01 set page_title "Modifica Operatore"
	#rom01 set buttons [list [list "Modifica Operatore" edit]]
	set page_title "Modifica Tecnico";#rom01
	set buttons [list [list "Modifica Tecnico"]];#rom01
        set field_mode display
	set field_readonly "readonly {}";#rom03
    } else {
#rom01  set page_title "Visaualizza Operatore"
	set page_title "Visaualizza Tecnico";#rom01
        set buttons [list [list "OK" view]]
        set field_mode display
    }
}

set db_name [db_get_database];#gac01

#rom01set context [list [list services "Servizi per i manutentori"] [list operators-list {Lista Operatori}] "Lista Operatori"]
set context [list [list services "Servizi per i manutentori"] [list operators-list {Lista Tecnici}] "Lista Tecnici"];#rom01
#gac01 aggiunti campi patentino e patentino_fgas
#but01 aggiunto il campo email_operator
ad_form -name addedit \
        -mode $mode \
        -export maintainer_id \
        -edit_buttons $buttons \
        -has_edit 1 \
        -form {
   
    operator_id:key

        {name:text 
            {label {Cognome}}
            {html {size 50 maxlength 200 $field_readonly}}
        }
        {first_name:text 
            {label {Nome}}
            {html {size 50 maxlength 100 $field_readonly}}
        }
        {no:text 
            {label {Matricola}}
            {html {size 50}}
        }
        {fiscal_code:text
            {label {Codice fiscale}}
            {html {maxlength 16}}
        }
        {phone:text,optional 
            {label {Telefono}}
        }
        {mobile:text,optional 
            {label {Cellulare}}
        }
        {email_operator:email(text)
	    {label {Email}}
	    {html {size 50}}
	}
        {address:text,optional
            {label {Recapito}}
            {html {size 50 maxlength 200}}
        }
        {role:text(radio),optional
            {label {Ruolo}}
	    {options { {"Tecnico" 0} {"Delegato del Rappresentante Legale" 1}}}
        }
        {is_active_p:boolean(radio)
            {label {Attivo?}}
	    {options {{"Si" t} {"No" f}}}
        }
}
#gac01 aggiunta if else e suo contenuto
#sim01 if {[string match "*iter-portal-marche*" $db_name]} {#gac01
    ad_form -extend -name addedit -form {
        {patentino:boolean(radio)
            {label {Patentino da conduttore per impianti superiori a 232 kW}}
            {options {{"Si" "t"} {"No" "f"}}}
            {value "f"}
        }
        {patentino_fgas:boolean(radio)
            {label {Patentino Fgas}}
            {options {{"Si" "t"} {"No" "f"}}}
            {value "f"}
        }
    }

if {[string match "*iter-portal-marche*" $db_name]} {#ric01 aggiunta if, else e contenuto
    ad_form -extend -name addedit -form {
	{abilitazione_giuridica_p:boolean(radio)
	    {label {Ha titolo giuridico per operare?}}
	    {options {{"Si" "t"} {"No" "f"}}}
	    {help_text "<b>Il tecnico è stato incaricato - in quanto dipendente o per altre ragioni - dalla ditta stessa che lo ha inserito tra i propri operatori.<br>In assenza di titolo giuridico l'operatore verrà disattivato.</b>"}
	}
    }
} else {
    ad_form -extend -name addedit -form {
	{abilitazione_giuridica_p:text(hidden),optional}
    }
}
#sim01 } else { #gac01

#sim01    ad_form -extend -name addedit -form {
#sim01        {patentino:text(hidden),optional}
#sim01        {patentino_fgas:text(hidden),optional}
#sim01    }
#sim01 };#gac01
ad_form -extend -name addedit \
    -form {
        {notes:text(textarea),optional,nospell 
            {label Note}
            {html {rows 5 cols 50 wrap soft}}
        }

} -new_request {
    set is_active_p "t"
} -edit_request {

    db_1row get_operator_data "
        select * 
        from iter_operators where operator_id = :operator_id"

} -on_submit {

    set data_oggi [db_string query "select to_char(current_date, 'YYYY-MM-DD')"]

    if {[string match "*iter-portal-marche*" $db_name]} {#ric01 aggiunta if e contenuto	
	if {$abilitazione_giuridica_p eq "f"} {
	    set is_active_p "f"
	}
    }
} -new_data {

    # controllo codice fiscale dell'operatore
    if {[regexp {[^A-Za-z0-9]+} $fiscal_code] > 0 } {
	template::form::set_error addedit fiscal_code "Contiene caratteri non validi."
	break 
    }
    set l [string length $fiscal_code]
    if {$l != 16} {
	template::form::set_error addedit fiscal_code "Lunghezza errata."
	break
    } elseif {[iter::verifyfc -xcodfis $fiscal_code] == 0} {
	template::form::set_error addedit fiscal_code "Codice Fiscale errato."
	break
    } else {
#	if {[db_0or1row check_fiscal_code "select 1 from iter_operators where fiscal_code = :fiscal_code and is_active_p = 't'"]} {
#	    template::form::set_error addedit fiscal_code "Codice fiscale già presente in archivio."
#	    break
#	}
	if {[db_0or1row check_fiscal_code "
                 select 1
                   from iter_operators
                  where fiscal_code   = :fiscal_code
                    and is_active_p   = 't'
                    and maintainer_id = :maintainer_id
                  limit 1"]} {#rom02 aggiunta if e suo contenuto
	    # Blocco la registrzione solo se provo a inserire un Operatore con il
	    # codice fiscale gia' presente per la stessa ditta di manutenzione.
	    template::form::set_error addedit fiscal_code "Codice fiscale già presente in archivio per la ditta di manutenzione."
	    break
	}
    }

    if {[string equal $role ""]} {
	set role "0"
    }

    db_transaction {
	
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
               , role
               , notes         
               , patentino           --gac01
               , patentino_fgas      --gac01
               , email_operator      --but01
               , abilitazione_giuridica_p --ric01
            ) values (
                 :operator_id
               , :maintainer_id
               , upper(:name)
               , upper(:first_name)    
               , upper(:no)
               , :phone         
               , :mobile        
               , upper(:address)
               , :is_active_p   
               , upper(:fiscal_code)   
               , :role
               , upper(:notes) 
               , :patentino         --gac01
               , :patentino_fgas    --gac01 
               , :email_operator    --but01
               , :abilitazione_giuridica_p --ric01
            )"
	db_dml query "update iter_maintainers set editing_date = :data_oggi where maintainer_id = :maintainer_id"

    } on_error {
	ah::transaction_error
    }
    
} -edit_data {

    # controllo codice fiscale dell'operatore
    if {[regexp {[^A-Za-z0-9]+} $fiscal_code] > 0 } {
	template::form::set_error addedit fiscal_code "Contiene caratteri non validi."
	break 
    }
    set l [string length $fiscal_code]
    if {$l != 16} {
	template::form::set_error addedit fiscal_code "Lunghezza errata."
	break
    } elseif {[iter::verifyfc -xcodfis $fiscal_code] == 0} {
	template::form::set_error addedit fiscal_code "Codice Fiscale errato."
	break
    } else {#rom02 aggiunta else e suo contenuto
	if {[db_0or1row check_fiscal_code "
                 select 1
                   from iter_operators
                  where fiscal_code   = :fiscal_code
                    and is_active_p   = 't'
                    and maintainer_id = :maintainer_id
                    and operator_id <> :operator_id
                  limit 1"]} {
	    # Blocco la registrzione solo se provo a inserire un Operatore con il
	    # codice fiscale gia' presente per la stessa ditta di manutenzione.
	    template::form::set_error addedit fiscal_code "Codice fiscale già presente in archivio per la ditta di manutenzione."
	    break
	}
    }
#    if {[db_string count "select count(*) from iter_operators where fiscal_code = :fiscal_code and is_active_p = 't' and operator_id <> :operator_id"] > 1} {
#	template::form::set_error addedit fiscal_code "Codice fiscale già presente in archivio."
#	break
#    }

    db_transaction {
	
	db_dml query "
            update iter_operators set
                 name        = upper(:name)          
               , first_name  = upper(:first_name)
               , no          = upper(:no)
               , phone       = :phone
               , mobile      = :mobile
               , address     = upper(:address)
               , role        = :role
               , is_active_p = :is_active_p
               , fiscal_code = upper(:fiscal_code)
               , notes       = upper(:notes)
               , patentino   = :patentino
               , patentino_fgas = :patentino_fgas
               , email_operator = :email_operator --but01
               , abilitazione_giuridica_p  = :abilitazione_giuridica_p --ric01
            where operator_id = :operator_id
      "
	db_dml query "update iter_maintainers set editing_date = :data_oggi where maintainer_id = :maintainer_id"

    } on_error {
	ah::transaction_error
    }
} -after_submit {

    ad_returnredirect "operators-list?maintainer_id=$maintainer_id"
    ad_script_abort
}



