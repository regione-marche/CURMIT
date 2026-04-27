ad_page_contract {
    Lista tabella "coimdimp"

    @author                  Giulio Laurenzi
    @creation-date           06/04/2004

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

    @cvs-id coimdimp-list.tcl 

    USER  DATA       MODIFICHE
    ===== ========== =======================================================================
    innes 17/05/2018 Innesto da iter-dev a iter-portal-dev. Tutte le query verranno eseguite
    innes            passando il dbn che riceviamo dalla pagina di filtro. Abbiamo gestito il
    innes            dbn anche per le proc iter_get_coimtgen e iter_get_coimdesc.
    innes            Aggiunti i parametri targa e dbn_iter.

    rom02 08/05/2018 Rimosso il link per aggiungere un Allegato IX.

    sim08 20/04/2018 Aggiunto per Ucit possibilità di fare RCEE senza portafoglio (momentaneo)

    sim07 01/12/2017 Tolto per Taranto la possibilità di fare RCEE senza portafoglio

    gac01 25/10/2017 Rimossi link per aggiungere modelli G e modelli F

    gab01 07/07/2017 Cambiato la label RCEE Tipo 1 Legna in: RCEE Tipo 1 biomassa

    sim07 05/05/2017 Solo per Firenze si può inserire sia un rct standard che un rct legna

    sim06 06/04/2017 Se la dichiarazione è riferita ad un impianto con teleriscaldamento
    sim06            devo puntare al programma coimdimp-r3-gest.

    sim05 09/03/2017 Per PLI inibiti link per inserimento modelli G ed F.

    sim04 25/10/2016 Anche per gli amministratori di iterprrc sarà presente il link
    sim04            per inserire rct senza il portafoglio

    sim03 18/10/2016 Solo per taranto ci sarà anche il flag_tracciato NW che è l'rct senza
    sim03            il portafoglio

    sim02 21/03/2016 I link Richiedi storno e Ins. mod. sost. devono essere visualizzati solo
    sim02            dal manutentore.
    sim02            Per il momento non visualizziamo il link Accetta storno.

    san01 14/01/2016 Per CPESARO e CFANO, inibiti link per inserimento modelli G ed F.

    nic02 17/09/2015 Aggiunti link per gestione dichiarazioni di avvenuta manutenzione per
    nic02            la regione Marche.

    ant01 16/09/2015 Aggiunta lista e link per gestione "dich. di freq. ed elenco oper. di
    ant01            contr. e manut." usata solo nella regione Marche.

    nic01 18/11/2014 D'accordo con Sandro, facciamo l'order by desc

    sim01 18/11/2014 correzione del link pagina successiva
    
} { 
    {search_word            ""}
    {rows_per_page          ""}
    {caller            "index"}
    {nome_funz              ""}
    {nome_funz_caller       ""} 
    {receiving_element      ""}
    {last_cod_dimp          ""}
    {cod_impianto           ""}
    {targa                  ""}
    {dbn_iter               ""}            
    {url_aimp               ""}
    {url_list_aimp          ""}
}  -properties {
    page_title:onevalue
    context_bar:onevalue
    list_head:onevalue
    table_result:onevalue
}

# B80: RECUPERO LO USER - INTRUSIONE
set id_utente_loggato_vero [ad_get_client_property iter logged_user_id]
set session_id [ad_conn session_id]
set adsession [ad_get_cookie "ad_session_id"]
set referrer [ns_set get [ad_conn headers] Referer]
set clientip [lindex [ns_set iget [ns_conn headers] x-forwarded-for] end]

set login_cohesion_marche_p [parameter::get_from_package_key -package_key iter-portal -parameter login_cohesion_marche_p];#innes

set login_cittadino_p [parameter::get_from_package_key -package_key iter-portal -parameter login_cittadino_p];#innes

if {$login_cohesion_marche_p eq "1"} {#innes: aggiunta if, else e loro contenuto
    set codice_fiscale [iter::check_login_cohesion -nome_array_output array_cohesion -dbn_iter $dbn_iter -cod_impianto $cod_impianto]
    # Se in futuro ci sara' bisogno di altri campi useremo i valori di array_cohesion
} else {
    if {$login_cittadino_p} {
	set user_id [iter::script_init_cittadino]
    }
}


