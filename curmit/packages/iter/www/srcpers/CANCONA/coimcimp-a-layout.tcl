ad_page_contract {
    Stampa Rapporto di verifica
    
    @author        Giulio Laurenzi
    @creation-date 18/08/2006

    @cvs-id coimcimp-layout.tcl

    USER  DATA       MODIFICHE
    ===== ========== =========================================================================
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
#set id_utente [ad_get_cookie iter_login_[ns_conn location]]
set id_utente [iter_get_id_utente]

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
    set sel_cimp "sel_cimp_no_vie"
}

if {[db_0or1row $sel_cimp ""] == 0} {
    iter_return_complaint "Rapporto di verifica non trovato"
    return
}

if {[db_0or1row sel_manutentore "select coalesce(a.cognome,'') as cogn_manut,
                                        coalesce(a.nome,'') || ' (manut.)' as nome_manut,
                                        a.indirizzo as indi_manut,
                                        a.comune    as comu_manut,
                                        a.telefono  as tele_manut 
                                   from coimmanu a,
                                        coimaimp b 
                                  where b.cod_impianto = :cod_impianto
                                   and  a.cod_manutentore = b.cod_manutentore"] == 0} {
    set cogn_manut ""
    set nome_manut ""
    set indi_manut ""
    set comu_manut ""
    set tele_manut ""
}

iter_get_coimdesc
set ente $coimdesc(nome_ente)

if {[string equal $data_installaz ""]} {
    set data_installaz "Non conosciuta"
}
if {[string equal $descr_comb ""]} {
    set descr_comb "Non noto"
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
    set aimp_categoria_edificio "Non noto"
}
if {[string equal $new1_data_ultima_anal ""]} {
    set man_effettuata "NO"
} else {
    set man_effettuata "SI"
}

set rend2 [expr $rend_comb_convc + 2]

if {[string equal $gend_fluido_termovettore ""]} {
    set gend_fluido_termovettore "Non noto"
}


regsub -all \n  $new1_note_manu     \<br>  new1_note_manu
regsub -all \n  $note_verificatore  \<br>  note_verificatore
regsub -all \n  $note_conf          \<br>  note_conf
regsub -all \n  $note_resp          \<br>  note_resp

set lista_anom "<tr><td valign=top align=left colspan=2><b>b) Codici elenco non conformit&agrave;:</b> "
db_foreach sel_anom "" {
    append lista_anom "$cod_tanom; "
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

if {[string equal $gend_data_installazione ""]} {
    set gend_data_installazione   "Non noto"
    set gend_eta_gend ""
} else {
  set gend_data_installazione [iter_check_date $gend_data_installazione]
	if {$gend_data_installazione <= "19010101"} {
	    set gend_eta_gend ">= 15 anni"
	} else {
	    if {[clock format [clock scan "$gend_data_installazione 15 year"] -format %Y%m%d] > [clock format [clock second] -format %Y%m%d]} {
		set gend_eta_gend "< 15 anni"
	    } else {
		set gend_eta_gend ">= 15 anni"
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

set logo_dir      [iter_set_logo_dir]

set stampe_logo_in_tutte_le_stampe [parameter::get_from_package_key -package_key iter -parameter stampe_logo_in_tutte_le_stampe -default "0"];#sim01
set stampe_logo_nome               [parameter::get_from_package_key -package_key iter -parameter stampe_logo_nome];#sim01
set stampe_logo_height             [parameter::get_from_package_key -package_key iter -parameter stampe_logo_height];#sim01

if {$stampe_logo_in_tutte_le_stampe eq "1" && $stampe_logo_nome ne ""} {#sim01: Aggiunta if e suo contenuto
    if {$stampe_logo_height ne ""} {
        set height_logo "height=$stampe_logo_height"
    } else {
        set height_logo ""
    }
    set logo "<img src=$logo_dir/$stampe_logo_nome $height_logo>"
} else {
    set logo ""
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
          <td width=95%>";#sim01
} else {#sim01
    append stampa "
          <td width=100%>"
};#sim01

append stampa "
            <table width=100%>
            <tr>
                <td width=100% align=center><b>VERIFICA DELLO STATO DI MANUTENZIONE ED ESERCIZIO DEGLI IMPIANTI TERMICI &#139 35 kW</b></td>
            </tr>
            <tr>
                <td align=center><b>(ai sensi del DLgs 192/05)</b></td>
            </tr>
            <tr>
                <td align=left><b>$ente</b></td>
            </tr>
            </table>
        </td></table>
    </tr>   
</tr>
<tr>
    <td><table width=100% border=1>
        <tr bgcolor=#D6D6D6>
            <td colspan=6 width=100% align=center valign=top ><b>1. DATI GENERALI</b></td>
        </tr>
        <tr>
            <td valign=top width=15% align=left bgcolor=#D6D6D6>a)Catasto Impianti/codice</td>
            <td valign=top width=15% >$cod_impianto_est</td>
            <td valign=top width=15%  bgcolor=#D6D6D6 align=left>b) Data ispezione</td>
            <td valign=top width=15% >$data_controllo</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
             </tr>
        <tr>
            <td valign=top width=10%  bgcolor=#D6D6D6 align=left>Verbale N.</td>
            <td valign=top width=10% >$verb_n</td>
            <td valign=top width=10%  bgcolor=#D6D6D6 align=left>Ispettore</td>
           <td valign=top width=10% >$opve</td>

        </tr>
        <tr>
            <td valign=top align=left bgcolor=#D6D6D6>d) Dichiarato</td>
            <td valign=top>$dichiarato</td>
             <td valign=top align=left bgcolor=#D6D6D6>e) Bollini n.</td>
            <td valign=top>$riferimento_pag_bollini</td>
            <td valign=top  align=left bgcolor=#D6D6D6 >f) Data dich.</td>
            <td valign=top>$new1_data_dimp</td>
             </tr>
        </table>
    </td>
<tr>
    <td><table border=1 width=100%>
        <tr bgcolor=#D6D6D6>
            <td valign=top align=left bgcolor=#D6D6D6>g) Ubicazione impianto</td>
            <td valign=top colspan=3>$ubicazione</td>
        </tr>
        <tr> 
            <td colspan=1 bgcolor=#D6D6D6>i) Responsabile impianto</td>
            <td colspan=3>$aimp_flag_resp_desc </td>
        </tr>
        <tr bgcolor=#D6D6D6>
            <td valign=top colspan=4 align=center>g) Proprietario/Occupante</td>
        </tr>
        <tr>
            <td valign=top colspan=1>Cognome e nome<br>Ragione sociale</td>
            <td valign=top colspan=3>$cogn_occu $nome_occu</td>
        </tr>
        <tr>
            <td valign=top colspan=1>Indirizzo</td>
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
            <td valign=top colspan=2 align=center bgcolor=#D6D6D6>h) Amministratore</td>
            <td valign=top colspan=2 align=center bgcolor=#D6D6D6>i) Terzo Responsabile/Manutentore</td>
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
            <td valign=top>Telefono</td>
            <td valign=top>$telef_ammin</td>
            <td valign=top>Telefono</td>
            <td valign=top>$telef_terz</td>
        </tr>
        <tr><td valign=top align=left bgcolor=#D6D6D6>j) Eventuale delegato</td>
            <td valign=top colspan=3>$nominativo_pres</td>
        </tr>
        </table>
    <td>
</tr>
<tr>
    <td><table border=1 width=100%>
        <tr bgcolor=#D6D6D6>
            <td colspan=4 align=center valign=top ><b>2. DESTINAZIONE</b></td>
        </tr>
        <tr bgcolor=#D6D6D6>
            <td width=25%>a) Destinazione prevalente dell'immobile</td>
            <td width=25%>b) Impianto a servizio di:</td>
            <td width=25%>c) Destinazione d'uso dell'impianto</td>
            <td width=25%>d) Combustibile</td>
        </tr>
        <tr>
            <td valign=top >$aimp_dest_uso</td>
            <td valign=top >$aimp_tipologia</td>
            <td valign=top >$gend_destinazione_uso </td>
            <td valign=top>$descr_comb</td>
        </tr>
        </table>
    </td>
