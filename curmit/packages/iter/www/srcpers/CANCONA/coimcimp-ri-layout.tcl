ad_page_contract {
    Stampa Rapporto di verifica
    
    @author        Giulio Laurenzi
    @creation-date 18/08/2006

    @cvs-id coimcimp-layout.tcl

    USER  DATA       MODIFICHE
    ===== ========== =========================================================================
    rom02 19/04/2021 Coretta la stampa del campo new1_manu_prec_8a per la Sezione 7.

    rom01 13/01/2021 Per la regione i file verranno salvati su file system non sul db.

    gab01 22/08/2017 Aggiunto logo dell'Ente e piccole modifiche all'intestazione.

    sim01 21/06/2016 Aggiunta del logo alla stampa utilizzando i parametri stampe_logo_nome
    sim01            e stampe_logo_in_tutte_le_stampe.

} {
    {cod_cimp         ""}
    {funzione        "V"}
    {caller      "index"}
    {nome_funz        ""}
    {nome_funz_caller ""}
    {flag_ins        "S"}
} -properties {
    page_title:onevalue
    context_bar:onevalue
    form_name:onevalue
}

# imposto l'utente
set id_utente [ad_get_cookie iter_login_[ns_conn location]]

iter_get_coimtgen
set flag_viario coimtgen(flag_viario)

# controllo il parametro di "propagazione" per la navigation bar
if {[string is space $nome_funz_caller]} {
    set nome_funz_caller $nome_funz
}

set stampa ""

# Ricerca i parametri della testata
if {$flag_viario == "T"} {
    set sel_cimp "sel_cimp_si_vie"
} else {
    set sel_cimp "sel_cimp_si_vie"
}

if {[db_0or1row $sel_cimp ""] == 0} {
    iter_return_complaint "Rapporto di verifica non trovato"
    return
}

