ad_library {

    General procs 

    @author claudio.pasolini@comune.mantova.it
    @cvs-id $Id:

    USER  DATA       MODIFICHE
    ===== ========== ==========================================================================
    ric01 11/09/2025 Modificata proc iter::script_init per segnalare la presenza di tecnici senza
    ric01            il titolo giuridico (abilitazione_giuridica_p) valorizzato. ("Nuova richiesta 2025")
    ric01            MEV regione Marche.

    but01 14/06/2023 modificato la proc 'iter_taratura_scaduta' agguinto solo per i strumenti attivi  

    rom03 05/06/2023 Modificata proc iter_taratura_scaduta: la mail va inviata solo se non ci trova in un
    rom03            ambiente di dev o test.

    rom02 14/01/2023 Modificato testo mail su tarataura degli strumenti in base all'ente in cui ci si trova.

    sim06 10/09/2020 Modificato oggetto e testo della email per gli strumenti in scadenza

    sim05 06/05/2020 Per la Regione Marche, la mail delle tarature scadute, deve essere il cc diverso
    sim05            dal mittente e il testo è leggermente diverso.

    rom01 13/04/2019 Siccome il controllo del bit di parita' del cod.fisc. puo' essere
    rom01            raggirato inserendo dei codici falsi come ad esempio "cccccccccccccccc"
    rom01            inserisco un controllo che blocca l'utente se prova a inserire una stringa
    rom01            tutta numerica o tutta alfabetica.
    
    sim04 21/06/2018 Una volta registrato,nel frattempo che viene validato, al manutentore viene
    sim04            proposto il messaggio forviante "Attenzione. Registrazione Incompleta: registrare ancora"
    sim04            Ora, in mancanza di errori, verrà proposto il messaggio "Grazie per aver inserito tutti i 
    sim04            suoi dati. La registrazione sarà al più presto validata"

    sim03 23/11/2017 Gestisco in maniera differente la chiamata per poter usare il wallet anche con https

    sim02 02/05/2017 Per Ancona è stato personalizzato il messaggio post inserimento dei dati.

    sim01 26/10/2016 Parametrizzato l'email di uscita e l'indirizzo del portale che compare nelle email

}

namespace eval iter {}

ad_proc -public iter::verifyfc  {
     -xcodfis
    {-xcontrolla "0"}
} { 
    Verify last char of fiscal code
} {

    set exception_count 0
    set exception_text ""
    set xcodfis [string toupper $xcodfis]


    # pezza temporanea
    if {[string range $xcodfis 0 2] eq "XYZ"} {
	return $xcodfis
    }
    
    if {[string length $xcodfis] != 16} {
	incr exception_count
	append exception_text "<li> Lunghezza del Codice Fiscale Errata"
    } else {
	set x15cf [string range $xcodfis 0 14]
	set car_contr [iter::calc_char_cf -x15cf $x15cf]
	if {$car_contr != [string range $xcodfis 15 15]} {
	    incr exception_count
	    append exception_text "<li> Carattere di Controllo del Codice Fiscale Errato"
	}
    }
    if {[string is digit $xcodfis]} {#rom01 aggiunta if e suo contenuto
	incr exception_count
	append exception_text "<li> Codice Fiscale Errato"
    }
    if {[string is alpha $xcodfis]} {#rom01 aggiunta if e suo contenuto
	incr exception_count
	append exception_text "<li> Codice Fiscale Errato"
    }
    
    if {$exception_count > 0 } {
	if {$xcontrolla == 1} {
	    #visualizzo il messaggio di errore
	    ad_return_complaint $exception_count $exception_text
	}
	return 0
    } else {
	return $xcodfis
    }
    
}

