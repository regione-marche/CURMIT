ad_page_contract {

    @author Riccardo Vesentini
    @cvs-id maintainer-delegation-add-edit.tcl

    USER  DATA       MODIFICHE
    ===== ========== =========================================================================
    ric02 27/11/2025 Modifiche alla mail come richiesto nella call del 25/11/2025.

    ric01 17/11/2025 Aggiunto controllo per impedire di inserire per le stesse ditte deleghe nello
    ric01            stesso intervallo di date e notifica via mail all'installatore delegante.
} {
    delegation_id:integer,optional

    {cod_delegato      ""}
    {delegato          ""}
    {cognome_delegato  ""}

    {mode "edit"}
}

if {[ad_form_new_p -key delegation_id]} { 
    set page_title "Aggiungi delega"
    set buttons [list [list "Aggiungi delega" new]]
    set field_mode edit
} else {
    if {[string equal $mode "edit"]} {
        set page_title "Modifica delega"
        set buttons [list [list "Modifica delega" edit]]
        set field_mode display
    } else {
        set page_title "Visualizza delega"
        set buttons [list [list "OK" view]]
        set field_mode display
    }
}

set user_id [auth::require_login] 

set context [list [list services "Servizi per i manutentori"] [list maintainer-delegations-list {Lista deleghe}] "Lista deleghe"]

