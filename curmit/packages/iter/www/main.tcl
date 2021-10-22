# /www/caldaie/main.tcl
ad_page_contract {
    Menu principale.
    
    @author Giulio Laurenzi
    @date   13/12/2002

    @cvs_id main.tcl

    USER    DATA       MODIFICHE
    ======= ========== =======================================================================
    sim01 12/03/2019 Per ragioni di sicurezza in caso di single-sign-on è meglio non passare l'id_utente
    sim01            nell'url quindi farò l'autenticazione solo attraverso il token_code

    rom01   29/06/2018 Cambiato il titolo in "Menù gestione Impianti"

    gab01   13/04/2018 Gestione del Multiportafoglio: al web-service che restituisce il saldo
    gab01              del portafoglio passo il nome dell'ente portafoglio

    nic01   27/05/2013 Aggiunto avviso presenza di messaggi non letti

} {
    {livello  "1"}
    {scelta_1 ""} 
    {scelta_2 ""}
    {scelta_3 ""}
    {scelta_4 ""}
    {id_utente ""}
    {messaggioscad ""}
    {nome_funz "main"}
    {flag_saldo ""}
    {id_utente ""}
    {token_code ""}
}

set db_name [parameter::get_from_package_key -package_key iter -parameter dbname_portale -default ""]

set ente_portafoglio [db_get_database];#gab01

db_0or1row q "select flag_single_sign_on
                     from coimtgen"