</tr>
<tr>
    <td><table border=1 width=100%>
        <tr bgcolor=#D6D6D6>
            <td colspan=4 align=center valign=top ><b>3. GENERATORE</b></td>
        </tr>
        <tr>
            <td bgcolor=#D6D6D6 valign=top width=\"25%\" align=left class=form_title>Generatore</td>
            <td valign=top width=\"25%\" align=right class=form_title bgcolor=white>$gend_gen_prog_est</td>
            <td bgcolor=#D6D6D6 valign=top width=\"50%\" align=left class=form_title colspan=2>i) Dati nominali</td>
        </tr>
        <tr>
            <td bgcolor=#D6D6D6 valign=top align=left class=form_title>a) Fluido termovettore</td>
            <td valign=top  align=right class=form_title bgcolor=white>$gend_fluido_termovettore</td>
            <td bgcolor=#D6D6D6 valign=top align=left class=form_title>Potenza termica al focolare</td>
            <td valign=top align=right>(kW) $pot_focolare_nom</td>
        </tr>
        <tr>
            <td bgcolor=#D6D6D6 valign=top align=left class=form_title>b) Tipo caldaia</td>
            <td valign=top  align=right class=form_title bgcolor=white>$gend_tipo_focolare</td>
            <td bgcolor=#D6D6D6 valign=top align=left class=form_title>Potenza termica utile</td>
            <td valign=top align=right>(kW) $pot_utile_nom</td>
        </tr> 
        <tr>
            <td bgcolor=#D6D6D6 valign=top align=left class=form_title>c) Data installazione impianto</td>
            <td valign=top  align=right class=form_title bgcolor=white>$gend_data_installazione</td>
            <td bgcolor=#D6D6D6 valign=top align=left class=form_title colspan=2> Dati misurati</td>
        </tr>

        <tr>
            <td bgcolor=#D6D6D6 valign=top align=left class=form_title>d) Et&agrave; generatore</td>
            <td valign=top align=right class=form_title bgcolor=white>$gend_eta_gend</td>
            <td bgcolor=#D6D6D6 valign=top align=left class=form_title>Portata di combustibile</td>
            <td valign=top align=right>(m<sup>3</sup>/h)/(kg/h) $mis_port_combust</td>
  
        <tr>
            <td bgcolor=#D6D6D6 valign=top align=left class=form_title>e) Costruttore generatore</td>
            <td valign=top align=right class=form_title bgcolor=white>$gend_descr_cost</td>  
            <td bgcolor=#D6D6D6 valign=top align=left class=form_title>Potenza termica al focolare</td>
            <td valign=top align=right>(kW) $mis_pot_focolare</td>
        </tr> 
        <tr>
            <td bgcolor=#D6D6D6 valign=top align=left class=form_title>f) Modello e matricol generatore</td>
            <td valign=top align=right class=form_title bgcolor=white>$gend_modello</td>  
            <td colspan=2 rowspan=3>&nbsp;</td>
        </tr> 
        <tr>
            <td bgcolor=#D6D6D6 valign=top align=left class=form_title>g) Locale d'installazione</td>
            <td valign=top align=right class=form_title bgcolor=white>$gend_tipologia_locale</td>  
        </tr> 
        <tr>
            <td bgcolor=#D6D6D6 valign=top align=left class=form_title>h) Classificazione DPR 660/96</td>
            <td valign=top align=right class=form_title bgcolor=white>$gend_dpr_660_96</td>  
        </tr>
        </table>
    </td>
