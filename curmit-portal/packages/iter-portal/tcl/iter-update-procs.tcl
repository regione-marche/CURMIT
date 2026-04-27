ad_library {

    Procedure di aggiornamento delle istanze ITER via -dbn 

    @author Luca Bellini
    @author Claudio Pasolini

    @cvs-id $Id:

    USER  DATA       MODIFICHE
    ===== ========== ==========================================================================
    mat01 3/11/2025  Aggiornato il testo della mail mandate alle ditte di manutenzione quando
    mat01            si registrano per UCIT.

    rom17 10/09/2025 Modificata proc deprecata util_unlist con lassign

    rom16 28/08/2025 Modifiche per allineamento Regione Friuli al cvs iter2019

    ric03 22/09/2025 Punto 40 MEV regione Marche, creata proc per propagare le nuove delghe inserite
    ric03            da portale, modificato proc per propagare le deleghe modificate da portale.

    ric02 11/09/2025 Punto "Nuova richiesta 2025" MEV regione Marche, aggiunto nuovo campo
    ric02            abilitazione_giuridica_p (upgrade-2.1.22-2.1.23).

    rom15 04/12/2024 Quando creo o aggiorno gli operatori su iter devo riportare il codice fiscale
    rom15            sulla coimuten.

    rom14 29/10/2024 Devo troncare a massimo 50 caratteri marca, modello e matricola degli strumenti su iter
    rom14            per evitare errori in fase di propagazione del batch.

    rom13 23/10/2024 Corretta modifica bi but01, quando venovano inseriti nuovi operatori l'email_operator
    rom13            sulla tabella iter_operators veniva sbiancata.

    but01 01/10/2024 Aggiunto il campo email_operator.
    
    rom12 18/09/2024 Aggiunta proc iter::notify_maintainer_upd per invio mail alle ditte di manutenzione
    rom12            con credenziali degli operatori aggiuntivi.

    rom11 02/08/2024 Se viene modificata la data di taratura di uno strumento bisogna riportare
    rom11            la modifica anche lato iter.

    rom10 08/07/2024 Corretto errore per il comando ns_md, nelle vecchie versioni di naviserver
    rom10            bisogna passare il default digest "sha256".

    ric01 07/06/2024 Ricodifica psw su coimuten.

    rom09 02/05/2024 Corretto bug sulla proc maintainers_update_from_curit: tengo in considerazione solo
    rom09            i manutentori validati con un iter_code per evitare casi sporchi.

    rom08 13/06/2023 MEV Regione Marche: "Annullamento logico di uno strumento da portale"
    rom08            Ora i manutentori possono annullare gli strumenti dal portale e bisogna riportare
    rom08            la modifica dello stato anche lato iter.

    rom07 05/05/2023 Modificata proc iter_instances_sync: alla fine della proc viene mandata una
    rom07            mail se non mi trovo in un ambiente di test.

    rom06 16/11/2021 Il campo reg_imprese non deve essere limitato a 15 ma 20 caratteri.

    rom05 10/08/2021 Le proc iter::maintainers_new e iter::maintainers_update tenevano come lunghezza
    rom05            massima della mail 35 caratteri, in realta' su Iter il campo e' un varchar(150). 

    rom04 08/06/2021 Regione Marche ha richiesto la modifica della mail di notica dei manutentori
    rom04            quindi modifico la proc iter::notify_maintainer cambiando il testo della mail.
    rom04            Sandro ha detto di cambiare solo per le Marche e solo la mail dei manutentori.

    rom03 15/04/2021 Per problemi riscontrati piu' volte durante la propagazione dei manutentori
    rom03            di Regione Marche metto xxxxxxx come destinatario della
    rom03            mail che viene inviata alla fine dell'esezuzione della proc iter_instances_sync
    rom03            in modod da tenere monitorata la situazione.

    sim08 12/05/2020 Corretto la modifica dello stato degli operatori.

    rom02 02/10/2019 Modificate le proc iter::maintainers_new_from_curit, iter::maintainers_new,
    rom02            iter::maintainers_update_from_curit e iter::maintainers_update per inserire
    rom02            anche i campi la,lb,lc,ld,le,lf,lg.

    sim07 29/05/2018 Se sono la regione marche valido in automatico tutti i manutentori che hanno allegato
    sim07            il documento di autodichiarazione

    gab01 06/04/2018 Modificata la proc iter::maintainers_new per la gestione del multiportafoglio 
    gab01            (solo per chi lo utilizza). 

    rom01 06/03/2018 Implementato il batch che propaga gli operatori in modo che 
    rom01            inserisca gli utenti una volta creato l'operatore su iter.

    sim06 10/03/2017 Modificata la proc iter::maintainers_new per inserire anche il campo
    sim06            patentino_fgas.

    sim05 09/03/2016 Gestito le nuove opzioni Manut/Inst Clim.Estiva e Manut/Inst Biomassa Legnosa nel
    sim05            campo Ruolo nelle iter::maintainers_update e iter::maintainers_new

    sim04 26/10/2016 Parametrizzato l'email di uscita e l'indirizzo del portale che compare nelle email

    sim03 09/08/2016 Corretta proc iter::maintainers_new per wal_holders

    sim02 28/06/2016 Modificata la proc iter::maintainers_new per inserire anche il campo
    sim02            patentino.

    nic02 14/06/2016 Modificata la proc iter::maintainers_new per inserire anche il campo pec.

    sim01 06/04/2016 Modificato la proc iter::maintainers_new in modo da inserire il codice
    sim01            portafoglio del manutentore.

    nic01 09/12/2013 Modificata proc iter::representatives_update per gestire il cambio
    nic01            di rappresentante legale della ditta di manutenzione come richiesto da
    nic01            UCIT
}

namespace eval iter {}

ad_proc -public iter::iter_instances_sync {
    {-from_date ""}
    {-to_date ""}
} {
    Propaga nelle varie istanze iter le modifiche intercorse dall'ultima elaborazione
    ai manutentori e agli amministratori di condominio.
   
    Con from_date e to_date è possibile delimitare il range temporale da prendere in 
    considerazione. Per default si assume la data del giorno precedente.

} {

#    return "bloccata. da sbloccare una volta fatta la prima propagazione"

    set db_name [db_get_database];#sim07

    if {[string match "*iter-portal-marche*" $db_name]} {#sim07 if e suo contenuto

	db_dml query "update iter_maintainers 
                         set validated_p  = 't'
                           , validating_date =  current_date
                       where validated_p != 't' 
                         and coalesce(path_dichiaraz_dpr,'') != ''" 

    }

    set email_from [parameter::get_from_package_key -package_key iter-portal -parameter email_from];#sim04

    # imposto alcune date
    set current_date [ah::today_ansi]
    if {$from_date eq ""} {
	# assumo ieri
	set from_date [db_string query "select current_date - 1"]
    }
    if {$to_date eq ""} {
	# assumo ieri
	set to_date [db_string query "select current_date - 1"]
    }

    # imposto le istanze iter da aggiornare
    #if {[db_get_database] eq "curit-dev"} {
	#set instances [list "iterrl-dev"]
    #} elseif {[db_get_database] eq "curit-sta"} {
	#set instances [list "iterrl-sta"]
    #} else {
        #set instances [db_list get_instances "select instance_name from iter_instances"]
    #}

    set instances [db_list get_instances "select instance_name from iter_instances"]

    ns_log notice "\niter::iter_instances_sync instances=$instances \nfrom_date=$from_date to_date=$to_date"

    # inizializzo file di log
    set fd [open [ah::package_root -package_key iter-portal]/iter-update.log w]
    puts $fd "Elaborazione del $current_date"
    puts $fd "Istanze $instances"
    close $fd

    db_transaction {

	# creo nuovi manutentori
        set maintainers_to_notify [iter::maintainers_new_from_curit \
				       -from_date $from_date \
				       -to_date   $to_date \
				       -instances $instances]

	# aggiorno manutentori variati
        #rom12iter::maintainers_update_from_curit \
	#rom12    -from_date $from_date \
	#rom12	    -to_date   $to_date \
	#rom12	    -instances $instances

	#rom12 aggiorno manutentori variati
	set maintainers_upd_to_notify [iter::maintainers_update_from_curit \
					   -from_date $from_date \
					   -to_date   $to_date \
					   -instances $instances];#rom12

	# creo nuovi amministratori di condominio
        set trustees_to_notify [iter::trustees_new_from_curit \
				    -from_date $from_date \
				    -to_date   $to_date \
				    -instances $instances]

	# aggiorno nuovi amministratori di condominio
        iter::trustees_update_from_curit \
	    -from_date $from_date \
	    -to_date   $to_date \
	    -instances $instances

    } on_error {
	ad_log_stack_trace
	
 	acs_mail_lite::send -from_addr $email_from -to_addr xxxxxxx -subject "iter-update-procs" -body "Da: [db_get_database]. Qualcosa è andato storto. L'errore riscontrato è:\n$errmsg \n\nMaggiori dettagli nel file di log.";#sim04
#sim04	acs_mail_lite::send -from_addr "xxxxxxx" -to_addr xxxxxxx -subject "iter-update-procs" -body "Da: [db_get_database]. Qualcosa è andato storto. L'errore riscontrato è:\n$errmsg \n\nMaggiori dettagli nel file di log."
        ad_script_abort

    }

    # tutto è andato bene e quindi posso notificare i manutentori e gli amministratori
    # di condominio

    # notifica manutentori 
    foreach maintainer $maintainers_to_notify {
	#rom017 util_unlist $maintainer maintainer_id cait_id
	lassign $maintainer maintainer_id cait_id

	if {$cait_id ne ""} {
            iter::notify_maintainer_with_cait -maintainer_id $maintainer_id -cait_id $cait_id
	} else {
            iter::notify_maintainer -maintainer_id $maintainer_id
	}
    }

    #rom12 Notifica manutentori operatori aggiuntivi
    foreach maintainer_upd $maintainers_upd_to_notify {#rom12 Aggiunta foreach e contenuto
	#rom017 util_unlist $maintainer_upd maintainer_id
	lassign $maintainer_upd maintainer_id
	iter::notify_maintainer_upd -maintainer_id $maintainer_id
    }
    
    # notifica gli amministratori di condominio
    foreach trustee $trustees_to_notify {
	#rom17 util_unlist $trustee trustee_id office_id
	lassign $trustee trustee_id office_id

	if {$office_id ne ""} {
	    iter::notify_trustee_with_office -trustee_id $trustee_id -office_id $office_id
	} else {
	    iter::notify_trustee -trustee_id $trustee_id
	}
    }

    if {![string match "*dev*" $db_name] && ![string match "*test" $db_name]} {#rom07 Aggiunta if ma non il suo contenuto
    acs_mail_lite::send -from_addr $email_from -to_addr xxxxxxx -subject "iter-update-procs" -body "Da: [db_get_database]. \n iter::iter_instances_sync \n Tutto bene.";#rom03
    };#rom07
    #rom03acs_mail_lite::send -from_addr $email_from -to_addr xxxxxxx -subject "iter-update-procs" -body "Da: [db_get_database]. Tutto bene.";#sim04

#sim04    acs_mail_lite::send -from_addr "xxxxxxx" -to_addr xxxxxxx -subject "iter-update-procs" -body "Da: [db_get_database]. Tutto bene."
    ns_log notice "\niter::iter_instances_sync\nTutto bene."

}