#sim01 tolto $id_utente ne ""
if {$token_code ne "" && $flag_single_sign_on eq "t" && [db_0or1row -dbn $db_name q "
                                                                          select data_last_login
                                                                               , utente as id_utente --sim01
                                                                            from iter_login
                                                                           where --sim01 utente     = :id_utente and 
                                                                                 token_code = :token_code
                                                                             and data_last_login + (interval '30 minute') > current_timestamp"]} {


    db_1row q "select rows_per_page
                 from coimuten 
                where id_utente=:id_utente "

    ad_set_client_property iter logged_user_id $id_utente
    set id_utente_loggato_vero [ad_get_client_property iter logged_user_id]
    set clientip [lindex [ns_set iget [ns_conn headers] x-forwarded-for] end]
    set session_id [ad_conn session_id]
    set adsession [ad_get_cookie "ad_session_id"]
    
    # crea cookie utenti e permessi
    ad_set_cookie -replace t -path / iter_login_[ns_conn location] $id_utente
    ad_set_cookie -replace t -path / iter_rows_[ns_conn location] $rows_per_page
    
}


# : RECUPERO LO USER - INTRUSIONE
set id_utente [ad_get_cookie iter_login_[ns_conn location]]
set id_utente_loggato_vero [ad_get_client_property iter logged_user_id]
set session_id [ad_conn session_id]
set adsession [ad_get_cookie "ad_session_id"]
set referrer [ns_set get [ad_conn headers] Referer]
set hostx [ns_set get [ad_conn headers] Host]
set clientip [lindex [ns_set iget [ns_conn headers] x-forwarded-for] end]
#ns_log notice "$id_utente $id_utente_loggato_vero"

#if {[string equal $id_utente_loggato_vero "xxzzy"]} {
  if {$id_utente != $id_utente_loggato_vero} {
	set login [ad_conn package_url]
	ns_log Notice "********AUTH-CHECK-MAIN-KO-USER;ip-$clientip;$id_utente;$id_utente_loggato_vero;$session_id;$nome_funz;$adsession;"
	iter_return_complaint "Accesso non consentito! Per accedere a questo programma devi prima eseguire la procedura di <a href=$login>Login.</a>"
	return 0
   } else {
	ns_log Notice "********AUTH-CHECK-MAIN-OK;ip-$clientip;$id_utente;$id_utente_loggato_vero;$session_id;$nome_funz;$adsession;"
   }
#}

# mail alert
#if {![string equal $id_utente_loggato_vero $id_utente]} {
#    ns_log Notice "********B80-AUTH-CHECK-MAIN-KO-USER-COOKIE;ip-$clientip;$id_utente;$id_utente_loggato_vero;$session_id;$nome_funz;$adsession;"
#    if {$id_utente != ""} {
#	ns_sendmail "sferrari@oasisoftware.it" "Accesso illegale utenti via cookie $id_utente_loggato_vero $id_utente - $clientip - $hostx" "Accesso illegale utenti via cookie $id_utente_loggato_vero $id_utente - $clientip - $hostx"
	# questa ns_sendmail va in abend su oasi64-dev perchè manca il mittente...
#    }
#}

if {![string is space $nome_funz]} {
    set lvl        1
    set id_utente [lindex [iter_check_login $lvl $nome_funz] 1]
} else {
    set id_utente [ad_get_cookie iter_login_[ns_conn location]]
}

if {[db_0or1row sel_menu ""] == 0} {
    iter_return_complaint  "Il Vs. profilo non ha men&ugrave;."
    return
}

set main_directory [ad_conn package_url]
if {[db_0or1row get_titolo ""] == 1} {
    set context_bar  [iter_context_bar \
		     [list ${main_directory}main "Home"] \
                     "$titolo"]
} else {
    set titolo ""
    set context_bar  [iter_context_bar [list "Home"]]
}

#if {$livello != 1} {
#    set livello_inf [expr $livello - 1]
#    switch $livello_inf {
#	"2" {append context_bar " : <a href=main?livello=$livello_inf&scelta_1=$scelta_1&scelta_2=0&scelta_3=0&scelta_4=0&nome_funz=main>Men&ugrave; precedente</a>" 
#	}
#	"3" {append context_bar " : <a href=main?livello=$livello_inf&scelta_1=$scelta_1&scelta_2=$scelta_2&scelta_3=0&scelta_4=0&nome_funz=main>Men&ugrave; precedente</a>" 
#	}
#	"4" {append context_bar " : <a href=main?livello=$livello_inf&scelta_1=$scelta_1&scelta_2=$scelta_2&scelta_3=$scelta_3&scelta_4=0&nome_funz=main>Men&ugrave; precedente</a>" 
#	}
#    }
#}

#switch $livello {
#    "1" {set where_scelte_a ""}
#    "2" {set where_scelte_a "and a.scelta_1 = :scelta_1"}
#    "3" {set where_scelte_a "and a.scelta_1 = :scelta_1
#                          and a.scelta_2 = :scelta_2"}
#    "4" {set where_scelte_a "and a.scelta_1 = :scelta_1
#                          and a.scelta_2 = :scelta_2
#                          and a.scelta_3 = :scelta_3"}
#}

#set indice ""
#db_foreach sel_menu_join_ogge "" {
#    if {$tipo == "menu"}  {
#	set liv [expr $livello + 1]
#	append indice "<li><a href=main?livello=$liv&scelta_1=$uno&scelta_2=$due&scelta_3=$tre&scelta_4=$quattro&nome_funz=main>$descrizione</a>"
#    } 
#    if {$tipo == "funzione"} {
#	if {[db_0or1row sel_funz ""] == 0} {
#	} else {
#	    set link "$azione$det?nome_funz=$nome_funz"
#	    if {![string equal $parametri ""]} {
#		set list_par [split $parametri "\&"]
#		foreach coppia $list_par {
#		    set list_elem [split $coppia "="]
#		    set key [lindex $list_elem 0]
#		    set val [lindex $list_elem 1]
#		    append link "&$key=[ns_urlencode $val]"
#		}
#	    }
#	    append indice "<li><a href=$link>$descrizione</a>" 
#	}

#    }
#}

#append indice "</li>"


# leggo nome e cognome dell'utente
if {![db_0or1row sel_user ""]
} {
    iter_return_complaint  "Codice utente non valido." 
    return
} 

set yui_menu_p $flag_menu_yui

#messaggio Password
#set current_date [db_string query "select to_char(current_date,'YYYY-MM-DD')"]
#set datascadpsw [db_string query "select to_char(:data::date + 91,'YYYY-MM-DD')"]
#set dataprescad [db_string query "select to_char(:data::date + 81,'YYYY-MM-DD')"]
#set datascadpsw  [db_string query "select to_char(:datascadpsw::date,'DD-MM-YYYY')"]
   
#if {$current_date > $dataprescad} {
#    set messaggioscad " Attenzione!! Password in scadenza il $datascadpsw" 
#} else {
#    set messaggioscad ""
#}

# leggo titolo
#switch $livello {
#    2 {set scelta_2 0}
#    3 {set scelta_3 0}
#}
#if {[db_0or1row sel_ogge_titolo ""] == 0
#} {
#rom01    set titolo "Men&ugrave; principale"
set titolo "Men&ugrave; gestione Impianti";#rom01
#}

db_1row sel_tgen "select flag_portafoglio from coimtgen"

set riga_portafoglio ""

if {$flag_portafoglio ==  "T"} {

    set link_saldo ""
    set saldo ""
    set conto_manu ""

    set cod_manu [iter_check_uten_manu $id_utente]   
    if {![string equal $cod_manu ""]} {
	if {$flag_saldo ne "T"} {
	    set riga_portafoglio "<a href=main?flag_saldo=T>Visualizza il saldo residuo</a>"
	} else {
	    set url  "lotto/balance?iter_code=$cod_manu&ente_portafoglio=$ente_portafoglio";#gab01 passo al web-service anche ente_portafoglio
	    set data [iter_httpget_wallet $url]
	    array set result $data
	    
	    set risultato [string range $result(page) 0 [expr [string first " " $result(page)] - 1]]
	    set parte_2   [string range $result(page) [expr [string first " " $result(page)] + 1] end]
	    set saldo     [iter_edit_num [string range $parte_2 0 [expr [string first " " $parte_2] - 1]] 2]
	    set codice_portafoglio [string range $parte_2 [expr [string first " " $parte_2] + 1] end]

	    set riga_portafoglio "Saldo: $saldo &#8364;; Codice portafoglio: $codice_portafoglio"
	}
    }
}

set page_title $titolo

db_1row query "
select count(*) as ctr_msg_non_letti
  from coimdmsg
 where utente_dest = :id_utente -- solo i messaggi ricevuti dallo user corrente
   and flag_letto  = 'f'
";#nic01

set funz_pwd     [iter_get_nomefunz coimcpwd-gest]
set funz_log_out [iter_get_nomefunz logout]
ad_return_template