</tr>
<tr>
    <td><table border=1 width=100%>
        <tr bgcolor=#D6D6D6>
            <td colspan=4 align=center valign=top ><b>4. VERIFICHE VISIVE</b></td>
        </tr>
	<tr bgcolor=#D6D6D6>
            <td valign=top colspan=2 align=left class=form_title><b>a) Esame visivo condotti di evacuazione e foro di prelievo</b></td>
	    <td valign=top colspan=2 align=left class=form_title><b>b) Controllo evacuazione prodotti della combustione</b></td>
        </tr>

        <tr>         
	    <td bgcolor=#D6D6D6 valign=top width=\"25%\" align=left class=form_title>Pendenza corretta dei canali da fumo</td>
            <td valign=top width=\"25%\" align=right>$pendenza</td>            
	    <td bgcolor=#D6D6D6 valign=top width=\"25%\" align=left class=form_title>L'apparecchio scarica:</td>
            <td valign=top width=\"25%\" align=right class=form_title>$gend_tipologia_emissione</td>
        </tr>
        <tr>
	    <td bgcolor=#D6D6D6 valign=top align=left class=form_title>Buono stato di conservazione condotti di evacuazione</td>
            <td valign=top align=right>$verifica_areaz</td>
             <td bgcolor=#D6D6D6 valign=top width=\"25%\" align=left class=form_title>L'apparecchio dirett.all'esterno:</td>
            <td valign=top width=\"25%\" align=right class=form_title>$scarico_dir_esterno</td>
	            </tr>
        <tr>
	    <td bgcolor=#D6D6D6 valign=top align=left class=form_title>Foro per prelievo presente e accessibile</td>
            <td valign=top align=right>$new1_foro_presente</td>
	    <td bgcolor=#D6D6D6 valign=top align=left class=form_title><b>d) Verifica visiva dello stato delle coibentazioni</b></td>
            <td valign=top align=right>$stato_coiben</td>
        </tr>
        <tr>
	    <td bgcolor=#D6D6D6 valign=top align=left class=form_title>Foro in posizione corretta</td>
            <td valign=top align=right>$new1_foro_corretto</td>
	    <td colspan=2>&nbsp;</td>
        </tr>	
        <tr>
	    <td bgcolor=#D6D6D6 valign=top align=left class=form_title>Chiusura foro corretta</td>
            <td valign=top align=right>$new1_foro_accessibile</td>
	    <td bgcolor=#D6D6D6 colspan=2 valign=top align=left class=form_title><b>e) Dispositivi</b></td>
        </tr>	
        <tr>
	    <td bgcolor=#D6D6D6 valign=top align=left class=form_title colspan=2><b>c) Esame visivo locale di installazione</b></td>
	    <td bgcolor=#D6D6D6 valign=top align=left class=form_title>Dispositivi di regolazione e controllo presenti</td>
            <td valign=top align=right>$disp_reg_cont_pre</td>
        </tr>	
        <tr>
	    <td bgcolor=#D6D6D6 valign=top align=left class=form_title>Idoneit&agrave; locale</td>
            <td valign=top align=right>$new1_conf_locale</td>
	    <td bgcolor=#D6D6D6 valign=top align=left class=form_title>Dispositivi di regolazione e controllo funzionanti</td>
            <td valign=top align=right>$disp_reg_cont_funz</td>
        </tr>	
        <tr>
	    <td bgcolor=#D6D6D6 valign=top align=left class=form_title>Adeguate dimensioni e posizione delle aperture di ventilazione</td>
            <td valign=top align=right>$verifica_areaz</td>
	    <td bgcolor=#D6D6D6 valign=top align=left class=form_title>Dispositivi di regolazione climatica presente</td>
            <td valign=top align=right>$new1_disp_regolaz</td>
        </tr>	
        <tr>
	    <td bgcolor=#D6D6D6 valign=top align=left class=form_title>Aperture di ventilazione libere da ostruzioni</td>
            <td valign=top align=right>$ventilaz_lib_ostruz</td>
	    <td bgcolor=#D6D6D6 valign=top align=left class=form_title>Dispositivi di regolazione climatica funzionante</td>
            <td valign=top align=right>$disp_reg_clim_funz</td>
        </tr>
        </table>
    </td>