ad_proc -public iter::maintainers_new_from_curit {
    -from_date
    -to_date
    -instances
} {
    Creazione nuovi manutentori.
} {

    ns_log notice "\n Inizio iter::maintainers_new_from_curit"

    set validating_date [ah::today_ansi]

    # azzero liste
    set maintainers               [list]
    set representatives           [list]
    set operators                 [list]
    set to_notify                 [list]
    set maintainers_installations [list] ;#rom01
    set tools                     [list]
    set delegations               [list];#ric03
    
    set iter_code_num [db_string query "select max(substr(iter_code, 3, 6)) from iter_maintainers"]
    set iter_code_num [string trimleft $iter_code_num "0"]
    if {[string equal $iter_code_num ""]} {
	set db_name [db_get_database]
	if {[string match "*iter-portal-marche*" $db_name]} {
	    set iter_code_num 600000
	} elseif {[string match "*iter-portal-salerno*" $db_name]} {
	    set iter_code_num 200000
	} else {
	    set iter_code_num 0
	}
    }
    
    # leggo manutentori da propagare: devono avere il flag validated_p=t e iter_code=null
    db_foreach query "
            select * 
            from iter_maintainers 
            where validated_p = 't' 
              and iter_code is null 
            order by creation_date, maintainer_id
    " {

	incr iter_code_num
	set iter_code [db_string query "select lpad(:iter_code_num, 6, '0')"]
	set iter_code "MA$iter_code"

	# popolo lista manutentori
        # nic02: aggiunto campo pec e sistemato maintainer_id per non fare confusione con
        #        la lista usata in maintainers_update che e' identica
	#nic02 lappend maintainers [list $iter_code $name $address1 $address2 $province $zipcode $city $fiscal_code $iva_code $phone $mobile $fax $email $registration_no $where_registered $rea_no $where_rea $capital $role $maintainer_id]
        #sim02 lappend maintainers [list [list $iter_code $maintainer_id] $name $address1 $address2 $province $zipcode $city $fiscal_code $iva_code $phone $mobile $fax $email $registration_no $where_registered $rea_no $where_rea $capital $role $pec];#nic02
        #sim06 lappend maintainers [list [list $iter_code $maintainer_id] $name $address1 $address2 $province $zipcode $city $fiscal_code $iva_code $phone $mobile $fax $email $registration_no $where_registered $rea_no $where_rea $capital $role $pec $patentino];#sim02

	#rom02 lappend maintainers [list [list $iter_code $maintainer_id] $name $address1 $address2 $province $zipcode $city $fiscal_code $iva_code $phone $mobile $fax $email $registration_no $where_registered $rea_no $where_rea $capital $role $pec $patentino $patentino_fgas];#sim06

	lappend maintainers [list [list $iter_code $maintainer_id] $name $address1 $address2 $province $zipcode $city $fiscal_code $iva_code $phone $mobile $fax $email $registration_no $where_registered $rea_no $where_rea $capital $role $pec $patentino $patentino_fgas $la $lb $lc $ld $le $lf $lg];#rom02
	
        # popolo lista soggetti da notificare
        lappend to_notify [list $maintainer_id $cait_id]

	# leggo rappresentante legale
	db_1row query "
            select p.name as rep_name, 
               p.first_name as rep_first_name, 
               p.address1 as rep_address1, 
               p.city as rep_city, 
               p.address2 as rep_address2, 
               p.province as rep_province, 
               p.zipcode as rep_zipcode, 
               p.fiscal_code as rep_fiscal_code,
               p.patentino as patentino_rapp,            --gac01
               p.patentino_fgas as patentino_fgas_rapp   --gac01
               
            from iter_parties p
           where p.party_id = :representative_id"

	# popolo lista rappresentanti legali
	lappend representatives [list $iter_code $rep_name $rep_first_name $rep_address1 $rep_city $rep_address2 $rep_province $rep_zipcode $rep_fiscal_code $patentino_rapp $patentino_fgas_rapp]

	# leggo operatori
	set ops [db_list_of_lists operators "
                select operator_id, 
                       name, 
                       first_name, 
                       no, 
                       fiscal_code, 
                       phone, 
                       mobile, 
                       address, 
                       notes,
                       patentino as patentino_op,              --gac01
                       patentino_fgas as patentino_op_fgas,     --gac01
                       email_operator,                           --but01 
                       abilitazione_giuridica_p                 --ric02
                 from iter_operators 
                 where maintainer_id = :maintainer_id 
                 order by operator_id"]

	set iter_no_num 0

	foreach op $ops {
	    #ric02 aggiunto abilitazione_giuridica_p
	    #but01 aggiunto il campo email_operator
	    #rom17 util_unlist $op operator_id name first_name no fiscal_code phone mobile address notes patentino_op patentino_op_fgas email_operator
            lassign $op operator_id name first_name no fiscal_code phone mobile address notes patentino_op patentino_op_fgas email_operator abilitazione_giuridica_p

	    set password [randomRange 99999999]
	    incr iter_no_num
	    set iter_no [ah::lpad $iter_no_num 2 "0"]
	    set iter_no "$iter_code$iter_no"

	    # popolo lista operatori
	    lappend operators [list $iter_no $name $first_name $no $fiscal_code $phone $mobile $address $notes $password $operator_id $patentino_op $patentino_op_fgas $email_operator $abilitazione_giuridica_p]

	}

	set ls_tools [db_list_of_lists  tools "
          select tool_id
               , :iter_code
               , type
               , brand
               , model
               , no
               , last_calibration_date
               , m.is_active_p --rom08
            from iter_tools m
           where maintainer_id = :maintainer_id
             and brand is not null"]

        append tools " $ls_tools"

	#ric03 aggiunto lista deleghe
	set ls_delegation [db_list_of_lists delegations "
            select d.delegation_id
                 , m.iter_code as cod_manutentore
                 , o.iter_code as cod_manutentore_inst
                 , d.start_date
                 , d.end_date
                 , d.delegation_state
                 , d.creation_date
                 , d.creation_user
                 , d.edit_date
                 , d.edit_user
              from iter_maintainer_delegations d
                 , iter_maintainers m
                 , iter_maintainers o
             where d.delegato_id = o.maintainer_id
               and d.maintainer_id = m.maintainer_id
               and d.maintainer_id = :maintainer_id"]

	append delegations " $ls_delegation";#ric03
	
	#rom01: Leggo maintainer_installations
	set man_inst [db_list_of_lists maintainers_installations "
                select maintainer_installations_id
                     , :iter_code
                     , installation_type_code
                     , 'batch'      as creation_user
                     , current_date as creation_date
                  from iter_maintainer_installations i
                     , iter_installation_types t
                 where maintainer_id = :maintainer_id
                   and t.installation_type_id = i.installation_type_id
              order by maintainer_installations_id"]

#	set iter_no_num 0

	foreach manut_in $man_inst {

	    #rom17 util_unlist $manut_in maintainer_installations_id maintainer_id installation_type_code creation_user creation_date
	    lassign $manut_in maintainer_installations_id maintainer_id installation_type_code creation_user creation_date

#	    incr iter_no_num

	    #rom01 Popolo lista maintainer_installations
	    lappend maintainers_installations [list $maintainer_installations_id $iter_code $installation_type_code $creation_user $creation_date]

	}
	
    }
    # Le liste maintainers, representatives e operators contengono i dati necessari ad
    # aggiornare le varie istanze di iter, ma prima devo validare i manutentori e aggiornare gli operatori.
    # Eseguo questi aggiornamenti, per motivi di integrità transazionale, al termine della db_foreach.

    ns_log notice "\niter::maintainers_new_from_curit \nmaintainers=$maintainers \nrepresentatives= $representatives \noperators=$operators \nmaintainers_installations=$maintainers_installations"
    set fd [open [ah::package_root -package_key iter-portal]/iter-update.log a]
    puts $fd "maintainers_new_from_curit"
    puts $fd "maintainers=$maintainers"
    puts $fd "representatives=$representatives"
    puts $fd "operators=$operators"
    puts $fd "maintainers_installations=$maintainers_installations"
    puts $fd "tools=$tools"
    puts $fd "delegations=$delegations";#ric03
    close $fd

    # valido manutentori
    foreach maintainer $maintainers {
        #nic02 set iter_code     [lindex $maintainer  0]
        #nic02 set maintainer_id [lindex $maintainer 19]
        set iter_code     [lindex [lindex $maintainer  0] 0];#nic02
        set maintainer_id [lindex [lindex $maintainer  0] 1];#nic02
	
	db_dml validate "
            update iter_maintainers set 
              --validating_date = current_date
              iter_code       = :iter_code 
              -- , validated_p     = 't'
            where maintainer_id = :maintainer_id"

    }

    # aggiorno operatori
    foreach operator $operators {
	set iter_no     [lindex $operator 0]
	set password    [lindex $operator 9]
	set operator_id [lindex $operator 10]
	#rom13set email_operator [lindex $operator 14];#but01
	
	db_dml op_upd "
            update iter_operators set 
                iter_no  = :iter_no, 
                password = :password
     --rom13    email_operator = :email_operator    --but01 
            where operator_id = :operator_id"
	
	#rom01 qui_inserire_utente_operatore
	
	set user_id  [db_nextval acs_object_id_seq]
	set username $iter_no
	set email "$iter_no@test.it"   
	set first_names [lindex $operator 2]
	set last_name [lindex $operator 1]
	#	set screen_name $first_names
	#abbiamo scoperto che screen_name deve essere univoco quindi uso il codice iter
	set screen_name $iter_no
	set password_confirm $password
	set url ""
	set secret_question ""
	set secret_answer ""

	ns_log notice "Luca10 R. user_id=$user_id username=$username email=$email first_name=$first_names last_name=$last_name screen_name=$screen_name password=$password password_confirm=$password_confirm operator_id=$operator_id"

	#sim db_transaction {

	    #E' capitato che tenesse in cache dati sporchi che poi facevano andare in errore l'inserimento dell'utente
	    #Per precauzione pulisco la cache per quell'utente prima di provare l'inserimento
	    set authority_id [auth::authority::local]
	    set pulisci_cash [util_memoize_flush [list acs_user::get_by_username_not_cached -authority_id $authority_id -username $username]]

	    #rom01 anticipo la creazione dello user OpenACS
	    array set creation_info [auth::create_user \
					 -user_id $user_id \
					 -verify_password_confirm \
					 -username $username \
					 -email $email \
					 -first_names $first_names \
					 -last_name $last_name \
					 -screen_name $screen_name \
					 -password $password \
					 -password_confirm $password_confirm \
					 -url $url \
					 -secret_question $secret_question \
					 -secret_answer $secret_answer]


	    ns_log notice "\nuser-new: creation_info=$creation_info(creation_status)"
	    #rom17 sistituita proc deprecata exists_and_not_null
   	    if {[string equal $creation_info(creation_status) "ok"] && [info exists rel_group_id] && $rel_group_id ne ""} {
		group::add_member \
		    -group_id $rel_group_id \
		    -user_id $user_id \
		    -rel_type $rel_type

	    }

	    if { [string equal $creation_info(creation_status) "ok"]} {
		
		#rom01 Nella creazione dell'utente ho dovuto usare una email fittizia per passare i controlli. 
		#rom01 Ora gli setto il codice operatore
		db_dml q "update parties
                         set email    = :username 
                       where party_id = :user_id"		

		set token_code_new $user_id[randomRange 99999999]
		db_dml q "insert into iter_login 
                                    ( utente
                                    , data_last_login
                                    , token_code
                                    ) values
                                    ( :username
                                    , current_timestamp
                                    , :token_code_new
                                    )"

	    } else {#but01 aggiunto email_operator nel else
		ns_log Notice "Luca R. iter::maintainers_new_from_curit ERRORE NELL'INSERIMENTO DELL'OPERATORE operator_id: $operator_id codice:$username messaggio: $creation_info(element_messages) $creation_info(creation_status) email: $email_operator "
	    } 	    
	#sim}
    }
    
    foreach instance $instances {

        ns_log notice "\niter::maintainers_new_from_curit ... processing instance=$instance"

	# nuovi manutentori
	iter::maintainers_new -dbn $instance -maintainers $maintainers

	# nuovi operatori
	iter::operators_new -dbn $instance -operators $operators

	# nuovi rappresentanti legali
	iter::representatives_new -dbn $instance -representatives $representatives

	ns_log notice "simone maintainers_installations=$maintainers_installations maintainers=$maintainers"

	#rom01 nuove tipologie installazione
	iter::maintainer_installations_new -dbn $instance -maintainers_installations $maintainers_installations

	#sim nuovi tools
	iter::iter_tools_new -dbn $instance -tools $tools

	#ric03 nuove deleghe
	iter::iter_delegation_new -dbn $instance -delegations $delegations
    }

    ns_log notice "\n Fine iter:maintainers_new_from_curit"

    return $to_notify
}

ad_proc -private iter::maintainers_update_from_curit {
    -from_date
    -to_date
    -instances
} {
    Aggiorna i manutentori nelle appropriate istanze di ITER.
} {

    ns_log notice "\n Inizio iter::maintainers_update_from_curit"

    # azzero liste
    set maintainers     [list]
    set representatives [list]
    set operators       [list]
    set upd_to_notify   [list] ;#rom12
    
    # leggo tutti i manutentori da aggiornare
    db_foreach query "
            select * 
            from iter_maintainers 
            where validated_p = 't' 
              and validating_date < editing_date
              and iter_code is not null -- rom09
              and editing_date between :from_date and :to_date
            order by iter_code
    " {
	
	# popolo lista manutentori
        # nic02: aggiunto campo pec
        # sim02: aggiunto campo patentino
	# sim06: aggiunto campo patentino_fgas
	# rom02: aggiunti campi la lb lc ld le lf lg
	lappend maintainers  [list $iter_code $name $address1 $address2 $province $zipcode $city $fiscal_code $iva_code $phone $mobile $fax $email $registration_no $where_registered $rea_no $where_rea $capital $role $pec $patentino $patentino_fgas $la $lb $lc $ld $le $lf $lg]
	
	# leggo rappresentante legale
	db_1row query "
            select p.name as rep_name, 
               p.first_name as rep_first_name, 
               p.address1 as rep_address1, 
               p.city as rep_city, 
               p.address2 as rep_address2, 
               p.province as rep_province, 
               p.zipcode as rep_zipcode, 
               p.fiscal_code as rep_fiscal_code,
               p.patentino as patentino_rapp,            --gac01
               p.patentino_fgas as patentino_fgas_rapp   --gac01
            from iter_parties p
            where p.party_id = :representative_id"

	# popolo lista rappresentanti legali
#nic01	lappend representatives [list $iter_code $rep_name $rep_first_name $rep_address1 $rep_city $rep_address2 $rep_province $rep_zipcode $rep_fiscal_code]
#gac01        lappend representatives [list $iter_code $rep_name $rep_first_name $rep_address1 $rep_city $rep_address2 $rep_province $rep_zipcode $rep_fiscal_code $maintainer_id];#nic01
        lappend representatives [list $iter_code $rep_name $rep_first_name $rep_address1 $rep_city $rep_address2 $rep_province $rep_zipcode $rep_fiscal_code $maintainer_id $patentino_rapp $patentino_fgas_rapp];#gac01

	# leggo operatori con iter_no significativo
	#but01 aggiunto il campo email_operator.
	set ops [db_list_of_lists operators "
                select operator_id, 
                       name, 
                       first_name, 
                       no, 
                       fiscal_code, 
                       phone, 
                       mobile, 
                       address, 
                       notes, 
                       iter_no, 
                       password, 
                       is_active_p,
                       patentino as patentino_op,              --gac01
                       patentino_fgas as patentino_op_fgas,    --gac01
                       email_operator,                          --but01
                       abilitazione_giuridica_p                 --ric02
                 from iter_operators 
                 where maintainer_id = :maintainer_id 
                   and iter_no is not null 
                 order by iter_no"]

	foreach op $ops {
	    #ric02 aggiunto abilitazione_giuridica_p
	    #but01 aggiunto email_operator
	    #rom17 util_unlist $op operator_id name first_name no fiscal_code phone mobile address notes iter_no password is_active_p patentino_op patentino_op_fgas email_operator
	    lassign $op operator_id name first_name no fiscal_code phone mobile address notes iter_no password is_active_p patentino_op patentino_op_fgas email_operator abilitazione_giuridica_p

	    # popolo lista operatori
	    #ric02 aggiunto abilitazione_giuridica_p
	    #but01 aggiunto email_operator alla lista
	    lappend operators [list $iter_no $name $first_name $no $fiscal_code $phone $mobile $address $notes $password $is_active_p $operator_id $patentino_op $patentino_op_fgas $email_operator $abilitazione_giuridica_p]
	}

	set iter_no_num [string trimleft [string range $iter_no 8 9] "0"]

	# leggo operatori con iter_no nullo
	set ops [db_list_of_lists operators "
                select operator_id, 
                       name, 
                       first_name, 
                       no, 
                       fiscal_code, 
                       phone, 
                       mobile, 
                       address, 
                       notes, 
                       iter_no, 
                       password, 
                       is_active_p,
                       patentino as patentino_op,              --gac01
                       patentino_fgas as patentino_op_fgas,     --gac01
                       email_operator,                           --but01 
                       abilitazione_giuridica_p                 --ric02
                 from iter_operators 
                 where maintainer_id = :maintainer_id 
                   and iter_no is null 
                 order by operator_id"]

	foreach op $ops {
	    #rom17 util_unlist $op operator_id name first_name no fiscal_code phone mobile address notes iter_no password is_active_p patentino_op patentino_op_fgas email_operator
	    #ric02 aggiunto abilitazione_giuridica_p
	    lassign $op operator_id name first_name no fiscal_code phone mobile address notes iter_no password is_active_p patentino_op patentino_op_fgas email_operator abilitazione_giuridica_p

	    # genero password
	    set password [randomRange 99999999]

	    # genero iter_no
	    incr iter_no_num
	    set iter_no [ah::lpad $iter_no_num 2 "0"]
	    set iter_no "$iter_code$iter_no"

	    # popolo lista operatori
	    lappend operators [list $iter_no $name $first_name $no $fiscal_code $phone $mobile $address $notes $password $is_active_p $operator_id $patentino_op $patentino_op_fgas $email_operator $abilitazione_giuridica_p]

	}
	
	if {[llength $ops] > 0} {#rom12 Aggiunta if e il suo contenuto
	    lappend upd_to_notify [list $maintainer_id]
	}
    }

    # Le liste maintainers, representatives e operators contengono i dati necessari ad
    # aggiornare le varie istanze di iter, ma prima devo aggiornare gli operatori.
    # Eseguo questi aggiornamenti, per motivi di integrità transazionale, al termine della db_foreach.

    ns_log notice "\niter::maintainers_update_from_curit \nmaintainers=$maintainers \nrepresentatives= $representatives \noperators=$operators"
    set fd [open [ah::package_root -package_key iter-portal]/iter-update.log a]
    puts $fd "maintainers_update_from_curit"
    puts $fd "maintainers=$maintainers"
    puts $fd "representatives=$representatives"
    puts $fd "operators=$operators"
    close $fd

    # aggiorno operatori
    #but01 aggiunto email_operator
    foreach operator $operators {
	set iter_no     [lindex $operator 0]
	set password    [lindex $operator 9]
	set operator_id [lindex $operator 11]
	#rom13set email_operator [lindex $operator 14]

	# aggiorno operatore                
	db_dml op_upd "
            update iter_operators set 
                iter_no = :iter_no, 
                password = :password
       --rom13  email_operator = :email_operator  --but01 
            where operator_id = :operator_id"
	
	set user_id  [db_nextval acs_object_id_seq]
	set username $iter_no
	set email "$iter_no@test.it"   
	set first_names [lindex $operator 2]
	set last_name [lindex $operator 1]
	#       set screen_name $first_names
	#abbiamo scoperto che screen_name deve essere univoco quindi uso il codice iter
	        set screen_name $iter_no
	set password_confirm $password
	set url ""
	set secret_question ""
	set secret_answer ""
	
	ns_log notice "Luca1 R. user_id=$user_id username=$username email=$email first_name=$first_names last_name=$last_name screen_name=$screen_name password=$password password_confirm=$password_confirm operator_id=$operator_id"
	
	#db_transaction {
	    

	    if {![db_0or1row q "select 1 from users where username = :username limit 1"]} {
	    #E' capitato che tenesse in cache dati sporchi che poi facevano andare in errore l'inserimento dell'utente
	    #Per precauzione pulisco la cache per quell'utente prima di provare l'inserimento
	    set authority_id [auth::authority::local]
	    set pulisci_cash [util_memoize_flush [list acs_user::get_by_username_not_cached -authority_id $authority_id -username $username]]

	    #rom01 anticipo la creazione dello user OpenACS
	    array set creation_info [auth::create_user \
					 -user_id $user_id \
					 -verify_password_confirm \
					 -username $username \
					 -email $email \
					 -first_names $first_names \
					 -last_name $last_name \
					 -screen_name $screen_name \
					 -password $password \
					 -password_confirm $password_confirm \
					 -url $url \
					 -secret_question $secret_question \
					 -secret_answer $secret_answer]


	    ns_log notice "\nuser-new: creation_info=$creation_info(creation_status)"
	    #rom17 sistituita proc deprecata exists_and_not_null
   	    if {[string equal $creation_info(creation_status) "ok"] && [info exists rel_group_id] && $rel_group_id ne ""} {
		group::add_member \
		    -group_id $rel_group_id \
		    -user_id $user_id \
		    -rel_type $rel_type

	    }

	    if { [string equal $creation_info(creation_status) "ok"]} {
		
		#rom01 Nella creazione dell'utente ho dovuto usare una email fittizia per passare i controlli. 
		#rom01 Ora gli setto il codice operatore
		db_dml q "update parties
                         set email    = :username 
                       where party_id = :user_id"		

		set token_code_new $user_id[randomRange 99999999]
		db_dml q "insert into iter_login 
                                    ( utente
                                    , data_last_login
                                    , token_code
                                    ) values
                                    ( :username
                                    , current_timestamp
                                    , :token_code_new
                                    )"



	    } else {
		ns_log Notice "Luca R. iter::maintainers_new_from_curit ERRORE NELL'INSERIMENTO DELL'OPERATORE operator_id: $operator_id codice:$username messaggio: $creation_info(element_messages) $creation_info(creation_status) "
	    } 	    
	    } else {
		ns_log Notice "Luca R. iter::maintainers_new_from_curit  Utente $username già presente"
	    }

	#}

    }

    foreach instance $instances {

        ns_log notice "\niter::maintainers_update_from_curit ... processing instance=$instance"

	# aggiorno manutentori
	iter::maintainers_update -dbn $instance -maintainers $maintainers

	# aggiorno operatori
	iter::operators_update -dbn $instance -operators $operators

	# aggiorno rappresentanti legali
#nic01	iter::representatives_update -dbn $instance -representatives $representatives
	iter::representatives_update -dbn $instance -representatives $representatives -from_date $from_date -to_date $to_date;#nic01

    }

    ns_log notice "\n Fine iter:maintainers_update_from_curit"
    return $upd_to_notify;#rom12
}

ad_proc -public iter::trustees_new_from_curit {
    -from_date
    -to_date
    -instances
} {
    Creazione nuovi amministratori di condominio.
} {

    ns_log notice "\n Inizio iter::trustees_new_from_curit"

    set validating_date [ah::today_ansi]

    # azzero lista amministratori
    set trustees  [list]
    set to_notify [list]

    set iter_code_num [db_string trustee "select max(substr(iter_code, 3, 6)) from iter_trustees"]
    set iter_code_num [string trimleft $iter_code_num "0"]
    if {[string equal $iter_code_num ""]} {
	set iter_code_num 0
    }

    db_foreach query "
        select * 
        from iter_trustees 
        where approved_p = 't' 
          and validating_date is null  
        order by creation_date, trustee_id
    " {

	incr iter_code_num
	set iter_code [db_string query "select lpad(:iter_code_num, 6, '0')"]
	set iter_code "AM$iter_code"
	set password [randomRange 99999999]
	if {[string equal $jtype "0"]} {
	    set natura "G"
	} else {
	    set natura "F"
	}

	# popolo lista amministratori
	lappend trustees [list $iter_code $name $first_name $address1 $city $address2 $province $zipcode $fiscal_code $iva_code $phone $mobile $fax $email $natura $password $trustee_id]

        # popolo lista soggetti da notificare
	lappend to_notify [list $trustee_id $office_id]
    }
    # La lista trustees contiene i dati necessari ad aggiornare le varie istanze di iter, ma prima 
    # devo aggiornare gli amministratori.
    # Eseguo questi aggiornamenti, per motivi di integrità transazionale, al termine della db_foreach.

    ns_log notice "\niter::trustees_new_from_curit \ntrustees=$trustees"
    set fd [open [ah::package_root -package_key iter-portal]/iter-update.log a]
    puts $fd "trustees_new_from_curit"
    puts $fd "trustees=$trustees"
    close $fd

    # aggiorno amministratori
    foreach trustee $trustees {
	set iter_code   [lindex $trustee 0]
	set password    [lindex $trustee 15]
	set trustee_id  [lindex $trustee 16]

	db_dml query "
            update iter_trustees set 
                validating_date = current_date, 
                iter_code       = :iter_code 
              , password        = :password 
              , validated_p     = 't'
            where trustee_id = :trustee_id"
    }

    foreach instance $instances {

        ns_log notice "\niter::trustees_new_from_curit ... processing instance=$instance"

	# nuovi amministratori
	iter::trustees_new -dbn $instance -trustees $trustees

    }


    
    ns_log notice "\niter::trustees_new_from_curit fine"
    
    return $to_notify
}

ad_proc -public iter::trustees_update_from_curit {
    -from_date
    -to_date
    -instances
} {
    Aggiorna gli amministratori di condominio nelle appropriate istanze di ITER.
} {

    ns_log notice "\n Inizio iter::trustees_update_from_curit"

    # azzero liste
    set trustees     [list]
    
    # leggo tutti gli amministratori da aggiornare
    db_foreach query "
            select * 
            from iter_trustees 
            where approved_p = 't' 
              and validating_date < editing_date 
              and editing_date between :from_date and :to_date 
            order by iter_code
    " {

	if {[string equal $jtype "0"]} {
	    set natura "G"
	} else {
	    set natura "F"
	}
	
	# popolo lista amministratori
	lappend trustees [list $iter_code $name $first_name $address1 $city $address2 $province $zipcode $fiscal_code $iva_code $phone $mobile $fax $email $natura $password ]
	
    }

    # la lista trustees contiene i dati necessari ad aggiornare le varie istanze di iter

    ns_log notice "\niter::trustees_update_from_curit \ntrustees=$trustees"
    set fd [open [ah::package_root -package_key iter-portal]/iter-update.log a]
    puts $fd "trustees_update_from_curit"
    puts $fd "trustees=$trustees"
    close $fd

    foreach instance $instances {

        ns_log notice "\niter::trustees_update_from_curit ... processing instance=$instance"

	# aggiorno amministratori
	iter::trustees_update -dbn $instance -trustees $trustees

    }

    ns_log notice "\n Fine iter:trustees_update_from_curit"
    
}

ad_proc -private iter::maintainers_new {
    -dbn
    -maintainers
} {
    Crea i manutentori della lista 'maintainers' nel database 'dbn'.
} {

    set fd [open [ah::package_root -package_key iter-portal]/iter-update.log a]

    set sw_multi_portafoglio [parameter::get_from_package_key -package_key wallet -parameter sw_multi_portafoglio -default 0];#gab01

    if {$sw_multi_portafoglio} {;#gab01 aggiunta if, else e contenuto
	set instance_multiportafoglio $dbn
    } else {
	set instance_multiportafoglio [db_get_database]
    }

    foreach maintainer $maintainers {

        #nic02 set cod_manutentore [lindex $maintainer 0]
        set cod_manutentore [lindex [lindex $maintainer 0] 0];#nic02
	set cognome         [lindex $maintainer 1]
	set indirizzo       [lindex $maintainer 2]
	set indirizzo       [string range $indirizzo 0 39]
	set localita        [lindex $maintainer 3]
	set provincia       [lindex $maintainer 4]
	set cap             [lindex $maintainer 5]
	set comune          [lindex $maintainer 6]
	set cod_fiscale     [lindex $maintainer 7]
	set cod_piva        [lindex $maintainer 8]
	set telefono        [lindex $maintainer 9]
	set telefono        [string range $telefono 0 14]
	set cellulare       [lindex $maintainer 10]
	set cellulare       [string range $cellulare 0 14]
	set fax             [lindex $maintainer 11]
	set fax             [string range $fax 0 14]
	set email           [lindex $maintainer 12]
	#rom05set email           [string range $email 0 34]
	set email           [string range $email 0 149];#rom05
	set reg_imprese     [lindex $maintainer 13]
	set localita_reg    [lindex $maintainer 14]
	set rea             [lindex $maintainer 15]
	set localita_rea    [lindex $maintainer 16]
	set capit_sociale   [lindex $maintainer 17]
	set flag_ruolo      [lindex $maintainer 18]
        set pec             [lindex $maintainer 19];#nic02
        set patentino       [lindex $maintainer 20];#sim02
	set patentino_fgas  [lindex $maintainer 21];#sim06
	set la              [lindex $maintainer 22];#rom02
	set lb              [lindex $maintainer 23];#rom02
        set lc              [lindex $maintainer 24];#rom02
	set ld              [lindex $maintainer 25];#rom02
	set le              [lindex $maintainer 26];#rom02
	set lf              [lindex $maintainer 27];#rom02
	set lg              [lindex $maintainer 28];#rom02
	
	if {[string equal $flag_ruolo "1"]} {
	    set flag_ruolo "M"
	} elseif {[string equal $flag_ruolo "0"]} {
	    set flag_ruolo "I"
	} elseif {[string equal $flag_ruolo "2"]} {
	    set flag_ruolo "T"
	} elseif {[string equal $flag_ruolo "3"]} {;#sim05 if e suo contenuto
            set flag_ruolo "E"
        } elseif {[string equal $flag_ruolo "4"]} {;#sim05 if e suo contenuto
            set flag_ruolo "L"
	} elseif {[string equal $flag_ruolo "5"]} {;#sim09 if e suo contenuto
            set flag_ruolo "B"
        }
	
	#rom06 Limito la varibaile da 15 a 20 caratteri
	if {[string length $reg_imprese] > 20} {
	    set reg_imprese [string range $reg_imprese 0 19]
	}

        ns_log notice "\n ... inserisco manutentore $cod_manutentore su dbn=$dbn"
        puts $fd "... inserisco manutentore $cod_manutentore su dbn=$dbn"
        puts $fd $maintainer

        db_dml -dbn $dbn iter_maintainer_new "
            insert into coimmanu (
                cod_manutentore
              , cognome
              , indirizzo
              , localita
              , provincia
              , cap
              , comune
              , cod_fiscale
              , cod_piva
              , telefono
              , cellulare
              , fax
              , email
              , reg_imprese
              , localita_reg
              , rea
              , localita_rea
              , capit_sociale
              , data_ins
              , flag_ruolo
              , flag_convenzionato
              , pec -- nic02
              , patentino --sim02
              , patentino_fgas --sim06
              , flag_a --rom02
              , flag_b --rom02
              , flag_c --rom02
              , flag_d --rom02
              , flag_e --rom02
              , flag_f --rom02
              , flag_g --rom02
            ) values (
                :cod_manutentore
              , :cognome
              , :indirizzo
              , :localita
              , :provincia
              , :cap
              , :comune
              , :cod_fiscale
              , :cod_piva
              , :telefono
              , :cellulare
              , :fax
              , :email
              , :reg_imprese
              , :localita_reg
              , :rea
              , :localita_rea
              , :capit_sociale
              , current_date
              , :flag_ruolo
              , 'S'  -- flag_convenzionato
              , :pec -- nic02
              , :patentino --sim02
              , :patentino_fgas --sim06
              , :la --rom02
              , :lb --rom02
              , :lc --rom02
              , :ld --rom02
              , :le --rom02
              , :lf --rom02
              , :lg --rom02
            )"

	set sw_wallet_usato_dal_portale [parameter::get_from_package_key -package_key wallet -parameter sw_usato_dal_portale -default 0];#sim01

	if {$sw_wallet_usato_dal_portale eq "1"} {

	    db_1row source_man "
             select source_id as maintainers_source_id
                  , prefix as maintainers_prefix
               from wal_sources
              where source_name = 'MAN'";#sim01

	    set id [db_string query "select substr(:cod_manutentore,3,6)"];#sim01

	    # genero identificativo univoco di 18 digit per Lottomatica
	    set holder_id [db_string query "select substr(:cod_manutentore,3,length(:cod_manutentore))"];#sim01

            if {![db_0or1row query "
                  select wallet_id
                    from wal_holders
                   where instance_name = :instance_multiportafoglio --gab01
                     and holder_id = :holder_id"]
	    } {#sim03: ho solo aggiunta la if ma non il suo contenuto

                set wallet_id ${maintainers_prefix}${id}[randomRange 99999999];#sim01
                set wallet_id [ah::rpad $wallet_id 18 9];#sim01

		#gab01 aggiunto instance_name
		db_dml new_holder "
                insert
                  into wal_holders
                     ( holder_id
                     , wallet_id
                     , source_id
                     , filename
                     , sisal_filename
                     , name
                     , fiscal_code
                     , iva_code
                     , city
                     , instance_name
                     )
              values (:holder_id
                     ,:wallet_id
                     ,:maintainers_source_id
                     ,null
                     ,null
                     ,upper(:cognome)
                     ,upper(:cod_fiscale)
                     ,:cod_piva
                     ,upper(:comune)
                     ,:instance_multiportafoglio
                     )";#sim01

            };#sim03

	    db_dml -dbn $dbn query "
            update coimmanu
               set wallet_id       = :wallet_id
             where cod_manutentore = :cod_manutentore";#sim01

	    db_dml query "
            update iter_maintainers
               set wallet_id       = :wallet_id
             where iter_code       = :cod_manutentore";#sim01
	};#sim01

    }

    close $fd

    return 0
}


ad_proc -private iter::representatives_new {
    -dbn
    -representatives
} {
    Crea i rappresentanti legali della lista 'representatives' nel database 'dbn'.
} {

    set fd [open [ah::package_root -package_key iter-portal]/iter-update.log a]

    foreach representative $representatives {

	set cod_manutentore [string trim [lindex $representative 0]]
	set cognome         [string trim [lindex $representative 1]]
	set nome            [string trim [lindex $representative 2]]
	set indirizzo       [string trim [lindex $representative 3]]
	set indirizzo       [string range $indirizzo 0 39]
	set comune          [string trim [lindex $representative 4]]
	set localita        [string trim [lindex $representative 5]]
	set provincia       [string trim [lindex $representative 6]]
	set cap             [string trim [lindex $representative 7]]
	set cod_fiscale     [string trim [lindex $representative 8]]
	set patentino       [string trim [lindex $representative 9]]    ;#gac01
        set patentino_fgas  [string trim [lindex $representative 10]]   ;#gac01

	db_1row -dbn $dbn query "select nextval('coimcitt_s') as cod_cittadino"

        ns_log notice "\n ... inserisco rappresentante legale  $cod_cittadino su dbn=$dbn" 
        puts $fd "... inserisco rappresentante legale  $cod_cittadino su dbn=$dbn" 
        puts $fd $representative

        db_dml -dbn $dbn iter_citta_new "
                insert into coimcitt ( 
                       cod_cittadino
                     , natura_giuridica
                     , cognome
                     , nome
                     , indirizzo
                     , cap
                     , localita
                     , comune
                     , provincia
                     , cod_fiscale
                     , data_ins
                     , patentino                --gac01
                     , patentino_fgas           --gac01
                ) values (
                      :cod_cittadino
                     ,'F'
                     ,upper(:cognome)
                     ,upper(:nome)
                     ,upper(:indirizzo)
                     ,:cap
                     ,upper(:localita)
                     ,upper(:comune)
                     ,upper(:provincia)
                     ,upper(:cod_fiscale)
                     ,current_date
                     ,:patentino                --gac01
                     ,:patentino_fgas           --gac01
                 )"

        ns_log notice "\n ... aggiorno manutentore con rappresentante=$cod_manutentore su dbn=$dbn"
        puts $fd "... aggiorno manutentore con rappresentante=$cod_manutentore su dbn=$dbn"

	db_dml -dbn $dbn iter_update_rleg "
            update coimmanu set 
                cod_legale_rapp = :cod_cittadino 
            where cod_manutentore = :cod_manutentore"

    }

    close $fd

    return 0
}
#rom01 aggiunta nuova proc per le nuove tipologie d'installazione
ad_proc -private iter::maintainer_installations_new {
    -dbn
    -maintainers_installations
} {
    inserisce i record della tabella iter_maintainers_installations sulla tabella coimtpin_manu nel database 'dbn'.
} {

    set fd [open [ah::package_root -package_key iter-portal]/iter-update.log a]

    ns_log notice "Simone100 maintainers_installations=$maintainers_installations"

    foreach maintainer_installation $maintainers_installations {

	ns_log notice "Simone101 maintainers_installation=$maintainer_installation"
	
	set cod_coimtpin_manu [lindex $maintainer_installation 0]
	set cod_manutentore   [lindex $maintainer_installation 1]
	set codice_coimtpin   [lindex $maintainer_installation 2]
	set creation_user     [lindex $maintainer_installation 3]
	set creation_date     [lindex $maintainer_installation 4]
	ns_log notice "luca100 cod_coimtpin_manu: $cod_coimtpin_manu cod_manutentore: $cod_manutentore codice_coimtpin: $codice_coimtpin creation_user: $creation_user creation_date: $creation_date"
	ns_log notice "\n ... inserisco installation_type_id $codice_coimtpin su dbn=$dbn"
        puts $fd "... inserisco installation_type_id $codice_coimtpin su dbn=$dbn"
	puts $fd $maintainer_installation

	set cod_coimtpin_manu_new [db_string  -dbn $dbn q "select coalesce(max(cod_coimtpin_manu),0) +1 from coimtpin_manu"]

	ns_log notice "luca101  insert into coimtpin_manu
                    ( cod_coimtpin_manu
                    , cod_manutentore
                    , cod_coimtpin
                    , creation_user
                    , creation_date )
               select :cod_coimtpin_manu_new
                    , :cod_manutentore
                    , cod_coimtpin
                    , :creation_user
                    , :creation_date
                 from coimtpin
                where codice = :codice_coimtpin "

	 db_dml -dbn $dbn iter_maintainer_installation_new "
             insert into coimtpin_manu 
                    ( cod_coimtpin_manu 
                    , cod_manutentore 
                    , cod_coimtpin 
                    , creation_user 
                    , creation_date )
               select :cod_coimtpin_manu_new
                    , :cod_manutentore
                    , cod_coimtpin
                    , :creation_user
                    , :creation_date
                 from coimtpin
                where codice = :codice_coimtpin "
	
    }
    
    close $fd
    
    return 0
}
#rom01 fine


#sim aggiunta nuova proc per gli analizzatori 
ad_proc -private iter::iter_tools_new {
    -dbn
    -tools
} {
    inserisce i record della tabella iter_tools sulla tabella coimstru_manu nel database 'dbn'.
} {

    set fd [open [ah::package_root -package_key iter-portal]/iter-update.log a]

    ns_log notice "Simone100 tools=$tools"

    
    foreach tool $tools {

	ns_log notice "Simone101 tool=$tool"
	
	set tool_id           [lindex $tool 0]
	set cod_manutentore   [lindex $tool 1]
	set tipo_strum        [lindex $tool 2]
	#rom14 set marca_strum       [lindex $tool 3]
	#rom14 set modello_strum     [lindex $tool 4]
	#rom14 set matr_strum        [lindex $tool 5]
	set marca_strum       [string range [lindex $tool 3] 0 49];#rom14
        set modello_strum     [string range [lindex $tool 4] 0 49];#rom14
        set matr_strum        [string range [lindex $tool 5] 0 49];#rom14
	set dt_tar_strum      [lindex $tool 6]
	set is_active_p       [lindex $tool 7];#rom08
	

	set ls_strum_mod [db_list -dbn $dbn q "select cod_strumento
                                                 from coimstru_manu
                                                where cod_manutentore = :cod_manutentore
                                                  and tipo_strum      = :tipo_strum 
                                                  and marca_strum     = :marca_strum 
                                                  and modello_strum   = :modello_strum 
                                                  and matr_strum      = :matr_strum
                                          --rom11 and is_active_p    != :is_active_p
                                                  and ( is_active_p  != :is_active_p
                                                     or dt_tar_strum != :dt_tar_strum) --rom11 "]

	if {[llength $ls_strum_mod] >=1} {#rom08 Aggiunta if e il suo contenuto
	    
	    foreach tool_mod $ls_strum_mod {

		puts $fd "... aggiorno tool tool_id $tool_id del manutentore $cod_manutentore su dbn=$dbn"
		puts $fd $tool
		
		#Devo aggiornare lo strumento e non inserirlo nuovo perche' dal portale lo hanno solo disattivato.
		db_dml -dbn $dbn iter_tool_upd "
             update coimstru_manu
                set is_active_p     = :is_active_p
                  , dt_tar_strum    = :dt_tar_strum --rom11
              where cod_strumento   = :tool_mod
                and cod_manutentore = :cod_manutentore"
	    }
	    
	} else {#rom08 Aggiunta else ma non il suo contenuto
	    
	    puts $fd "... inserisco tool tool_id $tool_id su dbn=$dbn"
	    puts $fd $tool
	    
	    set cod_strumento_new [db_string  -dbn $dbn q "select coalesce(max(cod_strumento::integer),0) +1 from coimstru_manu"]

	    #inserisco solo se nuovo
	    if {![db_0or1row -dbn $dbn q "select 1 
                              from coimstru_manu 
                             where tipo_strum=:tipo_strum 
                               and marca_strum=:marca_strum 
                               and modello_strum=:modello_strum 
                               and matr_strum=:matr_strum
                               and cod_manutentore=:cod_manutentore limit 1"]} {
	
		db_dml -dbn $dbn iter_tool_new "
             insert into coimstru_manu
                    ( cod_strumento
                    , cod_manutentore
                    ,tipo_strum
                    ,marca_strum 
                    ,modello_strum
                    ,matr_strum
                    ,dt_tar_strum
                    ,is_active_p  --rom08
                    )
               values ( :cod_strumento_new
                    ,:cod_manutentore
                    ,:tipo_strum
                    ,:marca_strum
                    ,:modello_strum
                    ,:matr_strum
                    ,:dt_tar_strum
                    ,:is_active_p --rom08
                    )"

	    }
	 
	};#rom08

    }
    close $fd
    
    return 0
}
#sim fine


ad_proc -private iter::operators_new {
    -dbn
    -operators
} {
    Crea gli operatori della lista 'operators' nel database 'dbn'.
} {
    
    set fd [open [ah::package_root -package_key iter-portal]/iter-update.log a]

    foreach operator $operators {

	set cod_opma        [lindex $operator 0]
	set cod_manutentore [string range $cod_opma 0 7]
	set cognome         [lindex $operator 1] 
	set nome            [lindex $operator 2]
	set matricola       [lindex $operator 3]
	set codice_fiscale  [lindex $operator 4]
	set telefono        [lindex $operator 5]
	set cellulare       [lindex $operator 6]
	set recapito        [lindex $operator 7]
	set note            [lindex $operator 8]
	set password        [lindex $operator 9]
	#[lindex $operator 10] è l'operator_id che non mi serve
        set patentino       [lindex $operator 11]        ;#gac01
        set patentino_fgas  [lindex $operator 12]        ;#gac01
	set email_operator  [lindex $operator 13]        ;#but01
	set abilitazione_giuridica_p [lindex $operator 14];#ric02

        ns_log notice "\n ... inserisco operatore $cod_opma su dbn=$dbn"
        puts $fd "... inserisco operatore $cod_opma su dbn=$dbn"
        puts $fd $operator
	#ric02 aggiunto abilitazione_giuridica_p
	#gac01 aggiunti campi patentino e patentino_fgas
	#but01 aggiunto il campo email_operator
	db_dml -dbn $dbn iter_op_new "
            insert into coimopma (
                cod_opma, cod_manutentore, cognome, nome, matricola, codice_fiscale, telefono, cellulare, recapito, note, patentino, patentino_fgas, email_operator, abilitazione_giuridica_p
            ) values (
                :cod_opma, :cod_manutentore, :cognome, :nome, :matricola, :codice_fiscale, :telefono, :cellulare, :recapito, :note, :patentino, :patentino_fgas, :email_operator, :abilitazione_giuridica_p
            )"

        ns_log notice "\n ... inserisco utente $cod_opma su dbn=$dbn"
        puts $fd "... inserisco utente $cod_opma su dbn=$dbn"

	set salt     [sec_random_token];#ric01
	#rom10set password [ns_md string $password$salt];#ric01
	set password [ns_md string -digest "sha256" $password$salt];#ric01
	#but01 modificato il valore del campo e_mail dal '.' al $email_operator
      	db_dml -dbn $dbn iter_user_new "
            insert into coimuten (
                id_utente, cognome, nome, password, id_settore, id_ruolo, lingua, e_mail, rows_per_page, data, livello
		, salt             --ric01
                , is_first_login_p --ric01
                , codice_fiscale   --rom15
            ) values (
                :cod_opma, substr(:cognome, 1 ,40), substr(:nome, 1, 40), :password, 'ente', 'manutentore', 'it', coalesce(:email_operator,'.'), 30, current_date, 5
		, :salt            --ric01
                , 't'              --ric01
                , :codice_fiscale  --rom15
            )"
    }

    close $fd

    return 0
}

ad_proc -private iter::trustees_new {
    -dbn
    -trustees
} {
    Crea gli amministratori della lista 'trustees' nel database 'dbn'.
} {

    set fd [open [ah::package_root -package_key iter-portal]/iter-update.log a]

    foreach trustee $trustees {

	set cod_cittadino     [lindex $trustee 0]
	set cognome           [string trim [lindex $trustee 1]]
	set cognome_uten      [string range $cognome 0 39]
	set nome              [string trim [lindex $trustee 2]]
	set nome_uten         [string range $nome 0 39]
        if {$nome_uten eq ""} {
	    set nome_uten "-"  ; # mi cautelo in caso di nome nullo
	}
	set indirizzo         [string trim [lindex $trustee 3]]
	set indirizzo         [string range $indirizzo 0 39]
	set comune            [string trim [lindex $trustee 4]]
	set localita          [string trim [lindex $trustee 5]]
	set provincia         [lindex $trustee 6]
	set cap               [lindex $trustee 7]
	set cod_fiscale       [lindex $trustee 8]
	set cod_piva          [lindex $trustee 9]
	set telefono          [lindex $trustee 10]
	set telefono          [string range $telefono 0 14]
	set cellulare         [lindex $trustee 11]
	set cellulare         [string range $cellulare 0 14]
	set fax               [lindex $trustee 12]
	set fax               [string range $fax 0 14]
	set email             [lindex $trustee 13]
	set email             [string range $email 0 34]
	set natura_giuridica  [lindex $trustee 14]
	set password          [lindex $trustee 15]

	####inizio creazione utente per login iter

	set user_id  [db_nextval acs_object_id_seq]
	set username $cod_cittadino
	set email "$cod_cittadino@test.it"
	set first_names $nome_uten
	set last_name $cognome_uten
	set screen_name $first_names
	set password_confirm $password
	set url ""
	set secret_question ""
	set secret_answer ""

	if {![db_0or1row q "select 1 from users where username = :username limit 1"]} {
	    #E' capitato che tenesse in cache dati sporchi che poi facevano andare in errore l'inserimento dell'utente
	    #Per precauzione pulisco la cache per quell'utente prima di provare l'inserimento
	    set authority_id [auth::authority::local]
	    set pulisci_cash [util_memoize_flush [list acs_user::get_by_username_not_cached -authority_id $authority_id -username $username]]
	
	    #anticipo la creazione dello user OpenACS
	    array set creation_info [auth::create_user \
					 -user_id $user_id \
					 -verify_password_confirm \
					 -username $username \
					 -email $email \
					 -first_names $first_names \
					 -last_name $last_name \
					 -screen_name $screen_name \
					 -password $password \
					 -password_confirm $password_confirm \
					 -url $url \
					 -secret_question $secret_question \
					 -secret_answer $secret_answer]
	    
	    ns_log notice "\nuser-new: creation_info=$creation_info(creation_status)"
	    if { [string equal $creation_info(creation_status) "ok"] && [exists_and_not_null rel_group_id] } {
		group::add_member \
		    -group_id $rel_group_id \
		    -user_id $user_id \
		    -rel_type $rel_type
		
	    }
	    
	    if { [string equal $creation_info(creation_status) "ok"]} {
		
		#rom01 Nella creazione dell'utente ho dovuto usare una email fittizia per passare i controlli. 
		#rom01 Ora gli setto il codice operatore
		db_dml q "update parties
                         set email    = :username 
                       where party_id = :user_id"		
		
		set token_code_new $user_id[randomRange 99999999]
		db_dml q "insert into iter_login 
                                    ( utente
                                    , data_last_login
                                    , token_code
                                    ) values
                                    ( :username
                                    , current_timestamp
                                    , :token_code_new
                                    )"
		
		
	    
	    } else {
		ns_log Notice "Simone iter::trustees_new_from_curit ERRORE NELL'INSERIMENTO DELL'amministratore username=$username messaggio: $creation_info(element_messages) $creation_info(creation_status) "
	    } 	    
	} else {
	    ns_log Notice "Simone iter::trustees_new_from_curit  Utente $username già presente"
	}
	
	
	####fine creazione utente
	
	
        ns_log notice "\n ... inserisco amministratore $cod_cittadino su dbn=$dbn"
        puts $fd "... inserisco amministratore $cod_cittadino su dbn=$dbn"
        puts $fd $trustee

        db_dml -dbn $dbn iter_citta_new "insert
                  into coimcitt ( 
                       cod_cittadino
                     , natura_giuridica
                     , cognome
                     , nome
                     , indirizzo
                     , cap
                     , localita
                     , comune
                     , provincia
                     , cod_fiscale
                     , cod_piva
                     , telefono
                     , cellulare
                     , fax
                     , email
                     , data_ins
                ) values (
                      :cod_cittadino
                     ,:natura_giuridica
                     ,upper(:cognome)
                     ,upper(:nome)
                     ,upper(:indirizzo)
                     ,:cap
                     ,upper(:localita)
                     ,upper(:comune)
                     ,upper(:provincia)
                     ,upper(:cod_fiscale)
                     ,upper(:cod_piva)
                     ,upper(:telefono)
                     ,upper(:cellulare)
                     ,upper(:fax)
                     ,:email
                     ,current_date
                  )"

        ns_log notice "\n ... inserisco utente $cod_cittadino su dbn=$dbn"
        puts $fd "... inserisco utente $cod_cittadino su dbn=$dbn"

	set salt     [sec_random_token];#ric01
	#rom10set password [ns_md string $password$salt];#ric01
	set password [ns_md string -digest "sha256" $password$salt];#rom10

        db_dml -dbn $dbn iter_user_new "
            insert into coimuten (
                id_utente, cognome, nome, password, id_settore, id_ruolo, lingua, e_mail, rows_per_page, data, livello
		, salt             --ric01
                , is_first_login_p --ric01
                , codice_fiscale   --rom15
            ) values (
                :cod_cittadino, substr(:cognome_uten, 1, 40), substr(:nome_uten, 1, 40), :password, 'regione', 'ammin', 'it', '.', 30, current_date, 5
		, :salt            --ric01
                , 't'              --ric01
                , :cod_fiscale     --rom15
            )"

    }

    close $fd

    return 0
}

ad_proc -private iter::maintainers_update {
    -dbn
    -maintainers
} {
    Aggiorna i manutentori della lista 'maintainers' nel database 'dbn'.
} {

    set fd [open [ah::package_root -package_key iter-portal]/iter-update.log a]

    set maintainer_installations [list];#rom01

    foreach maintainer $maintainers {

	set cod_manutentore [lindex $maintainer 0]
	set cognome         [lindex $maintainer 1]
	set indirizzo       [lindex $maintainer 2]
	set indirizzo       [string range $indirizzo 0 39]
	set localita        [lindex $maintainer 3]
	set provincia       [lindex $maintainer 4]
	set cap             [lindex $maintainer 5]
	set comune          [lindex $maintainer 6]
	set cod_fiscale     [lindex $maintainer 7]
	set cod_piva        [lindex $maintainer 8]
	set telefono        [lindex $maintainer 9]
	set telefono        [string range $telefono 0 14]
	set cellulare       [lindex $maintainer 10]
	set cellulare       [string range $cellulare 0 14]
	set fax             [lindex $maintainer 11]
	set fax             [string range $fax 0 14]
	set email           [lindex $maintainer 12]
	#rom05set email           [string range $email 0 34]
	set email           [string range $email 0 149];#rom05
	set reg_imprese     [lindex $maintainer 13]
	set localita_reg    [lindex $maintainer 14]
	set rea             [lindex $maintainer 15]
	set localita_rea    [lindex $maintainer 16]
	set capit_sociale   [lindex $maintainer 17]
	set flag_ruolo      [lindex $maintainer 18]
        set pec             [lindex $maintainer 19];#nic02
        set patentino       [lindex $maintainer 20];#sim02
	set patentino_fgas  [lindex $maintainer 21];#sim06
	set la              [lindex $maintainer 22];#rom02
	set lb              [lindex $maintainer 23];#rom02
        set lc              [lindex $maintainer 24];#rom02
	set ld              [lindex $maintainer 25];#rom02
	set le              [lindex $maintainer 26];#rom02
	set lf              [lindex $maintainer 27];#rom02
	set lg              [lindex $maintainer 28];#rom02

	if {[string equal $flag_ruolo "1"]} {
	    set flag_ruolo "M"
	} elseif {[string equal $flag_ruolo "0"]} {
	    set flag_ruolo "I"
	} elseif {[string equal $flag_ruolo "2"]} {
	    set flag_ruolo "T"
	} elseif {[string equal $flag_ruolo "3"]} {;#sim05 if e suo contenuto
            set flag_ruolo "E"
        } elseif {[string equal $flag_ruolo "4"]} {;#sim05 if e suo contenuto
            set flag_ruolo "L"
        } elseif {[string equal $flag_ruolo "5"]} {;#rom16 if e suo contenuto
            set flag_ruolo "B"
        }

	#rom06 Limito la variabile da 15 a 20 caratteri.
	if {[string length $reg_imprese] > 20} {
	    set reg_imprese [string range $reg_imprese 0 19]
	}

        ns_log notice "\n ... aggiorno manutentore $cod_manutentore su dbn=$dbn"
        puts $fd "... aggiorno manutentore $cod_manutentore su dbn=$dbn"
        puts $fd $maintainer

	db_dml -dbn $dbn instance_upd "
            update coimmanu set 
                cognome = :cognome
              , indirizzo = :indirizzo
              , localita = :localita
              , provincia = :provincia
              , cap = :cap
              , comune = :comune
              , cod_fiscale = :cod_fiscale
              , cod_piva = :cod_piva
              , telefono = :telefono
              , cellulare = :cellulare
              , fax = :fax
              , email = :email
              , reg_imprese = :reg_imprese
              , localita_reg = :localita_reg
              , rea = :rea
              , localita_rea = :localita_rea
              , capit_sociale = :capit_sociale
              , flag_ruolo = :flag_ruolo 
              , pec        = :pec -- nic02
              , patentino  = :patentino --sim02
              , patentino_fgas = :patentino_fgas --sim06
              , flag_a = :la --rom02
              , flag_b = :lb --rom02
              , flag_c = :lc --rom02
              , flag_d = :ld --rom02
              , flag_e = :le --rom02
              , flag_f = :lf --rom02
              , flag_g = :lg --rom02
            where cod_manutentore = :cod_manutentore"
	
	db_dml -dbn $dbn coimtpin_manu_dlt "
            delete from coimtpin_manu 
             where cod_manutentore = :cod_manutentore";#rom01
	
	set ls_maintainer_installations [db_list_of_lists maintainer_installations "
                select maintainer_installations_id
                     , :cod_manutentore
                     , installation_type_code 
                     , 'batch'      as creation_user
                     , current_date as creation_date
                  from iter_maintainer_installations m
                     , iter_installation_types t
                     , iter_maintainers i
                 where i.iter_code = :cod_manutentore
                   and t.installation_type_id = m.installation_type_id
                   and i.maintainer_id = m.maintainer_id
              order by maintainer_installations_id"];#rom01

	append maintainer_installations " $ls_maintainer_installations"

	set ls_tools [db_list_of_lists  tools "
          select tool_id
               , :cod_manutentore
               , type
               , brand
               , model
               , no
               , last_calibration_date
               , m.is_active_p --rom08 
            from iter_tools m
               , iter_maintainers i
           where i.iter_code = :cod_manutentore
             and i.maintainer_id = m.maintainer_id
             and brand is not null"]

	append tools " $ls_tools"	

	#pulisco gli strumenti mai utilizzati
	db_dml -dbn $dbn q "delete from coimstru_manu 
               where cod_manutentore = :cod_manutentore 
                 and cod_strumento not in (select cod_strumento_01 from coimdimp)
                 and cod_strumento not in (select cod_strumento_02 from coimdimp)"

	
	iter::iter_tools_new -dbn $dbn -tools $tools
	
	#ric03 lista deleghe
	set ls_delegations [db_list_of_lists delegations "
            select d.delegation_id
                 , m.iter_code as cod_manutentore
                 , o.iter_code as cod_manutentore_inst     
                 , d.start_date      
                 , d.end_date        
                 , delegation_state
                 , d.creation_date   
                 , d.creation_user   
                 , d.edit_date       
                 , d.edit_user       
              from iter_maintainer_delegations d
                 , iter_maintainers m
                 , iter_maintainers o
             where d.maintainer_id = m.maintainer_id 
               and d.delegato_id   = o.maintainer_id
               and m.iter_code     = :cod_manutentore"]

	append delegations " $ls_delegations"

	db_dml -dbn $dbn q "delete from coimdele where cod_manutentore = :cod_manutentore"

	iter::iter_delegation_new -dbn $dbn -delegations $delegations;#ric03
	
    }

    iter::maintainer_installations_new -dbn $dbn -maintainers_installations $maintainer_installations

    
    close $fd

    return 0
}

ad_proc -private iter::operators_update {
    -dbn
    -operators
} {
    Aggiorna gli operatori della lista 'operators' nel database 'dbn'.
} {

    set fd [open [ah::package_root -package_key iter-portal]/iter-update.log a]

    foreach operator $operators {
ns_log Notice "simone -$operator-"
	set cod_opma        [lindex $operator 0]
	set cod_manutentore [string range $cod_opma 0 7]
	set cognome         [lindex $operator 1]
	set nome            [lindex $operator 2]
	set matricola       [lindex $operator 3]
	set codice_fiscale  [lindex $operator 4]
	set telefono        [lindex $operator 5]
	set cellulare       [lindex $operator 6]
	set recapito        [lindex $operator 7]
	set note            [lindex $operator 8]
	set password        [lindex $operator 9]
	set is_active_p     [lindex $operator 10]
	#lindex $operator 11] è operator_id che non ci serve
        set patentino       [lindex $operator 12]         ;#gac01
        set patentino_fgas  [lindex $operator 13]         ;#gac01
	set email_operator  [lindex $operator 14]         ;#but01
	set abilitazione_giuridica_p [lindex $operator 15];#ric02
	if {[db_0or1row -dbn $dbn query "select 1 from coimopma where cod_opma = :cod_opma"]} {

            ns_log notice "\n ... aggiorno operatore $cod_opma su dbn=$dbn"
            puts $fd "... aggiorno operatore $cod_opma su dbn=$dbn"
            puts $fd $operator

	    if {$is_active_p} {#sim08 if else e loro contenuto
		#stato attivo su iter
		set stato 0
	    } else {
		#stato non attivo su iter
		set stato 1
	    }	    

	    db_dml -dbn $dbn iter_operator-upd "
                update coimopma set 
                    cognome = :cognome
                  , nome = :nome
                  , matricola = :matricola
                  , codice_fiscale = :codice_fiscale
                  , telefono = :telefono
                  , cellulare = :cellulare
                  , recapito = :recapito
                  , note = :note
                  , patentino = :patentino                 --gac01
                  , patentino_fgas = :patentino_fgas       --gac01
                  , stato = :stato  --sim08 
                  , email_operator = :email_operator     --but01
                  , abilitazione_giuridica_p = :abilitazione_giuridica_p --ric02
                where cod_opma = :cod_opma"
	} else {

            ns_log notice "\n ... inserisco operatore $cod_opma su dbn=$dbn"
            puts $fd "... inserisco operatore $cod_opma su dbn=$dbn"
            puts $fd $operator
	    #ric02 aggiunto abilitazione_giuridica_p
	    #gac01 aggiunti campi patentino e patentino_fgas
	    #but01 aggiunto il campo email_operator
	    db_dml -dbn $dbn iter_operator_insert "
                insert into coimopma (
                    cod_opma, cod_manutentore, cognome, nome, matricola, codice_fiscale, telefono, cellulare, recapito, note, patentino, patentino_fgas, email_operator, abilitazione_giuridica_p
                ) values (
                   :cod_opma, :cod_manutentore, :cognome, :nome, :matricola, :codice_fiscale, :telefono, :cellulare, :recapito, :note, :patentino, :patentino_fgas, :email_operator, :abilitazione_giuridica_p
                )"

            ns_log notice "\n ... inserisco utente $cod_opma su dbn=$dbn"
            puts $fd "... inserisco utente $cod_opma su dbn=$dbn"

	    set salt     [sec_random_token];#ric01
	    #rom10set password [ns_md string $password$salt];#ric01
	    set password [ns_md string -digest "sha256" $password$salt];#rom10
	    #but01 modificato il valore del campo e_mail dal '.' al $email_operator.
	    db_dml -dbn $dbn insert_user "
                insert into coimuten (
                    id_utente, cognome, nome, password, id_settore, id_ruolo, lingua, e_mail, rows_per_page, data, livello
                    , salt             --ric01
                    , is_first_login_p --ric01
                    , codice_fiscale   --rom15
                ) values (
                    :cod_opma, substr(:cognome, 1, 40), substr(:nome, 1, 40), :password, 'ente', 'manutentore', 'it', coalesce(:email_operator,'.'), 30, current_date, 5
		    , :salt            --ric01
                    , 't'              --ric01
                    , :codice_fiscale  --rom15	
                )"
	}

	if {$is_active_p} {

	    db_dml -dbn $dbn q "
                update coimopma
                    set stato = 0
                where cod_opma = :cod_opma";#rom16

 	    db_dml -dbn $dbn iter_user_upd5 "
                update coimuten set 
                    livello = 5
                  , cognome = substr(:cognome, 1, 40)
                  , nome    = substr(:nome, 1, 40)
                  , e_mail  = coalesce(:email_operator,'.')  --but01 
                  , codice_fiscale = :codice_fiscale         --rom15
                where id_utente = :cod_opma"
	} else {

	    db_dml -dbn $dbn q "
                update coimopma
                    set stato = 1
                where cod_opma = :cod_opma";#rom16

	    db_dml -dbn $dbn iter_user_upd0 "
                update coimuten set 
                    livello = 0
                  , cognome = substr(:cognome, 1, 40)
                  , nome    = substr(:nome, 1, 40)
                --  , e_mail  = coalesce(:email_operator,'.')  --but01 
                where id_utente = :cod_opma"
	}

    }

    close $fd

    return 0
}

ad_proc -private iter::representatives_update {
    -dbn
    -representatives
    -from_date
    -to_date
} {
    Aggiorna i rappresentanti legali della lista 'representatives' nel database 'dbn'.
} {
    # nic01: ho aggiunto i parametri obbligatori -from_date e -to_date

    set fd [open [ah::package_root -package_key iter-portal]/iter-update.log a]

    foreach representative $representatives {

	set cod_manutentore [lindex $representative 0]
	set cognome         [string trim [lindex $representative 1]]
	set nome            [string trim [lindex $representative 2]]
	set indirizzo       [string trim [lindex $representative 3]]
	set indirizzo       [string range $indirizzo 0 39]
	set comune          [string trim [lindex $representative 4]]
	set localita        [string trim [lindex $representative 5]]
	set provincia       [lindex $representative 6]
	set cap             [lindex $representative 7]
	set cod_fiscale     [lindex $representative 8]
	set maintainer_id   [lindex $representative 9];#nic01
        set patentino       [lindex $representative 10]   ;#gac01
        set patentino_fgas  [lindex $representative 11]   ;#gac01
        ns_log notice "... leggo manutentore $cod_manutentore per aggiornare poi RL"

	db_1row -dbn $dbn query "select cod_legale_rapp as cod_cittadino from coimmanu where cod_manutentore = :cod_manutentore"

	# Verifico se nel periodo è stato effettuato o meno un cambio di rappresentante legale
	if {![db_0or1row sel_test_cambio "
             select end_date
               from iter_hist_representatives
              where maintainer_id                  = :maintainer_id
                and creation_timestamp::date between :from_date 
                                                 and :to_date
              limit 1"]
	} {;#nic01
	    # se non è stato fatto un cambio di rappresentante legale, aggiorno semplicemente
            # i dati della coimcitt (come prima delle modifiche nic01)

	    ns_log notice "\n ... aggiorno rappresentante legale $cod_cittadino su dbn=$dbn"
	    puts $fd "... aggiorno rappresentante legale $cod_cittadino su dbn=$dbn"
	    puts $fd $representative
	    
	    db_dml -dbn $dbn iter_representative_upd "
            update coimcitt set 
                cognome = :cognome
              , nome = :nome
              , indirizzo = :indirizzo
              , cap = :cap
              , localita = :localita
              , comune = :comune
              , provincia = :provincia
              , cod_fiscale = :cod_fiscale 
              , patentino = :patentino             --gac01
              , patentino_fgas = :patentino_fgas   --gac01
            where cod_cittadino = :cod_cittadino"
	} else {;#nic01: aggiunto tutto questo blocco
	    # Se è stato fatto un cambio di rappresentante legale, devo fare queste operazioni.

	    set old_cod_legale_rapp $cod_cittadino

	    # Per prima cosa, verifico se esiste già un altro record di coimcitt con lo
            # stesso codice fiscale, cognome e nome.
            if {[db_0or1row -dbn $dbn sel_coimcitt "
                 select cod_cittadino
                   from coimcitt
                   where upper(trim(cod_fiscale)) = upper(trim(:cod_fiscale))
                    and upper(trim(cognome))     = upper(trim(:cognome))
                    and upper(trim(nome))        = upper(trim(:nome))
               order by cod_cittadino desc
                  limit 1"]
            } {
                # in questo caso, modifico gli altri dati del soggetto
		ns_log Notice "iter::representatives_update;aggiorno coimcitt con cod_cittadino = $cod_cittadino su dbn = $dbn"
		puts $fd "Aggiorno coimcitt con cod_cittadino = $cod_cittadino su dbn=$dbn"
		puts $fd $representative
	    
		db_dml -dbn $dbn upd_coimcitt "
                update coimcitt
                   set cognome       = :cognome
                     , nome          = :nome
                     , indirizzo     = :indirizzo
                     , cap           = :cap
                     , localita      = :localita
                     , comune        = :comune
                     , provincia     = :provincia
                     , cod_fiscale   = :cod_fiscale 
                     , patentino = :patentino             --gac01
                     , patentino_fgas = :patentino_fgas   --gac01
                 where cod_cittadino = :cod_cittadino"
	    } else {
		# in questo caso, inserisco un nuovo soggetto:

		db_1row -dbn $dbn sel_next_cod_citt "select nextval('coimcitt_s') as cod_cittadino"

		ns_log Notice "iter::representatives_update;Inserisco coimcitt con cod_cittadino = $cod_cittadino su dbn=$dbn" 
		puts $fd "Inserisco coimcitt con cod_cittadino = $cod_cittadino su dbn=$dbn" 
		puts $fd $representative

		db_dml -dbn $dbn iter_citta_new "
                insert into coimcitt ( 
                       cod_cittadino
                     , natura_giuridica
                     , cognome
                     , nome
                     , indirizzo
                     , cap
                     , localita
                     , comune
                     , provincia
                     , cod_fiscale
                     , data_ins
                     , patentino
                     , patentino_fgas
                ) values (
                      :cod_cittadino
                     ,'F'
                     ,upper(:cognome)
                     ,upper(:nome)
                     ,upper(:indirizzo)
                     ,:cap
                     ,upper(:localita)
                     ,upper(:comune)
                     ,upper(:provincia)
                     ,upper(:cod_fiscale)
                     ,current_date
                     ,:patentino             --gac01
                     ,:patentino_fgas        --gac01
                 )"
	    }

	    if {$cod_cittadino != $old_cod_legale_rapp} {
		# Storicizzo il vecchio rappresentante legale del manutentore

		# Non posso inserire sullo storico due record con la stessa data di fine
		# validità: prima devo leggere se esiste già.
		set data_fin_valid $end_date
		if {[db_0or1row -dbn $dbn sel_coimstrl "
                     select cod_strl
                       from coimstrl
                      where cod_manutentore = :cod_manutentore
                        and data_fin_valid  = :data_fin_valid"]
		} {
		    # Se esiste già, non faccio niente perchè così rimane nello storico quello
		    # che era in vigore fino a quella data di fine validità
		} else {
		    # In questo caso, inserisco il record

		    db_1row -dbn $dbn sel_max_cod_strl "
                    select coalesce(max(cod_strl),0) + 1 as cod_strl
                      from coimstrl"

		    set cod_soggetto $old_cod_legale_rapp
		    ns_log Notice "iter::representatives_update;Inserisco coimstrl con cod_strl = $cod_strl su dbn=$dbn (cod_manutentore = $cod_manutentore, data_fin_valid = $data_fin_valid, cod_soggetto = $cod_soggetto)" 
		    puts $fd "Inserisco coimstrl con cod_strl = $cod_strl su dbn=$dbn (cod_manutentore = $cod_manutentore, data_fin_valid = $data_fin_valid, cod_soggetto = $cod_soggetto)" 

		    db_dml -dbn $dbn ins_coimstrl "
                    insert
                      into coimstrl
                         ( cod_strl        
                         , cod_manutentore 
                         , data_fin_valid  
                         , cod_soggetto    
                         , timestamp_ins   
                         )
                  values (:cod_strl
                         ,:cod_manutentore
                         ,:data_fin_valid
                         ,:cod_soggetto
                         , current_timestamp
                         )"
		}

		ns_log Notice "iter::representatives_update;aggiorno coimmanu con cod_manutentore = $cod_manutentore cambiando il cod_legale rapp con $cod_cittadino su dbn = $dbn"
		puts $fd "aggiorno coimmanu con cod_manutentore = $cod_manutentore cambiando il cod_legale rapp con $cod_cittadino su dbn = $dbn"

		db_dml -dbn $dbn upd_coimmanu "
                update coimmanu
                   set cod_legale_rapp = :cod_cittadino 
                     , data_mod        = current_date
                 where cod_manutentore = :cod_manutentore"

		# Cerco tutti gli impianti in cui old_cod_legale_rapp era responsabile
		set list_cod_impianto [db_list -dbn $dbn sel_coimaimp "
                select cod_impianto
                  from coimaimp
                 where cod_responsabile = :old_cod_legale_rapp
                   and flag_resp        = 'T' -- terzo
		   and stato            = 'A' -- attivo"]

		foreach cod_impianto $list_cod_impianto {
		    # per prima cosa, storicizzo il responsabile originale sulla coimrife

		    set ruolo "T"
		    # Prima controllo se esiste già il record:
		    if {[db_0or1row -dbn $dbn sel_rife "
                         select '1'
                           from coimrife
                          where cod_impianto    = :cod_impianto
                            and ruolo           = :ruolo
                            and data_fin_valid  = :data_fin_valid"]
		    } {
			# Se esiste già, non faccio niente perchè così rimane nello storico
			# quello che era in vigore fino a quella data di fine validità
		    } else {
			# In questo caso, inserisco il record
			set cod_soggetto $old_cod_legale_rapp
			ns_log Notice "iter::representatives_update;Inserisco coimrife con cod_impianto = $cod_impianto, data_fin_valid = $data_fin_valid e cod_soggetto = $cod_soggetto su dbn=$dbn" 
			puts $fd "Inserisco coimrife con cod_impianto = $cod_impianto, data_fin_valid = $data_fin_valid e cod_soggetto = $cod_soggetto su dbn=$dbn"

			db_dml -dbn $dbn ins_coimrife "
                        insert
                          into coimrife
                             ( cod_impianto
                             , ruolo
                             , data_fin_valid
                             , cod_soggetto
                             , data_ins
                             )
                      values (:cod_impianto
                             ,:ruolo
                             ,:data_fin_valid
                             ,:cod_soggetto
                             , current_date
                             )"
		    }

		    # Ora aggiorno il responsabile della coimaimp
		    set cod_responsabile $cod_cittadino

		    ns_log Notice "iter::representatives_update;Aggiorno coimaimp con cod_impianto = $cod_impianto cambiando cod_responsabile con $cod_responsabile su dbn=$dbn" 
		    puts $fd "Aggiorno coimaimp con cod_impianto = $cod_impianto cambiando cod_responsabile con $cod_responsabile su dbn=$dbn"

		    db_dml -dbn $dbn upd_coimaimp "
                    update coimaimp
                       set cod_responsabile = :cod_responsabile
                         , data_mod         = current_date -- concordato con Sandro
                --rom16  , utente           = null         -- concordato con Sandro
                         , utente           = 'batch'     --rom16
                     where cod_impianto     = :cod_impianto"
		}
		
	    }

	};#nic01
    }

    close $fd

    return 0
}


ad_proc -private iter::trustees_update {
    -dbn
    -trustees
} {
    Aggiorna gli amministratori della lista 'trustees' nel database 'dbn'.
} {

    set fd [open [ah::package_root -package_key iter-portal]/iter-update.log a]

    foreach trustee $trustees {

	set cod_cittadino     [lindex $trustee 0]
	set cognome           [string trim [lindex $trustee 1]]
	set cognome_uten      [string range $cognome 0 39]
	set nome              [string trim [lindex $trustee 2]]
	set nome_uten         [string range $nome 0 39]
        if {$nome_uten eq ""} {
	    set nome_uten "-"  ; # mi cautelo in caso di nome nullo
	}
	set indirizzo         [string trim [lindex $trustee 3]]
	set indirizzo         [string range $indirizzo 0 39]
	set comune            [string trim [lindex $trustee 4]]
	set localita          [string trim [lindex $trustee 5]]
	set provincia         [lindex $trustee 6]
	set cap               [lindex $trustee 7]
	set cod_fiscale       [lindex $trustee 8]
	set cod_piva          [lindex $trustee 9]
	set telefono          [lindex $trustee 10]
	set telefono          [string range $telefono 0 14]
	set cellulare         [lindex $trustee 11]
	set cellulare         [string range $cellulare 0 14]
	set fax               [lindex $trustee 12]
	set fax               [string range $fax 0 14]
	set email             [lindex $trustee 13]
	set email             [string range $email 0 34]
	set natura_giuridica  [lindex $trustee 14]
	set password          [lindex $trustee 15]

        ns_log notice "\n ... aggiorno amministratore $cod_cittadino su dbn=$dbn"
        puts $fd "... aggiorno amministratore $cod_cittadino su dbn=$dbn"
        puts $fd $trustee

        db_dml -dbn $dbn iter_citta_upd "
            update coimcitt set 
                natura_giuridica = :natura_giuridica
              , cognome          = :cognome
              , nome             = :nome_uten
              , indirizzo        = :indirizzo
              , cap              = :cap
              , localita         = :localita
              , comune           = :comune
              , provincia        = :provincia
              , cod_fiscale      = :cod_fiscale
              , cod_piva         = :cod_piva
              , telefono         = :telefono
              , cellulare        = :cellulare
              , fax              = :fax
              , email            = :email
              , data_mod         = current_date
            where cod_cittadino = :cod_cittadino"

        ns_log notice "\n ... aggiorno utente $cod_cittadino su dbn=$dbn"
        puts $fd "... aggiorno utente $cod_cittadino su dbn=$dbn"

        db_dml -dbn $dbn iter_user_upd "
            update coimuten set
                cognome = substr(:cognome, 1, 40)
              , nome    = substr(:nome_uten, 1, 40)
              , e_mail  = :email
              , codice_fiscale = :cod_fiscale --rom15
            where id_utente = :cod_cittadino"

    }

    close $fd

    return 0
}

ad_proc -private iter::notify_maintainer_with_cait {
    -maintainer_id
    -cait_id
} {
    Notifica un manutentore associato ad un CAIT
} {

    set email_from [parameter::get_from_package_key -package_key iter-portal -parameter email_from];#sim04

    db_1row query "select * from iter_maintainers where maintainer_id = :maintainer_id"

    db_1row query "select name as cait_name, email as cait_email from iter_cait where cait_id = :cait_id"

    set mail_text "Spett.le $cait_name,\n\nLa registrazione al portale del Catasto Unico degli Impianti Termici del manutentore $name è stata completata con successo.\n\nGli utenti e le password assegnate agli operatori dichiarati sono le seguenti:\n\n"

    set ops [db_list_of_lists query "
                select operator_id, name, first_name, iter_no, password 
                from iter_operators 
                where maintainer_id = :maintainer_id 
                order by operator_id"]

    foreach op $ops {

	#rom17 util_unlist $op operator_id name first_name iter_no password
	lassign $op operator_id name first_name iter_no password

	append mail_text "$name $first_name : $iter_no - $password\n"

	#ric01 appena ho composto la email vado a pulire il campo password
	db_dml q "update iter_operators
                     set password = null
                   where operator_id = :operator_id";#ric01
    }

    set db_name [db_get_database];#mat01
    if {[string match "*ucit*" $db_name]} { #mat01 aggiunto if e contenuto

	append mail_text "\n\nPer la convalida del profilo devono essere inviati all’indirizzo assistenzacrit@fvgenergia.it la visura camerale in corso di validità, il certificato di taratura dello strumento analizzatore e copia dei patentini."
    }
    
    acs_mail_lite::send -from_addr $email_from -to_addr $cait_email -subject "Registrazione di $name completata" -body $mail_text;#sim04
    ns_log notice "LUCAR: notify_maintainer_with_cait inviata mail da $email_from a $email per registrazione nuovo CAIT"
    
#sim04    acs_mail_lite::send -from_addr "xxxxxxx" -to_addr $cait_email -subject "Registrazione di $name completata" -body $mail_text

}

ad_proc -private iter::notify_maintainer {
    -maintainer_id
} {
    Notifica un manutentore indipendente
} {

    set email_from [parameter::get_from_package_key -package_key iter-portal -parameter email_from];#sim04
    set email_indirizzo_portale [parameter::get_from_package_key -package_key iter-portal -parameter email_indirizzo_portale];#sim04

    db_1row query "select * from iter_maintainers where maintainer_id = :maintainer_id"

    set db_name [db_get_database];#rom04
	
    set mail_text "Spett.le $name,\n\nLa registrazione al portale del Catasto Unico degli Impianti Termici è stata completata con successo.\n\nGli utenti e le password assegnate agli operatori dichiarati sono le seguenti:\n\n"

    set ops [db_list_of_lists query "
            select operator_id, name, first_name, iter_no, password 
            from iter_operators 
            where maintainer_id = :maintainer_id 
            order by operator_id"]

    foreach op $ops {

	#rom17 util_unlist $op operator_id name first_name iter_no password
	lassign $op operator_id name first_name iter_no password

	#rom04append mail_text "$name $first_name : $iter_no - $password\n"
	append mail_text "$name $first_name : codice utente (userid): $iter_no - password $password\n";#rom04

	#ric01 appena ho composto la email vado a pulire il campo password
	db_dml q "update iter_operators
                     set password = null
                   where operator_id = :operator_id";#ric01
    }

    if {[string match "*iter-portal-marche*" $db_name]} {#rom01 Aggiunta if e il suo contenuto.

	    append mail_text "\n\nCon questi utenti e queste password sarà possibile accedere al Menù Gestione Impianti per inserire i modelli  RCEE ed operare su tutte le funzionalità a cui si è abilitati.\n\nSarà cura dell'operatore stesso, dopo il primo accesso, cambiarsi la password.\n\nI passi operativi sono i seguenti:\n\n   1. Sul portale $email_indirizzo_portale accedere ai servizi come \"altro operatore\" ed inserire email e password nei campi \"Login Ditta Manutenzione...\"\n   2. Nella pagina \"Servizi per i manutentori...\" cliccare sul link \"Accedi al menù Gestione Impianti...\".\n   3. Selezionare l'ente su cui si vuole lavorare\n   4. Digitare codice utente (userid) e password\n   5. Dal menù Gestione impianti si può acquisire, inserire o ricercare un impianto, compilare, aggiornare e stampare il libretto, trasmettere a catasto la modulistica (RCEE, ecc.), ecc.\n\nIn alternativa, per accedere al menù Gestione impianti è possibile andare sul portale $email_indirizzo_portale , accedere ai servizi come \"altro operatore\" ed inserire nei campi \"Login Operatore...\" codice utente e password appena forniti, selezionando quindi l'ente su cui lavorare.\n\nIl manuale operativo per i manutentori si trova nel menù Gestione Impianti, sottomenù \"Impianti\", alla voce \"Manuali\".\n\nPer eventuali comunicazioni, non utlizzare il presente indirizzo email ma scrivere a energia@regione.marche.it"

    } else {#rom04 Aggiunta else ma non il suo contenuto.

	append mail_text "\n\nCon questi utenti e queste password sarà possibile accedere al programma I.Ter per inserire i modelli  RCEE ed operare su tutte le funzionalità a cui si è abilitati.\n\nSarà cura dell'operatore stesso, dopo il primo accesso, cambiarsi la password.\n\nI passi operativi sono i seguenti:\n\n   1.Andare sul portale $email_indirizzo_portale nei servizi riservati ai manutentori\n   2.Cliccare sul link 'Accesso ad I.Ter'.\n   3.Selezionare l'ente su cui si vuole lavorare\n   4.Digitare user e password\n   5.Registrare i modelli\n\nIl manuale operativo di I.Ter per i manutentori è in linea nella home page del sito nella sezione \"Documentazione\"."

    }

    if {[string match "*ucit*" $db_name]} { #mat01 aggiunto if e contenuto

        append mail_text "\n\nPer la convalida del profilo devono essere inviati all’indirizzo assistenzacrit@fvgenergia.it la visura camerale in corso di validità, il certificato di taratura dello strumento analizzatore e copia dei patentini."
    }
    
    acs_mail_lite::send -from_addr $email_from -to_addr $email -subject "Registrazione completata" -body $mail_text
    ns_log notice "LUCAR: notify_maintainer inviata mail da $email_from a $email per registrazione ditta"
    
#sim04    acs_mail_lite::send -from_addr "xxxxxxx" -to_addr $email -subject "Registrazione completata" -body $mail_text

}

ad_proc -private iter::notify_maintainer_upd {
    -maintainer_id
} {
    Notifica alle Ditte di manutenzione per aggiunta operatori aggiuntivi.
} {

    ns_log notice "LUCAR: INIZIO notify_maintainer_upd $maintainer_id"
    
    set email_from [parameter::get_from_package_key -package_key iter-portal -parameter email_from]
    set email_indirizzo_portale [parameter::get_from_package_key -package_key iter-portal -parameter email_indirizzo_portale]

    db_1row query "select * from iter_maintainers where maintainer_id = :maintainer_id"

    set db_name [db_get_database]
	
    set mail_text "Spett.le $name,\n\nLa registrazione al portale del Catasto Unico degli Impianti Termici è stata completata con successo.\n\nGli utenti e le password assegnate agli operatori dichiarati sono le seguenti:\n\n"

    set ops [db_list_of_lists query "
            select operator_id, name, first_name, iter_no, password 
            from iter_operators 
            where maintainer_id = :maintainer_id 
              and password is not null
            order by operator_id"]

    foreach op $ops {

	#rom17 util_unlist $op operator_id name first_name iter_no password
	lassign $op operator_id name first_name iter_no password

	ns_log notice "LUCAR: notify_maintainer_upd operatore $operator_id $name $first_name $iter_no"
	append mail_text "$name $first_name : codice utente (userid): $iter_no - password $password\n"

	#ric01 appena ho composto la email vado a pulire il campo password
	db_dml q "update iter_operators
                     set password = null
                   where operator_id = :operator_id";#ric01
    }

    if {[string match "*iter-portal-marche*" $db_name]} {

	    append mail_text "\n\nCon questi utenti e queste password sarà possibile accedere al Menù Gestione Impianti per inserire i modelli  RCEE ed operare su tutte le funzionalità a cui si è abilitati.\n\nSarà cura dell'operatore stesso, dopo il primo accesso, cambiarsi la password.\n\nI passi operativi sono i seguenti:\n\n   1. Sul portale $email_indirizzo_portale accedere ai servizi come \"altro operatore\" ed inserire email e password nei campi \"Login Ditta Manutenzione...\"\n   2. Nella pagina \"Servizi per i manutentori...\" cliccare sul link \"Accedi al menù Gestione Impianti...\".\n   3. Selezionare l'ente su cui si vuole lavorare\n   4. Digitare codice utente (userid) e password\n   5. Dal menù Gestione impianti si può acquisire, inserire o ricercare un impianto, compilare, aggiornare e stampare il libretto, trasmettere a catasto la modulistica (RCEE, ecc.), ecc.\n\nIn alternativa, per accedere al menù Gestione impianti è possibile andare sul portale $email_indirizzo_portale , accedere ai servizi come \"altro operatore\" ed inserire nei campi \"Login Operatore...\" codice utente e password appena forniti, selezionando quindi l'ente su cui lavorare.\n\nIl manuale operativo per i manutentori si trova nel menù Gestione Impianti, sottomenù \"Impianti\", alla voce \"Manuali\".\n\nPer eventuali comunicazioni, non utlizzare il presente indirizzo email ma scrivere a energia@regione.marche.it"

    } else {#rom04 Aggiunta else ma non il suo contenuto.

	append mail_text "\n\nCon questi utenti e queste password sarà possibile accedere al programma I.Ter per inserire i modelli  RCEE ed operare su tutte le funzionalità a cui si è abilitati.\n\nSarà cura dell'operatore stesso, dopo il primo accesso, cambiarsi la password.\n\nI passi operativi sono i seguenti:\n\n   1.Andare sul portale $email_indirizzo_portale nei servizi riservati ai manutentori\n   2.Cliccare sul link 'Accesso ad I.Ter'.\n   3.Selezionare l'ente su cui si vuole lavorare\n   4.Digitare user e password\n   5.Registrare i modelli\n\nIl manuale operativo di I.Ter per i manutentori è in linea nella home page del sito nella sezione \"Documentazione\"."

    }

    if {[string match "*ucit*" $db_name]} { #mat01 aggiunto if e contenuto

        append mail_text "\n\nPer la convalida del profilo devono essere inviati all’indirizzo assistenzacrit@fvgenergia.it la visura camerale in corso di validità, il certificato di taratura dello strumento analizzatore e copia dei patentini."
    }
    acs_mail_lite::send -from_addr $email_from -to_addr $email -subject "Registrazione completata" -body $mail_text
    ns_log notice "LUCAR: notify_maintainer_upd inviata mail da $email_from a $email per registrazione nuovo operatore $name $first_name : codice utente (userid): $iter_no"
    
}

ad_proc -private iter::notify_trustee {
    -trustee_id
} {
    Notifica un amministratore
} {

    set email_from [parameter::get_from_package_key -package_key iter-portal -parameter email_from];#sim04
    set email_indirizzo_portale [parameter::get_from_package_key -package_key iter-portal -parameter email_indirizzo_portale];#sim04

    db_1row query "
        select * 
        from iter_trustees 
        where trustee_id = :trustee_id"

    set mail_text "Spett.le $name $first_name,\n\nLa registrazione al portale del Catasto Unico degli Impianti Termici è stata completata con successo.\n\nL'utente assegnato è $iter_code e la password è $password.\n\n"

    append mail_text "\nCon questo utente e questa password sarà possibile accedere al programma I.Ter per inserire i modelli  RCEE ed operare su tutte le funzionalità a cui si è abilitati.\n\nSarà Vs. cura, dopo il primo accesso, cambiare la password.\n\nI passi operativi sono i seguenti:\n\n   1.Andare sul portale $email_indirizzo_portale nei servizi riservati agli Amministratori di Condominio\n   2.Cliccare sul link 'Accesso ad I.Ter'.\n   3.Selezionare l'ente su cui si vuole lavorare\n   4.Digitare user e password\n   5.Registrare i modelli\n\nPer gli Amministratori di Condominio, il manuale operativo di I.Ter da utilizzare è quello dei manutentori ed è in linea nella home page del sito nella sezione \"Documentazione\"."
    
    #ric01 appena ho composto la email vado a pulire il campo password
    db_dml q "update iter_trustees
                 set password = null
               where trustee_id = :trustee_id";#ric01
    
    acs_mail_lite::send -from_addr $email_from -to_addr $email -subject "Registrazione completata" -body $mail_text;#sim04

#sim04    acs_mail_lite::send -from_addr "xxxxxxx" -to_addr $email -subject "Registrazione completata" -body $mail_text

}

ad_proc -private iter::notify_trustee_with_office {
    -trustee_id
    -office_id
} {
    Notifica un amministratore associato ad un CAIT
} {

    set email_from [parameter::get_from_package_key -package_key iter-portal -parameter email_from];#sim04

    db_1row query "select * from iter_trustees where trustee_id = :trustee_id"

    db_1row query "select name as office_name, email as office_email from iter_offices where office_id = :office_id"

    set mail_text "Spett.le $office_name,\n\nLa registrazione al portale del Catasto Unico degli Impianti Termici dell'amministratore $name è stata completata con successo.\n\nL'utente assegnato è $iter_code e la password è $password.\n\n"

    acs_mail_lite::send -from_addr $email_from -to_addr $office_email -subject "Registrazione di $name completata" -body $mail_text;#sim04

    #ric01 appena ho composto la email vado a pulire il campo password
    db_dml q "update iter_trustees
                 set password = null
               where trustee_id = :trustee_id";#ric01

#sim04    acs_mail_lite::send -from_addr "xxxxxxx" -to_addr $office_email -subject "Registrazione di $name completata" -body $mail_text

}

ad_proc -public iter::propaga_bollini {
    {-from_date ""}
    {-to_date ""}
} {
    Propaga nelle varie istanze iter i bollini.
   
    Con from_date e to_date è possibile delimitare il range temporale da prendere in 
    considerazione. Per default si assume la data del giorno precedente.

} {

    set email_from [parameter::get_from_package_key -package_key iter-portal -parameter email_from];#sim04

    # imposto alcune date
    set current_date [ah::today_ansi]
    if {$from_date eq ""} {
	# assumo ieri
	set from_date [db_string query "select current_date - 1"]
    }
    if {$to_date eq ""} {
	# assumo ieri
	set to_date [db_string query "select current_date - 1"]
    }

    set bollini [db_list_of_lists bollini "
        select
            cod_bollini
          , cod_manutentore
          , data_consegna
          , nr_bollini
          , matricola_da
          , matricola_a
          , pagati
          , costo_unitario
          , nr_bollini_resi
          , note
          , data_ins
          , data_mod
          , utente
          , data_scadenza
          , cod_tpbo
          , imp_pagato
          , imp_sconto
          , cod_tpbl
          , cod_fatt
        from coimboll
        where data_ins between :from_date and :to_date
    "]

    set instances [db_list get_instances "select instance_name from iter_instances"]
#    set instances "itercman-dev" ;#IMPORTANTE: da togliere perchè serve solo per i test

    
    
    db_transaction {

	foreach instance $instances {

	    foreach bollino $bollini {
		#rom17 util_unlist $bollino cod_bollini cod_manutentore data_consegna nr_bollini matricola_da matricola_a pagati costo_unitario nr_bollini_resi note data_ins data_mod utente data_scadenza cod_tpbo imp_pagato imp_sconto cod_tpbl cod_fatt
		lassign $bollino cod_bollini cod_manutentore data_consegna nr_bollini matricola_da matricola_a pagati costo_unitario nr_bollini_resi note data_ins data_mod utente data_scadenza cod_tpbo imp_pagato imp_sconto cod_tpbl cod_fatt

	    db_dml -dbn $instance new "
                insert into coimboll (
                    cod_bollini
                  , cod_manutentore
                  , data_consegna
                  , nr_bollini
                  , matricola_da
                  , matricola_a
                  , pagati
                  , costo_unitario
                  , nr_bollini_resi
                  , note
                  , data_ins
                  , data_mod
                  , utente
                  , data_scadenza
                  , cod_tpbo
                  , imp_pagato
                  , imp_sconto
                  , cod_tpbl
                  , cod_fatt
                ) values (
                    nextval('coimboll_s')
                  , :cod_manutentore
                  , :data_consegna
                  , :nr_bollini
                  , :matricola_da
                  , :matricola_a
                  , :pagati
                  , :costo_unitario
                  , :nr_bollini_resi
                  , :note
                  , :data_ins
                  , :data_mod
                  , :utente
                  , :data_scadenza
                  , :cod_tpbo
                  , :imp_pagato
                  , :imp_sconto
                  , :cod_tpbl
                  , :cod_fatt
                )"
	    }

	}

    } on_error {
	ad_log_stack_trace

        acs_mail_lite::send -from_addr $email_from -to_addr xxxxxxx -subject "propaga_bollini" -body "Da: [db_get_database]. Qualcosa è andato storto. L'errore riscontrato è:\n$errmsg \n\nMaggiori dettagli nel file di log."

#sim04        acs_mail_lite::send -from_addr "xxxxxxx" -to_addr xxxxxxx -subject "propaga_bollini" -body "Da: [db_get_database]. Qualcosa è andato storto. L'errore riscontrato è:\n$errmsg \n\nMaggiori dettagli nel file di log."
        ad_script_abort

    }

    acs_mail_lite::send -from_addr $email_from -to_addr xxxxxxx -subject "propaga_bollini" -body "Da: [db_get_database]. Tutto bene.";#sim04

#sim04    acs_mail_lite::send -from_addr "xxxxxxx" -to_addr xxxxxxx -subject "propaga_bollini" -body "Da: [db_get_database]. Tutto bene."
    ns_log notice "\niter::propaga_bollini\nTutto bene."

}

ad_proc -public iter::propaga_bolltrasf {
    {-from_date ""}
    {-to_date ""}
} {
    Propaga nelle varie istanze iter i trasferimenti di bollini.
   
    Con from_date e to_date è possibile delimitare il range temporale da prendere in 
    considerazione. Per default si assume la data del giorno precedente.

} {

    set email_from [parameter::get_from_package_key -package_key iter-portal -parameter email_from];#sim04

    # imposto alcune date
    set current_date [ah::today_ansi]
    if {$from_date eq ""} {
	# assumo ieri
	set from_date [db_string query "select current_date - 1"]
    }
    if {$to_date eq ""} {
	# assumo ieri
	set to_date [db_string query "select current_date - 1"]
    }

    set bollini [db_list_of_lists bollini "
        select
            cod_boap
          , cod_bollini
          , cod_manutentore_da
          , cod_manutentore_a
          , nr_bollini
          , matr_da
          , matr_a
          , note
          , data_ins
          , data_mod
          , utente_ins
          , utente_mod
          , cod_val_spost
        from coimboap
        where data_ins between :from_date and :to_date
    "]

    set instances [db_list get_instances "select instance_name from iter_instances"]
#    set instances "itercman-dev" ;#IMPORTANTE: da togliere perchè serve solo per i test
    
    db_transaction {

	foreach instance $instances {

	    foreach bollino $bollini {
		#rom17 util_unlist $bollino cod_boap cod_bollini cod_manutentore_da cod_manutentore_a nr_bollini matr_da matr_a note data_ins data_mod utente_ins utente_mod cod_val_spost
		lassign $bollino cod_boap cod_bollini cod_manutentore_da cod_manutentore_a nr_bollini matr_da matr_a note data_ins data_mod utente_ins utente_mod cod_val_spost

	    db_dml -dbn $instance new "
                insert into coimboap (
                    cod_boap
                  , cod_bollini
                  , cod_manutentore_da
                  , cod_manutentore_a
                  , nr_bollini
                  , matr_da
                  , matr_a
                  , note
                  , data_ins
                  , data_mod
                  , utente_ins
                  , utente_mod
                  , cod_val_spost
                ) values (
                    nextval('coimboap_s')
                  ,:cod_bollini
                  ,:cod_manutentore_da
                  ,:cod_manutentore_a
                  ,:nr_bollini
                  ,:matr_da
                  ,:matr_a
                  ,:note
                  ,:data_ins
                  ,:data_mod
                  ,:utente_ins
                  ,:utente_mod
                  ,:cod_val_spost
                )"
	    }

	}

    } on_error {
	ad_log_stack_trace
        acs_mail_lite::send -from_addr $email_from -to_addr xxxxxxx -subject "propaga_bolltrasf" -body "Da: [db_get_database]. Qualcosa è andato storto. L'errore riscontrato è:\n$errmsg \n\nMaggiori dettagli nel file di log.";#sim04
#sim04	acs_mail_lite::send -from_addr "xxxxxxx" -to_addr xxxxxxx -subject "propaga_bolltrasf" -body "Da: [db_get_database]. Qualcosa è andato storto. L'errore riscontrato è:\n$errmsg \n\nMaggiori dettagli nel file di log."
        ad_script_abort

    }

    acs_mail_lite::send -from_addr $email_from -to_addr xxxxxxx -subject "propaga_bolltrasfi" -body "Da: [db_get_database]. Tutto bene.";#sim04

#sim04    acs_mail_lite::send -from_addr "xxxxxxx" -to_addr xxxxxxx -subject "propaga_bolltrasfi" -body "Da: [db_get_database]. Tutto bene."
    ns_log notice "\niter::propaga_bolltrasf\nTutto bene."

}

#ric03 aggiunta nuova proc per propagare le deleghe
ad_proc -private iter::iter_delegation_new {
    -dbn
    -delegations
} {
    inserisce i record della tabella iter_maintainer_delegations sulla tabella coimdele nel database 'dbn'.
} {

    set fd [open [ah::package_root -package_key iter-portal]/iter-update.log a]

    ns_log notice "Riccardo100 iter_delegation_new: delegations=$delegations"

    foreach delegation $delegations {

	ns_log notice "Riccardo101 delegation=$delegation"
	
	set delegation_id         [lindex $delegation 0]
	set cod_manutentore       [lindex $delegation 1]
	set cod_manutentore_inst  [lindex $delegation 2]
	set start_date            [lindex $delegation 3]
	set end_date              [lindex $delegation 4]
	set delegation_state      [lindex $delegation 5]
	set creation_date         [lindex $delegation 6]
	set creation_user         [lindex $delegation 7]
	set edit_date             [lindex $delegation 8]
	set edit_user             [lindex $delegation 9]
	
	set ls_deleghe_mod [db_list -dbn $dbn q "select delegation_id
                                                 from coimdele
                                                where cod_manutentore      = :cod_manutentore
                                                  and cod_manutentore_inst = :cod_manutentore_inst
                                                  and start_date           = :start_date
                                                  and end_date             = :end_date
                                                  and delegation_state     = :delegation_state
                                                 -- and edit_date            = :edit_date
                                                 -- and edit_user            = :edit_user 
                                                   "]

	if {[llength $ls_deleghe_mod] >=1} {
	    
	    foreach delega_mod $ls_deleghe_mod {

		puts $fd "... aggiorno delega delegation_id $delegation_id del manutentore $cod_manutentore su dbn=$dbn"
		puts $fd $delegation

		db_dml -dbn $dbn iter_dele_upd "
             update coimdele set cod_manutentore       = :cod_manutentore     
                               , cod_manutentore_inst  = :cod_manutentore_inst
                               , start_date            = :start_date          
                               , end_date              = :end_date            
                               , delegation_state      = :delegation_state         
                               , edit_date             = :edit_date           
                               , edit_user             = :edit_user   
                           where delegation_id = :delegation_id"
	    }
	    
	} else {
	    
	    puts $fd "... inserisco delega delegation_id $delegation_id su dbn=$dbn"
	    puts $fd $delegation
	    
	    set delegation_id_new [db_string  -dbn $dbn q "select coalesce(max(delegation_id::integer),0) +1 from coimdele"]

	    #inserisco solo se nuovo
	    if {![db_0or1row -dbn $dbn q "select 1 
                              from coimdele
                             where cod_manutentore       = :cod_manutentore
                               and cod_manutentore_inst  = :cod_manutentore_inst
                               and start_date            = :start_date
                               and end_date              = :end_date
                               and delegation_state      = :delegation_state
                               and creation_date         = :creation_date
                               and creation_user         = :creation_user"]} {
	
		db_dml -dbn $dbn iter_deleghe_new "
             insert into coimdele
                    ( delegation_id        
                    , cod_manutentore     
                    , cod_manutentore_inst
                    , start_date          
                    , end_date            
                    , delegation_state    
                    , creation_date       
                    , creation_user       
                    , edit_date           
                    , edit_user           
                    ) values ( 
                      :delegation_id_new        
                    , :cod_manutentore     
                    , :cod_manutentore_inst
                    , :start_date          
                    , :end_date            
                    , :delegation_state    
                    , :creation_date       
                    , :creation_user       
                    , null           
                    , null           
                    )"

	    }
	}
    }
    close $fd
    
    return 0
}
#ric03 fine
