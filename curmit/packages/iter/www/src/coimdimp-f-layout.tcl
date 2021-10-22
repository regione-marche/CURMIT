ad_page_contract {
    Stampa modello H impianto
    
    @author Giulio Laurenzi
    @creation-date 13/04/2004

    @cvs-id coimdimp-layout.tcl

    @param codice_dimp                 codice dimp
    
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
#set logo_dir "/www/logo"

# controllo il parametro di "propagazione" per la navigation bar
if {[string is space $nome_funz_caller]} {
    set nome_funz_caller $nome_funz
}

# Personalizzo la pagina
set link_list_script {[export_url_vars last_cod_dimp caller nome_funz_caller nome_funz cod_impianto  url_list_aimp url_aimp]&[iter_set_url_vars $extra_par]}
set link_list        [subst $link_list_script]
set page_title       "Stampa Modello H"

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

switch $flag_resp {
    "P" {set check_prop "<img src=$logo_dir/check-in.gif>"
         set check_occu "<img src=$logo_dir/check-out.gif>"
         set check_terz "<img src=$logo_dir/check-out.gif>"
         set check_ammi "<img src=$logo_dir/check-out.gif>"
    }
    "O" {set check_prop "<img src=$logo_dir/check-out.gif>"
         set check_occu "<img src=$logo_dir/check-in.gif>"
         set check_terz "<img src=$logo_dir/check-out.gif>"
         set check_ammi "<img src=$logo_dir/check-out.gif>"
    }
    "T" {set check_prop "<img src=$logo_dir/check-out.gif>"
         set check_occu "<img src=$logo_dir/check-out.gif>"
         set check_terz "<img src=$logo_dir/check-in.gif>"
         set check_ammi "<img src=$logo_dir/check-out.gif>"
    }
    "A" {set check_prop "<img src=$logo_dir/check-out.gif>"
         set check_occu "<img src=$logo_dir/check-out.gif>"
         set check_terz "<img src=$logo_dir/check-out.gif>"
         set check_ammi "<img src=$logo_dir/check-in.gif>"
    }
}

set stp_pag_gend {
append stampa "

<!-- PAGE BREAK -->

<tr><td><table width=100%>
    <tr>
        <td width=50%><small>Data $data_controllo</small></td>
        <td width=50%><small>Rapporto di controllo N&deg; $num_autocert</small></td>
    </tr>
</table>
<tr><td>&nbsp</td></tr>
<tr><td width=100%><table width=100%>
    <tr>
        <td valign=top align=left class=form_title colspan=6><b><small>D. DATI GENERALI DEI GENERATORI</small></b></td>
    </tr>
    <tr>
        <td valign=top align=left class=form_title colspan=6><b><small>Generatore di calore</small></b></td>
    </tr>
    <tr>
        <td valign=top align=right class=form_title><small>Costruttore</small></td>
        <td valign=top><small>$descr_cost</small></td>
        <td valign=top align=right class=form_title><small>Modello</small></td>
        <td valign=top><small>$modello</small></td>
        <td valign=top align=right class=form_title><small>Matricola</small></td>
        <td valign=top><small>$matricola</small></td>
    </tr>
    <tr>
         <td valign=top align=right class=form_title><small>Anno di costruzione</small></td>
         <td valign=top><small>$data_costruz_gen</small></td>
         <td valign=top align=right class=form_title><small>Tipologia</small></td>
         <td valign=top><small>$tipo_gen_foco</small></td>
         <td valign=top align=right class=form_title><small>Marcatura efficienza energetica:(DPR 660/96)</small></td>
         <td valign=top><small>$marc_effic_energ</small></td>
    </tr>
    <tr>
        <td valign=top align=right class=form_title><small>Pot. term. nom. utile (kW)</small></td>
        <td valign=top><small>$potenza</small></td>
        <td valign=top align=right class=form_title><small>Pot. term. nom al focolare (kW)</small></td>
        <td valign=top><small>$pot_focolare_nom</small></td>
        <td valign=top align=right class=form_title><small>Fluido termovettore</small></td>
        <td valign=top><small>$mod_funz</small></td>       
    </tr>
    <tr>
        <td valign=top align=left call=form_title colspan=6><b><small>Bruciatore abbinato</small></b></td>
    </tr>
    <tr>
        <td valign=top align=right class=form_title><small>Costruttore</small></td>
        <td valign=top><small>$costruttore_bruc</small></td>
        <td valign=top align=right class=form_title><small>Modello</small></td>
        <td valign=top><small>$modello_bruc</small></td>
        <td valign=top align=right class=form_title><small>Matricola</small></td>
        <td valign=top><small>$matricola_bruc</small></td>
    </tr>
    <tr>
         <td valign=top align=right class=form_title><small>Anno di costruzione</small></td>
         <td valign=top><small>$data_costruz_bruc</small></td>
         <td valign=top align=right class=form_title><small>Tipologia</small></td>
         <td valign=top><small>$tipo_bruciatore</small></td>
         <td valign=top align=right class=form_title><small>Campo di funzionamento (kW)</small></td>
         <td valign=top><small>da $campo_funzion_min a $campo_funzion_max</small></td>
    </tr>
    <tr>
        <td valign=top align=right class=form_title colspan=2><b><small>Data installazione del generatore di calore</small></b></td>
        <td valign=top colspan=4><small>$data_installaz</small></td>       
    </tr>
</table></td></tr>
<tr><td>&nbsp</td></tr>
<tr><td><table width=100%>
    <tr>
        <td valign=top align=left class=form_title colspan=4><b><small>E. ESAME VISIVO E CONTROLLO DEI GENERATORI</small></b></td>
    </tr>
    <tr>
        <td valign=top align=left class=form_title colspan=4><small>Bruciatore</small></td>
    </tr>
    <tr>
        <td valign=top align=right class=form_title width=40%><small>Ugelli puliti</small></td>
        <td valign=top width=10%><small>[iter_edit_flag_mh $pulizia_ugelli]</small> </td>
        <td valign=top align=right class=form_title width=40%><small>Funzionamento corretto</small></td>
        <td valign=top width=10%><small>[iter_edit_flag_mh $funz_corr_bruc]</small></td>
    </tr>
    <tr>
        <td valign=top align=left class=form_title colspan=4><small>Generatore di calore</small></td>
    </tr>
    <tr>
        <td valign=top align=right class=form_title><small>Scambiatore lato fumi</small></td>
        <td valign=top><small>[iter_edit_flag_mh $scambiatore]</small></td>
        <td valign=top align=right class=form_title><small>Accensione e funzionamento regolari</small></td>
        <td valign=top><small>[iter_edit_flag_mh $accens_reg]</small></td>
    </tr>
    <tr>
        <td valign=top align=right class=form_title><small>Dispositivi di comando funzionanti correttamente</small></td>
        <td valign=top><small>[iter_edit_flag_mh $disp_comando]</small></td>
        <td valign=top align=right class=form_title><small>Assenza di perdite e ossidazioni dai/sui raccordi</small></td>
        <td valign=top><small>[iter_edit_flag_mh $ass_perdite]</small></td>
    </tr>
    <tr>
        <td valign=top align=right class=form_title><small>Dispositivi di sicurezza non manomessi e/o cortocircuitati</small></td>
        <td valign=top><small>[iter_edit_flag_mh $disp_sic_manom]</small></td>
        <td valign=top align=right class=form_title><small>Vaso di espansione carico</small></td>
        <td valign=top><small>[iter_edit_flag_mh $vaso_esp]</small></td>
    </tr>
    <tr>
        <td valign=top align=right class=form_title cospan=2><small>Organi soggetti a sollecitazioni termiche integri e senza segni di usura e/o deformazione</small></td>
        <td valign=top colspan=2><small>[iter_edit_flag_mh $organi_integri]</small></td>
    </tr>
</table></td></tr>

<tr><td>&nbsp;</td></tr>
<p></p>
<tr><td>&nbsp</td></tr>
    <tr>
       <td valign=top align=left class_form_title><small><b>F. CONTROLLO DEL RENDIMENTO DI COMBUSTIONE</b> $cont_rend</small></td>
   </tr>
<tr><td  width=100%><table cellspacing=0 cellpadding=0 width=100% border=1>
   <tr>
    <td valign=top align=center class=form_title><small>Temp. fumi (&deg;C)</small></td>
    <td valign=top align=center class=form_title><small>Temp. aria<br> comb. (&deg;C)</small></td>
    <td valign=top align=center class=form_title><small>O<sub><small>2</small></sub>(%)</small></td>
    <td valign=top align=center class=form_title><small>CO<sub><small>2</small></sub>(%)</small></td>
    <td valign=top align=center class=form_title><small>Bacharach (n.)</small></td>
    <td valign=top align=center class=form_title><small>CO calc. $misura_co</small></td>
    <td valign=top align=center class=form_title><small>Rend.to combustione<br>a pot. nominale(%)</small></td>
    <td valign=top align=center class=form_title><small>Tiraggio (Pa)</small></td>
   </tr><tr>
    <td valign=top align=center><small>$temp_fumi</small></td>
    <td valign=top align=center><small>$temp_ambi</small></td>
    <td valign=top align=center><small>$o2</small></td>
    <td valign=top align=center><small>$co2</small></td>
    <td valign=top align=center><small>$bacharach</small></td>
    <td valign=top align=center><small>$co</small></td>
    <td valign=top align=center><small>$rend_combust</small></td>
    <td valign=top align=center><small>$tiraggio_fumi</small></td>
    </tr></table></td>
</tr>
<tr><td>&nbsp</td></tr>
<tr>
    <td align=center ><table width=100%>
         <tr>
           <td valign=top align=left class=form_title><b><small>Osservazioni</small></b></td>
         </tr>
         <tr>
           <td valign=top><small>$osservazioni</small></td>
         </tr>
         <tr>
             <td valign=top align=left class=form_title><small><b>Raccomandazioni</b><br> (in attesa di questi interventi l'impianto pu&ograve; essere messo in funzione)</small></td>
         </tr>
         <tr>
            <td valign=top><small>$raccomandazioni</small></td>
         </tr>
         <tr>
            <td valign=top align=left class=form_title><small><b>Prescrizioni</b><br> (in attesa di questi interventi l'impianto <b>non</b> pu&ograve; essere messo in funzione)</small></td>
         </tr>
         <tr>
            <td valign=top><small>$prescrizioni</small></td>  
         </tr>
    </tr></table></td>
</tr>
"

set lista_anom ""
db_foreach sel_anom "" {
    lappend lista_anom $cod_tanom
}

if {![string equal $lista_anom ""]} {
    append stampa "<tr><td><small> anomalie presenti:"
    foreach anom $lista_anom {
	append stampa "<br>$anom "
    }
}


append stampa "</small>
               </td>
               </tr>
               </table>"

if {[db_0or1row sel_manu ""] == 1} {
    set manuten "$nome $cognome"
    set indir_man "$indirizzo $localita $provincia $telefono" 
} else {
    # codice non trovato
    set manuten "" 
    set indir_man ""
}

if {[string is space $opmanu]} {
    set opmanu $manuten
}

if {[string is space $firma_resp]} {
    set firma_resp $nominativo_resp
}

append stampa "
<tr><td align=center><table width=100% border=1><tr>
<tr>
    <td  valign=top align=left class=form_title><small>In mancanza di prescrizione esplicite, il tecnico dichiara che l'apparecchio pu&ograve; essere messo in servizio ed usato normalmente senza compromettere la sicurezza delle persone, degli animali e dei beni.<b>Ai fini della sicurezza l'impianto pu&ograve; funzionare</b> [iter_edit_flag_mh $flag_status]</small></td>
</tr>
</table></td></tr>
<tr><td align=center><table width=100% ><tr>
    <td  valign=top align=left class=form_title><small>Il tecnico declina altresi ogni responsabilit&agrave; per sinistri a persone, animali o cose derivanti da manomissione dell'impianto o dell'apparecchio da parte di terzi, ovvero da carenze di manutenzione successiva. In presenza di carenza riscontrate e non eliminate, il responsabile dell'impianto si impegna, entro breve tempo a provvedere alla loro risoluzione dandone notizia all'operatore incaricato.</small></td>
</tr>
</table></td></tr>
               <table width=100% border=0 cellpadding=2 cellspacing=0>
               <tr>
                    <td colspan=2><small><b>TECNICO CHE HA EFFETTUATO IL CONTROLLO:</b></small></td>
               </tr>
               <tr>
                  <td colspan=2><small>Nome e cognome: $opmanu </small></td>
               </tr>
               <tr>
                  <td colspan=2><small>Indirizzo ditta: $indir_man<small>
               </tr>
               <tr>
                  <td><small><u>Orario di arrivo presso l'impianto $ora_inizio</u></small></td>
                  <td><small><u>Orario di partenza dall'impianto $ora_fine</u></small></td>
               </tr>
               <tr>
                  <td width=50%><small>Firma manutentore</small></td>
                  <td width=50%><small>Firma responsabile</small></td>
               </tr>
               <tr>
                  <td><small>$opmanu</small></td>
                  <td><small>$firma_resp</small></td>
               </tr>
               </table>"


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

switch $tipo_gen_foco {
    "A" {set des_tipo_foc "Aperto"}
    "C" {set des_tipo_foc "Chiuso"}
default {set des_tipo_foc "&nbsp;"}
}

switch $tiraggio {
    "F" {set des_tiraggio "Forzato"}
    "N" {set des_tiraggio "Naturale"}
default {set des_tiraggio "&nbsp;"}
}

switch $assenza_fughe {
    "N" {set assenza_fughe "No"}
    "P" {set assenza_fughe "Si"}
default {set assenza_fughe "&nbsp;"}
}


set stampa ""


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
    set co [expr $co / 10000.0000]
    set co [iter_edit_num $co 4]
    set misura_co "(%)"
} else {
    set misura_co "(ppm)"
    set co [iter_edit_num $co 0]
}

set testata2 "<!-- FOOTER RIGHT  \"Foglio \$PAGE(1) di \$PAGES(1)\"-->
              <table width=100% ><tr>
               <td width=100% align=center><table >
               <tr>
                  <td align=center><b>$ente</b></td>
               </tr><tr>
                   <td align=center><b>$ufficio</b></td></tr>
               </tr><tr>
                   <td align=center>$assessorato</td>
               </tr><tr>
                  <td align=center><small>$indirizzo_ufficio</small></td>
               </tr><tr>
                  <td align=center><small>$telefono_ufficio</small></td></tr></td></tr>
               </table>
 <table width=100% border>
    <tr>
        <td align=center>RAPPORTO DI CONTROLLO TECNICO (Allegato F)
        <br>PER IMPIANTO CON POTENZA TERMICA NOMINALE AL FOCOLARE >= 35 kw</td>
    </tr>
 </table>"


set testata ""



append stampa "
               <table align=center width=100% cellpadding=2 cellspacing=0>
               <tr>
                  <td width=50%><small>Data $data_controllo</small></td>
                  <td colspan=2 width=50%><small>Rapporto di controllo N&deg; $num_autocert</small></td>
               </tr>
               <tr>
                  <td><b><small>A. IDENTIFICAZIONE DELL'IMPIANTO</small></b></td>
                  <td><small>Catasto impianti/codice</small></td>
                  <td><small>$cod_impianto_est</small></td>
               </tr>
               <tr>
                  <td colspan=3><small>Impianto termico sito nel comune di: $comune_ubic $prov_ubic 
                  <br>in via/piazza: $indirizzo_ubic Cap: $cap_ubic
                  <br>Responsabile : $cognome_resp $nome_resp $indirizzo_resp  tel.: $telefono_resp
                  <br>Indirizzo $indirizzo_resp $numero_resp $cap_resp $comune_resp $provincia_resp
<!--  : $cognome_util $nome_util $indirizzo_util $numero_util $cap_util $comune_util $provincia_util</small></td> -->
                  <br>in qualit&agrave; di $check_prop Proprietario $check_occu Occupante 
                      $check_terz Terzo responsabile $check_ammi Amministratore
                  </small>
               </tr>
               </table>

<tr><td>&nbsp</td></tr>
<br />
<br />
<tr><td><table width=100%>
    <tr>
        <td valign=top align=right class=form_title><small>Combustibile</small></td>
        <td valign=top><small><small>$descr_comb</small></td>
        <td valign=top align=right class=form_title><small>Destinazione</small></td>
        <td valign=top><small>$destinazione</small></td>
    </tr>
    <tr>
        <td valign=top align=right class=form_title><small>Volimetria riscaldata (m<sup><small>3</small></sup>)</small></td>
        <td valign=top><small>$volimetria_risc</small></td>
        <td colspan=2>&nbsp;</td>
    </tr>
    <tr>
        <td valign=top align=right class=form_title><small>Stagione di riscaldamento</small></td>
        <td valign=top><small>$stagione_risc</small></td>
        <td valign=top align=right class=form_title><small>Consumi (m<sup><small>3</small></sup>/kg)</small></td>
        <td valign=top><small>$consumo_annuo</small></td>
    </tr>
    <tr>
        <td valign=top align=right class=form_title><small>Stagione di riscaldamento</small></td>
        <td valign=top><small>$stagione_risc2</small></td>
        <td valign=top align=right class=form_title><small>Consumi (m<sup><small>3</small></sup>/kg)</small></td>
        <td valign=top><small>$consumo_annuo2</small></td>
    </tr>
    <tr>
        <td valign=top align=left class=form_title colspan=4><b><small>B. DOCUMENTAZIONE TECNICA A CORREDO</small></b></td>
    </tr>
</tr></table></td></tr>
<tr><td><table width=100% border=1>
    <tr>
        <td valign=top align=center class=form_title width=40%><small><b>Documento</b></small></td>
        <td valign=top width=10%>&nbsp;</td>
        <td valign=top width=60% align=center><small><b>Note</b></small></td>
     </tr>

    <tr>
        <td valign=top align=left class=form_title><small>Libretto d'impianto</small></td>
        <td valign=top><small>[iter_edit_flag_mh3 $lib_impianto]</small></td>
        <td valign=top><small>$lib_impianto_note</small></td>
     </tr>

    <tr>
        <td valign=top align=left class=form_title><small>Rapporto di controllo ex UNI 10435 (imp a gas)</small></td>
        <td valign=top><small>[iter_edit_flag_mh3 $rapp_contr]</small></td>
        <td valign=top><small>$rapp_contr_note</small></td>
     </tr>

    <tr>
        <td valign=top align=left class=form_title><small>Certificazione ex UNI 8364</small></td>
        <td valign=top><small>[iter_edit_flag_mh3 $certificaz]</small></td>
        <td valign=top><small>$certificaz_note</small></td>
    </tr>

    <tr>
        <td valign=top align=left class=form_title><small>Dichiarazione di conformit&agrave;</small></td>
        <td valign=top><small>[iter_edit_flag_mh3 $dich_conf]</small></td>
        <td valign=top><small>$dich_conf_note</small></td>
    </tr>

    <tr>
        <td valign=top align=left class=form_title><small>Libretto/i d'uso/manutenzione caldaia/e</small></td>
        <td valign=top><small>[iter_edit_flag_mh3 $lib_uso_man]</small></td>
        <td valign=top><small>$lib_uso_man_note</small></td>
    </tr>

    <tr>
        <td valign=top align=left class=form_title><small>Libretto/i uso/manutenzione bruciatore/i</small></td>
        <td valign=top><small>[iter_edit_flag_mh3 $libretto_bruc]</small></td>
        <td valign=top><small>$libretto_bruc_note</small></td>
    </tr>

    <tr>
        <td valign=top align=left class=form_title><small>Schemi funzionali idraulici</small></td>
        <td valign=top><small>[iter_edit_flag_mh3 $schemi_funz_idr]</small></td>
        <td valign=top><small>$schemi_funz_idr_note</small></td>
    </tr>

    <tr>
        <td valign=top align=left class=form_title><small>Schemi funzionali elettrici</small></td>
        <td valign=top><small>[iter_edit_flag_mh3 $schemi_funz_ele]</small></td>
        <td valign=top><small>$schemi_funz_ele_note</small></td>
    </tr>

    <tr>
        <td valign=top align=left class=form_title><small>Pratica ISPESL</small></td>
        <td valign=top><small>[iter_edit_flag_mh3 $ispesl]</small></td>
        <td valign=top><small>$ispesl_note</small></td>
    </tr>

    <tr>
        <td valign=top align=left class=form_title><small>Certificato prevensione incendi</small></td>
        <td valign=top><small>[iter_edit_flag_mh3 $prev_incendi]</small></td>
        <td valign=top><small>$prev_incendi_note</small></td>
    </tr>
</tr></table></td></tr>
<br />
<br />
<tr><td><table width=100%>
    <tr>
        <td valign=top align=left class=form_title colspan=4><b><small>C. ESAME VISIVO E CONTROLLO DELL'IMPIANTO</small></b></td>
    </tr>
    <tr>
        <td valign=top align=left class=form_title colspan=2 ><b><small>1. Centrale termica</small></b></td>
    </tr>
    <tr>
        <td valign=top align=left class=form_title width=40%><small>-  Idoneit&agrave; del locale di installazione</small></td>
        <td valign=top width=10%><small>[iter_edit_flag_mh $idoneita_locale]</small></td>
    </tr>
    <tr>
        <td valign=top align=left class=form_title><small>-  Adeguate dimensione aperture ventilazione</small></td>
        <td valign=top><small>[iter_edit_flag_mh $ap_ventilaz]</small></td>
    </tr>    
    <tr>
        <td valign=top align=left class=form_title><small>-  Aperture di ventilazione libere da ostruzioni<small></td>
        <td valign=top><small>[iter_edit_flag_mh $ap_vent_ostruz]</small></td>
    </tr>
    <tr>
        <td valign=top align=left class=form_title width=30%><b><small>2. Esame visivo linee elettriche</small></b></td>
        <td valign=top width=20%><small>[iter_edit_flag_mh2 $esame_vis_l_elet]</small></td>       
    </tr>
    <tr>
        <td valign=top align=left class=form_title><b><small>3. Controllo assenza fughe</small></b></td>
        <td valign=top><small>$assenza_fughe</small></td>
    </tr>
    <tr>
        <td valign=top align=left class=form_title><b><small>4. Esame visivo delle coibentazione</small></b></td>
        <td valign=top><small>[iter_edit_flag_mh2 $coibentazione]</small></td>
    </tr>
    <tr>
        <td valign=top align=left class=form_title><b><small>5. Esame visivo camino e canale da fumo</small></b></td>
        <td valign=top><small>[iter_edit_flag_mh2 $conservazione]</small></td>
    </tr>
</table></td></tr>
<tr><td>&nbsp</td></tr>
"

eval $stp_pag_gend

set lista_gend_prog [list]
db_foreach sel_gend_prog "" {
    lappend lista_gen_n $gen_prog_n
    if {[db_0or1row sel_dimp_n ""] == 1} {
	#ns_return 200 text/html $gen_prog_n
	eval $stp_pag_gend
    }
}



# creo file temporaneo html
set stampa1 $testata
append stampa1 $stampa
set stampa2 $testata2
append stampa2 $stampa


# imposto il nome dei file
set nome_file        "stampa-modello-f"
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

#ns_return 200 text/html $file_pdf; return
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

