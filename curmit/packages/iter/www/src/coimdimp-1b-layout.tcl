ad_page_contract {
    Stampa modello RCEE impianto
    
    @author Giulio Laurenzi
    @creation-date 13/04/2004

    @cvs-id coimdimp-layout.tcl

    USER  DATA       MODIFICHE
    ===== ========== =========================================================================
    sim03 23/11/2016 Per Reggio Calabria aggiungo un secondo logo nella stampa

    sim02 17/10/2016 In caso di bollino virtuale visualizzo il prezzo.

    sim01 21/06/2016 Aggiunta del logo alla stampa utilizzando i parametri stampe_logo_nome
    sim01            e stampe_logo_in_tutte_le_stampe.

} {
    {cod_dimp             ""}
    {last_cod_dimp        ""}
    {funzione            "V"}
    {caller          "index"}
    {nome_funz            ""}
    {nome_funz_caller     ""}
    {extra_par            ""}
    {cod_impianto         ""}
    {url_aimp             ""} 
    {url_list_aimp        ""}
    {cod_manutentore_old  ""}
    {cod_responsabile_old ""}
    {cognome_manu_old     ""}
    {nome_manu_old        ""}
    {cognome_resp_old     ""}
    {nome_resp_old        ""}
    {flag_ins             ""}
} -properties {
    page_title:onevalue
    context_bar:onevalue
    form_name:onevalue
}

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

set spool_dir     [iter_set_spool_dir]
set spool_dir_url [iter_set_spool_dir_url]

set link_tab      [iter_links_form $cod_impianto $nome_funz_caller $url_list_aimp $url_aimp]
set dett_tab      [iter_tab_form $cod_impianto]
set logo_dir      [iter_set_logo_dir]

# controllo il parametro di "propagazione" per la navigation bar
if {[string is space $nome_funz_caller]} {
    set nome_funz_caller $nome_funz
}

# Personalizzo la pagina
set link_list_script {[export_url_vars last_cod_dimp caller nome_funz_caller nome_funz cod_impianto  url_list_aimp url_aimp]&[iter_set_url_vars $extra_par]}
set link_list        [subst $link_list_script]
set page_title       "Stampa RCEE"

set context_bar  [iter_context_bar -nome_funz $nome_funz_caller]

#set data_contr $data_controllo

# Ricerca i parametri della testata
if {[db_0or1row sel_cod_gend ""] == 0} {
    set cod_gendd 0
}
iter_get_coimtgen
set flag_viario $coimtgen(flag_viario)

if {$flag_viario == "T"} {
    set sel_dimp "sel_dimp_si_vie"
} else {
    set sel_dimp "sel_dimp_no_vie"
}

if {[db_0or1row $sel_dimp ""] == 0} {
    # codice non trovato
    iter_return_complaint  "Dati Impianto non trovati</li>"
    return
}

# dati impianto
if {[db_0or1row sel_aimp ""] == 0} {
    # codice non trovato
    #   iter_return_complaint  "Impianto non trovato"
    #   return
    set modello          ""
    set descrizione      ""
    set tipo_gen_foco    ""
    set tiraggio         ""
}

switch $flag_resp {
    "P" {set check_prop "<img src=$logo_dir/check-in.gif>"
	set check_occu "<img src=$logo_dir/check-out.gif>"
	set check_terz "<img src=$logo_dir/check-out.gif>"
	set check_ammi "<img src=$logo_dir/check-out.gif>"
	set check_inst "<img src=$logo_dir/check-out.gif>"
    }
    "O" {set check_prop "<img src=$logo_dir/check-out.gif>"
	set check_occu "<img src=$logo_dir/check-in.gif>"
	set check_terz "<img src=$logo_dir/check-out.gif>"
	set check_ammi "<img src=$logo_dir/check-out.gif>"
	set check_inst "<img src=$logo_dir/check-out.gif>"
    }
    "T" {set check_prop "<img src=$logo_dir/check-out.gif>"
	set check_occu "<img src=$logo_dir/check-out.gif>"
	set check_terz "<img src=$logo_dir/check-in.gif>"
	set check_ammi "<img src=$logo_dir/check-out.gif>"
	set check_inst "<img src=$logo_dir/check-out.gif>"
    }
    "A" {set check_prop "<img src=$logo_dir/check-out.gif>"
	set check_occu "<img src=$logo_dir/check-out.gif>"
	set check_terz "<img src=$logo_dir/check-out.gif>"
	set check_ammi "<img src=$logo_dir/check-in.gif>"
	set check_inst "<img src=$logo_dir/check-out.gif>"
    }
    "I" {set check_prop "<img src=$logo_dir/check-out.gif>"
	set check_occu "<img src=$logo_dir/check-out.gif>"
	set check_terz "<img src=$logo_dir/check-out.gif>"
	set check_ammi "<img src=$logo_dir/check-out.gif>"
	set check_inst "<img src=$logo_dir/check-in.gif>"
    }
}

