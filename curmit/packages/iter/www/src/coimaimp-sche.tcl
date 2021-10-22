ad_page_contract {

    @author          Paolo Formizzi Adhoc
    @creation-date   18/05/2004

    @cvs-id          coimaimp-sche.tcl

    @Ogni modifica apportata a questo programma va apportata anche al sorgente clone presente
    @su iter-portal-dev/packages/iter-portal/www

    USER  DATA       MODIFICHE
    ===== ========== ========================================================================================
    rom25 04/08/2021 Su segnalazione di regione Marche corretta la visualizzazione delle schede 6.3, 6.4, 7 e 9.5

    rom24 28/01/2021 Corretta Sezione 4.2: per capire meglio ora espongo anche il codice impianto del bruciatore
    rom24            a fianco del numero del generatore; corrette le chiusure delle table che erano sbagliate.

    rom23 21/01/2021 Corretta anomalia presente per gli RCEE appartenenti ad impianti diversi con la stessa targa.
    rom23            Nella sezione 14.1 per tutti gli enti mostro anche il codice impianto e il generatore per
    rom23            i quali vado a scrivere i consumi di combustibile.
    
    rom22 03/11/2020 Corretta anomalia nella sezione 1 bis delle Marche: non venivano calcolati giustamente
    rom22            gli anni del segno identificativo per gli impianti del caldo che hanno piu' generatori
    rom22            con una potenza superiore ai 100 Kw.

    rom21 26/08/2020 Corretta anomalia nella sezione 1 bis delle Marche: non venivano calcolati giustamente
    rom21            gli anni del segno identificativo.

    rom20 28/05/2020 Corretto intervento di rom19: Nella schema 1.3 vanno sommate tutte le potenze che hanno
    rom20            la stessa targa.

    rom19 26/05/2020 Modificata scheda 1.3 per Regione Marche: nella Climatizzazione invernale bisogna vedere
    rom19            la somma delle potenze utili in riscaldamento. Nella Climatizzazione estiva bisogna vedere
    rom19            la somma delle potenze utili in raffrescamento.
    
    sim10 07/03/2019 Per la regione i file verranno salvati su file system non sul  db

    rom18 26/02/2019 Modificata la scheda 1.3 per la regione Marche. Per le Marche utilizzo i campi del generatore
    rom18            flag_clima_invernale, flag_clim_est e flag_prod_acqua_calda; siccome per ogni generatore
    rom18            potrei avere fleggato campi diversi Sandro ha detto che nella scheda1.3 mostro sempre
    rom18            i campi del primo generatore attivo.
    rom18            Modificata scheda 1.bis per la Regione: se il proprietario e' diverso dal responsabile 
    rom18            mostro anche i suoi dati.

    rom17 15/02/2019 Aggiunta la sezione 4.4bis, 4.5bis e 4.6bis per la regione Marche

    rom16 19/01/2019 Modifiche per impianti del freddo richiesti dalle marche

    rom15 16/01/2019 Aggiunti i nuovi campi per i generatori del freddo sorgente_lato_esterno e fluido_lato_utenze.
    
    gac11 11/01/2019 Aggiunto codice impianto su schede 3, 4.1, 4.1bis, 4.4, 4.4bis, 4.6, 4.7, 4.8, 5.1, 5.2,
    gac11            5.3, 5.4, 6, 7, 8, 9, 12, 13, 14

    rom14 04/01/2019 Aggiunte le nuove opzioni per il campo integrazione_per.

    gac10 24/12/2018 Aggiunto modifiche per le tabelle della scheda 1 bis per impianto del freddo

    gac09 18/12/2018 Aggiunto linee tabella per la scheda 4.1 bis e copiata frase dalla scheda 4 e aggiunta
    gac09            alla scheda 4.1

    gac08 17/12/2018 Su richiesta di Sandro aggiunta una pagina bianca dopo la prima pagina del libretto

    rom13 11/12/2018 Gestita la sostituzione dei componenti per le schede 4.1, 4.1bis, 4.4, 4.5 e 4.6

    rom12 30/11/2018 Modificato intervento di rom09: il campo funzione_grup_ter non è più usato, al suo posto
    rom12            uso i nuovi campi flag_clima_invernale, flag_clim_est,flag_prod_acqua_calda e flag_altro.
    
    rom11 13/11/2018 Solo per le Marche: Rivisitata la Scheda 5 per "Sistema reg.ne" e "Valvola reg.ne".

    rom10 07/11/2018 Aggiunti alla Scheda 2.5 i nuovi campi tratt_acqua_raff_filtraz_note_altro,
    rom10            tratt_acqua_raff_tratt_note_altro e tratt_acqua_raff_cond_note_altro.
    rom10            Scheda 4.7: in base al valore el flag_sostituito gestisco la compilazione automatica 
    rom10            della "Variazione del campo solare termico".
    rom10            Rivista la Scheda 7: non uso più il campo sistem_emis_tipo.
    rom10            Rivista la Scheda 8: aggiunto il campo coibentazione e coibentazione_sost_comp.
    rom10            Rivista la Scheda 9.6: gestisco in maniera differente i campi rc_uta_vmc_sost_comp e
    rom10            rc_uta_vmc.
    
    rom09 05/10/2018 Per regione Marche: Gestita in maniera differente la compilazione della Scheda 1.3:
    rom09            non uso più il campo cod_utgi ma il campo funzione_grup_ter.

    rom08 04/10/2018 Rimodificata l'impaginazione della Scheda 3 per la Regione Marche.

    rom07 05/09/2018 Cambiata la gestione delle Schede 4.3, 4.8, 6.4, 8, 9.1, 9.2, 9.3, 9.4, 9.5, 9.6, 10.1
    rom07            su richiesta della Regione Marche: in base al valore del flag_sostituito gestisco 
    rom07            la compilazione automatica dei "Sostituti del componente" che prima erano compilabili a mano.

    rom06 09/08/2018 Cambiata impaginazione per la Scheda 3 del libretto per la Regione Marche  

    gac07 29/06/2018 Aggiunti campi integrazione, superficie_integrazione, nota_altra_integrazione e 
    gac07            pot_utile_integrazione

    rom05 19/06/2018 Gestita la tipologia intervento con il nuovo campo tipologia_intervento della coimaimp
    rom05            al posto del parametro f_tipo_inte.

    gac06 08/06/2018 Aggiunti campi elettricita

    gac05 07/06/2018 Aggiunti campi tipologia_generatore e integrazione_per 

    rom04M24/05/2018 Aggiunta dicitura in testa alla pagina 'Data scadenza RCEE' se i contributi 
    rom04M            son stati pagati regolarmente. 

    gac04 09/05/2018 Aggiunti nuovi campi alla scheda 11

    gac03 03/05/2018 Aggiunti nuovi campi rce alla scheda 14

    gac02 18/04/2018 Aggiunta sezione 'Scheda 1Bis Dati Generali' per la Regione Marche

    rom03 16/04/2018 Aggiunta sezione 'Scheda 4.1 bis' per la Regione Marche.
    rom03.bis       16/11/2018 Aggiunto controllo su tipologia_intervento.
    
    gac01 07/02/2018 Aggiunto titolo 1. Scheda identificativa dell'impianto, rifatto sezione 3 come richiesto
    gac01            da Simone e gestita la paginazione sempre della sezione 3

    rom02 02/02/2018 Aggiunto sezioni 4.5 e 11.3 relativi al teleriscaldamento

    rom01 01/02/2018 Modificato sezioni 11 per gestire meglio la paginazione

    sim09 23/01/2018 Rivista sezione 4.4 e 11

    sim08 05/10/2017 Sandro ha detto che al posto dell'allegato E2 va visualizzato la prima
    sim08            pagina del libretto.
    sim08            Aggiunto la data odierna sulla prima pagina.
    sim08            Gestito la scelta del tipo intervento mediante il filtro f_tipo_inte

    sim07 28/12/2016 Fatto in modo che se la matricola contiene > o < l'html venga scritto
    sim07            correttamente.

    ale01 28/11/2016 Eliminate le tabelle doppie "Ditte tecnici" e "Soggetti responsabili"

    sim06 26/10/2016 Corretto visualizzazione in pagina del logo.

    sim05 26/10/2016 Aggiunto dicitura in testa alla pagina se i contributi son stati pagati regolarmente

    gab05 24/10/2016 Aggiunta estrazione dei generatori padre anche per la sezione 4.4 (Freddo)

    gab04 16/09/2016 Aggiunte sezioni 9.5, 9.6 e 10.1 del libretto

    sim04 06/09/2016 Se il parmetro flag_gest_targa e' attivo,
    sim04            visualizzo il campo targa e non il cod impianto princ.

    gab03 17/08/2016 Aggiunte sezioni 7 - 8.1 - 9.1 - 9.2 - 9.3 - 9.4 del libretto.

    gab02 14/07/2016 Aggiunte sezioni 4.3, 4.7, 4.8 e 6 al libretto.

    gab01 13/07/2016 Tolta numerazione delle pagine su richiesta degli utenti e di Sandro.
   
    sim03 21/06/2016 Aggiunta del logo alla stampa utilizzando i parametri stampe_logo_nome
    sim03            e stampe_logo_in_tutte_le_stampe.

    nic02 24/05/2016 Nella scheda impianto, non compaiono i generatori del freddo
    nic02            (segnalato da ASPES: Comune di Pesaro).

    nic01 23/11/2015 Segnalazione della Provincia di Pesaro Urbino: se sul generatore e' stata
    nic01            selezionata la Dest. d'uso Riscaldamento + produzione acqua
    nic01            (cod_utgi = 'E'), nella stampa del libretto, alla voce 1.3, bisogna
    nic01            selezionare anche la spunta su 'produzione acqua calda sanitaria'.

    sim02 11/11/2014 Gestito nuovi campi e modificato il layout della stampa libretto

    sim01 10/09/2014 Aggiunto link al file Libretto-compilabile.pdf con commento sottostante
    sim01            Rivisto complessivamente il layout e Sandro ha fatto altre modifiche
} {
    {cod_impianto      ""}
    {funzione         "V"}
    {caller       "index"}
    {nome_funz         ""}
    {nome_funz_caller  ""}
    {url_aimp          ""}
    {url_list_aimp     ""}
    {flag_aces         ""}
    {cod_aces          ""}
    {url_coimaces_list ""}
    {flag_call         ""}
    {f_cognome         ""}
    {f_nome            ""}
    {f_desc_topo       ""}
    {f_desc_via        ""}
    {stato_01          ""}
    {flag_no_links    "F"}
    {f_tipo_inte      ""}
} -properties {
    page_title:onevalue
    context_bar:onevalue
    form_name:onevalue
}

if {[db_get_database] eq "iterprmi"} {
   ad_return_if_another_copy_is_running
}

set where_gend_sost ""

# B80: RECUPERO LO USER - INTRUSIONE
set id_utente [ad_get_cookie iter_login_[ns_conn location]]
set id_utente_loggato_vero [ad_get_client_property iter logged_user_id]
set session_id [ad_conn session_id]
set adsession [ad_get_cookie "ad_session_id"]
set referrer [ns_set get [ad_conn headers] Referer]
set clientip [lindex [ns_set iget [ns_conn headers] x-forwarded-for] end]

# if {$referrer == ""} {
#	set login [ad_conn package_url]
#	ns_log Notice "********AUTH-CHECK-SCHEDA-KO-REFERER;ip-$clientip;$id_utente;$id_utente_loggato_vero;$session_id;$nome_funz;$adsession;"
#	iter_return_complaint "Accesso non consentito! Per accedere a questo programma devi prima eseguire la procedura di <a href=$login>Login.</a>"
#	return 0
#    } 
#if {$id_utente != $id_utente_loggato_vero} {
#    set login [ad_conn package_url]
#    ns_log Notice "********AUTH-CHECK-SCHEDA-KO-USER;ip-$clientip;$id_utente;$id_utente_loggato_vero;$session_id;$nome_funz;$adsession;"
#    iter_return_complaint "Accesso non consentito! Per accedere a questo programma devi prima eseguire la procedura di <a href=$login>Login.</a>"
#    return 0
#} else {
#    ns_log Notice "********AUTH-CHECK-SCHEDA-OK;ip-$clientip;$id_utente;$id_utente_loggato_vero;$session_id;$nome_funz;$adsession;"
#}
# ***

##set lvl 1
##set id_utente [lindex [iter_check_login $lvl $nome_funz] 1]

# controllo il parametro di "propagazione" per la navigation bar
if {[string is space $nome_funz_caller]} {
    set nome_funz_caller $nome_funz
}

if {$flag_aces == "S"} {
    set link_tab [iter_links_aces $cod_aces $nome_funz_caller $url_coimaces_list $flag_call $stato_01]
    set dett_tab [iter_tab_aces $cod_aces $f_cognome $f_nome $f_desc_topo $f_desc_via]
} else {
    if {$flag_no_links == "F"} { 
	set link_tab [iter_links_form $cod_impianto $nome_funz_caller $url_list_aimp $url_aimp]
    }
    set dett_tab [iter_tab_form $cod_impianto]
}

# imposto variabili usate nel programma:
set sysdate_edit [list [iter_edit_date [iter_set_sysdate]] [iter_set_systime]]

# imposta le class css della barra delle funzioni
iter_set_func_class $funzione

# Personalizzo la pagina
set titolo       "Stampa Scheda Tecnica"
set page_title   "Stampa Scheda Tecnica"

db_1row q "select current_date as oggi, to_char(current_date, 'DD/MM/YYYY') as oggi_pretty";#sim05

# se il flag no links e' attivo imposto il context bar a "chiudi finestra"
# perche in questo caso la pagina e' stata aperta come un'altra finestra
if {$flag_no_links == "T"} {
    set context_bar [iter_context_bar \
			 [list "javascript:window.close()" "Chiudi finestra"] \
			 "$page_title"]
} else {
    set context_bar  [iter_context_bar -nome_funz $nome_funz_caller]
}

iter_get_coimtgen
set flag_viario     $coimtgen(flag_viario)
set flag_gest_targa $coimtgen(flag_gest_targa);#sim04

#rom03 Per le Marche se si vuole stampare il libretto è necessario che il campo data_libretto sia valorizzato nella "Scheda 1 Dati Tecnici"
#rom03 altrimenti faccio un redirect su "coimaimp-gest" per farlo inserire
#rom03.bis Oltre che il campo data_libretto è necessario che sia valorizzato anche tipologia_intervento nella "Scheda 1 Dati Tecnici"
if {$coimtgen(regione) eq "MARCHE"} {#rom03 if e suo contenuto
    if {![db_0or1row q "select data_libretto as oggi
                             , to_char(data_libretto, 'DD/MM/YYYY') as oggi_pretty
                             , to_char(data_scad_dich, 'DD/MM/YYYY') as data_scad_dich_pretty --rom04M
                             , tipologia_intervento --rom03.bis
                          from coimaimp
                         where data_libretto is not null
                           and tipologia_intervento is not null --rom03.bis
                           and cod_impianto = :cod_impianto"]
    } {
	set f_data_libretto "t"
	set link_list "[export_url_vars cod_impianto url_list_aimp nome_funz_caller url_aimp f_data_libretto]&nome_funz=[iter_get_nomefunz coimaimp-list]"
	ad_returnredirect  "coimaimp-gest?&funzione=M&$link_list"
    }
};#rom03


db_1row gen "
select count(*) as numero_gend
  from coimgend
 where cod_impianto = :cod_impianto
   and flag_attivo = 'S'"

#sim02 Sandro mi ha detto di prendere i dati che servono alla stampa dal primo generatore
if {![db_0or1row query "
    select cod_utgi
         , mod_funz
      from coimgend
     where cod_impianto = :cod_impianto
       and flag_attivo  = 'S'
  order by gen_prog
     limit 1
     "]
} {
    set cod_utgi "";#sim02
    set mod_funz "";#sim02
};#sim02

set where_flag_tracciato ""

iter_get_coimdesc
set nome_ente    $coimdesc(nome_ente)
set tipo_ufficio $coimdesc(tipo_ufficio)
set assessorato  $coimdesc(assessorato)
set indirizzo    $coimdesc(indirizzo)
set telefono     $coimdesc(telefono)
set resp_uff     $coimdesc(resp_uff)
set uff_info     $coimdesc(uff_info)
set dirigente    $coimdesc(dirigente)

set logo_dir      [iter_set_logo_dir]
set logo_url_relativo [iter_set_logo_dir_url];#sim06 

set stampe_logo_in_tutte_le_stampe [parameter::get_from_package_key -package_key iter -parameter stampe_logo_in_tutte_le_stampe -default "0"];#sim03
set stampe_logo_nome                        [parameter::get_from_package_key -package_key iter -parameter stampe_logo_nome];#sim03
set stampe_logo_height                      [parameter::get_from_package_key -package_key iter -parameter stampe_logo_height];#sim03

if {$stampe_logo_in_tutte_le_stampe eq "1" && $stampe_logo_nome ne ""} {#sim03 aggiunta if e suo contenuto
    if {$stampe_logo_height ne ""} {
	set height_logo "height=$stampe_logo_height"
    } else {
	set height_logo ""
    }	
    set logo "<img src=$logo_dir/$stampe_logo_nome $height_logo>"
    set logo_relativo "<img src=$logo_url_relativo/$stampe_logo_nome $height_logo>";#sim06
} else {
    set logo ""
    set logo_relativo "";#sim06
}

#gab01 Tolta numerazione delle pagine su richiesta degli utenti:
#gab01 Prima della modifica, prima di FOOTER LEFT c'era:
#gab01 <!-- FOOTER RIGHT  \"Pagina \$PAGE(1) di \$PAGES(1)\"-->
#rom03 Per le Marche nel footer faccio vedere la data_libretto, per gli altri metto la data di oggi
if {$coimtgen(regione) ne "MARCHE"} {#rom03 aggiunta if ed else
    set testata "
<!-- FOOTER LEFT   \"$sysdate_edit $id_utente\"-->
"
} else {
    set testata "
<!-- FOOTER LEFT   \"$oggi_pretty $id_utente\"-->
"
};#rom03


if {$stampe_logo_in_tutte_le_stampe eq "1" && $stampe_logo_nome ne ""} {#sim03: aggiunta if e suo contenuto
    append testata "<table width=100%> 
    <tr>
      <td width=20%>$logo</td>
      <td width=60% align=center>"
}

append testata "<table width=100%>
      <tr>
         <td align=center>$nome_ente</td>
      </tr>
      <tr>
         <td align=center>$tipo_ufficio</td>
      </tr>
      <tr>
         <td align=center>$assessorato</td>
      </tr>
      <tr>
         <td align=center><small>$indirizzo</small></td>
      </tr>
      <tr>
         <td align=center><small>$telefono</small></td>
      </tr>
      <tr>
         <td align=center>&nbsp;</td>
      </tr>
</table>"

if {$stampe_logo_in_tutte_le_stampe eq "1" && $stampe_logo_nome ne ""} {#sim03: aggiunta if e suo contenuto
    append testata "
      </td>
      <td width=20%></td>
   </tr>
</table>
" 
}

set ctr 0

if {$flag_viario == "T"} {
    set sel_aimp_2 "sel_aimp_si_viae"
    set sel_stub   "sel_stub_si_viae"
} else {
    set sel_aimp_2 "sel_aimp_no_viae"
    set sel_stub   "sel_stub_no_viae"
}

set stampa ""
append stampa $testata

db_0or1row sel_aimp ""

# Ubicazione
if {[db_0or1row $sel_aimp_2 ""] == 0} {
    iter_return_complaint "Impianto non trovato"
} else {

    if {$flag_gest_targa eq "T"} {#sim04: aggiunta if e suo contenuto
	set cod_impianto_princ_stampa $targa
    } else {
	if {$cod_impianto_princ ne ""} {
	    set cod_impianto_princ_stampa $cod_impianto_princ
	} else {
	    set cod_impianto_princ_stampa $cod_impianto_est
	}
    }

    append stampa "
    <table width=100%>
          <tr>
             <td align=center><big><b>Codice catasto/Targa: $cod_impianto_princ_stampa</b></big></td>
          </tr>
          <tr>
             <td>&nbsp;</td>
          </tr>
    </table>
    <table width=100% align=center border>
          <tr>
             <td align=center colspan=2><b>Ubicazione Impianto</b></td>
          </tr>
          <tr>
             <td align=center><b>Indirizzo</b></td>
             <td align=center><b>Data fine validit&agrave;</b></td>
          </tr>
          <tr>
             <td>$indir $nome_comu ($sigla) $cap</td>
             <td align=center>Attuale</td>
          </tr>"

    db_foreach $sel_stub "" {
	append stampa "
          <tr>
             <td>$indir $nome_comu_st ($sigla) $cap</td>
             <td align=center>$data_fin_valid</td>
          </tr>"
    }

    append stampa "</table>
    <table width=100%>
          <tr>
             <td>&nbsp;</td>
          <tr>
    </table>"

}

# Responsabile
if {[db_0or1row sel_resp ""] == 0} {
    iter_return_complaint "Impianto non trovato"
} else {

    if {[string is space $nome_resp]} {
	set nome_resp "&nbsp;"
    }

    append stampa "
    <table width=100% align=center border>
          <tr>
             <td align=center colspan=2><b>Responsabile</b></td>
          </tr>
          <tr>
             <td>$nome_resp</td>
             <td>$indir_r $nome_comu_r ($sigla_r) $cap_r - $tel</td>
          </tr>"

    append stampa "</table>
    <table width=100%>
          <tr>
             <td>&nbsp;</td>
          <tr>
    </table>"

}

# Dati impianto
if {[db_0or1row sel_aimp ""] == 0} {

    iter_return_complaint "Impianto non trovato"
} else {
    set cod_comb $cod_combustibile
    set installatore_iniziale [db_string q "select coalesce(coalesce(cognome,'') || coalesce(nome,''), '_____________')
                                              from coimmanu 
                                              where cod_manutentore='$cod_installatore'" -default ""]
    append stampa "
    <table width=100% align=center border>
          <tr>
             <td align=center colspan=2><b>Dati generali</b></td>
          </tr>
          <tr>
             <td><b>Dato</b></td>
             <td><b>Valore</b></td>
          </tr>
          <tr>
             <td>Dichiarato</td>
             <td>$desc_dich</td>
          </tr>
          <tr>
             <td>Data ultimo RCEE</td>
             <td>$data_ult</td>
          </tr>
          <tr>
             <td>Data primo RCEE</td>
             <td>$data_pri</td>
          </tr>
          <tr>
             <td>Tipo impianto</td>
             <td>$descr_tpim</td>
          </tr>
          <tr>
             <td>Num. generatori</td>
             <td>$n_generatori</td>
          </tr>
          <tr>
             <td>Combustibile</td>
             <td>$comb</td>
          </tr>
          <tr>
             <td>Consumo annuo</td>
             <td>$consumo_annuo</td>
          </tr>
          <tr>
             <td>Tariffa</td>
             <td>$desc_tariffa</td>
          </tr>
          <tr>
             <td>Categoria edificio</td>
             <td>$descr_cted</td>
          </tr>
          <tr>
             <td>Data installazione</td>
             <td>$data_insta</td>
          </tr>
          <tr>
             <td>Data attivazione</td>
             <td>$data_att</td>
          </tr>
          <tr>
             <td>Data rottamazione</td>
             <td>$data_rott</td>
          </tr>
          <tr>
             <td>Potenza focolare</td>
             <td>$potenza</td>
          </tr>
          <tr>
             <td>Potenza utile</td>
             <td>$potenza_utile</td>
          </tr>
          <tr>
             <td>Codice utenza</td>
             <td>$cod_amag</td>
          </tr>
          <tr>
             <td>Provenienza dati</td>
             <td>$descr_prov</td>
          </tr>"

    append stampa "</table>
    <table width=100%>
          <tr>
             <td>&nbsp;</td>
          <tr>
    </table>"
}
if {$data_scad_dich > $oggi} {;#sim05 if else e suo contributo
    set msg_contributi "Contributi corrisposti correttamente al $oggi_pretty"
    if {$coimtgen(regione) eq "MARCHE"} {
	set msg_data_dich  "Data scadenza RCEE: $data_scad_dich_pretty" ;#rom04M
    } else {
	set msg_data_dich ""
    }
} else {
    set msg_contributi ""
    set msg_data_dich ""
}

# Generatori
append stampa "
<table width=100% align=center border>
       <tr>
          <td align=center colspan=8><b>Generatori</b></td>
       </tr>
       <tr>
          <td align=center><b>N.Gen.      </b></td>
          <td align=center><b>Matricola   </b></td>
          <td align=center><b>Costruttore </b></td>
          <td align=center><b>Modello     </b></td>
          <td align=center><b>Combustibile</b></td>
          <td align=center><b>Data inst.  </b></td>
          <td align=center><b>Potenza     </b></td>
          <td align=center><b>Stato Gen.  </b></td>
       </tr>"

set ctr_gend_scheda 0;#nic02
db_foreach sel_gend_ri "" {
    incr ctr_gend_scheda;#nic02
    regsub -all {<} $matricola {\&lt;} matricola;#sim07
    regsub -all {>} $matricola {\&gt;} matricola;#sim07
    append stampa "
       <tr>
          <td align=right>$gen_prog_est</td>
          <td>$matricola</td>
          <td>$costruttore_gend</td>
          <td>$modello</td>
          <td>$descr_comb</td>
          <td align=center>$data_installaz</td>
          <td align=right>$pot_focolare_lib</td>
          <td align=center><b>$stato_gen</b></td>
       </tr>"
} if_no_rows {
#nic02    append stampa "
#nic02    <tr>
#nic02       <td colspan=6>Non esiste alcun generatore</td>
#nic02    </tr>"
}

db_foreach sel_gend_fr "" {#nic02: aggiunta db_foreach e suo contenuto
    incr ctr_gend_scheda;#nic02
    regsub -all {<} $matricola_fr {\&lt;} matricola_fr;#sim07
    regsub -all {>} $matricola_fr {\&gt;} matricola_fr;#sim07
    append stampa "
       <tr>
          <td align=right>$gen_prog_est_fr</td>
          <td>$matricola_fr</td>
          <td>$costruttore_gend_fr</td>
          <td>$modello_fr</td>
          <td>$descr_comb_fr</td>
          <td align=center>$data_installaz_fr</td>
          <td align=right>$pot_focolare_lib_fr</td>
          <td align=center><b>$stato_gen_fr</b></td>
       </tr>"
}

if {$ctr_gend_scheda == 0} {#nic02: aggiunta if e suo contenuto
    append stampa "
    <tr>
       <td colspan=6>Non esiste alcun generatore</td>
    </tr>"
}

append stampa "</table>
    <table width=100%>
          <tr>
             <td>&nbsp;</td>
          <tr>
    </table>"

# Soggetti
if {[db_0or1row sel_aimp_3 ""] == 0} {
    iter_return_complaint "Impianto non trovato"
} else {
    if {[string is space $nome_inte]} {
	set nome_inte "&nbsp;"
    }
    if {[string is space $nome_prop]} {
	set nome_prop "&nbsp;"
    }
    if {[string is space $nome_occu]} {
	set nome_occu "&nbsp;"
    }
    if {[string is space $nome_ammi]} {
	set nome_ammi "&nbsp;"
    }
    if {[string is space $nome_resp]} {
	set nome_resp "&nbsp;"
    }

    append stampa "
    <!-- PAGE BREAK -->
    <table width=100% align=center border>
          <tr>
             <td align=center colspan=4><b>Soggetti/Responsabili</b></td>
          </tr>
          <tr>
             <td align=center><b>Tipo soggetto</b></td>
             <td align=center><b>Nominativo</b></td>
             <td align=center><b>Indirizzo</b></td>
             <td align=center><b>Data fine validit&agrave;</b></td>
          </tr>
          <tr>
             <td>Intestatario</td>
             <td>$nome_inte</td>
             <td>$indir_i $nome_comu_i ($sigla_i) $cap_i</td>
             <td align=center>Attuale</td>
          </tr>
          <tr>
             <td>Proprietario</td>
             <td>$nome_prop</td>
             <td>$indir_p $nome_comu_p $sigla_p $cap_p</td>
             <td align=center>Attuale</td>
          </tr>
          <tr>
             <td>Occupante</td>
             <td>$nome_occu</td>
             <td>$indir_o $nome_comu_o ($sigla_o) $cap_o</td>
             <td align=center>Attuale</td>
          </tr>
          <tr>
             <td>Amministratore</td>
             <td>$nome_ammi</td>
             <td>$indir_a $nome_comu_a ($sigla_a) $cap_a</td>
             <td align=center>Attuale</td>
          </tr>"

    db_foreach sel_rife "" {
	if {[string is space $nome_sogg]} {
	    set nome_sogg "&nbsp;"
	}
	append stampa "
          <tr>
             <td>$desc_ruolo</td>
             <td>$nome_sogg</td>
             <td>$indir_s $nome_comu_s ($sigla_s) $cap_s</td>
             <td align=center>$data_fin_valid</td>
          </tr>"
    }

    append stampa "</table>
    <table width=100%>
          <tr>
             <td>&nbsp;</td>
          <tr>
    </table>"
}

# Ditte/Tecnici
if {[db_0or1row sel_aimp_4 ""] == 0} {
    iter_return_complaint "Impianto non trovato"
} else {

    if {[string is space $nome_manu]} {
	set nome_manu "&nbsp;"
    }
    if {[string is space $nome_inst]} {
	set nome_inst "&nbsp;"
    }
    if {[string is space $nome_dist]} {
	set nome_dist "&nbsp;"
    }
    if {[string is space $nome_prog]} {
	set nome_prog "&nbsp;"
    }

    append stampa "
    <table width=100% align=center border>
          <tr>
             <td align=center colspan=4><b>Ditte/Tecnici</b></td>
          </tr>
          <tr>
             <td align=center><b>Tipo soggetto</b></td>
             <td align=center><b>Nominativo</b></td>
             <td align=center><b>Indirizzo</b></td>
             <td align=center><b>Data fine validit&agrave;</b></td>
          </tr>
          <tr>
             <td>Manutentore</td>
             <td>$nome_manu</td>
             <td>$indir_m $nome_comu_m ($sigla_m) $cap_m</td>
             <td align=center>Attuale</td>
          </tr>
          <tr>
             <td>Installatore</td>
             <td>$nome_inst</td>
             <td>$indir_i $nome_comu_i ($sigla_i) $cap_i</td>
             <td align=center>Attuale</td>
          </tr>
          <tr>
             <td>Distributore</td>
             <td>$nome_dist</td>
             <td>$indir_d $nome_comu_d ($sigla_d) $cap_d</td>
             <td align=center>Attuale</td>
          </tr>
          <tr>
             <td>Progettista</td>
             <td>$nome_prog</td>
             <td>$indir_g $nome_comu_g ($sigla_g) $cap_g</td>
             <td align=center>Attuale</td>
          </tr>"

    #    db_foreach sel_rife_2 "" {
    #	 if {[string equal $nome_sogg " "]} {
    #	     set nome_sogg "&nbsp;"
    #	 }
    #	 append stampa "
    #          <tr>
    #             <td align=center>$desc_ruolo</td>
    #             <td align=center>$nome_sogg</td>
    #             <td align=center>$indir_s $nome_comu_s ($sigla_s) $cap_s</td>
    #             <td align=center>$data_fin_valid</td>
    #          </tr>"
    #     }
    append stampa "</table>
    <table width=100%>
          <tr>
             <td>&nbsp;</td>
          <tr>
    </table>"
}

# Modelli H
append stampa "
<table width=100% align=center border>
       <tr>
          <td align=center colspan=5><b>Modelli RCEE/DAM/DFM</b></td>
       </tr>
       <tr>
          <td align=center><b>Data controllo  </b></td>
          <td align=center><b>Stato conformit&agrave;</b></td>
          <td align=center><b>Num. prot.      </b></td>
          <td align=center><b>Data prot.      </b></td>
          <td align=center><b>Num. bollino    </b></td>
       </tr>"

db_foreach sel_dimp "" {
    append stampa "
       <tr>
          <td align=center><font color=#1E90FF><b>$data_controllo</b></font></td>
          <td>$desc_status</td>
          <td>$n_prot</td>
          <td align=center>$data_prot</td>
          <td><font color=#1E90FF><b>$num_bollo</b></font></td>
       </tr>"
} if_no_rows {
    append stampa "
    <tr>
       <td colspan=5>Non esistono Modelli</td>
    </tr>"
}

append stampa "</table>
    <table width=100%>
          <tr>
             <td>&nbsp;</td>
          <tr>
    </table>"

# Allegati 284
append stampa "
<table width=100% align=center>
       <tr>
          <td align=center colspan=4><b>Allegati 284</b></td>
       </tr>
       <tr>
          <td colspan=4>&nbsp;</td>
             </tr>"

db_foreach sel_noveb "" {
    append stampa "
       <tr>
          <td align=center>Data Consegna</td>
          <td align=center>$data_consegna</td>
          <td align=center>Manutentore</td>
          <td>$manutentore</td>
  
       </tr>"
} if_no_rows {
    append stampa "
    <tr>
       <td colspan=4>Non esistono Allegati 284</td>
    </tr>"
}

append stampa "</table>
    <table width=100%>
          <tr>
             <td>&nbsp;</td>
          <tr>
    </table>"

# Incontri
append stampa "
<table width=100% align=center border>
       <tr>
          <td align=center colspan=6><b>Appuntamenti per le ispezioni</b></td>
       </tr>
       <tr>
          <td align=center><b>Campagna         </b></td>
          <td align=center><b>Data appuntamento</b></td>
          <td align=center><b>Ora appuntamento </b></td>
          <td align=center><b>Stato            </b></td>
          <td align=center><b>Esito ispezione  </b></td>
          <td align=center><b>Ispettore        </b></td>
       </tr>"

db_foreach sel_inco "" {
    if {[string is space $nome_opve]} {
	set nome_opve "&nbsp;"
    }
    append stampa "
       <tr>
          <td>$desc_camp</td>
          <td align=center><font color=#E30B5C><b>$data_verifica</b></font></td>
          <td align=center>$ora_verifica</td>
          <td>$desc_stato</td>
          <td><font color=#E30B5C><b>$desc_esito</b></font></td>
          <td>$nome_opve</td>
       </tr>"
} if_no_rows {
    append stampa "
    <tr>
       <td colspan=6>Non esistono appuntamenti</td>
    </tr>"
}

append stampa "</table>
    <table width=100%>
          <tr>
             <td>&nbsp;</td>
          <tr>
    </table>"

if {$coimtgen(ente) eq "PUD" || $coimtgen(ente) eq "PGO" || $coimtgen(ente) eq "PPN"} {
    set titolo_dati_fattura "/ Dati Fattura"
} else {
    set titolo_dati_fattura ""
}

# Rapporti di verifica
append stampa "
<table width=100% align=center border>
       <tr>
          <td align=center colspan=6><b>Rapporti di Ispezione</b></td>
       </tr>
       <tr>
          <td align=center><b>Data controllo </b></td>
          <td align=center><b>Esito ispezione $titolo_dati_fattura</b></td>
          <td align=center><b>Num. prot.     </b></td>
          <td align=center><b>Data prot.     </b></td>
          <td align=center><b>Costo ispezione</b></td>
          <td align=center><b>Ispettore      </b></td>
       </tr>"

db_foreach sel_cimp "" {
    if {[string is space $nome_opve]} {
	set nome_opve "&nbsp;"
    }
    if {$coimtgen(ente) eq "PUD" || $coimtgen(ente) eq "PGO" || $coimtgen(ente) eq "PPN"} {
	append desc_esito " - $numfatt - $data_fatt"
    }

    append stampa "
       <tr>
          <td align=center>$data_controllo</td>
          <td>$desc_esito</td>
          <td>$verb_n</td>
          <td align=center>$data_verb</td>
          <td>$costo_verifica</td>
          <td>$nome_opve</td>
       </tr>"

    set si_privol "S"

    db_foreach sel_anom "" {
	if {$si_privol == "S"} {
	    set si_privol "N"
	    set anom "Anomalie:"
	} else {
	    set anom "&nbsp;"
	}
	append stampa "
        <tr>
           <td>$anom</td>
           <td>$cod_tanom</td>
           <td colspan=4>$descr_tano</td>
        </tr>"
    }
} if_no_rows {
    append stampa "
    <tr>
       <td colspan=6>Non esistono rapporti di ispezione</td>
    </tr>"
}

append stampa "</table>
    <table width=100%>
          <tr>
             <td>&nbsp;</td>
          <tr>
    </table>"

# Pagamenti
append stampa "
<table width=100% align=center border>
       <tr>
          <td align=center colspan=6><b>Pagamenti</b></td>
       </tr>
       <tr>
          <td align=center><b>Tipo pag.   </b></td>
          <td align=center><b>Data scad.  </b></td>
          <td align=center><b>Importo     </b></td>
          <td align=center><b>Data pag.   </b></td>
          <td align=center><b>Importo pag.</b></td>
          <td align=center><b>Tipo pag.   </b></td>
          <td align=center><b>Pagato      </b></td>
       </tr>"

db_foreach sel_movi "" {
    append stampa "
       <tr>
          <td>$desc_movi</td>
          <td align=center>$data_scad</td>
          <td align=right>$importo</td>
          <td align=center>$data_pag</td>
          <td align=right>$importo_pag</td>
          <td>$desc_pag</td>
          <td align=center>$flag_pagato</td>
       </tr>"
} if_no_rows {
    append stampa "
    <tr>
       <td colspan=7>Non esistono pagamenti</td>
    </tr>"
}

append stampa "</table>
    <table width=100%>
          <tr>
             <td>&nbsp;</td>
          <tr>
    </table>"

# Provvedimenti
append stampa "
<table width=100% align=center border>
       <tr>
          <td align=center colspan=2><b>Provvedimenti</b></td>
       </tr>
       <tr>
          <td align=center><b>Data provvedimento</b></td>
          <td align=center><b>Causale           </b></td>
       </tr>"

db_foreach sel_prvv "" {
    append stampa "
       <tr>
          <td align=center>$data_provv</td>
          <td>$desc_causale</td>
       </tr>"
} if_no_rows {
    append stampa "
    <tr>
       <td colspan=2>Non esistono provvedimenti</td>
    </tr>"
}

append stampa "</table>
    <table width=100%>
          <tr>
             <td>&nbsp;</td>
          <tr>
    </table>"

# Attività sospese
append stampa "
<table width=100% align=center border>
       <tr>
          <td align=center colspan=3><b>Anomalie da rapporto di ispezione non evase</b></td>
       </tr>
       <tr>
          <td align=center><b>Tipologia     </b></td>
          <td align=center><b>Stato evasione</b></td>
          <td align=center><b>Data evasione </b></td>
       </tr>"

db_foreach sel_todo "" {
    append stampa "
       <tr>
          <td>$desc_tipologia</td>
          <td>$desc_evasione</td>
          <td align=center>$data_evasione</td>
       </tr>"
} if_no_rows {
    append stampa "
    <tr>
       <td colspan=3>Non esistono attivit&agrave; sospese</td>
    </tr>"
}

append stampa "</table>
    <table width=100%>
          <tr>
             <td>&nbsp;</td>
          <tr>
    </table>"

#sim01 setto l'url del pdf del libretto
set file_libretto_pdf "Libretto-compilabile.pdf"

# imposto la directory degli spool ed il loro nome.
set spool_dir     [iter_set_spool_dir]
set spool_dir_url [iter_set_spool_dir_url]

# imposto il nome dei file
set nome_file        "scheda tecnica"
set nome_file        [iter_temp_file_name $nome_file]
set file_html        "$spool_dir/$nome_file.html"
set file_pdf         "$spool_dir/$nome_file.pdf"
set file_pdf_url     "$spool_dir_url/$nome_file.pdf"

set file_id   [open $file_html w]
fconfigure $file_id -encoding iso8859-1

puts $file_id $stampa
close $file_id

# lo trasformo in PDF
iter_crea_pdf [list exec htmldoc --webpage --header ... --footer ... --quiet --bodyfont arial --fontsize 09 --left 1cm --right 1cm --top 1cm --bottom 0.2cm -f $file_pdf $file_html]

# stampa libretto impianto

if {$flag_gest_targa eq "T"} {#sim04: aggiunta if e suo contenuto
    set cod_impianto_princ_stampa $targa
} else {

    if {$cod_impianto_princ ne ""} {
	set cod_impianto_princ_stampa $cod_impianto_princ
    } else {
	set cod_impianto_princ_stampa $cod_impianto_est
    }
}
set table_con_header_per_tutte_le_pagine "
    <table width=100%>
       <tr>
          <td align=center><big><b><font color=grey>Codice catasto/Targa: $cod_impianto_princ_stampa</font></b></big></td>
       </tr>
       <tr>
          <td>&nbsp;</td>
       </tr>
    </table>"


set libretto ""
append libretto $testata
set nome_file3 ""
set nome_file3 "Libretto Imp"
set img_url [iter_set_logo_dir]
set img_checked "<img src=\"$img_url/checked.bmp\" height=12 width=12>";#sim02
set img_unchecked "<img src=\"$img_url/unchecked.bmp\" height=12 width=12>";#sim02
# Ubicazione
if {[db_0or1row $sel_aimp_2 ""] == 0} {
    iter_return_complaint "Impianto non trovato"
} else {


set lista_cod_impianti [list]

if {$flag_gest_targa eq "T"} {

    set lista_cod_impianti [db_list q "select cod_impianto
                                         from coimaimp
                                        where upper(targa)  = upper(:targa)
                                          and stato = 'A'"]

} else {

    set lista_cod_impianti [db_list q "select f.cod_impianto
                                         from coimaimp f
                                   inner join coimaimp h on f.cod_impianto = h.cod_impianto_princ
                                          and f.cod_impianto != h.cod_impianto
                                        where h.cod_impianto = :cod_impianto
                                          and f.stato='A'  --rom25 query che partendo dal figlio trova il padre
                                       union all
                                       select f.cod_impianto
                                         from coimaimp f
                                   inner join coimaimp h 
                                           on h.cod_impianto = f.cod_impianto_princ
                                          and f.cod_impianto != h.cod_impianto
                                        where h.cod_impianto = :cod_impianto
                                          and f.stato='A' --rom25 query che partendo dal padre trova i figli  
                                      "]
    
    lappend lista_cod_impianti $cod_impianto
}


    
    append libretto "
    <table width=100% border=1>
        <tr>
           <td align=center valign=center height=80%><big><b>LIBRETTO IMPIANTO<b></big></td>
        </tr>
    </table>
    <!-- PAGE BREAK --><!--gac08 aggiunto page break dopo la prima pagina del libretto-->
    $table_con_header_per_tutte_le_pagine
    <!-- PAGE BREAK --> 
    $table_con_header_per_tutte_le_pagine";#sim02

    set img_tip_n  $img_unchecked;#sim08
    set img_tip_r  $img_unchecked;#sim08
    set img_tip_s  $img_unchecked;#sim08
    set img_tip_c  $img_unchecked;#sim08
#rom05    if {$f_tipo_inte eq "N"} {#sim08 if e suo contenuto
#rom05	set img_tip_n  $img_checked
#rom05    }
#rom05    if {$f_tipo_inte eq "R"} {#sim08 if e suo contenuto
#rom05	set img_tip_r  $img_checked
#rom05    }
#rom05    if {$f_tipo_inte eq "S"} {#sim08 if e suo contenuto
#rom05	set img_tip_s  $img_checked
#rom05    }
#rom05    if {$f_tipo_inte eq "C"} {#sim08 if e suo contenuto
#rom05	set img_tip_c  $img_checked
#rom05    }

    #rom05 nuova gestione tipologia_intervento
    if {$tipologia_intervento eq "NUINS"} {#rom05 if e contenuto
        set img_tip_n  $img_checked
    }
    if {$tipologia_intervento eq "RISTR"} {#rom05 if e contenuto
        set img_tip_r  $img_checked
    }
    if {$tipologia_intervento eq "SOSGE"} {#rom05 if e contenuto
        set img_tip_s  $img_checked
    }
    if {$tipologia_intervento eq "COLIE"} {#rom05 if e contenuto
        set img_tip_c  $img_checked
    }

    #sim08 aggiunto $oggi_pretty
    #gac01 aggiunto titolo "1. Scheda identificativa dell’impianto"
    append libretto "
    <table width=100% border=1>
          <tr>
             <td align=center bgcolor=\"E1E1E1\"><big><b>1. Scheda identificativa dell&rsquo;impianto</b></big></td>
          </tr>
    </table>
    <table width=100% align=left border=0>
          <tr>
             <td>&nbsp;</td>
          </tr>
         <tr>
             <td>&nbsp;</td>
          </tr>
           <tr>
             <td align=center><b>1.1 Tipologia intervento</b></td>
          </tr>
         <tr>
             <td>&nbsp;</td>
          </tr>
          <tr>
              <td align=left>In data: $oggi_pretty</td>
          </tr>
          <tr>
          <td align=left>$img_tip_n Nuova Installazione $img_tip_r Ristrutturazione $img_tip_s Sostituzione del Generatore $img_tip_c Compilazione libretto impianto esistente</td>
          </tr>
          <tr>
             <td>&nbsp;</td>
          </tr>
     </table>
     <table width=100% align=left border=0>
          <tr>
             <td align=center colspan=2><b>1.2 Ubicazione e destinazione dell'edificio</b></td>
          </tr>
          <tr>
             <td colspan=2>&nbsp;</td>
          </tr>      
          <tr>
             <td align=left colspan=2>Indirizzo: $indir</td>
           </tr>
          <tr>          
             <td align=left>Comune: $nome_comu $cap</td>
             <td align=left>Provincia: $sigla</td>
          <tr>
"

#commentato perchè non presente nel modello di esempio. Viene messa solo la ubicazione attuale
#    db_foreach $sel_stub "" {
#	append libretto "
#          <tr>
#             <td>Indirizzo: $indir $nome_comu_st ($sigla) $cap</td>
#             <td align=left>Data fine validit&agrave;: $data_fin_valid</td>
#          </tr>"
#    }


    append libretto "</table>
    <table width=100%>
          <tr>
             <td>&nbsp;</td>
          <tr>
    </table>"

    #sim02 Sandro ha detto che il controllo per mettere il flag  viene fatto solo sui primi due (E1,E2).
    #rom13 ampliato controlli di sim02
    if {$cod_cted=="E1" || $cod_cted=="E11" || $cod_cted=="E11a" || $cod_cted=="E11b" || $cod_cted=="E12" ||  $cod_cted=="E13"} {#sim02
	set img_E1 $img_checked;#sim02 
    } else {#sim02
	set img_E1 $img_unchecked;#sim02 
    } ;#sim02

    if {$cod_cted=="E2"} {#sim02
        set img_E2 $img_checked;#sim02
    } else {#sim02
        set img_E2 $img_unchecked ;#sim02
    };#sim02

    if {$cod_cted=="E3"} {#rom13
	set img_E3 $img_checked;
    } else {
	set img_E3 $img_unchecked 
    }
    if {$cod_cted=="E41" || $cod_cted=="E42" || $cod_cted=="E43"} {#rom13
	set img_E4  $img_checked;
    } else {
	set img_E4  $img_unchecked
    }
    if {$cod_cted=="E5"} {#rom13
	set img_E5  $img_checked;
    } else {
	set img_E5 $img_unchecked
    }
    if {$cod_cted=="E61" || $cod_cted=="E62" || $cod_cted=="E63"} {#rom13
	set img_E6 $img_checked;
    } else {
	set img_E6 $img_unchecked
    }
    if {$cod_cted=="E7"} {#rom13
	set img_E7 $img_checked;
    } else {
	set img_E7 $img_unchecked
    }
    if {$cod_cted=="E8"} {#rom13
	set img_E8  $img_checked;
    } else {
	set img_E8  $img_unchecked
    }

    db_0or1row q "select iter_edit_num(sum(volimetria_risc),2) as tot_volimetria_risc
                       , iter_edit_num(sum(volimetria_raff),2) as tot_volimetria_raff        
                    from coimaimp
                   where cod_impianto in ('[join $lista_cod_impianti ',']')"
    
   append libretto "<table width=100% align=left>
          <tr>
             <td><img src=\"$img_url/unchecked.bmp\" height=12 width=12> Singola Unità imm.</td>
             <td align=left valign=center>Categoria: $img_E1 E.1 $img_E2 E.2 $img_E3 E.3 $img_E4 E.4 $img_E5 E.5 $img_E6 E.6 $img_E7 E.7 $img_E8 E.8</td>
          <tr>
             <td align=left colspan=2>Volume lordo Riscaldato: $tot_volimetria_risc (m&#179;)</td>
          </tr>
          <tr>   
             <td align=left colspan=2>Volume lordo Raffrescato: $tot_volimetria_raff (m&#179;)</td>
          </tr>
     </table>";#sim02

}

    append libretto "</table>
    <table width=100%>
          <tr>
             <td>&nbsp;</td>
          <tr>
    </table>"

if {$coimtgen(regione) ne "MARCHE"} {

    #sim02 Spostati. Prima erano all'inizio della pagina
    append libretto "<table width=100% > 
          <tr>
             <td align=left>PDR: $pdr</td>
             <td>&nbsp;</td>
             <td align=left>POD: $pod</td>
             <td>&nbsp;</td>
          </tr>
          </table><br>";#sim02
          
}

#destinazione uso

if {$flag_gest_targa eq "F"} {#sim04: aggiunta if, else e contenuto dell'else

    #Se ha un impianto padre ricavo la sua potenza utile
    if {![db_0or1row query "
         select --sim a.potenza_utile as potenza_utile_padre
                coalesce(iter_edit_num(a.potenza_utile, 2),'&nbsp;') as potenza_utile_padre --sim 
           from coimaimp a 
              , coimaimp b 
          where b.cod_impianto = :cod_impianto
            and a.cod_impianto = b.cod_impianto_princ
            and a.stato = 'A' 
        "]
    } {
	set potenza_utile_padre ""
    } 
    
} else {#sim04: aggiunta else e suo contenuto

    if {![db_0or1row query "
         select a.potenza_utile as potenza_utile_padre
           from coimaimp a
          where upper(targa)  = upper(:targa)
            and cod_impianto != :cod_impianto
            and a.stato = 'A'
           limit 1
        "]
    } {
	set potenza_utile_padre ""
    }
}


set img_cli_est $img_unchecked;#sim02 
set pot_utile_cli_est "";#sim02
set img_prod_acqua $img_unchecked;#sim02
set pot_utile_prod_acqua "";#sim02
set img_cli_inv $img_unchecked ;#sim02
set pot_utile_cli_inv "";#sim02
set img_altro $img_unchecked;#sim02
set note_altro "______________";#rom09


if {$coimtgen(regione) ne "MARCHE"} {#rom09 aggiunta if; aggiunta else e contenuto
    if {$cod_utgi == "F"} {#sim02
	set img_cli_est $img_checked;#sim02
	set pot_utile_cli_est "- <b>Potenza Utile: $potenza_utile</b>";#sim02
    }
    
    if {$cod_utgi eq "A" || $cod_utgi eq "D" || $cod_utgi eq "E"} {#sim02;#nic01
	set img_prod_acqua $img_checked;#sim02
	set pot_utile_prod_acqua "- <b>Potenza Utile: $potenza_utile</b>";#sim02
    }
    
    if {$cod_utgi == "E" || $cod_utgi == "R"} {#sim02
	set img_cli_inv $img_checked;#sim02
	set pot_utile_cli_inv "- <b>Potenza Utile: $potenza_utile</b>";#sim02
	
	#Se l'impianto del freddo ha un padre visualizzo i suoi dati
	if {$potenza_utile_padre ne ""} {
	    set pot_utile_cli_est "- <b>Potenza Utile: $potenza_utile_padre</b>"
	    set img_cli_est $img_checked;
	}
    }
    
    if {$cod_utgi == "0" || $cod_utgi == "X"} {#sim02
    set img_altro $img_checked;#sim02
    }
} else {

    
    set tot_pot_utile_cli_est    0
    set tot_pot_utile_prod_acqua 0
    set tot_pot_utile_cli_inv    0
    
    db_foreach q "select flag_prod_acqua_calda
                       , flag_clim_est
                       , flag_clima_invernale
                       , coalesce(pot_focolare_nom,'0.00') as pot_focolare_nom
                       , coalesce(pot_focolare_lib,'0.00') as pot_focolare_lib
                       , coalesce(pot_utile_nom,'0.00') as potenza_utile
                       , flag_tipo_impianto as flag_tipo_impianto_pot
                    from coimgend g
                       , coimaimp i
                   where g.cod_impianto in ('[join $lista_cod_impianti ',']')
                     and i.cod_impianto = g.cod_impianto
                     and flag_attivo  = 'S'
    " {

	if {$flag_tipo_impianto_pot eq "F"} {
	    set potenza_utile $pot_focolare_nom
	    set potenza_termica_nominale $pot_focolare_lib
	} elseif {$flag_tipo_impianto_pot eq "T"} {
	    set potenza_utile $pot_focolare_nom
	} 
	
	if {$flag_clim_est eq "S"} {#rom12 sostituita variabile funzione_grup_ter con flag_clim_est
	    set img_cli_est $img_checked
	    #set pot_utile_cli_est "- <b>Potenza Utile: $potenza_utile</b>"
	    if {$flag_tipo_impianto_pot eq "F"} {#per il freddo mostro la maggiore tra la potenza nominale frigorifera e termica
		#rom19set potenza_nominale_fr $potenza_utile
		#rom19set potenza_nominale_ri $potenza_termica_nominale
		#rom19if {$potenza_nominale_ri > $potenza_nominale_fr} {
		    #set pot_utile_cli_est "- <b>Potenza Utile: $potenza_termica_nominale</b>"
		#rom19set tot_pot_utile_cli_est [expr $tot_pot_utile_cli_est + $potenza_nominale_ri]
		#rom19} else {
		#rom19set tot_pot_utile_cli_est [expr $tot_pot_utile_cli_est + $potenza_nominale_fr]
		#rom19}
		
		set tot_pot_utile_cli_est [expr $tot_pot_utile_cli_est + $potenza_utile];#rom20
	    } else {
		set tot_pot_utile_cli_est [expr $tot_pot_utile_cli_est + $potenza_utile]
	    }
	}
	
	if {$flag_prod_acqua_calda eq "S"} {#rom12 sostituita variabile funzione_grup_ter con flag_prod_acqua_calda
		
	    set img_prod_acqua $img_checked
	    if {$flag_tipo_impianto_pot eq "F"} {
		set tot_pot_utile_prod_acqua [expr $tot_pot_utile_prod_acqua + $potenza_termica_nominale]
#		set pot_utile_prod_acqua "- <b>Potenza Utile: $potenza_termica_nominale</b>"
	    } else {
		set tot_pot_utile_prod_acqua [expr $tot_pot_utile_prod_acqua + $potenza_utile]
		#		set pot_utile_prod_acqua "- <b>Potenza Utile: $potenza_utile</b>"
	    }
	}	
	
	if {$flag_clima_invernale eq "S"} {#rom12 sostituita variabile funzione_grup_ter con flag_clima_invernale
	    set img_cli_inv $img_checked
#	    set pot_utile_cli_inv "- <b>Potenza Utile: $potenza_utile</b>"
	    if {$flag_tipo_impianto_pot eq "F"} {# per il freddo mostro la maggiore tra la potenza nominale frigorifera e termica
		#rom19set potenza_nominale_fr $potenza_utile
		#rom19set potenza_nominale_ri $potenza_termica_nominale
## correzione potenza
##		if {$potenza_nominale_ri > $potenza_nominale_fr} {
		#rom19set tot_pot_utile_cli_inv [expr $tot_pot_utile_cli_inv + $potenza_nominale_ri]
#		    set pot_utile_cli_inv "- <b>Potenza Utile: $potenza_termica_nominale</b>"
##		} else {
##		    set tot_pot_utile_cli_inv [expr $tot_pot_utile_cli_inv + $potenza_nominale_fr]
##		}
		set tot_pot_utile_cli_inv [expr $tot_pot_utile_cli_inv + $potenza_termica_nominale];#rom20
	    } else {
		set tot_pot_utile_cli_inv [expr $tot_pot_utile_cli_inv + $potenza_utile]
	    }
	}

    }

    if {$tot_pot_utile_cli_est > 0} {
	set tot_pot_utile_cli_est [db_string a "select iter_edit_num(:tot_pot_utile_cli_est,2)"]
	set pot_utile_cli_est "- <b>Potenza Utile: $tot_pot_utile_cli_est</b>"
    }
    
    if {$tot_pot_utile_prod_acqua > 0} {
	set tot_pot_utile_prod_acqua [db_string a "select iter_edit_num(:tot_pot_utile_prod_acqua,2)"]
	set pot_utile_prod_acqua "- <b>Potenza Utile: $tot_pot_utile_prod_acqua</b>"
    }
    
    if {$tot_pot_utile_cli_inv > 0} {
	set tot_pot_utile_cli_inv [db_string a "select iter_edit_num(:tot_pot_utile_cli_inv,2)"]
	set pot_utile_cli_inv "- <b>Potenza Utile: $tot_pot_utile_cli_inv</b>"
    }

};#rom09

#sim04: corretto <tr> che erano scritti sbagliati
append libretto "
    <table width=100% align=center>
          <tr>
             <td align=center><b>1.3 Impianto destinato a soddisfare i seguenti servizi</b></td>
          </tr>
          <tr>
             <td>&nbsp;</td>
          </tr>
     </table>
          
     <table width=100% align=left>
             <tr>
             <td align=left>$img_prod_acqua Prod. Acq. calda sanitaria $pot_utile_prod_acqua</td>
             </tr>
             <tr>
             <td align=left>$img_cli_inv Climatizzazione inv. $pot_utile_cli_inv</td>
             </tr>
             <tr>
             <td align=left>$img_cli_est Climatizzazione est. $pot_utile_cli_est</td>
             </tr>
             <tr>
             <td align=left>$img_altro Altro $note_altro</td>
             </tr>             
          </tr>
      </table>";#sim02

    append libretto "</table>
    <table width=100%>
          <tr>
             <td>&nbsp;</td>
          <tr>
    </table>"



#tipologia fluido vettore

if {$mod_funz == "1"} {#sim02
    set img_acqua $img_checked;#sim02
} else {#sim02
    set img_acqua $img_unchecked;#sim02
};#sim02

if {$mod_funz == "2"} {#sim02
    set img_aria $img_checked;#sim02
} else {#sim02
    set img_aria $img_unchecked;#sim02
};#sim02

if {$mod_funz == "0" || $mod_funz == "3"} {#sim02
    set img_altro_vet $img_checked;#sim02
} else {#sim02
    set img_altro_vet $img_unchecked;#sim02
};#sim02

    append libretto "
    <table width=100% align=center>
          <tr>
             <td align=center><b>1.4 Tipologia Fluido Vettore</b></td>
          </tr>
          <tr>
             <td>&nbsp;</td>
          </tr>
   </table>
   <table width=100% align=left colspan= 4>
          <tr>
             <td align=left>$img_acqua Acqua</td> 
             <td align=left>$img_aria Aria  </td> 
             <td align=left>$img_altro_vet Altro_____________ </td>
          </tr>";#sim02

    append libretto "</table>
    <table width=100%>
          <tr>
             <td>&nbsp;</td>
          </tr>
    </table>"


set img_gcomb $img_unchecked
set img_pcalo $img_unchecked
set img_mfrig $img_unchecked
set img_trisc $img_unchecked
set img_traff $img_unchecked
set img_cotri $img_unchecked
set img_altro_tip_gen $img_unchecked
set img_clinv $img_unchecked
set img_clest $img_unchecked
set img_pracs $img_unchecked
set img_clinv_pracs $img_unchecked
set img_clest_clinv $img_unchecked
set img_clest_clinv_pracs $img_unchecked
set img_clest_pracs $img_unchecked
set img_altro $img_unchecked
set img_pannelli_solari $img_unchecked
set img_altra_integ $img_unchecked

db_foreach q "select tipologia_generatore
                   , integrazione_per
                   , integrazione
                from coimaimp
               where cod_impianto in ('[join $lista_cod_impianti ',']')" {

#tipologia_generatore
if {$tipologia_generatore == "GCOMB"} {;#gac05
    set img_gcomb $img_checked;#gac05
}
if {$tipologia_generatore == "PCALO"} {;#gac05
    set img_pcalo $img_checked;#gac05
} 
if {$tipologia_generatore == "MFRIG"} {;#gac05
    set img_mfrig $img_checked;#gac05
}
if {$tipologia_generatore == "TRISC"} {;#gac05
    set img_trisc $img_checked;#gac05
}
if {$tipologia_generatore == "TRAFF"} {;#gac05
    set img_traff $img_checked;#gac05
} 
if {$tipologia_generatore == "COTRI"} {;#gac05
    set img_cotri $img_checked;#gac05
}
if {$tipologia_generatore == "ALTRO"} {;#gac05
    set img_altro_tip_gen $img_checked;#gac05
}

#integrazione_per
if {$integrazione_per == "CLINV"} {;#gac05
    set img_clinv $img_checked;#gac05
}
if {$integrazione_per == "CLEST"} {;#gac05
    set img_clest $img_checked;#gac05
}
if {$integrazione_per == "PRACS"} {;#gac05
    set img_pracs $img_checked;#gac05
}
if {$integrazione_per == "CLINV+PRACS"} {#rom14 aggiunte if, else e loro contenuto
    set img_clinv_pracs $img_checked
}
if {$integrazione_per == "CLEST+CLINV"} {#rom14 aggiunte if, else e loro contenuto
    set img_clest_clinv $img_checked
}
if {$integrazione_per == "CLEST+CLINV+PRACS"} {#rom14 aggiunte if, else e loro contenuto
    set img_clest_clinv_pracs $img_checked
}
if {$integrazione_per == "CLEST+PRACS"} {#rom14 aggiunte if, else e loro contenuto
    set img_clest_pracs $img_checked
}
#if {$integrazione_per == ""} {;#gac05
#    set img_altro $img_checked;#gac05
#}

#integrazione
if {$integrazione eq "P"} {#gac07
    set img_pannelli_solari $img_checked;#gac07
}
if {$integrazione eq "A"} {#gac07
    set img_altra_integ $img_checked;#gac07
}

}
    append libretto "
    <table width=100% align=center>
          <tr>
             <td align=center colspan=3><b>1.5 Individuazione della Tipologia dei Generatori</b></td>
          </tr>
          <tr>
             <td>$img_gcomb Generatore a combustione</td>
             <td>$img_pcalo Pompa di calore</td>
             <td>$img_mfrig Macchina frigorifera</td>
          </tr>
          <tr>
             <td>$img_trisc Teleriscaldamento</td>
             <td>$img_traff Teleraffrescamento</td>
             <td>$img_cotri Cogenerazionetrigenerazione</td>
          </tr>
          <tr>
             <td colspan=3>$img_altro_tip_gen Altro <u>$altra_tipologia_generatore</u></td>  
          </tr>
          <tr>
             <td align=left>Eventuale Integrazione con:</td>
          </tr>
    </table>

    <table width=100% border=0>
       <tr>
          <td align=left colspan=5>$img_pannelli_solari Pannelli solari termici: superficie totale lorda $superficie_integrazione (m&#178;)</td>
       </tr>
       <tr>
          <td colspan=3>$img_altra_integ Altro $nota_altra_integrazione</td>
          <td colspan=2>Potenza Utile $pot_utile_integrazione (kW)</td>
       </tr>
       <tr>
          <td valign=top rowspan=2 width=6%>Per:</td>
          <td valign=top align=left colspan=2 width=47%>$img_clinv Climatizzazione invernale
                                <br>$img_clest_clinv Climatizzazione estiva + Climatizzazione invernale
          </td>
          <td valign=top align=left colspan=2 width=47%>$img_clest Climatizzazione estiva
                                <br>$img_clest_clinv_pracs Climatizzazione estiva + Climatizzazione invernale + Produzione ACS
          </td>
      </tr>
      <tr>
          <td valign=top align=left colspan=2>$img_pracs Produzione ACS
                                <br>$img_clest_pracs Climatizzazione estiva + Produzione ACS
          </td>
          <td valign=top align=left colspan=2>$img_clinv_pracs Climatizzazione invernale + Produzione ACS
                                <br>$img_altro ______________
          </td>
       </tr>
     </table>"


# Responsabile
if {[db_0or1row sel_resp ""] == 0} {
    iter_return_complaint "Impianto non trovato"
} else {

    if {[string is space $nome_resp]} {
	set nome_resp "&nbsp;"
    }

    append libretto "
    <table width=100% align=center>
          <tr><td>&nbsp;</td></tr>
          <tr>
             <td align=center colspan=3><b>1.6 Responsabile dell'Impianto</b></td>
          </tr>
          <tr>
             <td>Cognome: $cgn_resp</td>
             <td>Nome: $nom_resp</td>
             <td>CF: $cf_resp</td>
          </tr>
          <tr>
             <td colspan=2>Ragione Sociale: __________________</td>                     
             <td>P.IVA: $piva_resp</td>
          </tr>
          <tr>
             <td>&nbsp;</td>
          </tr>"

    append libretto "</table>
    <table width=100%>
          <tr>
             <td>&nbsp;</td>
          <tr>
    </table>"

    append libretto "
    <table width=100%>
          <tr>
             <td width=50%>&nbsp;</td>
             <td align=center>Firma del responsabile<br>
             (Legale Rappresentante in caso di persona giuridica)</td>
          </tr>
         <tr>
             <td width=50%>&nbsp;</td>
             <td>________________________________________________</td>
         </tr>
    </table>"

}

set libretto_prima_pagina $libretto;#sim08

append libretto "
    <!-- PAGE BREAK -->
    $table_con_header_per_tutte_le_pagine"


#GACALIN INIZIO SCHEDA 1BIS
if {$coimtgen(regione) eq "MARCHE"} {#gac02: if e suo contenuto

    set ls_cod_impianto_padre_fr [list]
    set ls_cod_impianto_padre_ca [list]
    
    if {$flag_tipo_impianto eq "F"} {
	
	set ls_cod_impianto_padre_fr "$cod_impianto "
    }
    
    if {$flag_tipo_impianto ne "F"} {     
	set ls_cod_impianto_padre_ca "$cod_impianto "
    }
    
    if {$flag_gest_targa eq "T"} {
	
	db_1row q "select targa 
                 from coimaimp 
                where cod_impianto = :cod_impianto"
	
	set join_padre "inner join coimaimp f      on f.cod_impianto      = a.cod_impianto"
	set where_padre "    f.cod_impianto != :cod_impianto
                     and upper(f.targa)  = upper(:targa)"

	append ls_cod_impianto_padre_fr [db_list q "select f.cod_impianto
                                            from coimaimp f     
                                           where f.cod_impianto != :cod_impianto
                                            and upper(f.targa)  = upper(:targa)
                                            and f.stato='A'
                                            and flag_tipo_impianto='F'"]

	append ls_cod_impianto_padre_ca [db_list q "select f.cod_impianto
                                            from coimaimp f     
                                           where f.cod_impianto != :cod_impianto
                                            and upper(f.targa)  = upper(:targa)
                                            and f.stato='A'
                                            and flag_tipo_impianto!='F'"]				 

	
    } else {
	
	set join_padre "left outer join coimaimp f on f.cod_impianto = a.cod_impianto
                         inner join coimaimp h on f.cod_impianto = h.cod_impianto_princ
                           and f.cod_impianto != h.cod_impianto"
	set where_padre "h.cod_impianto = :cod_impianto"
	
	    append ls_cod_impianto_padre_fr [db_list q "select h.cod_impianto
                                            from coimaimp f
                                      inner join coimaimp h
                                              on f.cod_impianto = h.cod_impianto_princ
                                             and f.cod_impianto != h.cod_impianto
                                           where h.cod_impianto = :cod_impianto
                                             and f.stato='A'
                                             and h.flag_tipo_impianto='F'"]

	append ls_cod_impianto_padre_ca [db_list q "select h.cod_impianto
                                            from coimaimp f
                                      inner join coimaimp h
                                              on f.cod_impianto = h.cod_impianto_princ
                                             and f.cod_impianto != h.cod_impianto
                                           where h.cod_impianto = :cod_impianto
                                             and f.stato='A'
                                             and h.flag_tipo_impianto!='F'"]


    }
    
    set select_anni "case when flag_tipo_impianto ='T' or flag_tipo_impianto = 'C' then 'ogni 4 anni' else  
                          (case when potenza_num < 100  and combustibile     in ('4','5')
                               then 'ogni 4 anni' --metano e gpl con pot < 100
                          when potenza_num < 100  and combustibile not in ('4','5')
                               then 'ogni 2 anni' --altri comb con pot < 100
                          when potenza_num >= 100 and combustibile     in ('4','5')
                               then 'ogni 2 anni' --metano e gpl con pot >= 100
                          when potenza_num >= 100 and combustibile not in ('4','5')
                               then 'ogni 1 anno' -- altri comb con pot >= 100
                          else '' end) end as anni"

    set select_anni_tot "case when flag_tipo_impianto ='T' or flag_tipo_impianto = 'C' then 'ogni 4 anni' else  
                              (case when sum(potenza_num) < 100  and combustibile     in ('4','5')
                                    then 'ogni 4 anni' --metano e gpl con pot < 100
                               when sum(potenza_num) < 100  and combustibile not in ('4','5')
                                    then 'ogni 2 anni' --altri comb con pot < 100
                               when sum(potenza_num) >= 100 and combustibile     in ('4','5')
                                    then 'ogni 2 anni' --metano e gpl con pot >= 100
                               when sum(potenza_num) >= 100 and combustibile not in ('4','5')
                                    then 'ogni 1 anno' -- altri comb con pot >= 100
                               else '' end) end as anni";#rom22
    
    set select_anni_fr "case when cod_tpco in ('1','2') and potenza_num_fr < 100
                                  then 'ogni 4 anni' --pompe di calore a compressione e a fiamma diretta con pot < 100
                             when cod_tpco in ('1','2') and potenza_num_fr >= 100
                                  then 'ogni 2 anni' --pompe di calore a compressione e a fiamma diretta con pot >= 100
                             when cod_tpco = '4'
                                  then 'ogni 4 anni' --pompe di calore a motore endotermico
                             when cod_tpco = '3'
                                  then 'ogni 2 anni' --pompe di calore a energia termica
                             else '' end as anni"

    set select_anni_tot_fr "case when cod_tpco in ('1','2') and sum(potenza_num_fr) < 100
                                  then 'ogni 4 anni' --pompe di calore a compressione e a fiamma diretta con pot < 100
                             when cod_tpco in ('1','2') and sum(potenza_num_fr) >= 100
                                  then 'ogni 2 anni' --pompe di calore a compressione e a fiamma diretta con pot >= 100
                             when cod_tpco = '4'
                                  then 'ogni 4 anni' --pompe di calore a motore endotermico
                             when cod_tpco = '3'
                                  then 'ogni 2 anni' --pompe di calore a energia termica
                             else '' end as anni";#rom21




    append libretto "
    <table width=100% border=1>
          <tr>
             <td align=center bgcolor=\"E1E1E1\"><big><b>1Bis. Dati Generali</b></big></td>
          </tr>
    </table>"
        
    append libretto "
        <table align=left border=0>
          <tr>
             <td>&nbsp;</td>
          </tr>
              <tr>
                 <td align=left>PDR</td>
                 <td align=left>$pdr</td>
              </tr>
              <tr>
                 <td align=left>POD</td>
                 <td align=left>$pod</td>
              </tr>
        </table>
<br>

        <table align=center width=100% >
              <tr>
                 <td align=center><b>Ulteriori dati Responsabile d'impianto</b></td>
              </tr>
        </table>
        <table align=left>
              <tr>
                 <td colspan=5>&nbsp;</td>
              </tr> 
              <tr>
                 <td align=left>Tipo Persona:</td>
                 <td colspan=4 align=left>$natura_giuridica</td>
              </tr>
              <tr>
                 <td colspan=5>&nbsp;</td>
              </tr>
              <tr>
                 <td align=left>Ruolo:</td>
                 <td colspan=4 align=left>$flag_resp</td>
              </tr>
              <tr>
                 <td colspan=5>&nbsp;</td>
              </tr>
              <tr>
                 <td align=left>Recapiti:</td>
                 <td align=left>Via/Piazza</td>
                 <td align=left>$indir_r</td>
                 <td align=left>Comune</td>
                 <td align=left>$nome_comu_r</td>
              </tr>
              <tr>
                 <td align=left>&nbsp;</td>
                 <td align=left>Prov</td>
                 <td align=left>$sigla_r</td>
                 <td align=left>C.A.P.</td>
                 <td align=left>$cap_r</td>
              </tr>
              <tr>
                 <td colspan=5>&nbsp;</td>
              </tr>
              <tr>
                 <td align=left>Contatti:</td>
                 <td align=left>Telefono</td>
                 <td align=left>$tel</td>
                 <td align=left>Fax</td> 
                 <td align=left>$fax</td>
              </tr>
              <tr>
                 <td align=left>&nbsp;</td>
                 <td align=left>Email</td>
                 <td align=left>$email</td>
                 <td align=left>Pec</td>
                 <td align=left>$pec</td>
              </tr>
       </table>
       <br>"

    #rom18 se il proprietario dell'impianto e' diverso dal responsabile devo mostrare anche i suoi dati.
    #if {[db_0or1row q "select 1
    #                     from coimaimp
    #                    where cod_proprietario != cod_responsabile
    #                      and cod_impianto = :cod_impianto"]} {#rom18 aggiunta if e suo contenuto
	append libretto "        <table align=center width=100% >
              <tr>
                 <td align=center><b>Dati del Proprietario d'impianto</b></td>
              </tr>
        </table>"


	if {[db_0or1row sel_prop "select c.nome as nome_prop
                                       , c.cognome as cognome_prop
                                       , c.cod_fiscale as cod_fisc_prop
                                       , c.cod_piva as cod_piva_prop
                                       , coalesce(c.indirizzo,'')||' '||coalesce(c.numero,'') as indirizzo_prop
                                       , c.cap as cap_prop
                                       , c.comune as comune_prop
                                       , c.provincia as provincia_prop
                                       , c.telefono as tel_prop
                                       , c.fax as fax_prop
                                       , c.email as email_prop
                                       , c.pec as pec_prop
                                       , case c.natura_giuridica 
                                         when 'F' then 'FISICA' 
                                         when 'G' then 'GIURIDICA'
                                         else '' end as natura_giuridica_prop
                                    from coimaimp a
                                       , coimcitt c    
                                   where a.cod_proprietario = c.cod_cittadino
                                     and a.cod_impianto = :cod_impianto"]} {
	    
	    append libretto "
        <table align=left>
              <tr>
                 <td colspan=5>&nbsp;</td>
              </tr> 
              <tr>
                 <td align=left>Cognome: $cognome_prop</td>
                 <td align=left>Nome: $nome_prop</td>
              </tr>
              <tr>
                 <td align=left>CF: $cod_fisc_prop</td>
                 <td align=left>P.IVA: $cod_piva_prop</td>
              </tr>
              <tr>
                 <td align=left>Tipo Persona:</td>
                 <td colspan=4 align=left>$natura_giuridica_prop</td>
              </tr>
              <tr>
                 <td colspan=5>&nbsp;</td>
              </tr>
              <tr>
                 <td align=left>Ruolo:</td>
                 <td colspan=4 align=left>Proprietario</td>
              </tr>
              <tr>
                 <td colspan=5>&nbsp;</td>
              </tr>
              <tr>
                 <td align=left>Recapiti:</td>
                 <td align=left>Via/Piazza</td>
                 <td align=left>$indirizzo_prop</td>
                 <td align=left>Comune</td>
                 <td align=left>$comune_prop</td>
              </tr>
              <tr>
                 <td align=left>&nbsp;</td>
                 <td align=left>Prov</td>
                 <td align=left>$provincia_prop</td>
                 <td align=left>C.A.P.</td>
                 <td align=left>$cap_prop</td>
              </tr>
              <tr>
                 <td colspan=5>&nbsp;</td>
              </tr>
              <tr>
                 <td align=left>Contatti:</td>
                 <td align=left>Telefono</td>
                 <td align=left>$tel_prop</td>
                 <td align=left>Fax</td> 
                 <td align=left>$fax_prop</td>
              </tr>
              <tr>
                 <td align=left>&nbsp;</td>
                 <td align=left>Email</td>
                 <td align=left>$email_prop</td>
                 <td align=left>Pec</td>
                 <td align=left>$pec_prop</td>
              </tr>
              <tr>
                 <td colspan=5>&nbsp;</td>
              </tr>
       </table>
       <br>"
	} else {
	    append libretto "<table align=center width=100% >
              <tr>
                 <td align=center>Inserire il Proprietario nella Scheda 1bis</td>
              </tr>
            </table>"
	}
    #};#rom18
    
    	append libretto "
       <table align=center width=100% >
              <tr>
                 <td align=center><b>Intestatario contratto fornitura combustibile</b></td>
              </tr>
       </table>";#rom13

    if {[db_0or1row sel_inte_contr ""] == 1} {#rom13 aggiunta if, else e loro contenuto
	append libretto "
       <table align=left>
              <tr>
                 <td align=left>Cognome</td>
                 <td align=left>$cognome_inte_contr</td>
                 <td align=left>Nome</td>
                 <td align=left>$nome_inte_contr</td>
              </tr>
        </table>
        <br>"
    } else {
	append libretto "<table width=100% align=center border=0>
                            <tr>
                               <td align=left>Non esiste intestatario fornitura combustibile</td>
                            </tr>
                         </table><br>"
    }

    append libretto "        <table align=center border=0 width=100%>
              <tr>
                 <td align=center nowrap><b>Eventuale conduttore (per impianti con potenza nominale utile superiore a 232 kW) per l'impianto $cod_impianto_est</b></td>
              </tr>
        </table>"


    if {[db_0or1row sel_condu ""] == 0} {
	append libretto "<table width=100% align=center border=0>
                            <tr>
                               <td align=left>Non esiste eventuale conduttore</td>
                            </tr>
                         </table>"   
        

    } else {
	append libretto "
        <table align=left>
              <tr>
                 <td colspan=5>&nbsp;</td>
              </tr>
              <tr>
                 <td align=left>Cognome e Nome</td>
                 <td colspan=4 align=left>$nome_condu</td>
              </tr>
              <tr>
                 <td colspan=5>&nbsp;</td>
              </tr>
              <tr>
                 <td align=left>Codice Fiscale</td>
                 <td colspan=4 align=left>$cod_fiscale_condu</td>
              </tr>
              <tr>
                 <td colspan=5>&nbsp;</td>
              </tr>
              <tr>
                 <td align=left>Data patentino</td>
                 <td colspan=4 align=left>$data_patentino_condu</td>
              </tr>
              <tr>
                 <td colspan=5>&nbsp;</td>
              </tr>
              <tr>
                 <td align=left>Ente che ha rilasciato il patentino:
                 <td colspan=4 align=left>$ente_rilascio_patentino</td>
              </tr>
              <tr>
                 <td colspan=5>&nbsp;</td>
              </tr>
              <tr>
                 <td align=left>Recapiti:</td>
                 <td align=left>Via/Piazza</td>
                 <td align=left>$indirizzo_condu</td>
                 <td align=left>Comune</td> 
                 <td align=left>$nome_comu_condu</td>
              </tr>
              <tr>
                 <td align=left>&nbsp;</td>
                 <td align=left>Prov</td>
                 <td align=left>$sigla_condu</td>
                 <td align=left>C.A.P.</td>
                 <td align=left>$cap_condu</td>
              </tr>
              <tr>
                 <td colspan=5>&nbsp;</td>
              </tr>
              <tr>
                 <td align=left>Contatti:</td>
                 <td align=left>Telefono</td> 
                 <td align=left>$tel_condu</td>
                 <td align=left>Fax</td> 
                 <td align=left>$fax_condu</td>
              </tr>
              <tr>
                 <td align=left>&nbsp;</td>
                 <td align=left>Email</td> 
                 <td align=left>$email_condu</td>
                 <td align=left>Pec</td> 
                 <td align=left>$pec_condu</td>
              </tr>
        </table> "
    }
    set descr_tpim_1bis [db_string q "select case cod_tpim
                                        when 'A' then 'Autonomo'
                                        when 'C' then 'Centralizzato'
                                        else ''
                                         end as descr_tpim_1bis
                                        from coimaimp 
                                       where cod_impianto = :cod_impianto" -default ""];#rom16
    if {$flag_tipo_impianto eq "F"} {#rom16 aggiunta if e suo contenuto
	set descr_tpim_1bis [db_string q "select case cod_tpim
                                        when 'A' then 'Autonomo'
                                        when 'C' then 'Centralizzato'
                                        else ''
                                         end as descr_tpim_1bis
                                        from coimaimp
                                       where targa = :targa
                                       limit 1" -default ""]
    }

db_foreach q "select cod_impianto_est as cod_impianto_est_ult
                   , case cod_tpim
                     when 'A' then 'Autonomo'
                     when 'C' then 'Centralizzato'
                     else ''
                     end                       as descr_tpim_1bis
                   , case when a.unita_immobiliari_servite = 'U' then 'unica' 
                when a.unita_immobiliari_servite = 'P' then 'più unità'       
	        else ''                                                       
	        end  as unita_immobiliari_servite_ult
                   , case a.pres_certificazione
	   when 'S' then 'S&igrave;'
           when 'N' then 'No'
           else ''
	   end       as pres_certificazione_ult
                   , coalesce(certificazione, '')            as certificazione_ult
                   , cod_installatore          as cod_installatore_ult
                   , coalesce(iter_edit_data(data_installaz),'&nbsp;')                as data_insta_ult
                   , iter_edit_data(anno_costruzione)          as anno_costruzione_ult
                   , case a.stato
	   when 'A' then 'Attivo'
	   when 'R' then 'Rottamato'
	   when 'U' then 'Impianto Chiuso'
	   when 'N' then 'Non Attivo'
	   when 'L' then 'Annullato'
	   when 'D' then 'Da Accatastare'
	   else ''
	   end                     as stato_ult
                   , coalesce(iter_edit_data(data_rottamaz),'&nbsp;') as data_rott_ult
                   , coalesce(iter_edit_data(data_attivaz),'&nbsp;') as data_attivaz_ult
                   , case when cat_catastale = 'CT' then 'Catasto Terreni'
                          when cat_catastale = 'CF' then 'Catasto Fabbricati'
                          else '' end as cat_catastale_ult
                   , sezione as sezione_ult
                   , foglio  as foglio_ult
                   , mappale as mappale_ult
                   , subalterno as subalterno_ult
                from coimaimp a
               where cod_impianto in ('[join $lista_cod_impianti ',']')
" {

    set installatore_iniziale_ult [db_string q "select coalesce(coalesce(cognome,'') || coalesce(nome,''), '_____________')
                                              from coimmanu
                                              where cod_manutentore=:cod_installatore_ult" -default ""]
		   
append libretto "<br>
        <table width=100%>
              <tr>
                 <td align=center><b>Ulteriori dati dell'impianto $cod_impianto_est_ult</b></td>
              </tr>
        </table>
        <table align=left border=0>
              <tr>
                 <td align=left>Tipologia impianto:</td>
                 <td align=left>$descr_tpim_1bis</td>
              </tr>
              <tr>
                 <td align=left>Unità immobiliari servite:</td>
                 <td align=left>$unita_immobiliari_servite_ult</td>
              </tr>
              <tr>
                 <td align=left>N. di attestati APE presenti:</td>                 
                 <td align=left>$pres_certificazione_ult</td>
              </tr>
              <tr>
                 <td align=left>Codice/i identificativo/i del/degli  APE:</td>
                 <td align=left>$certificazione_ult</td>
              </tr>
              <tr>
                 <td align=left>Installatore iniziale:</td>
                 <td align=left>$installatore_iniziale_ult</td>
              </tr>
              <tr>
                 <td align=left>Data di installazione dell'impianto:</td>
                 <td align=left>$data_insta_ult</td>
              </tr>
              <tr>
                 <td align=left>Data di costruzione dell'impianto:</td>
                 <td align=left>$anno_costruzione_ult</td>
              </tr>            
              <tr>
                 <td align=left>Stato dell'impianto:</td>
                 <td align=left>$stato_ult</td>
              </tr>"
    
    if {$flag_tipo_impianto == "R"} {
	append libretto "
             <tr>
                 <td align=left>Data dismissione/disattivazione:</td>
                 <td align=left>$data_rott_ult</td>
              </tr>"

    } elseif {$flag_tipo_impianto == "F"} {
	append libretto "
              <tr>
                 <td align=left>Data dismissione/disattivazione:</td>
                 <td align=left>$data_rott_ult</td>
              </tr>"
    }
    append libretto "
              <tr>
                 <td align=left>Data dell'eventuale riattivazione:</td>
                 <td align=left>$data_attivaz_ult</td>
              </tr>
              <tr>
                 <td align=left colspan=2><br><br><b>Dati Catastali dell'immobile</b></td>
              </tr>
              <tr>
                 <td align=left>Tipo Catasto:</td>
                 <td align=left>$cat_catastale_ult</td>
              </tr>
              <tr>
                 <td align=left>Sezione:</td>
                 <td align=left>$sezione_ult</td>
              </tr>
              <tr>
                 <td align=left>Foglio:</td>
                 <td align=left>$foglio_ult</td>
              </tr>
              <tr>
                 <td align=left>Mappale:</td>
                 <td align=left>$mappale_ult</td>
              </tr>
              <tr>
                 <td align=left>Subalterno:</td>
                 <td align=left>$subalterno_ult</td>
              </tr>
        </table><br>"

}
    
    append libretto "
<!-- PAGE BREAK -->
        <table width=100% align=center>
              <tr>
              <td align=center><b>Periodicità per l'invio del Rapporto di controllo dell'efficienza energetica e costo del segno identificativo</b></td>
              </tr>
        </table>"

    
    foreach cod_impianto_1bis $ls_cod_impianto_padre_ca {

	    db_1row q "select cod_impianto_est as cod_impianto_est_1bis
                            , flag_tipo_impianto as flag_tipo_impianto_1bis
                            , potenza as potenza_bis
             from coimaimp
            where cod_impianto = :cod_impianto_1bis"

	    if {$flag_tipo_impianto_1bis eq "F" && $potenza_1bis < 12} {
		continue
	    }
	    
	append libretto "<br>
        <table width=100% align=center>
             <tr>
                 <td align=center><b>Rapporto di controllo dell'efficienza energetica tipo 1 per l'impianto $cod_impianto_est_1bis</b></td>
              </tr>
        </table>
        <table width=70% align=center border=1>
             <tr>
                <td align=center width=25%>Codice Impianto</td>
                <td align=center width=5%>GT.</td>
                <td align=center width=30%>Potenza termica nominale del GT</td>
                <td align=center width=30%>Combustibile</td>
                <td align=center width=10%>Attivo</td>
             </tr>"

	
	    db_foreach sel_gend_bis "" { 
	    
		append libretto "
             <tr>
                <td align=center width=25%>$cod_impianto_est</td>
                <td align=center width=5%>$gen_prog_est</td>
                <td align=center width=30%>$potenza</td>
                <td align=center width=30%>$descr_comb</td>
                <td align=center width=10%>$flag_attivo</td>
             </tr>"

	    }

	    append libretto "</table>"

	    append libretto "<br>
            <table width=100% border=1>
             <tr>
                <td align=center>Tipo Combustibile</td>
                <td align=center>Potenza termica nominale utile complessiva</td> 
                <td align=center>Costo del segno identificativo</td>
                <td align=center>Periodicità invio del Rapporto di Efficenza Energetica munito di segno identificativo</td>  
             </tr>"

	    db_foreach sel_tot_gend "" {

		append libretto "
             <tr>
                <td align=center>$tipo_combustibile</td>
                <td align=center>$tot_potenza</td>
                <td align=center>&euro; $importo</td>
                <td align=center>$anni</td>  
             </tr>"
	    }
	    
	    append libretto "</table>"

	}

    
    foreach cod_impianto_1bis $ls_cod_impianto_padre_fr {

	db_1row q "select cod_impianto_est as cod_impianto_est_1bis
                        , flag_tipo_impianto as flag_tipo_impianto_1bis
                        , potenza as potenza_1bis
             from coimaimp
            where cod_impianto = :cod_impianto_1bis"

	if {$flag_tipo_impianto_1bis eq "F" && $potenza_1bis < 12} {
	    continue
	}
	
	append libretto "<br>
        <table width=100% align=center>
             <tr>
                 <td align=center><b>Rapporto di controllo dell'efficienza energetica tipo 2 per l'impianto $cod_impianto_est_1bis</b></td>
              </tr>
        </table>
        <table width=90% align=center border=1>
             <tr>
                <td align=center width=15%>Codice Impianto</td>
                <td align=center width=5%>GF</td>
                <td align=center width=20%>Potenza nominale utile del GF</td>
                <td align=center width=35%>Tipo di climatizzazione</td>
                <td align=center width=35%>Sistema di azionamento</td>
                <td align=center width=5%>Attivo</td>
             </tr>"

	
	db_foreach sel_gend_fr_bis "" {
	    
	    append libretto "
             <tr>
                <td align=center width=15%>$cod_impianto_est</td>
                <td align=center width=5%>$gen_prog_est</td>
                <td align=center width=20%>$potenza</td>
                <td align=center width=35%>$tipo_climatizzazione</td>
                <td align=center width=35%>$descr_tpco</td>
                <td align=center width=5%>$flag_attivo</td>
             </tr>"
	}

        append libretto "</table>"

	append libretto "<br>
            <table width=100% border=1>
             <tr>
                <td align=center>Sistema di azionamento</td>
                <td align=center>Tipo di climatizzazione</td>
                <td align=center>Potenza nominale utile complessiva</td>
                <td align=center>Costo del segno identificativo</td>
                <td align=center>Periodicità invio del Rapporto di Efficenza Energetica munito di segno identificativo</td>
             </tr>"

	db_foreach  sel_tot_gend_fr "" {
	    append libretto "
             <tr>
                <td align=center>$tot_descr_tpco</td>
                <td align=center>$tipo_climatizzazione</td>
                <td align=center>$tot_potenza</td>
                <td align=center>&euro; $importo</td>
                <td align=center>$anni</td>
             </tr>"
	}
        append libretto "</table>"
    }

    append libretto "
	    <!-- PAGE BREAK -->
    $table_con_header_per_tutte_le_pagine
	    "
} else {
    set select_anni ""
    set select_anni_fr ""
    set select_anni_tot "";#rom22
    set select_anni_tot_fr "";#rom22
}
#GACALIN FINE SCHEDA 1BIS



append libretto "
<table width=100% border=1>
     <tr>
        <td align=center bgcolor=\"E1E1E1\"><big><b>2. Trattamento Acqua</b></big></td>
     </tr>
</table>"
   


#trattamento dell'acqua

#contenuto acqua

if {[db_0or1row sel_aimp_tratt_acqua ""] == 0} {
    iter_return_complaint "Impianto non trovato"
} else {

    append libretto "

    <table width=100% align=center>
          <tr>
             <td>&nbsp;</td>
          </tr>
          <tr>
             <td align=center><b>2.1 Contenuto d'acqua dell'impianto di climatizzazione</b> $tratt_acqua_contenuto (m<sup>3</sup>)</td>
          </tr>"
          #<tr>
          #   <td>$tratt_acqua_contenuto (m<sup>3</sup>)</td>
          #</tr>";#sim02

    append libretto "</table>
    <table width=100%>
          <tr>
             <td>&nbsp;</td>
          <tr>
    </table>"

    append libretto "
    <table width=100% align=center>
          <tr>
             <td align=center><b>2.2 Durezza Totale dell'acqua</b> $tratt_acqua_durezza °fr</td>
          </tr>"
          #<tr>
          #   <td>$tratt_acqua_durezza °fr</td>
          #</tr>";#sim02

    append libretto "</table>
    <table width=100%>
          <tr>
             <td>&nbsp;</td>
          <tr>
    </table>"

    set img_assente_cli_tipo      $img_unchecked
    set img_filtrazione           $img_unchecked
    set img_addolcimento          $img_unchecked
    set img_con_chimico           $img_unchecked
    
    set img_assente_gelo          $img_unchecked
    set img_etilenico             $img_unchecked
    set img_propilenico           $img_unchecked

    if {$tratt_acqua_clima_tipo eq "A"} {
	set img_assente     $img_checked
    }
    if {$tratt_acqua_clima_tipo eq "F"} {
        set img_filtrazione $img_checked
    }
    if {$tratt_acqua_clima_tipo eq "D"} {
        set img_addolcimento $img_checked
    }
    if {$tratt_acqua_clima_tipo eq "C"} {
        set img_con_chimico $img_checked
    }
    if {$tratt_acqua_clima_tipo eq "K"} {
        set img_filtrazione $img_checked
	set img_addolcimento $img_checked
    }
    if {$tratt_acqua_clima_tipo eq "J"} {
        set img_filtrazione $img_checked
	set img_con_chimico $img_checked
    }
    if {$tratt_acqua_clima_tipo eq "W"} {
        set img_con_chimico $img_checked
	set img_addolcimento $img_checked
    }
    if {$tratt_acqua_clima_tipo eq "T"} {
        set img_filtrazione $img_checked
        set img_con_chimico $img_checked
	set img_addolcimento $img_checked
    }
    if {$tratt_acqua_clima_prot_gelo eq "A"} {
	set img_assente_gelo $img_checked
    }
    if {$tratt_acqua_clima_prot_gelo eq "E"} {
        set img_etilenico $img_checked
    }
    if {$tratt_acqua_clima_prot_gelo eq "P"} {
        set img_propilenico $img_checked
    }

    append libretto "
<table width=100% align=center>
<tr>
  <td align=center><b>2.3 Trattamento dell'acqua dell'impianto di climatizzazione (Rif. UNI 8065)</b></td>
</tr>
<tr>
<td>
    <table width=100% align=center>   
         <tr>
            <td colspan=4>$img_assente_cli_tipo Assente</td>
         </tr>
         <tr>
            <td>$img_filtrazione Filtrazione</td>
            <td colspan=2>$img_addolcimento Addolcimento:<br><small>durezza totale acqua impianto.</small> $tratt_acqua_clima_addolc (°fr)</td>
            <td>$img_con_chimico Condizionamento chimico</td>
         </tr>
         <tr>
            <td align=right>Protezione del gelo:</td>
            <td colspan=3>$img_assente_gelo Assente</td>
         </tr>
         <tr>
            <td></td>
            <td>$img_etilenico Glicole etilenico<br><small>concentrazione glicole nel fluido termovettore</small></td> 
            <td>$tratt_acqua_clima_prot_gelo_eti_perc (%)</td>
            <td>$tratt_acqua_clima_prot_gelo_eti (pH)</td>
         </tr>
         <tr>
            <td></td>
            <td>$img_propilenico Glicole propilenico<br><small>concentrazione glicole nel fluido termovettore</small></td>
            <td>$tratt_acqua_clima_prot_gelo_pro_perc (%)</td>
            <td>$tratt_acqua_clima_prot_gelo_pro (pH)</td>
         </tr>
   </table>
</td>
</tr>
</table>"

append libretto "
    <table width=100%>
          <tr>
             <td>&nbsp;</td>
          <tr>
    </table>";#sim02  

    set img_assente_acs          $img_unchecked
    set img_filtrazione_acs      $img_unchecked
    set img_addolcimento_acs     $img_unchecked
    set img_con_chimico_acs      $img_unchecked

    if {$tratt_acqua_calda_sanit_tipo eq "A"} {
        set img_assente_acs $img_checked
    }
    if {$tratt_acqua_calda_sanit_tipo eq "F"} {
        set img_filtrazione_acs $img_checked
    }
    if {$tratt_acqua_calda_sanit_tipo eq "D"} {
        set img_addolcimento_acs $img_checked
    }
    if {$tratt_acqua_calda_sanit_tipo eq "C"} {
        set img_con_chimico_acs $img_checked
    }

    append libretto "
    <table width=100% align=center>
          <tr>
             <td align=center colspan=4><b>2.4 Trattamento dell'acqua calda sanitaria</b></td>
          </tr>
          <tr>
             <td>$img_assente_acs Assente</td>
             <td>$img_filtrazione_acs Filtrazione</td>
             <td>$img_addolcimento_acs Addolcimento<br><small>durezza totale uscita addolcitore</small> $tratt_acqua_calda_sanit_addolc (°fr)</td>
             <td>$img_con_chimico_acs Condizionamento chimico</td>
          </tr>"

    append libretto "</table>
    <table width=100%>
          <tr>
             <td>&nbsp;</td>
          <tr>
    </table>"

    set img_acqua_raff_assente $img_unchecked
    
    if {$tratt_acqua_raff_assente eq "S"} {
	set img_acqua_raff_assente $img_checked
    }
    
    append libretto "
    <table width=100% align=center>
          <tr>
             <td align=center><b>2.5 Trattamento dell'acqua di raffreddamento dell'impianto di climatizzazione estiva</b></td>
          </tr>
          <tr>
             <td>$img_acqua_raff_assente Assente</td>
          </tr>"

    #append libretto "</table>
    #<table width=100%>
    #      <tr>
    #         <td>&nbsp;</td>
    #      <tr>
    #</table>"

    set img_senza_rec $img_unchecked
    set img_rec_parzi $img_unchecked
    set img_rec_tot   $img_unchecked
 
    if {$tratt_acqua_raff_tipo_circuito eq "S"} {
        set img_senza_rec $img_checked
    }
    if {$tratt_acqua_raff_tipo_circuito eq "P"} {
        set img_rec_parzi $img_checked
    }
    if {$tratt_acqua_raff_tipo_circuito eq "T"} {
        set img_rec_tot $img_checked
    }

    append libretto "
    <table width=100% align=center>
          <tr>
             <td align=center colspan=3><b>Tipologia di raffreddamento</b></td>
          </tr>
          <tr>
             <td>$img_senza_rec senza recupero termico</td>
             <td>$img_rec_parzi a recupero termico parziale</td>
             <td>$img_rec_tot a recupero termico totale</td>
          </tr>
    </table>
    <table width=100%>
          <tr>
             <td>&nbsp;</td>
          <tr>
    </table>";#sim02

    set img_acquedotto $img_unchecked
    set img_pozzo $img_unchecked
    set img_acqua_sup $img_unchecked

    if {$tratt_acqua_raff_origine eq "A"} {
	set img_acquedotto $img_checked
    }
    if {$tratt_acqua_raff_origine eq "P"} {
        set img_pozzo $img_checked
    }
    if {$tratt_acqua_raff_origine eq "S"} {
        set img_acqua_sup $img_checked
    }

    append libretto "
    <table width=100% align=center>
          <tr>
             <td align=center colspan=3><b>Origine acqua di alimento</b></td>
          </tr>
          <tr>
             <td>$img_acquedotto acquedotto</td>
             <td>$img_pozzo pozzo</td>
             <td>$img_acqua_sup acqua superficiale</td>
          </tr>
    </table>
    <table width=100%>
          <tr>
             <td>&nbsp;</td>
          <tr>
    </table>";#sim02

    set img_acqua_raff_filtraz_flag  $img_unchecked      
    set img_acqua_raff_filtraz_1     $img_unchecked      
    set img_acqua_raff_filtraz_2     $img_unchecked      
    set img_acqua_raff_filtraz_3     $img_unchecked      
    set img_acqua_raff_filtraz_4     $img_unchecked

    if {$tratt_acqua_raff_filtraz_flag eq "S"} {
	set img_acqua_raff_filtraz_flag $img_checked
    }
    if {$tratt_acqua_raff_filtraz_1 eq "S"} {
        set img_acqua_raff_filtraz_1 $img_checked
    }
    if {$tratt_acqua_raff_filtraz_2 eq "S"} {
        set img_acqua_raff_filtraz_2 $img_checked
    }
    if {$tratt_acqua_raff_filtraz_3 eq "S"} {
        set img_acqua_raff_filtraz_3 $img_checked
    }
    if {$tratt_acqua_raff_filtraz_4 eq "S"} {
        set img_acqua_raff_filtraz_4 $img_checked
    }

    set img_acqua_raff_tratt_flag  $img_unchecked      
    set img_acqua_raff_tratt_1     $img_unchecked      
    set img_acqua_raff_tratt_2     $img_unchecked      
    set img_acqua_raff_tratt_3     $img_unchecked      
    set img_acqua_raff_tratt_4     $img_unchecked
    set img_acqua_raff_tratt_5     $img_unchecked

    if {$tratt_acqua_raff_tratt_flag eq "S"} {
	set img_acqua_raff_tratt_flag $img_checked
    }
    if {$tratt_acqua_raff_tratt_1 eq "S"} {
        set img_acqua_raff_tratt_1 $img_checked
    }
    if {$tratt_acqua_raff_tratt_2 eq "S"} {
        set img_acqua_raff_tratt_2 $img_checked
    }
    if {$tratt_acqua_raff_tratt_3 eq "S"} {
        set img_acqua_raff_tratt_3 $img_checked
    }
    if {$tratt_acqua_raff_tratt_4 eq "S"} {
        set img_acqua_raff_tratt_4 $img_checked
    }
    if {$tratt_acqua_raff_tratt_5 eq "S"} {
        set img_acqua_raff_tratt_5 $img_checked
    }
    
    set img_acqua_raff_cond_flag  $img_unchecked      
    set img_acqua_raff_cond_1     $img_unchecked      
    set img_acqua_raff_cond_2     $img_unchecked      
    set img_acqua_raff_cond_3     $img_unchecked      
    set img_acqua_raff_cond_4     $img_unchecked
    set img_acqua_raff_cond_5     $img_unchecked
    set img_acqua_raff_cond_6     $img_unchecked

    if {$tratt_acqua_raff_cond_flag eq "S"} {
	set img_acqua_raff_cond_flag $img_checked
    }
    if {$tratt_acqua_raff_cond_1 eq "S"} {
        set img_acqua_raff_cond_1 $img_checked
    }
    if {$tratt_acqua_raff_cond_2 eq "S"} {
        set img_acqua_raff_cond_2 $img_checked
    }
    if {$tratt_acqua_raff_cond_3 eq "S"} {
        set img_acqua_raff_cond_3 $img_checked
    }
    if {$tratt_acqua_raff_cond_4 eq "S"} {
        set img_acqua_raff_cond_4 $img_checked
    }
    if {$tratt_acqua_raff_cond_5 eq "S"} {
        set img_acqua_raff_cond_5 $img_checked
    }
    if {$tratt_acqua_raff_cond_6 eq "S"} {
        set img_acqua_raff_cond_6 $img_checked
    }

    #rom10 aggiunti a campi ratt_acqua_raff_filtraz_note_altro, tratt_acqua_raff_tratt_note_altro e tratt_acqua_raff_cond_note_altro.
    append libretto "
    <table width=100% align=center>
          <tr>
             <td align=center><b>Trattamenti acqua esistenti</b></td>
          </tr>
   
     <tr>
     <td>
         <table width=100% align=center>
          <tr>
             <td>$img_acqua_raff_filtraz_flag Filtrazione</td>
             <td>$img_acqua_raff_filtraz_1 filtrazione di sicurezza</td>
          </tr>
          <tr>
             <td></td>
             <td>$img_acqua_raff_filtraz_2 filtrazione a masse</td>
          </tr>
          <tr>
             <td></td>
             <td>$img_acqua_raff_filtraz_3 altro <u>$tratt_acqua_raff_filtraz_note_altro</u></td>
          </tr>
          <tr>
             <td></td>
             <td>$img_acqua_raff_filtraz_4 nessun trattamento</td>
          </tr>
          <tr>
             <td>$img_acqua_raff_tratt_flag Trattamento acqua</td>
             <td>$img_acqua_raff_tratt_1 addolcimento</td>
          </tr>
          <tr>
             <td></td>
             <td>$img_acqua_raff_tratt_2 osmosi inversa</td>
          </tr>
          <tr>
             <td></td>
             <td>$img_acqua_raff_tratt_3 demineralizzazione</td>
          </tr>
          <tr>
             <td></td>
             <td>$img_acqua_raff_tratt_4 altro <u>$tratt_acqua_raff_tratt_note_altro</u></td>
          </tr>
          <tr>
             <td></td>
             <td>$img_acqua_raff_tratt_5 nessun trattamento</td>
          </tr>
          <tr>
             <td>$img_acqua_raff_cond_flag Condizionamento chimico</td>
             <td>$img_acqua_raff_cond_1 a prevalente azione antincrostante</td>
          </tr>
          <tr>
             <td></td>
             <td>$img_acqua_raff_cond_2 a prevalente azione anticorrosiva</td>
          </tr>
          <tr>
             <td></td>
             <td>$img_acqua_raff_cond_3 azione antincrostante e anticorrosiva</td>
          </tr>
          <tr>
             <td></td>
             <td>$img_acqua_raff_cond_4 biocida</td>
          </tr>
          <tr>
             <td></td>
             <td>$img_acqua_raff_cond_5 altro <u>$tratt_acqua_raff_cond_note_altro</u></td>
          </tr>
          <tr>
             <td></td>
             <td>$img_acqua_raff_cond_6 nessun trattamento</td>
          </tr>
         </table>
    </td>
    </tr>
    </table>
    <table width=100%>
          <tr>
             <td>&nbsp;</td>
          <tr>
    </table>";#sim02

    set img_raff_spurgo_flag $img_unchecked
    
    if {$tratt_acqua_raff_spurgo_flag eq "S"} {
        set img_raff_spurgo_flag $img_checked
    }

    append libretto "<table width=100% align=center>
          <tr>
             <td align=center colspan=1><b>Gestione torre di raffreddamento</b></td>
          </tr>
          <tr>
             <td>$img_raff_spurgo_flag Presenza sistema spurgo automatico (per circuiti a recupero parziale)</td>
          </tr>
          <tr>
             <td>Conducibilità acqua in ingresso $tratt_acqua_raff_spurgo_cond_ing</td>
          </tr>
          <tr>
             <td>Taratura valore conducibilità inizio spurgo $tratt_acqua_raff_spurgo_tara_cond</td>
          </tr>
          </table>";#sim02

    #append libretto "
    #<table width=100%>
    #      <tr>
    #         <td>&nbsp;</td>
    #      <tr>
    #</table>"


}


append libretto "
    <!-- PAGE BREAK -->
    $table_con_header_per_tutte_le_pagine
"


append libretto "
    <table width=100% border=1>
          <tr>
             <td align=center bgcolor=\"E1E1E1\"><big><b>3. Nomina del terzo responsabile</b></big></td>
          </tr>
    </table>"

#gac01                                     append libretto "
#gac01 table spostata dentro la foreach    <table width=100% align=center border>"
#gac01 aggiunto contatore 
set conta 0
set pagina_1 "t"

#rom08 per le Marche estraggo solo quelli con la data_inizio, per gli altri enti non cambia nulla
if {$coimtgen(regione) eq "MARCHE"} {#rom08 if, else e loro contenuto
    set where_data_inizio  "and a.data_inizio is not null"
    set flag_as_resp_occu $img_unchecked
    set flag_as_resp_prop $img_unchecked
    set flag_as_resp_ammi $img_unchecked
    
} else {
    set where_data_inizio ""
    set flag_as_resp_occu ""
    set flag_as_resp_prop ""
    set flag_as_resp_ammi ""
    
};#rom08

db_foreach sel_as_resp "" {
    incr conta 
    #gac01 se sono nella prima pagina faccio il page brrak dopo 4 tabelle
    if {$conta == 5 && $pagina_1 eq "t"} {
	append libretto "
            <!-- PAGE BREAK -->
$table_con_header_per_tutte_le_pagine"
	set conta 0
	set pagina_1 "f"
    } 
    #gac01 se sono nella seconda pagina lo faccio dopo 5 tabelle perche ce ne sta una in piu
    if {$pagina_1 eq "f" && $conta == 6} {
        append libretto "
            <!-- PAGE BREAK -->
 $table_con_header_per_tutte_le_pagine"
        set conta 0
    }
    
    if {$pagina_1 eq "t"} {
	append libretto "<br><br>"
    }
    
    if {$coimtgen(regione) eq "MARCHE"} {#rom06 aggiunta if, else e loro contenuto

	if {[db_0or1row q "select coalesce(iter_edit_data(data_fine),'&nbsp;') as data_cessazione
                             from coim_as_resp
                            where cod_impianto =  :cod_impianto
                              and cod_manutentore = :cod_manutentore
                              and data_fine > :db_data_inizio
                            order by data_fine desc
	                     limit 1"] == 1} {
	    set data_fine "al <b>$data_cessazione</b>"
	} else {
	    set data_fine ""
	};#rom08	
	if {$flag_as_resp eq "P"} {
	    set flag_as_resp_prop $img_checked
	} 
	if {$flag_as_resp eq "O"} {
	    set flag_as_resp_occu $img_checked
	}
	if {$flag_as_resp eq "A"} {
	    set flag_as_resp_ammi $img_checked
	}
	
	append libretto "
    <br>
    <table width=100% align=center>
          <tr>
             <td>
                <table width=100% align=center>
                     <tr>
                        <td>Il sottoscritto <b>$cognome_resp $nome_resp $cod_ficsc_resp $cod_piva_resp</b>,
                        <br>responsabile dell'impianto in qualit&agrave; di  $flag_as_resp_prop proprietario $flag_as_resp_occu occupante $flag_as_resp_ammi amministratore</td>
                     </tr>
                     <tr>
                        <td>affida la responsabilit&agrave; dell'impianto termico $cod_impianto_est alla Ditta <b> $cognome_manu $nome_manu</b></td><!--gac11-->
                     </tr>
                     <tr> 
                        <td>iscritta alla CCIAA di <b>$localita_reg</b>, al numero <b>$reg_imprese</b></td>
                     </tr>
                     <tr>
                        <td><b>Riferimento:</b> contratto valido dal <b>$data_inizio</b> $data_fine <br>&nbsp; </td>
                     </tr> "
	
    } else {#rom06 aggiunta else
	
	append libretto "
    <br>
    <table width=100% align=center>
          <tr>
             <td>
                <table width=100% align=center>
                     <tr>
                        <td>Il sottoscritto <b>$cognome_legale $nome_legale</b></td>
                     </tr>
                     <tr>
                        <td>Legale rappresentante della Ditta <b> $cognome_manu $nome_manu</b></td>
                     </tr>
                     <tr>
                        <td>iscritta alla CCIAA di <b>$localita_reg</b>, al numero <b>$reg_imprese</b></td>
                     </tr>
                     <tr>
                        <td align=center><b>Comunica</b></td>
                     </tr>"

	if {$data_inizio ne ""} {
	    append libretto "
           <tr>
              <td>di aver assunto l'incarico di terzo responsabile dalla data del <b>$data_inizio</b> <br>&nbsp; </td>
           </tr> "
	} else {
	    append libretto "
           <tr>
              <td>di non essere più terzo responsabile dal <b>$data_fine</b> <br>&nbsp; </td>
           </tr>"
	}
    };#rom06	
    append libretto "
                <tr>
                   <td>Firma del proprietario/occupante/amministratore &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; _____________________</td>
                </tr>
                <tr>
                   <td> <br> Firma del terzo responsabile &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; _____________________</td>
                </tr>
         </table>
     </td> 
 </tr> 
</table>
"

    
} if_no_rows {
    append libretto "
<table width=100% align=center>
    <tr>
       <td>&nbsp;</td>
    </tr>
    <tr>
       <td>Non esiste alcun terzo responsabile</td>
    </tr>
</table>"
}

    append libretto "
        <!-- PAGE BREAK -->
        $table_con_header_per_tutte_le_pagine
"


append libretto "
    <table width=100% border=1>
          <tr>
             <td align=center bgcolor=\"E1E1E1\"><big><b>4. Generatori</b></big></td>
          </tr>
    </table>"

if {[db_0or1row sel_aimp ""] == 0} {
    iter_return_complaint "Impianto non trovato"
}

# Generatori
set gen_prog ""
set gen_prog_est ""
set matricola  ""
set costruttore_gend ""
set modello ""
set descr_comb ""
set data_installaz ""
set pot_focolare_lib ""
set stato_gen ""

append libretto "
<table width=100% align=center>
          <tr>
             <td>&nbsp;</td>
          </tr>
       <tr>
          <td align=center><b>4.1 Gruppi termici o caldaie.</b></td>
       </tr>
       <tr>
          <td>&nbsp;</td>
        </tr>
</table>
"

set num_gend_ri "0"
set where_gend_sost "and a.gen_prog_originario is null"
db_foreach sel_gend_ri "" {
    regsub -all {<} $matricola {\&lt;} matricola;#sim07
    regsub -all {>} $matricola {\&gt;} matricola;#sim07

    set img_GTS  $img_unchecked
    set img_GTM $img_unchecked
    set img_TNR  $img_unchecked
    set img_GAC  $img_unchecked
    set num_GTM  "__"

    if {$cod_grup_term eq "GTS"} {
        set img_GTS $img_checked
    }
    
    if {$cod_grup_term eq "GTM1"} {
        set img_GTM $img_checked
	set num_GTM "$num_prove_fumi"
    }
    
    if {$cod_grup_term eq "GTM2"} {
        set img_GTM $img_checked
	set num_GTM "2"
    }
    
    if {$cod_grup_term eq "GTM3"} {
        set img_GTM $img_checked
	set num_GTM "3"
    }
    
    if {$cod_grup_term eq "TNR"} {
        set img_TNR $img_checked
    }
 
    if {$cod_grup_term eq "GAC"} {
        set img_GAC $img_checked
    }
    
    if {$cod_grup_term eq "GTM"} {
        set img_GTM $img_checked
    }
    
    append libretto "
     <table width=100% border=1>
       <tr>
          <td align=left width=20%>Gruppo Termico<br>GT $gen_prog_est</td>
          <td align=left width=80%>Situazione alla prima installazione o alla ristrutturazione dell'impianto termico $cod_impianto_est</td><!--gac11-->
       </tr>
    <tr>
    <td colspan=2>
    <table width=100%>
       <tr>            
          <td align=left>Data installazione</td>
          <td align=left>$data_installaz</td>
          <td align=left>Data dismissione</td>
          <td align=left>$data_rottamaz </td>
       </tr>
       <tr>   
          <td align=left>Fabbricante</td>         
          <td align=left>$costruttore_gend</td>
          <td align=left>Modello </td>
          <td align=left>$modello</td>
       </tr>
       <tr>
          <td align=left>Matricola </td>
          <td align=left colspan=3>$matricola</td>
       </tr>
       <tr>              
          <td align=left>Combustibile</td>
          <td align=left>$descr_comb</td>
          <td align=left>Fluido Termovettore</td>
          <td align=left>$fluido_termovettore</td>
       </tr> 
       <tr>
          <td align=left>Potenza termica utile nominale Pn max</td>
          <td align=left>$pot_utile_nom (kW)</td>
          <td align=left>Rendimento termico utile a Pn max</td>
          <td align=left>$rend_ter_max (%)</td>
       </tr>
       <tr>
       <tr>
          <td colspan=2 align=left>$img_GTS Gruppo termico singolo</td>
          <td colspan=2 align=left>$img_GTM Gruppo termico modulare con n° $num_GTM analisi fumi previste</td>
       </tr>
       <tr>
          <td colspan=2 align=left>$img_TNR Tubo / nastro radiante</td>
          <td colspan=2 align=left>$img_GAC Generatore d'aria calda</td>
       </tr>
      
       </table>
     </td>
     </tr>
   </table><br><br>"

    set  num_gend_ri "1"
}

if {$flag_gest_targa eq "T"} {#sim04: aggiunta if e suo contenuto
    set q_sel_gend_ri_padre "sel_gend_ri_padre_targa"
} else {
    set q_sel_gend_ri_padre "sel_gend_ri_padre"
}
set where_gend_sost "and a.gen_prog_originario is null"
db_foreach $q_sel_gend_ri_padre "" {
    regsub -all {<} $matricola_padre {\&lt;} matricola_padre;#sim07
    regsub -all {>} $matricola_padre {\&gt;} matricola_padre;#sim07

    set img_GTS_padre  $img_unchecked
    set img_GTM_padre $img_unchecked
    set img_TNR_padre  $img_unchecked
    set img_GAC_padre  $img_unchecked
    set num_GTM_padre  "__"

    if {$cod_grup_term_padre eq "GTS"} {
        set img_GTS_padre $img_checked
    }
    
    if {$cod_grup_term_padre eq "GTM1"} {
        set img_GTM_padre $img_checked
	set num_GTM_padre "$num_prove_fumi_padre"
    }
    
    if {$cod_grup_term_padre eq "GTM2"} {
        set img_GTM_padre $img_checked
	set num_GTM_padre "2"
    }
    
    if {$cod_grup_term_padre eq "GTM3"} {
        set img_GTM_padre $img_checked
	set num_GTM_padre "3"
    }
    
    if {$cod_grup_term_padre eq "TNR"} {
        set img_TNR_padre $img_checked
    }
 
    if {$cod_grup_term_padre eq "GAC"} {
        set img_GAC_padre $img_checked
    }
    
    if {$cod_grup_term_padre eq "GTM"} {
        set img_GTM_padre $img_checked
    }
    
    append libretto "
     <table width=100% border=1>
       <tr>
          <td align=left width=20%>Gruppo Termico<br>GT $gen_prog_est_padre</td>
          <td align=left width=100%>Situazione alla prima installazione o alla ristrutturazione dell'impianto termico $cod_impianto_est_padre</td><!--gac11-->
       </tr>
    <tr>
    <td colspan=2>
    <table width=100%>
       <tr>            
          <td align=left>Data installazione</td>
          <td align=left>$data_installaz_padre</td>
          <td align=left>Data dismissione</td>
          <td align=left>$data_rottamaz_padre</td>
       </tr>
       <tr>   
          <td align=left>Fabbricante</td>         
          <td align=left>$costruttore_gend_padre</td>
          <td align=left>Modello </td>
          <td align=left>$modello_padre</td>
       </tr>
       <tr>
          <td align=left>Matricola </td>
          <td align=left colspan=3>$matricola_padre</td>
       </tr>
       <tr>              
          <td align=left>Combustibile</td>
          <td align=left>$descr_comb_padre</td>
          <td align=left>Fluido Termovettore</td>
          <td align=left>$fluido_termovettore_padre</td>
       </tr> 
       <tr>
          <td align=left>Potenza termica utile nominale Pn max</td>
          <td align=left>$pot_utile_nom_padre (kW)</td>
          <td align=left>Rendimento termico utile a Pn max</td>
          <td align=left>$rend_ter_max_padre (%)</td>
       </tr>
       <tr>
       <tr>
          <td colspan=2 align=left>$img_GTS_padre Gruppo termico singolo</td>
          <td colspan=2 align=left>$img_GTM_padre Gruppo termico modulare con n° $num_GTM_padre analisi fumi previste</td>
       </tr>
       <tr>
          <td colspan=2 align=left>$img_TNR_padre Tubo / nastro radiante</td>
          <td colspan=2 align=left>$img_GAC_padre Generatore d'aria calda</td>
       </tr>
      
       </table>
     </td>
     </tr>
   </table><br><br>"

    set  num_gend_ri "1"
}


if {$num_gend_ri eq "1"} {

	set where_gend_sost "and a.gen_prog_originario is not null"

	append libretto "
    <table width=100%>
          <tr>
             <td colspan=2>&nbsp;</td>
          </tr>
          </tr>
          <tr>
             <td colspan=2><b>SOSTITUZIONI DEL COMPONENTE</b></td>
          </tr>
          <tr>
             <td>&nbsp;</td>
          </tr>
    </table>"
	
	db_foreach sel_gend_ri_sost "" {
	    regsub -all {<} $matricola_sost {\&lt;} matricola;#sim07
	    regsub -all {>} $matricola_sost {\&gt;} matricola;#sim07
	    
	    set img_GTS_sost  $img_unchecked
	    set img_GTM_sost $img_unchecked
	    set img_TNR_sost  $img_unchecked
	    set img_GAC_sost  $img_unchecked
	    set num_GTM_sost  "__"
	    
	    if {$cod_grup_term_sost eq "GTS"} {
		set img_GTS_sost $img_checked
	    }
	    
	    if {$cod_grup_term_sost eq "GTM1"} {
		set img_GTM_sost $img_checked
		set num_GTM_sost "$num_prove_fumi_sost"
	    }
	    
	    if {$cod_grup_term_sost eq "GTM2"} {
		set img_GTM_sost $img_checked
		set num_GTM_sost "2"
	    }
	    
	    if {$cod_grup_term_sost eq "GTM3"} {
		set img_GTM_sost $img_checked
		set num_GTM_sost "3"
	    }
	    
	    if {$cod_grup_term_sost eq "TNR"} {
		set img_TNR_sost $img_checked
	    }
	    
	    if {$cod_grup_term_sost eq "GAC"} {
		set img_GAC_sost $img_checked
	    }
	    
	    if {$cod_grup_term_sost eq "GTM"} {
		set img_GTM_sost $img_checked
	    }

	    
	    append libretto "
     <table width=100% border=1>
       <tr>
          <td align=left width=20%>Gruppo Termico<br>GT $gen_prog_est_sost</td>
          <td align=left width=100%>Sostituzione del componente dell'impianto termico $cod_impianto_est</td>
       </tr>
    <tr>
    <td colspan=2>
    <table width=100%>
       <tr>            
          <td align=left>Data installazione</td>
          <td align=left>$data_installaz_sost</td>
          <td align=left>Data dismissione</td>
          <td align=left>$data_rottamaz_sost</td>
       </tr>
       <tr>   
          <td align=left>Fabbricante</td>         
          <td align=left>$costruttore_gend_sost</td>
          <td align=left>Modello </td>
          <td align=left>$modello_sost</td>
       </tr>
       <tr>
          <td align=left>Matricola </td>
          <td align=left colspan=3>$matricola_sost</td>
       </tr>
       <tr>              
          <td align=left>Combustibile</td>
          <td align=left>$descr_comb_sost</td>
          <td align=left>Fluido Termovettore</td>
          <td align=left>$fluido_termovettore_sost</td>
       </tr> 
       <tr>
          <td align=left>Potenza termica utile nominale Pn max</td>
          <td align=left>$pot_utile_nom_sost (kW)</td>
          <td align=left>Rendimento termico utile a Pn max</td>
          <td align=left>$rend_ter_max_sost (%)</td>
       </tr>
       <tr>
       <tr>
          <td colspan=2 align=left>$img_GTS_sost Gruppo termico singolo</td>
          <td colspan=2 align=left>$img_GTM_sost Gruppo termico modulare con n° $num_GTM_sost analisi fumi previste</td>
       </tr>
       <tr>
          <td colspan=2 align=left>$img_TNR_sost Tubo / nastro radiante</td>
          <td colspan=2 align=left>$img_GAC_sost Generatore d'aria calda</td>
       </tr>
      
       </table>
     </td>
     </tr>
   </table><br>"

	}
	
	if {$flag_gest_targa eq "T"} {
	    set q_sel_gend_ri_padre_sost "sel_gend_ri_padre_targa_sost"
	} else {
	    set q_sel_gend_ri_padre_sost "sel_gend_ri_padre_sost"
	}

    set where_gend_sost "and a.gen_prog_originario is not null"
    db_foreach $q_sel_gend_ri_padre_sost "" {
	    regsub -all {<} $matricola_padre_sost {\&lt;} matricola_padre_sost
	    regsub -all {>} $matricola_padre_sost {\&gt;} matricola_padre_sost
	    
	    set img_GTS_padre_sost  $img_unchecked
	    set img_GTM_padre_sost  $img_unchecked
	    set img_TNR_padre_sost  $img_unchecked
	    set img_GAC_padre_sost  $img_unchecked
	    set num_GTM_padre_sost  "__"
	    
	    if {$cod_grup_term_padre_sost eq "GTS"} {
		set img_GTS_padre_sost $img_checked
	    }
	    
	    if {$cod_grup_term_padre_sost eq "GTM1"} {
		set img_GTM_padre_sost $img_checked
		set num_GTM_padre_sost "$num_prove_fumi_padre_sost"
	    }
	    
	    if {$cod_grup_term_padre_sost eq "GTM2"} {
		set img_GTM_padre_sost $img_checked
		set num_GTM_padre_sost "2"
	    }
	    
	    if {$cod_grup_term_padre_sost eq "GTM3"} {
		set img_GTM_padre_sost $img_checked
		set num_GTM_padre_sost "3"
	    }
	    
	    if {$cod_grup_term_padre_sost eq "TNR"} {
		set img_TNR_padre_sost $img_checked
	    }
	    
	    if {$cod_grup_term_padre_sost eq "GAC"} {
		set img_GAC_padre_sost $img_checked
	    }
	    
	    if {$cod_grup_term_padre_sost eq "GTM"} {
		set img_GTM_padre_sost $img_checked
	    }

	    append libretto "
     <table width=100% border=1>
       <tr>
          <td align=left width=20%>Gruppo Termico<br>GT $gen_prog_est_padre_sost</td>
          <td align=left width=100%>Sostituzione del componente dell'impianto terrmico $cod_impianto_est_padre</td>
       </tr>
    <tr>
    <td colspan=2>
    <table width=100%>
       <tr>            
          <td align=left>Data installazione</td>
          <td align=left>$data_installaz_padre_sost</td>
          <td align=left>Data dismissione</td>
          <td align=left>$data_rottamaz_padre_sost</td>
       </tr>
       <tr>   
          <td align=left>Fabbricante</td>         
          <td align=left>$costruttore_gend_padre_sost</td>
          <td align=left>Modello </td>
          <td align=left>$modello_padre_sost</td>
       </tr>
       <tr>
          <td align=left>Matricola </td>
          <td align=left colspan=3>$matricola_padre_sost</td>
       </tr>
       <tr>              
          <td align=left>Combustibile</td>
          <td align=left>$descr_comb_padre_sost</td>
          <td align=left>Fluido Termovettore</td>
          <td align=left>$fluido_termovettore_padre_sost</td>
       </tr> 
       <tr>
          <td align=left>Potenza termica utile nominale Pn max</td>
          <td align=left>$pot_utile_nom_padre_sost (kW)</td>
          <td align=left>Rendimento termico utile a Pn max</td>
          <td align=left>$rend_ter_max_padre_sost (%)</td>
       </tr>
       <tr>
       <tr>
          <td colspan=2 align=left>$img_GTS_padre_sost Gruppo termico singolo</td>
          <td colspan=2 align=left>$img_GTM_padre_sost Gruppo termico modulare con n° $num_GTM_padre_sost analisi fumi previste</td>
       </tr>
       <tr>
          <td colspan=2 align=left>$img_TNR_padre_sost Tubo / nastro radiante</td>
          <td colspan=2 align=left>$img_GAC_padre_sost Generatore d'aria calda</td>
       </tr>
      
       </table>
     </td>
     </tr>
   </table><br>"
	}
    
} else {
    append libretto "
    <tr>
       <td colspan=10>Non esiste alcun generatore</td>
    </tr>
    </table>"
}

append libretto "
    <!-- PAGE BREAK -->
    $table_con_header_per_tutte_le_pagine
"
#rom03 Aggiunta Scheda 4.1 bis 
if {$coimtgen(regione) eq "MARCHE"} {#rom03: if e suo contenuto
    if {[db_0or1row sel_aimp ""] == 0} {
	iter_return_complaint "Impianto non trovato"
    }
    
    # Generatori
    set locale                       ""                 
    set dpr_660_96                   ""
    set flag_caldaia_comb_liquid     ""
    set tipo_foco                    ""
    set funzione_grup_ter            ""
    set funzione_grup_ter_note_altro ""
    set tiraggio                     ""
    set cod_emissione                ""
    set data_installaz               ""
    
    append libretto "
    <table width=100% border=1>
          <tr>
             <td align=center bgcolor=\"E1E1E1\"><big><b>4. Generatori</b></big></td>
          </tr>
    </table>"

    append libretto "
       <table width=100% align=center>
          <tr>
             <td>&nbsp;</td>
          </tr>
       <tr>
          <td align=center><b>4.1bis Dati Specifici Gruppi termici.</td>
       </tr>
       <tr>
         <td>&nbsp;</td>
       </tr>
       </table>"
    set num_gend_ri_4_1bis "0"
    set where_gend_sost "and a.gen_prog_originario is null"   
    db_foreach sel_gend_4_1bis "" {
	set img_prod_acqua_4_1bis $img_unchecked
	set pot_utile_prod_acqua_4_1bis ""
	set img_cli_inv_4_1bis $img_unchecked 
	set pot_utile_cli_inv_4_1bis ""
	set img_cli_est_4_1bis $img_unchecked
	set pot_utile_cli_est_4_1bis ""
	set img_altro_4_1bis $img_unchecked;
	set note_altro_4_1bis ""
	
	if {$flag_prod_acqua_calda_4_1bis eq "S"} {
	    set img_prod_acqua_4_1bis $img_checked
	    set pot_utile_prod_acqua_4_1bis "- <b>Potenza Utile: $potenza_utile_4_1bis</b>"
	}
	if {$flag_clima_invernale_4_1bis eq "S"} {
	    set img_cli_inv_4_1bis $img_checked
	    set pot_utile_cli_inv_4_1bis "- <b>Potenza Utile: $potenza_utile_4_1bis</b>"
	}
	if {$flag_clim_est_4_1bis eq "S"} {
	    set img_cli_est_4_1bis $img_checked
	    set pot_utile_cli_est_4_1bis "- <b>Potenza Utile: $potenza_utile_4_1bis</b>"
	}
	if {$flag_altro_4_1bis eq "S" } {
	    set img_altro_4_1bis $img_checked
	    set note_altro_4_1bis "<u>$funzione_grup_ter_note_altro_4_1bis</u>"   
	}
	    
	append libretto "
<table width=100% border=1>
    <tr>
       <td align=left width=20%>Gruppo Termico GT $gen_prog_est_4_1bis</td>
       <td align=left width=80%>Situazione alla prima installazione o alla ristrutturazione dell'impianto termico $cod_impianto_est_4_1bis</td><!--gac09 e gac11-->
    </tr>
    <tr>
       <td colspan=2>
  <table  border=0>
       <tr>
         <td align=left>Locale Installazione</td>
         <td align=left>$locale_4_1bis</td>
         <td align=left>Classif. DPR 660/96</td>
         <td align=left>$dpr_660_96_4_1bis</td>
       </tr>
       <tr>  
         <td align=left>Caldaia a cond. a combust. liquid.</td>
         <td align=left>$flag_caldaia_comb_liquid_4_1bis</td>
         <td align=left>Camera Combustione</td>
         <td align=left>$tipo_foco_4_1bis</td>
       </tr>
       <tr>  
         <td align=left colspan=2 width=50%>$img_prod_acqua_4_1bis Prod. Acq. calda sanitaria $pot_utile_prod_acqua_4_1bis</td>
         <td align=left colspan=2 width=50%>$img_cli_inv_4_1bis Climatizzazione inv. $pot_utile_cli_inv_4_1bis</td>
       </tr>
       <tr>
         <td align=left colspan=2 width=50%>$img_cli_est_4_1bis Climatizzazione est. $pot_utile_cli_est_4_1bis</td>
         <td align=left colspan=2 width=50%>$img_altro_4_1bis Altro $note_altro_4_1bis</td>
       </tr>
       <tr>
         <td align=left>Evacuazione fumi</td>
         <td align=left>$tiraggio_4_1bis</td>
         <td align=left>Scarico fumi</td>
         <td align=left>$cod_emissione_4_1bis</td>
       </tr>
       <tr>  
         <td align=left>Data costruzione</td>
         <td align=left>$data_costruz_gen_4_1bis</td>
       </tr>
       <tr>
         <td align=left>Attivo</td>
         <td align=left>$attivo_si_no_4_1bis</td>
         <td align=left>Motivazione GT inattivo</td>
         <td align=left>$motivazione_disattivo_4_1bis</td>
       </tr>
    </table>
</td>
</tr>
</table>
<br>"
	set num_gend_ri_4_1bis "1"
    }

    if {$num_gend_ri_4_1bis eq "1"} {

	append libretto "<table width=100%>
          <tr>
             <td>&nbsp;</td>
          </tr>
          <tr>
             <td align=left><b>SOSTITUZIONI DEL COMPONENTE</b></td>
          </tr>
     </table><br>"
	set where_gend_sost "and a.gen_prog_originario is not null"
	
    db_foreach sel_gend_4_1bis_sost "" {
	
	set  num_gend_ri_4_1bis "1"
	set img_prod_acqua_4_1bis_sost $img_unchecked
	set pot_utile_prod_acqua_4_1bis_sost ""
	set img_cli_inv_4_1bis_sost $img_unchecked 
	set pot_utile_cli_inv_4_1bis_sost ""
	set img_cli_est_4_1bis_sost $img_unchecked
	set pot_utile_cli_est_4_1bis_sost ""
	set img_altro_4_1bis_sost $img_unchecked;
	set note_altro_4_1bis_sost ""
	
	if {$flag_prod_acqua_calda_4_1bis_sost eq "S"} {
	    set img_prod_acqua_4_1bis_sost $img_checked
	    set pot_utile_prod_acqua_4_1bis_sost "- <b>Potenza Utile: $potenza_utile_4_1bis_sost</b>"
	}
	if {$flag_clima_invernale_4_1bis_sost eq "S"} {
	    set img_cli_inv_4_1bis_sost $img_checked
	    set pot_utile_cli_inv_4_1bis_sost "- <b>Potenza Utile: $potenza_utile_4_1bis_sost</b>"
	}
	if {$flag_clim_est_4_1bis_sost eq "S"} {
	    set img_cli_est_4_1bis_sost $img_checked
	    set pot_utile_cli_est_4_1bis_sost "- <b>Potenza Utile: $potenza_utile_4_1bis_sost</b>"
	}
	if {$flag_altro_4_1bis_sost eq "S" } {
	    set img_altro_4_1bis_sost $img_checked
	    set note_altro_4_1bis_sost "<u>$funzione_grup_ter_note_altro_4_1bis_sost</u>"   
	}
	    
	append libretto "
<table width=100% border=1>
    <tr>
        <td align=left width=20%>Gruppo termico GT $gen_prog_est_4_1bis_sost</td>
        <td align=left width=80%>Sostituzione del componente dell'impianto termico $cod_impianto_est_4_1bis_sost</td><!--gac09 e gac11-->
    </tr>
    <tr>
        <td colspan=2>
  <table width=100% border=0>
       <tr>
         <td align=left>Locale Installazione  </td>
         <td align=left>$locale_4_1bis_sost</td>
         <td align=left>Classif. DPR 660/96   </td>
         <td align=left>$dpr_660_96_4_1bis_sost</td>
       </tr>
       <tr>  
         <td align=left>Caldaia a cond. a combust. liquid.</td>
         <td align=left>$flag_caldaia_comb_liquid_4_1bis_sost</td>
         <td align=left>Camera Combustione    </td>
         <td align=left>$tipo_foco_4_1bis_sost</td>
       </tr>
       <tr>
         <td align=left colspan=2 width=50%>$img_prod_acqua_4_1bis_sost Prod. Acq. calda sanitaria $pot_utile_prod_acqua_4_1bis_sost</td>
         <td align=left colspan=2 width=50%>$img_cli_inv_4_1bis_sost Climatizzazione inv. $pot_utile_cli_inv_4_1bis_sost</td>
       </tr>
       <tr>
         <td align=left colspan=2 width=50%>$img_cli_est_4_1bis_sost Climatizzazione est. $pot_utile_cli_est_4_1bis_sost</td>
         <td align=left colspan=2 width=50%>$img_altro_4_1bis_sost Altro $note_altro_4_1bis_sost</td>
       </tr>
       <tr>
         <td align=left>Evacuazione fumi      </td>
         <td align=left>$tiraggio_4_1bis_sost</td>
         <td align=left>Scarico fumi          </td>
         <td align=left>$cod_emissione_4_1bis_sost</td>
       </tr>
       <tr>  
         <td align=left>Data costruzione            </td>
         <td align=left>$data_costruz_gen_4_1bis_sost</td>
       </tr>
       <tr>
         <td align=left>Attivo</td>
         <td align=left>$attivo_si_no_4_1bis_sost</td>
         <td align=left>Motivazione GT inattivo</td>
         <td align=left>$motivazione_disattivo_4_1bis_sost</td>
       </tr>
</table>
</td>
</tr>
   </table><br>"
    }

    } else {
	append libretto "
    <table>
    <tr>
       <td>Non esiste alcun generatore</td>
    </tr>
    </table>"
    }
    
    append libretto "
    <!-- PAGE BREAK -->
    $table_con_header_per_tutte_le_pagine
"
};#rom03

append libretto "
    <table width=100% border=1>
          <tr>
             <td align=center bgcolor=\"E1E1E1\"><big><b>4. Generatori</b></big></td>
          </tr>
    </table>"

append libretto "
<table width=100% align=center>
          <tr>
             <td>&nbsp;</td>
          </tr>
       <tr>
          <td align=center colspan=4><b>4.2 Bruciatori (se non incorporati nel gruppo termico)<br></b></td>
       </tr>
       <tr>
          <td colspan=4>&nbsp;</td>
       </tr>
</table>"

set num_bruc "0"

db_foreach sel_bruc "" {
    regsub -all {<} $matricola_bruc {\&lt;} matricola_bruc;#sim07
    regsub -all {>} $matricola_bruc {\&gt;} matricola_bruc;#sim07
    append libretto "
<table width=100% border=1>
  <tr>
    <td align=left width=20%>Bruciatore<br>BR $gen_prog_est_bruc</td>
    <td align=left width=25%>Collegato <small>al Gruppo Termico</small>  $cod_impianto_est_bruc<br>GT $gen_prog_est_bruc</td>
    <td align=left width=100%>Situazione alla prima installazione o alla ristrutturazione dell'impianto termico</td>
  </tr>
  <tr>
    <td colspan=3>
      <table width=100%>
        <tr>
          <td align=left>Data di installazione</td>
          <td align=left>$data_installaz_bruc</td>
          <td align=left>Data di dismissione</td>
          <td align=left>$data_rottamaz_bruc</td>
        </tr>
        <tr>
          <td align=left>Fabbricante</td>
          <td align=left>$descr_cost</td>
          <td align=left>Modello</td>
          <td align=left>$modello_bruc</td>
        </tr>
        <tr>
          <td align=left>Matricola</td>
          <td align=left>$matricola_bruc</td>
        </tr>
        <tr>
          <td align=left>Tipologia</td>
          <td align=left>$tipo_bruciatore</td>
          <td align=left>Combustibile</td>
          <td align=left>$descr_comb</td>
        </tr>
        <tr>   
          <td align=left>Portata termica max nominale</td>
          <td align=left>$campo_funzion_max (kW)</td>
          <td align=left>Portata termica min nominale</td>
          <td align=left>$campo_funzion_min (kW)</td>
        </tr>
        <tr>
          <td colspan=4>&nbsp;</td>
        </tr>
      </table>
    </td>
  </tr>
</table><br><br>"

    set  num_bruc "1"
}

if {$flag_gest_targa eq "T"} {#sim04: aggiunta if e suo contenuto
    set q_sel_bruc_padre "sel_bruc_padre_targa"
} else {
    set q_sel_bruc_padre "sel_bruc_padre"
}

db_foreach $q_sel_bruc_padre "" {
    regsub -all {<} $matricola_bruc_padre {\&lt;} matricola_bruc_padre;#sim07
    regsub -all {>} $matricola_bruc_padre {\&gt;} matricola_bruc_padre;#sim07
    append libretto "
<table width=100% border=1>
  <tr>
    <td align=left width=20%>Bruciatore<br>BR $gen_prog_est_bruc_padre</td>
    <td align=left width=25%>Collegato <small>al Gruppo Termico</small>  $cod_impianto_est_bruc_padre<br>GT $gen_prog_est_bruc_padre</td>
    <td align=left width=100%>Situazione alla prima installazione o alla ristrutturazione dell'impianto termico</td>
  </tr>
  <tr>
    <td colspan=3>
      <table width=100%>
        <tr> 
          <td align=left>Data di installazione</td>
          <td align=left>$data_installaz_bruc_padre</td>
          <td align=left>Data di dismissione</td>
          <td align=left>$data_rottamaz_bruc_padre</td>
        </tr>
        <tr>
          <td align=left>Fabbricante</td>
          <td align=left>$descr_cost_padre</td>
          <td align=left>Modello</td>
          <td align=left>$modello_bruc_padre</td>
        </tr>
        <tr>
          <td align=left>Matricola</td>
          <td align=left>$matricola_bruc_padre</td>
        </tr>
        <tr>
          <td align=left>Tipologia</td>
          <td align=left>$tipo_bruciatore_padre</td>
          <td align=left>Combustibile</td>
          <td align=left>$descr_comb_padre</td>
        </tr>
        <tr>   
          <td align=left>Portata termica max nominale</td>
          <td align=left>$campo_funzion_max_padre</td>
          <td align=left>Portata termica min nominale</td>
          <td align=left>$campo_funzion_min_padre</td>
        </tr>
      </table>
    </td>
  </tr>
</table><br><br>"

    set  num_bruc "1"
}

if {$num_bruc eq "1"} {

    append libretto "
    <table width=100%>
        <tr>
             <td colspan=2>&nbsp;</td>
          </tr>
          <tr>
             <td colspan=2><b>SOSTITUZIONI DEL COMPONENTE</b></td>
          </tr>
          <tr>
             <td colspan=2>&nbsp;</td>
          </tr>
          <tr>
             <td>Data di installazione _________________</td>
             <td>Data di dismissione _________________</td>
          </tr>
          <tr> 
             <td>Fabbricante _________________</td>
             <td>Modello _________________</td>
          </tr>
          <tr>
             <td colspan=2>Matricola _________________</td>
          </tr>
          <tr>
             <td>Tipologia _________________</td>
             <td>Combustibile_________________</td>
          </tr>
          <tr>
             <td>Potenza termica max nominale</td>
             <td>Potenza termica min nominale</td>
          <tr>
             <td colspan=2>&nbsp;</td>
          </tr>
          <tr>
             <td colspan=2>&nbsp;</td>
          </tr>
          <tr>
             <td>Data di installazione _________________</td>
             <td>Data di dismissione _________________</td>
          </tr>
          <tr>
             <td>Fabbricante _________________</td>
             <td>Modello _________________</td>
          </tr>
          <tr>
             <td colspan=2>Matricola_________________</td>
          </tr>
          <tr>
             <td>Tipologia _________________</td>
             <td>Combustibile _________________</td>
          </tr>
          <tr>
             <td>Potenza termica max nominale</td>
             <td>Potenza termica min nominale</td>
          </tr>
           <tr>
             <td colspan=2>&nbsp;</td>
          </tr>
          <tr>
             <td colspan=2>&nbsp;</td>
          </tr>
          <tr>
             <td>Data di installazione _________________</td>
             <td>Data di dismissione _________________</td>
          </tr>
          <tr>
             <td>Fabbricante _________________</td>
             <td>Modello _________________</td>
          </tr>
          <tr>
             <td colspan=2>Matricola_________________</td>
          </tr>
          <tr>
             <td>Tipologia _________________</td>
             <td>Combustibile _________________</td>
          </tr>
          <tr>
             <td>Potenza termica max nominale</td>
             <td>Potenza termica min nominale</td>
          </tr>
          <tr>
             <td colspan=2>&nbsp;</td>
          </tr>
    </table>"


} else {
    append libretto "
<table width=100%>
  <tr>
    <td colspan=4>Non esiste alcun bruciatore</td>
  </tr>
</table>"
}

append libretto "
    <table width=100%>
          <tr>
             <td>&nbsp;</td>
          <tr>
    </table>"


#gab02 Aggiunta sezione 4.3 Recuperatori/Condensatori
set cod_recu_cond_aimp ""
set num_rc ""
set data_installaz ""
set data_dismissione  ""
set descr_cost ""
set modello ""
set matricola ""
set portata_term_max ""
set portata_term_min ""

append libretto "
    <!-- PAGE BREAK -->
    $table_con_header_per_tutte_le_pagine
"
append libretto "
    <table width=100% border=1>
          <tr>
             <td align=center bgcolor=\"E1E1E1\"><big><b>4. Generatori</b></big></td>
          </tr>
    </table>"

append libretto "
    <table width=100% align=center>
          <tr>
             <td>&nbsp;</td>
          </tr>
       <tr>
          <td align=center colspan=4><b>4.3 Recuperatori / Condensatori lato fumi (se non incorporati nel gruppo termico).
       </tr>
       <tr>
          <td>&nbsp;</td>
       </tr>"

set sw_recu_comp "f"

db_foreach sel_recu_cond "" {
    regsub -all {<} $matricola {\&lt;} matricola;#sim07
    regsub -all {>} $matricola {\&gt;} matricola;#sim07
    append libretto "
     <table width=100% border=1>
       <tr>
          <td align=left width=20%>Recuperatore/condensatore<br>RC $num_rc</td>
          <td align=left width=25%>Collegato <small>al Gruppo Termico</small><br>GT $gt_collegato</td><!--rom10-->
          <td align=left width=80%>Situazione alla prima installazione o alla ristrutturazione dell'impianto termico</td>
       </tr>
    <tr>
    <td colspan=3>
    <table width=100%>
       <tr>
          <td align=left>Data Installazione</td>
          <td align=left>$data_installaz</td>
          <td align=left>Data Dismissione</td>
          <td align=left>$data_dismissione</td>
       </tr>
       <tr>
          <td align=left>Fabbricante</td>
          <td align=left>$descr_cost</td>
          <td align=left>Modello</td>
          <td align=left>$modello</td>
       </tr>
       <tr>
          <td align=left>Matricola</td>
          <td align=left>$matricola</td>
       </tr>
       <tr>
          <td align=left>Portata termica max nominale</td>
          <td align=left>$portata_term_max (kW)</td>
    <if $coimtgen(regione) ne \"MARCHE\">
          <td align=left>Portata termica min nominale</td>
          <td align=left>$portata_term_min (kW)</td>
    </if>
       </tr>
      </table>
     </td>
    </tr>
   </table><br><br>"

    set sw_recu_comp "t"
}


if {$sw_recu_comp eq "t"} {
   append libretto "</table>
    <table width=100%>
          <tr>
             <td colspan=2>&nbsp;</td>
          </tr>
          <tr>
             <td colspan=2><b>SOSTITUZIONI DEL COMPONENTE</b></td>
          </tr> 
          <tr>
             <td>&nbsp;</td>
          </tr>
    </table>"        

    db_foreach sel_recu_cond_sost_comp "" {#rom07 aggiunta foreach e contenuto
    regsub -all {<} $matricola_sost_comp {\&lt;} matricola_sost_comp
    regsub -all {>} $matricola_sost_comp {\&gt;} matricola_sost_comp
    append libretto "
     <table width=100% border=1>
       <tr>
          <td align=left width=20%>Recuperatore/condensatore<br>RC $num_rc_sost_comp</td>
          <td align=left width=100%>Sostituzione del componente</td>
       </tr>
    <tr>
    <td colspan=2>
    <table width=100%>
       <tr>
          <td align=left>Data Installazione</td>
          <td align=left>$data_installaz_sost_comp</td>
          <td align=left>Data Dismissione</td>
          <td align=left>$data_dismissione_sost_comp</td>
       </tr>
       <tr>
          <td align=left>Fabbricante</td>
          <td align=left>$descr_cost_sost_comp</td>
          <td align=left>Modello</td>
          <td align=left>$modello_sost_comp</td>
       </tr>
       <tr>
          <td align=left>Matricola</td>
          <td align=left>$matricola_sost_comp</td>
       </tr>
       <tr>
          <td align=left>Portata termica max nominale</td>
          <td align=left>$portata_term_max_sost_comp (kW)</td>
    <if $coimtgen(regione) ne \"MARCHE\">
          <td align=left>Portata termica min nominale</td>
          <td align=left>$portata_term_min_sost_comp (kW)</td>
    </if>
       </tr>
      </table>
     </td>
    </tr>
   </table><br><br>"
    };#rom07

    #rom07     <tr>
    #rom07        <td colspan=2>&nbsp;</td>
    #rom07     </tr>
    #rom07     <tr>
    #rom07        <td>Data di installazione _________________</td>
    #rom07        <td>Data di dismissione _________________</td>
    #rom07     </tr>
    #rom07     <tr> 
    #rom07        <td>Fabbricante _________________</td>
    #rom07        <td>Modello _________________</td>
    #rom07     </tr>
    #rom07     <tr>
    #rom07        <td colspan=2>Matricola _________________</td>
    #rom07     </tr>
    #rom07     <tr>
    #rom07        <td>Portata termica max nominale _________________</td>
    #rom07        <td>Portata termica min nominale _________________</td>
    #rom07    </tr>
    #rom07
    #rom07    <tr>
    #rom07       <td colspan=2>&nbsp;</td>
    #rom07    </tr>
    #rom07    <tr>
    #rom07       <td>Data di installazione _________________</td>
    #rom07       <td>Data di dismissione _________________</td>
    #rom07    </tr>
    #rom07    <tr>
    #rom07       <td>Fabbricante _________________</td>
    #rom07       <td>Modello _________________</td>
    #rom07    </tr>
    #rom07    <tr>
    #rom07       <td colspan=2>Matricola_________________</td>
    #rom07    </tr>
    #rom07    <tr>
    #rom07       <td>Portata termica max nominale _________________</td>
    #rom07       <td>Portata termica min nominale _________________</td>
    #rom07    </tr>
    #rom07
    #rom07    <tr>
    #rom07       <td colspan=2>&nbsp;</td>
    #rom07    </tr>
    #rom07    <tr>
    #rom07       <td>Data di installazione _________________</td>
    #rom07       <td>Data di dismissione _________________</td>
    #rom07    </tr>
    #rom07    <tr>
    #rom07       <td>Fabbricante _________________</td>
    #rom07       <td>Modello _________________</td>
    #rom07    </tr>
    #rom07    <tr>
    #rom07       <td colspan=2>Matricola _________________</td>
    #rom07    </tr>
    #rom07    <tr>
    #rom07       <td>Portata termica max nominale _________________</td>
    #rom07       <td>Portata termica min nominale _________________</td>
    #rom07    </tr>
    #rom07
    #rom07    <tr>
    #rom07       <td colspan=2>&nbsp;</td>
    #rom07    </tr>
    #rom07    <tr>
    #rom07       <td>Data di installazione _________________</td>
    #rom07       <td>Data di dismissione _________________</td>
    #rom07    </tr>
    #rom07    <tr>
    #rom07       <td>Fabbricante _________________</td>
    #rom07       <td>Modello _________________</td>
    #rom07    </tr>
    #rom07    <tr>
    #rom07       <td colspan=2>Matricola_________________</td>
    #rom07    </tr>
    #rom07    <tr>
    #rom07       <td>Portata termica max nominale _________________</td>
    #rom07       <td>Portata termica min nominale _________________</td>
    #rom07    </tr>
    #rom07  </table>

} else {
    append libretto "
    <tr>
       <td colspan=4>Non esiste alcun recuperatore/condensatore</td>
    </tr>
    </table>"
}

 

# Generatori freddo 

append libretto "
    <!-- PAGE BREAK -->
    $table_con_header_per_tutte_le_pagine
"


set gen_prog_est_fr ""
set matricola_fr ""
set costruttore_gend_fr ""
set modello_fr ""
set descr_comb_fr ""
set data_installaz_fr ""
set pot_focolare_lib_fr ""
set stato_gen_fr ""

append libretto "
    <table width=100% border=1>
          <tr>
             <td align=center bgcolor=\"E1E1E1\"><big><b>4. Generatori</b></big></td>
          </tr>
    </table>"

append libretto "
<table width=100% align=center>
          <tr>
             <td>&nbsp;</td>
          </tr>
       <tr>
          <td align=center colspan=4><b>4.4 Macchine frigorifere/ Pompe di calore</b></td>
       </tr>
       <tr>
          <td>&nbsp;</td>
        </tr>";#sim09


set num_gend_fr "0";#gab05
set where_gend_sost "and a.gen_prog_originario is null"
db_foreach sel_gend_fr "" {
    regsub -all {<} $matricola_fr {\&lt;} matricola_fr;#sim07
    regsub -all {>} $matricola_fr {\&gt;} matricola_fr;#sim07
    set tpco_ass_rec_cal $img_unchecked
    set tpco_ass_fiam_dir_comb $img_unchecked
    set tpco_comp_mot_el_end $img_unchecked
    if {$cod_tpco eq "1"} {
	set tpco_ass_fiam_dir_comb $img_checked
    } 
    if {$cod_tpco eq "2" || $cod_tpco eq "4"} {
	set tpco_comp_mot_el_end $img_checked
    }
    if {$cod_tpco eq "3"} {
	set tpco_ass_rec_cal $img_checked
    }
    set img_sor_lt_est_aria  $img_unchecked;#rom15
    set img_sor_lt_est_acqua $img_unchecked;#rom15
    if {$sorgente_lato_esterno eq "AR"} {#rom15
	set img_sor_lt_est_aria $img_checked
    }
    if {$sorgente_lato_esterno eq "AC"} {#rom15
	set img_sor_lt_est_acqua $img_checked
    }
    set img_fl_lt_ut_aria  $img_unchecked;#rom15
    set img_fl_lt_ut_acqua $img_unchecked;#rom15
    if {$fluido_lato_utenze eq "AR"} {#rom15
	set img_fl_lt_ut_aria $img_checked
    }
    if {$fluido_lato_utenze eq "AC"} {#rom15
	set img_fl_lt_ut_acqua $img_checked
    }

    
    append libretto "
  <table width=100% border=1>
   <tr>
    <td align=left width=30%>Gruppo Frigo/Pompa di calore<br>GF $gen_prog_est_fr</td>
    <td align=left width=70%>Situazione alla prima installazione o alla ristrutturazione dell'impianto termico $cod_impianto_est</td><!--gac11-->
  </tr>
   <tr>
    <td colspan=2>
     <table width=100% border=0>
       <tr>
          <td align=left>Data di installazione</td>
          <td align=left>$data_installaz_fr</td>
          <td align=left>Data di dismissione</td>
          <td align=left>$data_rottamaz_fr</td>
       </tr>
       <tr>
          <td align=left>Fabbbricante</td>
          <td align=left>$costruttore_gend_fr</td>
          <td align=left>Modello     </td>
          <td align=left>$modello_fr</td>
       </tr>
       <tr>
          <td align=left>Matricola   </td>
          <td align=left>$matricola_fr</td>
          <td align=left>Sorgente lato esterno:</td>
          <td align=left>$img_sor_lt_est_aria Aria  $img_sor_lt_est_acqua Acqua</td><!--rom15-->
       </tr>
       <tr>
          <td align=left>Fluido frigorigeno</td>
          <td align=left>$mod_funz</td>
          <td align=left> Fluido lato utenze:</td>
          <td align=left>$img_fl_lt_ut_aria Aria $img_fl_lt_ut_acqua Acqua</td><!--rom15-->

       </tr>
       <tr>
          <td align=left colspan=4>$tpco_ass_rec_cal Ad assorbimento per recupero di calore</td>
       </tr>
       <tr>          
          <td align=left colspan=4>$tpco_ass_fiam_dir_comb Ad assorbimento a fiamma diretta con combustibile $descr_comb_fr</td>
       </tr>
       <tr>
          <td align=left colspan=4>$tpco_comp_mot_el_end A ciclo di compressione con motore elettrico o endotermico</td>
       </tr>
       <tr>
          <td align=right colspan=2>circuiti n°</td>
          <td align=left colspan=2>$num_circuiti</td>
</tr>
       <tr>
<td colspan=4>
<table width=100% border=0>
<tr> 
          <td align=left nowrap>Raffrescamento EER(o GUE) $per_fr</td>
          <td align=left>Pot. Frig. Nom. $pot_foc_gend_fr (kW)</td>
          <td align=left>Potenza assorbita nominale $pot_utile_nom_fr (kW)</td>
       </tr>
       <tr>
          <td align=left nowrap>Riscaldamento COP (o &#951;) $cop_fr</td>
          <td align=left>Potenza termica nominale $pot_focolare_lib_fr (kW)</td>
          <td align=left>Potenza assorbita nominale $pot_utile_lib_fr (kW)</td>
</tr>
</table>        
</td>
</tr>
       </table>
      </td>
     </tr>
    </table><br><br>
";#sim09

    set num_gend_fr 1

}
    

if {$flag_gest_targa eq "T"} {#gab05: aggiunta if, else e loro contenuto
    set q_sel_gend_fr_padre "sel_gend_fr_padre_targa"
} else {
    set q_sel_gend_fr_padre "sel_gend_fr_padre"
}
set where_gend_sost "and a.gen_prog_originario is null"
db_foreach $q_sel_gend_fr_padre "" {#gab05
    regsub -all {<} $matricola_fr_padre {\&lt;} matricola_fr_padre;#sim07
    regsub -all {>} $matricola_fr_padre {\&gt;} matricola_fr_padre;#sim07

    set tpco_ass_rec_cal_padre $img_unchecked
    set tpco_ass_fiam_dir_comb_padre $img_unchecked
    set tpco_comp_mot_el_end_padre $img_unchecked
    if {$cod_tpco_padre eq "1"} {
	set tpco_ass_fiam_dir_comb_padre $img_checked
    } 
    if {$cod_tpco_padre eq "2" || $cod_tpco_padre eq "4"} {
	set tpco_comp_mot_el_end_padre $img_checked
    }
    if {$cod_tpco_padre eq "3"} {
	set tpco_ass_rec_cal_padre $img_checked
    }
    set img_sor_lt_est_aria_padre  $img_unchecked;#rom15
    set img_sor_lt_est_acqua_padre $img_unchecked;#rom15
    if {$sorgente_lato_esterno_padre eq "AR"} {#rom15
	set img_sor_lt_est_aria_padre $img_checked
    }
    if {$sorgente_lato_esterno_padre eq "AC"} {#rom15
	set img_sor_lt_est_acqua_padre $img_checked
    }
    set img_fl_lt_ut_aria_padre  $img_unchecked;#rom15
    set img_fl_lt_ut_acqua_padre $img_unchecked;#rom15
    if {$fluido_lato_utenze_padre eq "AR"} {#rom15
	set img_fl_lt_ut_aria_padre $img_checked
    }
    if {$fluido_lato_utenze_padre eq "AC"} {#rom15
	set img_fl_lt_ut_acqua_padre $img_checked
    }
    
    append libretto "
    <table width=100% border=1>
     <tr>
        <td align=left width=30%>Gruppo Frigo/Pompa di calore<br>GF $gen_prog_est_fr_padre</td>
        <td align=left width=70%>Situazione alla prima installazione o alla ristrutturazione dell'impianto termico $cod_impianto_est_padre</td><!--gac11-->
     </tr>
     <tr>
      <td colspan=2>
      <table width=100% border=0>
       <tr>
          <td align=left>Data di installazione</td>
          <td align=left>$data_installaz_fr_padre</td>
          <td align=left>Data di dismissione</td>
          <td align=left>$data_rottamaz_fr_padre</td>
       </tr>
       <tr>
          <td align=left>Fabbbricante</td>
          <td align=left>$costruttore_gend_fr_padre</td>
          <td align=left>Modello     </td>
          <td align=left>$modello_fr_padre</td>
       </tr>
       <tr>
          <td align=left>Matricola   </td>
          <td align=left>$matricola_fr_padre</td>
          <td align=left>Sorgente lato esterno:</td>
          <td align=left>$img_sor_lt_est_aria_padre Aria $img_sor_lt_est_acqua_padre Acqua</td>
       </tr>
       <tr>
          <td align=left>Fluido frigorigeno</td>
          <td align=left>$mod_funz_padre</td>
          <td align=left> Fluido lato utenze:</td>
          <td align=left>$img_fl_lt_ut_aria_padre Aria $img_fl_lt_ut_acqua_padre Acqua</td>
       </tr>
       <tr>
          <td align=left colspan=4>$tpco_ass_rec_cal_padre Ad assorbimento per recupero di calore</td>
       </tr>
       <tr>          
          <td align=left colspan=4>$tpco_ass_fiam_dir_comb_padre Ad assorbimento a fiamma diretta con combustibile $descr_comb_fr_padre</td>
       </tr>
       <tr>
          <td align=left colspan=4>$tpco_comp_mot_el_end_padre A ciclo di compressione con motore elettrico o endotermico</td>
       </tr>
       <tr>
          <td align=right colspan=2>circuiti n°</td>
          <td align=left colspan=2>$num_circuiti_fr_padre</td>
</tr>
<tr>
<td colspan=4>
<table border=0 width=100%>
       <tr>

          <td align=left nowrap >Raffrescamento EER(o GUE) $per_fr_padre</td>
          <td align=left>Pot. Frig. Nom. $pot_foc_gend_fr_padre (kW)</td>
          <td align=left>Potenza assorbita nominale $pot_utile_nom_fr_padre (kW)</td>
       </tr>
       <tr>
          <td align=left nowrap>Riscaldamento COP (o &#951;) $cop_fr_padre</td>
          <td align=left>Potenza termica nominale $pot_focolare_lib_fr_padre (kW)</td>
          <td align=left>Potenza assorbita nominale $pot_utile_lib_fr_padre (kW)</td>
</tr>
</table>
</td>

       </tr>
      </table>
     </td>
    </tr>
   </table><br><br>
        ";#sim09

    set num_gend_fr 1

}

if {$flag_tipo_impianto ne "F"} {#gab02: chiesto da Sandro - vanno esposti solo per il freddo
    set per ""
    set cop ""
}

if {$num_gend_fr eq 1} { #gab05 aggiunta if

	append libretto "
    <table width=100%>
          <tr>
             <td colspan=2>&nbsp;</td>
          </tr>
          <tr>
             <td colspan=2><b>SOSTITUZIONI DEL COMPONENTE</b></td>
          </tr>
          <tr>
             <td>&nbsp;</td>
          </tr>
    </table>"
	set where_gend_sost "and a.gen_prog_originario is not null"
    db_foreach sel_gend_fr_sost "" {
	regsub -all {<} $matricola_fr_sost {\&lt;} matricola_fr_sost
	regsub -all {>} $matricola_fr_sost {\&gt;} matricola_fr_sost
	set tpco_ass_rec_cal_sost $img_unchecked
	set tpco_ass_fiam_dir_comb_sost $img_unchecked
	set tpco_comp_mot_el_end_sost $img_unchecked
	if {$cod_tpco_sost eq "1"} {
	    set tpco_ass_fiam_dir_comb_sost $img_checked
	} 
	if {$cod_tpco_sost eq "2" || $cod_tpco_sost eq "4"} {
	    set tpco_comp_mot_el_end_sost $img_checked
	}
	if {$cod_tpco_sost eq "3"} {
	    set tpco_ass_rec_cal_sost $img_checked
	}
	set img_sor_lt_est_aria_sost  $img_unchecked;#rom15
	set img_sor_lt_est_acqua_sost $img_unchecked;#rom15
	if {$sorgente_lato_esterno_sost eq "AR"} {#rom15
	    set img_sor_lt_est_aria_sost $img_checked
	}
	if {$sorgente_lato_esterno_sost eq "AC"} {#rom15
	    set img_sor_lt_est_acqua_sost $img_checked
	}
	set img_fl_lt_ut_aria_sost  $img_unchecked;#rom15
	set img_fl_lt_ut_acqua_sost $img_unchecked;#rom15
	if {$fluido_lato_utenze_sost eq "AR"} {#rom15
	    set img_fl_lt_ut_aria_sost $img_checked
	}
	if {$fluido_lato_utenze_sost eq "AC"} {#rom15
	    set img_fl_lt_ut_acqua_sost $img_checked
	}
	
	
	
	append libretto "
  <table width=100% border=1>
   <tr>
    <td align=left width=30%>Gruppo Frigo/Pompa di calore<br>GF $gen_prog_est_fr_sost</td>
    <td align=left width=70%>Sostituzione del componente dell'impianto termico $cod_impianto_est</td>
  </tr>
   <tr>
    <td colspan=2>
     <table width=100%>
       <tr>
          <td align=left>Data di installazione</td>
          <td align=left>$data_installaz_fr_sost</td>
          <td align=left>Data di dismissione</td>
          <td align=left>$data_rottamaz_fr_sost</td>
       </tr>
       <tr>
          <td align=left>Fabbbricante</td>
          <td align=left>$costruttore_gend_fr_sost</td>
          <td align=left>Modello     </td>
          <td align=left>$modello_fr_sost</td>
       </tr>
       <tr>
          <td align=left>Matricola   </td>
          <td align=left>$matricola_fr_sost</td>
          <td align=left>Sorgente lato esterno:</td>
          <td align=left>$img_sor_lt_est_aria_sost Aria $img_sor_lt_est_acqua_sost Acqua</td>
       </tr>
       <tr>
          <td align=left>Fluido frigorigeno</td>
          <td align=left>$mod_funz_sost</td>
          <td align=left> Fluido lato utenze:</td>
          <td align=left>$img_fl_lt_ut_aria_sost Aria $img_fl_lt_ut_acqua_sost Acqua</td>
       </tr>
       <tr>
          <td align=left colspan=4>$tpco_ass_rec_cal_sost Ad assorbimento per recupero di calore</td>
       </tr>
       <tr>          
          <td align=left colspan=4>$tpco_ass_fiam_dir_comb_sost Ad assorbimento a fiamma diretta con combustibile $descr_comb_fr_sost</td>
       </tr>
       <tr>
          <td align=left colspan=4>$tpco_comp_mot_el_end_sost A ciclo di compressione con motore elettrico o endotermico</td>
       </tr>
       <tr>
          <td align=right colspan=2>circuiti n°</td>
          <td align=left colspan=2>$num_circuiti_sost</td>
</tr>
       <tr>
<td colspan=4>
<table width=100% border=0>
       <tr>
          <td align=left nowrap>Raffrescamento EER(o GUE) $per_fr_sost</td>
          <td align=left>Pot. Frig. Nom. $pot_foc_gend_fr_sost (kW)</td>
          <td align=left>Potenza assorbita nominale $pot_utile_nom_fr_sost (kW)</td>
       </tr>
       <tr>
          <td align=left nowrap>Riscaldamento COP (o &#951;) $cop_fr_sost</td>
          <td align=left>Potenza termica nominale $pot_focolare_lib_fr_sost (kW)</td>
          <td align=left>Potenza assorbita nominale $pot_utile_lib_fr_sost (kW)</td>
</tr>
</table>
</td>
        </tr>
       </table>
      </td>
     </tr>
    </table><br>
"
	}
	
	
	if {$flag_gest_targa eq "T"} {
	    set q_sel_gend_fr_padre_sost "sel_gend_fr_padre_targa_sost"
	} else {
	    set q_sel_gend_fr_padre_sost "sel_gend_fr_padre_sost"
	}
	set where_gend_sost "and a.gen_prog_originario is not null"
    db_foreach $q_sel_gend_fr_padre_sost "" {
	    regsub -all {<} $matricola_fr_padre_sost {\&lt;} matricola_fr_padre_sost
	    regsub -all {>} $matricola_fr_padre_sost {\&gt;} matricola_fr_padre_sost
	    
	    set tpco_ass_rec_cal_padre_sost $img_unchecked
	    set tpco_ass_fiam_dir_comb_padre_sost $img_unchecked
	    set tpco_comp_mot_el_end_padre_sost $img_unchecked
	    if {$cod_tpco_padre_sost eq "1"} {
		set tpco_ass_fiam_dir_comb_padre_sost $img_checked
	    } 
	    if {$cod_tpco_padre_sost eq "2" || $cod_tpco_padre_sost eq "4"} {
		set tpco_comp_mot_el_end_padre_sost $img_checked
	    }
	    if {$cod_tpco_padre_sost eq "3"} {
		set tpco_ass_rec_cal_padre_sost $img_checked
	    }
	    set img_sor_lt_est_aria_padre_sost  $img_unchecked;#rom15
	    set img_sor_lt_est_acqua_padre_sost $img_unchecked;#rom15
	    if {$sorgente_lato_esterno_padre_sost eq "AR"} {#rom15
		set img_sor_lt_est_aria_padre_sost $img_checked
	    }
	    if {$sorgente_lato_esterno_padre_sost eq "AC"} {#rom15
		set img_sor_lt_est_acqua_padre_sost $img_checked
	    }
	    set img_fl_lt_ut_aria_padre_sost  $img_unchecked;#rom15
	    set img_fl_lt_ut_acqua_padre_sost $img_unchecked;#rom15
	    if {$fluido_lato_utenze_padre_sost eq "AR"} {#rom15
		set img_fl_lt_ut_aria_padre_sost $img_checked
	    }
	    if {$fluido_lato_utenze_padre_sost eq "AC"} {#rom15
		set img_fl_lt_ut_acqua_padre_sost $img_checked
	    }
	    append libretto "
    <table width=100% border=1>
     <tr>
        <td align=left width=30%>Gruppo Frigo/Pompa di calore<br>GF $gen_prog_est_fr_padre_sost</td>
        <td align=left width=70%>Sostituzione del componente dell'impianto termico $cod_impianto_fr_est_padre_sost</td>
     </tr>
     <tr>
      <td colspan=2>
      <table width=100% border=0>
       <tr>
          <td align=left>Data di installazione</td>
          <td align=left>$data_installaz_fr_padre_sost</td>
          <td align=left>Data di dismissione</td>
          <td align=left>$data_rottamaz_fr_padre_sost</td>
       </tr>
       <tr>
          <td align=left>Fabbbricante</td>
          <td align=left>$costruttore_gend_fr_padre_sost</td>
          <td align=left>Modello     </td>
          <td align=left>$modello_fr_padre_sost</td>
       </tr>
       <tr>
          <td align=left>Matricola   </td>
          <td align=left>$matricola_fr_padre_sost</td>
          <td align=left>Sorgente lato esterno:</td>
          <td align=left>$img_sor_lt_est_aria_padre_sost Aria $img_sor_lt_est_acqua_padre_sost Acqua</td>
       </tr>
       <tr>
          <td align=left>Fluido frigorigeno</td>
          <td align=left>$mod_funz_padre_sost</td>
          <td align=left> Fluido lato utenze:</td>
          <td align=left>$img_fl_lt_ut_aria_padre_sost Aria $img_fl_lt_ut_acqua_padre_sost Acqua</td>
       </tr>
       <tr>
          <td align=left colspan=4>$tpco_ass_rec_cal_padre_sost Ad assorbimento per recupero di calore</td>
       </tr>
       <tr>          
          <td align=left colspan=4>$tpco_ass_fiam_dir_comb_padre_sost Ad assorbimento a fiamma diretta con combustibile $descr_comb_fr_padre_sost</td>
       </tr>
       <tr>
          <td align=left colspan=4>$tpco_comp_mot_el_end_padre_sost A ciclo di compressione con motore elettrico o endotermico</td>
       </tr>
       <tr>
          <td align=right colspan=2>circuiti n°</td>
          <td align=left colspan=2>$num_circuiti_fr_padre_sost</td>
</tr>
       <tr>
<td colspan=4>
<table width=100% border=0>
       <tr>
          <td align=left nowrap>Raffrescamento EER(o GUE) $per_fr_padre_sost</td>
          <td align=left>Pot. Frig. Nom. $pot_foc_gend_fr_padre_sost (kW)</td>
          <td align=left>Potenza assorbita nominale $pot_utile_nom_fr_padre_sost (kW)</td>
       </tr>
       <tr>
          <td align=left nowrap>Riscaldamento COP (o &#951;) $cop_fr_padre_sost</td>
          <td align=left>Potenza termica nominale $pot_focolare_lib_fr_padre_sost (kW)</td>
          <td align=left>Potenza assorbita nominale $pot_utile_lib_fr_padre_sost (kW)</td>
       </tr>
</table>
</td>
</tr>
      </table>
     </td>
    </tr>
   </table><br>"
	}

} else {
	append libretto "
    <table>
    <tr>
       <td>Non esiste alcun generatore</td>
    </tr>
    </table>"


}


#rom17 Aggiunta Scheda 4.4bis
if {$coimtgen(regione) eq "MARCHE"} {#rom17 Aggiunta if e suo contenuto
    if {[db_0or1row sel_aimp ""] == 0} {
	iter_return_complaint "Impianto non trovato"
    }
    append libretto "
    <!-- PAGE BREAK -->
    $table_con_header_per_tutte_le_pagine"
    
    # Generatori
    set locale                       ""                 
    set dpr_660_96                   ""
    set flag_caldaia_comb_liquid     ""
    set tipo_foco                    ""
    set funzione_grup_ter            ""
    set funzione_grup_ter_note_altro ""
    set tiraggio                     ""
    set cod_emissione                ""
    set data_installaz               ""
    
    append libretto "
    <table width=100% border=1>
          <tr>
             <td align=center bgcolor=\"E1E1E1\"><big><b>4. Generatori</b></big></td>
          </tr>
    </table>"

    append libretto "
       <table width=100% align=center>
          <tr>
             <td>&nbsp;</td>
          </tr>
       <tr>
          <td align=center><b>4.4bis Dati Specifici Gruppo Frigo/Pompa di calore.</td>
       </tr>
       <tr>
         <td>&nbsp;</td>
       </tr>
       </table>"
    set num_gend_fr_4_4bis "0"
    set where_gend_sost "and a.gen_prog_originario is null"
    db_foreach sel_gend_fr_4_4bis "" {
	set img_prod_acqua_fr_4_4bis $img_unchecked
	set pot_utile_prod_acqua_fr_4_4bis ""
	set img_cli_inv_fr_4_4bis $img_unchecked 
	set pot_utile_cli_inv_fr_4_4bis ""
	set img_cli_est_fr_4_4bis $img_unchecked
	set pot_utile_cli_est_fr_4_4bis ""
	
	if {$flag_prod_acqua_calda_fr_4_4bis eq "S"} {
	    set img_prod_acqua_fr_4_4bis $img_checked
	    set pot_utile_prod_acqua_fr_4_4bis "- <b>Potenza Utile: $pot_term_nominale_fr_4_4bis</b>"
	}
	if {$flag_clima_invernale_fr_4_4bis eq "S"} {
	    set img_cli_inv_fr_4_4bis $img_checked
	    if {$potenza_maggiore_fr_4_4bis eq "1"} {#la potenza frigorifera nominale e' maggiore di quella termica nominale
		set pot_utile_cli_inv_fr_4_4bis "- <b>Potenza Utile: $pot_frig_nominale_fr_4_4bis</b>"
	    } elseif {$potenza_maggiore_fr_4_4bis eq "2"} {#la potenza termica nominale e' maggiore di quella frigorifera nominale
		set pot_utile_cli_inv_fr_4_4bis "- <b>Potenza Utile: $pot_term_nominale_fr_4_4bis</b>"
	    } else {#le 2 potenze sono uguali e non conta quale mostro
		set pot_utile_cli_inv_fr_4_4bis "- <b>Potenza Utile: $pot_term_nominale_fr_4_4bis</b>"
	    }
	}
	if {$flag_clim_est_fr_4_4bis eq "S"} {
	    set img_cli_est_fr_4_4bis $img_checked
	    if {$potenza_maggiore_fr_4_4bis eq "1"} {#la potenza frigorifera nominale e' maggiore di quella termica nominale
		set pot_utile_cli_est_fr_4_4bis "- <b>Potenza Utile: $pot_frig_nominale_fr_4_4bis</b>"
	    } elseif {$potenza_maggiore_fr_4_4bis eq "2"} {#la potenza termica nominale e' maggiore di quella frigorifera nominale
		set pot_utile_cli_est_fr_4_4bis "- <b>Potenza Utile: $pot_term_nominale_fr_4_4bis</b>"
	    } else {#le 2 potenze sono uguali e non conta quale mostro
		set pot_utile_cli_inv_fr_4_4bis "- <b>Potenza Utile: $pot_term_nominale_fr_4_4bis</b>"
	    }
	}

	set  pot_utile_cli_est_fr_4_4bis "- <b>Potenza Utile: $pot_frig_nominale_fr_4_4bis</b>"
	set pot_utile_cli_inv_fr_4_4bis  "- <b>Potenza Utile: $pot_term_nominale_fr_4_4bis</b>"

	append libretto "
<table width=100% border=1>
    <tr>
       <td align=left width=20%>Gruppo Frigo/Pompa di calore<br>GF $gen_prog_est_fr_4_4bis</td>
       <td align=left width=80%>Situazione alla prima installazione o alla ristrutturazione dell'impianto termico $cod_impianto_est_4_4bis</td>
    </tr>
    <tr>
       <td colspan=2>
  <table  border=0>
       <tr>  
         <td align=left>Data costruzione</td>
         <td align=left>$data_costruz_gen_fr_4_4bis</td>
       </tr>
       <tr>
         <td align=left>Tipologia generatore</td>
         <td align=left></td>
       </tr>
       <tr>
         <td align=left>Attivo</td>
         <td align=left>$stato_gen_fr_4_4bis</td>
         <td align=left>Motivazione GF inattivo</td>
         <td align=left>$motivazione_disattivo_fr_4_4bis</td>
       </tr>
       <tr>
         <td align=left>Tipo locale</td>
         <td align=left>$locale_fr_4_4bis</td>
       </tr>
       <tr>
         <td align=left>Carica refrigerante</td>
         <td align=left>$carica_refrigerante_fr_4_4bis</td>
         <td align=left>Carica ermeticamente sigillata</td>
         <td align=left>$sigillatura_carica_fr_4_4bis</td>
       </tr>
       <tr>
         <td align=left>Riferimento</td>
         <td align=left>$rif_uni_10389_fr_4_4bis</td>
         <td align=left>Altro</td>
         <td align=left>$altro_rif_fr_4_4bis</td>
       <tr>  
         <td align=left colspan=2 width=50%>$img_prod_acqua_fr_4_4bis Prod. Acq. calda sanitaria $pot_utile_prod_acqua_fr_4_4bis</td>
       </tr>
       <tr>
         <td align=left colspan=2 width=50%>$img_cli_inv_fr_4_4bis Climatizzazione inv. $pot_utile_cli_inv_fr_4_4bis</td>
       </tr>
       <tr>
         <td align=left colspan=2 width=50%>$img_cli_est_fr_4_4bis Climatizzazione est. $pot_utile_cli_est_fr_4_4bis</td>
       </tr>
       <tr>
       </tr>
    </table>
</td>
</tr>
</table>
<br>"
	set num_gend_fr_4_4bis "1"

    }
    
    if {$num_gend_fr_4_4bis eq "1"} {
	
	append libretto "<table width=100%>
          <tr>
             <td>&nbsp;</td>
          </tr>
          <tr>
             <td align=left><b>SOSTITUZIONI DEL COMPONENTE</b></td>
          </tr>
     </table><br>"
	set where_gend_sost "and a.gen_prog_originario is not null"
    db_foreach sel_gend_fr_4_4bis_sost "" {
	set img_prod_acqua_fr_4_4bis_sost $img_unchecked
	set pot_utile_prod_acqua_fr_4_4bis_sost ""
	set img_cli_inv_fr_4_4bis_sost $img_unchecked 
	set pot_utile_cli_inv_fr_4_4bis_sost ""
	set img_cli_est_fr_4_4bis_sost $img_unchecked
	set pot_utile_cli_est_fr_4_4bis_sost ""
	
	if {$flag_prod_acqua_calda_fr_4_4bis_sost eq "S"} {
	    set img_prod_acqua_fr_4_4bis_sost $img_checked
	    set pot_utile_prod_acqua_fr_4_4bis_sost "- <b>Potenza Utile: $pot_term_nominale_fr_4_4bis_sost</b>"
	}
	if {$flag_clima_invernale_fr_4_4bis_sost eq "S"} {
	    set img_cli_inv_fr_4_4bis_sost $img_checked
	    if {$potenza_maggiore_fr_4_4bis_sost eq "1"} {#la potenza frigorifera nominale e' maggiore di quella termica nominale
		set pot_utile_cli_inv_fr_4_4bis_sost "- <b>Potenza Utile: $pot_frig_nominale_fr_4_4bis_sost</b>"
	    } elseif {$potenza_maggiore_fr_4_4bis_sost eq "2"} {#la potenza termica nominale e' maggiore di quella frigorifera nominale
		set pot_utile_cli_inv_fr_4_4bis_sost "- <b>Potenza Utile: $pot_term_nominale_fr_4_4bis_sost</b>"
	    } else {#le 2 potenze sono uguali e non conta quale mostro
		set pot_utile_cli_inv_fr_4_4bis_sost "- <b>Potenza Utile: $pot_term_nominale_fr_4_4bis_sost</b>"
	    }
	}
	if {$flag_clim_est_fr_4_4bis_sost eq "S"} {
	    set img_cli_est_fr_4_4bis_sost $img_checked
	    if {$potenza_maggiore_fr_4_4bis_sost eq "1"} {#la potenza frigorifera nominale e' maggiore di quella termica nominale
		set pot_utile_cli_est_fr_4_4bis_sost "- <b>Potenza Utile: $pot_frig_nominale_fr_4_4bis_sost</b>"
	    } elseif {$potenza_maggiore_fr_4_4bis_sost eq "2"} {#la potenza termica nominale e' maggiore di quella frigorifera nominale
		set pot_utile_cli_est_fr_4_4bis_sost "- <b>Potenza Utile: $pot_term_nominale_fr_4_4bis_sost</b>"
	    } else {#le 2 potenze sono uguali e non conta quale mostro
		set pot_utile_cli_inv_fr_4_4bis_sost "- <b>Potenza Utile: $pot_term_nominale_fr_4_4bis_sost</b>"
	    }
	}

	set pot_utile_cli_est_fr_4_4bis_sost "- <b>Potenza Utile: $pot_frig_nominale_fr_4_4bis_sost</b>"
	set pot_utile_cli_inv_fr_4_4bis_sost  "- <b>Potenza Utile: $pot_term_nominale_fr_4_4bis_sost</b>"
	    
	append libretto "
<table width=100% border=1>
    <tr>
       <td align=left width=20%>Gruppo Frigo/Pompa di calore<br>GF $gen_prog_est_fr_4_4bis_sost</td>
       <td align=left width=80%>Sostituzione del componente dell'impianto termico $cod_impianto_est_4_4bis_sost</td>
    </tr>
    <tr>
       <td colspan=2>
  <table  border=0>
       <tr>  
         <td align=left>Data costruzione</td>
         <td align=left>$data_costruz_gen_fr_4_4bis_sost</td>
       </tr>
       <tr>
         <td align=left>Tipologia generatore</td>
         <td align=left></td>
       </tr>
       <tr>
         <td align=left>Attivo</td>
         <td align=left>$stato_gen_fr_4_4bis_sost</td>
         <td align=left>Motivazione GF inattivo</td>
         <td align=left>$motivazione_disattivo_fr_4_4bis_sost</td>
       </tr>
       <tr>
         <td align=left>Tipo locale</td>
         <td align=left>$locale_fr_4_4bis_sost</td>
       </tr>
       <tr>
         <td align=left>Carica refrigerante</td>
         <td align=left>$carica_refrigerante_fr_4_4bis_sost</td>
         <td align=left>Carica ermeticamente sigillata</td>
         <td align=left>$sigillatura_carica_fr_4_4bis_sost</td>
       </tr>
       <tr>
         <td align=left>Riferimento</td>
         <td align=left>$rif_uni_10389_fr_4_4bis_sost</td>
         <td align=left>Altro</td>
         <td align=left>$altro_rif_fr_4_4bis_sost</td>
       <tr>  
         <td align=left colspan=2 width=50%>$img_prod_acqua_fr_4_4bis_sost Prod. Acq. calda sanitaria $pot_utile_prod_acqua_fr_4_4bis_sost</td>
       </tr>
       <tr>
         <td align=left colspan=2 width=50%>$img_cli_inv_fr_4_4bis_sost Climatizzazione inv. $pot_utile_cli_inv_fr_4_4bis_sost</td>
       </tr>
       <tr>
         <td align=left colspan=2 width=50%>$img_cli_est_fr_4_4bis_sost Climatizzazione est. $pot_utile_cli_est_fr_4_4bis_sost</td>
       </tr>
       <tr>
       </tr>
    </table>
</td>
</tr>
</table><br>"
    }

    } else {
	append libretto "
    <table>
    <tr>
       <td>Non esiste alcun generatore</td>
    </tr>
    </table>"
    }
};#rom17 fine sezione 4.4bis

append libretto "</table>
    <table width=100%>
          <tr>
             <td>&nbsp;</td>
          <tr>
    </table>"

#rom02 Aggiunta sezione 4.5 Teleriscaldamento
append libretto "
    <!-- PAGE BREAK -->
    $table_con_header_per_tutte_le_pagine
"
set gen_prog_est_tel ""
set matricola_tel ""
set costruttore_gend_tel ""
set modello_tel ""
set matricola_tel ""
set data_installaz_tel ""
set pot_foc_nom_tel ""

append libretto "
    <table width=100% border=1>
          <tr>
             <td align=center bgcolor=\"E1E1E1\"><big><b>4. Generatori</b></big></td>
          </tr>
    </table>"

append libretto "
<table width=100% align=center>
          <tr>
             <td>&nbsp;</td>
          </tr>
       <tr>
          <td align=center colspan=4><b>4.5 Scambiatori di Calore della Sottostazione di Teleriscaldamento / Teleraffrescamento</b></td>
       </tr>
       <tr>
          <td colspan=4>&nbsp;</tr>
       </tr>"

set num_gend_tel "0"
set where_gend_sost "and a.gen_prog_originario is null"
db_foreach sel_gend_tel "" {
    regsub -all {<} $matricola_tel {\&lt;} matricola_tel
    regsub -all {>} $matricola_tel {\&gt;} matricola_tel

    append libretto "
 <table width=100% border=1>
   <tr>
      <td align=left width=20%>Scambiatore<br>SC $gen_prog_est_tel</td>
      <td align=left width=80%>Situazione alla prima installazione o alla ricostruzione dell'impianto termico $cod_impianto_est</td>
 </tr>
  <tr>
    <td colspan=2>
     <table width=100%>
       <tr>
         <td align=left>Data di installazione      </td>
         <td align=left>$data_installaz_tel</td>
         <td align=left>Data di dismissione    </td>
         <td align=left>$data_rottamaz_tel</td>
      </tr>
      <tr>
         <td align=left>Fabbricante     </td>
         <td align=left>$costruttore_gend_tel</td>
         <td align=left>Modello         </td>
         <td align=left>$modello_tel</td>
      </tr>
       <tr>
         <td align=left>Matricola       </td>
         <td align=left>$matricola_tel</td>
         <td align=left>Potenza termica nominale totale</td>
         <td align=left>$pot_foc_nom_tel (kW)</td>
      </tr>
    </table>
  </tr>
 </table><br><br>"
    set num_gend_tel "1"
}

if {$flag_gest_targa eq "T"} {#rom02: aggiunta if, else e loro contenuto
    set q_sel_gend_tel_padre "sel_gend_tel_padre_targa"
} else {
    set q_sel_gend_tel_padre "sel_gend_tel_padre"
}
set where_gend_sost "and a.gen_prog_originario is null"
db_foreach $q_sel_gend_tel_padre "" {
    regsub -all {<} $matricola_tel_padre {\&lt;} matricola_tel_padre
    regsub -all {>} $matricola_tel_padre {\&gt;} matricola_tel_padre
    append libretto "
 <table width=100% border=1>
   <tr>
      <td align=left width=20%>Scambiatore<br>SC $gen_prog_est_tel_padre</td>
      <td align=left width=80%>Situazione alla prima installazione o alla ricostruzione dell'impianto termico $cod_impianto_est_tel_padre</td>
 </tr>
  <tr>
    <td colspan=2>
     <table width=100%>
       <tr>
         <td align=left>Data di installazione      </td>
         <td align=left>$data_installaz_tel_padre</td>
         <td align=left>Data di dismissione    </td>
         <td align=left>$data_rottamaz_tel_padre</td>
      </tr>
      <tr>
         <td align=left>Fabbricante     </td>
         <td align=left>$costruttore_gend_tel_padre</td>
         <td align=left>Modello         </td>
         <td align=left>$modello_tel_padre</td>
      </tr>
       <tr>
         <td align=left>Matricola       </td>
         <td align=left>$matricola_tel_padre</td>
         <td align=left>Potenza termica nominale totale</td>
         <td align=left>$pot_foc_nom_tel_padre (kW)</td>
      </tr>
    </table>
  </tr>
 </table><br><br>"

    set num_gend_tel "1"

} 
if {$num_gend_tel eq "1"} {#rom02: aggiunta if e suo contenuto
	append libretto "</table>
    <table width=100% border=0>
          <tr>
             <td>&nbsp;</td>
          </tr>
          <tr>
             <td><b>SOSTITUZIONI DEL COMPONENTE</b></td>
          </tr>
    </table>"
	set where_gend_sost "and a.gen_prog_originario is not null"
    db_foreach sel_gend_tel_sost "" {
	regsub -all {<} $matricola_tel_sost {\&lt;} matricola_tel_sost
	regsub -all {>} $matricola_tel_sost {\&gt;} matricola_tel_sost
	
	append libretto "
 <table width=100% border=1 align=center>
   <tr>
      <td align=left width=20%>Scambiatore<br>SC $gen_prog_est_tel_sost</td>
      <td align=left width=80%>Sostituzione del componente dell'impianto terrmico $cod_impianto_est_tel_sost</td>
 </tr>
  <tr>
    <td colspan=2>
     <table width=100%>
       <tr>
         <td align=left>Data di installazione      </td>
         <td align=left>$data_installaz_tel_sost</td>
         <td align=left>Data di dismissione    </td>
         <td align=left>$data_rottamaz_tel_sost</td>
      </tr>
      <tr>
         <td align=left>Fabbricante     </td>
         <td align=left>$costruttore_gend_tel_sost</td>
         <td align=left>Modello         </td>
         <td align=left>$modello_tel_sost</td>
      </tr>
       <tr>
         <td align=left>Matricola       </td>
         <td align=left>$matricola_tel_sost</td>
         <td align=left>Potenza termica nominale totale</td>
         <td align=left>$pot_foc_nom_tel_sost (kW)</td>
      </tr>
    </table>
  </tr>
 </table><br>"
	}
	
	if {$flag_gest_targa eq "T"} {
	    set q_sel_gend_tel_padre_sost "sel_gend_tel_padre_targa_sost"
	} else {
	    set q_sel_gend_tel_padre_sost "sel_gend_tel_padre_sost"
	}
	set where_gend_sost "and a.gen_prog_originario is not null"
	db_foreach $q_sel_gend_tel_padre_sost "" {
	    regsub -all {<} $matricola_tel_padre_sost {\&lt;} matricola_tel_padre_sost
	    regsub -all {>} $matricola_tel_padre_sost {\&gt;} matricola_tel_padre_sost
	    append libretto "
 <table width=100% border=1>
   <tr>
      <td align=left width=20%>Scambiatore<br>SC $gen_prog_est_tel_padre_sost</td>
      <td align=left width=80%>Sostituzione del componente dell'impianto terrmico $cod_impianto_est_tel_padre_sost</td>
 </tr>
  <tr>
    <td colspan=2>
     <table width=100%>
       <tr>
         <td align=left>Data di installazione</td>
         <td align=left>$data_installaz_tel_padre_sost</td>
         <td align=left>Data di dismissione</td>
         <td align=left>$data_rottamaz_tel_padre_sost</td>
      </tr>
      <tr>
         <td align=left>Fabbricante</td>
         <td align=left>$costruttore_gend_tel_padre_sost</td>
         <td align=left>Modello</td>
         <td align=left>$modello_tel_padre_sost</td>
      </tr>
       <tr>
         <td align=left>Matricola</td>
         <td align=left>$matricola_tel_padre_sost</td>
         <td align=left>Potenza termica nominale totale</td>
         <td align=left>$pot_foc_nom_tel_padre_sost (kW)</td>
      </tr>
    </table>
  </tr>
 </table><br>"
	} 

} else {
    append libretto "
    <tr>
       <td colspan=4>Non esiste alcun scambiatore di calore</td>
    </tr>
    </table>"
};#rom02

append libretto "</table>
    <table width=100%>
          <tr>
             <td>&nbsp;</td>
          <tr>
    </table>"

if {$coimtgen(regione) eq "MARCHE"} {#rom17 aggiunta if e suop contenuto
        if {[db_0or1row sel_aimp ""] == 0} {
	iter_return_complaint "Impianto non trovato"
    }
    append libretto "
    <!-- PAGE BREAK -->
    $table_con_header_per_tutte_le_pagine"
    
    append libretto "
    <table width=100% border=1>
          <tr>
             <td align=center bgcolor=\"E1E1E1\"><big><b>4. Generatori</b></big></td>
          </tr>
    </table>"

    append libretto "
       <table width=100% align=center>
          <tr>
             <td>&nbsp;</td>
          </tr>
       <tr>
          <td align=center><b>4.5bis Dati Specifici  Scambiatori di calore.</td>
       </tr>
       <tr>
         <td>&nbsp;</td>
       </tr>
       </table>"
    set num_gend_te "0"
    set where_gend_sost "and a.gen_prog_originario is null"
    db_foreach sel_gend_te_4_5bis "" {
	set img_prod_acqua_te_4_5bis $img_unchecked
	set pot_utile_prod_acqua_te_4_5bis ""
	set img_cli_inv_te_4_5bis $img_unchecked 
	set pot_utile_cli_inv_te_4_5bis ""
	set img_cli_est_te_4_5bis $img_unchecked
	set pot_utile_cli_est_te_4_5bis ""
	
	if {$flag_prod_acqua_calda_te_4_5bis eq "S"} {
	    set img_prod_acqua_te_4_5bis $img_checked
	    set pot_utile_prod_acqua_te_4_5bis "- <b>Potenza Utile: $pot_term_nominale_te_4_5bis</b>"
	}
	if {$flag_clima_invernale_te_4_5bis eq "S"} {
	    set img_cli_inv_te_4_5bis $img_checked
	    set pot_utile_cli_inv_te_4_5bis "- <b>Potenza Utile: $pot_term_nominale_te_4_5bis</b>"
	}
	if {$flag_clim_est_te_4_5bis eq "S"} {
	    set pot_utile_cli_inv_te_4_5bis "- <b>Potenza Utile: $pot_term_nominale_te_4_5bis</b>"
	}

	append libretto "
<table width=100% border=1>
    <tr>
       <td align=left width=20%>Scambiatore SC $gen_prog_est_te_4_5bis</td>
       <td align=left width=80%>Situazione alla prima installazione o alla ristrutturazione dell'impianto termico $cod_impianto_est_4_5bis</td>
    </tr>
    <tr>
       <td colspan=2>
  <table  border=0>
       <tr>  
         <td align=left>Data costruzione</td>
         <td align=left>$data_costruz_gen_te_4_5bis</td>
       </tr>
       <tr>
         <td align=left>Attivo</td>
         <td align=left>$stato_gen_te_4_5bis</td>
         <td align=left>Motivazione GT inattivo</td>
         <td align=left>$motivazione_disattivo_te_4_5bis</td>
       </tr>
       <tr>
         <td align=left>Riferimento</td>
         <td align=left>$rif_uni_10389_te_4_5bis</td>
         <td align=left>Altro</td>
         <td align=left>$altro_rif_te_4_5bis</td>
       <tr>  
         <td align=left colspan=2 width=50%>$img_prod_acqua_te_4_5bis Prod. Acq. calda sanitaria $pot_utile_prod_acqua_te_4_5bis</td>
       </tr>
       <tr>
         <td align=left colspan=2 width=50%>$img_cli_inv_te_4_5bis Climatizzazione inv. $pot_utile_cli_inv_te_4_5bis</td>
       </tr>
       <tr>
         <td align=left colspan=2 width=50%>$img_cli_est_te_4_5bis Climatizzazione est. $pot_utile_cli_est_te_4_5bis</td>
       </tr>
       <tr>
       </tr>
    </table>
</td>
</tr>
</table>
<br>"
	set num_gend_te "1"
    }
    
    if {$num_gend_te eq "1"} {

	append libretto "<table width=100%>
          <tr>
             <td>&nbsp;</td>
          </tr>
          <tr>
             <td align=left><b>SOSTITUZIONI DEL COMPONENTE</b></td>
          </tr>
     </table><br>"
	set where_gend_sost "and a.gen_prog_originario is not null"
    db_foreach sel_gend_te_4_5bis_sost "" {
	set img_prod_acqua_te_4_5bis_sost $img_unchecked
	set pot_utile_prod_acqua_te_4_5bis_sost ""
	set img_cli_inv_te_4_5bis_sost $img_unchecked 
	set pot_utile_cli_inv_te_4_5bis_sost ""
	set img_cli_est_te_4_5bis_sost $img_unchecked
	set pot_utile_cli_est_te_4_5bis_sost ""

	if {$flag_prod_acqua_calda_te_4_5bis_sost eq "S"} {
	    set img_prod_acqua_te_4_5bis_sost $img_checked
	    set pot_utile_prod_acqua_te_4_5bis_sost "- <b>Potenza Utile: $pot_term_nominale_te_4_5bis_sost</b>"
	}
	if {$flag_clima_invernale_te_4_5bis_sost eq "S"} {
	    set img_cli_inv_te_4_5bis_sost $img_checked
	    set pot_utile_cli_inv_te_4_5bis_sost "- <b>Potenza Utile: $pot_term_nominale_te_4_5bis_sost</b>"
	}
	if {$flag_clim_est_te_4_5bis_sost eq "S"} {
	    set pot_utile_cli_inv_te_4_5bis_sost "- <b>Potenza Utile: $pot_term_nominale_te_4_5bis_sost</b>"
	}
	
	    
	append libretto "
<table width=100% border=1>
    <tr>
       <td align=left width=20%>Scambiatore SC $gen_prog_est_te_4_5bis_sost</td>
       <td align=left width=80%>Sostituzione del componente dell'impianto termico $cod_impianto_est_4_5bis_sost</td>
    </tr>
    <tr>
       <td colspan=2>
  <table  border=0>
       <tr>
         <td align=left>Data costruzione</td>
         <td align=left>$data_costruz_gen_te_4_5bis_sost</td>
       </tr>
       <tr>
         <td align=left>Attivo</td>
         <td align=left>$stato_gen_te_4_5bis_sost</td>
         <td align=left>Motivazione GT inattivo</td>
         <td align=left>$motivazione_disattivo_te_4_5bis_sost</td>
       </tr>
       <tr>
         <td align=left>Riferimento</td>
         <td align=left>$rif_uni_10389_te_4_5bis_sost</td>
         <td align=left>Altro</td>
         <td align=left>$altro_rif_te_4_5bis_sost</td>
       <tr>
         <td align=left colspan=2 width=50%>$img_prod_acqua_te_4_5bis_sost Prod. Acq. calda sanitaria $pot_utile_prod_acqua_te_4_5bis_sost</td>
       </tr>
       <tr>
         <td align=left colspan=2 width=50%>$img_cli_inv_te_4_5bis_sost Climatizzazione inv. $pot_utile_cli_inv_te_4_5bis_sost</td>
       </tr>
       <tr>
         <td align=left colspan=2 width=50%>$img_cli_est_te_4_5bis_sost Climatizzazione est. $pot_utile_cli_est_te_4_5bis_sost</td>
       </tr>
       <tr>
       </tr>
    </table>
</td>
</tr>
</table>
<br>"
    }

    } else {
	append libretto "
    <table>
    <tr>
       <td>Non esiste alcun generatore</td>
    </tr>
    </table>"
    }
};#rom17 fine aggiunta sezione 4.5bis per regione marche

#sim inizio 4.6 cogenerazione 

append libretto "
    <!-- PAGE BREAK -->
    $table_con_header_per_tutte_le_pagine
"
append libretto "
    <table width=100% border=1>
          <tr>
             <td align=center bgcolor=\"E1E1E1\"><big><b>4. Generatori</b></big></td>
          </tr>
    </table>"

append libretto "
    <table width=100% align=center>
          <tr>
             <td>&nbsp;</td>
          </tr>
       <tr>
          <td align=center colspan=4><b>4.6 Cogeneratori/Trigeneratori</b>
       </tr>
       <tr>
          <td>&nbsp;</td>
       </tr>"

set num_gend_con "0"
set where_gend_sost "and a.gen_prog_originario is null"
db_foreach sel_gend_con "" {
    regsub -all {<} $matricola {\&lt;} matricola;#sim07
    regsub -all {>} $matricola {\&gt;} matricola;#sim07
    append libretto "
     <table width=100% border=1>
       <tr>
          <td align=left width=20%>Cogeneratore/Trigeneratore<br>CG $gen_prog</td>
          <td align=left width=80%>Situazione alla prima installazione o alla ristrutturazione dell'impianto termico $cod_impianto_est</td><!--gac11-->
       </tr>
    <tr>
    <td colspan=2>
    <table width=100% border=0>
       <tr>
          <td align=left>Data Installazione</td>
          <td align=left>$data_installaz</td>
          <td align=left>Data Dismissione</td>
          <td align=left>$data_rottamaz</td>
       </tr>
       <tr>
          <td align=left>Fabbricante</td>
          <td align=left>$descr_cost</td>
          <td align=left>Modello</td>
          <td align=left>$modello</td>
       </tr>
       <tr>
          <td align=left>Matricola</td>
          <td align=left>$matricola</td>
       </tr>
       <tr>
          <td align=left>Tipologia</td>
          <td align=left>$tipologia_cogenerazione</td>
          <td align=left>Alimentazione</td>
          <td align=left>$descr_comb</td>
       </tr>
       <tr>
          <td align=left>Potenza termica nominale (massimo recupero)</td>
          <td align=left colspan=3>$pot_foc_gend_con (kW)</td>
       </tr>
       <tr>
          <td align=left>Potenza elettrica nominale <small>ai morsetti del generatore</small></td>
          <td align=left colspan=3>$pot_utile_nom_con (kW)</td>
       </tr>
       </table>
       <br>
       <table width=100%>
       <tr>
          <td align=left bgcolor=\"E1E1E1\">Dati di targa</td>
          <td align=center bgcolor=\"E1E1E1\">min/max</td>
          <td align=left bgcolor=\"E1E1E1\">&nbsp;</td>
          <td align=center bgcolor=\"E1E1E1\">min/max</td>
       </tr>
       <tr>
          <td align=left>Temperatura acqua in uscita (°C)</td>
          <td align=center>$temp_h2o_uscita_min/$temp_h2o_uscita_max</td>
          <td align=left>Temperatura fumi a valle dello scambiatore (°C)</td>
          <td align=center>$temp_fumi_valle_min/$temp_fumi_valle_max</td>
       </tr>
       <tr>
          <td align=left>Temperatura acqua in ingresso (°C)</td>
          <td align=center>$temp_h2o_ingresso_min/$temp_h2o_ingresso_max</td>
          <td align=left>Temperatura fumi a monte dello scambiatore (°C)</td>
          <td align=center>$temp_fumi_monte_min/$temp_fumi_monte_max</td>
       </tr>
       <tr>
          <td align=left>Temperatura acqua motore <small>(solo m.c.i.)</small> (°C)</td>
          <td align=center>$temp_h2o_motore_min/$temp_h2o_motore_max</td>
          <td align=left>Emissioni di monossido di carbonio CO<br>(mg/Nm3 riportati al 5% di O2 nei fumi)</td>
          <td align=center>$emissioni_monossido_co_min/$emissioni_monossido_co_max</td>
       </tr>
      </table>
     </td>
    </tr>
   </table><br><br>"

    set num_gend_con "1"
}


if {$flag_gest_targa eq "T"} {#rom02: aggiunta if, else e loro contenuto
    set q_sel_gend_con_padre "sel_gend_con_padre_targa"
} else {
    set q_sel_gend_con_padre "sel_gend_con_padre"
}
set where_gend_sost "and a.gen_prog_originario is null"

db_foreach $q_sel_gend_con_padre "" {
    regsub -all {<} $matricola_con_padre {\&lt;} matricola_con_padre
    regsub -all {>} $matricola_con_padre {\&gt;} matricola_con_padre
    append libretto "

     <table width=100% border=1>
       <tr>
          <td align=left width=20%>Cogeneratore/Trigeneratore<br>CG $gen_prog_est_con_padre</td>
          <td align=left width=80%>Situazione alla prima installazione o alla ristrutturazione dell'impianto termico $cod_impianto_est_padre</td><!--gac11-->
       </tr>
    <tr>
    <td colspan=2>
    <table width=100% border=0>
       <tr>
          <td align=left>Data Installazione</td>
          <td align=left>$data_installaz_con_padre</td>
          <td align=left>Data Dismissione</td>
          <td align=left>$data_rottamaz_con_padre</td>
       </tr>
       <tr>
          <td align=left>Fabbricante</td>
          <td align=left>$costruttore_gend_con_padre</td>
          <td align=left>Modello</td>
          <td align=left>$modello_con_padre</td>
       </tr>
       <tr>
          <td align=left>Matricola</td>
          <td align=left>$matricola_con_padre</td>
       </tr>
       <tr>
          <td align=left>Tipologia</td>
          <td align=left>$tipologia_cogenerazione_con_padre</td>
          <td align=left>Alimentazione</td>
          <td align=left>$descr_comb_con_padre</td>
       </tr>
       <tr>
          <td align=left>Potenza termica nominale (massimo recupero)</td>
          <td align=left colspan=3>$pot_foc_gend_con_padre (kW)</td>
       </tr>
       <tr>
          <td align=left>Potenza elettrica nominale <small>ai morsetti del generatore</small></td>
          <td align=left colspan=3>$pot_utile_nom_con_padre (kW)</td>
       </tr>
       </table>
       <br>
       <table width=100%>
       <tr>
          <td align=left bgcolor=\"E1E1E1\">Dati di targa</td>
          <td align=center bgcolor=\"E1E1E1\">min/max</td>
          <td align=left bgcolor=\"E1E1E1\">&nbsp;</td>
          <td align=center bgcolor=\"E1E1E1\">min/max</td>
       </tr>
       <tr>
          <td align=left>Temperatura acqua in uscita (°C)</td>
          <td align=center>$temp_h2o_uscita_min_con_padre/$temp_h2o_uscita_max_con_padre</td>
          <td align=left>Temperatura fumi a valle dello scambiatore (°C)</td>
          <td align=center>$temp_fumi_valle_min_con_padre/$temp_fumi_valle_max_con_padre</td>
       </tr>
       <tr>
          <td align=left>Temperatura acqua in ingresso (°C)</td>
          <td align=center>$temp_h2o_ingresso_min_con_padre/$temp_h2o_ingresso_max_con_padre</td>
          <td align=left>Temperatura fumi a monte dello scambiatore (°C)</td>
          <td align=center>$temp_fumi_monte_min_con_padre/$temp_fumi_monte_max_con_padre</td>
       </tr>
       <tr>
          <td align=left>Temperatura acqua motore <small>(solo m.c.i.)</small> (°C)</td>
          <td align=center>$temp_h2o_motore_min_con_padre/$temp_h2o_motore_max_con_padre</td>
          <td align=left>Emissioni di monossido di carbonio CO<br>(mg/Nm3 riportati al 5% di O2 nei fumi)</td>
          <td align=center>$emissioni_monossido_co_max_con_padre/$emissioni_monossido_co_min_con_padre</td>
       </tr>
      </table>
     </td>
    </tr>
   </table><br><br>
"

    set num_gend_con "1"
    set num_gend_con_sost "1";#rom19
} 

if {$num_gend_con eq "1"} {
	append libretto "</table>
    <table width=100% >
          <tr>
             <td colspan=2>&nbsp;</td>
          </tr>
          <tr>
             <td colspan=2><b>SOSTITUZIONI DEL COMPONENTE</b></td>
          </tr>
    </table>"

    set where_gend_sost "and a.gen_prog_originario is not null"
    db_foreach sel_gend_con_sost "" {
	regsub -all {<} $matricola_sost {\&lt;} matricola_sost
	regsub -all {>} $matricola_sost {\&gt;} matricola_sost
	append libretto "
     <table width=100% border=1>
       <tr>
          <td align=left width=20%>Cogeneratore/Trigeneratore<br>CG $gen_prog_est_sost</td>
          <td align=left width=80%>Sostituzione del componente dell'impianto terrmico $cod_impianto_est</td>
       </tr>
    <tr>
    <td colspan=2>
    <table width=100% border=0>
       <tr>
          <td align=left>Data Installazione</td>
          <td align=left>$data_installaz_sost</td>
          <td align=left>Data Dismissione</td>
          <td align=left>$data_rottamaz_sost</td>
       </tr>
       <tr>
          <td align=left>Fabbricante</td>
          <td align=left>$descr_cost_sost</td>
          <td align=left>Modello</td>
          <td align=left>$modello_sost</td>
       </tr>
       <tr>
          <td align=left>Matricola</td>
          <td align=left>$matricola_sost</td>
       </tr>
       <tr>
          <td align=left>Tipologia</td>
          <td align=left>$tipologia_cogenerazione_sost</td>
          <td align=left>Alimentazione</td>
          <td align=left>$descr_comb_sost</td>
       </tr>
       <tr>
          <td align=left>Potenza termica nominale (massimo recupero)</td>
          <td align=left colspan=3>$pot_foc_gend_con_sost (kW)</td>
       </tr>
       <tr>
          <td align=left>Potenza elettrica nominale <small>ai morsetti del generatore</small></td>
          <td align=left colspan=3>$pot_utile_nom_con_sost (kW)</td>
       </tr>
       </table>
       <br>
       <table width=100%>
       <tr>
          <td align=left bgcolor=\"E1E1E1\">Dati di targa</td>
          <td align=center bgcolor=\"E1E1E1\">min/max</td>
          <td align=left bgcolor=\"E1E1E1\">&nbsp;</td>
          <td align=center bgcolor=\"E1E1E1\">min/max</td>
       </tr>
       <tr>
          <td align=left>Temperatura acqua in uscita (°C)</td>
          <td align=center>$temp_h2o_uscita_min_sost/$temp_h2o_uscita_max_sost</td>
          <td align=left>Temperatura fumi a valle dello scambiatore (°C)</td>
          <td align=center>$temp_fumi_valle_min_sost/$temp_fumi_valle_max_sost</td>
       </tr>
       <tr>
          <td align=left>Temperatura acqua in ingresso (°C)</td>
          <td align=center>$temp_h2o_ingresso_min_sost/$temp_h2o_ingresso_max_sost</td>
          <td align=left>Temperatura fumi a monte dello scambiatore (°C)</td>
          <td align=center>$temp_fumi_monte_min_sost/$temp_fumi_monte_max_sost</td>
       </tr>
       <tr>
          <td align=left>Temperatura acqua motore <small>(solo m.c.i.)</small> (°C)</td>
          <td align=center>$temp_h2o_motore_min_sost/$temp_h2o_motore_max_sost</td>
          <td align=left>Emissioni di monossido di carbonio CO<br>(mg/Nm3 riportati al 5% di O2 nei fumi)</td>
          <td align=center>$emissioni_monossido_co_min_sost/$emissioni_monossido_co_max_sost</td>
       </tr>
      </table>
     </td>
    </tr>
   </table><br>"
    }

    if {$flag_gest_targa eq "T"} {
	set q_sel_gend_con_padre_sost "sel_gend_con_padre_targa_sost"
    } else {
	set q_sel_gend_con_padre_sost "sel_gend_con_padre_sost"
    }
    set where_gend_sost "and a.gen_prog_originario is not null"
    db_foreach $q_sel_gend_con_padre_sost "" {
	regsub -all {<} $matricola_con_padre_sost {\&lt;} matricola_con_padre_sost
	regsub -all {>} $matricola_con_padre_sost {\&gt;} matricola_con_padre_sost
	append libretto "
     <table width=100% border=1>
       <tr>
          <td align=left width=20%>Cogeneratore/Trigeneratore<br>CG $gen_prog_con_padre_sost</td>
          <td align=left width=80%>Sostituzione del componente dell'impianto terrmico $cod_impianto_est_padre</td>
       </tr>
    <tr>
    <td colspan=2>
    <table width=100% border=0>
       <tr>
          <td align=left>Data Installazione</td>
          <td align=left>$data_installaz_con_padre_sost</td>
          <td align=left>Data Dismissione</td>
          <td align=left>$data_rottamaz_con_padre_sost</td>
       </tr>
       <tr>
          <td align=left>Fabbricante</td>
          <td align=left>$costruttore_gend_con_padre_sost</td>
          <td align=left>Modello</td>
          <td align=left>$modello_con_padre_sost</td>
       </tr>
       <tr>
          <td align=left>Matricola</td>
          <td align=left>$matricola_con_padre_sost</td>
       </tr>
       <tr>
          <td align=left>Tipologia</td>
          <td align=left>$tipologia_cogenerazione_con_padre_sost</td>
          <td align=left>Alimentazione</td>
          <td align=left>$descr_comb_con_padre_sost</td>
       </tr>
       <tr>
          <td align=left>Potenza termica nominale (massimo recupero)</td>
          <td align=left colspan=3>$pot_foc_gend_con_padre_sost (kW)</td>
       </tr>
       <tr>
          <td align=left>Potenza elettrica nominale <small>ai morsetti del generatore</small></td>
          <td align=left colspan=3>$pot_utile_nom_con_padre_sost (kW)</td>
       </tr>
       </table>
       <br>
       <table width=100%>
       <tr>
          <td align=left bgcolor=\"E1E1E1\">Dati di targa</td>
          <td align=center bgcolor=\"E1E1E1\">min/max</td>
          <td align=left bgcolor=\"E1E1E1\">&nbsp;</td>
          <td align=center bgcolor=\"E1E1E1\">min/max</td>
       </tr>
       <tr>
          <td align=left>Temperatura acqua in uscita (°C)</td>
          <td align=center>$temp_h2o_uscita_min_con_padre_sost/$temp_h2o_uscita_max_con_padre_sost</td>
          <td align=left>Temperatura fumi a valle dello scambiatore (°C)</td>
          <td align=center>$temp_fumi_valle_min_con_padre_sost/$temp_fumi_valle_max_con_padre_sost</td>
       </tr>
       <tr>
          <td align=left>Temperatura acqua in ingresso (°C)</td>
          <td align=center>$temp_h2o_ingresso_min_con_padre_sost/$temp_h2o_ingresso_max_con_padre_sost</td>
          <td align=left>Temperatura fumi a monte dello scambiatore (°C)</td>
          <td align=center>$temp_fumi_monte_min_con_padre_sost/$temp_fumi_monte_max_con_padre_sost</td>
       </tr>
       <tr>
          <td align=left>Temperatura acqua motore <small>(solo m.c.i.)</small> (°C)</td>
          <td align=center>$temp_h2o_motore_min_con_padre_sost/$temp_h2o_motore_max_con_padre_sost</td>
          <td align=left>Emissioni di monossido di carbonio CO<br>(mg/Nm3 riportati al 5% di O2 nei fumi)</td>
          <td align=center>$emissioni_monossido_co_min_con_padre_sost/$emissioni_monossido_co_max_con_padre_sost</td>
       </tr>
      </table>
     </td>
    </tr>
   </table><br>
"
} 

    
} else {
    append libretto "
    <tr>
       <td colspan=4>Non esiste alcun generatore</td>
    </tr>
    </table>"
}

append libretto "</table>
    <table width=100%>
          <tr>
             <td>&nbsp;</td>
          <tr>
    </table>"


#sim fine 4.6 cogenerazione

if {$coimtgen(regione) eq "MARCHE"} {#rom17: aggiunta if e suo contenuto per sezione 4.6bis delle Marche
        if {[db_0or1row sel_aimp ""] == 0} {
	iter_return_complaint "Impianto non trovato"
    }
    append libretto "
    <!-- PAGE BREAK -->
    $table_con_header_per_tutte_le_pagine"
    
    append libretto "
    <table width=100% border=1>
          <tr>
             <td align=center bgcolor=\"E1E1E1\"><big><b>4. Generatori</b></big></td>
          </tr>
    </table>"

    append libretto "
       <table width=100% align=center>
          <tr>
             <td>&nbsp;</td>
          </tr>
       <tr>
          <td align=center><b>4.6bis Dati Specifici Cogeneratori / Trigeneratori</td>
       </tr>
       <tr>
         <td>&nbsp;</td>
       </tr>
       </table>"
    set num_gend_co "0"
    set where_gend_sost "and a.gen_prog_originario is null"
    db_foreach sel_gend_co_4_6bis "" {
	set img_prod_acqua_co_4_6bis $img_unchecked
	set pot_utile_prod_acqua_co_4_6bis ""
	set img_cli_inv_co_4_6bis $img_unchecked 
	set pot_utile_cli_inv_co_4_6bis ""
	set img_cli_est_co_4_6bis $img_unchecked
	set pot_utile_cli_est_co_4_6bis ""
	
	if {$flag_prod_acqua_calda_co_4_6bis eq "S"} {
	    set img_prod_acqua_co_4_6bis $img_checked
	    set pot_utile_prod_acqua_co_4_6bis "- <b>Potenza Utile: $pot_utile_nom_co_4_6bis</b>"
	}
	if {$flag_clima_invernale_co_4_6bis eq "S"} {
	    set img_cli_inv_co_4_6bis $img_checked
	    set pot_utile_cli_inv_co_4_6bis "- <b>Potenza Utile: $pot_utile_nom_co_4_6bis</b>"
	}
	if {$flag_clim_est_co_4_6bis eq "S"} {
	    set pot_utile_cli_inv_co_4_6bis "- <b>Potenza Utile: $pot_utile_nom_co_4_6bis</b>"
	}

	append libretto "
<table width=100% border=1>
    <tr>
       <td align=left width=20%>Cogeneratore/trigeneratore CG $gen_prog_est_co_4_6bis</td>
       <td align=left width=80%>Situazione alla prima installazione o alla ristrutturazione dell'impianto termico $cod_impianto_est_4_6bis</td>
    </tr>
    <tr>
       <td colspan=2>
  <table  border=0>
       <tr>  
         <td align=left>Data costruzione</td>
         <td align=left>$data_costruz_gen_co_4_6bis</td>
       </tr>
       <tr>
         <td align=left>Attivo</td>
         <td align=left>$stato_gen_co_4_6bis</td>
         <td align=left>Motivazione GT inattivo</td>
         <td align=left>$motivazione_disattivo_co_4_6bis</td>
       </tr>
       <tr>
         <td align=left>Riferimento</td>
         <td align=left>$rif_uni_10389_co_4_6bis</td>
         <td align=left>Altro</td>
         <td align=left>$altro_rif_co_4_6bis</td>
       <tr>  
         <td align=left colspan=2 width=50%>$img_prod_acqua_co_4_6bis Prod. Acq. calda sanitaria $pot_utile_prod_acqua_co_4_6bis</td>
       </tr>
       <tr>
         <td align=left colspan=2 width=50%>$img_cli_inv_co_4_6bis Climatizzazione inv. $pot_utile_cli_inv_co_4_6bis</td>
       </tr>
       <tr>
         <td align=left colspan=2 width=50%>$img_cli_est_co_4_6bis Climatizzazione est. $pot_utile_cli_est_co_4_6bis</td>
       </tr>
       <tr>
       </tr>
    </table>
</td>
</tr>
</table>
<br>"
	set num_gend_co "1"
    }
    
    if {$num_gend_co eq "1"} {

	append libretto "<table width=100%>
          <tr>
             <td>&nbsp;</td>
          </tr>
          <tr>
             <td align=left><b>SOSTITUZIONI DEL COMPONENTE</b></td>
          </tr>
     </table><br>"
	set where_gend_sost "and a.gen_prog_originario is not null"
    db_foreach sel_gend_co_4_6bis_sost "" {
	set img_prod_acqua_co_4_6bis_sost $img_unchecked
	set pot_utile_prod_acqua_co_4_6bis_sost ""
	set img_cli_inv_co_4_6bis_sost $img_unchecked 
	set pot_utile_cli_inv_co_4_6bis_sost ""
	set img_cli_est_co_4_6bis_sost $img_unchecked
	set pot_utile_cli_est_co_4_6bis_sost ""
	
	if {$flag_prod_acqua_calda_co_4_6bis_sost eq "S"} {
	    set img_prod_acqua_co_4_6bis_sost $img_checked
	    set pot_utile_prod_acqua_co_4_6bis_sost "- <b>Potenza Utile: $pot_utile_nom_co_4_6bis_sost</b>"
	}
	if {$flag_clima_invernale_co_4_6bis_sost eq "S"} {
	    set img_cli_inv_co_4_6bis_sost $img_checked
	    set pot_utile_cli_inv_co_4_6bis_sost "- <b>Potenza Utile: $pot_utile_nom_co_4_6bis_sost</b>"
	}
	if {$flag_clim_est_co_4_6bis_sost eq "S"} {
	    set pot_utile_cli_inv_co_4_6bis_sost "- <b>Potenza Utile: $pot_utile_nom_co_4_6bis_sost</b>"
	}
	    
	append libretto "
<table width=100% border=1>
    <tr>
       <td align=left width=20%>Cogeneratore/trigeneratore CG $gen_prog_est_co_4_6bis_sost</td>
       <td align=left width=80%>Sostituzione del componente dell'impianto termico $cod_impianto_est_4_6bis_sost</td>
    </tr>
    <tr>
       <td colspan=2>
  <table  border=0>
       <tr>
         <td align=left>Data costruzione</td>
         <td align=left>$data_costruz_gen_co_4_6bis_sost</td>
       </tr>
       <tr>
         <td align=left>Attivo</td>
         <td align=left>$stato_gen_co_4_6bis_sost</td>
         <td align=left>Motivazione GT inattivo</td>
         <td align=left>$motivazione_disattivo_co_4_6bis_sost</td>
       </tr>
       <tr>
         <td align=left>Riferimento</td>
         <td align=left>$rif_uni_10389_co_4_6bis_sost</td>
         <td align=left>Altro</td>
         <td align=left>$altro_rif_co_4_6bis_sost</td>
       <tr>
         <td align=left colspan=2 width=50%>$img_prod_acqua_co_4_6bis_sost Prod. Acq. calda sanitaria $pot_utile_prod_acqua_co_4_6bis_sost</td>
       </tr>
       <tr>
         <td align=left colspan=2 width=50%>$img_cli_inv_co_4_6bis_sost Climatizzazione inv. $pot_utile_cli_inv_co_4_6bis_sost</td>
       </tr>
       <tr>
         <td align=left colspan=2 width=50%>$img_cli_est_co_4_6bis_sost Climatizzazione est. $pot_utile_cli_est_co_4_6bis_sost</td>
       </tr>
       <tr>
       </tr>
    </table>
</td>
</tr>
</table>
<br>"
    }

    } else {
    append libretto "
    <table>
    <tr>
       <td>Non esiste alcun generatore</td>
    </tr>
    </table>"
    }
};#rom17 fine sezione 4.6bis

set where_gend_sost ""

#gab02 Aggiunta sezione 4.7 Campi Solari Termici
append libretto "
    <!-- PAGE BREAK -->
    $table_con_header_per_tutte_le_pagine
"


set cod_camp_sola_aimp ""
set num_cs ""
set data_installaz ""
set descr_cost ""
set collettori ""
set sup_totale ""

append libretto "
    <table width=100% border=1>
          <tr>
             <td align=center bgcolor=\"E1E1E1\"><big><b>4. Generatori</b></big></td>
          </tr>
    </table>"

append libretto "
    <table width=100% align=center>
          <tr>
             <td>&nbsp;</td>
          </tr>
       <tr>
          <td align=center colspan=4><b>4.7 Campi Solari Termici.
       </tr>
       <tr>
          <td colspan=4>&nbsp;</td>
       </tr>"

set sw_camp_sola "f"

db_foreach sel_camp_sola "" {
    append libretto "
  <table width=100% border=1>
    <tr>
      <td align=left width=30%>Campo Solare<br>CS $num_cs</td>
      <td align=left width=70%>Situazione alla prima installazione o alla ristrutturazione dell'impianto termico $cod_impianto_est</td><!--gac11-->
   </tr>
   <tr>
    <td colspan=2>
     <table width=100%>
       <tr>
          <td align=left>Data di installazione</td>
          <td align=left colspan=3>$data_installaz</td>
      </tr>
       <tr>
          <td align=left>Fabbricante</td>
          <td align=left colspan=3>$descr_cost</td>
      </tr>
       <tr>
          <td align=left>Collettori</td>
          <td align=left>$collettori (n°)</td>
          <td align=left>Superficie totale di apertura</td>
          <td align=left>$sup_totale (m2)</td>
      </tr>
     </table>
    </td>
   </tr>
  </table><br><br>"
    set sw_camp_sola "t"
}


if {$sw_camp_sola eq "t"} {
    append libretto "</table>
    <table width=100%>
          <tr>
             <td colspan=2>&nbsp;</td>
          <tr>
             <td colspan=2>&nbsp;</td>
          </tr>
          </tr>
          <tr>
             <td colspan=2><b>VARIAZIONE DEL CAMPO SOLARE TERMICO</b></td>
          </tr>         
          <tr>
             <td colspan=2>&nbsp;</td>
          </tr>
    </table>"
    
    db_foreach sel_camp_sola_variaz "" {#rom10 aggiunta foreach e contenuto
	append libretto "
<table width=100% border=1>
     <tr>
       <td colspan=2>
         <table width=100%>
              <tr>
                <td align=left>Data installazione nuova configurazione</td>
                <td align=left colspan=3>$data_installaz</td>
              </tr>
              <tr>
                <td align=left>Fabbricante</td>
                <td align=left colspan=3>$descr_cost_variaz</td>
              </tr>
              <tr>
                <td align=left>Collettori</td>
                <td align=left>$collettori_variaz (n°)</td>
                <td align=left>Superficie totale di apertura</td>
                <td align=left>$sup_totale_variaz (m2)</td>
              </tr>
         </table>
       </td>
     </tr>
</table><br><br>"
	
    };#rom10

#rom10	<tr>
#rom10        <td>Data installazione nuova configurazione _________________</td>
#rom10     </tr>
#rom10     <tr> 
#rom10        <td>Fabbricante _________________</td>
#rom10     </tr>
#rom10     <tr>
#rom10        <td>Collettori _________________ (n&deg;)</td>
#rom10        <td>Superficie totale di apertura _________________ (m<sup>2</sup>)</td>
#rom10     </tr>

#rom10     <tr>
#rom10        <td colspan=2>&nbsp;</td>
#rom10     </tr>
#rom10          <tr>
#rom10             <td>Data installazione nuova configurazione _________________</td>
#rom10          </tr>
#rom10          <tr> 
#rom10             <td>Fabbricante _________________</td>
#rom10          </tr>
#rom10          <tr>
#rom10             <td>Collettori _________________ (n&deg;)</td>
#rom10             <td>Superficie totale di apertura _________________ (m<sup>2</sup>)</td>
#rom10          </tr>
#rom10
#rom10          <tr>
#rom10        <td colspan=2>&nbsp;</td>
#rom10     </tr>
#rom10      <tr>
#rom10        <td>Data installazione nuova configurazione _________________</td>
#rom10     </tr>
#rom10     <tr> 
#rom10        <td>Fabbricante _________________</td>
#rom10     </tr>
#rom10     <tr>
#rom10        <td>Collettori _________________ (n&deg;)</td>
#rom10        <td>Superficie totale di apertura _________________ (m<sup>2</sup>)</td>
#rom10     </tr>

#rom10     <tr>
#rom10        <td colspan=2>&nbsp;</td>
#rom10     </tr>
#rom10     <tr>
#rom10        <td>Data installazione nuova configurazione _________________</td>
#rom10     </tr>
#rom10     <tr> 
#rom10        <td>Fabbricante _________________</td>
#rom10     </tr>
#rom10     <tr>
#rom10        <td>Collettori _________________ (n&deg;)</td>
#rom10        <td>Superficie totale di apertura _________________ (m<sup>2</sup>)</td>
#rom10     </tr>
#rom10/table>

} else {
    append libretto "
    <tr>
       <td colspan=4>Non esiste alcun campo solare termico</td>
    </tr>
    </table>"
}


#gab02 Aggiunta sezione 4.8 Altri Generatori
set cod_altr_gend_aimp ""
set num_ag ""
set data_installaz ""
set data_dismissione ""
set descr_cost ""
set modello ""
set matricola ""
set tipologia ""
set potenza_utile ""

append libretto "
    <!-- PAGE BREAK -->
    $table_con_header_per_tutte_le_pagine
"
append libretto "
    <table width=100% border=1>
          <tr>
             <td align=center bgcolor=\"E1E1E1\"><big><b>4. Generatori</b></big></td>
          </tr>
    </table>"

append libretto "
    <table width=100% align=center>
          <tr>
             <td>&nbsp;</td>
          </tr>
       <tr>
          <td align=center colspan=4><b>4.8 Altri Generatori.
<br>Situazione alla prima installazione o alla ristrutturazione dell'impianto termico $cod_impianto_est</b></td><!--gac11-->
       </tr>
       <tr>
          <td colspan=4>&nbsp;</td>
       </tr>"

set sw_altr_gend "f"

db_foreach sel_altr_gend "" {
    regsub -all {<} $matricola {\&lt;} matricola;#sim07
    regsub -all {>} $matricola {\&gt;} matricola;#sim07
    append libretto "
  <table width=100% border=1>
       <tr>
          <td align=left width=20%>Altro  Generatore<br>AG $num_ag</td>
    <td align=left width=70%>Situazione alla prima installazione o alla ristrutturazione dell'impianto termico $cod_impianto_est</td><!--gac11-->
  </tr>
   <tr>
    <td colspan=2>
     <table width=100%>
       <tr>
          <td align=left>Data di installazione</td>
          <td align=left>$data_installaz</td>
          <td align=left>Data di dismissione</td>
          <td align=left>$data_dismissione</td>
       </tr>
       <tr>
          <td align=left>Fabbricante</td>
          <td align=left>$descr_cost</td>
          <td align=left>Modello</td>
          <td align=left>$modello</td>
       </tr>
       <tr>
          <td align=left>Matricola</td>
          <td align=left>$matricola</td>
       </tr>
       <tr>
          <td align=left>Tipologia</td>
          <td align=left>$tipologia</td>
          <td align=left>Potenza Utile</td>
          <td align=left>$potenza_utile (kW)</td>
       </tr>
       </table>
      </td>
     </tr>
    </table><br><br>"

    set sw_altr_gend "t"
}


if {$sw_altr_gend eq "t"} {
    append libretto "</table>
    <table width=100%>
          <tr>
             <td colspan=2>&nbsp;</td>
          </tr>
          <tr>
             <td colspan=2><b>SOSTITUZIONI DEL COMPONENTE</b></td>
          </tr>         
          <tr>
             <td colspan=2>&nbsp;</td>
          </tr>          
    </table>"

    db_foreach sel_altr_gend_sost_comp "" {#rom07 aggiunta foreach e contenuto
	regsub -all {<} $matricola_sost_comp {\&lt;} matricola_sost_comp
	regsub -all {>} $matricola_sost_comp {\&gt;} matricola_sost_comp
	append libretto "
  <table width=100% border=1>
       <tr>
          <td align=left width=20%>Altro  Generatore<br>AG $num_ag_sost_comp</td>
    <td align=left width=70%>Sostituzione del componente</td>
  </tr>
   <tr>
    <td colspan=2>
     <table width=100%>
       <tr>
          <td align=left>Data di installazione</td>
          <td align=left>$data_installaz_sost_comp</td>
          <td align=left>Data di dismissione</td>
          <td align=left>$data_dismissione_sost_comp</td>
       </tr>
       <tr>
          <td align=left>Fabbricante</td>
          <td align=left>$descr_cost_sost_comp</td>
          <td align=left>Modello</td>
          <td align=left>$modello_sost_comp</td>
       </tr>
       <tr>
          <td align=left>Matricola</td>
          <td align=left>$matricola_sost_comp</td>
       </tr>
       <tr>
          <td align=left>Tipologia</td>
          <td align=left>$tipologia_sost_comp</td>
          <td align=left>Potenza Utile</td>
          <td align=left>$potenza_utile_sost_comp (kW)</td>
       </tr>
       </table>
      </td>
     </tr>
    </table><br><br>"

};#rom07

    #rom07    <tr>
    #rom07       <td colspan=2>&nbsp;</td>
    #rom07    </tr>
    #rom07    <tr>
    #rom07       <td>Data di installazione _________________</td>
    #rom07       <td>Data di dismissione _________________</td>
    #rom07    </tr>
    #rom07    <tr>
    #rom07       <td>Fabbricante _________________</td>
    #rom07       <td>Modello _________________</td>
    #rom07    </tr>
    #rom07    <tr>
    #rom07       <td>Matricola _________________</td>
    #rom07    </tr>
    #rom07    <tr>
    #rom07       <td>Tipologia _________________</td>
    #rom07       <td>Potenza utile _________________ (kW)</td>
    #rom07    </tr>
    #rom07
    #rom07    <tr>
    #rom07       <td colspan=2>&nbsp;</td>
    #rom07    </tr>
    #rom07    <tr>
    #rom07       <td>Data di installazione _________________</td>
    #rom07       <td>Data di dismissione _________________</td>
    #rom07    </tr>
    #rom07    <tr>
    #rom07       <td>Fabbricante _________________</td>
    #rom07       <td>Modello _________________</td>
    #rom07    </tr>
    #rom07    <tr>
    #rom07       <td>Matricola _________________</td>
    #rom07    </tr>
    #rom07    <tr>
    #rom07       <td>Tipologia _________________</td>
    #rom07       <td>Potenza utile _________________ (kW)</td>
    #rom07    </tr>
    #rom07
    #rom07    <tr>
    #rom07       <td colspan=2>&nbsp;</td>
    #rom07    </tr>
    #rom07    <tr>
    #rom07       <td>Data di installazione _________________</td>
    #rom07       <td>Data di dismissione _________________</td>
    #rom07    </tr>
    #rom07    <tr>
    #rom07       <td>Fabbricante _________________</td>
    #rom07       <td>Modello _________________</td>
    #rom07    </tr>
    #rom07    <tr>
    #rom07       <td>Matricola _________________</td>
    #rom07    </tr>
    #rom07    <tr>
    #rom07       <td>Tipologia _________________</td>
    #rom07       <td>Potenza utile _________________ (kW)</td>
    #rom07    </tr>
    #rom07
    #rom07    <tr>
    #rom07       <td colspan=2>&nbsp;</td>
    #rom07    </tr>
    #rom07    <tr>
    #rom07       <td>Data di installazione _________________</td>
    #rom07       <td>Data di dismissione _________________</td>
    #rom07    </tr>
    #rom07    <tr>
    #rom07       <td>Fabbricante _________________</td>
    #rom07       <td>Modello _________________</td>
    #rom07    </tr>
    #rom07    <tr>
    #rom07       <td>Matricola _________________</td>
    #rom07    </tr>
    #rom07    <tr>
    #rom07       <td>Tipologia _________________</td>
    #rom07       <td>Potenza utile _________________ (kW)</td>
    #rom07    </tr>
    #rom07
    #rom07</table>
    
} else {
    append libretto "
    <tr>
       <td colspan=4>Non esiste alcun altro generatore</td>
    </tr>
    </table>"
}



#Contabilizzazione del calore

append libretto "
    <!-- PAGE BREAK -->
    $table_con_header_per_tutte_le_pagine
"


append libretto "
    <table width=100% border=1>
          <tr>
             <td align=center bgcolor=\"E1E1E1\"><big><b>5. Sistemi di Regolazione e  Contabilizzazione</b></big></td>
          </tr>
    </table>"

#if {[db_0or1row sel_aimp_rego ""] == 0} {
#    iter_return_complaint "Impianto non trovato"
#} else {}

if {$coimtgen(regione) eq "MARCHE"} {

    set or_aimp_rego "or targa = :targa"

} else {
    set or_aimp_rego ""
}

db_foreach sel_aimp_rego "" {
    
    append libretto "
    <table width=100% align=center>
          <tr>
          <tr>
             <td colspan=4>&nbsp;</td>
          </tr>
             <td align=center colspan=4><b>5.1  Regolazione  Primaria<br>Situazione alla prima installazione o alla ristrutturazione dell'impianto termico $cod_impianto_est_rego</b></td><!--gac11-->
          </tr>
          <tr>
             <td colspan=4>&nbsp;</td>
          </tr>
    </table>"


    set img_on_off             $img_unchecked
    set img_curva_integrata    $img_unchecked
    set img_curva_indipendente $img_unchecked
    set img_valv_regolazione   $img_unchecked
    set img_sist_multigradino  $img_unchecked
    set img_sist_inverter      $img_unchecked
    set img_altri_flag         $img_unchecked

    if {$regol_on_off eq "S"} {
	set img_on_off $img_checked
    }

    if {$regol_curva_integrata eq "S"} {
	set img_curva_integrata $img_checked
    }

    if {$regol_curva_indipendente eq "S"} {
	set img_curva_indipendente $img_checked
    }

    if {$regol_valv_regolazione eq "S"} {
        set img_valv_regolazione $img_checked
    }

    if {$regol_sist_multigradino eq "S"} {
        set img_sist_multigradino $img_checked
    }

    if {$regol_sist_inverter eq "S"} {
        set img_sist_inverter $img_checked
    }

    if {$regol_altri_flag eq "S"} {
        set img_altri_flag $img_checked
    }
    if {$coimtgen(regione) ne "MARCHE"} {#rom11 aggiunta if; aggiunta else e contenuto
	append libretto "
$img_on_off Sistema di regolazione ON - OFF<br>
$img_curva_integrata Sistema di regolazione con impostazione della curva climatica integrata nel generatore<br>
$img_curva_indipendente Sistema di regolazione con impostazione della curva climatica indipendente<br>
<br>
<table width=100% align=center>
      <tr>
         <td colspan=2 align=center>
           <table width=90% border=1>
                <tr>
                   <td align=left width=20%>Sistema reg.ne<br>SR 1</td>
                   <td align=left width=80%>Situazione alla prima installazione o alla ristrutturazione dell'impianto termico</td>
                </tr>
                <tr>
                   <td colspan=2>
                      <table width=100%>
                            <tr>
                               <td>Data di installazione</td>
                               <td>$regol_curva_ind_iniz_data_inst</td>
                               <td>Data di dismissione</td>
                               <td>$regol_curva_ind_iniz_data_dism</td>
                            </tr>
                            <tr>
                              <td>Fabbricante</td>
                              <td>$regol_curva_ind_iniz_fabbricante</td>
                              <td>Modello</td>
                              <td>$regol_curva_ind_iniz_modello</td>
                           </tr>
                           <tr>
                              <td>Fabbricante</td>
                              <td>$regol_curva_ind_iniz_fabbricante</td>
                              <td>Modello</td>
                              <td>$regol_curva_ind_iniz_modello</td>
                           </tr>
                           <tr>
                              <td>Numero punti di regolazione</td>
                              <td>$regol_curva_ind_iniz_n_punti_reg</td>
                              <td>Numero livelli di temperatura</td>
                              <td>$regol_curva_ind_iniz_n_liv_temp</td>
                           </tr>
                      </table>
                   </td>
                </tr>
           </table><br>
           <table width=90% align=center border=1>
                 <tr>
                    <td colspan=2>SOSTITUZIONI DEL COMPONENTE</td>
                </tr>
                <tr>
                   <td colspan=2>
                      <table width=100%>
                            <tr>
                               <td>Data di installazione _________________</td>
                               <td>Data di dismissione _________________</td>
                           </tr>
                           <tr>
                              <td>Fabbricante _________________</td>
                              <td>Modello _________________</td>
                           </tr>
                           <tr>
                              <td>Numero punti di regolazione _________________</td>
                              <td>Numero livelli di temperatura _________________</td>
                           </tr>
                      </table>
                   </td>
                </tr><br>
                <tr>
                   <td colspan=2>
                      <table width=100%>
                            <tr>
                               <td>Data di installazione _________________</td>
                               <td>Data di dismissione _________________</td>
                            </tr>
                            <tr>
                             <td>Fabbricante _________________</td>
                             <td>Modello _________________</td>
                            </tr>
                            <tr>
                             <td>Numero punti di regolazione _________________</td>
                             <td>Numero livelli di temperatura _________________</td>
                            </tr>
                      </table>
                   </td>
                </tr><br>
           </table>
         </td>
      </tr>
</table><br>
 $img_valv_regolazione Valvole di regolazione (se non incorporate nel generatore)<br>
<br>
<table width=90% align=center>
      <tr>
         <td>
            <table width=100% border=1>
                  <tr>
                     <td align=left width=20%>Valvola reg.ne<br>VR 1</td>
                     <td align=left width=80%>Situazione alla prima installazione o alla ristrutturazione dell'impianto termico</td>
                  </tr>
                  <tr>
                     <td colspan=2>
                        <table width=100%>
                              <tr>
                                 <td>Data di installazione</td>
                                 <td>$regol_valv_ind_iniz_data_inst</td>
                                 <td>Data di dismissione</td>
                                 <td>$regol_valv_ind_iniz_data_dism</td>
                              </tr>
                              <tr>
                                 <td>Fabbricante</td>
                                 <td>$regol_valv_ind_iniz_fabbricante</td>
                                 <td>Modello</td>
                                 <td>$regol_valv_ind_iniz_modello</td>
                              </tr>
                              <tr>
                                 <td>Numero di vie</td>
                                 <td>$regol_valv_ind_iniz_n_vie</td>
                                 <td>Servomotore</td>
                                 <td>$regol_valv_ind_iniz_servo_motore</td>
                              </tr>
                        </table> 
                     </td>
                  </tr>
            </table><br>
            <table width=100% align=center border=1>
                  <tr>
                     <td colspan=2>SOSTITUZIONI DEL COMPONENTE</td>
                  </tr>
                  <tr>
                     <td colspan=2>
                        <table width=100%>
                              <tr> 
                                 <td>Data di installazione _________________</td>
                                 <td>Data di dismissione _________________</td>
                              </tr>
                              <tr>
                                 <td>Fabbricante _________________</td>
                                 <td>Modello _________________</td>
                              </tr>
                              <tr>
                                 <td>Numero di vie _________________</td>
                                 <td>Servomotore _________________</td>
                              </tr>
                        </table>
                     </td>
                  </tr><br>
                  <tr>
                     <td colspan=2>
                        <table width=100%>
                              <tr> 
                                 <td>Data di installazione _________________</td>
                                 <td>Data di dismissione _________________</td>
                              </tr>
                              <tr>
                                 <td>Fabbricante _________________</td>
                                 <td>Modello _________________</td>
                              </tr>
                              <tr>
                                 <td>Numero di vie _________________</td>
                                 <td>Servomotore _________________</td>
                              </tr>
                        </table>
                     </td>
                  </tr><br>
              </table>  
           </td>
        </tr>
</table><br><br>
$img_sist_multigradino Sistema di regolazione multigradino<br>
$img_sist_inverter Sistema di regolazione a Inverter del generatore<br>
$img_altri_flag Altri sistemi di regolazione primaria<br><br>
Descrizione del Sistema: $regol_altri_desc_sistema
    <!-- PAGE BREAK -->
    $table_con_header_per_tutte_le_pagine
"
    } else {
   	append libretto "
$img_on_off Sistema di regolazione ON - OFF<br>
$img_curva_integrata Sistema di regolazione con impostazione della curva climatica integrata nel generatore<br>
$img_curva_indipendente Sistema di regolazione con impostazione della curva climatica indipendente<br>
<br>"
	set num_sist_reg ""
	db_foreach sel_sist_reg "" {
	append libretto "
<table width=100% align=center border=0>
      <tr>
         <td colspan=2 align=center>
           <table width=90% border=1>
                <tr>
                   <td align=left width=20%>Sistema reg.ne<br>SR $num_sr</td>
                   <td align=left width=80%>Situazione alla prima installazione o alla ristrutturazione dell'impianto termico $cod_impianto_est</td><!--gac11-->
                </tr>
                <tr>
                   <td colspan=2>
                      <table width=100%>
                            <tr>
                               <td>Data di installazione</td>
                               <td>$data_installazione_sr_edit</td>
                               <td>Data di dismissione</td>
                               <td>$data_dismissione_sr_edit</td>
                            </tr>
                            <tr>
                              <td>Fabbricante</td>
                              <td>$fabbricante_sr</td>
                              <td>Modello</td>
                              <td>$modello_sr</td>
                           </tr>
                           <tr>
                              <td>Numero punti di regolazione</td>
                              <td>$num_punti_regolaz_sr</td>
                              <td>Numero livelli di temperatura</td>
                              <td>$num_lvl_temp_sr</td>
                           </tr>
                      </table>
                   </td>
                </tr>
           </table>
         </td>
      </tr>"
	    set num_sist_reg "1"
	}
	if {$num_sist_reg == "1"} {
	    append libretto "
      <tr>
        <td colspan=2> 
           <table width=90% align=center>
                <tr>
                   <td align=left><b>SOSTITUZIONE DEL COMPONENTE</b></td>
            </table>
         </td>
      </tr>"
	    db_foreach sel_sist_reg_sost_comp "" {
		append libretto "
      <tr>
        <td colspan=2>  
           <table width=90% border=1 align=center>
                <tr>
                   <td align=left width=20%>Sistema reg.ne<br>SR $num_sr_sost_comp</td>
                   <td align=left width=80%>Sostituzione del componente</td>
                </tr>
                <tr>
                   <td colspan=2>
                      <table width=100%>
                            <tr>
                               <td>Data di installazione</td>
                               <td>$data_installazione_sr_edit_sost_comp</td>
                               <td>Data di dismissione</td>
                               <td>$data_dismissione_sr_edit_sost_comp</td>
                            </tr>
                            <tr>
                              <td>Fabbricante</td>
                              <td>$fabbricante_sr_sost_comp</td>
                              <td>Modello</td>
                              <td>$modello_sr_sost_comp</td>
                           </tr>
                           <tr>
                              <td>Numero punti di regolazione</td>
                              <td>$num_punti_regolaz_sr_sost_comp</td>
                              <td>Numero livelli di temperatura</td>
                              <td>$num_lvl_temp_sr_sost_comp</td>
                           </tr>
                      </table>
                   </td>
                </tr>
           </table>
        </td>
      </tr>
</table>"
	    }
	} else {
	    append libretto "
             <table width=90%>
                  <tr>
                    <td align=center>Non esiste alcun Sistema di Regolazione</td>   
                  </tr>
             </table>"
	}
	append libretto "
        <br>
        $img_valv_regolazione Valvole di regolazione (se non incorporate nel generatore)<br>
        <br>"
       
	set num_valv_reg ""
	db_foreach sel_valv_reg "" {
	    append libretto "
<table width=100% align=center>
      <tr>
         <td colspan=2 align=center>
            <table width=90% border=1>
                  <tr>
                     <td align=left width=20%>Valvola reg.ne<br>VR $num_vr</td>
                     <td align=left width=80%>Situazione alla prima installazione o alla ristrutturazione dell'impianto termico $cod_impianto_est</td><!--gac11-->
                  </tr>
                  <tr>
                     <td colspan=2>
                        <table width=100%>
                              <tr>
                                 <td>Data di installazione</td>
                                 <td>$data_installazione_vr_edit</td>
                                 <td>Data di dismissione</td>
                                 <td>$data_dismissione_vr_edit</td>
                              </tr>
                              <tr>
                                 <td>Fabbricante</td>
                                 <td>$fabbricante_vr</td>
                                 <td>Modello</td>
                                 <td>$modello_vr</td>
                              </tr>
                              <tr>
                                 <td>Numero di vie</td>
                                 <td>$num_vie_vr</td>
                                 <td>Servomotore</td>
                                 <td>$servomotore_vr</td>
                              </tr>
                        </table> 
                     </td>
                  </tr>
            </table>
         </td>
      </tr>"

	    set num_valv_reg "1" 
	}
	if {$num_valv_reg == "1"} {
	    append libretto "
      <tr>
         <td colspan=2>
           <table width=90% align=center>
                <tr>
                   <td align=left><b>SOSTITUZIONE DEL COMPONENTE</b></td>
                </tr>
           </table>
         </td>
      </tr>"
	    db_foreach sel_valv_reg_sost_comp "" {
		append libretto "
      <tr>
        <td colspan=2>  
           <table width=90% border=1 align=center>
                <tr>
                   <td align=left width=20%>Valvola reg.ne<br>VR $num_vr_sost_comp</td>
                   <td align=left width=80%>Sostituzione del componente</td>
                </tr>
                <tr>
                   <td colspan=2>
                      <table width=100%>
                            <tr>
                               <td>Data di installazione</td>
                               <td>$data_installazione_vr_edit_sost_comp</td>
                               <td>Data di dismissione</td>
                               <td>$data_dismissione_vr_edit_sost_comp</td>
                            </tr>
                            <tr>
                              <td>Fabbricante</td>
                              <td>$fabbricante_vr_sost_comp</td>
                              <td>Modello</td>
                              <td>$modello_vr_sost_comp</td>
                           </tr>
                           <tr>
                              <td>Numero di vie</td>
                              <td>$num_vie_vr_sost_comp</td>
                              <td>Servomotore</td>
                              <td>$servomotore_vr_sost_comp</td>
                           </tr>
                      </table>
                   </td>
                </tr>
           </table>
        </td>
      </tr>
</table>"
	    }
	} else {
            append libretto "
             <table width=90%>
                  <tr>
                    <td align=center>Non esiste alcuna Valvola di Regolazione</td>
                  </tr>
             </table>"
	}
	
	append libretto "
<br>
$img_sist_multigradino Sistema di regolazione multigradino<br>
$img_sist_inverter Sistema di regolazione a Inverter del generatore<br>
$img_altri_flag Altri sistemi di regolazione primaria<br><br>
Descrizione del Sistema: $regol_altri_desc_sistema
"
    };#rom11

}

append libretto "<!-- PAGE BREAK -->
    $table_con_header_per_tutte_le_pagine"

    
    append libretto "
    <table width=100% border=1>
          <tr>
             <td align=center bgcolor=\"E1E1E1\"><big><b>5. Sistemi di Regolazione e  Contabilizzazione</b></big></td>
          </tr>
    </table>"

db_foreach sel_aimp_rego "" {
    append libretto "
    <table width=100%>
          <tr>
             <td>&nbsp;</td>
          </tr>
          <tr>
             <td align=center><b>5.2 Regolazione Singolo Ambiente di Zona dell'impianto termico $cod_impianto_est_rego</b></td>
          </tr>
          <tr>
             <td>&nbsp;</td>
          </tr>
    </table>"

set img_term_on_off             $img_unchecked
set img_term_proporz            $img_unchecked
set img_entalpico               $img_unchecked
set img_aria_variabile          $img_unchecked
set img_valv_termostatiche_pres $img_unchecked
set img_valv_termostatiche_ass  $img_unchecked
set img_valv_due_vie_pres       $img_unchecked
set img_valv_due_vie_ass        $img_unchecked
set img_valv_tre_vie_pres       $img_unchecked
set img_valv_tre_vie_ass        $img_unchecked

if {$regol_cod_tprg eq "A"} {
    set img_term_on_off $img_checked
}
if {$regol_cod_tprg eq "B"} {
    set img_term_proporz $img_checked
}
if {$regol_cod_tprg eq "C"} {
    set img_entalpico $img_checked
}
if {$regol_cod_tprg eq "D"} {
    set img_aria_variabile $img_checked
}

if {$regol_valv_termostatiche eq "P"} {
    set img_valv_termostatiche_pres $img_checked
}
if {$regol_valv_termostatiche eq "A"} {
    set img_valv_termostatiche_ass $img_checked
}

if {$regol_valv_due_vie  eq "P"} {
    set img_valv_due_vie_pres $img_checked
}
if {$regol_valv_due_vie  eq "A"} {
    set img_valv_due_vie_ass $img_checked
}

if {$regol_valv_tre_vie  eq "P"} {
    set img_valv_tre_vie_pres $img_checked
}
if {$regol_valv_tre_vie  eq "A"} {
    set img_valv_tre_vie_ass $img_checked
}

    append libretto "
<table width=100% align=center>
<tr>
<td>
    <table width=100% align=center>
          <tr>
             <td colspan=3>$img_term_on_off Termostato di Zona o Ambiente con controllo ON-OFF</td>
          </tr>
          <tr>
             <td colspan=3>$img_term_proporz Termostato di Zona o Ambiente con controllo proporzionale</td>
          </tr>
          <tr>
             <td colspan=3>$img_entalpico Controllo Entalpico su serranda aria esterna</td>
          </tr>
          <tr>
             <td colspan=3>$img_aria_variabile Controllo Portata Aria Variablie per aria canalizzata</td>
          </tr>
          <tr>
             <td>Valvole Termostatiche (rif. UNI EN 21)</td>
             <td>$img_valv_termostatiche_pres Presenti</td>
             <td>$img_valv_termostatiche_ass Assenti</td>
          </tr>
          <tr>
             <td>Valvole a due vie</td>
             <td>$img_valv_due_vie_pres Presenti</td>
             <td>$img_valv_due_vie_ass Assenti</td>
          </tr>
          <tr>
             <td>Valvole a tre vie</td>
             <td>$img_valv_tre_vie_pres Presenti</td>
             <td>$img_valv_tre_vie_ass Assenti</td>
          </tr>
          <tr>
             <td>Note: $regol_valv_note</td>
    </table><br><br><br>
</td>
</tr>
</table>"
}

db_foreach sel_aimp_rego "" {

append libretto "
    <table width=100%>
          <tr>
             <td>&nbsp;</td>
          </tr>
          <tr>
             <td align=center><b>5.3  Sistemi Telematici di Telelettura e Telegestione dell'impianto termico $cod_impianto_est_rego</b></td>
          </tr>
          <tr>
             <td>&nbsp;</td>
          </tr>
    </table>"

set img_telettura_pres    $img_unchecked
set img_telettura_ass     $img_unchecked
set img_telegestione_pres $img_unchecked
set img_telegestione_ass  $img_unchecked

if {$regol_telettura eq "P"} {
    set img_telettura_pres $img_checked
}
if {$regol_telettura eq "A"} {
    set img_telettura_ass $img_checked
}


if {$regol_telegestione eq "P"} {
    set img_telegestione_pres $img_checked
}
if {$regol_telegestione eq "A"} {
    set img_telegestione_ass $img_checked
}

    append libretto "
<table width=100% align=center>
<tr>
<td>
    <table width=100% align=center>
          <tr>
             <td colspan=2>Telelettura</td>
             <td>$img_telettura_pres Presenti</td>
             <td>$img_telettura_ass Assenti</td>
          </tr>
          <tr>
             <td colspan=2>Telegestione</td>
             <td>$img_telegestione_pres Presenti</td>
             <td>$img_telegestione_ass Assenti</td>
          </tr>
          <tr>
             <td colspan=4><br>Descrizione del sistema (situazione alla prima installazione o alla ristrutturazione dell'impianto termico $cod_impianto_est):</td><!--gac11-->
          </tr>
          <tr>
             <td colspan=4>$regol_desc_sistema_iniz</td>
          </tr>
          <tr>
             <td colspan=4><br>Data di sostituzione: $regol_data_sost_sistema</td>
          </tr>
          <tr>
             <td colspan=4><br>Descrizione del sistema (sostituzione del sistema):</td>
          </tr>
          <tr>
             <td colspan=4>$regol_desc_sistema_sost</td>
          </tr>
    </table><br><br><br>
</td>
</tr>
</table>"
}
db_foreach sel_aimp_rego "" {

    append libretto "
    <table width=100%>
          <tr>
             <td>&nbsp;</td>
          </tr>
          <tr>
             <td align=center><b>5.4 Contabilizzazione dell'impianto termico $cod_impianto_est_rego</b></td>
          </tr>
          <tr>
             <td>&nbsp;</td>
          </tr>
    </table>"

set img_contab_si  $img_unchecked
set img_contab_no  $img_unchecked
set img_risc       $img_unchecked
set img_raff       $img_unchecked
set img_acqua      $img_unchecked
set img_diretto    $img_unchecked
set img_indiretto  $img_unchecked
set img_risc_acqua $img_unchecked
set img_risc_raff       $img_unchecked;#rom12
set img_risc_raff_acqua $img_unchecked;#rom12
set img_raff_acqua      $img_unchecked;#rom12

if {$contab_si_no eq "S"} {
    set img_contab_si $img_checked
}
if {$contab_si_no eq "N"} {
    set img_contab_no $img_checked
}

if {$contab_tipo_contabiliz eq "R"} {
    set img_risc $img_checked
}

if {$contab_tipo_contabiliz eq "F"} {
    set img_raff $img_checked
}

if {$contab_tipo_contabiliz eq "A"} {
    set img_acqua $img_checked
}

if {$contab_tipo_contabiliz eq "E"} {
    set img_risc_acqua $img_checked
}

if {$contab_tipo_contabiliz eq "I"} {#rom12 if e contenuto
    set img_risc_raff $img_checked
}

if {$contab_tipo_contabiliz eq "O"} {#rom12 if e contenuto
    set img_risc_raff_acqua $img_checked
}

if {$contab_tipo_contabiliz eq "U"} {#rom12 if e contenuto
    set img_raff_acqua $img_checked
}

if {$contab_tipo_sistema eq "D"} {
    set img_diretto $img_checked
}

if {$contab_tipo_sistema eq "I"} {
    set img_indiretto $img_checked
}

    append libretto "
<table width=100% align=center>
<tr>
<td>
    <table width=100% align=center>
          <tr>
             <td colspan=2>Unità Immobiliari Contabilizzate</td>
             <td>$img_contab_si SI</td>
             <td>$img_contab_no NO</td>
             <td></td>
          </tr>
          <tr>
             <td colspan=5>&nbsp;</td>
          </tr>
          <tr>
             <td>Se contabilizzate:</td>
             <td>$img_risc Riscaldamento</td>
             <td>$img_raff Raffrescamento</td>
             <td>$img_acqua Acqua Calda San.</td>
             <td>$img_risc_acqua Risc./Acqua Calda San.</td>
          </tr>
          <tr><!--rom12 aggiunta tr e contenuto-->
             <td>&nbsp;</td>
             <td>$img_risc_raff Risc./Raffrescamento</td>
             <td>$img_risc_raff_acqua Risc./Raffresc./Acqua Calda San.</td>
             <td colspan=2>$img_raff_acqua Raffresc./Acqua Calda San.</td>
          </tr>
          <tr>
             <td colspan=5>&nbsp;</td>
          </tr>
          <tr>
             <td colspan=2>Tipologia sistema</td>
             <td>$img_diretto Diretto</td>
             <td>$img_indiretto Indiretto</td>
             <td></td>
          </tr>
          <tr>
             <td colspan=5><br>Descrizione del sistema (situazione alla prima installazione o alla ristrutturazione dell'impianto termico $cod_impianto_est):</td><!--gac11-->
          </tr>
          <tr>
             <td colspan=5>$contab_desc_sistema_iniz</td>
          </tr>
          <tr>
             <td colspan=5><br>Data di sostituzione: $contab_data_sost_sistema</td>
          </tr>
          <tr>
             <td colspan=5><br>Descrizione del sistema (sostituzione del sistema):</td>
          </tr>
          <tr>
             <td colspan=5>$contab_desc_sistema_sost</td>
          </tr>
    </table>
</td>
</tr>
</table>"
}

#gab02 Aggiunta sezione 6. SISTEMI DI DISTRIBUZIONE
append libretto "
    <!-- PAGE BREAK -->
    $table_con_header_per_tutte_le_pagine
"

append libretto "
    <table width=100% border=1>
       <tr>
          <td align=center bgcolor=\"E1E1E1\"><big><b>6. Sistemi di Distribuzione</b></big></td>
       </tr>
    </table>"

set img_verticale   $img_unchecked
set img_orizzontale $img_unchecked
set img_canali      $img_unchecked
set img_altro       $img_unchecked

if {$sistem_dist_tipo eq "V"} {
    set img_verticale   $img_checked
}
if {$sistem_dist_tipo eq "O"} {
    set img_orizzontale $img_checked
}
if {$sistem_dist_tipo eq "C"} {
    set img_canali      $img_checked
}
if {$sistem_dist_tipo eq "A"} {
    set img_altro       $img_checked
}

set sistem_dist_note_altro [iter_edit_crlf $sistem_dist_note_altro];#trasformo i crlf, etc... in <br>

append libretto "
    <table width=100% align=center>
       <tr>
          <td>&nbsp;</td>
       </tr>
       <tr>
          <td align=center><b>6.1 Tipo di distribuzione</b></td>
       </tr>
       <tr>
          <td>&nbsp;</td>
       </tr>
       <tr>
          <td>$img_verticale Verticale a colonne montanti</td>
       </tr>
       <tr>
          <td>$img_orizzontale Orizzontale a zone</td>
       </tr>
       <tr>
          <td>$img_canali Canali d'aria</td>
       </tr>
       <tr>
          <td>$img_altro Altro:<br>$sistem_dist_note_altro </td>
       </tr>
       <tr>
          <td>&nbsp;</td>
       <tr>
    </table>"

set img_assente  $img_unchecked
set img_presente $img_unchecked

if {$sistem_dist_coibentazione_flag eq "P"} {
    set img_presente $img_checked
}
if {$sistem_dist_coibentazione_flag eq "A"} {
    set img_assente $img_checked
}

set sistem_dist_note [iter_edit_crlf $sistem_dist_note];#trasformo i crlf, etc... in <br>

append libretto "
    <table width=100% align=center>
       <tr>
          <td align=center><b>6.2 Coibentazione rete di distribuzione</b></td>
       </tr>
       <tr>
          <td>&nbsp;</td>
       </tr>
       <tr>
          <td>$img_assente Assente</td>
       </tr>
       <tr>
          <td>$img_presente Presente</td>
       </tr>
       <tr>
          <td>Note:<br>$sistem_dist_note</td>
       </tr>
       <tr>
          <td>&nbsp;</td>
       <tr>"


set cod_vasi_espa_aimp ""
set num_vx ""
set capacita ""
set flag_aperto ""
set pressione ""

#rom25 Sposto nella foreach
#rom25append libretto "
#rom25    <table width=100% align=center>
#rom25       <tr>
#rom25          <td align=center colspan=3><b>6.3 Vasi di espansione</b></td>
#rom25       </tr>
#rom25       <tr>
#rom25          <td colspan=3>&nbsp;</td>
#rom25       </tr>"

foreach cod_impianto_vasi_espa $lista_cod_impianti {
    set cod_impianto_est_vasi_espa [db_string q "select cod_impianto_est as cod_impianto_est_vasi_espa from coimaimp where cod_impianto = :cod_impianto_vasi_espa"]
    append libretto "
    <table width=100% align=center>
       <tr>
          <td align=center colspan=3><b>6.3 Vasi di espansione dell'impianto termico $cod_impianto_est_vasi_espa</b></td>
       </tr>
       <tr>
          <td colspan=3>&nbsp;</td>
       </tr>"

db_foreach sel_vasi_espa "" {

    set img_aperto $img_unchecked
    set img_chiuso $img_unchecked
 
    if {$flag_aperto eq "A"} {
        set img_aperto $img_checked
    }
    if {$flag_aperto eq "C"} {
        set img_chiuso $img_checked
    }

    append libretto "
       <tr>
          <td>VX$num_vx - Capacit&agrave; $capacita (l)</td>
          <td>$img_aperto Aperto $img_chiuso Chiuso</td>
          <td>Pressione di precarica solo per vasi chiusi $pressione (bar)</td>
       </tr>"

} if_no_rows {

    append libretto "
       <tr>
          <td colspan=3>Non esiste alcun vaso di espansione</td>
       </tr>"
}
    append libretto "
       <tr>
         <td colspan=3>&nbsp;</td>
       </tr>
   </table>"
};#rom25 
#rom25append libretto "
#rom25       <tr>
#rom25          <td>&nbsp;</td>
#rom25       <tr>
#rom25   </table>"


#gab02 Aggiunta sezione 6.4 Pompe di Circolazione
set cod_pomp_circ_aimp ""
set num_po ""
set data_installaz ""
set data_dismissione  ""
set descr_cost ""
set modello ""
set flag_giri_variabili ""
set pot_nom ""


append libretto "
    <table width=100% align=center>
       <tr>
          <td align=center colspan=4><b>6.4 Pompe di Circolazione (se non incorporate nel generatore).
<!--rom25<br>Situazione alla prima installazione o alla ristrutturazione dell'impianto termico $cod_impianto_est</b></td>-->
       </tr>
       <tr>
          <td>&nbsp;</td>
       </tr>"

set num_po_cir "0"
db_foreach sel_pomp_circ "" {
    append libretto "
<table width=100% align=center>
      <tr>
         <td colspan=2 align=center>
            <table width=90% border=1>
                  <tr>
                     <td align=left width=20%>Pompa<br>PO $num_po</td>
                     <td align=left width=80%>Situazione alla prima installazione o alla ristrutturazione dell'impianto termico $cod_impianto_est_pomp_circ</td>
                  </tr>
                  <tr>
                     <td colspan=2>
                        <table width=100%>
                              <tr>
                                 <td align=left>Data di installazione</td>
                                 <td align=left>$data_installaz</td>
                                 <td align=left>Data di dismissione</td>
                                 <td align=left>$data_dismissione</td>
                              </tr>
                              <tr>
                                 <td align=left>Fabbricante</td>
                                 <td align=left>$descr_cost</td>
                                 <td align=left>Modello</td>
                                 <td align=left>$modello</td>
                              </tr>
                              <tr>
                                 <td align=left>Giri Variabili</td>
                                 <td align=left>$flag_giri_variabili</td>
                                 <td align=left>Potenza Nominale</td>
                                 <td align=left>$pot_nom (kW)</td>
                              </tr>
                        </table><br>
                     </td>
                  </tr>
            </table>  
         </td>
      </tr>"
    set num_po_cir "1"
} 
if {$num_po_cir eq "1"} {
append libretto "
    <table width=100% align=center>
       <tr>
          <td colspan=4>&nbsp;</td>
       </tr>
       <tr>
          <td align=center colspan=4><b>SOSTITUZIONE DEL COMPONENTE</b></td>
       </tr>
       <tr>
          <td>&nbsp;</td>
       </tr>"

db_foreach sel_pomp_circ_sost_comp "" {#rom07 aggiunta foreach e contenuto
    append libretto "
<table width=100% align=center>
      <tr>
         <td colspan=2 align=center>
            <table width=90% border=1>
                  <tr>
                     <td align=left width=20%>Pompa<br>PO $num_po_sost_comp</td>
                     <td align=left width=80%>Sostituzione del componente dell'impianto termico $cod_impianto_est_pomp_circ_sost_comp</td>
                  </tr>
                  <tr>
                     <td colspan=2>
                        <table width=100%>
                              <tr>
                                 <td align=left>Data di installazione</td>
                                 <td align=left>$data_installaz_sost_comp</td>
                                 <td align=left>Data di dismissione</td>
                                 <td align=left>$data_dismissione_sost_comp</td>
                              </tr>
                              <tr>
                                 <td align=left>Fabbricante</td>
                                 <td align=left>$descr_cost_sost_comp</td>
                                 <td align=left>Modello</td>
                                 <td align=left>$modello_sost_comp</td>
                              </tr>
                              <tr>
                                 <td align=left>Giri Variabili</td>
                                 <td align=left>$flag_giri_variabili_sost_comp</td>
                                 <td align=left>Potenza Nominale</td>
                                 <td align=left>$pot_nom_sost_comp (kW)</td>
                              </tr>
                        </table><br>
                     </td>
                  </tr>
            </table>  
         </td>
      </tr>"
};#rom07

#rom07<table width=100% align=center>
#rom07  <tr>
#rom07     <td colspan=2 align=center>
#rom07        <table width=90% border=1>
#rom07              <tr>
#rom07                 <td align=left colspan=2>Sostituzione del componente</td>
#rom07              </tr>
#rom07              <tr>
#rom07                 <td colspan=2>
#rom07                    <table width=100%>
#rom07                          <tr>
#rom07                             <td align=left>Data di installazione</td>
#rom07                             <td align=left>__________________</td>
#rom07                             <td align=left>Data di dismissione</td>
#rom07                             <td align=left>__________________</td>
#rom07                          </tr>
#rom07                          <tr>
#rom07                             <td align=left>Fabbricante</td>
#rom07                             <td align=left>__________________</td>
#rom07                             <td align=left>Modello</td>
#rom07                             <td align=left>__________________</td>
#rom07                          </tr>
#rom07                          <tr>
#rom07                             <td align=left>Giri Variabili</td>
#rom07                             <td align=left>__________________</td>
#rom07                             <td align=left>Potenza Nominale</td>
#rom07                             <td align=left>__________________ (kW)</td>
#rom07                          </tr>
#rom07                    </table><br>
#rom07                 </td>
#rom07              </tr>
#rom07        </table>
#rom07     </td>
#rom07  </tr>

} else {
    append libretto "
    <tr>
       <td colspan=4>Non esiste alcuna pompa di circolazione</td>
    </tr>"
}

append libretto "</table>"


#gab03 Aggiunta sezione 7. SISTEMA DI EMISSIONE
append libretto "
    <!-- PAGE BREAK -->
    $table_con_header_per_tutte_le_pagine
"

append libretto "
    <table width=100% border=1>
       <tr>
          <td align=center bgcolor=\"E1E1E1\"><big><b>7. Sistema di Emissione</b></big></td>
       </tr>
    </table>"


#rom25 Aggiunta foreach
foreach cod_impianto_scheda7 $lista_cod_impianti {

    db_foreach q "select coalesce(sistem_emis_radiatore         , 'N') as sistem_emis_radiatore_scheda7
                       , coalesce(sistem_emis_termoconvettore   , 'N') as sistem_emis_termoconvettore_scheda7
                       , coalesce(sistem_emis_ventilconvettore  , 'N') as sistem_emis_ventilconvettore_scheda7
                       , coalesce(sistem_emis_pannello_radiante , 'N') as sistem_emis_pannello_radiante_scheda7
                       , coalesce(sistem_emis_bocchetta         , 'N') as sistem_emis_bocchetta_scheda7
                       , coalesce(sistem_emis_striscia_radiante , 'N') as sistem_emis_striscia_radiante_scheda7
                       , coalesce(sistem_emis_trave_fredda      , 'N') as sistem_emis_trave_fredda_scheda7
                       , coalesce(sistem_emis_altro             , 'N') as sistem_emis_altro_scheda7
                       , coalesce(sistem_emis_note_altro   , '&nbsp;') as sistem_emis_note_altro_scheda7
                       , cod_impianto_est                              as cod_impianto_est_scheda7
                    from coimaimp
                   where cod_impianto = :cod_impianto_scheda7
    " {
	
		           
set img_radiatori           $img_unchecked
set img_termoconvettori     $img_unchecked
set img_ventilconvettori    $img_unchecked
set img_pannelli            $img_unchecked
set img_bocchette           $img_unchecked
set img_strisce             $img_unchecked
set img_travi               $img_unchecked
set img_altro               $img_unchecked


#rom10if {$sistem_emis_tipo eq "R"} {
#    set img_radiatori        $img_checked
#}
#if {$sistem_emis_tipo eq "T"} {
#    set img_termoconvettori  $img_checked
#}
#if {$sistem_emis_tipo eq "V"} {
#    set img_ventilconvettori $img_checked
#}
#if {$sistem_emis_tipo eq "P"} {
#    set img_pannelli         $img_checked
#}
#if {$sistem_emis_tipo eq "B"} {
#    set img_bocchette        $img_checked
#}
#if {$sistem_emis_tipo eq "S"} {
#    set img_strisce          $img_checked
#}
#if {$sistem_emis_tipo eq "F"} {
#    set img_travi            $img_checked
#}
#if {$sistem_emis_tipo eq "A"} {
#    set img_altro           $img_checked
#rom10}


if {$sistem_emis_radiatore_scheda7 eq "S"} {#rom10 if e contenuto
    set img_radiatori        $img_checked
}
if {$sistem_emis_termoconvettore_scheda7 eq "S"} {#rom10 if e contenuto
    set img_termoconvettori  $img_checked
}
if {$sistem_emis_ventilconvettore_scheda7 eq "S"} {#rom10 if e contenuto
    set img_ventilconvettori $img_checked
}
if {$sistem_emis_pannello_radiante_scheda7 eq "S"} {#rom10 if e contenuto
    set img_pannelli         $img_checked
}
if {$sistem_emis_bocchetta_scheda7 eq "S"} {#rom10 if e contenuto
    set img_bocchette        $img_checked
}
if {$sistem_emis_striscia_radiante_scheda7 eq "S"} {#rom10 if e contenuto
    set img_strisce          $img_checked
}
if {$sistem_emis_trave_fredda_scheda7 eq "S"} {#rom10 if e contenuto
    set img_travi            $img_checked
}
if {$sistem_emis_altro_scheda7 eq "S"} {#rom10 if e contenuto
    set img_altro           $img_checked
}


set sistem_emis_note_altro [iter_edit_crlf $sistem_emis_note_altro_scheda7];#trasformo i crlf, etc... in <br>

append libretto "
    <table width=100% align=center>
       <tr>
          <td>&nbsp;</td>
       </tr>
       <tr>
          <td><b>Sistema di emissione dell'impianto termico $cod_impianto_est_scheda7</b></td>
       </tr>
          <tr>
             <td>$img_radiatori Radiatori</td>
          </tr>
          <tr>
             <td>$img_termoconvettori Termoconvettori</td>
          </tr>
          <tr>
             <td>$img_ventilconvettori Ventilconvettori</td>
          </tr>
           <tr>
             <td>$img_pannelli Pannelli Radianti</td>
          </tr>
          <tr>
             <td>$img_bocchette Bocchette</td>
          </tr>
          <tr>
             <td>$img_strisce Strisce Radianti</td>
          </tr>
          <tr>
             <td>$img_travi Travi Fredde</td>
          </tr>
          <tr>
             <td>$img_altro Altro: <u>$sistem_emis_note_altro</u> </td>
          </tr>
          <tr>
             <td>&nbsp;</td>
          <tr>
    </table>"

};#rom25 fine db_foreach

};#rom25 fine foreach su cod_impianto_scheda7

#gab03 Aggiunta sezione 8. SISTEMA DI ACCUMULO
append libretto "
    <!-- PAGE BREAK -->
    $table_con_header_per_tutte_le_pagine
"

append libretto "
    <table width=100% border=1>
          <tr>
             <td align=center bgcolor=\"E1E1E1\"><big><b>8. Sistema di Accumulo</b></big></td>
          </tr>
    </table>"
 
append libretto "
    <table width=100% align=center>
          <tr>
             <td colspan=4>&nbsp;</td>
          </tr>
       <tr>
          <td align=center colspan=4><b>8.1 Accumuli (se non incorporati nel gruppo termico o caldaia).
<br>Situazione alla prima installazione o alla ristrutturazione dell'impianto termico $cod_impianto_est</b></td><!--gac11-->
       </tr>
       <tr>
          <td colspan=4>&nbsp;</td>
       </tr>
</table>"

set sw_accu "f"

db_foreach sel_accu "" {
    regsub -all {<} $matricola {\&lt;} matricola;#sim07
    regsub -all {>} $matricola {\&gt;} matricola;#sim07

set img_acq_calda           $img_unchecked
set img_riscalda            $img_unchecked
set img_raffredda           $img_unchecked

    if {$utilizzo_codice eq "A"} {
	set img_acq_calda $img_checked
    }

    if {$utilizzo_codice eq "R"} {
	set img_riscalda  $img_checked
    }

    if {$utilizzo_codice eq "F"} {
	set img_raffredda $img_checked
    }

    set img_coib_assente  $img_unchecked;#rom10
    set img_coib_presente $img_unchecked;#rom10

    if {$coibentazione eq "N"} {#rom10 if e contenuto
	set img_coib_assente  $img_checked
    }
    if {$coibentazione eq "S"} {#rom10 if e contenuto
	set img_coib_presente $img_checked
    }

    append libretto "
            <table width=100% border=1>
                  <tr>
                     <td align=left width=20%>Accumolo<br>AC $num_ac</td>
                     <td align=left width=80%>Situazione alla prima installazione o alla ristrutturazione dell'impianto termico $cod_impianto_est</td><!--gac11-->
                  </tr>
                  <tr>
                     <td colspan=2>
                        <table width=100% border=0>
       <tr>
          <td align=left>Data Installazione</td>
          <td align=left>$data_installaz</td>
          <td align=left>Data Dismissione</td>
          <td align=left>$data_dismissione</td>
       </tr>
       <tr>
          <td align=left>Fabbricante</td>
          <td align=left>$descr_cost</td>
          <td align=left>Modello</td>
          <td align=left>$modello</td>
       </tr>
       <tr>
          <td align=left>Matricola</td>
          <td align=left>$matricola</td>
          <td align=left>Capacit&agrave;</td>
          <td align=left>$capacita</td>
       </tr>
      <tr>
          <td colspan=4>&nbsp;</td>
       </tr>
       <tr>
          <td align=left>$img_acq_calda Acqua calda sanitaria<br>
                         $img_riscalda Riscaldamento<br>
                         $img_raffredda Raffreddamento
          </td>
          <td>&nbsp;</td><!--rom10-->
          <td align=left valign=top>Coibentazione:</td> <!--rom10-->
          <td align=left valign=top>$img_coib_assente Assente<br><!--rom10-->
                                    $img_coib_presente Presente<!--rom10-->
          </td>
      </tr>
</table>
</td>
</tr>
</table>
<br>"

    set sw_accu "t"
}

if {$sw_accu eq "t"} {
    append libretto "
    <table width=100%>
          <tr>
             <td colspan=2>&nbsp;</td>
          </tr>
          <tr>
             <td colspan=2><b>SOSTITUZIONI DEL COMPONENTE</b></td>
          </tr>
          <tr>
             <td colspan=2>&nbsp;</td>
          </tr>
    </table>"         

db_foreach sel_accu_sost_comp "" {#rom07 aggiunta foreach e contenuto
    regsub -all {<} $matricola_sost_comp {\&lt;} matricola_sost_comp
    regsub -all {>} $matricola_sost_comp {\&gt;} matricola_sost_comp

    set img_acq_calda_sost_comp $img_unchecked
    set img_riscalda_sost_comp  $img_unchecked
    set img_raffredda_sost_comp $img_unchecked
    
    if {$utilizzo_codice_sost_comp eq "A"} {
	set img_acq_calda_sost_comp $img_checked
    }
    
    if {$utilizzo_codice_sost_comp eq "R"} {
	set img_riscalda_sost_comp  $img_checked
    }

    if {$utilizzo_codice_sost_comp eq "F"} {
	set img_raffredda_sost_comp $img_checked
    }
    
    set img_coib_assente_sost  $img_unchecked;#rom10
    set img_coib_presente_sost $img_unchecked;#rom10

    if {$coibentazione_sost_comp eq "N"} {#rom10 if e contenuto
	set img_coib_assente_sost  $img_checked
    }
    if {$coibentazione_sost_comp eq "S"} {#rom10 if e contenuto
	set img_coib_presente_sost $img_checked
    }
	
    append libretto "
            <table width=100% border=1>
                  <tr>
                     <td align=left width=20%>Accumolo<br>AC $num_ac_sost_comp</td>
                     <td align=left width=80%>Sostituzione del componente</td>
                  </tr>
                  <tr>
                     <td colspan=2>
                        <table width=100%>
       <tr>
          <td align=left>Data Installazione</td>
          <td align=left>$data_installaz_sost_comp</td>
          <td align=left>Data Dismissione</td>
          <td align=left>$data_dismissione_sost_comp</td>
       </tr>
       <tr>
          <td align=left>Fabbricante</td>
          <td align=left>$descr_cost_sost_comp</td>
          <td align=left>Modello</td>
          <td align=left>$modello_sost_comp</td>
       </tr>
       <tr>
          <td align=left>Matricola</td>
          <td align=left>$matricola_sost_comp</td>
          <td align=left>Capacit&agrave;</td>
          <td align=left>$capacita_sost_comp</td>
       </tr>
      <tr>
          <td colspan=4>&nbsp;</td>
       </tr>
       <tr>
          <td align=left>$img_acq_calda_sost_comp Acqua calda sanitaria<br>
                         $img_riscalda_sost_comp Riscaldamento<br>
                         $img_raffredda_sost_comp Raffreddamento
          </td>
          <td>&nbsp;</td><!--rom10-->
          <td align=left valign=top>Coibentazione:</td> <!--rom10-->
          <td align=left valign=top>$img_coib_assente_sost Assente<br><!--rom10-->
                                    $img_coib_presente_sost Presente<!--rom10-->
          </td>
      </tr>
</table>
</td>
</tr>
</table><br> "

};#rom07

    #rom07<tr>
    #rom07   <td colspan=2>&nbsp;</td>
    #rom07</tr>
    #rom07<tr>
    #rom07   <td>Data di installazione _________________</td>
    #rom07   <td>Data di dismissione _________________</td>
    #rom07</tr>
    #rom07<tr> 
    #rom07   <td>Fabbricante _________________</td>
    #rom07   <td>Modello _________________</td>
    #rom07 </tr>
    #rom07 <tr>
    #rom07    <td>Matricola _________________</td>
    #rom07    <td>Capacit&agrave; _________________ (l)</td>
    #rom07 </tr>
    #rom07 <tr>
    #rom07    <td valign=top>Utilizzo:<br>
    #rom07    <br>
    #rom07   $img_unchecked Acqua calda sanitaria<br> 
    #rom07    $img_unchecked Riscaldamento<br>
    #rom07    $img_unchecked Raffreddamento</td>
    #rom07    <td valign=top>Coibentazione:<br>
    #rom07    <br>
    #rom07    $img_unchecked Assente<br>
    #rom07    $img_unchecked Presente</td>
             
    #rom07 </tr>
          
    #rom07 <tr>
    #rom07    <td colspan=2>&nbsp;</td>
    #rom07 </tr>
    #rom07 <tr>
    #rom07    <td>Data di installazione _________________</td>
    #rom07    <td>Data di dismissione _________________</td>
    #rom07 </tr>
    #rom07 <tr>
    #rom07    <td>Fabbricante _________________</td>
    #rom07    <td>Modello _________________</td>
    #rom07 </tr>
    #rom07 <tr>
    #rom07    <td>Matricola_________________</td>
    #rom07    <td>Capacit&agrave;_________________ (l)</td>
    #rom07 </tr>
    #rom07 <tr>
    #rom07    <td valign=top>Utilizzo:<br>
    #rom07    <br>
    #rom07    $img_unchecked Acqua calda sanitaria<br> 
    #rom07    $img_unchecked Riscaldamento<br>
    #rom07    $img_unchecked Raffreddamento</td>
    #rom07    <td valign=top>Coibentazione:<br>
    #rom07    <br>
    #rom07    $img_unchecked Assente<br>
    #rom07    $img_unchecked Presente</td>
    #rom07 </tr>

    #rom07 <tr>
    #rom07    <td colspan=2>&nbsp;</td>
    #rom07 </tr>
    #rom07 <tr>
    #rom07    <td>Data di installazione _________________</td>
    #rom07    <td>Data di dismissione _________________</td>
    #rom07 </tr>
    #rom07 <tr> 
    #rom07    <td>Fabbricante _________________</td>
    #rom07    <td>Modello _________________</td>
    #rom07 </tr>
    #rom07 <tr>
    #rom07    <td>Matricola _________________</td>
    #rom07    <td>Capacit&agrave; _________________ (l)</td>
    #rom07 </tr>
    #rom07 <tr>
    #rom07    <td valign=top>Utilizzo:<br>
    #rom07    <br>
    #rom07    $img_unchecked Acqua calda sanitaria<br> 
    #rom07    $img_unchecked Riscaldamento<br>
    #rom07    $img_unchecked Raffreddamento</td>
    #rom07    <td valign=top>Coibentazione:<br>
    #rom07    <br>
    #rom07    $img_unchecked Assente<br>
    #rom07    $img_unchecked Presente</td>
    #rom07 </tr>
          
    #rom07 <tr>
    #rom07    <td colspan=2>&nbsp;</td>
    #rom07 </tr>
    #rom07 <tr>
    #rom07    <td>Data di installazione _________________</td>
    #rom07    <td>Data di dismissione _________________</td>
    #rom07 </tr>
    #rom07 <tr>
    #rom07    <td>Fabbricante _________________</td>
    #rom07    <td>Modello _________________</td>
    #rom07 </tr>
    #rom07 <tr>
    #rom07    <td>Matricola_________________</td>
    #rom07    <td>Capacit&agrave; _________________ (l)</td>
    #rom07 </tr>
    #rom07 <tr>
    #rom07    <td valign=top>Utilizzo:<br>
     #rom07   <br>
   #rom07     $img_unchecked Acqua calda sanitaria<br> 
    #rom07    $img_unchecked Riscaldamento<br>
    #rom07    $img_unchecked Raffreddamento</td>
    #rom07    <td valign=top>Coibentazione:<br>
    #rom07    <br>
    #rom07    $img_unchecked Assente<br>
    #rom07    $img_unchecked Presente</td>
    #rom07 </tr>
    #rom07</table>

} else {
    append libretto "
    <tr>
       <td colspan=4>Non esiste alcun accumulo</td>
    </tr>
    </table>"
}


#gab03 Aggiunta sezione 9 ALTRI COMPONENTI DELL'IMPIANTO
append libretto "
    <!-- PAGE BREAK -->
    $table_con_header_per_tutte_le_pagine
"

append libretto "
    <table width=100% border=1>
          <tr>
             <td align=center bgcolor=\"E1E1E1\"><big><b>9. Altri Componenti dell' Impianto</b></big></td>
          </tr>
    </table>"


append libretto "
    <table width=100% align=center>
       <tr>
          <tr>
             <td colspan=4>&nbsp;</td>
          </tr>
          <td align=center colspan=4><b>9.1 Torri Evaporative
<br>Situazione alla prima installazione o alla ristrutturazione dell'impianto termico $cod_impianto_est</b></td><!--gac11-->
       </tr>
       <tr>
             <td colspan=4>&nbsp;</td>
       </tr>
     </table>"

set sw_torr_evap "f"

db_foreach sel_torr_evap_aimp "" {
    regsub -all {<} $matricola {\&lt;} matricola;#sim07
    regsub -all {>} $matricola {\&gt;} matricola;#sim07
    append libretto "
            <table width=100% border=1>
                  <tr>
                     <td align=left width=20%>Torre<br>TE $num_te</td>
                     <td align=left width=80%>Situazione alla prima installazione o alla ristrutturazione dell'impianto termico $cod_impianto_est</td><!--gac11-->
                  </tr>
                  <tr>
                     <td colspan=2>
                        <table width=100%>
       <tr>
          <td align=left>Data Installazione</td>
          <td align=left>$data_installaz</td>
          <td align=left>Data Dismissione</td>
          <td align=left>$data_dismissione</td>
       </tr>
       <tr>
          <td align=left>Fabbricante</td>
          <td align=left>$descr_cost</td>
          <td align=left>Modello</td>
          <td align=left>$modello</td>
       </tr>
       <tr>
          <td align=left>Matricola</td>
          <td align=left>$matricola</td>
          <td align=left>Capacit&agrave; nominale</td>
          <td align=left>$capacita</td>
       </tr>
       <tr>
          <td align=left>Numero Ventilatori</td>
          <td align=left>$num_ventilatori</td>
          <td align=left>Tipo Ventilatori</td>
          <td align=left>$tipi_ventilatori</td>
       </tr>
       </table>
</td>
</tr>
</table>
<br>"

    set sw_torr_evap "t"
}

if {$sw_torr_evap eq "t"} {
    append libretto "</table>
    <table width=100%>
          <tr>
             <td colspan=2>&nbsp;</td>
          </tr>
          <tr>
             <td colspan=2><b>SOSTITUZIONI DEL COMPONENTE</b></td>
          </tr>         
          <tr>
             <td colspan=2>&nbsp;</td>
          </tr>
     </table>"

db_foreach sel_torr_evap_aimp_sost_comp "" {#rom07 aggiunta foreache contenuto
    regsub -all {<} $matricola_sost_comp {\&lt;} matricola_sost_comp
    regsub -all {>} $matricola_sost_comp {\&gt;} matricola_sost_comp
    append libretto "
            <table width=100% border=1>
                  <tr>
                     <td align=left width=20%>Torre<br>TE $num_te_sost_comp</td>
                     <td align=left width=80%>Sostituzione del componente</td>
                  </tr>
                  <tr>
                     <td colspan=2>
                        <table width=100%>
       <tr>
          <td align=left>Data Installazione</td>
          <td align=left>$data_installaz_sost_comp</td>
          <td align=left>Data Dismissione</td>
          <td align=left>$data_dismissione_sost_comp</td>
       </tr>
       <tr>
          <td align=left>Fabbricante</td>
          <td align=left>$descr_cost_sost_comp</td>
          <td align=left>Modello</td>
          <td align=left>$modello_sost_comp</td>
       </tr>
       <tr>
          <td align=left>Matricola</td>
          <td align=left>$matricola_sost_comp</td>
          <td align=left>Capacit&agrave; nominale</td>
          <td align=left>$capacita_sost_comp</td>
       </tr>
       <tr>
          <td align=left>Numero Ventilatori</td>
          <td align=left>$num_ventilatori_sost_comp</td>
          <td align=left>Tipo Ventilatori</td>
          <td align=left>$tipi_ventilatori_sost_comp</td>
       </tr>
       </table>
</td>
</tr>
</table><br>"
};#rom07

    #rom07<tr>
    #rom07<td colspan=2>&nbsp;</td>
    #rom07</tr>
    #rom07<tr>
    #rom07<td>Data di installazione _________________</td>
    #rom07<td>Data di dismissione _________________</td>
    #rom07</tr>
    #rom07<tr> 
    #rom07<td>Fabbricante _________________</td>
    #rom07<td>Modello _________________</td>
    #rom07</tr>
    #rom07<tr>
    #rom07<td>Matricola _________________</td>
    #rom07<td>Capacit&agrave; nominale _________________ (l)</td>
    #rom07</tr>
    #rom07<tr>
    #rom07<td>Numero ventilatori_________________</td>
    #rom07<td>Tipo ventilatori_________________</td>              
    #rom07</tr>
    
    #rom07<tr>
    #rom07<td colspan=2>&nbsp;</td>
    #rom07</tr>
    #rom07<tr>
    #rom07<td>Data di installazione _________________</td>
    #rom07<td>Data di dismissione _________________</td>
    #rom07</tr>
    #rom07<tr>
    #rom07<td>Fabbricante _________________</td>
    #rom07<td>Modello _________________</td>
    #rom07</tr>
    #rom07      <tr>
    #rom07<td>Matricola_________________</td>
    #rom07<td>Capacit&agrave; nominale_________________ (l)</td>
    #rom07</tr>
    #rom07<tr>
    #rom07         <td>Numero ventilatori_________________</td>
    #rom07<td>Tipo ventilatori_________________</td>
    #rom07</tr>
    
    #rom07<tr>
    #rom07<td colspan=2>&nbsp;</td>
    #rom07</tr>
    #rom07<tr>
    #rom07<td>Data di installazione _________________</td>
    #rom07<td>Data di dismissione _________________</td>
    #rom07</tr>
    #rom07<tr> 
    #rom07<td>Fabbricante _________________</td>
    #rom07<td>Modello _________________</td>
    #rom07</tr>
    #rom07<tr>
    #rom07<td>Matricola _________________</td>
    #rom07<td>Capacit&agrave; nominale_________________ (l)</td>
    #rom07</tr>
    #rom07<tr>
    #rom07<td>Numero ventilatori _________________</td>
    #rom07<td>Tipo ventilatori_________________</td>
    #rom07</tr>
    
    #rom07      <tr>
    #rom07<td colspan=2>&nbsp;</td>
    #rom07</tr>
    #rom07<tr>
    #rom07<td>Data di installazione _________________</td>
    #rom07<td>Data di dismissione _________________</td>
    #rom07</tr>
    #rom07<tr>
    #rom07         <td>Fabbricante _________________</td>
    #rom07<td>Modello _________________</td>
    #rom07</tr>
    #rom07      <tr>
    #rom07<td>Matricola_________________</td>
    #rom07<td>Capacit&agrave; nominale_________________ (l)</td>
    #rom07</tr>
    #rom07<tr>
    #rom07<td>Numero ventilatori_________________</td>
    #rom07         <td>Tipo ventilatori_________________</td>
    #rom07</tr>
    #rom07</table>"

} else {
    append libretto "
    <tr>
       <td colspan=4>Non esiste alcuna torre evaporativa</td>
    </tr>
    </table>"
}

append libretto "
    <!-- PAGE BREAK -->
    $table_con_header_per_tutte_le_pagine
"
append libretto "
    <table width=100% border=1>
          <tr>
             <td align=center bgcolor=\"E1E1E1\"><big><b>9. Altri Componenti dell' Impianto</b></big></td>
          </tr>
    </table>"

append libretto "
    <table width=100% align=center>
       <tr>
          <td colspan=4>&nbsp;</td>
       </tr>
       <tr>
          <td align=center colspan=4><b>9.2 Raffreddatori di Liquido (a circuito chiuso)
       </tr>
       <tr>
          <td colspan=4>&nbsp;</td>
       </tr>
       </table>"

set sw_raff "f"

db_foreach sel_raff_aimp "" {
    regsub -all {<} $matricola {\&lt;} matricola;#sim07
    regsub -all {>} $matricola {\&gt;} matricola;#sim07
    append libretto "
            <table width=100% border=1>
                  <tr>
                     <td align=left width=20%>Raffreddatore<br>RV $num_rv</td>
                     <td align=left width=80%>Situazione alla prima installazione o alla ristrutturazione dell'impianto termico $cod_impianto_est</td><!--gac11-->
                  </tr>
                  <tr>
                     <td colspan=2>
                        <table width=100%>
       <tr>
          <td align=left>Data installazione</td>
          <td align=left>$data_installaz</td>
          <td align=left>Data Dismissione</td>
          <td align=left>$data_dismissione</td>
       </tr>
       <tr>
          <td align=left>Fabbricante</td>
          <td align=left>$descr_cost</td>
          <td align=left>Modello</td>
          <td align=left>$modello</td>
       </tr>
       <tr>
          <td align=left>Matricola</td>
          <td align=left colspan=3>$matricola</td>
       </tr>
       <tr>
          <td align=left>Num. Ventilatori</td>
          <td align=left>$num_ventilatori</td>
          <td align=left>Tipo Ventilatori</td>
          <td align=left>$tipi_ventilatori</td>
       </tr>
       </table>
</td>
</tr>
</table>
<br>"

    set sw_raff "t"
}


if {$sw_raff eq "t"} {
    append libretto "</table>
    <table width=100%>
          <tr>
             <td colspan=2>&nbsp;</td>
          </tr>
          <tr>
             <td colspan=2><b>SOSTITUZIONI DEL COMPONENTE</b></td>
          </tr>         
          <tr>
             <td colspan=2>&nbsp;</td>
          </tr>
     </table>"

    db_foreach sel_raff_aimp_sost_comp "" {#rom07 aggiunto foreach e contenuto
	regsub -all {<} $matricola_sost_comp {\&lt;} matricola_sost_comp
	regsub -all {>} $matricola_sost_comp {\&gt;} matricola_sost_comp
	append libretto "
            <table width=100% border=1>
                  <tr>
                     <td align=left width=20%>Raffreddatore<br>RV $num_rv_sost_comp</td>
                     <td align=left width=80%>Sosotituzione del componente</td>
                  </tr>
                  <tr>
                     <td colspan=2>
                        <table width=100%>
       <tr>
          <td align=left>Data installazione</td>
          <td align=left>$data_installaz_sost_comp</td>
          <td align=left>Data Dismissione</td>
          <td align=left>$data_dismissione_sost_comp</td>
       </tr>
       <tr>
          <td align=left>Fabbricante</td>
          <td align=left>$descr_cost_sost_comp</td>
          <td align=left>Modello</td>
          <td align=left>$modello_sost_comp</td>
       </tr>
       <tr>
          <td align=left>Matricola</td>
          <td align=left colspan=3>$matricola_sost_comp</td>
       </tr>
       <tr>
          <td align=left>Num. Ventilatori</td>
          <td align=left>$num_ventilatori_sost_comp</td>
          <td align=left>Tipo Ventilatori</td>
          <td align=left>$tipi_ventilatori_sost_comp</td>
       </tr>
       </table>
</td>
</tr>
</table><br>"
};#rom07

#rom07     <tr>
#rom07        <td colspan=2>&nbsp;</td>
#rom07     </tr>
#rom07     <tr>
#rom07        <td>Data di installazione _________________</td>
#rom07        <td>Data di dismissione _________________</td>
#rom07     </tr>
#rom07     <tr> 
#rom07        <td>Fabbricante _________________</td>
#rom07        <td>Modello _________________</td>
#rom07     </tr>
#rom07     <tr>
#rom07        <td>Matricola _________________</td>
#rom07     </tr>
#rom07     <tr>
#rom07        <td>Numero ventilatori_________________</td>
#rom07        <td>Tipo ventilatori_________________</td>              
#rom07     </tr>
#rom07     <tr>
#rom07        <td colspan=2>&nbsp;</td>
#rom07     </tr>
#rom07     <tr>
#rom07        <td>Data di installazione _________________</td>
#rom07        <td>Data di dismissione _________________</td>
#rom07     </tr>
#rom07     <tr> 
#rom07        <td>Fabbricante _________________</td>
#rom07        <td>Modello _________________</td>
#rom07     </tr>
#rom07     <tr>
#rom07        <td>Matricola _________________</td>
#rom07     </tr>
#rom07     <tr>
#rom07        <td>Numero ventilatori_________________</td>
#rom07        <td>Tipo ventilatori_________________</td>              
#rom07     </tr>
#rom07     <tr>
#rom07        <td colspan=2>&nbsp;</td>
#rom07     </tr>
#rom07     <tr>
#rom07        <td>Data di installazione _________________</td>
#rom07        <td>Data di dismissione _________________</td>
#rom07     </tr>
#rom07     <tr> 
#rom07        <td>Fabbricante _________________</td>
#rom07        <td>Modello _________________</td>
#rom07     </tr>
#rom07     <tr>
#rom07        <td>Matricola _________________</td>
#rom07     </tr>
#rom07     <tr>
#rom07        <td>Numero ventilatori_________________</td>
#rom07        <td>Tipo ventilatori_________________</td>              
#rom07     </tr>
#rom07     <tr>
#rom07        <td colspan=2>&nbsp;</td>
#rom07     </tr>
#rom07     <tr>
#rom07        <td>Data di installazione _________________</td>
#rom07        <td>Data di dismissione _________________</td>
#rom07     </tr>
#rom07     <tr> 
#rom07        <td>Fabbricante _________________</td>
#rom07        <td>Modello _________________</td>
#rom07     </tr>
#rom07     <tr>
#rom07        <td>Matricola _________________</td>
#rom07     </tr>
#rom07     <tr>
#rom07        <td>Numero ventilatori_________________</td>
#rom07        <td>Tipo ventilatori_________________</td>              
#rom07     </tr>
#rom07</table>

} else {
    append libretto "
    <tr>
       <td colspan=4>Non esiste alcun raffreddatore di liquido</td>
    </tr>
    </table>"
}

append libretto "
    <!-- PAGE BREAK -->
    $table_con_header_per_tutte_le_pagine
"

append libretto "
    <table width=100% border=1>
          <tr>
             <td align=center bgcolor=\"E1E1E1\"><big><b>9. Altri Componenti dell' Impianto</b></big></td>
          </tr>
    </table>"


append libretto "
    <table width=100% align=center>
       <tr>
          <td colspan=4>&nbsp;</td>
       </tr>
       <tr>
          <td align=center colspan=4><b>9.3 Scambiatori di Calore Intermedi (per acqua di superficie o di falda)
       </tr>
       <tr>
          <td colspan=4>&nbsp;</td>
       </tr>
   </table>"

set sw_scam_calo "f"

db_foreach sel_scam_calo_aimp "" {
    append libretto "
 <table width=100% border=1>
       <tr>
          <td align=left width=20%>Scambiatore<br>SC $num_sc</td>
          <td align=left width=80%>Situazione alla prima installazione o alla ristrutturazione dell'impianto termico $cod_impianto_est</td><!--gac11-->
       </tr>
       <tr>
          <td colspan=2>
             <table width=100%>
       <tr>
          <td align=left>Data Installazione</td>
          <td align=left>$data_installaz</td>
          <td align=left>Data Dismissione</td>
          <td align=left>$data_dismissione</td>
       </tr>
       <tr>
          <td align=left>Fabbricante</td>
          <td align=left>$descr_cost</td>
          <td align=left>Modello</td>
          <td align=left>$modello</td>
       </tr>
       </table>
</td>
</tr>
</table>
<br>
"

    set sw_scam_calo "t"
}


if {$sw_scam_calo eq "t"} {
    append libretto "</table>
    <table width=100%>
          <tr>
             <td colspan=2>&nbsp;</td>
          </tr>
          <tr>
             <td colspan=2><b>SOSTITUZIONI DEL COMPONENTE</b></td>
          </tr>         
          <tr>
             <td colspan=2>&nbsp;</td>
          </tr>
    </table>"


db_foreach sel_scam_calo_aimp_sost_comp "" {#rom07 aggiunta foreach e contenuto
    append libretto "
 <table width=100% border=1>
       <tr>
          <td align=left width=20%>Scambiatore<br>SC $num_sc_sost_comp</td>
          <td align=left width=80%>Sostituzione del componente</td>
       </tr>
       <tr>
          <td colspan=2>
             <table width=100%>
       <tr>
          <td align=left>Data Installazione</td>
          <td align=left>$data_installaz_sost_comp</td>
          <td align=left>Data Dismissione</td>
          <td align=left>$data_dismissione_sost_comp</td>
       </tr>
       <tr>
          <td align=left>Fabbricante</td>
          <td align=left>$descr_cost_sost_comp</td>
          <td align=left>Modello</td>
          <td align=left>$modello_sost_comp</td>
       </tr>
       </table>
</td>
</tr>
</table><br>"
};#rom07



#rom07     <tr>
#rom07        <td colspan=2>&nbsp;</td>
#rom07     </tr>
#rom07     <tr>
#rom07        <td>Data di installazione _________________</td>
#rom07        <td>Data di dismissione _________________</td>
#rom07     </tr>
#rom07     <tr> 
#rom07        <td>Fabbricante _________________</td>
#rom07        <td>Modello _________________</td>
#rom07     </tr>

#rom07     <tr>
#rom07        <td colspan=2>&nbsp;</td>
#rom07     </tr>
#rom07     <tr>
#rom07        <td>Data di installazione _________________</td>
#rom07        <td>Data di dismissione _________________</td>
#rom07     </tr>
#rom07     <tr> 
#rom07        <td>Fabbricante _________________</td>
#rom07        <td>Modello _________________</td>
#rom07     </tr>

#rom07     <tr>
#rom07        <td colspan=2>&nbsp;</td>
#rom07     </tr>
#rom07     <tr>
#rom07        <td>Data di installazione _________________</td>
#rom07        <td>Data di dismissione _________________</td>
#rom07     </tr>
#rom07     <tr> 
#rom07        <td>Fabbricante _________________</td>
#rom07        <td>Modello _________________</td>
#rom07     </tr>

#rom07     <tr>
#rom07        <td colspan=2>&nbsp;</td>
#rom07     </tr>
#rom07     <tr>
#rom07        <td>Data di installazione _________________</td>
#rom07        <td>Data di dismissione _________________</td>
#rom07     </tr>
#rom07     <tr> 
#rom07        <td>Fabbricante _________________</td>
#rom07        <td>Modello _________________</td>
#rom07     </tr>
#rom07</table>

} else {
    append libretto "
    <tr>
       <td colspan=4>Non esiste alcuno scambiatore di calore intermedio</td>
    </tr>
    </table>"
}

append libretto "
    <!-- PAGE BREAK -->
    $table_con_header_per_tutte_le_pagine
"
append libretto "
    <table width=100% border=1>
          <tr>
             <td align=center bgcolor=\"E1E1E1\"><big><b>9. Altri Componenti dell' Impianto</b></big></td>
          </tr>
    </table>"

append libretto "
    <table width=100% align=center>
          <tr>
             <td>&nbsp;</td>
          </tr>
          <tr>
             <td align=center colspan=4><b>9.4 Circuiti Interrati a Condensazione / Espansione Diretta
          </tr>
          <tr>
             <td colspan=4>&nbsp;</td>
       </tr>
    </table>"

set sw_circ_inte "f"

db_foreach sel_circ_inte "" {
    append libretto "
            <table width=100% border=1>
                  <tr>
                     <td align=left  width=20%>Circuito<br>CI $num_ci</td>
                     <td align=left width=80%>Situazione alla prima installazione o alla ristrutturazione dell'impianto termico $cod_impianto_est</td><!--gac11-->
                  </tr>
                  <tr>
                     <td colspan=2>
                        <table width=100%>
                              <tr>
                                 <td align=left>Data Installazione</td>
                                 <td align=left>$data_installaz</td>
                                 <td align=left>Data Dismissione</td>
                                 <td align=left>$data_dismissione</td>
                              </tr>
                              <tr>
                                 <td align=left>Lunghezza circuito</td>
                                 <td align=left>$lunghezza (m)</td>
                              </tr>                       
                              <tr>
                                 <td align=left>Superficie dello scambiatore</td>
                                 <td align=left>$superficie (m<sup>2</sup>)</td>
                                 <td align=left>Profondit&agrave; d'installazione</td>
                                 <td align=left>$profondita (m)</td>
                              </tr>
                         </table>
                     </td>  
                  </tr>
            </table><br>"

    set sw_circ_inte "t"
}


if {$sw_circ_inte eq "t"} {
    append libretto "</table>
    <table width=100%>
          <tr>
             <td colspan=2>&nbsp;</td>
          </tr>
          <tr>
             <td colspan=2><b>SOSTITUZIONI DEL COMPONENTE</b></td>
          </tr>
          <tr>
             <td colspan=2>&nbsp;</td>
          </tr>
    </table>"         

db_foreach sel_circ_inte_sost_comp "" {#rom07 aggiunta foreach e contenuto
    append libretto "
            <table width=100% border=1>
                  <tr>
                     <td align=left  width=20%>Circuito<br>CI $num_ci_sost_comp</td>
                     <td align=left width=80%>Sosotituzione del componente</td>
                  </tr>
                  <tr>
                     <td colspan=2>
                        <table width=100%>
                              <tr>
                                 <td align=left>Data Installazione</td>
                                 <td align=left>$data_installaz_sost_comp</td>
                                 <td align=left>Data Dismissione</td>
                                 <td align=left>$data_dismissione_sost_comp</td>
                              </tr>
                              <tr>
                                 <td align=left>Lunghezza circuito</td>
                                 <td align=left>$lunghezza_sost_comp (m)</td>
                              </tr>                       
                              <tr>
                                 <td align=left>Superficie dello scambiatore</td>
                                 <td align=left>$superficie_sost_comp (m<sup>2</sup>)</td>
                                 <td align=left>Profondit&agrave; d'installazione</td>
                                 <td align=left>$profondita_sost_comp (m)</td>
                              </tr>
                         </table>
                     </td>  
                  </tr>
            </table><br>"
}

#rom07     <tr>
#             <td colspan=2>&nbsp;</td>
#          </tr>
#          <tr>
#             <td>Data di installazione _________________</td>
#             <td>Data di dismissione _________________</td>
#          </tr>
#          <tr>
#             <td>Lunghezza circuito _________________ (m)</td>
#          </tr>
#          <tr> 
#             <td>Superficie dello scambiatore _________________ (m<sup>2</sup>)</td>
#             <td>Profondit&agrave; d'installazione _________________ (m)</td>
#rom07     </tr>
#rom07     <tr>
#             <td colspan=2>&nbsp;</td>
#          </tr>
#          <tr>
#             <td>Data di installazione _________________</td>
#             <td>Data di dismissione _________________</td>
#          </tr>
#          <tr>
#             <td>Lunghezza circuito _________________ (m)</td>
#          </tr>
#          <tr> 
#             <td>Superficie dello scambiatore _________________ (m<sup>2</sup>)</td>
#             <td>Profondit&agrave; d'installazione _________________ (m)</td>
#rom07     </tr>
#rom07     <tr>
#             <td colspan=2>&nbsp;</td>
#          </tr>
#          <tr>
#             <td>Data di installazione _________________</td>
#             <td>Data di dismissione _________________</td>
#          </tr>
#          <tr>
#             <td>Lunghezza circuito _________________ (m)</td>
#          </tr>
#          <tr> 
#             <td>Superficie dello scambiatore _________________ (m<sup>2</sup>)</td>
#             <td>Profondit&agrave; d'installazione _________________ (m)</td>
#rom07     </tr>
#rom07     <tr>
#             <td colspan=2>&nbsp;</td>
#          </tr>
#          <tr>
#             <td>Data di installazione _________________</td>
#             <td>Data di dismissione _________________</td>
#          </tr>
#          <tr>
#             <td>Lunghezza circuito _________________ (m)</td>
#          </tr>
#          <tr> 
#             <td>Superficie dello scambiatore _________________ (m<sup>2</sup>)</td>
#             <td>Profondit&agrave; d'installazione _________________ (m)</td>
#rom07     </tr>
#rom07</table>

} else {
    append libretto "
    <tr>
       <td colspan=4>Non esiste alcun circuito interrato a condensazione/espansione diretta</td>
    </tr>
    </table>"
}

append libretto "
    <!-- PAGE BREAK -->
    $table_con_header_per_tutte_le_pagine
"
append libretto "
    <table width=100% border=1>
          <tr>
             <td align=center bgcolor=\"E1E1E1\"><big><b>9. Altri Componenti dell' Impianto</b></big></td>
          </tr>
    </table>"

#gab04 Aggiunta sezione 9.5
append libretto "
    <table width=100% align=center>
       <tr>
          <td colspan=4>&nbsp;</td>
       </tr>
       <tr>
          <td align=center colspan=4><b>9.5 Unit&agrave; di Trattamento Aria</td>
       </tr>
       <tr>
          <td colspan=4>&nbsp;</td>
       </tr>
    </table>"

set sw_trat_aria "f"

db_foreach sel_trat_aria "" {
    regsub -all {<} $matricola {\&lt;} matricola;#sim07
    regsub -all {>} $matricola {\&gt;} matricola;#sim07
    append libretto "
 <table width=100% border=1>
       <tr>
          <td align=left width=20%>Unit&agrave; T.A:<br>UT $num_ut</td>
          <td align=left width=80%>Situazione alla prima installazione o alla ristrutturazione dell'impianto termico $cod_impianto_est_trat_aria</td><!--gac11-->
       </tr>
       <tr>
          <td colspan=2>
             <table width=100%>
                  <tr>
                     <td align=left>Data Installazione</td>
                     <td align=left>$data_installaz</td>
                     <td align=left>Data Dismissione</td>
                     <td align=left>$data_dismissione</td>
                  </tr>
                  <tr>                       
                     <td align=left>Fabbricante</td>
                     <td align=left>$descr_cost</td>
                     <td align=left>Modello</td>
                     <td align=left>$modello</td>
                   </tr>
                   <tr>
                      <td align=left>Matricola</td>
                      <td align=left>$matricola</td>
                   </tr>
                   <tr>
                      <td align=left>Portata ventilatore di mandata</td>
                      <td align=left>$portata_mandata (l/s)</td>
                      <td align=left>Potenza ventilatore di mandata</td>
                      <td align=left>$potenza_mandata (kW)</td>
                   </tr>
                   <tr>
                      <td align=left>Portata ventilatore di ripresa</td>
                      <td align=left>$portata_ripresa (l/s)</td>
                      <td align=left>Potenza ventilatore di ripresa</td>
                      <td align=left>$potenza_ripresa (kW)</td>
                   </tr>
                   <tr>
                      <td colspan=4>&nbsp;</td>
                   </tr>
             </table>
          </td>
       </tr>
 </table><br>"

    set sw_trat_aria "t"
}


if {$sw_trat_aria eq "t"} {
    append libretto "</table>
    <table width=100%>
          <tr>
             <td colspan=2>&nbsp;</td>
          </tr>
          <tr>
             <td colspan=2><b>SOSTITUZIONI DEL COMPONENTE</b></td>
          </tr>         
          <tr>
             <td colspan=2>&nbsp;</td>
          </tr>
    </table>"

    db_foreach sel_trat_aria_sost_comp "" {#rom07 aggiunta foreach e contenuto
	regsub -all {<} $matricola_sost_comp {\&lt;} matricola_sost_comp
	regsub -all {>} $matricola_sost_comp {\&gt;} matricola_sost_comp
	append libretto "
 <table width=100% border=1>
       <tr>
          <td align=left width=20%>Unit&agrave; T.A:<br>UT $num_ut_sost_comp</td>
          <td align=left width=80%>Sostituzione del componente dell'impianto termico $cod_impianto_est_trat_aria_sost_comp</td>
       </tr>
       <tr>
          <td colspan=2>
             <table width=100%>
                  <tr>
                     <td align=left>Data Installazione</td>
                     <td align=left>$data_installaz_sost_comp</td>
                     <td align=left>Data Dismissione</td>
                     <td align=left>$data_dismissione_sost_comp</td>
                  </tr>
                  <tr>                       
                     <td align=left>Fabbricante</td>
                     <td align=left>$descr_cost_sost_comp</td>
                     <td align=left>Modello</td>
                     <td align=left>$modello_sost_comp</td>
                   </tr>
                   <tr>
                      <td align=left>Matricola</td>
                      <td align=left>$matricola_sost_comp</td>
                   </tr>
                   <tr>
                      <td align=left>Portata ventilatore di mandata</td>
                      <td align=left>$portata_mandata_sost_comp (l/s)</td>
                      <td align=left>Potenza ventilatore di mandata</td>
                      <td align=left>$potenza_mandata_sost_comp (kW)</td>
                   </tr>
                   <tr>
                      <td align=left>Portata ventilatore di ripresa</td>
                      <td align=left>$portata_ripresa_sost_comp (l/s)</td>
                      <td align=left>Potenza ventilatore di ripresa</td>
                      <td align=left>$potenza_ripresa_sost_comp (kW)</td>
                   </tr>
                   <tr>
                      <td colspan=4>&nbsp;</td>
                   </tr>
             </table>
          </td>
       </tr>
 </table><br>"
    };#rom07

#rom07     <tr>
#             <td colspan=2>&nbsp;</td>
#          </tr>
#          <tr>
#             <td>Data di installazione _________________</td>
#             <td>Data di dismissione _________________</td>
#          </tr>
#          <tr>
#             <td>Fabbricante  _________________</td>
#             <td>Modello  _________________</td>
#          </tr>
#          <tr> 
#             <td>Matricola _________________</td>
#          </tr>
#          <tr>
#             <td>Portata ventilatore di mandata _________________ (l/s)</td>
#             <td>Potenza ventilatore di mandata  _________________ (kW)</td>
#          </tr>
#          <tr>
#             <td>Portata ventilatore di ripresa  _________________ (l/s)</td>
#             <td>Potenza ventilatore di ripresa  _________________ (kW)</td>
#rom07     </tr>          
#rom07     <tr>
#             <td colspan=2>&nbsp;</td>
#          </tr>
#          <tr>
#             <td>Data di installazione _________________</td>
#             <td>Data di dismissione _________________</td>
#          </tr>
#          <tr>
#             <td>Fabbricante  _________________</td>
#             <td>Modello  _________________</td>
#          </tr>
#          <tr> 
#             <td>Matricola _________________</td>
#          </tr>
#          <tr>
#             <td>Portata ventilatore di mandata _________________ (l/s)</td>
#             <td>Potenza ventilatore di mandata  _________________ (kW)</td>
#          </tr>
#          <tr>
#             <td>Portata ventilatore di ripresa  _________________ (l/s)</td>
#             <td>Potenza ventilatore di ripresa  _________________ (kW)</td>
#rom07     </tr>          
#rom07     <tr>
#             <td colspan=2>&nbsp;</td>
#          </tr>
#          <tr>
#             <td>Data di installazione _________________</td>
#             <td>Data di dismissione _________________</td>
#          </tr>
#          <tr>
#             <td>Fabbricante  _________________</td>
#             <td>Modello  _________________</td>
#          </tr>
#          <tr> 
#             <td>Matricola _________________</td>
#          </tr>
#          <tr>
#             <td>Portata ventilatore di mandata _________________ (l/s)</td>
#             <td>Potenza ventilatore di mandata  _________________ (kW)</td>
#          </tr>
#          <tr>
#             <td>Portata ventilatore di ripresa  _________________ (l/s)</td>
#             <td>Potenza ventilatore di ripresa  _________________ (kW)</td>
#rom07     </tr>          
#rom07     <tr>
#             <td colspan=2>&nbsp;</td>
#          </tr>
#          <tr>
#             <td>Data di installazione _________________</td>
#             <td>Data di dismissione _________________</td>
#          </tr>
#          <tr>
#             <td>Fabbricante  _________________</td>
#             <td>Modello  _________________</td>
#          </tr>
#          <tr> 
#             <td>Matricola _________________</td>
#          </tr>
#          <tr>
#             <td>Portata ventilatore di mandata _________________ (l/s)</td>
#             <td>Potenza ventilatore di mandata  _________________ (kW)</td>
#          </tr>
#          <tr>
#             <td>Portata ventilatore di ripresa  _________________ (l/s)</td>
#             <td>Potenza ventilatore di ripresa  _________________ (kW)</td>
#rom07     </tr>          
#rom07</table>
    
} else {
    append libretto "
    <tr>
       <td colspan=4>Non esiste alcun unità di trattamento aria</td>
    </tr>
    </table>"
}

append libretto "
    <!-- PAGE BREAK -->
    $table_con_header_per_tutte_le_pagine
"
append libretto "
    <table width=100% border=1>
          <tr>
             <td align=center bgcolor=\"E1E1E1\"><big><b>9. Altri Componenti dell' Impianto</b></big></td>
          </tr>
    </table>"

#gab04 Aggiunta sezione 9.6
append libretto "
    <table width=100% align=center>
       <tr>
          <td>&nbsp;</td>
       </tr>
       <tr>
          <td align=center colspan=4><b>9.6 Recuperatori di Calore (aria ambiente)
       </tr>
       <tr>
          <td colspan=4>&nbsp;</td>
       </tr>"

set sw_recu_calo "f"

db_foreach sel_recu_calo "" {
    
    set rc_uta_vmc $img_unchecked
    set rc_indipendente $img_unchecked
    
#rom10    if {$installato_uta_vmc ne ""} {
#rom10	set rc_uta_vmc $img_checked
#rom10    }
    if {$installato_uta_vmc eq "S"} {#rom10 if e contenuto
	set rc_uta_vmc $img_checked
    }
    if {$indipendente ne ""} {
	set rc_indipendente $img_checked
    }
    
    append libretto "
 <table width=100% border=1>
       <tr>
          <td align=left width=20%>Recuperatore<br>RC $num_rc</td>
          <td align=left width=80%>Situazione alla prima installazione o alla ristrutturazione dell'impianto termico $cod_impianto_est</td><!--gac11-->
       </tr>
       <tr>
          <td colspan=2>
             <table width=100%>
                   <tr>
                      <td align=left>Data Installazione</td>
                      <td align=left>$data_installaz</td>
                      <td align=left>Data Dismissione</td>
                      <td align=left>$data_dismissione</td>
                   </tr>
                   <tr>
                      <td align=left>Tipologia</td>
                      <td align=left>$tipologia</td>
                   </tr>
                   <tr>
                      <td align=left>$rc_uta_vmc Installato in U.T.A. o V.M.C.</td>
                      <td colspan=2>&nbsp;</td>
                   </tr>
                   <tr>
                      <td align=left>$rc_indipendente Indipendente</td>
                      <td colspan=2>&nbsp;</td>
                   </tr>
                   <tr>
                      <td align=left>Portata ventilatore di mandata</td>
                      <td align=left>$portata_mandata (l/s)</td>
                      <td align=left>Potenza ventilatore di mandata</td>
                      <td align=left>$potenza_mandata (kW)</td>
                   </tr>
                   <tr>
                      <td align=left>Portata ventilatore di ripresa</td>
                      <td align=left>$portata_ripresa (l/s)</td>
                      <td align=left>Potenza ventilatore di ripresa</td>
                      <td align=left>$potenza_ripresa (kW)</td>
                   </tr>
              </table>
          </td>
       </tr>
 </table><br>"

    set sw_recu_calo "t"
}


if {$sw_recu_calo eq "t"} {
    append libretto "</table>
    <table width=100%>
          <tr>
             <td colspan=2>&nbsp;</td>
          </tr>
          <tr>
             <td colspan=2><b>SOSTITUZIONI DEL COMPONENTE</b></td>
          </tr>         
          <tr>
             <td colspan=2>&nbsp;</td>
          </tr>
    </table>"

    db_foreach sel_recu_calo_sost_comp "" {#rom07 aggiunto foreach e contenuto
	
	set rc_uta_vmc_sost_comp $img_unchecked
	set rc_indipendente_sost_comp $img_unchecked
	
#rom10	if {$installato_uta_vmc_sost_comp ne ""} {
#rom10	    set rc_uta_vmc_sost_comp $img_checked
#rom10	}
	if {$installato_uta_vmc_sost_comp eq "S"} {#rom10 if e contenuto
	    set rc_uta_vmc_sost_comp $img_checked
	}
	if {$indipendente_sost_comp ne ""} {
	    set rc_indipendente_sost_comp $img_checked
	}
	
	append libretto "
 <table width=100% border=1>
       <tr>
          <td align=left width=20%>Recuperatore<br>RC $num_rc_sost_comp</td>
          <td align=left width=80%>Sostituzione del componente</td>
       </tr>
       <tr>
          <td colspan=2>
             <table width=100%>
                   <tr>
                      <td align=left>Data Installazione</td>
                      <td align=left>$data_installaz_sost_comp</td>
                      <td align=left>Data Dismissione</td>
                      <td align=left>$data_dismissione_sost_comp</td>
                   </tr>
                   <tr>
                      <td align=left>Tipologia</td>
                      <td align=left>$tipologia_sost_comp</td>
                   </tr>
                   <tr>
                      <td align=left>$rc_uta_vmc_sost_comp Installato in U.T.A. o V.M.C.</td>
                      <td colspan=2>&nbsp;</td>
                   </tr>
                   <tr>
                      <td align=left>$rc_indipendente_sost_comp Indipendente</td>
                      <td colspan=2>&nbsp;</td>
                   </tr>
                   <tr>
                      <td align=left>Portata ventilatore di mandata</td>
                      <td align=left>$portata_mandata_sost_comp (l/s)</td>
                      <td align=left>Potenza ventilatore di mandata</td>
                      <td align=left>$potenza_mandata_sost_comp (kW)</td>
                   </tr>
                   <tr>
                      <td align=left>Portata ventilatore di ripresa</td>
                      <td align=left>$portata_ripresa_sost_comp (l/s)</td>
                      <td align=left>Potenza ventilatore di ripresa</td>
                      <td align=left>$potenza_ripresa_sost_comp (kW)</td>
                   </tr>
              </table>
          </td>
       </tr>
 </table><br>"
	
    };#rom07

#rom07     <tr>
#             <td colspan=2>&nbsp;</td>
#          </tr>
#          <tr>
#             <td>Data di installazione _________________</td>
#             <td>Data di dismissione _________________</td>
#          </tr>
#         <tr>
#             <td>Tipologia  _________________</td>
#          </tr>
#          <tr> 
#             <td valign=top>Installato in:
#             $img_unchecked U.T.A.
#             $img_unchecked V.M.C.<br>
#             <td valign=top>$img_unchecked Indipendente</td>
#          </tr>
#          <tr>
#             <td>Portata ventilatore di mandata _________________ (l/s)</td>
#             <td>Potenza ventilatore di mandata  _________________ (kW)</td>
#          </tr>
#          <tr>
#             <td>Portata ventilatore di ripresa  _________________ (l/s)</td>
#             <td>Potenza ventilatore di ripresa  _________________ (kW)</td>
#rom07     </tr>          

#rom07     <tr>
#             <td colspan=2>&nbsp;</td>
#          </tr>
#          <tr>
#             <td>Data di installazione _________________</td>
#             <td>Data di dismissione _________________</td>
#          </tr>
#         <tr>
#             <td>Tipologia  _________________</td>
#          </tr>
#          <tr> 
#             <td valign=top>Installato in:
#             $img_unchecked U.T.A.
#             $img_unchecked V.M.C.<br>
#             <td valign=top>$img_unchecked Indipendente</td>
#          </tr>
#          <tr>
#             <td>Portata ventilatore di mandata _________________ (l/s)</td>
#             <td>Potenza ventilatore di mandata  _________________ (kW)</td>
#          </tr>
#          <tr>
#             <td>Portata ventilatore di ripresa  _________________ (l/s)</td>
#             <td>Potenza ventilatore di ripresa  _________________ (kW)</td>
#rom07     </tr>          
#rom07     <tr>
#             <td colspan=2>&nbsp;</td>
#          </tr>
#          <tr>
#             <td>Data di installazione _________________</td>
#             <td>Data di dismissione _________________</td>
#          </tr>
#         <tr>
#             <td>Tipologia  _________________</td>
#          </tr>
#          <tr> 
#             <td valign=top>Installato in:
#             $img_unchecked U.T.A.
#             $img_unchecked V.M.C.<br>
#             <td valign=top>$img_unchecked Indipendente</td>
#          </tr>
#          <tr>
#             <td>Portata ventilatore di mandata _________________ (l/s)</td>
#             <td>Potenza ventilatore di mandata  _________________ (kW)</td>
#          </tr>
#          <tr>
#             <td>Portata ventilatore di ripresa  _________________ (l/s)</td>
#             <td>Potenza ventilatore di ripresa  _________________ (kW)</td>
#rom07     </tr>          
#rom07     <tr>
#             <td colspan=2>&nbsp;</td>
#          </tr>
#          <tr>
#             <td>Data di installazione _________________</td>
#             <td>Data di dismissione _________________</td>
#          </tr>
#         <tr>
#             <td>Tipologia  _________________</td>
#          </tr>
#          <tr> 
#             <td valign=top>Installato in:
#             $img_unchecked U.T.A.
#             $img_unchecked V.M.C.<br>
#             <td valign=top>$img_unchecked Indipendente</td>
#          </tr>
#          <tr>
#             <td>Portata ventilatore di mandata _________________ (l/s)</td>
#             <td>Potenza ventilatore di mandata  _________________ (kW)</td>
#          </tr>
#          <tr>
#             <td>Portata ventilatore di ripresa  _________________ (l/s)</td>
#             <td>Potenza ventilatore di ripresa  _________________ (kW)</td>
#rom07     </tr>          

#rom07</table>"

} else {
    append libretto "
    <tr>
       <td colspan=4>Non esiste alcun recuperatore di calore</td>
    </tr>
    </table>"
}

append libretto "
    <!-- PAGE BREAK -->
    $table_con_header_per_tutte_le_pagine
"

append libretto "
    <table width=100% border=1>
          <tr>
             <td align=center bgcolor=\"E1E1E1\"><big><b>10. Impianto di Ventilazione Meccanica Controllata</b></big></td>
          </tr>
    </table>"



#gab04 Aggiunta sezione 10.1
append libretto "
    <table width=100% align=center>
       <tr>
          <td align=center colspan=4>&nbsp;</td>
       </tr>
       <tr>
          <td align=center colspan=4><b>10.1 Impianto di Ventilazione Meccanica Controllata
       </tr>
       <tr>
          <td colspan=4>&nbsp;</td>
       </tr>"

set sw_vent "f"

db_foreach sel_vent "" {


    set tipo_sola_estr $img_unchecked
    set tipo_fluss_2rec_scamb_fluss_incr $img_unchecked
    set tipo_fluss_2rec_termodin $img_unchecked
    set tipo_altro $img_unchecked
   
    if {$tipologia eq "S"} {
	set tipo_sola_estr $img_checked
    }
    if {$tipologia eq "I"} {
	set tipo_fluss_2rec_scamb_fluss_incr $img_checked
    }
    if {$tipologia eq "T"} {
	set tipo_fluss_2rec_termodin $img_checked
    }
    if {$tipologia eq "A"} {
	set tipo_altro $img_checked
    }
    
    
    append libretto "
 <table width=100% align=center border=1>
       <tr>
          <td align=left width=20%>Impianto<br>VM $num_vm</td>
          <td align=left width=80%>Situazione alla prima installazione o alla ristrutturazione dell'impianto termico</td>
       </tr>
          <td colspan=2>
             <table width=100%>
                   <tr>
                      <td align=left>Data Installazione</td>
                      <td align=left>$data_installaz</td>
                      <td align=left>Data Dismissione</td>
                      <td align=left>$data_dismissione</td>
                   </tr>
                   <tr>
                      <td align=left>Fabbricante</td>
                      <td align=left>$descr_cost</td>
                      <td align=left>Modello</td>
                      <td align=left>$modello</td>
                   </tr>
                   <tr>
                      <td align=left>Tipologia:</td>
                      <td align=left colspan=3>$tipo_sola_estr Sola estrazione</td>
                   </tr>
                   <tr>
                      <td>&nbsp;</td>
                      <td align=left colspan=3>$tipo_fluss_2rec_scamb_fluss_incr Flusso doppio con recupero tramite scambiatore a flussi incociati</td>
                   </tr>
                   <tr>
                      <td>&nbsp;</td>
                      <td align=left colspan=3>$tipo_fluss_2rec_termodin Flusso doppio con recupero termodinamico</td>
                   </tr>
                   <tr>
                      <td>&nbsp;</td>
                      <td align=left colspan=3>$tipo_altro Altro: $note_tipologia_altro</td>
                   </tr>
                   <tr>
                   <td align=left>Massima portata aria</td>
                   <td align=left>$portata_aria (m3/h)</td>        
                   <td align=left>Rendimento di recupero / COP </td>
                   <td align=left>$rendimento_rec</td>
                </tr>
            </table>
</td>
</tr>
</table><br>"

    set sw_vent "t"
}


if {$sw_vent eq "t"} {
    append libretto "</table>
    <table width=100%>
          <tr>
             <td colspan=2>&nbsp;</td>
          </tr>
          <tr>
             <td colspan=2><b>SOSTITUZIONI DEL COMPONENTE</b></td>
          </tr>         
          <tr>
             <td colspan=2>&nbsp;</td>
          </tr>
    </table>"
    
    db_foreach sel_vent_sost_comp "" {#rom07 aggiunto foerach e contenuto
	set tipo_sola_estr_sost_comp $img_unchecked
	set tipo_fluss_2rec_scamb_fluss_incr_sost_comp $img_unchecked
	set tipo_fluss_2rec_termodin_sost_comp $img_unchecked
	set tipo_altro_sost_comp $img_unchecked
	
	if {$tipologia_sost_comp eq "S"} {
	    set tipo_sola_estr_sost_comp $img_checked
	}
	if {$tipologia_sost_comp eq "I"} {
	    set tipo_fluss_2rec_scamb_fluss_incr_sost_comp $img_checked
	}
	if {$tipologia_sost_comp eq "T"} {
	    set tipo_fluss_2rec_termodin_sost_comp $img_checked
	}
	if {$tipologia_sost_comp eq "A"} {
	    set tipo_altro_sost_comp $img_checked
	}
	
	
	append libretto "
 <table width=100% align=center border=1>
       <tr>
          <td align=left width=20%>Impianto<br>VM $num_vm_sost_comp</td>
          <td align=left width=80%>Sostituzione del componente</td>
       </tr>
          <td colspan=2>
             <table width=100%>
                   <tr>
                      <td align=left>Data Installazione</td>
                      <td align=left>$data_installaz_sost_comp</td>
                      <td align=left>Data Dismissione</td>
                      <td align=left>$data_dismissione_sost_comp</td>
                   </tr>
                   <tr>
                      <td align=left>Fabbricante</td>
                      <td align=left>$descr_cost_sost_comp</td>
                      <td align=left>Modello</td>
                      <td align=left>$modello_sost_comp</td>
                   </tr>
                   <tr>
                      <td align=left>Tipologia:</td>
                      <td align=left colspan=3>$tipo_sola_estr_sost_comp Sola estrazione</td>
                   </tr>
                   <tr>
                      <td>&nbsp;</td>
                      <td align=left colspan=3>$tipo_fluss_2rec_scamb_fluss_incr_sost_comp Flusso doppio con recupero tramite scambiatore a flussi incociati</td>
                   </tr>
                   <tr>
                      <td>&nbsp;</td>
                      <td align=left colspan=3>$tipo_fluss_2rec_termodin_sost_comp Flusso doppio con recupero termodinamico</td>
                   </tr>
                   <tr>
                      <td>&nbsp;</td>
                      <td align=left colspan=3>$tipo_altro_sost_comp Altro: $note_tipologia_altro_sost_comp</td>
                   </tr>
                   <tr>
                   <td align=left>Massima portata aria</td>
                   <td align=left>$portata_aria_sost_comp (m3/h)</td>        
                   <td align=left>Rendimento di recupero / COP </td>
                   <td align=left>$rendimento_rec_sost_comp</td>
                </tr>
            </table>
</td>
</tr>
</table><br>"
    };#rom07

#rom07     <tr>
#             <td colspan=2>&nbsp;</td>
#          </tr>
#          <tr>
#             <td>Data di installazione _________________</td>
#             <td>Data di dismissione _________________</td>
#          </tr>
#          <tr>
#             <td>Fabbricante  _________________</td>
#             <td>Modello  _________________</td>
#          </tr>
#          <tr> 
#             <td valign=top>Tipologia:<br>
#             $img_unchecked Sola estrazione<br>
#             $img_unchecked Flusso doppio con recupero tramite scambiatore a flussi incrociati<br>
#             $img_unchecked Flusso doppio con recupero termodinamico<br>
#             $img_unchecked Altro __________________________<br>
#          </tr>
#          <tr>
#             <td>Massima portata aria  _________________ (m3/h)</td>
#             <td>Rendimento di recupero / COP  _________________ </td>
#rom07     </tr>

#rom07     <tr>
#             <td colspan=2>&nbsp;</td>
#          </tr>
#          <tr>
#             <td>Data di installazione _________________</td>
#             <td>Data di dismissione _________________</td>
#          </tr>
#          <tr>
#             <td>Fabbricante  _________________</td>
#             <td>Modello  _________________</td>
#          </tr>
#          <tr> 
#             <td valign=top>Tipologia:<br>
#             $img_unchecked Sola estrazione<br>
#             $img_unchecked Flusso doppio con recupero tramite scambiatore a flussi incrociati<br>
#             $img_unchecked Flusso doppio con recupero termodinamico<br>
#             $img_unchecked Altro __________________________<br>
#          </tr>
#          <tr>
#             <td>Massima portata aria  _________________ (m3/h)</td>
#             <td>Rendimento di recupero / COP  _________________ </td>
#rom07     </tr>
#rom07     <tr>
#             <td colspan=2>&nbsp;</td>
#          </tr>
#          <tr>
#             <td>Data di installazione _________________</td>
#             <td>Data di dismissione _________________</td>
#          </tr>
#          <tr>
#             <td>Fabbricante  _________________</td>
#             <td>Modello  _________________</td>
#          </tr>
#          <tr> 
#             <td valign=top>Tipologia:<br>
#             $img_unchecked Sola estrazione<br>
#             $img_unchecked Flusso doppio con recupero tramite scambiatore a flussi incrociati<br>
#             $img_unchecked Flusso doppio con recupero termodinamico<br>
#             $img_unchecked Altro __________________________<br>
#          </tr>
#          <tr>
#             <td>Massima portata aria  _________________ (m3/h)</td>
#             <td>Rendimento di recupero / COP  _________________ </td>
#rom07     </tr>
#rom07     <tr>
#             <td colspan=2>&nbsp;</td>
#          </tr>
#          <tr>
#             <td>Data di installazione _________________</td>
#             <td>Data di dismissione _________________</td>
#          </tr>
#          <tr>
#             <td>Fabbricante  _________________</td>
#             <td>Modello  _________________</td>
#          </tr>
#          <tr> 
#             <td valign=top>Tipologia:<br>
#             $img_unchecked Sola estrazione<br>
#             $img_unchecked Flusso doppio con recupero tramite scambiatore a flussi incrociati<br>
#             $img_unchecked Flusso doppio con recupero termodinamico<br>
#             $img_unchecked Altro __________________________<br>
#          </tr>
#          <tr>
#             <td>Massima portata aria  _________________ (m3/h)</td>
#             <td>Rendimento di recupero / COP  _________________ </td>
#rom07     </tr>
            
#rom07</table>

} else {
    append libretto "
    <tr>
       <td colspan=4>Non esiste alcun impianto di ventilazione meccanica controllata</td>
    </tr>
    </table>"
}

append libretto "
    <!-- PAGE BREAK -->
    $table_con_header_per_tutte_le_pagine
"

append libretto "
    <table width=100% border=1>
          <tr>
             <td align=center bgcolor=\"E1E1E1\"><big><b>11.Risultati della prima verifica effettuata dall'installatore e<br>delle verifiche periodiche effettuate dal manutentore</b></big></td>
          </tr>
    </table>"

# Modelli g/f/rcce

append libretto "
    <table width=100% align=center>
          <tr>
             <td>&nbsp;</td>
          </tr>
          <tr>
             <td align=center><b>11.1 Gruppi Termici</b></td>
          </tr>
          <tr>
             <td>&nbsp;</td>
          </tr>
    </table>"


#simone: i dimp devono essere visualizzati in ordine di generatore

set prog_controllo 0


#sim09 set st_dt_contr   ""
#sim09 set st_stat_conf  ""
#sim09 set st_num_prot   ""
#sim09 set st_dt_prot    ""
#sim09 set st_num_bol    ""
#sim09 set st_temp_fum   ""
#sim09 set st_temp_amb   ""
#sim09 set st_O2         ""
#sim09 set st_CO2        ""
#sim09 set st_bacharach  ""
#sim09 set st_CO         ""
#sim09 set st_rend_comb  ""

set num_row "0"
set max_coll 6
#set where_flag_tracciato " and flag_tracciato != 'R2' and flag_tracciato != 'F' and flag_tracciato != 'DA'" 

set where_flag_tracciato " and flag_tracciato = 'R1'"
set num_dimp_caldo 0
db_foreach sel_gend_ri "" {

    set norma_uni $img_unchecked
    set norma_uni_altro $img_unchecked
    if {$rif_uni_10389 eq "U"} {
	set norma_uni $img_checked
    }
    if {$rif_uni_10389 eq "A"} {
    set norma_uni_altro $img_checked
    }

set where_gen_prog $gen_prog

#set prog_controllo 1;#sim09

incr prog_controllo
set num_row 0
set st_num_gen.$prog_controllo    $where_gen_prog
set st_dt_contr.$prog_controllo   "";#sim09
set st_stat_conf.$prog_controllo  "";#sim09
set st_num_prot.$prog_controllo   "";#sim09
set st_dt_prot.$prog_controllo    "";#sim09
set st_num_bol.$prog_controllo    "";#sim09
set st_temp_fum.$prog_controllo   "";#sim09
set st_temp_amb.$prog_controllo   "";#sim09
set st_O2.$prog_controllo         "";#sim09
set st_CO2.$prog_controllo        "";#sim09
set st_bacharach.$prog_controllo  "";#sim09
set st_CO.$prog_controllo         "";#sim09
set st_CO_fumi_secchi_ppm.$prog_controllo ""
set st_rend_comb.$prog_controllo  "";#sim09
set st_rct_rend_min_legge.$prog_controllo         "" ;#gac04
set st_rct_modulo_termico.$prog_controllo         "" ;#gac04  
set st_bacharach2.$prog_controllo                 "" ;#gac04
set st_bacharach3.$prog_controllo                 "" ;#gac04
set st_portata_comb.$prog_controllo               "" ;#gac04
set st_rispetta_indice_bacharach.$prog_controllo  "" ;#gac04
set st_co_fumi_secchi.$prog_controllo             "" ;#gac04
set st_rend_magg_o_ugua_rend_min.$prog_controllo  "" ;#gac04
set st_port_ter_eff.$prog_controllo  ""
set st_progressivo_prova_fumi.$prog_controllo  "";#sim09
set st_firma.$prog_controllo             ""
set calcola_colspan.$prog_controllo  [expr $num_row + 1]
set gt_dimp.$prog_controllo $gen_prog_est
set cod_impianto_gend.$prog_controllo $cod_impianto_gend ;#rom23

db_foreach sel_dimp__ "    
 select * from (
select case a.flag_status
           when 'P' then 'Positivo'
           when 'N' then 'Negativo'
           else '&nbsp;'
           end as desc_status
         , coalesce(a.n_prot,'&nbsp;') as n_prot
         , coalesce(iter_edit_data(a.data_controllo),'&nbsp;') as data_controllo
         , coalesce(iter_edit_data(a.data_prot),'&nbsp;') as data_prot
         , coalesce(a.riferimento_pag,'&nbsp;') as num_bollo
         , 1 as progressivo_prova_fumi
         , iter_edit_num(a.temp_fumi, 2) as temp_fumi
         , iter_edit_num(a.temp_ambi, 2) as temp_ambi
         , iter_edit_num(a.o2, 2) as o2
         , iter_edit_num(a.co2, 2) as co2
         , iter_edit_num(a.bacharach, 0) as bacharach
         , iter_edit_num(a.co, 2) as co
         , iter_edit_num(a.co_fumi_secchi_ppm, 2) as co_fumi_secchi_ppm
         , iter_edit_num(a.rend_combust, 2) as rend_combust
         , iter_edit_num(a.rct_rend_min_legge,2) as rct_rend_min_legge  --gac04
         , a.rct_modulo_termico                                         --gac04
	 , iter_edit_num(a.bacharach2,0) as bacharach2                  --gac04
	 , iter_edit_num(a.bacharach3,0) as bacharach3                  --gac04
         , iter_edit_num(a.portata_comb,2) as portata_comb              --gac04
         , case when a.rispetta_indice_bacharach = 'S' then 'SI'        --gac04
                when a.rispetta_indice_bacharach = 'N' then 'NO'        --gac04
                end as rispetta_indice_bacharach                        --gac04
	 , case when a.co_fumi_secchi = 'S' then 'SI'                   --gac04
                when a.co_fumi_secchi = 'N' then 'NO'                   --gac04
                end as co_fumi_secchi                                   --gac04
	 , case when a.rend_magg_o_ugua_rend_min = 'S' then 'SI'        --gac04
                when a.rend_magg_o_ugua_rend_min = 'N' then 'NO'        --gac04
                end as rend_magg_o_ugua_rend_min                        --gac04
         , a.cod_dimp                                                   --gac04
         , coalesce(iter_edit_num(a.portata_termica_effettiva,2),'/') as port_ter_eff
         , a.gen_prog
         , a.data_controllo as data_controllo_date
      from coimdimp a
     where a.cod_impianto = :cod_impianto
     $where_flag_tracciato --sim01
union all
select case a.flag_status
           when 'P' then 'Positivo'
           when 'N' then 'Negativo'
           else '&nbsp;'
           end as desc_status
         , coalesce(a.n_prot,'&nbsp;') as n_prot
         , coalesce(iter_edit_data(a.data_controllo),'&nbsp;') as data_controllo
         , coalesce(iter_edit_data(a.data_prot),'&nbsp;') as data_prot
         , coalesce(a.riferimento_pag,'&nbsp;') as num_bollo
         , b.progressivo_prova_fumi
         , iter_edit_num(b.temp_fumi, 2) as temp_fumi
         , iter_edit_num(b.temp_ambi, 2) as temp_ambi
         , iter_edit_num(b.o2, 2) as o2
         , iter_edit_num(b.co2, 2) as co2
         , iter_edit_num(b.bacharach, 0) as bacharach
         , iter_edit_num(b.co, 2) as co
         , iter_edit_num(b.co_fumi_secchi_ppm, 2) as co_fumi_secchi_ppm
         , iter_edit_num(b.rend_combust, 2) as rend_combust
         , iter_edit_num(b.rct_rend_min_legge,2) as rct_rend_min_legge  --gac04
         , b.rct_modulo_termico                                         --gac04
	 , iter_edit_num(b.bacharach2,0) as bacharach2                  --gac04
	 , iter_edit_num(b.bacharach3,0) as bacharach3                  --gac04
         , iter_edit_num(b.portata_comb,2) as portata_comb              --gac04
         , case when a.rispetta_indice_bacharach = 'S' then 'SI'        --gac04
                when a.rispetta_indice_bacharach = 'N' then 'NO'        --gac04
                end as rispetta_indice_bacharach                        --gac04
	 , case when a.co_fumi_secchi = 'S' then 'SI'                   --gac04
                when a.co_fumi_secchi = 'N' then 'NO'                   --gac04
                end as co_fumi_secchi                                   --gac04
	 , case when a.rend_magg_o_ugua_rend_min = 'S' then 'SI'        --gac04
                when a.rend_magg_o_ugua_rend_min = 'N' then 'NO'        --gac04
                end as rend_magg_o_ugua_rend_min                        --gac04
         , a.cod_dimp                                                   --gac04
         , coalesce(iter_edit_num(a.portata_termica_effettiva,2), '/') as port_ter_eff
         , a.gen_prog
         , a.data_controllo as data_controllo_date
      from coimdimp a
         , coimdimp_prfumi b
     where a.cod_impianto = :cod_impianto
       and a.cod_dimp = b.cod_dimp
     $where_flag_tracciato --sim01
) as q
where gen_prog=:where_gen_prog
    order by data_controllo_date desc ,progressivo_prova_fumi
" {

    if {![db_0or1row q "select 1 from coimdimp_prfumi where cod_dimp=:cod_dimp limit 1"]} {
	#se non ho altre prove fumi non va indicato il modulo in stampa
	set progressivo_prova_fumi ""
    }
    
    incr num_dimp_caldo

    set check_bacharach        $img_unchecked
    set uncheck_bacharach      $img_unchecked
    set check_co_fumi_secchi   $img_unchecked
    set uncheck_co_fumi_secchi $img_unchecked
    set check_rend_min_legge   $img_unchecked
    set uncheck_rend_min_legge $img_unchecked


    if {$rispetta_indice_bacharach eq "SI"} {
    set check_bacharach $img_checked
    }
    if {$rispetta_indice_bacharach eq "NO"} {
    set uncheck_bacharach $img_checked
    }
    if {$co_fumi_secchi eq "SI"} {
	    set check_co_fumi_secchi  $img_checked
    }
    if {$co_fumi_secchi eq "NO"} {
	set uncheck_co_fumi_secchi  $img_checked
    } 
    if {$rend_magg_o_ugua_rend_min eq "SI"} {
            set check_rend_min_legge  $img_checked
    }
    if {$rend_magg_o_ugua_rend_min eq "NO"} {
        set uncheck_rend_min_legge $img_checked
    }

    #    append libretto "
    #     <table width=100% align=center border>
    #       <tr>
    #          <td align=center><b>Data controllo:</b>$data_controllo</td>
    #          <td><b>Stato conformit&agrave;:</b>$desc_status</td>
    #          <td align=center><b>Num. prot.:</b>$n_prot</td>
    #          <td align=center><b>Data prot.:</b>$data_prot</td>
    #          <td align=center><b>Num. bollino:</b>$num_bollo</td>
    #         </tr>  <br>
    #         <tr>
    #          <td align=center><b>Temp.fumi: </b>$temp_fumi</td>          
    #          <td align=center><b>Temp.Ambiente: </b>$temp_ambi</td>
    #          <td align=center><b>O2: </b>$o2</td>
    #          <td align=center><b>CO2: </b>$co2</td>
    #          <td align=center><b>Bacharach: </b>$bacharach</td>
    #          <td align=center><b>CO: </b>$co</td>
    #          <td align=center><b>Rend.Comb.: </b>$rend_combust</td>
    #         </tr>
    
    #         <br>"
    
    if {$num_row == $max_coll} {
	
	incr prog_controllo
	set gt_dimp.$prog_controllo $gen_prog_est
	set cod_impianto_gend.$prog_controllo $cod_impianto_gend;#rom23
	set st_num_gen.$prog_controllo    $where_gen_prog
	set st_dt_contr.$prog_controllo   "";#sim09
	set st_progressivo_prova_fumi.$prog_controllo "";#sim09
	set st_stat_conf.$prog_controllo  "";#sim09
	set st_num_prot.$prog_controllo   "";#sim09
	set st_dt_prot.$prog_controllo    "";#sim09
	set st_num_bol.$prog_controllo    "";#sim09
	set st_temp_fum.$prog_controllo   "";#sim09
	set st_temp_amb.$prog_controllo   "";#sim09
	set st_O2.$prog_controllo         "";#sim09
	set st_CO2.$prog_controllo        "";#sim09
	set st_bacharach.$prog_controllo  "";#sim09
	set st_CO.$prog_controllo         "";#sim09
	set st_CO_fumi_secchi_ppm.$prog_controllo ""
	set st_rend_comb.$prog_controllo  "";#sim09
	set st_rct_rend_min_legge.$prog_controllo         "" ;#gac04
	set st_rct_modulo_termico.$prog_controllo         "" ;#gac04  
	set st_portata_comb.$prog_controllo               "" ;#gac04
	set st_rispetta_indice_bacharach.$prog_controllo  "" ;#gac04
	set st_co_fumi_secchi.$prog_controllo             "" ;#gac04
	set st_rend_magg_o_ugua_rend_min.$prog_controllo  "" ;#gac04
	set st_cod_dimp.$prog_controllo      "";#gac04
        set st_port_ter_eff.$prog_controllo      ""
	set st_firma.$prog_controllo             ""
	set num_row 0;#sim09
	set calcola_colspan.$prog_controllo  [expr $num_row + 1]
    }
    

    incr num_row;#sim09
    append st_dt_contr.$prog_controllo                "<td align=center width=9%>$data_controllo</td>"
    append st_progressivo_prova_fumi.$prog_controllo  "<td align=center>$progressivo_prova_fumi&nbsp;</td>"


    #sim metto le barre se vuoti

    if {$desc_status eq ""} {
	set desc_status " - "
    }

    if {$n_prot eq ""} {
	set n_prot " - "
    }

    if {$data_prot eq ""} {
	set data_prot " - "
    }

    if {$num_bollo eq ""} {
	set num_bollo " - "
    }

    if {$temp_fumi eq ""} {
	set temp_fumi " - "
    }

    if {$temp_ambi eq ""} {
	set  temp_ambi " - "
    }

    if {$o2 eq ""} {
	set  o2 " - "
    }

    if {$co2 eq ""} {
	set co2 " - "
    }

    if {$bacharach eq ""} {
	set bacharach " - "
    }

    if {$bacharach2 eq ""} {
	set bacharach2 " - "
    }

    if {$bacharach3 eq ""} {
	set bacharach3 " - "
    }

    if {$co eq ""} {
	set co " - "
    }

    if {$co_fumi_secchi_ppm eq ""} {
	set co_fumi_secchi_ppm " - "
    }

    if {$rend_combust eq ""} {
	set rend_combust " - "
    }

    if {$rct_rend_min_legge eq ""} {
	set rct_rend_min_legge " - "
    }

    if {$rct_modulo_termico eq ""} {
	set rct_modulo_termico  " - "
    }

    if {$portata_comb eq ""} {
	set portata_comb   " - "
    }

    if {$port_ter_eff eq ""} {
	set port_ter_eff  " - "
    }

    #fine

    append st_stat_conf.$prog_controllo  "<td align=center>$desc_status&nbsp;</td>"
    append st_num_prot.$prog_controllo   "<td align=center>$n_prot&nbsp;</td>"
    append st_dt_prot.$prog_controllo    "<td align=center>$data_prot&nbsp;</td>"
    append st_num_bol.$prog_controllo    "<td align=center>$num_bollo&nbsp;</td>"
    append st_temp_fum.$prog_controllo   "<td align=center>$temp_fumi&nbsp;</td>"
    append st_temp_amb.$prog_controllo   "<td align=center>$temp_ambi&nbsp;</td>"
    append st_O2.$prog_controllo         "<td align=center>$o2&nbsp;</td>"
    append st_CO2.$prog_controllo        "<td align=center>$co2&nbsp;</td>"
    append st_bacharach.$prog_controllo  "<td align=center>$bacharach/$bacharach2/$bacharach3</td>"
    append st_CO.$prog_controllo         "<td align=center>$co&nbsp;</td>"
    append st_CO_fumi_secchi_ppm.$prog_controllo         "<td align=center>$co_fumi_secchi_ppm&nbsp;</td>"
    append st_rend_comb.$prog_controllo  "<td align=center>$rend_combust&nbsp;</td>"
    #gac04 aggiunto rct_rend_min_legge, rct_modulo_termico, portata_comb e bacharach2 e bacharach3 di fianco a bacharach
    append st_rct_rend_min_legge.$prog_controllo "<td align=center>$rct_rend_min_legge&nbsp;</td>"
    append st_rct_modulo_termico.$prog_controllo "<td align=center>$rct_modulo_termico&nbsp;</td>"
    append st_portata_comb.$prog_controllo       "<td align=center>$portata_comb&nbsp;</td>"
    append st_port_ter_eff.$prog_controllo       "<td align=center>$port_ter_eff&nbsp;</td>"
    append st_cod_dimp.$prog_controllo $cod_dimp;#gac04
    append st_rispetta_indice_bacharach.$prog_controllo "<td align=center>$check_bacharach Si $uncheck_bacharach No</td>";#gac04
    append st_co_fumi_secchi.$prog_controllo "<td align=center>$check_co_fumi_secchi  Si $uncheck_co_fumi_secchi No</td>";#gac04
    append st_rend_magg_o_ugua_rend_min.$prog_controllo "<td align=center>$check_rend_min_legge Si $uncheck_rend_min_legge No</td>";#gac04
    append st_firma.$prog_controllo "<td align=center>&nbsp;</td>"
    set calcola_colspan.$prog_controllo [expr $num_row + 1]
}

#simone: questa sezione serve solo per fare le colonne vuote restanti e dare una migliore impaginazione alla tabella
if {$num_row <$max_coll} {

    set colonne_da_aggiungere [expr $max_coll - $num_row]
    set contatore_ciclo_col_vuote 0

    while {$colonne_da_aggiungere > 0} {#rom02: aggiunta while, if e loro contenuto
	incr colonne_da_aggiungere -1
	incr contatore_ciclo_col_vuote

	if {$contatore_ciclo_col_vuote eq 10} {
	    break
	}

	append st_dt_contr.$prog_controllo   "<td align=left width=9%>&nbsp;</td>"
	append st_progressivo_prova_fumi.$prog_controllo  "<td align=left>&nbsp;</td>"
	append st_stat_conf.$prog_controllo  "<td align=left>&nbsp;</td>"
	append st_num_prot.$prog_controllo   "<td align=left>&nbsp;</td>"
	append st_dt_prot.$prog_controllo    "<td align=left>&nbsp;</td>"
	append st_num_bol.$prog_controllo    "<td align=left>&nbsp;</td>"
	append st_temp_fum.$prog_controllo   "<td align=left>&nbsp;</td>"
	append st_temp_amb.$prog_controllo   "<td align=left>&nbsp;</td>"
	append st_O2.$prog_controllo         "<td align=left>&nbsp;</td>"
	append st_CO2.$prog_controllo        "<td align=left>&nbsp;</td>"
	append st_bacharach.$prog_controllo  "<td align=left>&nbsp;</td>"
	append st_CO.$prog_controllo         "<td align=left>&nbsp;</td>"
	append st_CO_fumi_secchi_ppm.$prog_controllo "<td align=left>&nbsp;</td>"
	append st_rend_comb.$prog_controllo  "<td align=left>&nbsp;</td>"
	append st_rct_rend_min_legge.$prog_controllo "<td align=left>&nbsp;</td>"
	append st_rct_modulo_termico.$prog_controllo "<td align=left>&nbsp;</td>"
	append st_portata_comb.$prog_controllo       "<td align=left>&nbsp;</td>"
	append st_port_ter_eff.$prog_controllo       "<td align=center>&nbsp;</td>"
	append st_rispetta_indice_bacharach.$prog_controllo "<td align=left>&nbsp;</td>"
	append st_co_fumi_secchi.$prog_controllo "<td align=center>&nbsp;</td>"
	append st_rend_magg_o_ugua_rend_min.$prog_controllo "<td align=center>&nbsp;</td>"
	append st_firma.$prog_controllo "<td align=center>&nbsp;</td>"

    }


}

#fine creazione colonne vuote

};#fine foreach su generatori


if {$flag_gest_targa eq "T"} {#sim04: aggiunta if e suo contenuto
    set q_sel_dimp_padre "sel_dimp_padre_targa"
} else {
    set q_sel_dimp_padre "sel_dimp_padre"
}

set where_gen_prog_padre "0"
set where_cod_impianto_padre "0" ;#rom23
db_foreach $q_sel_gend_ri_padre "" {
    
    set norma_uni $img_unchecked
    set norma_uni_altro $img_unchecked 
    if {$rif_uni_10389_padre eq "U"} {
        set norma_uni $img_checked
    }
    if {$rif_uni_10389_padre eq "A"} {
    set norma_uni_altro $img_checked
    }
    set altro_rif $altro_rif_padre

incr prog_controllo

set where_gen_prog_padre $gen_prog_padre
set where_cod_impianto_padre $cod_impianto_padre;#rom23
    
set num_row 0

set gt_dimp.$prog_controllo $gen_prog_est_padre
set cod_impianto_gend.$prog_controllo $cod_impianto_est_padre;#rom23
set st_num_gen.$prog_controllo    $where_gen_prog_padre
set st_dt_contr.$prog_controllo   "";#sim09
set st_stat_conf.$prog_controllo  "";#sim09
set st_num_prot.$prog_controllo   "";#sim09
set st_dt_prot.$prog_controllo    "";#sim09
set st_num_bol.$prog_controllo    "";#sim09
set st_temp_fum.$prog_controllo   "";#sim09
set st_temp_amb.$prog_controllo   "";#sim09
set st_O2.$prog_controllo         "";#sim09
set st_CO2.$prog_controllo        "";#sim09
set st_bacharach.$prog_controllo  "";#sim09
set st_CO.$prog_controllo         "";#sim09
set st_CO_fumi_secchi_ppm.$prog_controllo ""
set st_rend_comb.$prog_controllo  "";#sim09
set st_rct_rend_min_legge.$prog_controllo         "" ;#gac04
set st_rct_modulo_termico.$prog_controllo         "" ;#gac04  
set st_bacharach2.$prog_controllo                 "" ;#gac04
set st_bacharach3.$prog_controllo                 "" ;#gac04
set st_portata_comb.$prog_controllo               "" ;#gac04
set st_rispetta_indice_bacharach.$prog_controllo  "" ;#gac04
set st_co_fumi_secchi.$prog_controllo             "" ;#gac04
set st_rend_magg_o_ugua_rend_min.$prog_controllo  "" ;#gac04
set st_port_ter_eff.$prog_controllo  ""
set st_progressivo_prova_fumi.$prog_controllo  "";#sim09
set st_firma.$prog_controllo             ""
set calcola_colspan.$prog_controllo  [expr $num_row + 1]

db_foreach $q_sel_dimp_padre "" {

    if {![db_0or1row q "select 1 from coimdimp_prfumi where cod_dimp=:cod_dimp limit 1"]} {
	#se non ho altre prove fumi non va indicato il modulo in stampa
	set progressivo_prova_fumi ""
    }

    incr num_dimp_caldo
    set check_bacharach        $img_unchecked
    set uncheck_bacharach      $img_unchecked
    set check_co_fumi_secchi   $img_unchecked
    set uncheck_co_fumi_secchi $img_unchecked
    set check_rend_min_legge   $img_unchecked
    set uncheck_rend_min_legge $img_unchecked


    if {$rispetta_indice_bacharach eq "SI"} {
    set check_bacharach $img_checked
    }
    if {$rispetta_indice_bacharach eq "NO"} {
    set uncheck_bacharach $img_checked
    }
    if {$co_fumi_secchi eq "SI"} {
	    set check_co_fumi_secchi  $img_checked
    }
    if {$co_fumi_secchi eq "NO"} {
	set uncheck_co_fumi_secchi  $img_checked
    } 
    if {$rend_magg_o_ugua_rend_min eq "SI"} {
            set check_rend_min_legge  $img_checked
    }
    if {$rend_magg_o_ugua_rend_min eq "NO"} {
        set uncheck_rend_min_legge $img_checked
    }


    if {$num_row == $max_coll} {
	
	incr prog_controllo
	set gt_dimp.$prog_controllo $gen_prog_est_padre
	set cod_impianto_gend.$prog_controllo $cod_impianto_est_padre;#rom23
	set st_num_gen.$prog_controllo    $where_gen_prog_padre
	set st_dt_contr.$prog_controllo   "";#sim09
	set st_progressivo_prova_fumi.$prog_controllo "";#sim09
	set st_stat_conf.$prog_controllo  "";#sim09
	set st_num_prot.$prog_controllo   "";#sim09
	set st_dt_prot.$prog_controllo    "";#sim09
	set st_num_bol.$prog_controllo    "";#sim09
	set st_temp_fum.$prog_controllo   "";#sim09
	set st_temp_amb.$prog_controllo   "";#sim09
	set st_O2.$prog_controllo         "";#sim09
	set st_CO2.$prog_controllo        "";#sim09
	set st_bacharach.$prog_controllo  "";#sim09
	set st_CO.$prog_controllo         "";#sim09
	set st_CO_fumi_secchi_ppm.$prog_controllo ""
	set st_rend_comb.$prog_controllo  "";#sim09
        set st_rct_rend_min_legge.$prog_controllo         "" ;#gac04
        set st_rct_modulo_termico.$prog_controllo         "" ;#gac04
        set st_portata_comb.$prog_controllo               "" ;#gac04
        set st_rispetta_indice_bacharach.$prog_controllo  "" ;#gac04
        set st_co_fumi_secchi.$prog_controllo             "" ;#gac04
        set st_rend_magg_o_ugua_rend_min.$prog_controllo  "" ;#gac04
	set st_cod_dimp.$prog_controllo      "";#gac04
	set num_row 0;#sim09
	set calcola_colspan.$prog_controllo [expr $num_row + 1]

    }

    if {$desc_status eq ""} {
	set desc_status " - "
    }

    if {$n_prot eq ""} {
	set n_prot " - "
    }

    if {$data_prot eq ""} {
	set data_prot " - "
    }

    if {$num_bollo eq ""} {
	set num_bollo " - "
    }

    if {$temp_fumi eq ""} {
	set temp_fumi " - "
    }

    if {$temp_ambi eq ""} {
	set  temp_ambi " - "
    }

    if {$o2 eq ""} {
	set  o2 " - "
    }

    if {$co2 eq ""} {
	set co2 " - "
    }

    if {$bacharach eq ""} {
	set bacharach " - "
    }

    if {$bacharach2 eq ""} {
	set bacharach2 " - "
    }

    if {$bacharach3 eq ""} {
	set bacharach3 " - "
    }
    

    if {$co eq ""} {
	set co " - "
    }

    if {$co_fumi_secchi_ppm eq ""} {
	set co_fumi_secchi_ppm " - "
    }

    if {$rend_combust eq ""} {
	set rend_combust " - "
    }

    if {$rct_rend_min_legge eq ""} {
	set rct_rend_min_legge " - "
    }

    if {$rct_modulo_termico eq ""} {
	set rct_modulo_termico  " - "
    }

    if {$portata_comb eq ""} {
	set portata_comb   " - "
    }

    if {$port_ter_eff eq ""} {
	set port_ter_eff  " - "
    }
    
    
    append st_dt_contr.$prog_controllo   "<td align=center width=9%>$data_controllo</td>"
    append st_progressivo_prova_fumi.$prog_controllo  "<td align=center>$progressivo_prova_fumi&nbsp;</td>"
    append st_stat_conf.$prog_controllo  "<td align=center>$desc_status&nbsp;</td>"
    append st_num_prot.$prog_controllo   "<td align=center>$n_prot&nbsp;</td>"
    append st_dt_prot.$prog_controllo    "<td align=center>$data_prot&nbsp;</td>"
    append st_num_bol.$prog_controllo    "<td align=center>$num_bollo&nbsp;</td>"
    append st_temp_fum.$prog_controllo   "<td align=center>$temp_fumi&nbsp;</td>"
    append st_temp_amb.$prog_controllo   "<td align=center>$temp_ambi&nbsp;</td>"
    append st_O2.$prog_controllo         "<td align=center>$o2&nbsp;</td>"
    append st_CO2.$prog_controllo        "<td align=center>$co2&nbsp;</td>"
    append st_bacharach.$prog_controllo  "<td align=center>$bacharach/$bacharach2/$bacharach3</td>"
    append st_CO.$prog_controllo         "<td align=center>$co&nbsp;</td>"
    append st_CO_fumi_secchi_ppm.$prog_controllo "<td align=center>$co_fumi_secchi_ppm&nbsp;</td>"
    append st_rend_comb.$prog_controllo  "<td align=center>$rend_combust&nbsp;</td>"
    append st_port_ter_eff.$prog_controllo       "<td align=center>$port_ter_eff&nbsp;</td>"
    #gac04 aggiunto rct_rend_min_legge, rct_modulo_termico, portata_comb e bacharach2 e bacharach3 di fianco a bacharach
    append st_rct_rend_min_legge.$prog_controllo "<td align=center>$rct_rend_min_legge&nbsp;</td>"
    append st_rct_modulo_termico.$prog_controllo "<td align=center>$rct_modulo_termico&nbsp;</td>"
    append st_portata_comb.$prog_controllo       "<td align=center>$portata_comb&nbsp;</td>"
    #sim09 set num_row "1"
    append st_cod_dimp.$prog_controllo     $cod_dimp;#gac04
    append st_rispetta_indice_bacharach.$prog_controllo "<td align=center>$check_bacharach Si $uncheck_bacharach No</td>";#gac04
    append st_co_fumi_secchi.$prog_controllo "<td align=center>$check_co_fumi_secchi  Si $uncheck_co_fumi_secchi No</td>";#gac04
    append st_rend_magg_o_ugua_rend_min.$prog_controllo "<td align=center>$check_rend_min_legge Si $uncheck_rend_min_legge No</td>";#gac04
    append st_firma.$prog_controllo "<td align=center>&nbsp;</td>"
    incr num_row 
    set calcola_colspan.$prog_controllo [expr $num_row + 1]
}

#simone: questa sezione serve solo per fare le colonne vuote restanti e dare una migliore impaginazione alla tabella
if {$num_row <$max_coll} {

    set colonne_da_aggiungere [expr $max_coll - $num_row]
    set contatore_ciclo_col_vuote 0

    while {$colonne_da_aggiungere > 0} {#rom02: aggiunta while, if e loro contenuto
	incr colonne_da_aggiungere -1
	incr contatore_ciclo_col_vuote

	if {$contatore_ciclo_col_vuote eq 10} {
	    break
	}

	append st_dt_contr.$prog_controllo   "<td align=left width=9%>&nbsp;</td>"
	append st_progressivo_prova_fumi.$prog_controllo  "<td align=left>&nbsp;</td>"
	append st_stat_conf.$prog_controllo  "<td align=left>&nbsp;</td>"
	append st_num_prot.$prog_controllo   "<td align=left>&nbsp;</td>"
	append st_dt_prot.$prog_controllo    "<td align=left>&nbsp;</td>"
	append st_num_bol.$prog_controllo    "<td align=left>&nbsp;</td>"
	append st_temp_fum.$prog_controllo   "<td align=left>&nbsp;</td>"
	append st_temp_amb.$prog_controllo   "<td align=left>&nbsp;</td>"
	append st_O2.$prog_controllo         "<td align=left>&nbsp;</td>"
	append st_CO2.$prog_controllo        "<td align=left>&nbsp;</td>"
	append st_bacharach.$prog_controllo  "<td align=left>&nbsp;</td>"
	append st_CO.$prog_controllo         "<td align=left>&nbsp;</td>"
	append st_CO_fumi_secchi_ppm.$prog_controllo "<td align=left>&nbsp;</td>"
	append st_rend_comb.$prog_controllo  "<td align=left>&nbsp;</td>"
	append st_rct_rend_min_legge.$prog_controllo "<td align=left>&nbsp;</td>"
	append st_rct_modulo_termico.$prog_controllo "<td align=left>&nbsp;</td>"
	append st_portata_comb.$prog_controllo       "<td align=left>&nbsp;</td>"
	append st_port_ter_eff.$prog_controllo       "<td align=center>&nbsp;</td>"
	append st_rispetta_indice_bacharach.$prog_controllo "<td align=left>&nbsp;</td>"
	append st_co_fumi_secchi.$prog_controllo "<td align=center>&nbsp;</td>"
	append st_rend_magg_o_ugua_rend_min.$prog_controllo "<td align=center>&nbsp;</td>"
	append st_firma.$prog_controllo "<td align=center>&nbsp;</td>"

    }

}

#fine creazione colonne vuote

};#fine foreach su generatori padre

#sim09 if {$num_row ne "0"} {
set num_tabella_gen 0
#set num_rows 0
#set cambio_pagina ""
set cod_dimp_precedente "" 
set st_rispetta_indice_bacharach_precedente ""
set st_co_fumi_secchi_precedente ""
set st_rend_magg_o_ugua_rend_min_precedente ""
while {$num_tabella_gen < $prog_controllo} {#sim09 
    incr num_tabella_gen;#sim09
#    incr num_rows
    if {$num_tabella_gen eq 100} {#sim09
	break
    }
#    if {$num_rows == "5" && $prog_controllo ne $num_tabella_gen} {
#	set cambio_pagina "
#    <!-- PAGE BREAK -->
#    $table_con_header_per_tutte_le_pagine
#"
#	set num_rows 1
#    } else {
#	set cambio_pagina ""
#    }
  
    #   incr num_tabella_gen;#sim09 
    
    if {!($num_row==0 && $num_dimp_caldo==0)} {

	if {$cod_dimp_precedente ne "" && $cod_dimp_precedente ne [set st_cod_dimp.$num_tabella_gen]} {
	    
	    append libretto "
<table width=100%>
       <tr>
        <td align=left>Rispetta l'indice di Bacharach?</td>
        <td align=left>$st_rispetta_indice_bacharach_precedente</td>
        <td align=left>CO fumi secchi e senz'aria <=1.000 ppm v/v</td>
        <td align=left>$st_co_fumi_secchi_precedente</td>
        <td align=left>Rendimento >= a rendimento minimo?</td>
        <td align=left>$st_rend_magg_o_ugua_rend_min_precedente</td>
       </tr>
</table>
<br>"
	    
	}
	
	set gt_dimp [set gt_dimp.$num_tabella_gen]
	set cod_impianto_gend_html [set cod_impianto_gend.$num_tabella_gen];#rom23
	#rom23 Aggiunta variabile cod_impianto_gend_html per visualizzare il codice impianto dell'RCEE che sto stampando.
	append libretto "
     <table width=100% align=center border=0>
       <tr>
          <td align=left>Riferimento: $norma_uni norma UNI-10389-1   $norma_uni_altro altro $altro_rif</td>
       </tr>
     </table><br>
     <table width=100% align=center border=1>
       <tr>
          <td align=left width=20%>Gruppo termico<br>GT $gt_dimp</td>
          <td align=left width=80%>Compilare una scheda per ogni gruppo termico dell'impianto $cod_impianto_gend_html<br><small>Compilare la riga del \"Numero modulo\" qualora alla sezione 4.1, siano previste più analiisi fumi per lo stesso gruppo termico).</td>
       </tr>
     </table><br>
     <table width=100% align=center border=1>
       <tr>
          <td align=right width=37%><b>DATA</b></td>[set st_dt_contr.$num_tabella_gen]
       </tr>
       <tr>
          <td nowrap height=4% valign=center align=left>Numero modulo</td>[set st_progressivo_prova_fumi.$num_tabella_gen]
       </tr>
       <tr>
          <td nowrap height=4% valign=center align=left>Portata termica effettiva (kW)</td>[set st_port_ter_eff.$num_tabella_gen]
       </tr>
       <tr>
         <td nowrap height=4% valign=center align=left colspan=[expr $max_coll +1] bgcolor=\"E1E1E1\"><b>VALORI MISURATI</b></td>
       </tr>
       <tr>
         <td nowrap height=4% valign=center align=left>Temperatura fumi (&deg;C)</td>[set st_temp_fum.$num_tabella_gen]
       </tr>
       <tr>
         <td nowrap height=4% valign=center align=left>Temperatura aria comburente (&deg;C)</td>[set st_temp_amb.$num_tabella_gen]
       </tr>
       <tr>
         <td nowrap height=4% valign=center align=left>O<sub>2</sub> (&#37;)</td>[set st_O2.$num_tabella_gen]
       </tr>
       <tr>
         <td nowrap height=4% valign=center align=left>CO<sub>2</sub> (&#37;)</td>[set st_CO2.$num_tabella_gen]
       </tr>
       <tr>
        <td  nowrap height=4% valign=center align=left>Indice di Bacharach</td>[set st_bacharach.$num_tabella_gen]
       </tr>
       <tr>
        <td  nowrap height=4% valign=center align=left>CO nei fumi secchi (ppm v/v)</td>[set st_CO_fumi_secchi_ppm.$num_tabella_gen]
       </tr>
       <tr>
        <td nowrap height=4% valign=center align=left>Portata combustibile (m&sup3;/h oppure kg/h)</td>[set st_portata_comb.$num_tabella_gen]
       </tr>
       <tr>
         <td nowrap height=4% valign=center align=left colspan=[expr $max_coll +1] bgcolor=\"E1E1E1\"><b>VALORI CALCOLATI</b></td>
       </tr>
       <tr>
        <td nowrap height=4% valign=center align=left>CO nei fumi secchi e senz'aria (ppm v/v)</td>[set st_CO.$num_tabella_gen]
       </tr>
       <tr>
        <td nowrap height=4% valign=center align=left>Rendimento di combustione <setFont name=\"Serif\">&#x3B7;<sub>c</sub>(&#37;)</td>[set st_rend_comb.$num_tabella_gen]
       </tr>
       <tr>
         <td nowrap height=4% valign=center align=left colspan=[expr $max_coll +1] bgcolor=\"E1E1E1\"><b>VERIFICHE</b></td>
       </tr>
       <td nowrap height=4% valign=center align=left>Rispetta l'indice di Bacharach</td>[set st_rispetta_indice_bacharach.$num_tabella_gen]
       </tr>
       <tr>
        <td nowrap height=4% valign=center align=left>CO fumi secchi e senz'aria <=1.000 ppm v/v</td>[set st_co_fumi_secchi.$num_tabella_gen]
       </tr>
       <tr>
        <td nowrap height=4% valign=center align=left>&#951; minimo di legge (%)</td>[set st_rct_rend_min_legge.$num_tabella_gen]
       </tr>
       <tr>
        <td nowrap height=4% valign=center align=left>&#951;<sub>c</sub> >= &#951; minimo</td>[set st_rend_magg_o_ugua_rend_min.$num_tabella_gen]
       </tr>
       <tr>
         <td nowrap height=4% valign=center align=right><b>FIRMA</b></td>[set st_firma.$num_tabella_gen]
       </tr>
   </table>

"

	append libretto "
    <!-- PAGE BREAK -->
    $table_con_header_per_tutte_le_pagine
"


#	set cod_dimp_precedente                     [set st_cod_dimp.$num_tabella_gen];#gac04
#	set st_rispetta_indice_bacharach_precedente [set st_rispetta_indice_bacharach.$num_tabella_gen];#gac04
#	set st_co_fumi_secchi_precedente            [set st_co_fumi_secchi.$num_tabella_gen];#gac04
#	set st_rend_magg_o_ugua_rend_min_precedente [set st_rend_magg_o_ugua_rend_min.$num_tabella_gen];#gac04
    }


#append libretto "

#<br>
#<br>
#$cambio_pagina
#"    
};#sim09

#if {!($num_row==0 && $prog_controllo==1)} {
#	append libretto "
#<table width=100%>
#</table>"
#}

#sim09 } else { }
if {$num_row==0 && $num_dimp_caldo==0} {
    append libretto "
    <tr>
       <td colspan=4>Non esistono Allegati RCEE</td>
    </tr>"

append libretto "
    <!-- PAGE BREAK -->
    $table_con_header_per_tutte_le_pagine
"

}

append libretto "
    <table width=100% border=1>
          <tr>
             <td align=center bgcolor=\"E1E1E1\"><big><b>11.Risultati della prima verifica effettuata dall'installatore e<br>delle verifiche periodiche effettuate dal manutentore</b></big></td>
          </tr>
    </table>"


#append libretto "
#    <!-- PAGE BREAK -->
#    $table_con_header_per_tutte_le_pagine
#"
# sezione 11.2 MACCHINE FRIGO / POMPE DI CALORE 
append libretto "
    <table width=100%>
          <tr>
             <td>&nbsp;</td>
          </tr>
          <tr>
             <td align=center><b>11.2 Macchine Frigo / Pompe di Calore</b></td>
          </tr>
          <tr>
             <td>&nbsp;</td>
          </tr>
    </table>"

set prog_controllo 0;#rom01

#set st_dt_contr   ""
#set st_stat_conf  ""
#set st_num_prot   ""
#set st_dt_prot    ""
#set st_num_bol    ""
#set st_temp_fum   ""
#set st_temp_amb   ""
#set st_O2         ""
#set st_CO2        ""
#set st_bacharach  ""
#set st_CO         ""
#set st_rend_comb  ""

set num_row "0"
set where_flag_tracciato " and flag_tracciato = 'R2' "
set num_dimp_freddo 0
set max_coll 5
db_foreach sel_gend_fr "" {

set where_gen_prog $gen_prog_fr
incr prog_controllo
set num_row 0
set st_num_gen.$prog_controllo    $gen_prog_est_fr;#where_gen_prog
set cod_impianto_gend_fr.$prog_controllo $cod_impianto_gend_fr ;#rom23

set st_dt_contr.$prog_controllo   "";#rom01
set st_stat_conf.$prog_controllo  "";#rom01
set st_num_prot.$prog_controllo   "";#rom01
set st_dt_prot.$prog_controllo    "";#rom01
set st_num_bol.$prog_controllo    "";#rom01
set st_fr_surrisc.$prog_controllo  "";#rom01
set st_fr_sottoraff.$prog_controllo  "";#rom01
set st_fr_tcondens.$prog_controllo  "";#rom01
set st_fr_tevapor.$prog_controllo  "";#rom01
set st_fr_t_ing_lato_est.$prog_controllo  "";#rom01
set st_fr_t_usc_lato_est.$prog_controllo  "";#rom01
set st_fr_t_ing_lato_ute.$prog_controllo  "";#rom01
set st_fr_t_usc_lato_ute.$prog_controllo  "";#rom01
set st_fr_nr_circuito.$prog_controllo  "";#rom01
set st_progressivo_prova_fumi.$prog_controllo  "";#rom01
set st_firma.$prog_controllo ""
set st_fr_filtri_puliti.$prog_controllo ""
set st_fr_img_fr_verifica_superata.$prog_controllo "" 
set st_fr_uscita_fluido.$prog_controllo ""
set st_fr_bulbo_umido.$prog_controllo ""
set st_fr_ingresso_sorg_esterna.$prog_controllo ""
set st_fr_uscita_sorg_esterna.$prog_controllo ""
set st_fr_ingresso_alla_macchina.$prog_controllo ""
set st_fr_uscita_dalla_macchina.$prog_controllo ""
set st_fr_potenza_assorbita.$prog_controllo ""
set st_fr_entro_data.$prog_controllo ""

db_foreach sel_dimp_fr " select * from (
select case a.flag_status
           when 'P' then 'Positivo'
           when 'N' then 'Negativo'
           else '&nbsp;'
           end as desc_status
         , coalesce(a.n_prot,'&nbsp;') as n_prot
         , coalesce(iter_edit_data(a.data_controllo),'&nbsp;') as data_controllo
         , a.data_controllo as data_controllo_data
         , coalesce(iter_edit_data(a.data_prot),'&nbsp;') as data_prot
         , coalesce(a.riferimento_pag,'&nbsp;') as num_bollo
         , 1 as progressivo_prova_fumi
         , iter_edit_num(a.fr_surrisc, 2) as fr_surrisc
         , iter_edit_num(a.fr_sottoraff, 2) as fr_sottoraff
         , iter_edit_num(a.fr_tcondens, 2) as fr_tcondens
         , iter_edit_num(a.fr_tevapor, 2) as fr_tevapor
         , iter_edit_num(a.fr_t_ing_lato_est, 2) as fr_t_ing_lato_est
         , iter_edit_num(a.fr_t_usc_lato_est, 2) as fr_t_usc_lato_est
         , iter_edit_num(a.fr_t_ing_lato_ute, 2) as fr_t_ing_lato_ute
         , iter_edit_num(a.fr_t_usc_lato_ute, 2) as fr_t_usc_lato_ute
         , a.fr_nr_circuito
         , a.gen_prog
         , a.fr_assenza_perdita_ref
         , case when fr_prova_modalita = 'F' then 'Raff'
                when fr_prova_modalita = 'C' then 'Risc'
           end as fr_prova_modalita
      from coimdimp a
     where a.cod_impianto = :cod_impianto
     $where_flag_tracciato --sim01
union all
select case a.flag_status
           when 'P' then 'Positivo'
           when 'N' then 'Negativo'
           else '&nbsp;'
           end as desc_status
         , coalesce(a.n_prot,'&nbsp;') as n_prot
         , coalesce(iter_edit_data(a.data_controllo),'&nbsp;') as data_controllo
         , a.data_controllo as data_controllo_data
         , coalesce(iter_edit_data(a.data_prot),'&nbsp;') as data_prot
         , coalesce(a.riferimento_pag,'&nbsp;') as num_bollo
         , b.progressivo_prova_fumi
         , iter_edit_num(b.fr_surrisc, 2) as fr_surrisc
         , iter_edit_num(b.fr_sottoraff, 2) as fr_sottoraff
         , iter_edit_num(b.fr_tcondens, 2) as fr_tcondens
         , iter_edit_num(b.fr_tevapor, 2) as fr_tevapor
         , iter_edit_num(b.fr_t_ing_lato_est, 2) as fr_t_ing_lato_est
         , iter_edit_num(b.fr_t_usc_lato_est, 2) as fr_t_usc_lato_est
         , iter_edit_num(b.fr_t_ing_lato_ute, 2) as fr_t_ing_lato_ute
         , iter_edit_num(b.fr_t_usc_lato_ute, 2) as fr_t_usc_lato_ute
         , b.fr_nr_circuito
         , a.gen_prog
         , a.fr_assenza_perdita_ref
         , case when fr_prova_modalita = 'F' then 'Raff'
                when fr_prova_modalita = 'C' then 'Risc'
           end as fr_prova_modalita
      from coimdimp a
         , coimdimp_prfumi b
     where a.cod_impianto = :cod_impianto
       and a.cod_dimp = b.cod_dimp
     $where_flag_tracciato --sim01
) as q
where gen_prog=:where_gen_prog
    order by data_controllo_data desc ,--progressivo_prova_fumi
fr_nr_circuito" {
    
    incr num_dimp_freddo
    if {$num_row == $max_coll} {

        incr prog_controllo
	set st_num_gen.$prog_controllo    $gen_prog_est_fr;#where_gen_prog
	set cod_impianto_gend_fr.$prog_controllo $cod_impianto_gend_fr ;#rom23
	
	set st_dt_contr.$prog_controllo                ""
	set st_fr_nr_circuito.$prog_controllo          ""
	set st_fr_assenza_perdita_ref.$prog_controllo  ""
	set st_fr_prova_modalita.$prog_controllo       ""
	set st_fr_surrisc.$prog_controllo              ""
	set st_fr_sottoraff.$prog_controllo            ""
	set st_fr_tcondens.$prog_controllo             ""
	set st_fr_tevapor.$prog_controllo              ""
	set st_fr_t_ing_lato_est.$prog_controllo       ""
	set st_fr_t_usc_lato_est.$prog_controllo       ""
	set st_fr_t_ing_lato_ute.$prog_controllo       ""
	set st_fr_t_usc_lato_ute.$prog_controllo       ""
	set st_fr_filtri_puliti.$prog_controllo        ""
	set st_fr_img_fr_verifica_superata.$prog_controllo ""
	set st_firma.$prog_controllo                   ""
	set st_fr_uscita_fluido.$prog_controllo          ""
	set st_fr_bulbo_umido.$prog_controllo            ""
	set st_fr_ingresso_sorg_esterna.$prog_controllo  ""
	set st_fr_uscita_sorg_esterna.$prog_controllo    ""
	set st_fr_ingresso_alla_macchina.$prog_controllo ""
	set st_fr_uscita_dalla_macchina.$prog_controllo  ""
	set st_fr_potenza_assorbita.$prog_controllo      ""
	set st_fr_entro_data.$prog_controllo             ""
	set num_row 0
    }

    incr num_row;#rom01

    set img_fr_assenza_perdita_ref_si $img_unchecked
    set img_fr_assenza_perdita_ref_no $img_unchecked

    set img_fr_prova_modalita_raff $img_unchecked
    set img_fr_prova_modalita_risc $img_unchecked

    set img_fr_filtri_puliti_si     $img_unchecked
    set img_fr_filtri_puliti_no     $img_unchecked
    set img_fr_verifica_superata_si $img_unchecked
    set img_fr_verifica_superata_no $img_unchecked
    
    if {$fr_assenza_perdita_ref eq "S"} {
	set img_fr_assenza_perdita_ref_si $img_checked
    }
    if {$fr_assenza_perdita_ref eq "N"} {
	set img_fr_assenza_perdita_ref_no $img_checked
    }

    if {$fr_prova_modalita eq "Raff"} {
	set img_fr_prova_modalita_raff $img_checked
    }

    if {$fr_prova_modalita eq "Risc"} {
	set img_fr_prova_modalita_risc $img_checked
    }

    if {$fr_surrisc eq ""} {
	set fr_surrisc " - "
    }
    if {$fr_sottoraff eq ""} {
	set fr_sottoraff " - "
    }
    if {$fr_tcondens eq ""} {
	set fr_tcondens " - "
    }
    if {$fr_tevapor eq ""} {
	set fr_tevapor " - "
    }
    if {$fr_t_ing_lato_est eq ""} {
	set fr_t_ing_lato_est " - "
    }
    if {$fr_t_usc_lato_est eq ""} {
	set fr_t_usc_lato_est " - "
    }
    if {$fr_t_ing_lato_ute eq ""} {
	set fr_t_ing_lato_ute " - "
    }
    if {$fr_t_usc_lato_ute eq ""} {
	set fr_t_usc_lato_ute " - "
    } 

    append st_dt_contr.$prog_controllo                "<td align=center width=10%>$data_controllo&nbsp;</td>"
    append st_fr_nr_circuito.$prog_controllo          "<td align=center>$fr_nr_circuito&nbsp;</td>"
    append st_fr_assenza_perdita_ref.$prog_controllo  "<td align=center>$img_fr_assenza_perdita_ref_si S&igrave; $img_fr_assenza_perdita_ref_no No</td>"
    append st_fr_prova_modalita.$prog_controllo       "<td align=center nowrap>$img_fr_prova_modalita_raff Raff $img_fr_prova_modalita_risc Risc</td>"
    append st_fr_surrisc.$prog_controllo              "<td align=center>$fr_surrisc&nbsp;</td>"
    append st_fr_sottoraff.$prog_controllo            "<td align=center>$fr_sottoraff&nbsp;</td>"
    append st_fr_tcondens.$prog_controllo             "<td align=center>$fr_tcondens&nbsp;</td>"
    append st_fr_tevapor.$prog_controllo              "<td align=center>$fr_tevapor&nbsp;</td>"
    append st_fr_t_ing_lato_est.$prog_controllo       "<td align=center>$fr_t_ing_lato_est&nbsp;</td>"
    append st_fr_t_usc_lato_est.$prog_controllo       "<td align=center>$fr_t_usc_lato_est&nbsp;</td>"
    append st_fr_t_ing_lato_ute.$prog_controllo       "<td align=center>$fr_t_ing_lato_ute&nbsp;</td>"
    append st_fr_t_usc_lato_ute.$prog_controllo       "<td align=center>$fr_t_usc_lato_ute&nbsp;</td>"
    append st_fr_filtri_puliti.$prog_controllo        "<td align=center>$img_fr_filtri_puliti_si S&igrave; $img_fr_filtri_puliti_no No</td>"
    append st_fr_img_fr_verifica_superata.$prog_controllo "<td align=center>$img_fr_verifica_superata_si S&igrave; $img_fr_verifica_superata_no No</td>"
    append st_firma.$prog_controllo                   "<td align=center>&nbsp;</td>"
    append st_fr_uscita_fluido.$prog_controllo          "<td align=center>&nbsp;</td>"
    append st_fr_bulbo_umido.$prog_controllo            "<td align=center>&nbsp;</td>"
    append st_fr_ingresso_sorg_esterna.$prog_controllo  "<td align=center>&nbsp;</td>"
    append st_fr_uscita_sorg_esterna.$prog_controllo    "<td align=center>&nbsp;</td>"
    append st_fr_ingresso_alla_macchina.$prog_controllo "<td align=center>&nbsp;</td>"
    append st_fr_uscita_dalla_macchina.$prog_controllo  "<td align=center>&nbsp;</td>"
    append st_fr_potenza_assorbita.$prog_controllo      "<td align=center>&nbsp;</td>"
    append st_fr_entro_data.$prog_controllo             "<td align=center>&nbsp;</td>"
   # set num_row "1"
}

#simone: questa sezione serve solo per fare le colonne vuote restanti e dare una migliore impaginazione alla tabella
if {$num_row <$max_coll} {

    set colonne_da_aggiungere [expr $max_coll - $num_row]
    set contatore_ciclo_col_vuote 0

    while {$colonne_da_aggiungere > 0} {#rom02: aggiunta while, if e loro contenuto
	incr colonne_da_aggiungere -1
	incr contatore_ciclo_col_vuote

	if {$contatore_ciclo_col_vuote eq 10} {
	    break
	}
	
	set img_fr_filtri_puliti_si     $img_unchecked
	set img_fr_filtri_puliti_no     $img_unchecked
	set img_fr_verifica_superata_si $img_unchecked
	set img_fr_verifica_superata_no $img_unchecked

	
	append st_dt_contr.$prog_controllo                "<td align=center width=10%>&nbsp;</td>"
	append st_fr_nr_circuito.$prog_controllo          "<td align=center>&nbsp;</td>"
	append st_fr_assenza_perdita_ref.$prog_controllo  "<td align=center>$img_unchecked S&igrave; $img_unchecked No</td>"
	append st_fr_prova_modalita.$prog_controllo       "<td align=center nowrap>$img_unchecked Raff $img_unchecked Risc</td>"
	append st_fr_surrisc.$prog_controllo              "<td align=center>&nbsp;</td>"
	append st_fr_sottoraff.$prog_controllo            "<td align=center>&nbsp;</td>"
	append st_fr_tcondens.$prog_controllo             "<td align=center>&nbsp;</td>"
	append st_fr_tevapor.$prog_controllo              "<td align=center>&nbsp;</td>"
	append st_fr_t_ing_lato_est.$prog_controllo       "<td align=center>&nbsp;</td>"
	append st_fr_t_usc_lato_est.$prog_controllo       "<td align=center>&nbsp;</td>"
	append st_fr_t_ing_lato_ute.$prog_controllo       "<td align=center>&nbsp;</td>"
	append st_fr_t_usc_lato_ute.$prog_controllo       "<td align=center>&nbsp;</td>"
	append st_fr_filtri_puliti.$prog_controllo        "<td align=center>$img_fr_filtri_puliti_si S&igrave; $img_fr_filtri_puliti_no No</td>"
	append st_fr_img_fr_verifica_superata.$prog_controllo "<td align=center>$img_fr_verifica_superata_si S&igrave; $img_fr_verifica_superata_no No</td>"
	append st_firma.$prog_controllo                   "<td align=center>&nbsp;</td>"
	append st_fr_uscita_fluido.$prog_controllo          "<td align=center>&nbsp;</td>"
	append st_fr_bulbo_umido.$prog_controllo            "<td align=center>&nbsp;</td>"
	append st_fr_ingresso_sorg_esterna.$prog_controllo  "<td align=center>&nbsp;</td>"
	append st_fr_uscita_sorg_esterna.$prog_controllo    "<td align=center>&nbsp;</td>"
	append st_fr_ingresso_alla_macchina.$prog_controllo "<td align=center>&nbsp;</td>"
	append st_fr_uscita_dalla_macchina.$prog_controllo  "<td align=center>&nbsp;</td>"
	append st_fr_potenza_assorbita.$prog_controllo      "<td align=center>&nbsp;</td>"
	append st_fr_entro_data.$prog_controllo             "<td align=center>&nbsp;</td>"
    }

}

#fine creazione colonne vuote

};#fine foreach su generatori

set where_gen_prog_padre "0"
set where_cod_impianto_padre "0";#rom23
db_foreach $q_sel_gend_fr_padre "" {

incr prog_controllo
set where_cod_impianto_padre $cod_impianto_fr_padre;#rom23
set where_gen_prog_padre $gen_prog_fr_padre

set num_row 0

set st_num_gen.$prog_controllo    $gen_prog_est_fr_padre;#where_gen_prog_padre
set cod_impianto_gend_fr.$prog_controllo $cod_impianto_est_padre;#rom23
set st_dt_contr.$prog_controllo                ""
set st_fr_nr_circuito.$prog_controllo          ""
set st_fr_assenza_perdita_ref.$prog_controllo  ""
set st_fr_prova_modalita.$prog_controllo       ""
set st_fr_surrisc.$prog_controllo              ""
set st_fr_sottoraff.$prog_controllo            ""
set st_fr_tcondens.$prog_controllo             ""
set st_fr_tevapor.$prog_controllo              ""
set st_fr_t_ing_lato_est.$prog_controllo       ""
set st_fr_t_usc_lato_est.$prog_controllo       ""
set st_fr_t_ing_lato_ute.$prog_controllo       ""
set st_fr_t_usc_lato_ute.$prog_controllo       ""
set st_firma.$prog_controllo                   ""
set st_fr_filtri_puliti.$prog_controllo ""
set st_fr_img_fr_verifica_superata.$prog_controllo ""
set st_fr_uscita_fluido.$prog_controllo          ""
set st_fr_bulbo_umido.$prog_controllo            ""
set st_fr_ingresso_sorg_esterna.$prog_controllo  ""
set st_fr_uscita_sorg_esterna.$prog_controllo    ""
set st_fr_ingresso_alla_macchina.$prog_controllo ""
set st_fr_uscita_dalla_macchina.$prog_controllo  ""
set st_fr_potenza_assorbita.$prog_controllo      ""
set st_fr_entro_data.$prog_controllo             ""


db_foreach $q_sel_dimp_padre "" {
    incr num_dimp_freddo
    
    if {$num_row == $max_coll} {

        incr prog_controllo

	set st_num_gen.$prog_controllo    $gen_prog_est_fr_padre;#where_gen_prog_padre
	set cod_impianto_gend_fr.$prog_controllo $cod_impianto_est_padre;#rom23
	set st_dt_contr.$prog_controllo                ""
	set st_fr_nr_circuito.$prog_controllo          ""
	set st_fr_assenza_perdita_ref.$prog_controllo  ""
	set st_fr_prova_modalita.$prog_controllo       ""
	set st_fr_surrisc.$prog_controllo              ""
	set st_fr_sottoraff.$prog_controllo            ""
	set st_fr_tcondens.$prog_controllo             ""
	set st_fr_tevapor.$prog_controllo              ""
	set st_fr_t_ing_lato_est.$prog_controllo       ""
	set st_fr_t_usc_lato_est.$prog_controllo       ""
	set st_fr_t_ing_lato_ute.$prog_controllo       ""
	set st_fr_t_usc_lato_ute.$prog_controllo       ""
	set st_fr_filtri_puliti.$prog_controllo ""
	set st_fr_img_fr_verifica_superata.$prog_controllo ""
	set st_firma.$prog_controllo                   ""
	set st_fr_uscita_fluido.$prog_controllo          ""
	set st_fr_bulbo_umido.$prog_controllo            ""
	set st_fr_ingresso_sorg_esterna.$prog_controllo  ""
	set st_fr_uscita_sorg_esterna.$prog_controllo    ""
	set st_fr_ingresso_alla_macchina.$prog_controllo ""
	set st_fr_uscita_dalla_macchina.$prog_controllo  ""
	set st_fr_potenza_assorbita.$prog_controllo      ""
	set st_fr_entro_data.$prog_controllo             ""
	
	set num_row 0
    }


    incr num_row;#rom01

    set img_fr_assenza_perdita_ref_si $img_unchecked
    set img_fr_assenza_perdita_ref_no $img_unchecked

    set img_fr_prova_modalita_raff $img_unchecked
    set img_fr_prova_modalita_risc $img_unchecked

    set img_fr_filtri_puliti_si     $img_unchecked
    set img_fr_filtri_puliti_no     $img_unchecked
    set img_fr_verifica_superata_si $img_unchecked
    set img_fr_verifica_superata_no $img_unchecked
    
    if {$fr_assenza_perdita_ref eq "S"} {
	set img_fr_assenza_perdita_ref_si $img_checked
    }
    if {$fr_assenza_perdita_ref eq "N"} {
	set img_fr_assenza_perdita_ref_no $img_checked
    }

    if {$fr_prova_modalita eq "Raff"} {
	set img_fr_prova_modalita_raff $img_checked
    }

    if {$fr_prova_modalita eq "Risc"} {
	set img_fr_prova_modalita_risc $img_checked
    }

    if {$fr_surrisc eq ""} {
	set fr_surrisc " - "
    }
    if {$fr_sottoraff eq ""} {
	set fr_sottoraff " - "
    }
    if {$fr_tcondens eq ""} {
	set fr_tcondens " - "
    }
    if {$fr_tevapor eq ""} {
	set fr_tevapor " - "
    }
    if {$fr_t_ing_lato_est eq ""} {
	set fr_t_ing_lato_est " - "
    }
    if {$fr_t_usc_lato_est eq ""} {
	set fr_t_usc_lato_est " - "
    }
    if {$fr_t_ing_lato_ute eq ""} {
	set fr_t_ing_lato_ute " - "
    }
    if {$fr_t_usc_lato_ute eq ""} {
	set fr_t_usc_lato_ute " - "
    } 
   
    append st_dt_contr.$prog_controllo                "<td align=center width=10%>$data_controllo&nbsp;</td>"
    append st_fr_nr_circuito.$prog_controllo          "<td align=center>$fr_nr_circuito&nbsp;</td>"
    append st_fr_assenza_perdita_ref.$prog_controllo  "<td align=center>$img_fr_assenza_perdita_ref_si S&igrave; $img_fr_assenza_perdita_ref_no No</td>"
    append st_fr_prova_modalita.$prog_controllo       "<td align=center nowrap>$img_fr_prova_modalita_raff Raff $img_fr_prova_modalita_risc Risc</td>"
    append st_fr_surrisc.$prog_controllo              "<td align=center>$fr_surrisc&nbsp;</td>"
    append st_fr_sottoraff.$prog_controllo            "<td align=center>$fr_sottoraff&nbsp;</td>"
    append st_fr_tcondens.$prog_controllo             "<td align=center>$fr_tcondens&nbsp;</td>"
    append st_fr_tevapor.$prog_controllo              "<td align=center>$fr_tevapor&nbsp;</td>"
    append st_fr_t_ing_lato_est.$prog_controllo       "<td align=center>$fr_t_ing_lato_est&nbsp;</td>"
    append st_fr_t_usc_lato_est.$prog_controllo       "<td align=center>$fr_t_usc_lato_est&nbsp;</td>"
    append st_fr_t_ing_lato_ute.$prog_controllo       "<td align=center>$fr_t_ing_lato_ute&nbsp;</td>"
    append st_fr_t_usc_lato_ute.$prog_controllo       "<td align=center>$fr_t_usc_lato_ute&nbsp;</td>"
    append st_firma.$prog_controllo                   "<td align=center>&nbsp;</td>"
    append st_fr_filtri_puliti.$prog_controllo        "<td align=center>$img_fr_filtri_puliti_si S&igrave; $img_fr_filtri_puliti_no No</td>"
    append st_fr_img_fr_verifica_superata.$prog_controllo "<td align=center>$img_fr_verifica_superata_si S&igrave; $img_fr_verifica_superata_no No</td>"
    append st_fr_uscita_fluido.$prog_controllo          "<td align=center>&nbsp;</td>"
    append st_fr_bulbo_umido.$prog_controllo            "<td align=center>&nbsp;</td>"
    append st_fr_ingresso_sorg_esterna.$prog_controllo  "<td align=center>&nbsp;</td>"
    append st_fr_uscita_sorg_esterna.$prog_controllo    "<td align=center>&nbsp;</td>"
    append st_fr_ingresso_alla_macchina.$prog_controllo "<td align=center>&nbsp;</td>"
    append st_fr_uscita_dalla_macchina.$prog_controllo  "<td align=center>&nbsp;</td>"
    append st_fr_potenza_assorbita.$prog_controllo      "<td align=center>&nbsp;</td>"
    append st_fr_entro_data.$prog_controllo             "<td align=center>&nbsp;</td>"
    
   # set num_row "1"
   
}


#simone: questa sezione serve solo per fare le colonne vuote restanti e dare una migliore impaginazione alla tabella
if {$num_row <$max_coll} {

    set colonne_da_aggiungere [expr $max_coll - $num_row]
    set contatore_ciclo_col_vuote 0

    set img_fr_filtri_puliti_si     $img_unchecked
    set img_fr_filtri_puliti_no     $img_unchecked
    set img_fr_verifica_superata_si $img_unchecked
    set img_fr_verifica_superata_no $img_unchecked

    
    while {$colonne_da_aggiungere > 0} {#rom02: aggiunta while, if e loro contenuto
	incr colonne_da_aggiungere -1
	incr contatore_ciclo_col_vuote

	if {$contatore_ciclo_col_vuote eq 10} {
	    break
	}

	append st_dt_contr.$prog_controllo                "<td align=center width=10%>&nbsp;</td>"
	append st_fr_nr_circuito.$prog_controllo          "<td align=center>&nbsp;</td>"
	append st_fr_assenza_perdita_ref.$prog_controllo  "<td align=center>$img_unchecked S&igrave; $img_unchecked No</td>"
	append st_fr_prova_modalita.$prog_controllo       "<td align=center nowrap>$img_unchecked Raff $img_unchecked Risc</td>"
	append st_fr_surrisc.$prog_controllo              "<td align=center>&nbsp;</td>"
	append st_fr_sottoraff.$prog_controllo            "<td align=center>&nbsp;</td>"
	append st_fr_tcondens.$prog_controllo             "<td align=center>&nbsp;</td>"
	append st_fr_tevapor.$prog_controllo              "<td align=center>&nbsp;</td>"
	append st_fr_t_ing_lato_est.$prog_controllo       "<td align=center>&nbsp;</td>"
	append st_fr_t_usc_lato_est.$prog_controllo       "<td align=center>&nbsp;</td>"
	append st_fr_t_ing_lato_ute.$prog_controllo       "<td align=center>&nbsp;</td>"
	append st_fr_t_usc_lato_ute.$prog_controllo       "<td align=center>&nbsp;</td>"
	append st_firma.$prog_controllo                   "<td align=center>&nbsp;</td>"
	append st_fr_filtri_puliti.$prog_controllo        "<td align=center>$img_fr_filtri_puliti_si S&igrave; $img_fr_filtri_puliti_no No</td>"
	append st_fr_img_fr_verifica_superata.$prog_controllo "<td align=center>$img_fr_verifica_superata_si S&igrave; $img_fr_verifica_superata_no No</td>"
	append st_fr_uscita_fluido.$prog_controllo          "<td align=center>&nbsp;</td>"
	append st_fr_bulbo_umido.$prog_controllo            "<td align=center>&nbsp;</td>"
	append st_fr_ingresso_sorg_esterna.$prog_controllo  "<td align=center>&nbsp;</td>"
	append st_fr_uscita_sorg_esterna.$prog_controllo    "<td align=center>&nbsp;</td>"
	append st_fr_ingresso_alla_macchina.$prog_controllo "<td align=center>&nbsp;</td>"
	append st_fr_uscita_dalla_macchina.$prog_controllo  "<td align=center>&nbsp;</td>"
	append st_fr_potenza_assorbita.$prog_controllo      "<td align=center>&nbsp;</td>"
	append st_fr_entro_data.$prog_controllo             "<td align=center>&nbsp;</td>"
	
    }

}
#fine creazione colonne vuote

};#fine foreach su generatori padre


#if {$num_row ne "0"} { }
set num_tabella_gen 0
#set num_rows 0
#set cambio_pagina ""
set cod_dimp_precedente ""

while {$num_tabella_gen < $prog_controllo} {#rom01
    incr num_tabella_gen;#rom01
    if {$num_tabella_gen eq 100} {#rom01
        break
    }

#    if {$num_rows == "4"} {
#        append cambio_pagina "
#    <!-- PAGE BREAK -->
#    $table_con_header_per_tutte_le_pagine
#"
#        set num_rows 0
#    } else {
#        set cambio_pagina ""
#    }

#    incr num_tabella_gen;#rom01
    
    if {!($num_row==0 && $num_dimp_freddo==0)} {

	set cod_impianto_gend_fr_html [set cod_impianto_gend_fr.$num_tabella_gen];#rom23
	#rom23 Aggiunta variabile cod_impianto_gend_fr_html per visualizzare il codice impianto dell'RCEE che sto stampando. 
	append libretto "
     <table width=100% align=center border=1>
       <tr>
          <td align=left width=30%>Gruppo frigo/Pompe di Calore<br>GF [set st_num_gen.$num_tabella_gen]</td>
          <td align=left width=70%>Compilare una scheda per ogni gruppo frigo/pompa di calore dell'impianto $cod_impianto_gend_fr_html<br><small>Compilare la riga del \"Numero circuito\" qualora alla sezione 4.4, siano annotati più circuiti per lo stesso gruppo frigo)</td>
       </tr>
     </table><br>
     <table width=100% align=center border=1>
       <tr>
          <td align=right width=30% height=3%><b>DATA</b></td>[set st_dt_contr.$num_tabella_gen]
       </tr>
       <tr>
          <td align=left width=30% height=3%>Numero circuito</td>[set st_fr_nr_circuito.$num_tabella_gen]
       </tr>
       <tr>
          <td nowrap height=3% valign=center align=left>Assenza Perdite refrigerante</td>[set st_fr_assenza_perdita_ref.$num_tabella_gen]
       </tr>
       <tr>
          <td nowrap height=3% valign=center align=left>Modalità di funzionamento</td>[set st_fr_prova_modalita.$num_tabella_gen]
       </tr>
       <tr>
          <td nowrap height=3% valign=center align=left>Surriscaldamento (K)</td>[set st_fr_surrisc.$num_tabella_gen]
       </tr>
       <tr>
          <td nowrap height=3% valign=center align=left>Sottoraffreddamento (K)</td>[set st_fr_sottoraff.$num_tabella_gen]
       </tr>
       <tr>
          <td nowrap height=3% valign=center align=left>T condensazione (°C)</td>[set st_fr_tcondens.$num_tabella_gen]
       </tr>
       <tr>
          <td nowrap height=3% valign=center align=left>T evaporazione (°C)</td>[set st_fr_tevapor.$num_tabella_gen]
       </tr>
       <tr>
          <td nowrap height=3% valign=center align=left>T sorgente ingresso lato esterno (°C)</td>[set st_fr_t_ing_lato_est.$num_tabella_gen]
       </tr>
       <tr>
          <td nowrap height=3% valign=center align=left>T sorgente uscita lato esterno (°C)</td>[set st_fr_t_usc_lato_est.$num_tabella_gen]
       </tr>
       <tr>
          <td nowrap height=3% valign=center align=left>T ingresso fluido utenze (°C)</td>[set st_fr_t_ing_lato_ute.$num_tabella_gen]
</tr>
       <tr>
          <td nowrap height=3% valign=center align=left>T uscita fluido utenze (°C)</td>[set st_fr_t_usc_lato_ute.$num_tabella_gen]
       </tr>
       <tr>
          <td nowrap height=3% valign=center align=left colspan=[expr $max_coll +1] bgcolor=\"E1E1E1\">Se Usata Torre di raffreddamento o raffreddamento a fluido</td>
       </tr>
       <tr>
          <td nowrap height=3% valign=center align=left>T uscita fluido (°C)</td>[set st_fr_uscita_fluido.$prog_controllo]
       </tr>
       <tr>
          <td nowrap height=3% valign=center align=left>T bulbo umido aria (°C)</td>[set st_fr_bulbo_umido.$prog_controllo]
       </tr>
       <tr>
          <td nowrap height=3% valign=center align=left colspan=[expr $max_coll +1] bgcolor=\"E1E1E1\">Se usato Scambiatore di calore intermedio</td>
       </tr>
       <tr>
          <td nowrap height=3% valign=center align=left>T ingresso fluido sorgente esterna (°C)</td>[set st_fr_ingresso_sorg_esterna.$prog_controllo]
       </tr>
       <tr>
          <td nowrap height=3% valign=center align=left>T uscita fluido sorgente esterna (°C)</td>[set st_fr_uscita_sorg_esterna.$prog_controllo]
       </tr>
       <tr>
          <td nowrap height=3% valign=center align=left>T ingresso fluido alla macchina (°C)</td>[set st_fr_ingresso_alla_macchina.$prog_controllo]
       </tr>
       <tr>
          <td nowrap height=3% valign=center align=left>T uscita fluido dalla macchina (°C)</td>[set st_fr_uscita_dalla_macchina.$prog_controllo]
       </tr>
       <tr>
          <td nowrap height=3% valign=center align=left>Potenza assorbita (kW)</td>[set st_fr_potenza_assorbita.$prog_controllo]
       </tr>
       <tr>
          <td nowrap height=3% valign=center align=left>Filtri puliti</td>[set st_fr_filtri_puliti.$prog_controllo]
       </tr>
       <tr>
          <td nowrap height=3% valign=center align=left>Verifica superata</td>[set st_fr_img_fr_verifica_superata.$prog_controllo]
       </tr>
       <tr>
          <td nowrap height=3% valign=center align=left>Se NO, l'efficienza dell'impianto<br>va ripristinata entro la data del</td>[set st_fr_entro_data.$prog_controllo]
       </tr>
       <tr>
         <td nowrap height=3% valign=center align=right><b>FIRMA</b></td>[set st_firma.$num_tabella_gen]
       </tr>
   </table>"
 
        append libretto "
    <!-- PAGE BREAK -->
    $table_con_header_per_tutte_le_pagine
"

    }
    
};#rom01

#rom01else { }
if {$num_row==0 && $num_dimp_freddo==0} {
    append libretto "
    <tr>
       <td colspan=5>Non esistono Allegati R2</td>
    </tr>"

append libretto "
    <!-- PAGE BREAK -->
    $table_con_header_per_tutte_le_pagine
"

}


set where_flag_tracciato "";#sbianco il where perchè il sel_dimp è utilizzato anche sotto

#append libretto "</table>
#    <table width=100%>
#          <tr>
#             <td>&nbsp;</td>
#          <tr>
#    </table>"

#append libretto "
#    <!-- PAGE BREAK -->
#    $table_con_header_per_tutte_le_pagine
#"

append libretto "
    <table width=100% border=1>
          <tr>
             <td align=center bgcolor=\"E1E1E1\"><big><b>11.Risultati della prima verifica effettuata dall'installatore e<br>delle verifiche periodiche effettuate dal manutentore</b></big></td>
          </tr>
    </table>"

#rom02 Aggiunta sezione 11.3 per teleriscaldamento
append libretto "
    <table width=100%>
          <tr>
             <td>&nbsp;</td>
          </tr>
          <tr>
             <td align=center><b>11.3 Scambiatori di Calore della Sottostazione di Teleriscaldamento / Teleraffrescamento</b></td>
          </tr>
          <tr>
             <td>&nbsp;</td>
          </tr>
    </table>";#rom02

set num_row 0
set prog_controllo 0
set where_flag_tracciato "and flag_tracciato = 'R3' ";#rom02
set where_gen_prog ""
set num_dimp_tele 0
set max_coll 6
db_foreach sel_gend_tel "" {

set where_gen_prog $gen_prog_tel

#set prog_controllo 1;#rom02
incr prog_controllo
set num_row 0

set st_num_gen.$prog_controllo    $gen_prog_est_tel;#where_gen_prog
set st_dt_contr.$prog_controllo                          "";#rom02
set st_tel_temp_est.$prog_controllo                      "";#rom02
set st_temp_mand_prim.$prog_controllo                    "";#rom02
set st_temp_rit_prim.$prog_controllo                     "";#rom02
set st_temp_mand_sec.$prog_controllo                     "";#rom02
set st_temp_rit_sec.$prog_controllo                      "";#rom02
set st_potenza_compatibile_dati_prog.$prog_controllo     "";#rom02
set st_stato_coibent_idoneo_scamb.$prog_controllo        "";#rom02
set st_disp_regloaz_controll_funzionanti.$prog_controllo "";#rom02
set st_firma.$prog_controllo                             ""
set cod_impianto_gend_te.$prog_controllo $cod_impianto_gend_te;#rom23

db_foreach sel_dimp_tel__ " 
select case a.flag_status
           when 'P' then 'Positivo'
           when 'N' then 'Negativo'
           else '&nbsp;'
           end as desc_status
         , coalesce(a.n_prot,'&nbsp;') as n_prot
         , coalesce(iter_edit_data(a.data_controllo),'&nbsp;') as data_controllo
         , coalesce(iter_edit_data(a.data_prot),'&nbsp;') as data_prot
         , coalesce(a.riferimento_pag,'&nbsp;') as num_bollo
         , a.tel_temp_est       as tel_temp_est             --rom02
         , a.tel_temp_mand_prim as tel_temp_mand_prim       --rom02
         , a.tel_temp_rit_prim  as tel_temp_rit_prim        --rom02
         , a.tel_temp_mand_sec  as tel_temp_mand_sec        --rom02
         , a.tel_temp_rit_sec   as tel_temp_rit_sec         --rom02
         , a.tel_potenza_compatibile_dati_prog 
    , case a.tel_potenza_compatibile_dati_prog
           when 'S' then 'Sì'
           when 'N' then 'No'
           when 'C' then 'N.C.'
           else '&nbsp;'
           end as tel_potenza_compatibile_dati_prog
    , case a.tel_stato_coibent_idoneo_scamb
           when 'S' then 'Sì'
           when 'N' then 'No'
           when 'C' then 'N.C.'
           else '&nbsp;'
           end as tel_stato_coibent_idoneo_scamb
    , case a.tel_disp_regolaz_controll_funzionanti
           when 'S' then 'Sì'
           when 'N' then 'No'
           when 'C' then 'N.C.'
           else '&nbsp;'
           end as tel_disp_regolaz_controll_funzionanti
      from coimdimp a
     where a.cod_impianto = :cod_impianto
     $where_flag_tracciato
     and gen_prog=:where_gen_prog  
" {#rom02 e suo contenuto
    incr num_dimp_tele
    if {$num_row == $max_coll } {
	incr prog_controllo
	set st_num_gen.$prog_controllo    $gen_prog_est_tel;#where_gen_prog
	set st_dt_contr.$prog_controllo                          ""
	set st_tel_temp_est.$prog_controllo                      ""
	set st_temp_mand_prim.$prog_controllo                    ""
	set st_temp_rit_prim.$prog_controllo                     ""
	set st_temp_mand_sec.$prog_controllo                     ""
	set st_temp_rit_sec.$prog_controllo                      ""
	set st_potenza_compatibile_dati_prog.$prog_controllo     ""
	set st_stato_coibent_idoneo_scamb.$prog_controllo        ""
	set st_disp_regloaz_controll_funzionanti.$prog_controllo ""
	set st_firma.$prog_controllo                             ""
	set num_row 0
    }

    incr num_row
    append st_dt_contr.$prog_controllo                          "<td align=center width=9%>$data_controllo&nbsp;</td>"
    append st_tel_temp_est.$prog_controllo                      "<td align=center>$tel_temp_est&nbsp;</td>"
    append st_temp_mand_prim.$prog_controllo                    "<td align=center>$tel_temp_mand_prim&nbsp;</td>"
    append st_temp_rit_prim.$prog_controllo                     "<td align=center>$tel_temp_rit_prim&nbsp;</td>"
    append st_temp_mand_sec.$prog_controllo                     "<td align=center>$tel_temp_mand_sec&nbsp;</td>"
    append st_temp_rit_sec.$prog_controllo                      "<td align=center>$tel_temp_rit_sec&nbsp;</td>"
    append st_potenza_compatibile_dati_prog.$prog_controllo     "<td align=center>$tel_potenza_compatibile_dati_prog&nbsp;</td>"
    append st_stato_coibent_idoneo_scamb.$prog_controllo        "<td align=center>$tel_stato_coibent_idoneo_scamb&nbsp;</td>"
    append st_disp_regloaz_controll_funzionanti.$prog_controllo "<td align=center>$tel_disp_regolaz_controll_funzionanti&nbsp;</td>"
    append st_firma.$prog_controllo                             "<td align=center>&nbsp;</td>"
}  

#simone: questa sezione serve solo per fare le colonne vuote restanti e dare una migliore impaginazione alla tabella
if {$num_row <$max_coll} {

    set colonne_da_aggiungere [expr $max_coll - $num_row]
    set contatore_ciclo_col_vuote 0

    while {$colonne_da_aggiungere > 0} {#rom02: aggiunta while, if e loro contenuto
	incr colonne_da_aggiungere -1
	incr contatore_ciclo_col_vuote

	if {$contatore_ciclo_col_vuote eq 10} {
	    break
	}

	append st_dt_contr.$prog_controllo                          "<td align=center width=9%>&nbsp;</td>"
	append st_tel_temp_est.$prog_controllo                      "<td align=center>&nbsp;</td>"
	append st_temp_mand_prim.$prog_controllo                    "<td align=center>&nbsp;</td>"
	append st_temp_rit_prim.$prog_controllo                     "<td align=center>&nbsp;</td>"
	append st_temp_mand_sec.$prog_controllo                     "<td align=center>&nbsp;</td>"
	append st_temp_rit_sec.$prog_controllo                      "<td align=center>&nbsp;</td>"
	append st_potenza_compatibile_dati_prog.$prog_controllo     "<td align=center>&nbsp;</td>"
	append st_stato_coibent_idoneo_scamb.$prog_controllo        "<td align=center>&nbsp;</td>"
	append st_disp_regloaz_controll_funzionanti.$prog_controllo "<td align=center>&nbsp;</td>"
	append st_firma.$prog_controllo                             "<td align=center>&nbsp;</td>"
    }


}
#fine creazione colonne vuote

};#fine foreach su generatori

if {$flag_gest_targa eq "T"} {#rom02: aggiunta if e suo contenuto
    set q_sel_dimp_padre "sel_dimp_padre_targa"
} else {
    set q_sel_dimp_padre "sel_dimp_padre"
}

set where_gen_prog_padre "0"
set where_cod_impianto_padre "0";#rom23
db_foreach $q_sel_gend_tel_padre "" {

incr prog_controllo

set where_gen_prog_padre $gen_prog_tel_padre
set where_cod_impianto_padre $cod_impianto_est_tel_padre;#rom23
set num_row 0

set st_num_gen.$prog_controllo    $gen_prog_est_tel_padre;#where_gen_prog_padre
set cod_impianto_gend_te.$prog_controllo $cod_impianto_est_tel_padre;#rom23
set st_dt_contr.$prog_controllo                          ""
set st_tel_temp_est.$prog_controllo                      ""
set st_temp_mand_prim.$prog_controllo                    ""
set st_temp_rit_prim.$prog_controllo                     ""
set st_temp_mand_sec.$prog_controllo                     ""
set st_temp_rit_sec.$prog_controllo                      ""
set st_potenza_compatibile_dati_prog.$prog_controllo     ""
set st_stato_coibent_idoneo_scamb.$prog_controllo        ""
set st_disp_regloaz_controll_funzionanti.$prog_controllo ""
set st_firma.$prog_controllo                             ""

db_foreach $q_sel_dimp_padre "" {#rom02 e suo contenuto
    
    incr num_dimp_tele
    if {$num_row == $max_coll} {
        incr prog_controllo
	set st_dt_contr.$prog_controllo                          ""
	set st_tel_temp_est.$prog_controllo                      ""
	set st_temp_mand_prim.$prog_controllo                    ""
	set st_temp_rit_prim.$prog_controllo                     ""
	set st_temp_mand_sec.$prog_controllo                     ""
	set st_temp_rit_sec.$prog_controllo                      ""
	set st_potenza_compatibile_dati_prog.$prog_controllo     ""
	set st_stato_coibent_idoneo_scamb.$prog_controllo        ""
	set st_disp_regloaz_controll_funzionanti.$prog_controllo ""
	set st_firma.$prog_controllo                             ""
	set cod_impianto_gend_te.$prog_controllo $cod_impianto_est_tel_padre;#rom23
	set num_row 0 
    }

    append st_dt_contr.$prog_controllo                          "<td align=center width=9%>$data_controllo&nbsp;</td>"
    append st_tel_temp_est.$prog_controllo                      "<td align=center>$tel_temp_est&nbsp;</td>"
    append st_temp_mand_prim.$prog_controllo                    "<td align=center>$tel_temp_mand_prim&nbsp;</td>"
    append st_temp_rit_prim.$prog_controllo                     "<td align=center>$tel_temp_rit_prim&nbsp;</td>"
    append st_temp_mand_sec.$prog_controllo                     "<td align=center>$tel_temp_mand_sec&nbsp;</td>"
    append st_temp_rit_sec.$prog_controllo                      "<td align=center>$tel_temp_rit_sec&nbsp;</td>"
    append st_potenza_compatibile_dati_prog.$prog_controllo     "<td align=center>$tel_potenza_compatibile_dati_prog&nbsp;</td>"
    append st_stato_coibent_idoneo_scamb.$prog_controllo        "<td align=center>$tel_stato_coibent_idoneo_scamb&nbsp;</td>"
    append st_disp_regloaz_controll_funzionanti.$prog_controllo "<td align=center>$tel_disp_regolaz_controll_funzionanti&nbsp;</td>"    
    append st_firma.$prog_controllo                             "<td align=center>&nbsp;</td>"
    incr num_row
}

#simone: questa sezione serve solo per fare le colonne vuote restanti e dare una migliore impaginazione alla tabella
if {$num_row <$max_coll} {

    set colonne_da_aggiungere [expr $max_coll - $num_row]
    set contatore_ciclo_col_vuote 0

    while {$colonne_da_aggiungere > 0} {#rom02: aggiunta while, if e loro contenuto
	incr colonne_da_aggiungere -1
	incr contatore_ciclo_col_vuote

	if {$contatore_ciclo_col_vuote eq 10} {
	    break
	}

	append st_dt_contr.$prog_controllo                          "<td align=center width=9%>&nbsp;</td>"
	append st_tel_temp_est.$prog_controllo                      "<td align=center>&nbsp;</td>"
	append st_temp_mand_prim.$prog_controllo                    "<td align=center>&nbsp;</td>"
	append st_temp_rit_prim.$prog_controllo                     "<td align=center>&nbsp;</td>"
	append st_temp_mand_sec.$prog_controllo                     "<td align=center>&nbsp;</td>"
	append st_temp_rit_sec.$prog_controllo                      "<td align=center>&nbsp;</td>"
	append st_potenza_compatibile_dati_prog.$prog_controllo     "<td align=center>&nbsp;</td>"
	append st_stato_coibent_idoneo_scamb.$prog_controllo        "<td align=center>&nbsp;</td>"
	append st_disp_regloaz_controll_funzionanti.$prog_controllo "<td align=center>&nbsp;</td>"
	append st_firma.$prog_controllo                             "<td align=center>&nbsp;</td>"
    }


}
#fine creazione colonne vuote

};#fine foreach su generatori

set num_tabella_gen 0
#set num_rows 0
#set cambio_pagina ""
while {$num_tabella_gen < $prog_controllo} {#rom02: aggiunta while, if e loro contenuto
    incr num_tabella_gen
    if {$num_tabella_gen eq 100} {
        break
    }
#    if {$num_rows == "5"} {
#        append cambio_pagina "
#    <!-- PAGE BREAK -->
#    $table_con_header_per_tutte_le_pagine
#"
#        set num_rows 0
#    } else {
#        set cambio_pagina ""
#    }
    
    if {!($num_row==0 && $num_dimp_tele==0)} {
	
	set cod_impianto_gend_te_html [set cod_impianto_gend_te.$num_tabella_gen];#rom23
	#rom23 Aggiunta variabile cod_impianto_gend_te_html per visualizzare il codice impianto dell'RCEE che sto stampando.
	append libretto "
     <table width=100% align=center border=1>
       <tr>
          <td align=left width=20%>Scambiatore<br>SC [set st_num_gen.$num_tabella_gen]</td>
          <td align=left width=80%>Compilare una scheda per ogni scambiatore dell'impianto $cod_impianto_gend_te_html</td>
       </tr>
     </table><br>
     <table width=100% align=center border=1>
       <tr>
          <td align=right height=5% width=37%><b>DATA</b></td>[set st_dt_contr.$num_tabella_gen]
       </tr>
       <tr>
         <td nowrap height=5% valign=center align=left colspan=[expr $max_coll+1] bgcolor=\"E1E1E1\"><b>VALORI MISURATI</b></td>
       </tr>
       <tr>
         <td nowrap height=5% valign=center align=left>Temperatura esterna (°C)</td>[set st_tel_temp_est.$num_tabella_gen]
       </tr>
       <tr>
         <td nowrap height=5% valign=center align=left>Temperatura Mandata Primario (°C)</td>[set st_temp_mand_prim.$num_tabella_gen]
       </tr>
       <tr>
         <td nowrap height=5% valign=center align=left>Temperatura Ritorno Primario (°C)</td>[set st_temp_rit_prim.$num_tabella_gen]
       </tr>
       <tr>
         <td nowrap height=5% valign=center align=left>Temperatura Mandata Secondario (°C)</td>[set st_temp_mand_sec.$num_tabella_gen]
       </tr>
       <tr>
         <td nowrap height=5% valign=center align=left>Temperatura Ritorno Secondario (°C)</td>[set  st_temp_rit_sec.$num_tabella_gen] 
       </tr>
       <tr>
         <td nowrap height=5% valign=center align=left>Portata fluido primario (m&sup3;/h)</td><td colspan=$max_coll>&nbsp;</td>
       </tr>
       <tr>
         <td nowrap height=5% valign=center align=left>Portata Termica nominale totale (kW)</td><td colspan=$max_coll>&nbsp;</td>
       </tr>
       <tr>
         <td nowrap height=5% valign=center align=left colspan=[expr $max_coll +1] bgcolor=\"E1E1E1\"><b>ALTRE VERIFICHE</b></td>
       </tr>
       <tr>
         <td nowrap height=5% valign=center align=left>Potenza compatibile con i dati di Progetto</td>[set st_potenza_compatibile_dati_prog.$num_tabella_gen]
       </tr>
       <tr>
         <td nowrap height=5% valign=center align=left>Stato Coibentazioni idoneo</td>[set st_potenza_compatibile_dati_prog.$num_tabella_gen]
       </tr>
       <tr>
         <td nowrap height=5% valign=center align=left>Dispositivi di Regolazione e Controllo<br><small>/assenza di trafilamenti sulla valvola di regolazione)</small></td>[set st_disp_regloaz_controll_funzionanti.$num_tabella_gen]
       </tr>
       <tr>
         <td nowrap height=5% valign=center align=right><b>FIRMA</b></td>[set st_firma.$num_tabella_gen]
       </tr>
       </table>"

        append libretto "
    <!-- PAGE BREAK -->
    $table_con_header_per_tutte_le_pagine
"

} 

};#rom02
if {$num_row==0 && $num_dimp_tele==0} {
    append libretto "
    <tr>
       <td colspan=5>Non esistono allegati R3</td>
    </tr>"

append libretto "
    <!-- PAGE BREAK -->
    $table_con_header_per_tutte_le_pagine
"

}

set where_flag_tracciato "";#sbianco il where perchè il sel_dimp è utilizzato anche sotto

append libretto "</table>
    <table width=100%>
          <tr>
             <td>&nbsp;</td>
          <tr>
    </table>"

#append libretto "
#    <!-- PAGE BREAK -->
#    $table_con_header_per_tutte_le_pagine
#"

#rom02 fine aggiunte per sezione 11.3

########inizio sezione 11.4

append libretto "
    <table width=100% border=1>
          <tr>
             <td align=center bgcolor=\"E1E1E1\"><big><b>11.Risultati della prima verifica effettuata dall'installatore e<br>delle verifiche periodiche effettuate dal manutentore</b></big></td>
          </tr>
    </table>"


append libretto "
    <table width=100% align=center>
          <tr>
             <td>&nbsp;</td>
          </tr>
          <tr>
             <td align=center><b>11.4 Cogeneratore/Trigeneratore</b></td>
          </tr>
          <tr>
             <td>&nbsp;</td>
          </tr>
    </table>"

#simone: i dimp devono essere visualizzati in ordine di generatore

set prog_controllo 0

set num_row "0"
set where_flag_tracciato " and flag_tracciato = 'R4'"
set num_dimp_coge 0
db_foreach sel_gend_con "" {


incr prog_controllo
set num_row 0

set where_gen_prog $gen_prog

set st_num_gen.$prog_controllo    $gen_prog_est;#where_gen_prog
set st_dt_contr.$prog_controllo   ""
set st_temp_aria_comburente.$prog_controllo ""
set st_temp_acqua_uscita.$prog_controllo    ""
set st_temp_acqua_ingresso.$prog_controllo  ""
set st_temp_acqua_motore.$prog_controllo    ""
set st_temp_fumi_valle.$prog_controllo      ""
set st_temp_fumi_monte.$prog_controllo      ""
set st_pot_elett_morsetti.$prog_controllo   ""
set st_emissioni_monossido.$prog_controllo  ""
set st_firma.$prog_controllo             ""
set st_cog_sovrafreq_soglia.$prog_controllo ""
set st_cog_sovrafreq_tempo.$prog_controllo  ""
set st_cog_sottofreq_soglia.$prog_controllo ""
set st_cog_sottofreq_tempo.$prog_controllo  ""
set st_cog_sovraten_soglia.$prog_controllo  ""
set st_cog_sovraten_tempo.$prog_controllo   ""
set st_cog_sottoten_soglia.$prog_controllo  ""
set st_cog_sottoten_tempo.$prog_controllo   ""
set cod_impianto_gend_co.$prog_controllo $cod_impianto_gend_co;#rom23

db_foreach sel_dimp__ "    
select coalesce(iter_edit_data(a.data_controllo),'&nbsp;') as data_controllo
     , iter_edit_num(cog_temp_aria_comburente,2)   as cog_temp_aria_comburente
     , iter_edit_num(cog_temp_h2o_uscita,2)        as cog_temp_h2o_uscita 
     , iter_edit_num(cog_temp_h2o_ingresso,2)      as cog_temp_h2o_ingresso
     , iter_edit_num(cog_temp_h2o_motore,2)        as cog_temp_h2o_motore
     , iter_edit_num(cog_temp_fumi_valle,2)        as cog_temp_fumi_valle
     , iter_edit_num(cog_temp_fumi_monte,2)        as cog_temp_fumi_monte
     , iter_edit_num(cog_potenza_morsetti_gen,2)   as cog_potenza_morsetti_gen
     , iter_edit_num(cog_emissioni_monossido_co,2) as cog_emissioni_monossido_co
     , iter_edit_num(a.cog_sovrafreq_soglia1,0) as cog_sovrafreq_soglia1 
     , iter_edit_num(a.cog_sovrafreq_tempo1 ,0) as cog_sovrafreq_tempo1  
     , iter_edit_num(a.cog_sottofreq_soglia1,0) as cog_sottofreq_soglia1 
     , iter_edit_num(a.cog_sottofreq_tempo1 ,0) as cog_sottofreq_tempo1  
     , iter_edit_num(a.cog_sovraten_soglia1 ,0) as cog_sovraten_soglia1  
     , iter_edit_num(a.cog_sovraten_tempo1  ,0) as cog_sovraten_tempo1   
     , iter_edit_num(a.cog_sottoten_soglia1 ,0) as cog_sottoten_soglia1  
     , iter_edit_num(a.cog_sottoten_tempo1  ,0) as cog_sottoten_tempo1   
     , iter_edit_num(a.cog_sovrafreq_soglia2,0) as cog_sovrafreq_soglia2 
     , iter_edit_num(a.cog_sovrafreq_tempo2 ,0) as cog_sovrafreq_tempo2  
     , iter_edit_num(a.cog_sottofreq_soglia2,0) as cog_sottofreq_soglia2 
     , iter_edit_num(a.cog_sottofreq_tempo2 ,0) as cog_sottofreq_tempo2  
     , iter_edit_num(a.cog_sovraten_soglia2 ,0) as cog_sovraten_soglia2  
     , iter_edit_num(a.cog_sovraten_tempo2  ,0) as cog_sovraten_tempo2   
     , iter_edit_num(a.cog_sottoten_soglia2 ,0) as cog_sottoten_soglia2  
     , iter_edit_num(a.cog_sottoten_tempo2  ,0) as cog_sottoten_tempo2   
     , iter_edit_num(a.cog_sovrafreq_soglia3,0) as cog_sovrafreq_soglia3 
     , iter_edit_num(a.cog_sovrafreq_tempo3 ,0) as cog_sovrafreq_tempo3  
     , iter_edit_num(a.cog_sottofreq_soglia3,0) as cog_sottofreq_soglia3 
     , iter_edit_num(a.cog_sottofreq_tempo3 ,0) as cog_sottofreq_tempo3  
     , iter_edit_num(a.cog_sovraten_soglia3 ,0) as cog_sovraten_soglia3  
     , iter_edit_num(a.cog_sovraten_tempo3  ,0) as cog_sovraten_tempo3   
     , iter_edit_num(a.cog_sottoten_soglia3 ,0) as cog_sottoten_soglia3  
     , iter_edit_num(a.cog_sottoten_tempo3  ,0) as cog_sottoten_tempo3 
      from coimdimp a
     where a.cod_impianto = :cod_impianto
     $where_flag_tracciato
       and gen_prog=:where_gen_prog
     order by data_controllo desc
" {
    incr num_dimp_coge
    if {$num_row == $max_coll} {
	incr prog_controllo
        set st_num_gen.$prog_controllo    $gen_prog_est;#where_gen_prog
	set st_dt_contr.$prog_controllo   ""
	set st_temp_aria_comburente.$prog_controllo ""
	set st_temp_acqua_uscita.$prog_controllo    ""
	set st_temp_acqua_ingresso.$prog_controllo  ""
	set st_temp_acqua_motore.$prog_controllo    ""
	set st_temp_fumi_valle.$prog_controllo      ""
	set st_temp_fumi_monte.$prog_controllo      ""
	set st_pot_elett_morsetti.$prog_controllo   ""
	set st_emissioni_monossido.$prog_controllo  ""
	set st_firma.$prog_controllo                ""
	set st_cog_sovrafreq_soglia.$prog_controllo ""
	set st_cog_sovrafreq_tempo.$prog_controllo  ""
	set st_cog_sottofreq_soglia.$prog_controllo ""
	set st_cog_sottofreq_tempo.$prog_controllo  ""
	set st_cog_sovraten_soglia.$prog_controllo  ""
	set st_cog_sovraten_tempo.$prog_controllo   ""
	set st_cog_sottoten_soglia.$prog_controllo  ""
	set st_cog_sottoten_tempo.$prog_controllo   ""

        set num_row 0
    }
    
    incr num_row

    append st_dt_contr.$prog_controllo  "<td align=center width=9%>$data_controllo</td>"
    append st_temp_aria_comburente.$prog_controllo      "<td align=center>$cog_temp_aria_comburente&nbsp;</td>"
    append st_temp_acqua_uscita.$prog_controllo         "<td align=center>$cog_temp_h2o_uscita&nbsp;</td>"
    append st_temp_acqua_ingresso.$prog_controllo       "<td align=center>$cog_temp_h2o_ingresso&nbsp;</td>"
    append st_temp_acqua_motore.$prog_controllo         "<td align=center>$cog_temp_h2o_motore&nbsp;</td>"
    append st_temp_fumi_valle.$prog_controllo           "<td align=center>$cog_temp_fumi_valle&nbsp;</td>"
    append st_temp_fumi_monte.$prog_controllo           "<td align=center>$cog_temp_fumi_monte&nbsp;</td>"
    append st_pot_elett_morsetti.$prog_controllo        "<td align=center>$cog_potenza_morsetti_gen&nbsp;</td>"
    append st_emissioni_monossido.$prog_controllo       "<td align=center>$cog_emissioni_monossido_co&nbsp;</td>"
    append st_firma.$prog_controllo                     "<td align=center>&nbsp;</td>"
    append st_cog_sovrafreq_soglia.$prog_controllo "<td align=center>$cog_sovrafreq_soglia1 / $cog_sovrafreq_soglia2 / $cog_sovrafreq_soglia3</td>"
    append st_cog_sovrafreq_tempo.$prog_controllo  "<td align=center>$cog_sovrafreq_tempo1 / $cog_sovrafreq_tempo2 / $cog_sovrafreq_tempo3</td>"
    append st_cog_sottofreq_soglia.$prog_controllo "<td align=center>$cog_sottofreq_soglia1 / $cog_sottofreq_soglia2 / $cog_sottofreq_soglia3</td>"
    append st_cog_sottofreq_tempo.$prog_controllo  "<td align=center>$cog_sottofreq_tempo1 / $cog_sottofreq_tempo2 / $cog_sottofreq_tempo3</td>"
    append st_cog_sovraten_soglia.$prog_controllo  "<td align=center>$cog_sovraten_soglia1 / $cog_sovraten_soglia2 / $cog_sovraten_soglia3</td>"
    append st_cog_sovraten_tempo.$prog_controllo   "<td align=center>$cog_sovraten_tempo1 / $cog_sovraten_tempo2 / $cog_sovraten_tempo3</td>"
    append st_cog_sottoten_soglia.$prog_controllo  "<td align=center>$cog_sottoten_soglia1 / $cog_sottoten_soglia2 / $cog_sottoten_soglia3</td>"
    append st_cog_sottoten_tempo.$prog_controllo   "<td align=center>$cog_sottoten_tempo1 / $cog_sottoten_tempo2 / $cog_sottoten_tempo3</td>"

}

#simone: questa sezione serve solo per fare le colonne vuote restanti e dare una migliore impaginazione alla tabella
if {$num_row <$max_coll} {

    set colonne_da_aggiungere [expr $max_coll - $num_row]
    set contatore_ciclo_col_vuote 0

    while {$colonne_da_aggiungere > 0} {#rom02: aggiunta while, if e loro contenuto
	incr colonne_da_aggiungere -1
	incr contatore_ciclo_col_vuote

	if {$contatore_ciclo_col_vuote eq 10} {
	    break
	}

	append st_dt_contr.$prog_controllo                  "<td align=left width=9%>&nbsp;</td>"
	append st_temp_aria_comburente.$prog_controllo      "<td align=center>&nbsp;</td>"
	append st_temp_acqua_uscita.$prog_controllo         "<td align=center>&nbsp;</td>"
	append st_temp_acqua_ingresso.$prog_controllo       "<td align=center>&nbsp;</td>"
	append st_temp_acqua_motore.$prog_controllo         "<td align=center>&nbsp;</td>"
	append st_temp_fumi_valle.$prog_controllo           "<td align=center>&nbsp;</td>"
	append st_temp_fumi_monte.$prog_controllo           "<td align=center>&nbsp;</td>"
	append st_pot_elett_morsetti.$prog_controllo        "<td align=center>&nbsp;</td>"
	append st_emissioni_monossido.$prog_controllo       "<td align=center>&nbsp;</td>"
	append st_firma.$prog_controllo                     "<td align=center>&nbsp;</td>"
	append st_cog_sovrafreq_soglia.$prog_controllo "<td align=center>&nbsp;</td>"
	append st_cog_sovrafreq_tempo.$prog_controllo  "<td align=center>&nbsp;</td>"
	append st_cog_sottofreq_soglia.$prog_controllo "<td align=center>&nbsp;</td>"
	append st_cog_sottofreq_tempo.$prog_controllo  "<td align=center>&nbsp;</td>"
	append st_cog_sovraten_soglia.$prog_controllo  "<td align=center>&nbsp;</td>"
	append st_cog_sovraten_tempo.$prog_controllo   "<td align=center>&nbsp;</td>"
	append st_cog_sottoten_soglia.$prog_controllo  "<td align=center>&nbsp;</td>"
	append st_cog_sottoten_tempo.$prog_controllo   "<td align=center>&nbsp;</td>"

    }

}

#fine creazione colonne vuote

};#fine foreach su generatori

if {$flag_gest_targa eq "T"} {#sim04: aggiunta if e suo contenuto
    set q_sel_dimp_padre "sel_dimp_padre_targa"
} else {
    set q_sel_dimp_padre "sel_dimp_padre"
}

set where_gen_prog_padre "0"
set where_cod_impianto_padre "0";#rom23
db_foreach $q_sel_gend_con_padre "" {

    incr prog_controllo
    set num_row 0
    
    set where_gen_prog_padre $gen_prog_con_padre
    set where_cod_impianto_padre $cod_impianto_est_co_padre;#rom23
    
    set st_num_gen.$prog_controllo    $gen_prog_est_con_padre;#where_gen_prog_padre
    set cod_impianto_gend_co.$prog_controllo $cod_impianto_est_co_padre;#rom23
    set st_dt_contr.$prog_controllo   ""
    set st_temp_aria_comburente.$prog_controllo ""
    set st_temp_acqua_uscita.$prog_controllo    ""
    set st_temp_acqua_ingresso.$prog_controllo  ""
    set st_temp_acqua_motore.$prog_controllo    ""
    set st_temp_fumi_valle.$prog_controllo      ""
    set st_temp_fumi_monte.$prog_controllo      ""
    set st_pot_elett_morsetti.$prog_controllo   ""
    set st_emissioni_monossido.$prog_controllo  ""
    set st_firma.$prog_controllo             ""
    set st_cog_sovrafreq_soglia.$prog_controllo ""
    set st_cog_sovrafreq_tempo.$prog_controllo  ""
    set st_cog_sottofreq_soglia.$prog_controllo ""
    set st_cog_sottofreq_tempo.$prog_controllo  ""
    set st_cog_sovraten_soglia.$prog_controllo  ""
    set st_cog_sovraten_tempo.$prog_controllo   ""
    set st_cog_sottoten_soglia.$prog_controllo  ""
    set st_cog_sottoten_tempo.$prog_controllo   ""    

    db_foreach $q_sel_dimp_padre "" {
	
	incr num_dimp_coge
        if {$num_row == $max_coll} {
	    
	    incr prog_controllo
	    set st_num_gen.$prog_controllo    $gen_prog_est_con_padre;#where_gen_prog_padre
	    set st_dt_contr.$prog_controllo   ""
	    set st_temp_aria_comburente.$prog_controllo ""
	    set st_temp_acqua_uscita.$prog_controllo    ""
	    set st_temp_acqua_ingresso.$prog_controllo  ""
	    set st_temp_acqua_motore.$prog_controllo    ""
	    set st_temp_fumi_valle.$prog_controllo      ""
	    set st_temp_fumi_monte.$prog_controllo      ""
	    set st_pot_elett_morsetti.$prog_controllo   ""
	    set st_emissioni_monossido.$prog_controllo  ""
	    set st_firma.$prog_controllo             ""
	    set st_cog_sovrafreq_soglia.$prog_controllo ""
	    set st_cog_sovrafreq_tempo.$prog_controllo  ""
	    set st_cog_sottofreq_soglia.$prog_controllo ""
	    set st_cog_sottofreq_tempo.$prog_controllo  ""
	    set st_cog_sovraten_soglia.$prog_controllo  ""
	    set st_cog_sovraten_tempo.$prog_controllo   ""
	    set st_cog_sottoten_soglia.$prog_controllo  ""
	    set st_cog_sottoten_tempo.$prog_controllo   ""    
	    set cod_impianto_gend_co.$prog_controllo $cod_impianto_est_co_padre;#rom23
	    set num_row 0
	}	    
	
	
	append st_dt_contr.$prog_controllo  "<td align=center width=9%>$data_controllo</td>"
	append st_temp_aria_comburente.$prog_controllo      "<td align=center>$cog_temp_aria_comburente&nbsp;</td>"
	append st_temp_acqua_uscita.$prog_controllo         "<td align=center>$cog_temp_h2o_uscita&nbsp;</td>"
	append st_temp_acqua_ingresso.$prog_controllo       "<td align=center>$cog_temp_h2o_ingresso&nbsp;</td>"
	append st_temp_acqua_motore.$prog_controllo         "<td align=center>$cog_temp_h2o_motore&nbsp;</td>"
	append st_temp_fumi_valle.$prog_controllo           "<td align=center>$cog_temp_fumi_valle&nbsp;</td>"
	append st_temp_fumi_monte.$prog_controllo           "<td align=center>$cog_temp_fumi_monte&nbsp;</td>"
	append st_pot_elett_morsetti.$prog_controllo        "<td align=center>$cog_potenza_morsetti_gen&nbsp;</td>"
	append st_emissioni_monossido.$prog_controllo       "<td align=center>$cog_emissioni_monossido_co&nbsp;</td>"
	append st_firma.$prog_controllo                     "<td align=center>&nbsp;</td>"
	append st_cog_sovrafreq_soglia.$prog_controllo "<td align=center>$cog_sovrafreq_soglia1 / $cog_sovrafreq_soglia2 / $cog_sovrafreq_soglia3</td>"
	append st_cog_sovrafreq_tempo.$prog_controllo  "<td align=center>$cog_sovrafreq_tempo1 / $cog_sovrafreq_tempo2 / $cog_sovrafreq_tempo3</td>"
	append st_cog_sottofreq_soglia.$prog_controllo "<td align=center>$cog_sottofreq_soglia1 / $cog_sottofreq_soglia2 / $cog_sottofreq_soglia3</td>"
	append st_cog_sottofreq_tempo.$prog_controllo  "<td align=center>$cog_sottofreq_tempo1 / $cog_sottofreq_tempo2 / $cog_sottofreq_tempo3</td>"
	append st_cog_sovraten_soglia.$prog_controllo  "<td align=center>$cog_sovraten_soglia1 / $cog_sovraten_soglia2 / $cog_sovraten_soglia3</td>"
	append st_cog_sovraten_tempo.$prog_controllo   "<td align=center>$cog_sovraten_tempo1 / $cog_sovraten_tempo2 / $cog_sovraten_tempo3</td>"
	append st_cog_sottoten_soglia.$prog_controllo  "<td align=center>$cog_sottoten_soglia1 / $cog_sottoten_soglia2 / $cog_sottoten_soglia3</td>"
	append st_cog_sottoten_tempo.$prog_controllo   "<td align=center>$cog_sottoten_tempo1 / $cog_sottoten_tempo2 / $cog_sottoten_tempo3</td>"
	incr num_row
    }
#simone: questa sezione serve solo per fare le colonne vuote restanti e dare una migliore impaginazione alla tabella
if {$num_row <$max_coll} {

    set colonne_da_aggiungere [expr $max_coll - $num_row]
    set contatore_ciclo_col_vuote 0

    while {$colonne_da_aggiungere > 0} {#rom02: aggiunta while, if e loro contenuto
	incr colonne_da_aggiungere -1
	incr contatore_ciclo_col_vuote

	if {$contatore_ciclo_col_vuote eq 10} {
	    break
	}

	append st_dt_contr.$prog_controllo                  "<td align=left width=9%>&nbsp;</td>"
	append st_temp_aria_comburente.$prog_controllo      "<td align=center>&nbsp;</td>"
	append st_temp_acqua_uscita.$prog_controllo         "<td align=center>&nbsp;</td>"
	append st_temp_acqua_ingresso.$prog_controllo       "<td align=center>&nbsp;</td>"
	append st_temp_acqua_motore.$prog_controllo         "<td align=center>&nbsp;</td>"
	append st_temp_fumi_valle.$prog_controllo           "<td align=center>&nbsp;</td>"
	append st_temp_fumi_monte.$prog_controllo           "<td align=center>&nbsp;</td>"
	append st_pot_elett_morsetti.$prog_controllo        "<td align=center>&nbsp;</td>"
	append st_emissioni_monossido.$prog_controllo       "<td align=center>&nbsp;</td>"
	append st_firma.$prog_controllo                     "<td align=center>&nbsp;</td>"
	append st_cog_sovrafreq_soglia.$prog_controllo "<td align=center>&nbsp;</td>"
	append st_cog_sovrafreq_tempo.$prog_controllo  "<td align=center>&nbsp;</td>"
	append st_cog_sottofreq_soglia.$prog_controllo "<td align=center>&nbsp;</td>"
	append st_cog_sottofreq_tempo.$prog_controllo  "<td align=center>&nbsp;</td>"
	append st_cog_sovraten_soglia.$prog_controllo  "<td align=center>&nbsp;</td>"
	append st_cog_sovraten_tempo.$prog_controllo   "<td align=center>&nbsp;</td>"
	append st_cog_sottoten_soglia.$prog_controllo  "<td align=center>&nbsp;</td>"
	append st_cog_sottoten_tempo.$prog_controllo   "<td align=center>&nbsp;</td>"

    }

}

#fine creazione colonne vuote

};#fine foreach su generatori

set num_tabella_gen 0
set cod_dimp_precedente ""
set st_rispetta_indice_bacharach_precedente ""
set st_co_fumi_secchi_precedente ""
set st_rend_magg_o_ugua_rend_min_precedente ""

while {$num_tabella_gen < $prog_controllo} {
    incr num_tabella_gen
    if {$num_tabella_gen eq 100} {#sim09
        break
    }

    if {!($num_row==0 && $num_dimp_coge==0)} {

	set cod_impianto_gend_co_html [set cod_impianto_gend_co.$num_tabella_gen];#rom23
	#rom23 Aggiunta variabile cod_impianto_gend_co_html per visualizzare il codice impianto dell'RCEE che sto stampando.
	append libretto "
     <table width=100% align=center border=1>
       <tr>
          <td align=left width=20%>Cogeneratore/Trigenertore<br>CG [set st_num_gen.$num_tabella_gen]</td>
          <td align=left width=80%>Compilare una scheda per ogni cogeneratore/trigenertore dell'impianto $cod_impianto_gend_co_html</td>
       </tr>
     </table><br>
     <table width=100% align=center border=1>
       <tr>
          <td align=right width=37%><b>DATA</b></td>[set st_dt_contr.$num_tabella_gen]
       </tr>
       <tr>
          <td nowrap height=4% valign=center align=left>Temperatura aria comburente (°C)</td>[set st_temp_aria_comburente.$num_tabella_gen]
       </tr>
       <tr>
          <td nowrap height=4% valign=center align=left>Temperatura acqua in uscita (°C)</td>[set st_temp_acqua_uscita.$num_tabella_gen]
       </tr>
       <tr>
          <td nowrap height=4% valign=center align=left>Temperatura acqua in ingresso (°C)</td>[set st_temp_acqua_ingresso.$num_tabella_gen]
       </tr>
       <tr>
          <td nowrap height=4% valign=center align=left>Temperatura acqua motore<br>(solo m.c.i.) (°C)</td>[set st_temp_acqua_motore.$num_tabella_gen]
       </tr>
       <tr>
          <td nowrap height=4% valign=center align=left>Temperatura fumi a valle<br>dello scambiatore fumi (°C)</td>[set st_temp_fumi_valle.$num_tabella_gen]
       </tr>
       <tr>
          <td nowrap height=4% valign=center align=left>Temperatura fumi a monte<br>dello scambiatore fumi (°C)</td>[set st_temp_fumi_monte.$num_tabella_gen]
       </tr>
       <tr>
          <td nowrap height=4% valign=center align=left>Potenza elettrica ai morsetti (kW)</td>[set st_pot_elett_morsetti.$num_tabella_gen]
       </tr>
       <tr>
          <td nowrap height=4% valign=center align=left>Emissioni di monossido di carbonio CO <br>(mg/Nm&sup3 riportati al 5% di O2 nei fumi)</td>[set st_emissioni_monossido.$num_tabella_gen]
       </tr>
       <tr>
         <td nowrap height=4% valign=center align=left colspan=[expr $max_coll+1] bgcolor=\"E1E1E1\"><b>Protezione di interfaccia con la rete elettrica, verifica per ciascuna fase. L1/L2/L3</td>
       </tr>
       <tr>
          <td nowrap height=4% valign=center align=left>Sovrafrequenza: soglia di intervento (Hz)</td>[set st_cog_sovrafreq_soglia.$num_tabella_gen]
       </tr>
       <tr>
          <td nowrap height=4% valign=center align=left>Sovrafrequenza: tempo di intervento (s)</td>[set st_cog_sovrafreq_tempo.$num_tabella_gen]</tr>
       <tr>
          <td nowrap height=4% valign=center align=left>Sottofrequenza: soglia di intervento (Hz)</td>[set st_cog_sottofreq_soglia.$num_tabella_gen]
       </tr>
       <tr>
          <td nowrap height=4% valign=center align=left>Sottofrequenza: tempo di intervento (s)</td>[set st_cog_sottofreq_tempo.$num_tabella_gen]
       </tr>
       <tr>
          <td nowrap height=4% valign=center align=left>Sovratensione: soglia di intervento (V)</td>[set st_cog_sovraten_soglia.$num_tabella_gen]
       </tr>
       <tr>
          <td nowrap height=4% valign=center align=left>Sovratensione: tempo di intervento (s)</td>[set st_cog_sovraten_tempo.$num_tabella_gen]
       </tr>
       <tr>
          <td nowrap height=4% valign=center align=left>Sottotensione: soglia di intervento (V)</td>[set st_cog_sottoten_soglia.$num_tabella_gen]
       </tr>
       <tr>
          <td nowrap height=4% valign=center align=left>Sottotensione: tempo di intervento (s)</td>[set st_cog_sottoten_tempo.$num_tabella_gen]
       </tr>
       <tr>
         <td nowrap height=4% valign=center align=right><b>FIRMA</b></td>[set st_firma.$num_tabella_gen]
       </tr>
   </table>
"
    
	append libretto "
    <!-- PAGE BREAK -->
    $table_con_header_per_tutte_le_pagine
	"
    }
}

if {$num_row==0 && $num_dimp_coge==0} {
    append libretto "
    <tr>
       <td colspan=4>Non esistono allegati R4</td>
    </tr>"

append libretto "
    <!-- PAGE BREAK -->
    $table_con_header_per_tutte_le_pagine
"

}



########fine sezione 11.4


if {$coimtgen(regione) ne "MARCHE"} {

# Allegati 284
append libretto "
<table width=100% align=center>
       <tr>
          <td align=center colspan=4><b>Allegati 284</b></td>
       </tr>
       <tr>
          <td colspan=4>&nbsp;</td>
             </tr>"

db_foreach sel_noveb "" {
    append libretto "
       <tr>
          <td align=center>Data Consegna</td>
          <td align=center>$data_consegna</td>
          <td align=center>Manutentore</td>
          <td>$manutentore</td>
       </tr>
       <tr>
          <td colspan=4>&nbsp;</td>  
       </tr>"
} if_no_rows {
    append libretto "
    <tr>
       <td colspan=2>Non esistono Allegati 284</td>
    </tr>"
}

append libretto "</table>
    <table width=100%>
          <tr>
             <td>&nbsp;</td>
          <tr>
    </table>"




append libretto "</table><!-- PAGE BREAK -->
    $table_con_header_per_tutte_le_pagine"


}

append libretto "
    <table width=100% border=1>
          <tr>
             <td align=center bgcolor=\"E1E1E1\"><big><b>12. Interventi di controllo efficienza energetica</b></big></td>
          </tr>
    </table>"

append libretto "
<br>
<table width=100%>
 <tr>
   <td align=center>Allegare al presente libretto i relativi rapporti di intervento</td>
</tr>
</table>
<br>
<table width=100% border=1>
<tr>
  <td align=center>Data<br>controllo</td>
  <td align=center>Ragione sociale manutentore</td>
  <td align=center>CCIAA</td>
  <td align=center>Tipo<br>Allegato</td>
  <td align=center><small>Raccomandazioni</small><br>Si&nbsp;&nbsp;&nbsp;No</td>
  <td align=center><small>Prescrizioni</small><br>Si&nbsp;&nbsp;&nbsp;No</td>
</tr>
"
set where_flag_tracciato ""
set where_gen_prog_padre "gen_prog"
db_foreach sel_dimp "" {

    set img_raccomandazioni_si $img_unchecked
    set img_raccomandazioni_no $img_unchecked
    set img_prescrizioni_si    $img_unchecked
    set img_prescrizioni_no    $img_unchecked

    if {[string trim $raccomandazioni] ne ""} {
	set img_raccomandazioni_si $img_checked
    } else {
	set img_raccomandazioni_no $img_checked
    }

    if {[string trim $prescrizioni] ne ""} {
	set img_prescrizioni_si $img_checked
    } else {
	set img_prescrizioni_no $img_checked
    }

    set reg_imprese ""
    set manutentore_dimp ""

    db_0or1row q "select reg_imprese
                    , coalesce(cognome,'') || ' ' || coalesce(nome,'') as manutentore_dimp
                 from coimmanu 
                where cod_manutentore = :cod_manutentore_dimp"

append libretto "
<tr>
  <td align=center>$data_controllo</td>
  <td align=center>$manutentore_dimp</td>
  <td align=center>$reg_imprese&nbsp;</td>
  <td align=center>$flag_tracciato</td>
  <td align=center>$img_raccomandazioni_si&nbsp;&nbsp;&nbsp;$img_raccomandazioni_no</td>
  <td align=center>$img_prescrizioni_si&nbsp;&nbsp;&nbsp;$img_prescrizioni_no</td>
</tr>
"

}

if {$flag_gest_targa eq "T"} {#sim04: aggiunta if e suo contenuto
    set q_sel_dimp_padre "sel_dimp_padre_targa"
} else {
    set q_sel_dimp_padre "sel_dimp_padre"
}

db_foreach $q_sel_dimp_padre "" {

    set img_raccomandazioni_si $img_unchecked
    set img_raccomandazioni_no $img_unchecked
    set img_prescrizioni_si    $img_unchecked
    set img_prescrizioni_no    $img_unchecked

    if {[string trim $raccomandazioni] ne ""} {
	set img_raccomandazioni_si $img_checked
    } else {
	set img_raccomandazioni_no $img_checked
    }

    if {[string trim $prescrizioni] ne ""} {
	set img_prescrizioni_si $img_checked
    } else {
	set img_prescrizioni_no $img_checked
    }

    set reg_imprese ""
    set manutentore_dimp ""

    db_0or1row q "select reg_imprese
                    , coalesce(cognome,'') || ' ' || coalesce(nome,'') as manutentore_dimp
                 from coimmanu 
                where cod_manutentore = :cod_manutentore_dimp"

append libretto "
<tr>
  <td align=center>$data_controllo</td>
  <td align=center>$manutentore_dimp</td>
  <td align=center>$reg_imprese&nbsp;</td>
  <td align=center>$flag_tracciato</td>
  <td align=center>$img_raccomandazioni_si&nbsp;&nbsp;&nbsp;$img_raccomandazioni_no</td>
  <td align=center>$img_prescrizioni_si&nbsp;&nbsp;&nbsp;$img_prescrizioni_no</td>
</tr>
"

}



####inizio simone rapporti di verifica

append libretto "</table><!-- PAGE BREAK -->
    $table_con_header_per_tutte_le_pagine"

append libretto "
    <table width=100% border=1>
          <tr>
             <td align=center bgcolor=\"E1E1E1\"><big><b>13. Risultati delle ispezioni periodiche effettauate a cura dell'ente competente</b></big></td>
          </tr>
    </table>"


append libretto "
    <table width=100%>
          <tr>
             <td>&nbsp;</td>
          <tr>
    </table>
"

db_foreach sel_cimp "" {
    if {[string is space $nome_opve]} {
	set nome_opve "&nbsp;"
    }
    if {$coimtgen(ente) eq "PUD" || $coimtgen(ente) eq "PGO" || $coimtgen(ente) eq "PPN"} {
	append desc_esito " - $numfatt - $data_fatt"
    }


    append libretto "
<table width=100% border=0>
<tr>
<td>
  <table width=100% border=0>
  <tr>
  <td>
         <table width=100%>
         <tr>
          <td colspan=2>Ispezione eseguita il $data_controllo da $nome_opve</td>
         </tr>
         <tr>
          <td colspan=2>&nbsp;</td>
         </tr>
         <tr>
          <td colspan=2>Per conto di</td>
         </tr>
         <tr>
          <td colspan=2>ENTE COMPETENTE $nome_ente</td>
         </tr>
         <tr>
          <td colspan=2>&nbsp;</td>
         </tr>
         <tr>
          <td colspan=2>La verifica della documentazione impianto, dell'avvenuto controllo ed eventuale manutenzione e, ove previsto, del rendimento della combustione, ha avuto esito: $desc_esito
          </td>
         </tr>
         <tr><td colspan=2>&nbsp;</td></tr>
         <tr>
          <td colspan=2> Note: <br>"
          
    db_foreach sel_anom "" {

	    append libretto "$cod_tanom $descr_tano <br>"
	}

    append libretto "
          </td>
         </tr>
         <tr><td colspan=2>&nbsp;</td></tr>
         <tr>
          <td>Si allega copia del Rapporto di prova n° $verb_n</td>
          <td>Firma dell'ispettore _________________</td>
         </tr>
         <tr><td colspan=2>&nbsp;</td></tr>
        </table>
   </td></tr>
   </table>
</td></tr>
<tr><td>&nbsp;</td></tr>
</table>"
    
} if_no_rows {
    append libretto "
<table width=100%>
    <tr>
       <td colspan=6>Non esistono rapporti di ispezione</td>
    </tr>
</table>"
}

append libretto ""


####fine simone rapporti di verifica

append libretto "<!-- PAGE BREAK -->
    $table_con_header_per_tutte_le_pagine"

append libretto "
    <table width=100% border=1>
          <tr>
             <td align=center bgcolor=\"E1E1E1\"><big><b>14. Registrazione dei Consumi nei vari Esercizi</b></big></td>
          </tr>
    </table>"

append libretto "
    <table width=100% border=0>
          <tr>
             <td colspan=4>&nbsp;</td>
          </tr>
       <tr>
          <td colspan=4>&nbsp;</td>
       </tr>
       <tr>
          <td align=center colspan=4><b>14.1 Consumo di Combustibile</b></td>
       </tr>
       <tr>
          <td colspan=4>&nbsp;</td>
       </tr>
    </table>
<br>"

#append libretto "
#   <table width=100% >
#       <tr>
#          <td colspan=4>&nbsp;</td>
#       </tr>
#"

set ls_tipo_comb [db_list_of_lists q "
select distinct case when tipo = 'G' then 'GASSOSO'
                   when tipo = 'L' then 'LIQUIDO'
                   when tipo = 'S' then 'SOLIDO'
                   when tipo = 'A' then 'ALTRO'
                   end as tipo_combustibile
     , c.um
     , tipo as tipo_comb_codice
from coimcomb c"]

set where_flag_tracciato ""
set where_gen_prog_padre "1 or 1=1";#stratagemma per ricavare tutti i generatori 

foreach tipo_comb $ls_tipo_comb {

    util_unlist $tipo_comb tipo_combustibile um tipo_comb_codice

    set ls_letture [db_list_of_lists q "select d.stagione_risc
                                             , iter_edit_num(d.acquisti, 2)            as acquisti
                                             , iter_edit_num(d.scorta_o_lett_iniz, 2)  as scorta_o_lett_iniz
                                             , iter_edit_num(d.scorta_o_lett_fin, 2)   as scorta_o_lett_fin
                                             , iter_edit_num(d.consumo_annuo, 2)       as consumo_annuo
                                             , g.cod_impianto                          as cod_impianto_tipo_comb --rom23
                                             , case b.flag_tipo_impianto
                                               when 'R' then 'GT'
                                               when 'F' then 'GF'
                                               when 'T' then 'SC'
                                               when 'C' then 'CG'
                                               else ''  end                            as flag_tipo_imp_comb --rom23
                                             , g.gen_prog_est                          as gen_prog_est_comb  --rom23
                                          from coimgend g 
                                             , coimcomb c
                                             , coimdimp d
                                    inner join coimaimp b
                                            on d.cod_impianto = b.cod_impianto --rom23
                                         where c.cod_combustibile  = g.cod_combustibile
                                           and coalesce(c.tipo,'') = coalesce(:tipo_comb_codice,'')
                                           and coalesce(c.um,'')   = coalesce(:um,'')
                                           and d.cod_impianto      = g.cod_impianto
                                           and d.gen_prog          = g.gen_prog
                                           and g.cod_impianto      = :cod_impianto"]

    if {$flag_gest_targa eq "T"} {#sim04: aggiunta if e suo contenuto

	set ls_letture_padre [db_list_of_lists q "select d.stagione_risc
                                             , iter_edit_num(d.acquisti, 2)            as acquisti
                                             , iter_edit_num(d.scorta_o_lett_iniz, 2)  as scorta_o_lett_iniz
                                             , iter_edit_num(d.scorta_o_lett_fin, 2)   as scorta_o_lett_fin
                                             , iter_edit_num(d.consumo_annuo, 2)       as consumo_annuo
                                             , g.cod_impianto                          as cod_impianto_tipo_comb --rom23
                                             , case b.flag_tipo_impianto
                                               when 'R' then 'GT'
                                               when 'F' then 'GF'
                                               when 'T' then 'SC'
                                               when 'C' then 'CG'
                                               else ''  end                            as flag_tipo_imp_comb --rom23
                                             , g.gen_prog_est                          as gen_prog_est_comb  --rom23
                                          from coimgend g 
                                             , coimcomb c
                                             , coimdimp d
                                    inner join coimaimp b
                                            on d.cod_impianto = b.cod_impianto
                                         where c.cod_combustibile  = g.cod_combustibile
                                           and coalesce(c.tipo,'') = coalesce(:tipo_comb_codice,'')
                                           and coalesce(c.um,'')   = coalesce(:um,'')
                                           and b.cod_impianto != :cod_impianto
                                           and upper(b.targa) = upper(:targa)
                                           and d.cod_impianto     = g.cod_impianto
                                           and d.gen_prog         = g.gen_prog"]

    } else {
	
	set ls_letture_padre [db_list_of_lists q "select d.stagione_risc
                                             , iter_edit_num(d.acquisti, 2)            as acquisti
                                             , iter_edit_num(d.scorta_o_lett_iniz, 2)  as scorta_o_lett_iniz
                                             , iter_edit_num(d.scorta_o_lett_fin, 2)   as scorta_o_lett_fin
                                             , iter_edit_num(d.consumo_annuo, 2)       as consumo_annuo
                                             , g.cod_impianto                          as cod_impianto_tipo_comb --rom23
                                             , case b.flag_tipo_impianto
                                               when 'R' then 'GT'
                                               when 'F' then 'GF'
                                               when 'T' then 'SC'
                                               when 'C' then 'CG'
                                               else ''  end                            as flag_tipo_imp_comb --rom23
                                             , g.gen_prog_est                          as gen_prog_est_comb  --rom23
                                          from coimgend g
                                             , coimcomb c
                                             , coimdimp d
                                    inner join coimaimp b
                                            on d.cod_impianto = b.cod_impianto_princ
                                           and d.cod_impianto != b.cod_impianto
                                         where b.cod_impianto = :cod_impianto
                                           and c.cod_combustibile  = g.cod_combustibile
                                           and coalesce(c.tipo,'') = coalesce(:tipo_comb_codice,'')
                                           and coalesce(c.um,'')   = coalesce(:um,'')
                                           and d.cod_impianto      = g.cod_impianto
                                           and d.gen_prog          = g.gen_prog"]

    }

    
    if {[llength $ls_letture] >0 || [llength $ls_letture_padre] >0} {

#rom23	append libretto "
#  <table width=100% border=1>
#      <tr>
#        <td colspan=4>Tipo di combustibile: $tipo_combustibile</td><td>Unità di misura: $um</td>
#      </tr>
#      <tr>
#        <td align=center>Esercizio</td>
#        <td align=center>Acquisti</td>
#        <td align=center>Scorta o lettura iniziale</td>
#        <td align=center>Scorta o lettura finale</td>
#        <td align=center>Consumo</td>
#      </tr>"

	set table_consumi {
	    append libretto "
   <table width=100% border=1>
       <tr>
         <td colspan=4>Codice Impianto: $cod_impianto_tipo_comb $flag_tipo_imp_comb: $gen_prog_est_comb Tipo di combustibile: $tipo_combustibile</td><td>Unità di misura: $um</td>
       </tr>
       <tr>
         <td align=center>Esercizio</td>
         <td align=center>Acquisti</td>
         <td align=center>Scorta o lettura iniziale</td>
         <td align=center>Scorta o lettura finale</td>
         <td align=center>Consumo</td>
       </tr>"
    };#rom23

	foreach letture $ls_letture {
	    
	    util_unlist $letture stagione_risc acquisti scorta_o_lett_iniz scorta_o_lett_fin consumo_annuo cod_impianto_tipo_comb flag_tipo_imp_comb gen_prog_est_comb
	    
	    eval $table_consumi;#rom23
	    #gac03 aggiunti nuovi campi alla stampa
	    append libretto "
       <tr>
          <td align=center>$stagione_risc&nbsp;</td>
          <td align=center>$acquisti&nbsp;</td>
          <td align=center>$scorta_o_lett_iniz&nbsp;</td>
          <td align=center>$scorta_o_lett_fin&nbsp;</td>
          <td align=center>$consumo_annuo&nbsp;</td>
       </tr>"
	    append libretto "</table><br>"
	}
	
	foreach letture_padre $ls_letture_padre {
	    util_unlist $letture_padre stagione_risc acquisti scorta_o_lett_iniz scorta_o_lett_fin consumo_annuo cod_impianto_tipo_comb flag_tipo_imp_comb gen_prog_est_comb
	    
	    eval $table_consumi;#rom23
	    #gac03 aggiunti nuovi campi alla stampa
	    append libretto "
       <tr>
          <td align=center>$stagione_risc&nbsp;</td>
          <td align=center>$acquisti&nbsp;</td>
          <td align=center>$scorta_o_lett_iniz&nbsp;</td>
          <td align=center>$scorta_o_lett_fin&nbsp;</td>
          <td align=center>$consumo_annuo&nbsp;</td>
       </tr>"
	    append libretto "</table><br>";#rom23

	}
	
    }
    
}

append libretto "
    <table width=100%>
          <tr>
             <td>&nbsp;</td>
          <tr>
    </table>"

append libretto "
    <!-- PAGE BREAK -->
    $table_con_header_per_tutte_le_pagine"

#gac06 aggiunti campi relativi all'elettricità
append libretto "
    <table width=100% border=1>
          <tr>
             <td align=center bgcolor=\"E1E1E1\"><big><b>14. Registrazione dei Consumi nei veri Esercizi</b></big></td>
          </tr>
    </table>"

append libretto "
    <table width=100% border=0>
          <tr>
             <td colspan=4>&nbsp;</td>
          </tr>
       <tr>
          <td colspan=4>&nbsp;</td>
       </tr>
       <tr>
          <td align=center colspan=4><b>14.2 Consumo di elettricit&agrave;</b></td>
       </tr>
       <tr>
          <td colspan=4>&nbsp;</td>
       </tr>
    </table>
<br>"


append libretto "
   <table width=100% border=1>
       <tr>
         <td align=center valign=center height=3% bgcolor=\"E1E1E1\"><b>Esercizio</b></td>
         <td align=center valign=center height=3% bgcolor=\"E1E1E1\"><b>Lettura iniziale (kWh)</b></td>
         <td align=center valign=center height=3% bgcolor=\"E1E1E1\"><b>Lettura finale (kWh)</b></td>
         <td align=center valign=center height=3% bgcolor=\"E1E1E1\"><b>Consumo totale (kWh)</b></td>
       </tr>"

db_foreach sel_dimp "" {#gac06 aggiunta foreach e suo contenuto

append libretto "
       <tr>
         <td align=center valign=center height=3%>$elet_esercizio_1 / $elet_esercizio_2</td>
         <td align=center>$elet_lettura_iniziale&nbsp;</td>
         <td align=center>$elet_lettura_finale&nbsp;</td>
         <td align=center>$elet_consumo_totale&nbsp;</td>
       </tr>
       <tr>
         <td align=center valign=center height=3%>$elet_esercizio_3 / $elet_esercizio_4</td>
         <td align=center>$elet_lettura_iniziale_2&nbsp;</td>
         <td align=center>$elet_lettura_finale_2&nbsp;</td>
         <td align=center>$elet_consumo_totale_2&nbsp;</td>
       </tr>"
};#gac06

if {$flag_gest_targa eq "T"} {#gac06: aggiunta if e else e suo contenuto
    set q_sel_dimp_padre "sel_dimp_padre_targa"
} else {
    set q_sel_dimp_padre "sel_dimp_padre"
}

db_foreach $q_sel_dimp_padre "" {#gac06 aggiunta foreach e suo contenuto

  
#da_vedere    if {[db_0or1row q "select 1
#da_vedere                         from coimgend g
#da_vedere                            , coimcomb c
#da_vedere                        where g.cod_combustibile = c.cod_combustibile
#da_vedere                          and g.gen_prog         = :gen_prog_dimp
#da_vedere                          and g.cod_impianto     = :cod_impianto_dimp 
#da_vedere                          and tipo              != :codice_tipo_comb"]} {
#da_vedere	#scrivo la riga solo se il dimp ha un generatore di quel tipo combustibile
#da_vedere	continue
#da_vedere    }

append libretto "
       <tr>
         <td align=center valign=center height=3%>$elet_esercizio_1 / $elet_esercizio_2</td>
         <td align=center>$elet_lettura_iniziale&nbsp;</td>
         <td align=center>$elet_lettura_finale&nbsp;</td>
         <td align=center>$elet_consumo_totale&nbsp;</td>
       </tr>
       <tr>
         <td align=center valign=center height=3%>$elet_esercizio_3 / $elet_esercizio_4</td>
         <td align=center>$elet_lettura_iniziale_2&nbsp;</td>
         <td align=center>$elet_lettura_finale_2&nbsp;</td>
         <td align=center>$elet_consumo_totale_2&nbsp;</td>
       </tr>"

}

#La parte del Libretto relativa ai Soggetti Responsabili non la faccio vedere alle Marche
if {$coimtgen(regione) ne "MARCHE"} {

    append libretto "
        <!-- PAGE BREAK -->
        $table_con_header_per_tutte_le_pagine"

#ale01
#
# Soggetti
#if {[db_0or1row sel_aimp_3 ""] == 0} {
#    iter_return_complaint "Impianto non trovato"
#} else {
#    if {[string is space $nome_inte]} {
# 	set nome_inte "&nbsp;"
#    }
#    if {[string is space $nome_prop]} {
#	set nome_prop "&nbsp;"
#    }
#    if {[string is space $nome_occu]} {
#	set nome_occu "&nbsp;"
#    }
#    if {[string is space $nome_ammi]} {
#	set nome_ammi "&nbsp;"
#    }
#    if {[string is space $nome_resp]} {
#	set nome_resp "&nbsp;"
#    }
#
#
#append libretto "
#    <table width=100% align=center border>
#          <tr>
#             <td align=center colspan=4><b>Soggetti Responsabili</b></td>
#          </tr>
#          <tr>
#             <td align=center><b>Tipo soggetto</b></td>
#             <td align=center><b>Nominativo</b></td>
#             <td align=center><b>Indirizzo</b></td>
#             <td align=center><b>Data fine validit&agrave;</b></td>
#          </tr>
#          <tr>
#             <td>Intestatario</td>
#             <td>$nome_inte</td>
#             <td>$indir_i $nome_comu_i ($sigla_i) $cap_i</td>
#             <td align=center>Attuale</td>
#          </tr>
#          <tr>
#             <td>Proprietario</td>
#             <td>$nome_prop</td>
#             <td>$indir_p $nome_comu_p $sigla_p $cap_p</td>
#             <td align=center>Attuale</td>
#          </tr>
#          <tr>
#             <td>Occupante</td>
#             <td>$nome_occu</td>
#             <td>$indir_o $nome_comu_o ($sigla_o) $cap_o</td>
#             <td align=center>Attuale</td>
#          </tr>
##          <tr>
#             <td>Amministratore</td>
#             <td>$nome_ammi</td>
#             <td>$indir_a $nome_comu_a ($sigla_a) $cap_a</td>
#             <td align=center>Attuale</td>
#          </tr>"
#
#    db_foreach sel_rife "" {
#	if {[string is space $nome_sogg]} {
#	    set nome_sogg "&nbsp;"
#	}
#	append libretto "
#          <tr>
#             <td>$desc_ruolo</td>
#             <td>$nome_sogg</td>
#             <td>$indir_s $nome_comu_s ($sigla_s) $cap_s</td>
#             <td align=center>$data_fin_valid</td>
#          </tr>"
#    }
#
#    append libretto "</table>
#    <table width=100%>
#          <tr>
#             <td>&nbsp;</td>
#          <tr>
#    </table>"
#}
#
#
#append libretto "
#    <!-- PAGE BREAK -->
#    $table_con_header_per_tutte_le_pagine
#"
#
#
#append libretto "
#    <table width=100%>
#          <tr>
#             <td align=center><big><b><font color=grey>Ditte tecnici</font></b></big></td>
#          </tr>
#          <tr>
#             <td>&nbsp;</td>
#          </tr>
#    </table>"
## Ditte/Tecnici
#if {[db_0or1row sel_aimp_4 ""] == 0} {
#    iter_return_complaint "Impianto non trovato"
#} else {
#
#    if {[string is space $nome_manu]} {
#	set nome_manu "&nbsp;"
#    }
#    if {[string is space $nome_inst]} {
#	set nome_inst "&nbsp;"
#    }
#    if {[string is space $nome_dist]} {
#	set nome_dist "&nbsp;"
#    }
#    if {[string is space $nome_prog]} {
#	set nome_prog "&nbsp;"
#    }
#
#    append libretto "
#    <table width=100% align=center border>
#          <tr>
#             <td align=center colspan=4><b>Ditte/Tecnici</b></td>
#          </tr>
#          <tr>
#             <td align=center><b>Tipo soggetto</b></td>
#             <td align=center><b>Nominativo</b></td>
#             <td align=center><b>Indirizzo</b></td>
#             <td align=center><b>Data fine validit&agrave;</b></td>
#          </tr>
#          <tr>
#             <td>Manutentore</td>
#             <td>$nome_manu</td>
#             <td>$indir_m $nome_comu_m ($sigla_m) $cap_m</td>
#             <td align=center>Attuale</td>
#          </tr>
#          <tr>
#             <td>Installatore</td>
#             <td>$nome_inst</td>
#             <td>$indir_i $nome_comu_i ($sigla_i) $cap_i</td>
#             <td align=center>Attuale</td>
#          </tr>
#          <tr>
#             <td>Distributore</td>
#             <td>$nome_dist</td>
#             <td>$indir_d $nome_comu_d ($sigla_d) $cap_d</td>
#             <td align=center>Attuale</td>
#          </tr>
#          <tr>
#             <td>Progettista</td>
#             <td>$nome_prog</td>
#             <td>$indir_g $nome_comu_g ($sigla_g) $cap_g</td>
#             <td align=center>Attuale</td>
#          </tr>"
#
#    #    db_foreach sel_rife_2 "" {
#    #	 if {[string equal $nome_sogg " "]} {
#    #	     set nome_sogg "&nbsp;"
#    #	 }
#    #	 append stampa "
#    #          <tr>
#    #             <td align=center>$desc_ruolo</td>
#    #             <td align=center>$nome_sogg</td>
#    #             <td align=center>$indir_s $nome_comu_s ($sigla_s) $cap_s</td>
#    #             <td align=center>$data_fin_valid</td>
#    #          </tr>"
#    #     }
#    append libretto "</table>
#    <table width=100%>
#          <tr>
#             <td>&nbsp;</td>
#          <tr>
#    </table>"
#}
#
#append libretto "
#    <!-- PAGE BREAK -->
#    $table_con_header_per_tutte_le_pagine
#"

    
    # Soggetti
    if {[db_0or1row sel_aimp_3 ""] == 0} {
	iter_return_complaint "Impianto non trovato"
    } else {
	if {[string is space $nome_inte]} {
	    set nome_inte "&nbsp;"
	}
	if {[string is space $nome_prop]} {
	    set nome_prop "&nbsp;"
	}
	if {[string is space $nome_occu]} {
	    set nome_occu "&nbsp;"
	}
	if {[string is space $nome_ammi]} {
	    set nome_ammi "&nbsp;"
	}
	if {[string is space $nome_resp]} {
	    set nome_resp "&nbsp;"
	}
	
	if {![string is space $sigla_i]} {
	    set sigla_i "($sigla_i)"
	} else {
	    set sigla_i "&nbsp;"
	}
	
	if {![string is space $sigla_p]} {
	    set sigla_p "($sigla_p)"
	} else {
	    set sigla_p "&nbsp;"
	}
	
	if {![string is space $sigla_o]} {
	    set sigla_o "($sigla_o)"
	} else {
	    set sigla_o "&nbsp;"
	}
	
	if {![string is space $sigla_a]} {
	    set sigla_a "($sigla_a)"
	} else {
	    set sigla_a "&nbsp;"
	}
	
	
	append libretto "
    <table width=100% align=center border>
          <tr>
             <td align=center colspan=4><b>Soggetti Responsabili</b></td>
          </tr>
          <tr>
             <td align=center><b>Tipo soggetto</b></td>
             <td align=center><b>Nominativo</b></td>
             <td align=center><b>Indirizzo</b></td>
             <td align=center><b>Data fine validit&agrave;</b></td>
          </tr>
          <tr>
             <td>Intestatario</td>
             <td>$nome_inte</td>
             <td>$indir_i $nome_comu_i $sigla_i $cap_i</td>
             <td align=center>Attuale</td>
          </tr>
          <tr>
             <td>Proprietario</td>
             <td>$nome_prop</td>
             <td>$indir_p $nome_comu_p $sigla_p $cap_p</td>
             <td align=center>Attuale</td>
          </tr>
          <tr>
             <td>Occupante</td>
             <td>$nome_occu</td>
             <td>$indir_o $nome_comu_o $sigla_o $cap_o</td>
             <td align=center>Attuale</td>
          </tr>
          <tr>
             <td>Amministratore</td>
             <td>$nome_ammi</td>
             <td>$indir_a $nome_comu_a $sigla_a $cap_a</td>
             <td align=center>Attuale</td>
          </tr>"
	
	db_foreach sel_rife "" {
	    if {[string is space $nome_sogg]} {
		set nome_sogg "&nbsp;"
	    }
	    
	    if {![string is space $sigla_s]} {
		set sigla_s "($sigla_s)"
	    } else {
		set sigla_s "&nbsp;"
	    }
	    
	    append libretto "
          <tr>
             <td>$desc_ruolo</td>
             <td>$nome_sogg</td>
             <td>$indir_s $nome_comu_s $sigla_s $cap_s</td>
             <td align=center>$data_fin_valid</td>
          </tr>"
	}
	
	append libretto "</table>
    <table width=100%>
          <tr>
             <td>&nbsp;</td>
          <tr>
    </table>"
    }
}
#La parte del Libretto relativa a Ditte/Tecnici non la faccio vedere se sono delle Marche
if { $coimtgen(regione) ne "MARCHE"} {
    
    append libretto "
    <!-- PAGE BREAK -->
    $table_con_header_per_tutte_le_pagine
"
    
    
    append libretto "
    <table width=100% border=1>
          <tr>
             <td align=center bgcolor=\"E1E1E1\"><big><b>Ditte tecnici</b></big></td>
          </tr>
    </table>"
    # Ditte/Tecnici
    if {[db_0or1row sel_aimp_4 ""] == 0} {
	iter_return_complaint "Impianto non trovato"
    } else {
	
	if {[string is space $nome_manu]} {
	    set nome_manu "&nbsp;"
	}
	if {[string is space $nome_inst]} {
	    set nome_inst "&nbsp;"
	}
	if {[string is space $nome_dist]} {
	    set nome_dist "&nbsp;"
	}
	if {[string is space $nome_prog]} {
	    set nome_prog "&nbsp;"
	}
	
	if {![string is space $sigla_m]} {
	    set sigla_m "($sigla_m)"
	} else {
	    set sigla_m "&nbsp;"
	}
	
	if {![string is space $sigla_i]} {
	    set sigla_i "($sigla_i)"
	} else {
	    set sigla_i "&nbsp;"
	}
	
	if {![string is space $sigla_d]} {
	    set sigla_d "($sigla_d)"
	} else {
	    set sigla_d "&nbsp;"
	}
	
	if {![string is space $sigla_g]} {
	    set sigla_g "($sigla_g)"
	} else {
	    set sigla_g "&nbsp;"
	}
	
        append libretto "
    <table width=100% align=center>
          <tr>
             <td colspan=4>&nbsp;</td>
          </tr>"

	append libretto "
    <table width=100% align=center border>
          <tr>
             <td align=center colspan=4><b>Ditte/Tecnici</b></td>
          </tr>
          <tr>
             <td align=center>Tipo soggetto</td>
             <td align=center>Nominativo</td>
             <td align=center>Indirizzo</td>
             <td align=center>Data fine validit&agrave;</td>
          </tr>
          <tr>
             <td>Manutentore</td>
             <td>$nome_manu</td>
             <td>$indir_m $nome_comu_m $sigla_m $cap_m</td>
             <td align=center>Attuale</td>
          </tr>
          <tr>
             <td>Installatore</td>
             <td>$nome_inst</td>
             <td>$indir_i $nome_comu_i $sigla_i $cap_i</td>
             <td align=center>Attuale</td>
          </tr>
          <tr>
             <td>Distributore</td>
             <td>$nome_dist</td>
             <td>$indir_d $nome_comu_d $sigla_d $cap_d</td>
             <td align=center>Attuale</td>
          </tr>
          <tr>
             <td>Progettista</td>
             <td>$nome_prog</td>
             <td>$indir_g $nome_comu_g $sigla_g $cap_g</td>
             <td align=center>Attuale</td>
          </tr>"

    #    db_foreach sel_rife_2 "" {
    #	 if {[string equal $nome_sogg " "]} {
    #	     set nome_sogg "&nbsp;"
    #	 }
    #	 append stampa "
    #          <tr>
    #             <td align=center>$desc_ruolo</td>
    #             <td align=center>$nome_sogg</td>
    #             <td align=center>$indir_s $nome_comu_s ($sigla_s) $cap_s</td>
    #             <td align=center>$data_fin_valid</td>
    #          </tr>"
	#     }
	append libretto "</table>
    <table width=100%>
          <tr>
             <td>&nbsp;</td>
          <tr>
    </table>"
    }
}


set nome_file3_est    $nome_file3;#19/04/2013


if {$coimtgen(regione) eq "MARCHE"} {#sim10 if e suo contenuto

    set spool_dir_perm     [iter_set_permanenti_dir]
    set spool_dir_url_perm [iter_set_permanenti_dir_url]
    set nome_file3         [iter_temp_file_name -permanenti $nome_file3]
    set file_html3        "$spool_dir_perm/$nome_file3.html"   
    set file_pdf3         "$spool_dir_perm/$nome_file3.pdf"
    set file_pdf_url3     "$spool_dir_url_perm/$nome_file3.pdf"
    
} else {#sim10

    set nome_file3        [iter_temp_file_name $nome_file3]
    set file_html3        "$spool_dir/$nome_file3.html"   
    set nome_file        [iter_temp_file_name $nome_file]
    set file_pdf3         "$spool_dir/$nome_file3.pdf"
    set file_pdf_url3     "$spool_dir_url/$nome_file3.pdf"


};#sim10

set file_id3   [open $file_html3 w]
fconfigure $file_id3 -encoding iso8859-1

puts $file_id3 $libretto
close $file_id3

# lo trasformo in PDF
#prima era arial
iter_crea_pdf [list exec htmldoc --webpage --header ... --footer ... --quiet --bodyfont serif --fontsize 09 --left 1cm --right 1cm --top 1cm --bottom 0.2cm -f $file_pdf3 $file_html3]




#Allegati E1 E2 E3 E4
set stampa1 ""

if {$flag_resp == "T"} {
    set nome_tresp $nome_resp
    set indir_tresp $indir_r
    set nome_comu_tresp $nome_comu_r
    set sigla_tresp $sigla_r
} else {
    set nome_tresp ""
    set indir_tresp ""
    set nome_comu_tresp ""
    set sigla_tresp ""
}

db_1row sel_cod_comb "select cod_combustibile as cod_tele from coimcomb where descr_comb = 'TELERISCALDAMENTO'"
db_1row sel_cod_comb "select cod_combustibile as cod_pomp from coimcomb where descr_comb = 'POMPA DI CALORE'"

if {![exists_and_not_null dest_uso]} {#sim altrimenti se non esisteva in errore
    set dest_uso "";#sim
};#sim

if {![exists_and_not_null pot_foc_gend]} {#sim altrimenti se non esisteva in errore
    set pot_foc_gend "";#sim
};#sim

if {![exists_and_not_null scarico_fumi]} {#sim altrimenti se non esisteva in errore
    set scarico_fumi "";#sim
};#sim


set pote [iter_check_num $potenza 2]
if {$pote < 35} {
    set titolo "Stampa allegato E<small>1</small>"
    set nome_file1 "allegato e1"
    append stampa1 "
            $logo<!-- sim03 -->
	    <table width=100%>
	        <tr><td align=left><i>Allegato E1 - Scheda identificativa per impianti inferiori a 35 kW</i></td></tr>
	        <tr><td align=center>1. SCHEDA IDENTIFICATIVA DELL'IMPIANTO</td></tr>
	        <tr><td align=center>(trasmettere copia della scheda all'Ente locale competente per i controlli)</td></tr>
	        <tr><td>Data di stampa $sysdate_edit</td></tr>
               <tr><td>&nbsp;</td></tr>
	    </table>
	    <table width=100% border=1>
	        <tr><td><table width=100%>
	                    <tr><td width=3%>1.1</td>
	                        <td colspan=4>UBICAZIONE DELL'UNIT&Agrave; IMMOBILIARE</td>
	                    </tr>
	                    <tr><td>&nbsp;</td>
	                        <td colspan=3 nowrap>n. catasto impianto: $cod_impianto_est</td>
	                        <td nowrap>Volumetria riscaldata (m<sup><small>3</small></sup>): $volimetria_risc</td>
                    	</tr>
	                    <tr><td>&nbsp;</td>
	                        <td colspan=3>Indirizzo: $via_imp</td>
	                        <td colspan=1>N.: $num_imp</td>
	                    </tr>
	                   <tr><td>&nbsp;</td>
	                        <td nowrap>Scala: $scala_imp</td>
	                        <td nowrap>Piano: $piano_imp</td>
	                        <td nowrap>Interno: $interno_imp</td>
	                        <td nowrap>Cap: $cap</td>
                    	</tr>
	                     <tr><td>&nbsp;</td>
	                        <td nowrap>Localit&agrave;: $localita</td>
	                        <td colspan=2 nowrap>Comune: $nome_comu</td>
	                        <td colspan=1 nowrap>Provincia: $prov</td>
                    	</tr>
	                    <tr><td colspan=5>&nbsp;</td></tr>
	                    <tr><td>1.2</td>
	                        <td colspan=4>IMPIANTO TERMICO INDIVIDUALE DESTINATO A</td>
	                    </tr>
	                    <tr><td>&nbsp;</td>
	                        <td colspan=4>$dest_uso</td>
	                   </tr>
	                    <tr><td colspan=5>&nbsp;</td></tr>
	                    <tr><td>1.3</td>
	                        <td colspan=4>GENERATORE DI CALORE</td>
	                    </tr>
	                    <tr><td>&nbsp;</td>
	                        <td colspan=4>Data di installazione: $data_installaz</td>
	                    </tr>
	                    <tr><td>&nbsp;</td>
	                        <td colspan=4>Potenza termica del focolare nominale: $pot_foc_gend</td>
	                    </tr>
	                    <tr><td>&nbsp;</td>
	                        <td colspan=4>Combustibile: $descr_comb</td>
	                    </tr>
	                    <tr><td colspan=5>&nbsp;</td></tr>
	                    <tr><td>1.4</td>
	                        <td colspan=4>EVACUAZIONE DEI PRODOTTI DI COMBUSTIONE</td>
	                    </tr>
	                    <tr><td>&nbsp;</td>
	                        <td colspan=4>$scarico_fumi</td>
	                    </tr>
	                    <tr><td colspan=5>&nbsp;</td></tr>
	                    <tr><td>1.5</td>
	                        <td colspan=4 nowrap>PROGETTISTA DELL'IMPIANTO TERMICO (nominativo e n. di iscrizione all'ordine o collegio)</td>
	                    </tr>
	                    <tr><td>&nbsp;</td>
	                        <td colspan=4>$nome_prog $reg_prog</td>
	                    </tr>
	                    <tr><td colspan=5>&nbsp;</td></tr>
	                    <tr><td>1.6</td>
	                        <td colspan=4 nowrap>INSTALLATORE DELL'IMPIANTO TERMICO (ragione sociale e n. di iscrizione a CCIAA e/o AA)</td>
	                    </tr>
	                    <tr><td>&nbsp;</td>
	                        <td colspan=4>$nome_inst $reg_inst</td>
	                    </tr>
	                    <tr><td colspan=5>&nbsp;</td></tr>
	                    <tr><td>1.7</td>
	                        <td colspan=4>PROPRIETARIO DELL'UNIT&Agrave; IMMOBILIARE (cognome, nome e indirizzo)</td>
	                    </tr>
	                    <tr><td>&nbsp;</td>
	                        <td colspan=4>$nome_prop</td>
	                    </tr>"
    if {![string equal $nome_prop ""]} {
	append stampa1 "<tr><td>&nbsp;</td>
	                        <td colspan=4>$indir_p $nome_comu_p ($sigla_p)</td>
	                    </tr>"
    }
    append stampa1 "<tr><td colspan=5>&nbsp;</td></tr>
	                    <tr><td>1.8</td>
	                        <td colspan=4>OCCUPANTE DELL'UNIT&Agrave; IMMOBILIARE (cognome e nome)</td>
	                    </tr>
	                    <tr><td>&nbsp;</td>
	                        <td colspan=4>$nome_occu</td>
	                    </tr>
	                    <tr><td colspan=5>&nbsp;</td></tr>
	                    <tr><td>1.9.1</td>
	                        <td colspan=4 nowrap>MANUTENTORE (ragione sociale e n. di iscrizione a CCIAA e/o AA ed indirizzo)</td>
	                    </tr>
	                    <tr><td>&nbsp;</td>
	                        <td colspan=4>$nome_manu $reg_manu</td>
	                    </tr>"
    if {![string equal $nome_manu ""]} {
	append stampa1 "<tr><td>&nbsp;</td>
	                        <td colspan=4>$indir_m $nome_comu_m ($sigla_m)</td>
	                    	</tr>"
    }
    append stampa1 "<tr><td colspan=5>&nbsp;</td></tr>
	                    <tr><td>1.9.2</td>
	                        <td colspan=4>TERZO RESPONSABILE</td>
	                    </tr>
	                    <tr><td>&nbsp;</td>
	                        <td colspan=4>$nome_tresp</td>
	                    </tr>"
    if {![string equal $nome_tresp ""]} {
	append stampa1 " <tr><td>&nbsp;</td>
	                        <td colspan=4>$indir_tresp $nome_comu_tresp ($sigla_tresp)</td>
	                    </tr>"
    }
    append stampa1 " <tr><td colspan=5>&nbsp;</td>
	                    <tr><td>&nbsp;</td>
	                        <tr><td colspan=3>Data della scheda: $data_sche</td>
	                        <td nowrap><small>Firma del responsabile dell'esercizio e della mautenzione</small></td>
	                    <tr><td colspan=5>&nbsp;</td>
	                    </tr>
	        </table></td></tr>
	    </table>"
} elseif {$pote >= 35} {
    set nome_file1 "allegato e2"
    set titolo "Stampa allegato E<small>2</small>"
    append stampa1 "
	    <table width=100%>
	        <tr><td align=left><i>Allegato E2 - Scheda identificativa per impianti uguali o superiori a 35 kW</i></td></tr>
	        <tr><td align=center>1. SCHEDA IDENTIFICATIVA DELL'IMPIANTO</td></tr>
	        <tr><td align=center>(trasmettere copia della scheda all'Ente locale competente per i controlli)</td></tr>
	    </table>
	    <table width=100% border=1>
	        <tr><td><table width=100%>
	                    <tr><td width=3%>1.1</td>
	                        <td colspan=4>UBICAZIONE E DESTINAZIONE DELL'EDIFICIO</td>
	                    </tr>
	                    <tr><td>&nbsp;</td>
	                        <td colspan=3 nowrap>n. catasto impianto: $cod_impianto_est</td>
	                        <td>Volumetria riscaldata (m<sup><small>3</small></sup>): $volimetria_risc</td>
	                    </tr>
	                    <tr><td>&nbsp;</td>
	                        <td colspan=3>Indirizzo: $via_imp</td>
	                        <td colspan=1>N.: $num_imp</td>
	                    </tr>
	                    <tr><td>&nbsp;</td>
	                        <td nowrap>Scala: $scala_imp</td>
	                        <td nowrap>Piano: $piano_imp</td>
	                        <td nowrap>Interno: $interno_imp</td>
	                        <td nowrap>Cap: $cap</td>
                    	</tr>
	                     <tr><td>&nbsp;</td>
	                        <td nowrap>Localit&agrave;: $localita</td>
	                        <td colspan=2 nowrap>Comune: $nome_comu</td>
	                        <td nowrap>Provincia: $prov</td>
                    	</tr>
	                    <tr><td>&nbsp;</td>
	                        <td colspan=4>Edificio adibito a: $descr_cted</td>
	                    </tr>
	                    <tr><td>&nbsp;</td>
	                        <td colspan=4>Categoria: $cod_cted</td>
	                    </tr>
						<tr><td colspan=5>&nbsp;</td></tr>
	                    <tr><td>1.2</td>
	                        <td colspan=4>IMPIANTO TERMICO INDIVIDUALE DESTINATO A</td>
	                    </tr>
	                    <tr><td>&nbsp;</td>
	                        <td colspan=4>$dest_uso</td>
	                    </tr>
	                    <tr><td colspan=5>&nbsp;</td></tr>
	                    <tr><td>1.3</td>
	                        <td colspan=4>DATA DI INSTALLAZIONE/RISTRUTTURAZIONE</td>
	                    </tr>
	                    <tr><td>&nbsp;</td>
	                        <td colspan=4>$data_installaz</td>
	                    </tr>
	                    <tr><td colspan=5>&nbsp;</td></tr>
	                    <tr><td>1.4</td>
	                        <td colspan=4>GENERATORI DI CALORE</td>
	                    </tr>
	                    <tr><td>&nbsp;</td>
	                        <td>Numero: $n_generatori</td>
	                        <td>Potenza termica del focolare nominale totale (kW): $potenza</td>
	                        <td colspan=2>Combustibile: $descr_comb</td>
	                    </tr>
	                    <tr><td colspan=5>&nbsp;</td></tr>
	                    <tr><td>1.5</td>
	                        <td colspan=4>PROGETTISTA DELL'IMPIANTO TERMICO (nominativo e n. di iscrizione all'ordine o collegio)</td>
	                    </tr>
	                    <tr><td>&nbsp;</td>
	                        <td colspan=4>$nome_prog $reg_prog</td>
	                    </tr>
						<tr><td colspan=5>&nbsp;</td></tr>
	                    <tr><td>1.6</td>
	                        <td colspan=4>INSTALLATORE DELL'IMPIANTO TERMICO (ragione sociale e n. di iscrizione a CCIAA e/o AA)</td>
	                    </tr>
	                    <tr><td>&nbsp;</td>
	                        <td colspan=4>$nome_inst $reg_inst</td>
	                    </tr>
	                    <tr><td colspan=5>&nbsp;</td></tr>
	                    <tr><td>1.7</td>
	                        <td colspan=4>PROPRIETARIO O PROPRIETARI (cognome, nome e indirizzo)<small><sup>(1)</sup></small></td>
	                    </tr>
	                    <tr><td>&nbsp;</td>
	                        <td colspan=4>$nome_prop</td>
	                    </tr>"
    if {![string equal $nome_prop ""]} {
	append stampa1 "	<tr><td>&nbsp;</td>
	                        <td colspan=4>$indir_p $nome_comu_p ($sigla_p)</td>
	                    </tr>"
    }
    append stampa1 "<tr><td colspan=5>&nbsp;</td></tr>
	                    <tr><td>1.8</td>
	                        <td colspan=4>AMMINISTRATORE (cognome, nome e indirizzo)<small><sup>(2)</sup></small></td>
	                    </tr>
	                    <tr><td>&nbsp;</td>
	                        <td colspan=4>$nome_ammi</td>
	                    </tr>	"
    if {![string equal $nome_ammi ""]} {
	append stampa1 "<tr><td>&nbsp;</td>
	                        <td colspan=4>$indir_a $nome_comu_a ($sigla_a)</td>
	                    </tr>"
    }
    append stampa1 " <tr><td colspan=5>&nbsp;</td></tr>
	                    <tr><td>1.9.1</td>
	                        <td colspan=4>MANUTENTORE (ragione sociale e n. di iscrizione a CCIAA e/o AA ed indirizzo)</td>
	                    </tr>
	                    <tr><td>&nbsp;</td>
	                        <td colspan=4>$nome_manu reg_manu</td>
	                    </tr>	"
    if {![string equal $nome_manu ""]} {
	append stampa1 "<tr><td>&nbsp;</td>
	                        <td colspan=4>$indir_m $nome_comu_m ($sigla_m)</td>
	                    </tr>"
    }
    append stampa1 "<tr><td colspan=5>&nbsp;</td></tr>
	                    <tr><td>1.9.2</td>
	                        <td colspan=4>TERZO RESPONSABILE</td>
	                    </tr>
	                    <tr><td>&nbsp;</td>
	                        <td colspan=4>$nome_tresp</td>
	                    </tr>"
    if {![string equal $nome_tresp ""]} {
	append stampa1 "<tr><td>&nbsp;</td>
	                        <td colspan=4>$indir_tresp $nome_comu_tresp ($sigla_tresp)</td>
	                    </tr>"
    }
    append stampa1 "<tr><td colspan=5>&nbsp;</td></tr>
	                    <tr><td>&nbsp;</td>
	                        <tr><td colspan=3>Data della scheda: $data_sche</td>
	                        <td nowrap><small>Firma del responsabile dell'esercizio e della mautenzione</small></td>
	                    <tr><td colspan=5>&nbsp;</td>
	                    </tr>
	        </table></td></tr>
	    </table>
	        <tr><td><small>(1) In caso di propriet&agrave; in condominio indicare condomini, in caso di propriet&agrave; di persona giuridica la ragione sociale.
	                <br>(2) Da compilare nei casi di propriet&agrave; in condominio o di propriet&grave; di persona giuridica.
	                </small>
	        </td></tr>"
}

set stampa2 ""
set nome_file2 ""
if {$cod_comb == $cod_tele} {
    set nome_file2 "allegato e3"
    set titolo "Stampa allegato E<small>3</small>";#19/04/2013
    
    append stampa2 "
    <table width=100%>
        <tr><td align=left><i>Allegato E3 - Scheda identificativa per sottostazione di teleriscaldamento</i></td></tr>
        <tr><td align=center>1. SCHEDA IDENTIFICATIVA DELL'IMPIANTO</td></tr>
        <tr><td align=center>(trasmettere copia della scheda all'Ente locale competente per i controlli)</td></tr>
    </table>
    <table width=100% border=1>
        <tr><td><table width=100%>
                    <tr><td width=3%>1.1</td><td colspan=4>UBICAZIONE E DESTINAZIONE DELL'EDIFICIO</td>
                    </tr>
                    <tr><td>&nbsp;</td>
                        <td colspan=3 nowrap>n. catasto impianto: $cod_impianto_est</td>
                        <td>Volumetria riscaldata (m<sup><small>3</small></sup>): $volimetria_risc</td>
                    </tr>
                    <tr><td>&nbsp;</td>
                        <td colspan=3 nowrap>Indirizzo: $via_imp</td>
                        <td colspan=1>N.: $num_imp</td>
                    </tr>
                    <tr><td>&nbsp;</td>
                        <td nowrap>Scala: $scala_imp</td>
                        <td nowrap>Piano: $piano_imp</td>
                        <td nowrap>Interno: $interno_imp</td>
                        <td nowrap>Cap: $cap</td>
                    </tr>
                     <tr><td>&nbsp;</td>
                        <td nowrap>Localit&agrave;: $localita</td>
                        <td colspan=2 nowrap>Comune: $nome_comu</td>
                        <td nowrap>Provincia: $prov</td>
                    </tr>
                    <tr><td>&nbsp;</td>
                        <td colspan=4>Edificio adibito a: $descr_cted</td>
                    </tr>
                    <tr><td>&nbsp;</td>
                        <td colspan=4>Categoria: $cod_cted</td>
                    </tr>
		   			<tr><td colspan=5>&nbsp;</td></tr>
                    <tr><td>1.2</td><td colspan=4>IMPIANTO TERMICO INDIVIDUALE DESTINATO A</td>
                    </tr>
                    <tr><td>&nbsp;</td>
                        <td colspan=4>$dest_uso</td>
                    </tr>"
    if {$dest_uso == "Altro"} {
	append stampa2 "<tr><td>&nbsp;</td>
                        <td colspan=4>$note_dest</td>
                    </tr>"
    }
    append stampa2 "<tr><td colspan=5>&nbsp;</td></tr>
                    <tr><td>1.3</td>
                        <td colspan=4>DATA DI INSTALLAZIONE/RISTRUTTURAZIONE</td>
                    </tr>
                    <tr><td>&nbsp;</td>
                        <td colspan=4>$data_installaz</td>
                    </tr>
                    <tr><td colspan=5>&nbsp;</td></tr>
                    <tr><td>1.4</td>
                        <td colspan=4>CIRCUITO PRIMARIO</td>
                    </tr>
                    <tr><td>&nbsp;</td>
                        <td nowrap colspan=4>$circuito_primario</td>
                    </tr>
		    <tr><td colspan=5>&nbsp;</td></tr>
                    <tr><td>1.5</td>
                        <td colspan=4>DISTRIBUZIONE DEL CALORE</td>
                    </tr>
                    <tr><td>&nbsp;</td>
                        <td colspan=4>$distr_calore</td>
                    </tr>
		     <tr><td>&nbsp;</td>
                         <td colspan=3 nowrap>Numero di scambiatori di calore: $n_scambiatori</td>
                         <td colspan=1 nowrap>Potenza complessiva: $potenza_scamb_tot</td>
                    </tr>"
    set num 1
    db_foreach pot "select scamb_prog, iter_edit_num(potenza, 2) as potenza_scamb from coimscamb where cod_impianto = :cod_impianto order by scamb_prog" {
	append stampa2 "<tr><td colspan=4>Potenza (s. $scamb_prog) $potenza_scamb<br></td></tr>"
    }
    append stampa2 "<tr><td colspan=5>&nbsp;</td></tr>
                    <tr><td>1.6</td>
                        <td colspan=4>RETE DI TELERISCALDAMENTO</td>
                    </tr>
                    <tr><td>&nbsp;</td>
                        <td colspan=4>Nome identificativo Rete di Teleriscaldamento $nome_rete</td>
                    </tr>
					<tr><td>&nbsp;</td>
                        <td colspan=4>Gestore della Rete di Teleriscaldamento (ragione sociale ed indirizzo)" 
    if {[db_0or1row gest "select d.* from coimaimp a, coimdist d where d.cod_distr = a.cod_distributore and a.cod_impianto = :cod_impianto"] == 0} {
	set ragione_01 ""
	set indirizzo ""
	set numero ""
	set localita ""
	set comune ""
	set provincia ""
    }
    append stampa2 "$ragione_01 $indirizzo, $numero - $localita $comune ($provincia) $cap
		      </td>
                    </tr>	
                    <tr><td>1.7</td>
                        <td colspan=4 nowrap>PROGETTISTA DELL'IMPIANTO TERMICO (nominativo e n. di iscrizione all'ordine o collegio)</td>
                    </tr>
                    <tr><td>&nbsp;</td>
                        <td colspan=4>$nome_prog $reg_prog</td>
                    </tr>
                    <tr><td>1.8</td>
                        <td colspan=4 nowrap>INSTALLATORE DELL'IMPIANTO TERMICO (ragione sociale e n. di iscrizione a CCIAA e/o AA)</td>
                    </tr>
                    <tr><td>&nbsp;</td>
                        <td colspan=4>$nome_inst $reg_inst</td>
                    </tr>
                    <tr><td>1.9</td>
                        <td colspan=4>PROPRIETARIO O PROPRIETARI (cognome, nome e indirizzo)<small><sup>(1)</sup></small></td>
                    </tr>
                    <tr><td>&nbsp;</td>
                        <td colspan=4>$nome_prop</td>
                    </tr>"
    if {![string equal $nome_prop ""]} {
	append stampa2 "<tr><td>&nbsp;</td>
	                    <td colspan=4>$indir_p $nome_comu_p $sigla_p</td>
	                	</tr>"
    }
    append stampa2 "<tr><td>1.10</td>
                        <td colspan=4>AMMINISTRATORE (cognome, nome e indirizzo)<small><sup>(2)</sup></small></td>
                    </tr>
                    <tr><td>&nbsp;</td>
                        <td colspan=4>$nome_ammi</td>
                    </tr>"
    if {![string equal $nome_ammi ""]} {
	append stampa2 "<tr><td>&nbsp;</td>
                        <td colspan=4>$indir_a $nome_comu_a $sigla_a</td>
                    </tr>"
    }
    append stampa2 "<tr><td>&nbsp;</td>
                        <tr><td colspan=3>Data della scheda: $data_sche</td>
                        <td nowrap><small>Firma del responsabile dell'esercizio e della mautenzione</small></td>
                    <tr><td colspan=5>&nbsp;</td>
                    </tr>
        </table></td></tr>
    </table>
        <tr><td><small>(1) In caso di propriet&agrave; in condominio indicare condomini, in caso di propriet&agrave; di persona giuridica la ragione sociale.
                <br>(2) Da compilare nei casi di propriet&agrave; in condominio o di propriet&grave; di persona giuridica.
                </small>
        </td></tr>"
} elseif {$cod_comb == $cod_pomp} {
    set nome_file2 "allegato e4"
    set titolo "Stampa allegato E<small>4</small>";#19/04/2013
    append stampa2 "
	<table width=100%>
        <tr><td align=left><i>Allegato E4 - Scheda identificativa per Impianti a Pompa di Calore</i></td></tr>
        <tr><td align=center>1. SCHEDA IDENTIFICATIVA DELL'IMPIANTO</td></tr>
        <tr><td align=center>(trasmettere copia della scheda all'Ente locale competente per i controlli)</td></tr>
    </table>
    <table width=100% border=1>
        <tr><td><table width=100%>
                    <tr><td width=3%>1.1</td><td colspan=4>UBICAZIONE E DESTINAZIONE DELL'EDIFICIO</td>
                    </tr>
                    <tr><td>&nbsp;</td>
                        <td colspan=3 nowrap>n. catasto impianto: $cod_impianto_est</td>
                        <td>Volumetria riscaldata (m<sup><small>3</small></sup>): $volimetria_risc</td>
                    </tr>
                    <tr><td>&nbsp;</td>
                        <td colspan=3>Indirizzo: $via_imp</td>
                        <td colspan=1>N.: $num_imp</td>
                    </tr>
                    <tr><td>&nbsp;</td>
                        <td nowrap>Scala: $scala_imp</td>
                        <td nowrap>Piano: $piano_imp</td>
                        <td nowrap>Interno: $interno_imp</td>
                        <td nowrap>Cap: $cap</td>
                    </tr>
                    <tr><td>&nbsp;</td>
                        <td nowrap>Localit&agrave;: $localita</td>
                        <td colspan=2 nowrap>Comune: $nome_comu</td>
                        <td nowrap>Provincia: $prov</td>
                    </tr>
                    <tr><td>&nbsp;</td>
                        <td colspan=4>Edificio adibito a: $descr_cted</td>
                    </tr>
                    <tr><td>&nbsp;</td>
                        <td colspan=4>Categoria: $cod_cted</td>
                    </tr>
		    		<tr><td colspan=5>&nbsp;</td></tr>
                    <tr><td>1.2</td><td colspan=4>IMPIANTO TERMICO INDIVIDUALE DESTINATO A</td>
                    </tr>
                    <tr><td>&nbsp;</td>
                        <td colspan=4>$dest_uso</td>
                    </tr>"
    if {$dest_uso == "Altro"} {
	append stampa2 "<tr><td>&nbsp;</td>
                        <td colspan=4>$note_dest</td>
                    </tr>"
    }
    append stampa2 "<tr><td colspan=5>&nbsp;</td></tr>
                    <tr><td>1.3</td>
                        <td colspan=4>DATA DI INSTALLAZIONE/RISTRUTTURAZIONE</td>
                    </tr>
                    <tr><td>&nbsp;</td>
                        <td colspan=4>$data_installaz</td>
                    </tr>
                    <tr><td colspan=5>&nbsp;</td></tr>
                    <tr><td>1.4</td>
                        <td colspan=4>POMPA DI CALORE</td>
                    </tr>
                    <tr><td>&nbsp;</td>
                        <td nowrap>Alimentazione: $descr_alim</td>
                        <td nowrap>COP: $cop</td>
						<td nowrap>PER: $per</td>
						<td>&nbsp;</td>
					</tr>
					<tr><td>&nbsp;</td>
                    	<td colspan=4>Fonte di calore: $descr_fdc</td>
                    </tr>
                    <tr><td colspan=5>&nbsp;</td></tr>
                    <tr><td>1.5</td>
                        <td colspan=4 nowrap>PROGETTISTA DELL'IMPIANTO TERMICO (nominativo e n. di iscrizione all'ordine o collegio)</td>
                    </tr>
                    <tr><td>&nbsp;</td>
                        <td colspan=4>$nome_prog $reg_prog</td>
                    </tr>
					<tr><td colspan=5>&nbsp;</td></tr>
                    <tr><td>1.6</td>
                        <td colspan=4 nowrap>INSTALLATORE DELL'IMPIANTO TERMICO (ragione sociale e n. di iscrizione a CCIAA e/o AA)</td>
                    </tr>
                    <tr><td>&nbsp;</td>
                        <td colspan=4>$nome_inst $reg_inst</td>
                    </tr>
					<tr><td colspan=5>&nbsp;</td></tr>
                    <tr><td>1.7</td>
                        <td colspan=4>PROPRIETARIO O PROPRIETARI (cognome, nome e indirizzo)<small><sup>(1)</sup></small></td>
                    </tr>
                    <tr><td>&nbsp;</td>
                        <td colspan=4>$nome_prop</td>
                    </tr>"
    if {![string equal $nome_prop ""]} {
	append stampa2 "<tr><td>&nbsp;</td>
	                    <td colspan=4>$indir_p $nome_comu_p $sigla_p</td>
	                </tr>"
    } 
    append stampa2 "<tr><td colspan=5>&nbsp;</td></tr>
                    <tr><td>1.8</td>
                        <td colspan=4>AMMINISTRATORE (cognome, nome e indirizzo)<small><sup>(2)</sup></small></td>
                    </tr>
                    <tr><td>&nbsp;</td>
                        <td colspan=4>$nome_ammi</td>
                    </tr>"
    if {![string equal $nome_ammi ""]} {
	append stampa2 "<tr><td>&nbsp;</td>
                        <td colspan=4>$indir_a $nome_comu_a $sigla_a</td>
                    </tr>"
    }
    append stampa2 "<tr><td colspan=5>&nbsp;</td></tr>
                    <tr><td>&nbsp;</td>
                        <td colspan=3>Data $sysdate_edit</td>
                        <td nowrap><small>Firma del responsabile dell'esercizio e della mautenzione</small></td>
                    <tr><td colspan=4>&nbsp;</td>
                    </tr>
        </table></td></tr>
    </table>
        <tr><td><small>(1) In caso di propriet&agrave; in condominio indicare condomini, in caso di propriet&agrave; di persona giuridica la ragione sociale.
                <br>(2) Da compilare nei casi di propriet&agrave; in condominio o di propriet&grave; di persona giuridica.
                </small>
        </td></tr>"
}

set nome_file1_est    $nome_file1;#19/04/2013
set nome_file1        [iter_temp_file_name $nome_file1]
set file_html1        "$spool_dir/$nome_file1.html"
set file_pdf1         "$spool_dir/$nome_file1.pdf"
set file_pdf_url1     "$spool_dir_url/$nome_file1.pdf"

set file_id1   [open $file_html1 w]
fconfigure $file_id1 -encoding iso8859-1
set titolo "Stampa prima pagina libretto";#sim08
#sim08 puts $file_id1 $stampa1
puts $file_id1 $libretto_prima_pagina;#sim08
close $file_id1

# lo trasformo in PDF
iter_crea_pdf [list exec htmldoc --webpage --header ... --footer ... --quiet --bodyfont arial --fontsize 09 --left 1cm --right 1cm --top 1cm --bottom 0.2cm -f $file_pdf1 $file_html1]

if {![string equal $cod_comb $cod_tele] && ![string equal $cod_comb $cod_pomp]} {
#19/04/2013 old    set stampa_e "<td width=25% nowrap class=func-menu>
#19/04/2013 old		    <a href=\"#\" onclick=\"javascript:window.open('$file_pdf_url1', 'stampa', 'scrollbars=yes, resizable=yes')\">$titolo</a>
#19/04/2013 old    		  </td>"	
    set sw_stampa_file1 "SI";#19/04/2013
} else {
#19/04/2013 old    set stampa_e "" 
    set sw_stampa_file1 "NO";#19/04/2013
}
set stampa_e "";#19/04/2013: devo definire comunque la variabile altrimenti l'adp va in errore (anche se e' commentata anche sull'adp)

set nome_file2_est    $nome_file2;#19/04/2013
set nome_file2        [iter_temp_file_name $nome_file2]
set file_html2        "$spool_dir/$nome_file2.html"
set file_pdf2         "$spool_dir/$nome_file2.pdf"
set file_pdf_url2     "$spool_dir_url/$nome_file2.pdf"

set file_id2   [open $file_html2 w]
fconfigure $file_id2 -encoding iso8859-1

puts $file_id2 $stampa2
close $file_id2

# lo trasformo in PDF
iter_crea_pdf [list exec htmldoc --webpage --header ... --footer ... --quiet --bodyfont arial --fontsize 09 --left 1cm --right 1cm --top 1cm --bottom 0.2cm -f $file_pdf2 $file_html2]

# 19/04/2013 Nicola
# Imposto la url per chiamare il programma coimaimp-sch-allega-ed-esponi
# al posto di usare direttamente la url del file pdf dell'allegato E.
if {$sw_stampa_file1 != ""} {
    set path_file_pdf $file_pdf1
    set url_file_pdf  $file_pdf_url1
    set nome_file_est $nome_file1_est
} else {
    set path_file_pdf $file_pdf2
    set url_file_pdf  $file_pdf_url2
    set nome_file_est $nome_file2_est
}
set url_coimaimp_sch_allega_ed_esponi "coimaimp-sch-allega-ed-esponi?[export_url_vars cod_impianto nome_funz path_file_pdf url_file_pdf nome_file_est]"

#rom04M per la Regione Marche insieme alla stampa del libretto faccio una insert nella coimdocu
if {$coimtgen(regione) eq "MARCHE"} {#rom04M if e suo contenuto
    ns_unlink $file_html3;#sim01

    set data_corrente [iter_set_sysdate]
    set dml_sql [db_dml ins_docu " 
                insert
                  into coimdocu 
                     ( cod_documento
                     , tipo_documento
                     , cod_impianto
                     , data_stampa
                     , data_documento
                     , descrizione
                     , cod_soggetto
--sim10                     , contenuto
                     , path_file           --sim10
                     , tipo_contenuto)
                values 
                     ( (select nextval('coimdocu_s') as cod_documento)
                     ,'SI'
                     ,:cod_impianto
                     ,:data_corrente 
                     ,:data_corrente
                     ,'Libretto Impianto'
                     ,:cod_manutentore--id_utente
--sim10                     , lo_import(:file_pdf3)
                     , :file_pdf3
                     , 'application/pdf' 
                     )" ]
    
}

regsub -all $logo $stampa $logo_relativo stampa;#sim06


ns_unlink $file_html
ad_return_template