</tr>
<!-- PAGE BREAK -->
<tr>
<tr><td>&nbsp;</td></tr>
<tr>
    <td><table border=1 width=100%>
        <tr bgcolor=#D6D6D6>
            <td colspan=4 align=center valign=top ><b>5. STATO DELLA DOCUMENTAZIONE</b></td>
        </tr>
        <tr> 
            <td valign=top width=40% align=left>a) Libretto di impianto</td>
            <td valign=top width=10% align=left>$pres_libr</td>
            <td valign=top width=35% align=left>b) Compilazione libretto impianto o centrale completa</td>
            <td valign=top width=15% align=left>$libr_corr</td>
        </tr>
        <tr> 
            <td valign=top align=left>c) Dichiarazione di conformit&agrave;</td>
            <td valign=top align=left>$dich_conformita</td>
            <td valign=top align=left>d) Libretto/i di uso e manutenzione presente/i</td>
            <td valign=top align=left>$libr_manut</td>
        </tr>
        </table>
    </td>
</tr>


<tr>
    <td><table border=1 width=100%>
        <tr bgcolor=#D6D6D6>
            <td colspan=6 align=center valign=top><b>6. MANUTENZIONE ED ANALISI</b></td>
        </tr>
        <tr>
            <td valign=top width=25% align=left >a) Data ultima manutenzione</td>
            <td valign=top width=25% align=left>$new1_data_ultima_manu</td>
            <td valign=top width=25% align=left >b) Data ultima analisi combustibile</td>
            <td valign=top width=25% align=left>$new1_data_ultima_anal</td>
            <td valign=top width=25% align=left >Effettuata</td>
            <td valign=top width=25% align=left>$man_effettuata</td>

        </tr>

        <tr>
            <td  align=left rowspan=2 >c) Rapporto di controllo e manutenzione</td>
            <td valign=top  align=left>Presente $new1_dimp_pres</td>
            <td valign=top align=left  colspan=4 rowspan=2>d) Note: $new1_note_manu</td>
                  </tr> 
        <tr>
            <td valign=top align=left>Con prescrizioni $new1_dimp_prescriz
            </td>
        </tr>
        </table>
    </td>
