ad_page_contract {

    @author Claudio Pasolini
    @cvs-id operator-add-edit.tcl

    USER  DATA       MODIFICHE
    ===== ========== =========================================================================
    ric02 11/09/2025 Punto "Nuova richiesta 2025" MEV regione Marche, aggiunto nuovo campo
    ric02            abilitazione_giuridica_p (upgrade-2.1.22-2.1.23). Solo per regione Marche.

    but01 30/09/2024 Aggiunto il campo email_operator .
    
    ric01 18/03/2024 Cambiata label da "Patentino" a "Patentino Conduz. Imp. >232kW" per gli operatori
    ric01            su indicazione di Asia Benevento.

    rom01 11/03/2020 Su richiesta di Sandro blocco la registrazione di un nuovo operatore solo
    rom01            se il suo codice fiscale e' gia' presente per lo stesso manutentore.
    rom01            Lo stesso operatore puo'essere presente su piu' ditte di manutenzione.

    sim01 13/02/2020 Patentino e Patentino Fgas devono essere  visibili su tutti gli enti

    gac01 15/02/2018 Aggiunti campi Patentino e Patentino Fgas

    nic01 01/10/2013 Anche quando si inserisce un operatore bisogna aggiornare l'editing_date
                      del manutentore altrimenti il batch maintainers_update_from_curit non
                      rileva l'inserimento e non attribuisce il codice operatore, password...
} {
    operator_id:integer,optional
    {mode "edit"}
    maintainer_id
}

if {[ad_form_new_p -key operator_id]} { 
    set page_title "Crea Operatore"
    set buttons [list [list "Crea Operatore" new]]
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

set db_name [db_get_database];#gac01

set user_id [auth::require_login] 

set context [list [list services "Servizi per i manutentori"] [list operators-list {Lista Operatori}] "Lista Operatori"]
#gac01 aggiunti campi patentino e patentino_fgas
#but01 aggiunto il campo email
ad_form -name addedit \
        -mode $mode \
        -export maintainer_id \
        -edit_buttons $buttons \
        -has_edit 1 \
        -form {
   
    operator_id:key

        {name:text 
            {label {Cognome}}
            {html {size 50 maxlength 200}}
        }
        {first_name:text 
            {label {Nome}}
            {html {size 50 maxlength 100}}
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
	    {options { {"Tecnico" 0} {"Segreteria" 1}}}
        }
        {is_active_p:boolean(radio)
            {label {Attivo?}}
	    {options {{"Si" t} {"No" f}}}
        }
}
#ric01 cambiata label da "Patentino" a "Patentino Conduz. Imp. >232kW"
#gac01 aggiunta if else e suo contenuto
#sim01 if {[string match "*iter-portal-marche*" $db_name]} {#gac01
    ad_form -extend -name addedit -form {
        {patentino:boolean(radio),optional
            {label {Patentino Conduz. Imp. >232kW}}
            {options {{"Si" "t"} {"No" "f"}}}
            {value "f"}
        }
        {patentino_fgas:boolean(radio),optional
            {label {Patentino Fgas}}
            {options {{"Si" "t"} {"No" "f"}}}
            {value "f"}
        }
    }

if {[string match "*iter-portal-marche*" $db_name]} {#ric02 aggiunta if, else e contenuto
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

    if {[string match "*iter-portal-marche*" $db_name]} {#ric02 aggiunta if e contenuto	
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
#rom01	if {[db_0or1row check_fiscal_code "select 1 from iter_operators where fiscal_code = :fiscal_code and is_active_p = 't' limit 1"]} {
#rom01	    template::form::set_error addedit fiscal_code "Codice fiscale già presente in archivio."
#rom01	    break
#rom01	}
	if {[db_0or1row check_fiscal_code "
                 select 1
                   from iter_operators
                  where fiscal_code   = :fiscal_code
                    and is_active_p   = 't'
                    and maintainer_id = :maintainer_id
                  limit 1"]} {#rom01 aggiunta if e suo contenuto
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
               , patentino        --gac01
               , patentino_fgas   --gac01
               , email_operator   --but01
               , abilitazione_giuridica_p --ric02
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
               , :patentino       --gac01
               , :patentino_fgas  --gac01
               , :email_operator  --but01
               , :abilitazione_giuridica_p --ric02
            )"

	# aggiorno il manutentore per far rilevare l'inserimento dal batch 
        # maintainers_update_from_curit
	db_dml query "update iter_maintainers
                         set editing_date  = current_date
                           , editing_user  = :user_id
                       where maintainer_id = :maintainer_id";#nic01

    } on_error {
	ah::transaction_error
    }
    
} -edit_data {

    # controllo codice fiscale dell'operatore
    set l [string length $fiscal_code]

    if {[regexp {[^A-Za-z0-9]+} $fiscal_code] > 0 } {
	template::form::set_error addedit fiscal_code "Contiene caratteri non validi."
	break
    }
    if {$l != 16} {
	template::form::set_error addedit fiscal_code "Lunghezza errata."
	break
    } elseif {[iter::verifyfc -xcodfis $fiscal_code] == 0} {#rom01 aggiunte elseif, else e loro contenuto
	template::form::set_error addedit fiscal_code "Codice Fiscale errato."
	break
    } else {
	if {[db_0or1row check_fiscal_code "
                 select 1
                   from iter_operators
                  where fiscal_code   = :fiscal_code
                    and is_active_p   = 't'
                    and maintainer_id = :maintainer_id
                    and operator_id <> :operator_id
                  limit 1"]} {#rom01 aggiunta if e suo contenuto
	    # Blocco la registrzione solo se provo a inserire un Operatore con il
	    # codice fiscale gia' presente per la stessa ditta di manutenzione.
	    template::form::set_error addedit fiscal_code "Codice fiscale già presente in archivio per la ditta di manutenzione."
	    break
	}

    }

#rom01    if {[db_string count "select count(*) from iter_operators where fiscal_code = :fiscal_code and operator_id <> :operator_id"#rom01] > 1} {
#rom01	template::form::set_error addedit fiscal_code "Codice fiscale già presente in archivio."
#rom01	break
#rom01    }
    
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
               , patentino      = :patentino         --gac01
               , patentino_fgas = :patentino_fgas    --gac01
               , email_operator = :email_operator   --but01
               , abilitazione_giuridica_p  = :abilitazione_giuridica_p --ric02
            where operator_id = :operator_id
      "

	db_dml maintainer_edit "
            update iter_maintainers set
                editing_date      = current_date
               ,editing_user       = :user_id
             where maintainer_id = :maintainer_id"

    } on_error {
	ah::transaction_error
    }
} -after_submit {

    ad_returnredirect "operators-list?maintainer_id=$maintainer_id"
    ad_script_abort
}