iter_get_coimtgen -dbn $dbn_iter;#innes

db_1row -dbn $dbn_iter query "select flag_portafoglio,flag_gest_targa from coimtgen "

#innes iter_get_coimtgen;#ant01
# if {$referrer == ""} {
#	set login [ad_conn package_url]
#	ns_log Notice "********AUTH-CHECK-DIMPLIST-KO-REFERER;ip-$clientip;$id_utente;$id_utente_loggato_vero;$session_id;$nome_funz;$adsession;"
#	iter_return_complaint "Accesso non consentito! Per accedere a questo programma devi prima eseguire la procedura di <a href=$login>Login.</a>"
#	return 0
#    } 
# if {$id_utente != $id_utente_loggato_vero} {
#	set login [ad_conn package_url]
#	ns_log Notice "********AUTH-CHECK-DIMPLIST-KO-USER;ip-$clientip;$id_utente;$id_utente_loggato_vero;$session_id;$nome_funz;$adsession;"
#	iter_return_complaint "Accesso non consentito! Per accedere a questo programma devi prima eseguire la procedura di <a href=$login>Login.</a>"
#	return 0
#    } else {
#	ns_log Notice "********AUTH-CHECK-DIMPLIST-OK;ip-$clientip;$id_utente;$id_utente_loggato_vero;$session_id;$nome_funz;$adsession;"
#    }
# ***

# Controlla lo user
#innes if {![string is space $nome_funz]} {
#innes    set lvl        1
#innes    set id_utente [lindex [iter_check_login $lvl $nome_funz] 1]
#innes } else {
  # se la lista viene chiamata da un cerca, allora nome_funz non viene passato
  # e bisogna reperire id_utente dai cookie
    #set id_utente [ad_get_cookie iter_login_[ns_conn location]]
#innes    set id_utente [iter_get_id_utente]
#innes    if {$id_utente  == ""} {
#innes	set login [ad_conn package_url]
#innes	iter_return_complaint "Per accedere a questo programma devi prima eseguire la procedura di <a href=$login>Login.</a>"
#innes	return 0
#innes    }
#innes }

#innes set ruolo [db_string query "select id_ruolo from coimuten where id_utente = :id_utente  "]

#innes set link_tab [iter_links_form $cod_impianto $nome_funz_caller $url_list_aimp $url_aimp]
#innes set dett_tab [iter_tab_form $cod_impianto]

# controllo il parametro di "propagazione" per la navigation bar
if {[string is space $nome_funz_caller]} {
    set nome_funz_caller $nome_funz
}

set page_title      "Lista Allegati"

set context_bar [iter_context_bar -nome_funz ""]

# imposto le variabili da usare nel frammento html di testata della lista.
set curr_prog       [file tail [ns_conn url]]
set gest_prog       "coimdimp-gest"
set gest_prog_2     "coimdimp-gest"
set form_di_ricerca [iter_search_form $curr_prog $search_word]
set col_di_ricerca  "Responsabile"
set extra_par       [list rows_per_page     $rows_per_page \
                          receiving_element $receiving_element]
#set link_aggiungi   "<a href=\"$gest_prog?funzione=I&[export_url_vars last_cod_dimp caller url_list_aimp url_aimp cod_impianto nome_funz extra_par nome_funz_caller]\">Aggiungi</a>"

set link_aggiungi ""
set flag_sup ""
db_1row -dbn $dbn_iter sel_aimp_potenza ""

#innes if {$flag_tipo_impianto == "R"} {#dpr
#innes    if {$potenza >= 35} {
#innes	#sim05 aggiunto condizione su PLI
#innes	if {$coimtgen(ente) eq "CPESARO" || $coimtgen(ente) eq "CFANO" || $coimtgen(ente) eq "PLI"} {#san01
#innes	    set link_inserisci_modello_f "";#san01
#innes	} else {#san01
#innes      	    set link_inserisci_modello_f "
#innes                                 Aggiungi un <a href=\"$gest_prog?funzione=I&flag_tracciato=F&[export_url_vars flag_tracciato last_cod_dimp caller url_list_aimp url_aimp cod_impianto nome_funz extra_par nome_funz_caller]\">Modello F</a>
#innes                          <br> o "
#innes	};#san01

