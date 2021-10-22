ad_page_contract {
    Lista distinte di consegna modelli H (tabella "coimdocu")

    @author                  Adhoc
    @creation-date           03/07/2006

    @param search_word       parola da ricercare con una query
    @param rows_per_page     una delle dimensioni della tabella  
    @param caller            se diverso da index rappresenta il nome del form 
                             da cui e' partita la ricerca ed in questo caso
                             imposta solo azione "sel"
    @param nome_funz         identifica l'entrata di menu,
                             serve per le autorizzazioni
    @param nome_funz_caller  identifica l'entrata di menu,
                             serve per la navigation bar
    @param receiving_element nomi dei campi di form che riceveranno gli
                             argomenti restituiti dallo script di zoom,
                             separati da '|' ed impostarli come segue:

    @cvs-id coimdocu-dist-list.tcl 

    USER  DATA       MODIFICHE
    ===== ========== =======================================================================
    rom01 21/10/2020 Su segnalazione di Salerno modificato page_title per renderlo
    rom01            uguale al nome del menu', Sandro ha detto che va bene per tutti.

    sim01 30/09/2016 Corretto paginazione
} { 
   {search_word       ""}
   {rows_per_page     ""}
   {caller            "index"}
   {nome_funz         ""}
   {nome_funz_caller  ""} 
   {receiving_element ""}
   {last_cod_documento ""}
}  -properties {
    page_title:onevalue
    context_bar:onevalue
    list_head:onevalue
    table_result:onevalue
}

# B80: RECUPERO LO USER - INTRUSIONE
set id_utente [ad_get_cookie iter_login_[ns_conn location]]
set id_utente_loggato_vero [ad_get_client_property iter logged_user_id]
set session_id [ad_conn session_id]
set adsession [ad_get_cookie "ad_session_id"]
set referrer [ns_set get [ad_conn headers] Referer]
set clientip [lindex [ns_set iget [ns_conn headers] x-forwarded-for] end]

# if {$referrer == ""} {
#	set login [ad_conn package_url]
#	ns_log Notice "********AUTH-CHECK-DISTLIST-KO-REFERER;ip-$clientip;$id_utente;$id_utente_loggato_vero;$session_id;$nome_funz;$adsession;"
#	iter_return_complaint "Accesso non consentito! Per accedere a questo programma devi prima eseguire la procedura di <a href=$login>Login.</a>"
#	return 0
#    } 
# if {$id_utente != $id_utente_loggato_vero} {
#	set login [ad_conn package_url]
#	ns_log Notice "********AUTH-CHECK-DISTLIST-KO-USER;ip-$clientip;$id_utente;$id_utente_loggato_vero;$session_id;$nome_funz;$adsession;"
#	iter_return_complaint "Accesso non consentito! Per accedere a questo programma devi prima eseguire la procedura di <a href=$login>Login.</a>"
#	return 0
#    } else {
#	ns_log Notice "********AUTH-CHECK-DISTLIST-OK;ip-$clientip;$id_utente;$id_utente_loggato_vero;$session_id;$nome_funz;$adsession;"
#    }
# ***

# Controlla lo user
if {![string is space $nome_funz]} {
    set lvl        1
    set id_utente [lindex [iter_check_login $lvl $nome_funz] 1]
} else {
  # se la lista viene chiamata da un cerca, allora nome_funz non viene passato
  # e bisogna reperire id_utente dai cookie
    #set id_utente [ad_get_cookie iter_login_[ns_conn location]]
    set id_utente [iter_get_id_utente]
    if {$id_utente  == ""} {
	set login [ad_conn package_url]
	iter_return_complaint "Per accedere a questo programma devi prima eseguire la procedura di <a href=$login>Login.</a>"
	return 0
    }
}

# Controllo se l'utente è un manutentore
set cod_manutentore [iter_check_uten_manu $id_utente]

# controllo il parametro di "propagazione" per la navigation bar
if {[string is space $nome_funz_caller]} {
    set nome_funz_caller $nome_funz
}

#rom01set page_title      "Lista Distinte di consegna allegati"
set page_title      "Gestione distinte di consegna RCEE";#rom01
set context_bar     [iter_context_bar -nome_funz $nome_funz_caller]