switch $tipo_gen_foco {
    "A" {set des_tipo_foc "Aperto"
	set tipo_gen_foco "B"}
    "C" {set des_tipo_foc "Chiuso"}
    default {set des_tipo_foc "&nbsp;"}
}

switch $tiraggio {
    "F" {set des_tiraggio "Forzato"}
    "N" {set des_tiraggio "Naturale"}
    default {set des_tiraggio "&nbsp;"}
}

set stampa "<table>"
set root [ns_info pageroot]
# Titolo della stampa
iter_get_coimdesc
set ente              $coimdesc(nome_ente)
set ufficio           $coimdesc(tipo_ufficio)
set indirizzo_ufficio $coimdesc(indirizzo)
set telefono_ufficio  $coimdesc(telefono)
set assessorato       $coimdesc(assessorato)

# combustibile
if {[db_0or1row sel_comb ""] == 0} {
    # codice non trovato
    #   iter_return_complaint  "Combustibile non trovato"
    #   return
    set descr_comb ""
}


if {$flag_co_perc == "t"} {
    set misura_co "(%)"
} else {
    set misura_co "(ppm)"
}

if {[db_0or1row sel_manu ""] == 1} {
    set manuten "$nome $cognome"
    set indir_man "$indirizzo $localita $provincia $telefono" 
} else {
    # codice non trovato
    set manuten "" 
    set indir_man ""
}

if {[db_0or1row sel_opma ""] == 1} {
    set operatore "$nome_op $cognome_op"
} else {
    # codice non trovato
    set operatore "" 
}

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

    set logo_dx "";#sim03
    if {$coimtgen(ente) eq "PRC"} {;#sim03 if e suo contenuto
	
	set master_logo_dx_nome [parameter::get_from_package_key -package_key iter -parameter master_logo_dx_nome]
	set logo_dx "<img src=$logo_dir/$master_logo_dx_nome $height_logo align=right>"
	
    }
} else {
    set logo_dx "";#sim03
    set logo ""
}

set testata2 "
<table width=100%>
  <tr>
    <td width=100% align=center>"

if {$stampe_logo_in_tutte_le_stampe eq "1" && $stampe_logo_nome ne ""} {#sim01: aggiunta if e suo contenuto
    append testata2 "
      <table width=100%>
        <tr>
          <td width=20%>$logo</td>
          <td width=60% align=center>"
}

append testata2 "
            <table>
              <tr><td align=center><b><small>$ente</small></b></td></tr>
              <tr><td align=center><b><small>$ufficio</small></b></td></tr>
              <tr><td align=center><small>$assessorato</small></td></tr>
              <tr><td align=center><small>$indirizzo_ufficio</small></td></tr>
              <tr><td align=center><small>$telefono_ufficio</small></td></tr>
            </table>"

if {$stampe_logo_in_tutte_le_stampe eq "1" && $stampe_logo_nome ne ""} {#sim01: aggiunta if e suo contenuto
    #sim03 aggiunto logo_dx
    append testata2 "
          </td>
          <td width=20%>$logo_dx</td>
        </tr>
      </table>"
}

append testata2 "
      <table width=100% border>
        <tr>
          <td colspan=2 align=center>RAPPORTO DI CONTROLLO DI EFFICIENZA ENERGETICA TIPO 1 (GRUPPI TERMICI)
        </tr>
      </table>"


set testata ""

if {$tipologia_costo eq "BO"} {
    set bollino_applicato "Bollino applicato: $riferimento_pag"
} else {
    set bollino_applicato ""
}

if {$tipologia_costo eq "LM"} {;#sim02 if e else e loro contenuto
    set costo_bollino "Bollino virtuale: $costo_pretty euro"
} else {
    set costo_bollino ""
}