#gac01	set link_aggiungi "$link_inserisci_modello_f
#gac01                           Aggiungi un <a href=\"coimnove-gest?funzione=I&[export_url_vars flag_tracciato last_cod_dimp caller url_list_aimp url_aimp cod_impianto nome_funz extra_par nome_funz_caller]\">Allegato IX</a>
#gac01                    <br> o Aggiungi un <a href=\"coimnoveb-gest?funzione=I&[export_url_vars flag_tracciato last_cod_dimp caller url_list_aimp url_aimp cod_impianto nome_funz extra_par nome_funz_caller]\">Allegato art 284</a>
#gac01                    <br> o Aggiungi un <a href=\"$gest_prog?funzione=I&flag_tracciato=R1&[export_url_vars last_cod_dimp caller url_list_aimp url_aimp cod_impianto nome_funz extra_par nome_funz_caller flag_tracciato]\">RCEE Tipo 1</a>"

#rom02        set link_aggiungi "
#rom02                           Aggiungi un <a href=\"coimnove-gest?funzione=I&[export_url_vars flag_tracciato last_cod_dimp caller url_list#rom02_aimp \
#rom02url_aimp cod_impianto nome_funz extra_par nome_funz_caller]\">Allegato IX</a>
#rom02                    <br> o Aggiungi un <a href=\"coimnoveb-gest?funzione=I&[export_url_vars flag_tracciato last_cod_dimp caller url_lis#rom02t_aimp\
#rom02 url_aimp cod_impianto nome_funz extra_par nome_funz_caller]\">Allegato art 284</a>
#rom02                    <br> o Aggiungi un <a href=\"$gest_prog?funzione=I&flag_tracciato=R1&[export_url_vars last_cod_dimp caller url_list_aimp \
#rom02url_aimp cod_impianto nome_funz extra_par nome_funz_caller flag_tracciato]\">RCEE Tipo 1</a>"
#innes	set link_aggiungi "Aggiungi un <a href=\"coimnoveb-gest?funzione=I&[export_url_vars flag_tracciato last_cod_dimp caller url_list_aimp\
#innes url_aimp cod_impianto nome_funz extra_par nome_funz_caller]\">Allegato art 284</a>
#innes                    <br> o Aggiungi un <a href=\"$gest_prog?funzione=I&flag_tracciato=R1&[export_url_vars last_cod_dimp caller url_list_aimp \
#innes url_aimp cod_impianto nome_funz extra_par nome_funz_caller flag_tracciato]\">RCEE Tipo 1</a>"

#innes	set flag_sup "S"
#innes    } else {
	#sim05 aggiunto condizione su PLI
#innes        if {$coimtgen(ente) eq "CPESARO" || $coimtgen(ente) eq "CFANO" || $coimtgen(ente) eq "PLI"} {#san01
#innes            set link_inserisci_modello_g "";#san01
#innes        } else {#san01
#innes            set link_inserisci_modello_g "
#innes                           Aggiungi <a href=\"$gest_prog?funzione=I&flag_tracciato=G&[export_url_vars last_cod_dimp caller url_list_aimp url_aimp cod_impianto nome_funz extra_par nome_funz_caller flag_tracciato]\">Modello G</a>
#innes                          <br> o "
#innes	}
#gac01	set link_aggiungi "$link_inserisci_modello_g
#gac01                           Aggiungi <a href=\"$gest_prog?funzione=I&flag_tracciato=R1&[export_url_vars last_cod_dimp caller url_list_aimp url_aimp cod_impianto nome_funz extra_par nome_funz_caller flag_tracciato]\">RCEE Tipo 1</a>"

#innes	set link_aggiungi "
#innes                           Aggiungi <a href=\"$gest_prog?funzione=I&flag_tracciato=R1&[export_url_vars last_cod_dimp caller url_list_aimp url_aimp cod_impianto nome_funz extra_par nome_funz_caller flag_tracciato]\">RCEE Tipo 1</a>";#gac01

#innes	set flag_sup "N"
#innes    }

#innes    if {$coimtgen(flag_gest_rcee_legna) eq "T" && $coimtgen(ente) eq "PFI"} {;#sim07

	#gab01 cambiata label RCEE Tipo 1 Legna