# imposto le variabili da usare nel frammento html di testata della lista.
set curr_prog       [file tail [ns_conn url]]
set form_di_ricerca ""
set col_di_ricerca  ""
set extra_par       [list rows_per_page     $rows_per_page \
                          receiving_element $receiving_element]
set link_aggiungi   "<a href=\"coimdocu-dist-dimp-list?[export_url_vars last_cod_documento caller nome_funz extra_par nome_funz_caller]\">Crea distinta</a>"
set rows_per_page   [iter_set_rows_per_page $rows_per_page $id_utente]
set link_righe      [iter_rows_per_page     $rows_per_page]

set link            "\[export_url_vars cod_documento nome_funz_caller\]&nome_funz=$nome_funz"
set link_print      "
<td nowrap><a target=\"Stampa distinta di consegna modelli H\" href=\"coimdocu-gest?funzione=A&$link\">Stampa</a></td>"
set js_function     ""

# estraggo una sola volta uten_cognome_nome
if {[string equal $cod_manutentore ""]} {
    # dalla tabella utenti se l'utente non e' un manutentore
    # in questa query si usa nella where :id_utente
    if {[db_0or1row sel_uten ""] == 0} {
	iter_return_complaint "Codice utente non valido." 
	return
    }
    set uten_cognome_nome "$uten_cognome $uten_nome"
} else {
    # dalla tabella manutentori se l'utente e' un manutentore
    if {[db_0or1row sel_manu ""] == 0} {
	iter_return_complaint "Manutentore non trovato." 
	return
    }
    set uten_cognome_nome "$manu_cognome $manu_nome"
}
set td_uten_cognome_nome  "<td>$uten_cognome_nome</td>"

# imposto la struttura della tabella
set table_def [list \
        [list cod_documento       "N&deg; distinta" no_sort {l}] \
        [list uten_cognome_nome   "Creata da"       no_sort $td_uten_cognome_nome] \
        [list data_documento_edit "In data"         no_sort {c}] \
        [list link_print          "Stampa"          no_sort $link_print] \
]

# imposto la query SQL 

# imposto la condizione per il soggetto
if {[string equal $cod_manutentore ""]} {
    # inseriti dall'utente se l'utente non e' un manutentore
    set tipo_soggetto "C"
    set cod_soggetto  $id_utente
} else {
    # inseriti dal manutentore se l'utente e' un manutentore
    set tipo_soggetto "M"
    set cod_soggetto  $cod_manutentore
}

# imposto la condizione per la prossima pagina
if {![string is space $last_cod_documento]} {
    # ho messo <= perche' l'ordinamento e' descending
    #sim01 set where_last " and cod_documento<= :last_cod_documento"
    set where_last " and cast(cod_documento as int) <= :last_cod_documento";#sim01
} else {
    set where_last ""
}

set sel_docu     [db_map sel_docu]

set table_result [ad_table -Tmax_rows $rows_per_page -Tmissing_text "Nessun dato corrisponde ai criteri impostati." -Textra_vars {cod_documento last_cod_documento nome_funz nome_funz_caller extra_par} go $sel_docu $table_def]

# preparo url escludendo last_cod_documento che viene passato esplicitamente
# per poi preparare il link alla prima ed eventualmente alla prossima pagina
set url_vars [export_ns_set_vars "url" last_cod_documento]
set link_altre_pagine "Vai alla <a href=\"$curr_prog?$url_vars\">prima pagina</a>"

# preparo link a pagina successiva
set ctr_rec [expr [regsub -all <tr $table_result <tr comodo] -1]
if {$ctr_rec == $rows_per_page} {
    set last_cod_documento $cod_documento
    append url_vars          "&[export_url_vars last_cod_documento]"
    append link_altre_pagine " o alla <a href=\"$curr_prog?$url_vars\">pagina successiva</a>"
}

# creo testata della lista
set list_head [iter_list_head  $form_di_ricerca $col_di_ricerca \
              $link_aggiungi $link_altre_pagine $link_righe "Righe per pagina"]

db_release_unused_handles
ad_return_template 