append stampa "
               <tr>
               <td><b><small>A. IDENTIFICAZIONE DELL'IMPIANTO</small></b></td>
               <td><small>Catasto impianti/codice $cod_impianto_est</small></td>
               <td><small>$bollino_applicato</small></td>
               </tr>

               <table align=center width=100% cellpadding=2 cellspacing=0>
               <tr>
                  <td width=33%><small>Rapporto di controllo N&deg; $num_autocert</small></td>
                  <td width=33%><small><b>Data $data_controllo</b></small></td>
                  <td width=34%><small>Protocollo $n_prot</small></td>
               </tr>
               <tr>
                  <td colspan=3><small>Impianto termico sito nel comune di: $comune_ubic $prov_ubic 
                  <br>in via/piazza: $indirizzo_ubic Cap: $cap_ubic
                  <br>Responsabile : $cognome_resp $nome_resp $indirizzo_resp  tel.: $telefono_resp
                  <br>Indirizzo $indirizzo_resp $numero_resp $cap_resp $comune_resp $provincia_resp
                  <br>in qualit&agrave; di $check_prop Proprietario $check_occu Occupante 
                      $check_terz Terzo responsabile $check_ammi Amministratore $check_inst Intestatario
                  </small>
               </tr>
               </table>

<tr><td><table width=100% border=0>
    <tr>
        <td><b><small>Impresa di Manutenzione :</small></b></td>
        <td><small>$manuten  -  $indir_man</small></td>
    </tr>
 