#innes	append link_aggiungi "<br>o Aggiungi <a href=\"$gest_prog?funzione=I&flag_tracciato=1B&[export_url_vars last_cod_dimp caller url_list_aimp url_aimp cod_impianto nome_funz extra_par nome_funz_caller flag_tracciato]\">RCEE Tipo 1 biomassa</a>"
	
#innes    }

#innes}

#innes if {$flag_tipo_impianto == "F"} {#dpr
#innes    set link_aggiungi  "Aggiungi <a href=\"$gest_prog?funzione=I&flag_tracciato=R2&[export_url_vars last_cod_dimp caller url_list_aimp url_aimp cod_impianto nome_funz extra_par nome_funz_caller flag_tracciato]\">RCEE Tipo 2</a>"
#innes    set flag_sup "N"
#innes }

#innes if {$flag_tipo_impianto == "T"} {#sim6 if e suo contenuto
#innes    set link_aggiungi  "Aggiungi <a href=\"$gest_prog?funzione=I&flag_tracciato=R3&[export_url_vars last_cod_dimp caller url_list_aimp url_aimp cod_impianto nome_funz extra_par nome_funz_caller flag_tracciato]\">RCEE Tipo 3</a>"
#innes    set flag_sup "N"
#innes }

#innes if {$flag_tipo_impianto == "C"} {#rom01 if e suo contenuto
#innes    set link_aggiungi  "Aggiungi <a href=\"$gest_prog?funzione=I&flag_tracciato=R4&[export_url_vars last_cod_dimp caller url_list_aimp url_aimp cod_impianto nome_funz extra_par nome_funz_caller flag_tracciato]\">RCEE Tipo 4</a>"
#innes    set flag_sup "N"
#innes};#rom01


#innes if {$coimtgen(regione) eq "MARCHE"} {#nic02: aggiunta if e suo contenuto
#innes   append link_aggiungi "<br>o Aggiungi una <a href=\"$gest_prog?funzione=I&flag_tracciato=DA&[export_url_vars last_cod_dimp caller url_list_aimp url_aimp cod_impianto nome_funz extra_par nome_funz_caller flag_tracciato]\">Dich. di Avvenuta manutenzione</a>"
#innes}

# ant01: aggiungo il link alle dichiarazioni di frequenza.
if {$coimtgen(regione) eq "MARCHE"} {#ant01: aggiunta if e suo contenuto
    set sw_dichiarazioni_frequenza "t"
} else {
    set sw_dichiarazioni_frequenza "f"
}

#innes if {$sw_dichiarazioni_frequenza eq "t"} {#ant01: aggiunta if e suo contenuto
#innes    set coimdope_url "coimdope-aimp-gest?funzione=I&[export_url_vars last_cod_dimp caller url_list_aimp url_aimp cod_impianto flag_tipo_impianto nome_funz extra_par nome_funz_caller flag_tracciato]"
#innes    set js_function "return(confirm('Sono stati inseriti tutti i generatori?'));"
#innes    append link_aggiungi "<br> o Aggiungi una <a href=\"$coimdope_url\" onclick=\"$js_function\">Dich. di Freq. ed elenco oper. di contr. e man.</a>"
#innes}
#innes set cod_manu [iter_check_uten_manu $id_utente];#sim04
#sim04 aggiunto || per PRC
#sim07 tolto $coimtgen(ente) eq "PTA" || 
#sim08 aggiunto if per PUD-PGO-PTS-PPN
#innes if {($coimtgen(ente) eq "PRC" && $cod_manu eq "") ||
#innes        $coimtgen(ente) eq "PUD" ||
#innes        $coimtgen(ente) eq "PGO" ||
#innes        $coimtgen(ente) eq "PTS" ||
#innes        $coimtgen(ente) eq "PPN" } {;#sim03
#innes    append link_aggiungi "<br> o Aggiungi un <a href=\"$gest_prog?funzione=I&flag_tracciato=NW&[export_url_vars last_cod_dimp caller url_list_aimp url_aimp cod_impianto nome_funz extra_par nome_funz_caller flag_tracciato]\">RCEE senza bollino virtuale</a>"
#innes }

set id_utente "";#innes
set rows_per_page   [iter_set_rows_per_page $rows_per_page $id_utente]
set link_righe      [iter_rows_per_page     $rows_per_page]