if {[db_0or1row sel_manutentore "select coalesce(a.cognome,'&nbsp;') as cogn_manut,
                                        coalesce(a.nome,'&nbsp;') || ' (manut.)' as nome_manut,
                                        coalesce(a.indirizzo,'&nbsp;') as indi_manut,
                                        coalesce(a.comune,'&nbsp;')   as comu_manut,
                                        coalesce(a.telefono, '&nbsp;') as tele_manut 
                                   from coimmanu a,
                                        coimaimp b 
                                  where b.cod_impianto = :cod_impianto
                                   and  a.cod_manutentore = b.cod_manutentore"] == 0} {

    set cogn_manut "&nbsp; "
    set nome_manut "&nbsp; "
    set indi_manut "&nbsp; "
    set comu_manut "&nbsp; "
    set tele_manut "&nbsp; "
 } 
 if {$data_controllo_db < "2012-06-01"} {
     set cogn_manut "&nbsp; "
     set nome_manut "&nbsp; "
     set indi_manut "&nbsp; "
     set comu_manut "&nbsp; "
     set tele_manut "&nbsp; "
  }


iter_get_coimdesc
set ente $coimdesc(nome_ente)

set logo_dir      [iter_set_logo_dir]
set img_checked "<img src=\"$logo_dir/check-in.gif\" height=10 width=10>"
set img_unchecked "<img src=\"$logo_dir/check-out.gif\" height=10 width=10>"

if {[string equal $data_installaz ""]} {
    set data_installaz "Non conosciuta"
}
if {[string equal $descr_comb ""]} {
    set descr_comb "&nbsp;"
}

if {[string equal $new1_data_dimp ""]} {
    set new1_data_dimp "&nbsp;"
}
if {[string equal $new1_data_paga_dimp ""]} {
    set new1_data_paga_dimp "&nbsp;"
}
if {[string equal $new1_data_ultima_manu ""]} {
    set new1_data_ultima_manu "&nbsp;"
}
if {[string equal $new1_data_ultima_anal ""]} {
    set new1_data_ultima_anal "&nbsp;"
}
if {[string equal $aimp_categoria_edificio ""]} {
    set aimp_categoria_edificio "Non noto"
}
if {[string equal $aimp_categoria_edificio ""]} {
    set aimp_categoria_edificio "&nbsp;"
}

set img_man_effettuata_si $img_unchecked
set img_man_effettuata_no $img_unchecked

#rom02if {[string equal $new1_data_ultima_anal "&nbsp;"]} {}
if {![string equal $new1_manu_prec_8a "Effettuata"]} {#rom02 aggiunta if ma non contenuto
    set man_effettuata "NO"
    set img_man_effettuata_no $img_checked
} else {
    set man_effettuata "SI"
    set img_man_effettuata_si $img_checked
}

set rend_comb_convc 0
set rend2 [expr $rend_comb_convc + 2]

if {[string equal $gend_fluido_termovettore ""]} {
    set gend_fluido_termovettore "Non noto"
}

set stp_8a ""
set stp_8b ""
set stp_8c ""
set stp_8d ""

if {[string equal $manutenzione_8a ""]} {
    set stp_8a ""
}

if {[string equal $manutenzione_8a "Non effettuata"]} {
    set stp_8a "Negativa"
}

if {[string equal $manutenzione_8a "Effettuata"]} {
    set stp_8a "Positiva"
}

if {[string equal $co_fumi_secchi_8b ""]} {
    set stp_8b ""
}

if {[string equal $co_fumi_secchi_8b "Irregolare"]} {
    set stp_8b "Negativa"
}

if {[string equal $co_fumi_secchi_8b "Regolare"]} {
    set stp_8b "Positiva"
}

if {[string equal $indic_fumosita_8c ""]} {
    set stp_8c ""
}

if {[string equal $indic_fumosita_8c "Irregolare"]} {
    set stp_8c "Negativa"
}

if {[string equal $indic_fumosita_8c "Regolare"]} {
    set stp_8c "Positiva"
}

if {[string equal $rend_comb_8d ""]} {
    set stp_8d ""
}

if {[string equal $rend_comb_8d "Sufficiente"]} {
    set stp_8d "Positiva"
}

if {[string equal $rend_comb_8d "Insufficiente"]} {
    set stp_8d "Negativa"
}

#ns_return 200 text/html "$stp_8d" ; ad_script abort
regsub -all \n  $new1_note_manu     \<br>  new1_note_manu
regsub -all \n  $note_verificatore  \<br>  note_verificatore
set note_conf [ad_quotehtml $note_conf]
regsub -all \n  $note_conf          \<br>  note_conf
regsub -all \n  $note_resp          \<br>  note_resp


set lista_anom "<tr><td valign=top align=left colspan=2><b>b) Codici elenco non conformit&agrave;:</b> "
db_foreach sel_anom "" {
    append lista_anom "$cod_tanom - $descr_tano;"
} if_no_rows {
    set lista_anom ""
}
if {$lista_anom != ""} {
    append lista_anom "</td></tr>"
}

if {![string equal $lista_anom ""]} {
     foreach anom $lista_anom {
	append stampa " $anom "
    }
}

if {$flag_resp == "T"} {
    set cogn_terz  $cogn_responsabile
    set nome_terz  $nome_responsabile
    set indi_terz  $indi_resp
    set comu_terz  $comu_resp
    set telef_terz $telef_resp
} else {
    set cogn_terz  $cogn_manut
    set nome_terz  $nome_manut
    set indi_terz  $indi_manut
    set comu_terz  $comu_manut
    set telef_terz $tele_manut
}

if {$flag_resp == "P"} {
    set cogn_occu $cogn_prop
    set nome_occu $nome_prop
    set indi_occu $indi_prop
    set comu_occu $comu_prop
    set telef_occu $telef_prop
}

 if {$data_controllo_db < "2012-06-01"} {
    set cogn_occu  $cogn_responsabile
    set nome_occu  $nome_responsabile
    set indi_occu  $indi_resp
    set comu_occu  $comu_resp
    set telef_occu $telef_resp
}

switch $new1_disp_regolaz {
    "M" {set new1_disp_regolaz_manu "S&igrave;"
         set new1_disp_regolaz_prog "&nbsp;"
         set new1_disp_regolaz_asse "&nbsp;"
     }
    "P" {set new1_disp_regolaz_manu "&nbsp;"
   	 set new1_disp_regolaz_prog "S&igrave;"
         set new1_disp_regolaz_asse "&nbsp;"
     }
    "A" {set new1_disp_regolaz_manu "&nbsp;"
   	 set new1_disp_regolaz_prog "&nbsp;"
         set new1_disp_regolaz_asse "S&igrave;"
     }
    default {set new1_disp_regolaz_manu "&nbsp;"
     	     set new1_disp_regolaz_prog "&nbsp;"
             set new1_disp_regolaz_asse "&nbsp;" 
     }
} 
switch $cod_emissione {
    "0" {set gend_tipologia_emissione "Canna fumaria non verificabile"}
    "C" {set gend_tipologia_emissione "Canna fumaria collettiva al tetto"}
    "I" {set gend_tipologia_emissione "Canna fumaria singola al tetto"}
    "P" {set gend_tipologia_emissione "Scarico direttamente all'esterno"}
    default {set gend_tipologia_emissione "Non Noto"}
}

switch $cod_emissione {
    "O" {set gend_tipologia_emissione_non_ver    "S&igrave"
         set gend_tipologia_emissione_collettiva "&nbsp;"
         set gend_tipologia_emissione_singola    "&nbsp;"
         set gend_tipologia_emissione_esterno    "&nbsp;"
    }
    "C" {set gend_tipologia_emissione_non_ver    "&nbsp;"
         set gend_tipologia_emissione_collettiva "S&igrave"
         set gend_tipologia_emissione_singola    "&nbsp;"
         set gend_tipologia_emissione_esterno    "&nbsp;"
    }
    "I" {set gend_tipologia_emissione_non_ver    "&nbsp;"
         set gend_tipologia_emissione_collettiva "&nbsp;"
         set gend_tipologia_emissione_singola    "S&igrave"
         set gend_tipologia_emissione_esterno    "&nbsp;"
    }
    "P" {set gend_tipologia_emissione_non_ver    "&nbsp;"
         set gend_tipologia_emissione_collettiva "&nbsp;"
         set gend_tipologia_emissione_singola    "&nbsp;"
         set gend_tipologia_emissione_esterno    "S&igrave"
    }
default {set gend_tipologia_emissione_non_ver    "&nbsp;"
         set gend_tipologia_emissione_collettiva "&nbsp;"
         set gend_tipologia_emissione_singola    "&nbsp;"
         set gend_tipologia_emissione_esterno    "&nbsp;"
    }
}

set gend_data_installazione_v $gend_data_installazione


if {[string equal $gend_data_installazione ""]} {
    set gend_data_installazione   "Non noto"
    set gend_eta_gend ""
} else {
  set gend_data_installazione [iter_check_date $gend_data_installazione]
	if {$gend_data_installazione <= "19010101"} {
	    set gend_eta_gend ">= 15 anni"
	} else {
	    if {[clock format [clock scan "$gend_data_installazione 15 year"] -format %Y%m%d] > [clock format [clock second] -format %Y%m%d]} {
		set gend_eta_gend "< 15 anni  $gend_data_installazione_v"
	    } else {
		set gend_eta_gend ">= 15 anni $gend_data_installazione_v"
	    }
	}
    }

#if {![string equal $data_inizio_campagna ""]
#&&  ![string equal $data_fine_campagna ""]
#} {
#    set periodo_campagna "<small>campagna $data_inizio_campagna $data_fine_campagna</small>"
#} else {
#    set periodo_campagna ""
#}
set dt_oggi [db_string q "select iter_edit_data(current_date)"]
set gend_matricola [ad_quotehtml $gend_matricola]

set logo_dir      [iter_set_logo_dir]

set stampe_logo_in_tutte_le_stampe [parameter::get_from_package_key -package_key iter -parameter stampe_logo_in_tutte_le_stampe -default "0"];#sim01
set stampe_logo_nome               [parameter::get_from_package_key -package_key iter -parameter stampe_logo_nome];#sim01
set stampe_logo_height             [parameter::get_from_package_key -package_key iter -parameter stampe_logo_height];#sim01
set logo_dx_nome                   [parameter::get_from_package_key -package_key iter -parameter master_logo_dx_nome];#gab01
set master_logo_sx_titolo_sopra    [parameter::get_from_package_key -package_key iter -parameter master_logo_sx_titolo_sopra];#gab01
set master_logo_sx_titolo_sotto    [parameter::get_from_package_key -package_key iter -parameter master_logo_sx_titolo_sotto];#gab01


if {$stampe_logo_in_tutte_le_stampe eq "1" && $stampe_logo_nome ne ""} {#sim01 Aggiunta if e suo contenuto
    if {$stampe_logo_height ne ""} {
        set height_logo "height=$stampe_logo_height"
    } else {
        set height_logo ""
    }
    set logo "<img src=$logo_dir/$stampe_logo_nome $height_logo>"
    set logo_dx "<img src=$logo_dir/$logo_dx_nome $height_logo>";#gab01 
} else {
    set logo ""
    set logo_dx "";#gab01
}

set stampa "
<!-- FOOTER RIGHT  \"Pagina \$PAGE(1) di \$PAGES(1)\"-->
<table border=0 width=100%>
  <tr>
    <td width=100%>
      <table width=100% border=1 bgcolor=#D6D6D6>
        <tr>"

if {$stampe_logo_in_tutte_le_stampe eq "1" && $stampe_logo_nome ne ""} {#sim01
    append stampa "
          <td width=5%>$logo</td>
          <!-- gab01 -->
          <td width=90%>
          <!-- gab01 <td width=95%> -->";#sim01
} else {#sim01
    append stampa "
          <td width=100%>"
};#sim01

set dicitura_comune "$master_logo_sx_titolo_sopra $master_logo_sx_titolo_sotto";#gab01

append stampa "
            <table width=100%>
              <tr>
                <td width=100% align=center colspan=2><b>VERIFICA DELLO STATO DI MANUTENZIONE ED ESERCIZIO DEGLI IMPIANTI TERMICI</b></td>
              </tr>
              <tr>
                <td align=center colspan=2><b>(ai sensi del DLgs 192/05 e succ. mod.)</b></td>
              </tr>
              <tr>
                <!-- gab01 <td align=left><b>$ente</b></td> -->
                <!-- gab01 -->
                <td align=left><b>$dicitura_comune</b></td>
                <td align=right><b>$ente</b></td>
              </tr>
            </table>"
if {$stampe_logo_in_tutte_le_stampe eq "1" && $stampe_logo_nome ne ""} {#gab01
    append stampa "
          </td>
          <td width=5%>$logo_dx</td>"
} else {#gab01
    append stampa "
          </td>"
}

if {$int_rend_term eq "NON ESEGUITO"} {
    set int_rend_term "Valutazione non eseguita, motivo: $int_rend_term_note"
}

set img_rapp_cont_inviato_si $img_unchecked
set img_rapp_cont_inviato_no $img_unchecked
set img_rapp_cont_bollino_si $img_unchecked
set img_rapp_cont_bollino_no $img_unchecked

if {$rapp_cont_inviato eq "S"} {
    set img_rapp_cont_inviato_si $img_checked
}

if {$rapp_cont_inviato eq "N"} {
    set img_rapp_cont_inviato_no $img_checked
}

if {$rapp_cont_bollino  eq "S"} {
    set img_rapp_cont_bollino_si $img_checked
}

if {$rapp_cont_bollino  eq "N"} {
    set img_rapp_cont_bollino_no $img_checked
}


append stampa "
        </tr>   
      </table>
    </td>   
  </tr>
  <tr>
    <td>
      <table width=100% border=1>
        <tr bgcolor=#D6D6D6>
          <td colspan=4 width=100% align=center valign=top ><b>1. DATI GENERALI</b></td>
        </tr>
        <tr>
          <td valign=top align=left bgcolor=#D6D6D6>a)Catasto Impianti/codice</td>
          <td valign=top colspan=3>$cod_impianto_est</td>
        </tr>
        <tr>
          <td valign=top bgcolor=#D6D6D6 align=left>b) Ispezione</td>
          <td valign=top >Data: $data_controllo</td>
          <td valign=top >Ora: $ora_inizio</td>
          <td valign=top >Numero: $verb_n</td>
        </tr>
</table>
<table width=100% border=1>
        <tr>
          <tr>
          <td valign=top  bgcolor=#D6D6D6 align=left nowrap>c) Rapporto di controllo efficienza energetica</td>
          <td valign=top >Inviato $img_rapp_cont_inviato_si Si $img_rapp_cont_inviato_no No Bollino presente $img_rapp_cont_bollino_si Si $img_rapp_cont_bollino_no No</td>
          <td valign=top >Data compilazione: $dt_oggi</td>
        </tr>
</table>
<table width=100% border=1>
        <tr>
          <td valign=top bgcolor=#D6D6D6 align=left>d) Ispettore</td>
          <td valign=top nowrap>Cognome e nome: $opve</td>
          <td valign=top colspan=2>Estremi/qualifica:&nbsp;</td>
        </tr>
        <tr>
          <td valign=top align=left bgcolor=#D6D6D6>e) Impianto</td>
          <td valign=top align=left>Data Prima installazione: $data_installaz</td>
          <td valign=top align=left>Potenze termiche nominali totali:</td>
          <td valign=top align=left>al focolare $potenza_nom_tot_foc (kW)<br>Utile $potenza_nom_tot_util (kW)</td>
        </tr>
        <tr>
          <td valign=top align=left bgcolor=#D6D6D6 rowspan=2>f) Ubicazione</td>
          <td valign=top>Comune: $descr_comu</td>
          <td valign=top colspan=2>Localit&agrave; $localita</td>
        </tr>
        <tr>
          <td valign=top colspan=3>Indirizzo: $ubicazione</td>
        </tr>
        <tr> 
          <td colspan=1 bgcolor=#D6D6D6>g) Responsabile</td>
          <td colspan=3>$aimp_flag_resp_desc </td>
        </tr>
        <tr>
          <td bgcolor=#D6D6D6 valign=top colspan=4 align=center>h/i) Proprietario/Occupante</td>
        </tr>
        <tr>
          <td valign=top colspan=1>Cognome e nome<br>Ragione sociale</td>
          <td valign=top colspan=3>$cogn_occu $nome_occu</td>
        </tr>
        <tr>
          <td valign=top colspan=1 >Indirizzo</td>
          <td valign=top colspan=3>$indi_occu</td>
        </tr>
        <tr>
          <td valign=top colspan=1>Comune</td>
          <td valign=top colspan=3>$comu_occu</td>
        </tr>
        <tr>
          <td valign=top colspan=1>Telefono</td>
          <td valign=top colspan=3>$telef_occu</td>
        </tr>
        <tr>
          <td valign=top colspan=2 align=center bgcolor=#D6D6D6>k) Amministratore cond.</td>
          <td valign=top colspan=2 align=center bgcolor=#D6D6D6>j) Terzo Responsabile/Manutentore</td>
        </tr>
        <tr>
          <td valign=top>Cognome e nome<br>Ragione sociale</td>
          <td valign=top>$cogn_amministratore $nome_amministratore</td>
          <td valign=top>Cognome e nome<br>Ragione sociale</td>
          <td valign=top>$cogn_terz $nome_terz</td>
        </tr>
        <tr>
          <td valign=top>Indirizzo</td>
          <td valign=top>$indi_ammin</td>
          <td valign=top>Indirizzo</td>
          <td valign=top>$indi_terz</td>
        </tr>
        <tr>
          <td valign=top>Comune</td>
          <td valign=top>$comu_ammin</td>
          <td valign=top>Comune</td>
          <td valign=top>$comu_terz</td>
        </tr>
        <tr>
          <td valign=top>Telefono/fax</td>
          <td valign=top>$telef_ammin</td>
          <td valign=top>Telefono/fax</td>
          <td valign=top>$telef_terz</td>
        </tr>
        <tr>
          <td valign=top align=left>Eventuale delegato : </td>
          <td valign=top colspan=3>$nominativo_pres  - Delega presente : $delega_pres</td>
        </tr>
      </table>
    </td>
  </tr>
  <tr>
    <td>
      <table border=1 width=100%>
        <tr bgcolor=#D6D6D6>
          <td colspan=4 align=center valign=top ><b> 2. DESTINAZIONE</b></td>
        </tr>
        <tr>
          <td valign=top bgcolor=#D6D6D6>a) Categoria dell'edificio </td>
          <td valign=top colspan=3>$aimp_categoria_edificio</td>
        </tr>
        <tr>
          <td valign=top bgcolor=#D6D6D6>b) Unit&agrave; immobiliari servite</td>
          <td valign=top >$aimp_tipologia</td>
          <td valign=top bgcolor=#D6D6D6>c)Uso dell'impianto</td>
          <td valign=top >$gend_destinazione_uso</td>
        </tr>
        <tr>
          <td valign=top bgcolor=#D6D6D6>d) Volume lordo riscaldato</td>
          <td valign=top >$volumetria (m<sup>3</sup>)</td>
          <td valign=top bgcolor=#D6D6D6>e) Combustibile</td>
          <td valign=top >$descr_comb</td>
        </tr>
        <tr>
          <td valign=top bgcolor=#D6D6D6 rowspan=2>f) Trattamento dell'acqua</td>
          <td valign=top >in riscaldamento</td>
          <td valign=top colspan=2>$tratt_in_risc</td>
        </tr>
        <tr>
          <td valign=top>in Produzione di ACS</td>
          <td valign=top colspan=2>$tratt_in_acs</td>
        </tr>
      </table>
   </small> </td>
  </tr>
 <tr>
    <td>
       <table border=1 width=100%>
        <tr bgcolor=#D6D6D6>
          <td colspan=4 align=center valign=top ><b>3. CONTROLLO DELL'IMPIANTO</b></td>
        </tr>
	<tr>         
	  <td bgcolor=#D6D6D6 valign=top align=left class=form_title>a) Installazione interna: locale idoneo</td>
          <td valign=top align=left>$interna_locale_idoneo</td>            
	  <td bgcolor=#D6D6D6 valign=top align=left class=form_title>b) Installazione esterna: geneneratori idonei</td>
          <td valign=top align=left class=form_title>$esterna_generatore_idoneo</td>
        </tr>
        <tr>
	  <td bgcolor=#D6D6D6 valign=top align=left class=form_title>c) Sistema di ventilazione sufficiente</td>
          <td valign=top align=left>$ventilazione_locali</td> 
	  <td bgcolor=#D6D6D6 valign=top align=left class=form_title>d) Sistema evacuazione fumi idoneo (esame visivo)</td>
          <td valign=top align=left>$canale_fumo_idoneo</td>
	</tr>
        <tr> 
          <td bgcolor=#D6D6D6 valign=top align=left>e) Cartellonistica prevista presente</td>
          <td valign=top align=left>$new1_pres_cartell</td>
          <td bgcolor=#D6D6D6 valign=top align=left>f) Mezzi estinzione incendi presenti e revisionati</td>
          <td valign=top align=left>$new1_pres_mezzi</td>
        </tr>
        <tr> 
          <td bgcolor=#D6D6D6 valign=top align=left>g) Interruttore generaleerno presente</td>
          <td valign=top align=left>$new1_pres_interrut</td>
          <td bgcolor=#D6D6D6 valign=top align=left>h) Rubinetto intercettazione manuale esterna presente</td>
          <td valign=top align=left>$new1_pres_intercet</td>
        </tr>
          <tr> 
          <td bgcolor=#D6D6D6 valign=top align=left>i) Assenza perdite comb. (esame visivo)</td>
          <td valign=top align=left>$ass_perdite_comb</td>
	  <td bgcolor=#D6D6D6 valign=top align=left class=form_title>j) Sistema regolazione temp. ambiente funzionate</td>
          <td valign=top align=left>$verifica_disp_regolazione</td>
        </tr>
      </table>
	</small>
    </td>
  </tr>
 <tr>
 <td>
       <table border=1 width=100%>
        <tr bgcolor=#D6D6D6>
          <td colspan=4 align=center valign=top ><b>4. STATO DELLA DOCUMENTAZIONE</b></td>
        </tr>
        <tr> 
          <td bgcolor=#D6D6D6 valign=top align=left>a) Libretto di impianto presente</td>
          <td valign=top align=left>$pres_libr</td>
          <td bgcolor=#D6D6D6 valign=top align=left>b) Libretto di impianto compilato in tutte le sue parti</td>
          <td valign=top align=left>$libr_corr</td>
        </tr>
        <tr> 
          <td bgcolor=#D6D6D6 valign=top align=left>c) Dic. conformit&agrave;/rispondenza presente</td>
          <td valign=top align=left>$dich_conformita</td>
          <td bgcolor=#D6D6D6 valign=top align=left>d) Libretti uso/manutenzione generatire presente</td>
          <td valign=top align=left>$libr_manut</td>
        </tr>
         <tr> 
          <td bgcolor=#D6D6D6 valign=top width=40% align=left>e) Pratica VV.F. presente ove richiesto</td>
          <td valign=top width=10% align=left>$doc_prev_incendi</td>
          <td bgcolor=#D6D6D6 valign=top width=35% align=left>Pratica INAIL presente (gi&agrave; ISPESL)</td>
          <td valign=top width=15% align=left>$doc_ispesl</td>
        </tr>
      </table>
     </small>
    </td>
  </tr>
 <tr>
 <td>
       <table border=1 width=100%>        
         <tr bgcolor=#D6D6D6>
          <td colspan=2 align=center valign=top ><b>5. INTERVENTI DI MIGLIORAMENTO ENERGETICO DELL'IMPIANTO</b></td>
         </tr>
         <tr>
          <td align=left valign=top bgcolor=#D6D6D6 rowspan=4 >a) Check-list</td>
          <td  valign=top align=left>$check_valvole - Adozione di valvole termostatiche sui corpi scaldanti</td>
         </tr>
         <tr>
          <td  valign=top align=left>$check_isolamento - Isolamento della rete di distribuzione nei locali non riscaldati</td>
         </tr>
         <tr>
          <td valign=top align=left>$check_trattamento - Introduzione di un sistema di trattamento dell'acqua</td>
         </tr>
         <tr>
          <td  valign=top align=left>$check_regolazione - Sostituzione di un sistema di regolazione on/off con uno programmabile</td>
         </tr>
         <tr>
          <td align=left valign=top bgcolor=#D6D6D6>b) Interventi atti a migliorare il rendimento energetico</td>
          <td valign=top align=left>$int_rend_term</td>
         </tr>
         <tr>
          <td align=left valign=top bgcolor=#D6D6D6>c) Stima del dimensionamento del/i generatore/i</td>
          <td valign=top align=left>$dimensionamento_gen</td>
         </tr>
      </table>
     </small>
    </td>
  </tr>
  <tr>
    <td>
       <table border=1 width=100%>
        <tr bgcolor=#D6D6D6>
          <td colspan=4 align=center valign=top ><b>6. GENERATORE</b></td>
        </tr>
        <tr>
          <td bgcolor=#D6D6D6 valign=top width=\"25%\" align=left class=form_title>a) Generatore</td>
          <td valign=top width=\"25%\" align=left class=form_title bgcolor=white>N° $gend_gen_prog_est&nbsp;&nbsp; di $n_generatori</td>
          <td bgcolor=#D6D6D6 valign=top width=\"50%\" align=left class=form_title colspan=2>k) Dati nominali</td>
        </tr>
        <tr>
          <td bgcolor=#D6D6D6 valign=top align=left class=form_title>b)Data installazione</td>
          <td valign=top  align=left class=form_title bgcolor=white>$data_installaz</td>
          <td rowspan=4 colspan=2>
            <table width=100%  border=0>
              <tr>
                <td valign=top align=left class=form_title>Potenza termica al focolare:</td>
                <td valign=top align=left>$pot_focolare_nom (kW)</td>
              </tr>
              <tr>
                <td align=left class=form_title>Potenza termica utile:</td>
                <td valign=top align=left>$pot_utile_nom (kW)</td>
              </tr>
              <tr>
                <td valign=middle align=left class=form_title rowspan=2>Campo di lavoro bruciatore:</td>
                <td valign=top align=left>da: $gend_campo_funzion_min_edit (kW)</td>
              </tr>
              <tr>
                <td valign=top align=left>a: $gend_campo_funzion_max_edit (kW)</td>
              </tr>
            </table>
          </td>
        </tr>
        <tr>
          <td bgcolor=#D6D6D6 valign=top align=left class=form_title>c) Fluido termovettore</td>
          <td valign=top  align=left class=form_title bgcolor=white>$gend_fluido_termovettore</td>
        </tr>
        <tr>
          <td bgcolor=#D6D6D6 valign=top align=left class=form_title>d) Modalit&agrave; di evacuazione fumi</td>
          <td valign=top  align=left class=form_title bgcolor=white>$gend_tiraggio</td>
        </tr>
        <tr>
          <td bgcolor=#D6D6D6 valign=top align=left class=form_title>e) Costruttore caldaia</td>
          <td valign=top align=left class=form_title bgcolor=white>$gend_descr_cost</td>  
        </tr> 
        <tr>
          <td bgcolor=#D6D6D6 valign=top align=left class=form_title>f) Modello e matricola caldaia</td>
          <td valign=top align=left class=form_title bgcolor=white>$gend_modello $gend_matricola</td>  
          <td bgcolor=#D6D6D6 valign=top align=left class=form_title colspan=2>l) Dati misurati:</td>
        </tr> 
        <tr>
          <td bgcolor=#D6D6D6 valign=top align=left class=form_title>g) Costruttore Bruciatore</td>
          <td valign=top align=left class=form_title bgcolor=white>$gend_descr_cost_bruc</td>  
          <td rowspan=2 colspan=2>
            <table width=100% border=0>
              <tr>
                <td valign=top align=left class=form_title>Portata di combustibile:</td>
                <td valign=top align=left>$mis_port_combust (m<sup>3</sup>/h)/(kg/h)</td>
              </tr>
              <tr>
                <td valign=top align=left class=form_title>Potenza termica al focolare:</td>
                <td valign=top align=left>$mis_pot_focolare (kW)</td>
              </tr>
            </table>
          </td>
        </tr> 
        <tr>
          <td bgcolor=#D6D6D6 valign=top align=left class=form_title>h) Modello e matricola bruciatore</td>
          <td valign=top align=left class=form_title bgcolor=white>$gend_modello_bruc $gend_matricola_bruc</td>  
        </tr>
        <tr>
          <td bgcolor=#D6D6D6 valign=top align=left class=form_title>i) Tipologia gruppo termico</td>
          <td valign=top align=left class=form_title bgcolor=white colspan=3>$gend_tipo_foco</td>
        <tr>
          <td bgcolor=#D6D6D6 valign=top align=left class=form_title>j) Classificazione DPR 660/96</td>
          <td valign=top align=left class=form_title bgcolor=white colspan=3>$gend_dpr_660_96</td>  
        </tr>
</small>
      </table>
       
    </td>
  </tr>
"

set img_new1_dimp_prescriz $img_unchecked
set img_rcee_osservazioni $img_unchecked
set img_rcee_raccomandazioni $img_unchecked

if {$img_new1_dimp_prescriz eq "S&igrave;"} {
    set img_new1_dimp_prescriz $img_checked
}

if {$rcee_raccomandazioni eq "S"} {
    set img_rcee_raccomandazioni $img_checked
}

if {$rcee_osservazioni eq "S"} {
    set img_rcee_osservazioni $img_checked
}

append stampa "
  <tr>
    <td>
      <table border=1 width=100%>
        <tr bgcolor=#D6D6D6>
          <td colspan=3 align=center valign=top><b>7. MANUTENZIONE ED ANALISI</b></td>
        </tr>
       <tr>
          <td valign=top align=left bgcolor=#D6D6D6 rowspan=2>a) Operazioni di controllo e manutenzione</td>
          <td valign=top align=left colspan=2>Frequenza $frequenza_manut $frequenza_manut_altro</td>
        </tr>
        <tr>
          <td valign=top align=left nowrap colspan=2 >Ultima manutenzione prevista effettuata $img_man_effettuata_si Si $img_man_effettuata_no No  &nbsp;&nbsp;&nbsp;  In data: $new1_data_ultima_manu</td>
        </tr>
        <tr>
          <td  align=left bgcolor=#D6D6D6>b) Rapporto controllo efficienza energetica</td>
          <td valign=top  align=left>Presente $new1_dimp_pres</td>
          <td valign=top align=left>Con Osservazioni $img_rcee_osservazioni Raccomandazioni $img_rcee_raccomandazioni Prescrizioni $img_new1_dimp_prescriz</td>
        </tr>
      </table>
  </small> 
    </td>
  </tr>
  <tr>
    <td>
       <table border=1 width=100%>
        <tr bgcolor=#D6D6D6>
          <td colspan=4 align=center valign=top><b>8. MISURA DEL RENDIMENTO DI COMBUSTIONE (UNI 10389-1)</b></td>
        </tr>
        <tr>
          <td bgcolor=#D6D6D6 valign=top align=left class=form_title>a) Modulo termico</td>
          <td valign=top align=left class=form_title bgcolor=white>N° $gend_gen_prog_est&nbsp;&nbsp; di $n_generatori</td>
          <td bgcolor=#D6D6D6 valign=top align=left class=form_title>b) Indice di fumosit&agrave; <small>(solo per combustibili liquidi)</small></td>
          <td valign=top align=left class=form_title bgcolor=white nowrap>1° misura: &nbsp; $indic_fumosita_1a &nbsp;&nbsp;&nbsp; 2° misura: &nbsp; $indic_fumosita_2a &nbsp;&nbsp;&nbsp; 3° misura: &nbsp; $indic_fumosita_3a</td>
        </tr>
        <tr>
          <td bgcolor=#D6D6D6 valign=top align=left class=form_title>c) Strumento utilizzato</td>
          <td align=left valign=top class=form_title>Marca: &nbsp;&nbsp;&nbsp; $marca_01</td>
          <td align=left valign=top class=form_title>Modello: &nbsp;&nbsp;&nbsp; $modello_01</td>
          <td align=left valign=top class=form_title>Matricola: &nbsp;&nbsp;&nbsp; $matricola_01</td>
        </tr>
       </table>
       <table width=100% border=1>
        <tr>
           <td bgcolor=#D6D6D6 valign=top align=center class=form_title colspan=2>d) Valori Misurati (media delle tre misure)</td>
           <td bgcolor=#D6D6D6 valign=top align=center class=form_title colspan=2>e) Valori Calcolati</td>
        </tr>
        <tr>
          <td align=left valign=top class=form_title nowrap width=25%>Temperatura del fluido di mandata (°C)</td>
          <td align=left valign=top class=form_title width=25%>$temp_h2o_out_1a</td>
          <td align=left valign=top class=form_title width=25%>Indice d'aria (n)</td>
          <td align=left valign=top class=form_title width=25%>$eccesso_aria_perc</td>
        </tr>
        <tr>
          <td align=left valign=top class=form_title nowrap>Temperatura dell'aria comburente (°C)</td>
          <td align=left valign=top class=form_title>$t_aria_comb_1a</td>
          <td align=left valign=top class=form_title>CO nei fumi secchi e senz'aria (ppm)</td>
          <td align=left valign=top class=form_title>$co_2a</td>
        </tr>
        <tr>
          <td align=left valign=top class=form_title>Temperatura fumi (°C)</td>
          <td align=left valign=top class=form_title> $temp_fumi_1a </td>
          <td align=left valign=top class=form_title>Potenza termica persa al camino Qs(%)</td>
          <td align=left valign=top class=form_title> $perdita_ai_fumi </td>
        </tr>
        <tr>
          <td align=left valign=top class=form_title>O<sub>2</sub> (%)</td>
          <td align=left valign=top class=form_title> $o2_1a </td>
          <td align=left valign=top class=form_title nowrap>Recupero calore di condensazione E.T. (%)</td>
          <td align=left valign=top class=form_title> $et </td>
        </tr>
        <tr>
          <td align=left valign=top class=form_title>CO<sub>2</sub> (%)</td>
          <td align=left valign=top class=form_title> $co2_1a </td>
          <td align=left valign=top class=form_title>Rendimento di combustione &#951;<sub>comb</sub> (%)</td>
          <td align=left valign=top class=form_title> $rend_comb_min </td>
        </tr>
        <tr>
          <td align=left valign=top class=form_title>CO nei fumi secchi (ppm)</td>
          <td align=left valign=top class=form_title colspan=3>$co_1a</td>
        </tr>
     </table>
    </td>
  </tr>
  <tr>
    <td>
      <table border=1 width=100% cellpadding=0 cellspacing=0>
        <tr>
          <td valign=top align=center colspan=2  bgcolor=#D6D6D6><b>9. ESITO DELLA PROVA</b></td>
        </tr>
        <tr>
          <td valign=top bgcolor=#D6D6D6 align=left class=form_title>a)<b> Monossido di carbonio</b><small> nei fumi secchi e senz'aria<br>(deve essere <= a 1000 ppm)</small></td>
          <td valign=top align=left>$co_fumi_secchi_8b</td>
        </tr>
        <tr>
          <td valign=top bgcolor=#D6D6D6 align=left class=form_title>b)<b> Indice di fumosit&agrave;</b><br><small>(deve essere: olio combustibile <=6; gasolio <=2)</small></td>
          <td valign=top align=left>$indic_fumosita_8c</td>
        </tr>
        <tr>
          <td valign=top bgcolor=#D6D6D6 align=left class=form_title>c)<b> Rendimento di combustione<br><small>(rendimento minimo richiesto &#951;<sub>DPR74</sub> $rend_comb_min %</small></td>
          <td valign=top align=left>Valore rilevato + 2 = $rend_comb_conv % &nbsp;&nbsp;&nbsp; $rend_comb_8d</td>
        </tr>
        <tr>
          <td valign=top bgcolor=#D6D6D6 align=left class=form_title rowspan=2>d) <b>L'impianto rispetta la normativa</b>&nbsp;&nbsp;&nbsp;$esito_verifica<br>(DPR 74/2013)</td> 
          <td valign=top bgcolor=#D6D6D6 align=left class=form_title rowspan=2>e) <b>L'impianto non rispetta la normativa</b> per quanto riguarda i punti:<br><div align=center>7a: $norm_7a &nbsp;&nbsp;&nbsp; 9a: $norm_9a &nbsp;&nbsp;&nbsp; 9b: $norm_9b &nbsp;&nbsp;&nbsp; 9c: $norm_9c</div></td>
        </tr>
      </table>
    </td>
  </tr>
  <tr>
    <td><table border=1 width=100%>
        <tr>
          <td colspan=2 align=center valign=top bgcolor=#D6D6D6><b>10. OSSERVAZIONI</b></td>
        </tr>
        <tr>
          <td valign=top align=justify colspan=2>$note_conf</td>
        </tr>
        $lista_anom
      </table>
    </td>
  </tr>
  <tr>
    <td><table border=1 width=100%>
        <tr>
          <td colspan=2 align=center valign=top bgcolor=#D6D6D6><b>11. PRESCRIZIONI</b></td>
        </tr>
        <tr>
          <td colspan=2 valign=top align=justify>$note_verificatore</td>
        </tr>
      </table>
    </td>
  </tr>
  <tr>
    <td><table border=1 width=100%>
        <tr>
          <td colspan=2 align=center valign=top bgcolor=#D6D6D6><b>12. DICHIARAZIONI DEL RESPONSABILE IMPIANTO</b></td>
        </tr>
        <tr>
          <td valign=top align=justify colspan=2>$note_resp</td>
        </tr>
      </table>
    </td>
  </tr>
  <tr>
    <td><table border=0 width=100%>
        <tr>
          <td valign=top aling=left width=60%>Importo controllo: Euro $costo</td>
          <td valing=top align=center width=40%>&nbsp;</td>
        </tr>
      </table>
    </td>
  </tr>
  <tr>
      </td> <table border=0 width=100%>
        <tr>
          <td valign=top align=center nowrap><b>FIRMA DEL RESPONSABILE DELL'IMPIANTO O SUO DELEGATO PER RICEVUTA</b></td>
          <td valign=top align=center ><b>FIRMA DELL'ISPETTORE</b></td>
        </tr>
        <tr>
          <td valign=top align=center>...................................&nbsp;</td>
          <td valign=top align=center>$opve</td>
        </tr>
        </table> 
    </td>
  </tr>
</table>"



#ns_return 200 text/html "$stampa"; return
# creo file temporaneo html
# imposto la directory degli spool ed il loro nome.
#rom01set spool_dir     [iter_set_spool_dir]
#rom01set spool_dir_url [iter_set_spool_dir_url]
set logo_dir      [iter_set_logo_dir]

set spool_dir_perm     [iter_set_permanenti_dir];#rom01
set spool_dir_url_perm [iter_set_permanenti_dir_url];#rom01

# imposto il nome dei file
set nome_file        "stampa rapporto di verifica"
#rom01set nome_file        [iter_temp_file_name $nome_file]
#rom01set file_html        "$spool_dir/$nome_file.html"
#rom01set file_pdf         "$spool_dir/$nome_file.pdf"
#rom01set file_pdf_url     "$spool_dir_url/$nome_file.pdf"

set nome_file    [iter_temp_file_name -permanenti $nome_file];#rom01
set file_html    "$spool_dir_perm/$nome_file.html";#rom01
set file_pdf     "$spool_dir_perm/$nome_file.pdf";#rom01
set file_pdf_url "$spool_dir_url_perm/$nome_file.pdf";#rom01


set   file_id  [open $file_html w]
fconfigure $file_id -encoding iso8859-1
puts  $file_id $stampa
close $file_id

# lo trasformo in PDF
iter_crea_pdf [list exec htmldoc --webpage --header ... --footer ... --quiet --bodyfont arial --fontsize 9 --left 1cm --right 1cm --top 1cm --bottom 0.5cm -f $file_pdf $file_html]

# Controllo se il Database e' Oracle o Postgres
set id_db     [iter_get_parameter database]

set sql_contenuto  "lo_import(:file_html)"
set tipo_contenuto [ns_guesstype $file_pdf]

set contenuto_tmpfile  $file_pdf

if {[db_0or1row sel_docu ""] == 0} {
    set flag_docu "N"
} else {
    set flag_docu "S"
}

if {$flag_ins == "S"} {
    with_catch error_msg {
	db_transaction {
	    if {[string equal $cod_documento ""]
		|| $flag_docu == "N"} {
		db_1row sel_docu_next ""
		set tipo_documento "RV"
		db_dml dml_sql_docu [db_map ins_docu]
		db_dml dml_sql_cimp [db_map upd_cimp]
	    } else {
		db_dml dml_sql_docu [db_map upd_docu]
	    }
	    
	    if {$id_db == "postgres"} {
		if {[db_0or1row sel_docu_contenuto ""] == 1} {
		    if {![string equal $docu_contenuto_check ""]} {
			db_dml dml_sql2 [db_map upd_docu_2]
		    }
		}
		db_dml dml_sql3 [db_map upd_docu_3]
	    } else {
		db_dml dml_sql2 [db_map upd_docu_2] -blob_files [list $contenuto_tmpfile]
	    }
	    
	}
    } {
	iter_return_complaint "Spiacente, ma il DBMS ha restituito il
        seguente messaggio di errore <br><b>$error_msg</b><br>
        Contattare amministratore di sistema e comunicare il messaggio
        d'errore. Grazie."
    }
}


ns_unlink $file_html
ad_returnredirect $file_pdf_url
ad_script_abort