</table>

           </table><table align=center width=100% border=1  cellpadding=2 cellspacing=\"0\">
              <tr><td colspan=2 size=3><small><small><b>B. DOCUMENTAZIONE TECNICA DI CORREDO</b></small></small></td>
                 </tr>
                 <tr>
                  <td size=3 width=48%><small><small>Dichiarazione di conformit&agrave; dell'impianto</small></small></td>
                  <td width=2%><small><small>[iter_edit_flag_mh $conformita]</small></small></td>
                  <td size=3 width=48%><small><small>Istruzioni uso e manutenzione dell'impianto presenti</small></small></td>
                  <td width=2%><small><small>[iter_edit_flag_mh $libretto_manutenz]</small></small></td>
                 </tr>                  
                 <tr>
                  <td><small><small>Libretto d'impianto</small></small></td>
                  <td><small><small>[iter_edit_flag_mh $lib_impianto]</small></small></td>
                  <td><small><small>SCIA o CPI antincendio</small></small></td>
                  <td><small><small>[iter_edit_flag_mh $doc_prev_incendi]</small></small></td>
                 </tr>
                 <tr>
                   <td><small><small>Libretto compilato in tutte le sue parti</small></small></td>
                   <td><small><small>[iter_edit_flag_mh $rct_lib_uso_man_comp]</small></small></td>
                   <td><small><small>Documentazione art. 284 del Dlgs 152/06 presente</small></small></td>
                   <td><small><small>[iter_edit_flag_mh $dich_152_presente]</small></small></td>
                 </tr>
                 <tr>
                   <td><small><small>Libretti uso/manutenzione generatore presenti</small></small></td>
                   <td><small><small>[iter_edit_flag_mh $lib_uso_man]</small></small></td>
                   <td><small><small>Pratica INAIL (ex ISPESL)</small></small></td>
                   <td><small><small>[iter_edit_flag_mh $doc_ispesl]</small></small></td>
              </tr>
              <tr><td colspan=2 size=2><small><small><b>C.TRATTAMENTO DELL'ACQUA</b></small></small></td>
               </tr>
                  <tr>
                  <td><small><small>Durezza °fr</small></small></td>
                  <td><small><small>$rct_dur_acqua</small></small></small></td>
                  <td><small><small>Trattamento in riscaldamento -Non(R)ichiesto-(A)ssente-(F)iltrazione-A(D)dolcimento-Cond.(C)himico</small></small></td>
                  <td><small><small>$rct_tratt_in_risc</small></small></td>
                  </tr>
                  <tr><td><small><small>Trattamento in ACS  -Non(R)ichiesto-(A)ssente-(F)iltrazione-A(D)dolcimento-Cond.(C)himico</small></small></td>
                  <td><small><small>$rct_tratt_in_acs</small></small></td>

              </tr>
              <tr><td colspan=2 size=2><small><small><b>D. CONTROLLO DELL'IMPIANTO</b></small></small></td>
                  </tr>
                  <tr>
                  <td><small><small>Per Installazione interna : locale idoneo:</small></small></td>
                  <td><small><small>[iter_edit_flag_mh $idoneita_locale]</small></small></td>
                  <td><small><small>Canale da fumo o prodotti di scarico idonei (es.vis.)</small></small></td>
                  <td><small><small>[iter_edit_flag_mh $rct_canale_fumo_idoneo]</small></small></td>
              </tr>
              <tr><td><small><small>Per installazione esterna generatori idonei</small></small></td>
                  <td><small><small>[iter_edit_flag_mh $rct_install_interna]</small></small></td>
                  <td><small><small>Sistema di regolazione temp.ambiente funzionante</small></small></td>
                  <td><small><small>[iter_edit_flag_mh $rct_sistema_reg_temp_amb]</small></small></td>
              </tr>
              <tr><td><small><small>Aperture di ventilazione/areazione libere da ostruzione</small></small></td>
                  <td><small><small>[iter_edit_flag_mh $ap_vent_ostruz]</small></small></td>
                  <td><small><small>Pulizia camino effettuata secondo UNI 10847</small></small></td>
                  <td><small><small>[iter_edit_flag_mh $lg_flag_puliz_camino]</small></small></td>
              </tr>
              <tr><td><small><small>Adeguate dimensioni apertura ventilazione/aerazione</small></small></td>
                  <td><small><small>[iter_edit_flag_mh $ap_ventilaz]</small></small></td>
                  <td><small><small>Presente separazione idraulica tra generatori (ove richiesta)</small></small></td>
                  <td><small><small>[iter_edit_flag_mh $lg_flag_sep_gen]</small></small></td>
              </tr>
              <tr><td><small><small>Idoneità stoccaggio/deposito combustibile solido</small></small></td>
                  <td><small><small>[iter_edit_flag_mh $lg_flag_dep_combust_solido]</small></small></td>
                  <td><small><small>Organi soggetti a sollecitazione termiche integri</small></small></td>
                  <td><small><small>[iter_edit_flag_mh $lg_flag_sollecit_termiche]</small></small></td>
              </tr>
              </table>
              <table>
              <tr><td colspan=2 size=2><small><small><b>E. CONTROLLO E VERIFICA ENERGETICA DEL GRUPPO TERMICO</b></small></small></td>
                 <tr>
        <td valign=top align=left class=form_title><small>Costruttore: $descr_cost</small></td>
        <td valign=top align=left class=form_title><small>Modello: $modello</small></td>
        <td valign=top align=left class=form_title><small>Matricola: $matricola</small></td>
    </tr>
    <tr>
        <td valign=top align=left class=form_title><small>Pot. term. nom. utile (kW) $potenza</small></td>
        <td valign=top align=left class=form_title><small>Pot. term. nom al focolare (kW) $pot_focolare_nom</small></td>
        <td valign=top align=left class=form_title><small>Anno di costruzione: $data_costruz_gen</small></td>
    </tr>
    <tr>
         <td valign=top align=left class=form_title><small>Marcatura efficienza energetica:(DPR 660/96): $marc_effic_energ</small></td>
         <td valign=top align=left class=form_title><small>Uso: $destinazione</small></td>
        <td valign=top align=left class=form_title><small>Data installazione: $data_installaz</small></td>       
    </tr>
    <tr>
        <td valign=top align=left class=form_title><small>Caldaia tipo: $tipo_gen_foco</small></td>
        <td ><small>Combustibile: $descr_comb</small></td>
        <td valign=top align=left class=form_title><small>Volimetria riscaldata (m<sup><small>3</small></sup>): $volimetria_risc</small></td>
    </tr>
   <tr>
        <td valign=top align=left class=form_title><small>Consumi ultima stagione di riscaldamento (m<sup><small>3</small></sup>/kg): $consumo_annuo</small></td>
         <td valign=top align=left  class=form_title><small>Tiraggio: $tiraggio</small></td>
         <td valign=top align=left  class=form_title><small>Locale installazione: $locale</small></td>
    </tr>        
    <tr>
        <td valign=top align=left class=form_title><small>Tipologia: $tipologia</small></td>
        <td valign=top align=left class=form_title colspan=2><small>Note altro: $note_tplg_altro</small></td>
    </tr>
                            
              <tr><td><small><small>Condenzazione</small></small></td>
                  <td><small><small>$lg_condensazione</small></small></td>
                  <td><small><small>Vaso di espansione</small></small></td>
                  <td><small><small>$lg_vaso_espa</small></small></td>
              </tr>
              <tr><td><small><small>Marcatura CE apparecchio</small></small></td>
                  <td><small><small>$lg_marcatura_ce</small></small></td>
                  <td><small><small>Placca camino</small></small></td>
                  <td><small><small>$lg_placca_cam</small></small></td>
              </tr>
              <tr><td><small><small>Caricamento combustibile</small></small></td>
                  <td><small><small>$lg_caric_comb</small></small></td>
                  <td><small><small>Modalità evacuazione fumi</small></small></td>
                  <td><small><small>$lg_mod_evac_fumi</small></small></td>
              </tr>
              <tr><td><small><small>Aria comburente</small></small></td>
                  <td><small><small>$lg_aria_comburente</small></small></td>
              </tr>
              <tr><td><small><small>Dispositivi di comando e regolazione funzionanti</small></small></td>
                  <td><small><small>[iter_edit_flag_mh $disp_comando]</small></small></td>
                  <td><small><small>Dispositivi di sicurezza non manomessi o cortocircuitati</small></small></td>
                  <td><small><small>[iter_edit_flag_mh $disp_sic_manom]</small></small></td>
              </tr>
              <tr>
                  <td><small><small>Valvola di sicurezza alla sovrapressione a scarico libero</small></small></td>
                  <td><small><small>[iter_edit_flag_mh $rct_valv_sicurezza]</small></small></td>
                  <td><small><small>Controllato e pulito lo scambiatore lato fumi</small></small></td>
                  <td><small><small>[iter_edit_flag_mh $rct_scambiatore_lato_fumi]</small></small></td>
              </tr>
              <tr><td><small><small>Presenza riflusso prodotti combustione</small></small></td>
                  <td><small><small>[iter_edit_flag_mh $rct_riflussi_comb]</small></small></td>
                  <td><small><small>Risultati controllo secondo UNI 10389-1, conformi alla legge</small></small></td>
                  <td><small><small>[iter_edit_flag_mh $rct_uni_10389]</small></small></td>
              </tr>
              <tr><td><small><small>Depressione del canale da fumo (Pa) </small></small></td>
                  <td><small><small>$tiraggio_fumi</small></small></td>
                </table>
           <!--      <table align=center width=100% border=1 cellpadding=3 cellspacing=\"0\">
              <tr><td><small>Temperatura fumi(&deg;C)</small></td>
                  <td><small>Temperatura aria comb.(&deg;C)</small></td>
                  <td><small>O<sub><small>2</small></sub>(%)</small></td>
                  <td><small>CO<sub><small>2</small></sub>(%)</small></td>
                  <td><small>Bacharach(n&deg;)</small></td>
                  <td><small>CO $misura_co</small></td>
                  <td><small>Rend.to Combustione</small></td>
                  <td><small>Rend.to Min.legge</small></td>
                  <td><small>Modulo termico</small></td>
              </tr>
              <tr><td align=right><small>$temp_fumi</small></td>
                  <td align=right><small>$temp_ambi</small></td>
                  <td align=right><small>$o2</small></td>
                  <td align=right><small>$co2</small></td>
                  <td align=right><small>$bacharach</small></td>
                  <td align=right><small>$co</small></td>
                  <td align=right><small>$rend_combust</small></td>
                  <td align=right><small>$rct_rend_min_legge</small></td>
                  <td align=right><small>$rct_modulo_termico</small></td>
              </tr>
              </table>  -->
              <table>
                   <tr><td colspan=2 size=2><small><small><b>F. CHECK LIST</b></small></small></td> </tr>
                   <tr><td  valign=top align=left class=form_title><small><small>Elenco di possibili interventi, dei quali va valuta la convenienza economica, che qualora applicabili all'impianto, potrebbero comportare un miglioramento della prestazione energetica</b></small></small></td></tr>
                   <tr><td><small><small>$rct_check_list_1  -Adozione di valvole termostatiche</small></small></td></tr>
                   <tr><td><small><small>$rct_check_list_2   -L'isolamento della rete di distribuzione nei locali non riscaldati</small></small></td></tr>
                   <tr><td><small><small>$rct_check_list_3   -Introduzione di un trattamento dell'acqua sanitaria e per riscaldamento ove assente</small></small></td></tr>
                   <tr><td><small><small>$rct_check_list_4   -La sostituzione di un sistema on/off con un sistema programmabile su più livelli di temperatura</small></small></td></tr>
              </table>

              <table width=100% border=0 cellpadding=2 cellspacing=0>
              <tr>
                <td><small><b>G.OSSERVAZIONI</b>: $osservazioni</small>
                </td>
              </tr>
              <tr>
                <td><small><b>H.RACCOMANDAZIONI</b> (in attesa di questi interventi l'impianto pu&ograve; essere messo in funzione): $raccomandazioni</small>
                </td>
              </tr>
              <tr>
                <td><small><b>I.PRESCRIZIONI</b> (in attesa di questi interventi l'impianto non pu&ograve; essere messo in funzione): $prescrizioni"

set lista_anom ""
db_foreach sel_anom "" {
    lappend lista_anom $cod_tanom
}

if {![string equal $lista_anom ""]} {
    append stampa " anomalie presenti:"
    foreach anom $lista_anom {
	append stampa " $anom "
    }
}


append stampa "</b></small>
               </td>
               </tr>
               </table>"

if {[string is space $firma_manut]} {
    set firma_manut $manuten
}

if {[string is space $firma_resp]} {
    set firma_resp "$cognome_resp $nome_resp"
}

append stampa "</table></td></tr>
          <tr>
            <td align=center>
              <table width=100% border=1><tr>
                <tr>
                  <td  valign=top align=left class=form_title><small>il tecnico dichiara,in riferimento ai punti A,B,C,D,E (sopra menzionati)  che l'apparecchio pu&ograve; essere messo in servizio ed usato normalmente ai fini dell'efficenza energetica senza compromettere la sicurezza delle persone, degli animali e dei beni.<b>L'impianto pu&ograve; funzionare</b> [iter_edit_flag_mh $flag_status]</small></td>
                </tr>
              </table>
            </td>
          </tr>
          <tr><td align=center><table width=100% ><tr>
            <td  valign=top align=left class=form_title><small><small>Il tecnico declina altresi ogni responsabilit&agrave; per sinistri a persone, animali o cose derivanti da manomissione dell'impianto o dell'apparecchio da parte di terzi, ovvero da carenze di manutenzione successiva. In presenza di carenza riscontrate e non eliminate, il responsabile dell'impianto si impegna, entro breve tempo a provvedere alla loro risoluzione dandone notizia all'operatore incaricato. Si raccomanda un intervento manutentivo entro il $data_prox_manut</small></small></td>
          </tr>
          </table>
        </td>
      </tr>
             <table width=100% border=0 cellpadding=2 cellspacing=0>
               <tr>
                    <td colspan=2><small><b>TECNICO CHE HA EFFETTUATO IL CONTROLLO:</b></small></td>
               </tr>
               <tr>
                  <td colspan=2><small>Nome e cognome: $operatore </small></td>
               </tr>
               <tr>
                  <td colspan=2><small>Indirizzo $indir_man<small>
               </tr>
               <tr>
                  <td><small><u>Orario di arrivo presso l'impianto $ora_inizio</u></small></td>
                  <td><small><u>Orario di partenza dall'impianto $ora_fine</u></small></td>
               </tr>
               <tr>
                  <td colspan=2><small>$costo_bollino<small></td><!-- sim02 -->
               </tr>
               <tr>
                  <td width=50%><small>Firma manutentore</small></td>
                  <td width=50%><small>Firma responsabile</small></td>
               </tr>
               <tr>
                  <td><small>$firma_manut</small></td>
                  <td><small>$firma_resp</small></td>
               </tr>
             </table>"


# creo file temporaneo html
set stampa1 $testata
append stampa1 $stampa
set stampa2 $testata2
append stampa2 $stampa


# imposto il nome dei file
set nome_file        "stampa RCEE"
set nome_file        [iter_temp_file_name $nome_file]
set file_html        "$spool_dir/$nome_file.html"
set file_pdf         "$spool_dir/$nome_file.pdf"
set file_pdf_url     "$spool_dir_url/$nome_file.pdf"

set   file_id  [open $file_html w]
fconfigure $file_id -encoding iso8859-1
puts  $file_id $stampa2
close $file_id

# lo trasformo in PDF
iter_crea_pdf [list exec htmldoc --webpage --header ... --footer ... --quiet --bodyfont arial --left 1cm --right 1cm --top 0cm --bottom 0cm -f $file_pdf $file_html]

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
		|| $flag_docu == "N"
	    } {
		db_1row sel_docu_next ""
		set tipo_documento "MH"
		db_dml dml_sql_docu [db_map ins_docu]
		db_dml dml_sql_dimp [db_map upd_dimp]
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