set link    "\[export_url_vars cod_dimp cod_impianto url_list_aimp url_aimp last_cod_dimp nome_funz nome_funz_caller extra_par dbn_iter dbn_iter targa targa\]"
set link_gest "[export_url_vars last_cod_dimp nome_funz nome_funz_caller extra_par caller cod_impianto url_list_aimp url_aimp url_gage flag_no_link cod_opma data_ins tabella]"

#innes set link_scansionati  "\[export_url_vars cod_dimp  cod_impianto url_list_aimp url_aimp last_cod_dimp nome_funz nome_funz_caller extra_par \]"

#B80 Ticket 41448 - fix inserimento modello F/G - Start
#innesif {$potenza >= 35} {
#innesif {[string range $id_utente 0 1] eq "MA"} {
#innes	set actions "
#innes <td nowrap><a href=\"$gest_prog?funzione=V&flag_tracciato=F&$link\">Selez.</a></td>"
#innes    } else {
#innes	set actions "
#innes <td nowrap><a href=\"$gest_prog?funzione=V&flag_tracciato=F&$link\">Selez.</a> - <a href=\"coimdimp-gen-chg?$link\">Mod.Gen.</a></td>"
#innes    }
    
#innes} else {
#innes    if {[string range $id_utente 0 1] eq "MA"} {
#innes	set actions "
#innes <td nowrap><a href=\"$gest_prog?funzione=V&flag_tracciato=G&$link\">Selez.</a></td>"
#innes    } else {
#innes	set actions "
#innes <td nowrap><a href=\"$gest_prog?funzione=V&flag_tracciato=G&$link\">Selez.</a> - <a href=\"coimdimp-gen-chg?$link\">Mod.Gen.</a></td>"
#innes    }
#innes}
#B80 Ticket 41448 - End

if {$potenza >= 35} {
#    set actions "
# <td nowrap><a href=\"$gest_prog?funzione=V&flag_tracciato=F&dbn_iter=$dbn_iter&targa=$targa&$link\">Selez.</a></td>" 
    set actions "<a href=\"$gest_prog?funzione=V&flag_tracciato=F&dbn_iter=$dbn_iter&targa=$targa&$link\">Selez.</a>"
} else {
#    set actions "
# <td nowrap><a href=\"$gest_prog?funzione=V&flag_tracciato=G&dbn_iter=$dbn_iter&targa=$targa&$link\">Selez.</a></td>"   
    set actions "<a href=\"$gest_prog?funzione=V&flag_tracciato=G&dbn_iter=$dbn_iter&targa=$targa&$link\">Selez.</a>"
}
set js_function ""

#innesset azioni_aggiuntive "
#innes<td align=center><table cellpadding=0 cellspacing=0 border=0><tr>
#innes    <td align=center><a href=\"coimdimp-alle-ins?tabella=coimdimp&$link_scansionati\">Allega scansione</a></td>
#innes    <td align=center>&nbsp;<a href=\"coimdimp-alle-view?tabella=coimdimp&$link_scansionati\">Vedi scansione</a></td>
#innes    <td align=center>&nbsp;<a href=\"coimdimp-alle-delete?tabella=coimdimp&$link_scansionati\"onClick=\"javascript:return(confirm('Confermi eliminazione scansionato allegato?'))\">Elimina scansione</a></td>"

#innesif {$flag_portafoglio == "T"} {

#innes    if {$ruolo eq "manutentore"} {;#sim02

#innes	append azioni_aggiuntive "
#innes    <td align=center>&nbsp;<a href=\"$gest_prog_2?funzione=M&$link&tabella=stn\"onClick=\"javascript:return(confirm('Confermi accesso alla gestione di una dichiarazione sostitutiva che storni la presente?'))\">Ins. mod. sost.</a></td>
#innes    <td align=center>&nbsp;<a href=\"coimdimp-ricmot-storno?$link\"onClick=\"javascript:return(confirm('Confermi richiesta?'))\">Richiedi storno</a></td>
#innes"
#innes    };#sim02

#innes    if {$ruolo != "manutentore" && $ruolo != "ammin"} {
	
	#sim02 append azioni_aggiuntive "
        #sim02 <td align=center>&nbsp;<a href=\"coimdimp-acc-storno?$link\"onClick=\"javascript:return(confirm('Confermi accettazione storno?'))\">Accetta storno</a></td>"
        