ad_proc -public iter::verifyvc  {
     -xcodfis
    {-xcontrolla "0"}
} { 
    Verify last char of VAT code
} {

    # pezza temporanea
    if {[string range $xcodfis 0 2] eq "123"} {
	return 1
    }

    set exception_count 0
    set exception_text ""
    
    if {[string length $xcodfis] != 11 } {
	incr exception_count
	append exception_text "<li> Lunghezza della Partita IVA Errata"
    } else {
	if {[regexp {[^0-9]+} $xcodfis] > 0 } {
	    incr exception_count
	    append exception_text "<li> Partita IVA Errata. Ammessi solo numeri"
	} else {
	    set nl 1
	    set stringa ""
	    while {$nl < 11} {
		set char [string index $xcodfis $nl]
		set num [expr 2*$char]
		append stringa $num
		append stringa [string index $xcodfis [expr $nl - 1]]
		set nl [expr $nl + 2]
	    }
	    set num 0
	    set stringa [split $stringa {}]
	    foreach valore_lista $stringa {
		incr  num $valore_lista
	    }		
	    

	    set num [string index $num [expr [string length $num] - 1]]
	    if {$num == 0} {
		set char 0
	    } else {
		set char [expr 10 -$num]
	    }
	    set num [string range $xcodfis 7 9]
	    if {([string range $xcodfis 0 6] == 0000000) && ($num <= 95)} {
		set char 1
	    }
	    if {$char != [string index $xcodfis 10]} {
		incr exception_count
		append exception_text "<li> Partita IVA Errata"
	    }
	}
    }

    if {$exception_count > 0 } {
	if {$xcontrolla == 1} {
	    #visualizzo il messaggio di errore
	    #ns_return 200 text/html "|$exception_count|$exception_text|";return
	    ad_return_complaint $exception_count $exception_text
	}
        return 0
    } else {
	return 1
    }
}

ad_proc -public iter::calc_char_cf  {
     -x15cf
} { 
    Calculate last charr of fiscal code
} {
    set pari(A) 0
    set pari(B) 1
    set pari(C) 2
    set pari(D) 3
    set pari(E) 4
    set pari(F) 5
    set pari(G) 6
    set pari(H) 7
    set pari(I) 8
    set pari(J) 9
    set pari(0) 0
    set pari(1) 1
    set pari(2) 2
    set pari(3) 3
    set pari(4) 4
    set pari(5) 5
    set pari(6) 6
    set pari(7) 7
    set pari(8) 8
    set pari(9) 9
    set pari(K) 10
    set pari(L) 11
    set pari(M) 12
    set pari(N) 13
    set pari(O) 14
    set pari(P) 15
    set pari(Q) 16
    set pari(R) 17
    set pari(S) 18
    set pari(T) 19
    set pari(U) 20
    set pari(V) 21
    set pari(W) 22
    set pari(X) 23
    set pari(Y) 24
    set pari(Z) 25

    set dispari(A) 1
    set dispari(B) 0
    set dispari(C) 5
    set dispari(D) 7
    set dispari(E) 9
    set dispari(F) 13
    set dispari(G) 15
    set dispari(H) 17
    set dispari(I) 19
    set dispari(J) 21
    set dispari(0) 1
    set dispari(1) 0
    set dispari(2) 5
    set dispari(3) 7
    set dispari(4) 9
    set dispari(5) 13
    set dispari(6) 15
    set dispari(7) 17
    set dispari(8) 19
    set dispari(9) 21
    set dispari(K) 2
    set dispari(L) 4
    set dispari(M) 18
    set dispari(N) 20
    set dispari(O) 11
    set dispari(P) 3
    set dispari(Q) 6
    set dispari(R) 8
    set dispari(S) 12
    set dispari(T) 14
    set dispari(U) 16
    set dispari(V) 10
    set dispari(W) 22
    set dispari(X) 25
    set dispari(Y) 24
    set dispari(Z) 23


    set control(0) A
    set control(1) B
    set control(2) C
    set control(3) D
    set control(4) E
    set control(5) F
    set control(6) G
    set control(7) H
    set control(8) I
    set control(9) J
    set control(10) K
    set control(11) L
    set control(12) M
    set control(13) N
    set control(14) O
    set control(15) P
    set control(16) Q
    set control(17) R
    set control(18) S
    set control(19) T
    set control(20) U
    set control(21) V
    set control(22) W
    set control(23) X
    set control(24) Y
    set control(25) Z

    set xsum 0
    set i 0
    #pari = 0 -> dispari                                                                                                                                                                                                                       
    set flag_pari 0

    while {$i < 15} {

        set xc [string index $x15cf $i]

        if {$flag_pari == 0} {
            set xsum [expr $dispari($xc) + $xsum ]
            set flag_pari 1
        } else {
            set xsum [expr $pari($xc) + $xsum ]
            set flag_pari 0
        }
        incr i

    }

    #scorro la lista di controllo per assegnare il carattere di controllo                                                                                                                                                                      
    set cc [expr int(fmod($xsum,26))]
    set ccontrol $control($cc)

    return $ccontrol
}