ad_form -name addedit \
    -mode $mode \
    -export maintainer_id \
    -edit_buttons $buttons \
    -has_edit 1 \
    -form {
	
	delegation_id:key

	{cod_delegato:text(hidden),optional}
	{delegato:text(hidden),optional}
        {cognome_delegato:text 
            {label {Ditta di installazione delegante}}
            {html {size 50 maxlength 100}}
	    {after_html "<a href=\"#\" onClick=\"javascript:window.open('/iter-portal/maintainers-list?caller=operatordeleg&search_name=' + document.addedit.cognome_delegato.value, 'listspecial', 'scrollbars=yes,resizable=yes,width=2020,height=760');\"> Cerca</a>"}
        }


	{start_date_pretty:text
	    {label {Data inizio}}
	    {html {class ui-datepicker}}
	}
	{end_date_pretty:text
	    {label {Data fine}}
	    {html {class ui-datepicker}}
	}
	{delegation_state:text(radio)
	    {label {Stato}}
	    {options {{{Attiva} "A"} {{Disattiva} "D"}} }
	}

    } -new_request {
	
	set delegation_state "A"

    } -edit_request {

	db_1row get_operator_data "
        select m.name as cognome_manu
             , m.iter_code as cod_manutentore
             , o.name as cognome_delegato
             , o.iter_code as cod_delegato
             , to_char(start_date, 'DD/MM/YYYY') as start_date_pretty
             , to_char(end_date , 'DD/MM/YYYY') as end_date_pretty
             , delegation_state 
          from iter_maintainer_delegations d
             , iter_maintainers m
             , iter_maintainers o
         where d.maintainer_id = m.maintainer_id
           and d.delegato_id   = o.maintainer_id 
           and delegation_id = :delegation_id"

    } -on_submit {

	set errnum 0
	
	if {[db_0or1row q "select maintainer_id as delegato_id
                             from iter_maintainers 
                            where iter_code = :cod_delegato"]} {
	    set delegato_id $delegato_id
	} else {
	    template::form::set_error addedit cognome_delegato "<br>Ditta di installazione non valida, utilizzare il 'Cerca'"
	    incr errnum
	}

	if {$start_date_pretty ne ""} {
	    set start_date [ah::check_date -input_date $start_date_pretty -ansi]
	    if {$start_date == 0} {
		template::form::set_error addedit start_date_pretty "Data errata."
		incr errnum
	    } else {
		set start_date_pretty [db_string q "select to_char(:start_date::date, 'DD/MM/YYYY')"]
	    }
	} else {
	    #se non indicano una data tengo di default oggi
	    set start_date [db_string q "select current_date"]
	}
	
	if {$end_date_pretty ne ""} {
	    set end_date [ah::check_date -input_date $end_date_pretty -ansi]
	    if {$end_date == 0} {
		template::form::set_error addedit end_date_pretty "Data errata."
		incr errnum
	    } else {
		set end_date_pretty [db_string q "select to_char(:end_date::date, 'DD/MM/YYYY')"]
	    }
	} else {
	    template::form::set_error addedit start_date_pretty "Data errata."
	    incr errnum
	}

	if {$end_date < $start_date} {
	    template::form::set_error addedit end_date_pretty "'Data fine' inferiore a 'Data inizio'."
	    incr errnum
	}
	
	if {$end_date ne 0 && $start_date ne 0 } {#ric01 aggiunta if e contenuto
	    if {[db_0or1row q "select 1
                                 from iter_maintainer_delegations
                                where maintainer_id    = :user_id
                                  and delegato_id      = :delegato_id
                                  and delegation_state = 'A'
                                  and delegation_id   != :delegation_id
                                  and start_date <= :end_date
                                  and end_date   >= :start_date
                                limit 1"]} {
		template::form::set_error addedit end_date_pretty "Esiste già una delega attiva per questa ditta nel periodo indicato."
		incr errnum
	    }
	}
	
	if {$errnum > 0} {
	    break
	}
	
    } -new_data {

	db_transaction {
	    
	    set delegation_id [db_string query "select coalesce(max(delegation_id) + 1, 1) from iter_maintainer_delegations"]
	    # inserisco operatore
	    db_dml operator_add "
            insert into iter_maintainer_delegations (
                  delegation_id    
                , maintainer_id    
                , delegato_id      
                , start_date       
                , end_date         
                , delegation_state 
                , creation_date    
                , creation_user    
                , edit_date        
                , edit_user  
            ) values (
                 :delegation_id
               , :user_id
               , :delegato_id
               , :start_date
               , :end_date
               , :delegation_state
               , current_date
               , :user_id
               , null
               , null
             )"
	    
	    # Aggiorno ditta
	    db_dml maintainer_edit "update iter_maintainers
                                       set editing_date = current_date
                                     where maintainer_id = :user_id"
	} on_error {
	    ah::transaction_error
	}
	
    } -edit_data {

	
	db_transaction {
	    
	    db_dml query "
            update iter_maintainer_delegations set
                  maintainer_id    = :user_id
                , delegato_id      = :delegato_id     
                , start_date       = :start_date      
                , end_date         = :end_date        
                , delegation_state = :delegation_state
                , edit_date        = current_date       
                , edit_user        = :user_id
            where delegation_id = :delegation_id
      "

	    # Aggiorno ditta
	    db_dml maintainer_edit "update iter_maintainers
                                       set editing_date = current_date
                                     where maintainer_id = :user_id"

	} on_error {
	    ah::transaction_error
	}
    } -after_submit {

	#ric01 Notifico la delega per email al soggetto delegato
	set email_from [parameter::get_from_package_key -package_key iter-portal -parameter email_from];#ric01

	db_1row q "select name as nome_manu
                     from iter_maintainers
                    where maintainer_id = :user_id"
	
	if {[db_0or1row q "select email as email_to_notify 
                                , name as ditta_to_notify
                             from iter_maintainers
                            where maintainer_id = :delegato_id"]} {#ric01 aggiunta if e contenuto

	    #ric02 aggiunto  alla voce Visualizza deleghe
	    set mail_text "Spett.le $ditta_to_notify,\n\nti informiamo che in data odierna il CAT $nome_manu ha inserito in CURMIT una delega ricevuta dalla tua ditta installatrice, valida dal $start_date_pretty al $end_date_pretty : con essa, il CAT $nome_manu potrà inserire in CURMIT per tuo conto, a suo nome, il nuovo impianto/generatore e il relativo RCEE di prima accensione.\n\nPotrai visualizzare l'elenco delle deleghe da te conferite accedendo al portale CURMIT dal primo box di login (Login Ditta di manutenzione/installazione), utilizzando il menu \"Gestione deleghe\" alla voce Visualizza deleghe. \n\nCordiali saluti."
	    
	    if {[string match [db_get_database] "iter-portal-marche-test"]} {
		set email_to_notify "rvesentini@oasisoftware.it"
	    }

	    acs_mail_lite::send \
		-from_addr $email_from \
		-to_addr $email_to_notify \
		-subject "Ricevuta delega da $nome_manu" \
		-body $mail_text
	}

	ad_returnredirect "maintainer-delegations-list?search_delegation_id=$delegation_id"
	ad_script_abort
    }