#innes	append azioni_aggiuntive "
#innes        <td align=center>&nbsp;<a href=\"coimdimp-rif-storno?$link\"onClick=\"javascript:return(confirm('Confermi rifiuto storno?'))\">Rifiuta storno</a></td>
#innes        "
#innes    }
#innes}

#innes append azioni_aggiuntive "</tr></table></td>"


set table_def [list \
		   [list actions_portale     "Azioni"          no_sort {l}] \
		   [list cod_dimp            "Cod.Int."        no_sort {c}] \
		   [list data_controllo_edit "Data"            no_sort {c}] \
		   [list desc_manutentore    "Manut."          no_sort {l}] \
		   [list desc_responsabile   "Resp."           no_sort {l}] \
		   [list flag_status         "Esito"           no_sort {c}] \
		   [list flag_tracciato_edit "Tipo"            no_sort {c}] \
		   [list cod_docu_distinta   "Distinta"        no_sort {c}] \
		   [list riferimento_pag     "Att.Pagam."      no_sort {c}] \
		  ]
#innes		   [list stato_storno        " "               no_sort {c}] \
#innes		   [list azioni_aggiuntive   "Altre Azioni"    no_sort $azioni_aggiuntive] \


# imposto la query SQL 
if {[string equal $search_word ""]} {
    set where_word ""
} else {
    set search_word_1 [iter_search_word $search_word]
    set where_word  " and upper(c.cognome) like upper(:search_word_1)"
}

# imposto la condizione per la prossima pagina
if {![string is space $last_cod_dimp]} {
    set data_controllo [lindex $last_cod_dimp 0]
    set cod_dimp       [lindex $last_cod_dimp 1]
    
    #nic01 set where_last " and (  (   a.data_controllo = :data_controllo 
    #nic01                  --sim01 or a.cod_dimp      >= :cod_dimp)
    #nic01                         and a.cod_dimp      >= :cod_dimp) --sim01
    #nic01                       or    a.data_controllo > :data_controllo)"

    set where_last " and (  (    a.data_controllo  = :data_controllo 
                             and a.cod_dimp       <= :cod_dimp)
                          or     a.data_controllo <  :data_controllo)";#nic01

} else {
    set where_last ""
}

# imposto filtro per impianto
#innes if {![string is space $cod_impianto]} {
#innes    set where_aimp "and a.cod_impianto = :cod_impianto"
#innes } else {
#innes    set where_aimp ""
#innes}
if {![string is space $cod_impianto]} {

    if {$flag_gest_targa eq "F"} {
	set where_aimp "and i.cod_impianto=:cod_impianto"
    } else {
	set where_aimp "and i.targa = :targa"
    }
} else {
    set where_aimp ""
}
#innes 
set where_tracciato ""
set where_tracciato " and a.flag_tracciato not in ('H', 'HB', 'G', 'F')"

    
set sel_dimp [db_map sel_dimp]

#sim01 aggiunto data_controllo altrimenti la pagina andava in errore 
set table_result [ad_table -dbn $dbn_iter -Tmax_rows $rows_per_page -Tmissing_text "Nessun dato corrisponde ai criteri impostati." -Textra_vars {cod_dimp data_controllo cod_impianto last_cod_dimp nome_funz nome_funz_caller extra_par url_list_aimp url_aimp flag_tracciato} go $sel_dimp $table_def]

# preparo url escludendo last_cod_dimp che viene passato esplicitamente
# per poi preparare il link alla prima ed eventualmente alla prossima pagina
set url_vars [export_ns_set_vars "url" last_cod_dimp]
set link_altre_pagine "Vai alla <a href=\"$curr_prog?$url_vars\">prima pagina</a>"

# preparo link a pagina successiva
# sim01: Visto che nella lista c'è un <tr>, devo cercare "<tr " e non <tr.
# sim01 set ctr_rec [expr [regsub -all <tr $table_result <tr comodo] -1]
set ctr_rec [expr [regsub -all "<tr " $table_result "<tr " comodo] -1];#sim01

if {$ctr_rec == $rows_per_page} {
    #sim01 set last_cod_dimp [list data_controllo cod_dimp]
    set last_cod_dimp [list $data_controllo $cod_dimp];#sim01
    append url_vars "&[export_url_vars last_cod_dimp]"
    append link_altre_pagine " o alla <a href=\"$curr_prog?$url_vars\">pagina successiva</a>"
}