ad_proc -public iter::script_init  {
    {-approved_par ""}
    {-validated_par ""}
    {-caller        ""}
} { 
    Returns the maintainer_id
} {
    set maintainer_id [auth::require_login]

    ns_log notice "\niter::script_init -approved_par $approved_par -validated_par $validated_par maintainer_id=$maintainer_id"
    if {$caller ne "operators" && 1==0} {#ric01 aggiunta if e contenuto
	if {[string match  "*iter-portal-marche*" [db_get_database]]} {
	    #Se esistono operatori attivi senza abilitazione blocco.
	    if {[db_string q "select count(*) as a
                            from iter_operators
                           where maintainer_id = :maintainer_id 
                             and is_active_p = 't'
                             and abilitazione_giuridica_p is null"] > 0} {

		ad_returnredirect -message "Prima di procedere registra il titolo giuridico di tutti i tuoi tecnici." operators-list
		ad_script_abort
	    }
	}
    }
    if {![db_0or1row check_maint "select op_number, an_number, de_number, validated_p, approved_p from iter_maintainers where maintainer_id = :maintainer_id"]} {
        ns_log notice "\niter:script_init non registrato"
	ad_returnredirect -message "Spiacente, ma questa pagina è riservata ai manutentori registrati." /
	ad_script_abort
    }

    ns_log notice "\niter::script_init approved_p=$approved_p validated_p=$validated_p"

    if {![string equal $validated_par ""]} {
	if {![string equal $validated_p $validated_par]} {
	    set maintainer_id 0
	}
    }
    if {![string equal $approved_par ""]} {
	if {![string equal $approved_p $approved_par]} {
	    set maintainer_id 0
	}
    }

    ns_log notice "\niter::script_init ritorno $maintainer_id"
    return $maintainer_id
}

ad_proc -public iter::cait_script_init  {
} { 
    Returns the cait_id
} {
    set cait_id [auth::require_login]

    if {![db_0or1row check_maint "select 1 from iter_cait where cait_id = :cait_id"]} {
	ad_returnredirect -message "Spiacente, ma questa pagina è riservata ai CAIT registrati." /
	ad_script_abort
    }
    return $cait_id
}

ad_proc -public iter::office_script_init  {
} { 
    Returns the office_id
} {
    set office_id [auth::require_login]

    if {![db_0or1row check_office "select 1 from iter_offices where office_id = :office_id"]} {
	ad_returnredirect -message "Spiacente, ma questa pagina è riservata agli Studi associati registrati." /
	ad_script_abort
    }

    return $office_id
}

ad_proc -public iter::check_reg  {
    -maintainer_id
} { 
    Returns a msg with the number of operators and tools that are to be inserted, null if no other information to insert
} {
    if {![db_0or1row check_maint "select op_number, an_number, de_number from iter_maintainers where maintainer_id = :maintainer_id"]} {
        ns_log notice "\niter::check_reg RISERVATA!"
	ad_returnredirect -message "Spiacente, ma questa pagina è riservata ai manutentori registrati." /
	ad_script_abort
    }
    set num_op [db_string query "select count(*) from iter_operators where maintainer_id = :maintainer_id"]
    set num_an [db_string query "select count(*) from iter_tools where maintainer_id = :maintainer_id and type = '0'"]
    set num_de [db_string query "select count(*) from iter_tools where maintainer_id = :maintainer_id and type = '1'"]
    
    set op_diff [expr $op_number - $num_op]
    set an_diff [expr $an_number - $num_an]
    set de_diff [expr $de_number - $num_de]
    set num_msg ""
    if {$op_diff > 0} {
	if {$op_diff > 1} {
	    append num_msg "$op_diff Operatori "
	} else {
	    append num_msg "$op_diff Operatore "
	}
    }
    if {$an_diff > 0} {
	if {$an_diff > 1} {
	    append num_msg "$an_diff Analizzatori di Combustione "
	} else {
	    append num_msg "$an_diff Analizzatore di Combustione "
	}
    }
    if {$de_diff > 0} {
	if {$de_diff > 1} {
	    append num_msg "$de_diff Deprimometri"
	} else {
	    append num_msg "$de_diff Deprimometro"
	}
    }
    
    return $num_msg
}

ad_proc -public iter::get_reg_msg  {
    -validated_p
    -approved_p
    -num_msg
} { 
    Returns a msg with the number of operators and tools that are to be inserted, null if no other information to insert
} {

    set db_name [db_get_database];#sim02

    if {[string equal $validated_p "t"] && [string equal $approved_p "t"]} {
	if {[string match "*iter-portal-marche*" $db_name]} {
	    set reg_msg "Registrazione completata con successo: puoi accedere al CURMIT."
	} else {
	    set reg_msg "Registrazione completata con successo: puoi accedere ad I.Ter per inserire i modelli RCEE"
	}
    } elseif {[string equal $validated_p "t"] && [string equal $approved_p "f"]} {
	set reg_msg "Registrazione completata con successo: per poter inserire i modelli RCEE conferma definitivamente i dati inseriti e attendi la mail di avvenuta registrazione"
    } else {

	if {$num_msg ne ""} {#sim04
	    set reg_msg "Attenzione. Registrazione Incompleta: registrare ancora $num_msg"
	} else {#sim04 if e suo contenuto
	    set reg_msg "Grazie per aver inserito tutti i suoi dati. La registrazione sarà al più presto validata "
	}


	if {$db_name eq "iter-portal-pran"} {;#sim02 if e suo contenuto
	    set  reg_msg "Grazie per aver inserito tutti i suoi dati. La registrazione non potrà però essere convalidata dal nostro personale prima che lei ci faccia avere all'indirizzo e.mail: cristiana.costantini@anconaparcheggi.it una copia di una vostra recente visura camerale (max tre mesi) con l'evidenza della presenza della lettera C del DM 37/08."
	}


    }

    if {[string match "iter-portal-marche" $db_name]} {

	if {$num_msg ne ""} {
	    set reg_msg "Attenzione. Registrazione Incompleta: registrare ancora $num_msg"
	} else {
	    set reg_msg ""
	}

    }
    
    #   elseif {[string equal $num_msg ""]} {}
    #	set reg_msg "Registrazione confermata: appena riceverai la mail di avvenuta registrazione potrai accedere ad I.Ter per inserire gli RCEE"

    return $reg_msg
}

ad_proc -public iter::user_group  {
    -user_id:required
} { 
    Restituisce il gruppo (ENTE) di appartenenza dell'utente.
} {

    # trovo il subsite
    array set arr [site_node::get_from_url -url /]
    set context_id $arr(package_id)

    # ottengo il gruppo a cui appartengono, con relazione di
    # composizione, tutti gli altri gruppi 
    set subsite_group_id [application_group::group_id_from_package_id -package_id $context_id]

    # creo lista enti
    set group_list [db_list enti "
    select g.group_id 
    from acs_rels r, groups g
    where r.rel_type='composition_rel' and 
          r.object_id_one = :subsite_group_id and 
          r.object_id_two = g.group_id"]

    set group_list [join $group_list ,]

    return [db_string query "
           select object_id_one
           from acs_rels
           where object_id_two = :user_id and
                 object_id_one in($group_list)" -default ""]
}

ad_proc -public iter_taratura_scaduta {
} {
    ns_log notice "iter_taratura_scaduta: start ..."

    set mail_text ""
    set last_year [db_string query "select to_char(current_date + interval '10 days' - interval '1 year', 'yyyy-mm-dd')"]
    #but01set lista_tools [db_list query "select distinct maintainer_id from iter_tools where last_calibration_date = :last_year and last_calibration_date is not null and type = '0'"]
    set lista_tools [db_list query "select distinct maintainer_id
                                      from iter_tools 
                                     where last_calibration_date = :last_year 
                                       and last_calibration_date is not null 
                                       and type                  = '0'
                                       and is_active_p           = 't'"];#but01

    foreach maintainer_id $lista_tools {

	db_1row query "select name, email from iter_maintainers where maintainer_id = :maintainer_id"
	set mail_text "Spett.le $name,\n\n"

	db_foreach query "
            select brand, model, no, to_char(last_calibration_date, 'DD/MM/YYYY') as last_calibration_date_pretty
              from iter_tools
             where last_calibration_date = :last_year
               and last_calibration_date is not null
               and maintainer_id = :maintainer_id
               and type = '0'
        " {
	    #append mail_text "\nLo strumento $brand $model con matricola $no ha la taratura in scadenza il giorno $last_calibration_date_pretty.\n"
	}
	#append mail_text "\nDistinti Saluti\n"

	set from_addr [parameter::get_from_package_key -package_key iter-portal -parameter email_from];#sim01
	set email_indirizzo_portale [parameter::get_from_package_key -package_key iter-portal -parameter email_indirizzo_portale];#sim01
	
	set db_name [db_get_database];#rom02
	if {[string match "*iter-portal-marche*" $db_name]} {#rom02 Aggiunta if ma non il contenuto
	    append mail_text "La taratura di uno o più degli strumenti da voi censiti sul portale CURMIT risulta prossima alla scadenza. ";#sim06
	} elseif {[string match "*iter-portal-palermo*" $db_name]} {#rom02 Aggiunta elseif e il suo contenuto
	    append mail_text "La taratura di uno o più degli strumenti da voi censiti sul portale CUPI risulta prossima alla scadenza. "
	} else {#rom02 Aggiunta else e contenuto
	    append mail_text "La taratura di uno o più degli strumenti da voi censiti sul portale risulta prossima alla scadenza. "
	}
		  
	append mail_text "Vi richiediamo di controllare le date di taratura degli strumenti analizzatori dichiarati sul portale $email_indirizzo_portale e di apportare i necessari aggiornamenti o correggere eventuali errori avvenuti in fase di registrazione.\nSi precisa che non sarà possibile confermare l'operatività sul portale a ditte che dichiarano di svolgere la propria attività con l'utilizzo di strumentazione con taratura scaduta.\nUn tanto ai sensi della norma UNI 10389-1.\n\nCordiali saluti."

	#rom02set db_name [db_get_database]

	if {[string match "*iter-portal-marche*" $db_name]} {#sim05 if else e suo contenuto

	    append mail_text "\n
\n
Per favore, non rispondere a questa mail. Per eventuali comunicazioni scrivi ad energia@regione.marche.it"
	    if {$db_name eq "iter-portal-marche"} {
		set cc_addr "energia@regione.marche.it"
	    } else {
		#ambinte di test
		set cc_addr "xxxxxxx"
		set email "xxxxxxx"
	    }
	    	    
	} else {
	    set cc_addr $from_addr
	}
	
	#set email "xxxxxxx"
	#sim01 set from_addr "xxxxxxx"

	if {![string match "*dev" $db_name] && ![string match "*test" $db_name]} {#rom03 Aggiunta if ma non il suo contenuto

	    #nic01	acs_mail_lite::send -from_addr $from_addr -to_addr $email -subject "Strumenti con taratura scaduta" -body $mail_text
	    #sim05	acs_mail_lite::send -from_addr $from_addr -to_addr $email -cc_addr $from_addr -subject "Strumenti con taratura scaduta" -body $mail_text;#nic01
	    #sim06	acs_mail_lite::send -from_addr $from_addr -to_addr $email -cc_addr $cc_addr -subject "Strumenti con taratura scaduta" -body $mail_text;#sim05
	    acs_mail_lite::send -from_addr $from_addr -to_addr $email -cc_addr $cc_addr -subject "Strumenti con taratura in scadenza" -body $mail_text;#sim06

	};#rom03
	
    }
    
    ns_log notice "iter_taratura_scaduta: mail inviate"
}

ad_proc -public iter_bonifica_manutentori {
} {
    ns_log notice "iter_bonifica_manutentori: start ..."

    set lista_manu [db_list_of_lists query "select maint_2_id, name, fiscal_code, iva_code, iter_code from iter_maint_2"]

    foreach item $lista_manu {
	util_unlist $item maint_2_id name fiscal_code iva_code iter_code_2

	if {$fiscal_code eq ""} {
	    set iden_fiscale $iva_code
	} else {
	    set iden_fiscale $fiscal_code
	}
	
	if {[db_0or1row query "select iter_code from iter_maintainers where fiscal_code = :iden_fiscale or iva_code = :iden_fiscale"]} {
	    if {$iter_code ne ""} {
		ns_log notice "select iter_code from iter_maintainers where fiscal_code = '$iden_fiscale' or iva_code = '$iden_fiscale'"
		ns_log notice "BONIFICA MANUTENTORI|$maint_2_id|$name|$fiscal_code|$iva_code|$iter_code_2|TROVATO $iter_code"

		# aggiorno fatture e bollini
		db_dml query "update coimfatt set cod_sogg = :iter_code where cod_sogg = :iter_code_2 and id_utente = '1522'"
		db_dml query "update coimboll set cod_manutentore = :iter_code where cod_manutentore = :iter_code_2 and utente = '1522'"
		# e cancello il record dalla iter_maint_2
		db_dml query "delete from iter_maint_2 where maint_2_id = :maint_2_id and iter_code = :iter_code_2"
	    }
	}
    }

    ns_log notice "iter_bonifica_manutentori: finito"
}

ad_proc iter_httpget_wallet {
    url
} {
    esegue una chiamata http-get a wallet impostando dinamicamente l'indirizzo web

    Creata da Simone in maggio 2016
} {

    #nic01 10/06/2016 Su iter-portal non voglio usare parametri del package iter.
    #nic01            Normalmente il portale usa il wallet di se stesso.

    #sim01 02/08/2016 Per far riconoscere l'ip del chiamante al programma chiamato, e'
    #sim01            necessario specificare la url nella ad_httpget.
    #sim01            Uso util_current_location al posto di ns_conn location altrimenti
    #sim01            sui server amazon compare l'hostname al posto della url.
    #nic01 set url_portafoglio [parameter::get_from_package_key -package_key iter -parameter url_portafoglio]
    #sim01 set url_portafoglio /wallet;#nic01
    set url_portafoglio [util_current_location]/wallet;#sim01

    set db_name [db_get_database]
    if {[string match "iter-portal-marche" $db_name]} {
	set url_portafoglio 10.101.11.106:8011/wallet
    }
    if {[string match "iter-portal-marche-test" $db_name]} {
	set url_portafoglio 10.101.11.106:8026/wallet
    }
    
	
    set dyn_url         "$url_portafoglio/$url"

    regsub -all "http:" $dyn_url "https:" dyn_url;#sim03

    ns_log Notice "iter_httpget_wallet; ad_httpget -url $dyn_url -timeout 100  url:$url"

    set spool_dir     [iter_set_spool_dir];#sim03
    set nome_file_tmp "httpget_wallet";#sim03
    set nome_file_tmp [iter_temp_file_name $nome_file_tmp];#sim03

    set path_file_response "$spool_dir/${nome_file_tmp}-response.txt";#sim03
    set path_file_trace    "$spool_dir/${nome_file_tmp}-trace.txt";#sim03
    
    #sim03 aggiunto with_catch
    with_catch msg_err_curl {
	exec curl \
	    -vs \
	    -k \
	    -X GET \
	    --connect-timeout 100 \
	    --trace-ascii $path_file_trace \
	    $dyn_url > $path_file_response
    } {
        #Non e' un errmsg ma un debug
        ns_log Notice "iter_httpget_wallet;msg_err_curl:$msg_err_curl"
    }

    set file_id   [open $path_file_response r];#sim03
    fconfigure    $file_id -encoding utf-8;#sim03
    set response  [read $file_id];#sim03

    #se mi risponde col codice 301 vuol dire che devo fare la chiamata https
    if {[regexp {301 Moved Permanently} $response]} {#sim03
    
	set dyn_url  [regsub -all {http:} $dyn_url       {https:}]
	
	with_catch msg_err_curl {
        exec curl \
	    -vs \
            -k \
            -X GET \
            --connect-timeout 100 \
            --trace-ascii $path_file_trace \
            $dyn_url > $path_file_response

	    set file_id   [open $path_file_response r]
	    fconfigure   $file_id -encoding utf-8
	    set response  [read $file_id]
	    
	} {	    
	    #Non e' un errmsg ma un debug
	    ns_log Notice "iter_httpget_wallet redirect hhtps;msg_err_curl:$msg_err_curl"
	}

    }

    #restitusico la risposta come faceva già prima la ad_httpget
    set response [list page $response  status ""  modified ""];#sim03

    return $response;#sim03

    #sim03 return [ad_httpget -url $dyn_url -timeout 100]

}

ad_proc  -public iter::script_init_cittadino {
    
    {-level  "ok"}
    {-account_status "ok"}
    
} {
    Controlla se il cittadino è loggato e restituisce lo user_id 
    Creata da Luca R. il 07/05/2018
} {
    #Il controllo del login del cittadino lo faccio solo se il parametro login_cittadino_p vale 1, altrimenti lo salto visto che l'ente
    #non ha la gestione del cittadino. 
    
    set login_cittadino_p [parameter::get_from_package_key -package_key iter-portal -parameter login_cittadino_p]
    if {$login_cittadino_p} {
	set user_id [auth::get_user_id  -level $level  -account_status $account_status]
	set is_cittadino [group::member_p -user_id $user_id -group_name "Cittadino"  -cascade] 
	
	if { $user_id != 0 && $is_cittadino != 0 } {
	    # user is in fact logged in, return user_id
	    return $user_id
	}
	
	if { $user_id != 0 && $is_cittadino == 0 } {
	    set message "Utente non abilitato per accedere ai servizi del cittadino"
	} else {
	    set message "Per accedere ai servizi del cittadino è necessario effettuare il login."
	}
	set return_url "login-cittadino"
	
	
	ad_returnredirect -message $message -- $return_url
	ad_script_abort
    } else {
	set user_id ""
	return $user_id
    }
}