</tr>
<tr><td>&nbsp;</td></tr>
<tr>
    <td><table border=1 width=100%>
        <tr bgcolor=#D6D6D6>
            <td colspan=5 align=center valign=top><b>7. MISURA DEL RENDIMENTO DI COMBUSTIONE (UNI 10389)</b></td>
        </tr>
        <tr>
            <td align=left valign=top colspan=2 class=form_title>Strumento: $strumento_01 - Marca: $marca_01 - Modello: $modello_01 - Matricola: $matricola_01 </td>
            <td align=left valign=top colspan=3 class=form_title>Strumento: $strumento_02 - Marca: $marca_02 - Modello: $modello_02 - Matricola: $matricola_02 </td>
        </tr>
        <tr>
            <td bgcolor=#D6D6D6 valign=top align=center width=\"30%\" class=form_title>Misure</td>
            <td bgcolor=#D6D6D6 valign=top align=center width=\"17.5%\" class=form_title>Prova 1</td>
            <td bgcolor=#D6D6D6 valign=top align=center width=\"17.5%\" class=form_title>Prova 2</td>
            <td bgcolor=#D6D6D6 valign=top align=center width=\"17.5%\" class=form_title>Prova 3</td>
            <td bgcolor=#D6D6D6 valign=top align=center width=\"17.5%\" class=form_title>Media</td>
        </tr>
        <tr>
            <td bgcolor=#D6D6D6 valign=top align=left  class=form_title>Bacharach (per combustibili liquidi)</td>
            <td valign=top align=right>$indic_fumosita_1a (N.)</td>
            <td valign=top align=right>$indic_fumosita_2a (N.)</td>
            <td valign=top align=right>$indic_fumosita_3a (N.)</td>
            <td bgcolor=#D6D6D6>&nbsp;</td>
        </tr>
        <tr>
            <td bgcolor=#D6D6D6 valign=top align=left class=form_title>Temperatura fluido di mandata</td>
            <td valign=top  align=right>$temp_h2o_out_1a (&#176;C)</td>
            <td valign=top  align=right>$temp_h2o_out_2a (&#176;C)</td>
            <td valign=top  align=right>$temp_h2o_out_3a (&#176;C)</td>
            <td valign=top  align=right>$temp_h2o_out_md (&#176;C)</td>
        </tr>
        <tr>
            <td bgcolor=#D6D6D6 valign=top align=left class=form_title>Temperatura aria comburente</td>
            <td valign=top align=right>$t_aria_comb_1a (&#176;C)</td>
            <td valign=top align=right>$t_aria_comb_2a (&#176;C)</td>
            <td valign=top align=right>$t_aria_comb_3a (&#176;C)</td>
            <td valign=top align=right>$t_aria_comb_md (&#176;C)</td>
        </tr>
        <tr>
            <td bgcolor=#D6D6D6 valign=top align=left class=form_title>Temperatura fumi</td>
            <td valign=top align=right>$temp_fumi_1a (&#176;C)</td>
            <td valign=top align=right>$temp_fumi_2a (&#176;C)</td>
            <td valign=top align=right>$temp_fumi_3a (&#176;C)</td>
            <td valign=top align=right>$temp_fumi_md (&#176;C)</td>
        </tr>
        <tr>
            <td bgcolor=#D6D6D6 valign=top align=left class=form_title>CO misurato</td>
            <td valign=top align=right>$co_1a (ppm)</td>
            <td valign=top align=right>$co_2a (ppm)</td>
            <td valign=top align=right>$co_3a (ppm)</td>
            <td valign=top align=right>$co_md (ppm)</td>
        </tr>
        <tr>
            <td bgcolor=#D6D6D6 valign=top align=left class=form_title>CO<small><sub>2</sub></small></td>
            <td valign=top align=right>$co2_1a (%)</td>
            <td valign=top align=right>$co2_2a (%)</td>
            <td valign=top align=right>$co2_3a (%)</td>
            <td valign=top align=right>$co2_md (%)</td>
        </tr>
        <tr>
            <td bgcolor=#D6D6D6 valign=top align=left class=form_title>O<small><sub>2</sub></small></td>
            <td valign=top align=right>$o2_1a (%)</td>
            <td valign=top align=right>$o2_2a (%)</td>
            <td valign=top align=right>$o2_3a (%)</td>
            <td valign=top align=right>$o2_md (%)</td>
        </tr>
         <tr>
            <td bgcolor=#D6D6D6 valign=top align=left  class=form_title>Tiraggio</td>
            <td bgcolor=#D6D6D6>&nbsp;</td>
            <td bgcolor=#D6D6D6>&nbsp;</td>
            <td bgcolor=#D6D6D6>&nbsp;</td>
            <td valign=top align=right>$tiraggio (Pa)</td>
             </tr>
        <tr>
            <td bgcolor=#D6D6D6 valign=top align=left  class=form_title>E.T. per caldaie non condensanti = 0</td>
            <td bgcolor=#D6D6D6>&nbsp;</td>
            <td bgcolor=#D6D6D6>&nbsp;</td>
            <td bgcolor=#D6D6D6>&nbsp;</td>
            <td valign=top align=right>$et (%)</td>
             </tr>
        </table>
    </td>
</tr>
<tr><td>&nbsp;</td></tr>
<tr>
    <td><table border=1 width=100% cellpadding=0 cellspacing=0>
        <tr>
            <td valign=top align=center colspan=2 width=50% bgcolor=#D6D6D6><b>8. RISULTATI DELLA VERIFICA</b></td>
            <td valign=top align=center colspan=1 width=50% bgcolor=#D6D6D6><b>9. ESITO DELLA PROVA</b></td>
        </tr>
        <tr>
            <td valign=top colspan=2 align=left width=50%><b>a) Manutenzione</b></td>
            <td valign=top align=left width=50%><b>$esito_verifica</b> nei termini di legge</td>
        </tr>
        <tr>
            <td valign=top width=25% align=left>Anno in corso: $manutenzione_8a</td>
            <td valign=top width=25% align=left>Anni precedenti: $new1_manu_prec_8a</td>
            <td valign=top align=left width=50% rowspan=10>Prescrizioni<br>
            $note_verificatore</td>
        </tr>
        <tr>
            <td valign=top colspan=2 align=left ><b>b) Monossido di carbonio</b><small> nei fumi secchi e senz'aria (deve essere inferiore o uguale a 1000 ppm = 0,1%)</small></td>
        </tr>
        <tr>
            <td valign=top align=left>Valore rilevato: $new1_co_rilevato (ppm)</td>
            <td valign=bottom align=left>$co_fumi_secchi_8b</td>
        </tr> 
        <tr>
            <td valign=top colspan=2 align=left ><b>c) Indice di fumosit&agrave;</b><small> = N&#176; di Bacharach (per gasolio minore o uguale a 2; per olio combustibile minore o uguale a 6)</small> </td>
        </tr>
        <tr>
            <td valign=top align=left>Valore rilevato: $indic_fumosita_md</td>
            <td valign=bottom align=left>$indic_fumosita_8c</td>
        </tr> 
        <tr>
            <td valign=top colspan=2 align=left ><b>d) Rendimento di Combustione</b></td>
        </tr>
        <tr>
            <td valign=top align=left ><small>il valore deve essere superiore o uguale a</small></td> 
            <td valign=bottom align=left>$rend_comb_min
                                  <small>-2% rend. min.</small></td>
        </tr>
        <tr>
            <td valign=top align=left>Valore rilevato: $rend_comb_conv</td>
            <td valign=bottom align=left>Valore rilevato +2 :$rend2 % + E.T : $et%    $rend_comb_8d</td>
        </tr> 
        <tr>
            <td valign=top colspan=2 align=left ><b>P Impianto pericoloso</b> <small>vedi motivazione al punto 9</small></td>
        </tr> 
        <tr>
            <td valign=top align=left colspan=2>$new1_flag_peri_8p</td>
        </tr>
    </table>
    </td>
</tr>
<tr><td>&nbsp;</td></tr>
<tr>
    <td><table border=1 width=100%>
        <tr>
            <td colspan=2 align=center valign=top ><b>10. OSSERVAZIONI DEL VERIFICATORE</b></td>
        </tr>
        <tr>
            <td valign=top align=left width=20% ><b>a) Note:</b></td>
            <td valign=top width=80%>$note_conf</td>
        </tr>
         $lista_anom
        </table>
    </td>
</tr>
<tr><td>&nbsp;</td></tr>
<tr>
    <td><table border=1 width=100%>
        <tr>
            <td colspan=2 align=center valign=top ><b>11. DICHIARAZIONI DEL RESPONSABILE IMPIANTO</b></td>
        </tr>
        <tr>
            <td valign=top align=left width=20% ><b>Note:</b></td>
            <td valign=top width=80%>$note_resp</td>
        </tr>
        </table>
    </td>
</tr>
<tr><td>&nbsp;</td></tr>
<tr>
<tr>
    <td><table border=0 width=100%>
        <tr>
            <td valign=top aling=left width=60%>Importo controllo: Euro $costo</td>
            <td valing=top align=center width=40%><b>12.b) IL VERIFICATORE</b></td>
        </tr>
        <tr>
            <td valign=top aling=left>&nbsp;</td>
            <td valing=top align=center>$opve</td>
        </tr>
        </table>
    </td>
</tr>
<tr>
    <td><table border=0 width=100%>
        <tr>
            <td valign=top align=center width=40%><b>12.a) RESPONSABILE IMPIANTO O SUO<br>DELEGATO PER RICEVUTA</b></td>
            <td valign=top align=left width=20%>&nbsp;</td>
                   </tr>
        <tr>
            <td valign=top align=center>...................................&nbsp;</td>
            <td valign=top align=left>&nbsp;</td>
                   </tr>
        </table>
    </td>
</tr>

</table>
"
#ns_return 200 text/html "$stampa"; return
# creo file temporaneo html
# imposto la directory degli spool ed il loro nome.
set spool_dir     [iter_set_spool_dir]
set spool_dir_url [iter_set_spool_dir_url]

# imposto il nome dei file
set nome_file        "stampa rapporto di verifica"
set nome_file        [iter_temp_file_name $nome_file]
set file_html        "$spool_dir/$nome_file.html"
set file_pdf         "$spool_dir/$nome_file.pdf"
set file_pdf_url     "$spool_dir_url/$nome_file.pdf"

set   file_id  [open $file_html w]
fconfigure $file_id -encoding iso8859-1
puts  $file_id $stampa
close $file_id

# lo trasformo in PDF
iter_crea_pdf [list exec htmldoc --webpage --header ... --footer ... --quiet --bodyfont arial --fontsize 9 --left 1cm --right 1cm --top 0cm --bottom 0cm -f $file_pdf $file_html]

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