# creo testata della lista
set list_head [iter_list_head  $form_di_ricerca $col_di_ricerca \
              $link_aggiungi $link_altre_pagine $link_righe "Righe per pagina"]


if {$flag_sup == "S"} {
    ##lista allegati
    set link    "\[export_url_vars cod_nove cod_impianto url_list_aimp url_aimp nome_funz nome_funz_caller extra_par targa \]"
    set actions2 "<td nowrap><a href=\"coimnove-gest?funzione=V&$link\">Selez.</a></td>"
    set js_function ""
    
    # imposto la struttura della tabella
    set table_def2 [list \
			[list actions             "Azioni"                  no_sort $actions2] \
			[list cod_nove            "Progressivo"             no_sort {l}] \
			[list data_consegna       "Data consegna"           no_sort {c}] \
			[list desc_manu           "Manutentore"             no_sort {l}] \
		       ]
    
    set sel_nove [db_map sel_nove]
    
    set table_result2 [ad_table -dbn $dbn_iter -Tmax_rows $rows_per_page -Tmissing_text "Nessun dato corrisponde ai criteri impostati." -Textra_vars {cod_nove cod_impianto nome_funz nome_funz_caller extra_par url_list_aimp url_aimp} go $sel_nove $table_def2]


    ##lista allegati
    set link    "\[export_url_vars cod_noveb cod_impianto url_list_aimp url_aimp nome_funz nome_funz_caller extra_par targa \]"
    set actions3 "<td nowrap><a href=\"coimnoveb-gest?funzione=V&$link\">Selez.</a></td>"
    set js_function ""
    
    # imposto la struttura della tabella
    set table_def3 [list \
			[list actions             "Azioni"                  no_sort $actions3] \
			[list cod_noveb           "Progressivo"             no_sort {l}] \
			[list data_consegna       "Data consegna"           no_sort {c}] \
			[list desc_manu           "Manutentore"             no_sort {l}] \
		       ]
    
    set sel_noveb [db_map sel_noveb]
    
    set table_result3 [ad_table -dbn $dbn_iter -Tmax_rows $rows_per_page -Tmissing_text "Nessun dato corrisponde ai criteri impostati." -Textra_vars {cod_noveb cod_impianto nome_funz nome_funz_caller extra_par url_list_aimp url_aimp} go $sel_noveb $table_def3]
}

if {$sw_dichiarazioni_frequenza eq "t"} {#ant01: aggiunta if ed il suo contenuto
    # Lista delle dichiarazioni di frequenza ed elenco operazioni di controllo
    set link "\[export_url_vars cod_dope_aimp cod_impianto url_list_aimp url_aimp last_cod_dimp nome_funz nome_funz_caller extra_par targa \]"
  #  set cod_dope_aimp [db_string -dbn $dbn_iter q "select cod_dope_aimp
   #                                                      from coimdope_aimp
    #                                                   where cod_impianto = :cod_impianto" -default ""]
    
    set actions4 "<td nowrap><a href=\"coimdope-aimp-gest?$link&funzione=V&targa=$targa&dbn_iter=$dbn_iter\">Selez.</a> <a href=\"coimdope-aimp-layout?$link&dbn_iter=$dbn_iter&targa=$targa\">Stampa</a></td>"
    
    set table_def4 [list \
			[list actions        "Azioni"       no_sort $actions4] \
			[list cod_dope_aimp  "Cod.Int."     no_sort {r}] \
			[list data_dich      "Data Dich."   no_sort {c}] \
			[list desc_manu      "Manutentore"  no_sort {l}] \
			[list tipo_dich      "Tipo Dich."   no_sort {l}] \
		       ]

    set table_result4 [ad_table \
			   -dbn $dbn_iter \
			   -Tmax_rows $rows_per_page \
			   -Tmissing_text "Nessun dato corrisponde ai criteri impostati." \
			   -Textra_vars {cod_dope_aimp cod_impianto nome_funz nome_funz_caller extra_par url_list_aimp url_aimp} \
			   go [db_map sel_coimdope] \
			   $table_def4]
} 

db_release_unused_handles
ad_return_template 
