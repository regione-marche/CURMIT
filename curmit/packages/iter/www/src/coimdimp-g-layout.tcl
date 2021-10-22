ad_page_contract {
    Stampa modello H impianto
    
    @author Giulio Laurenzi
    @creation-date 13/04/2004

    @cvs-id coimdimp-layout.tcl

    USER  DATA       MODIFICHE
    ===== ========== =========================================================================
    ale01 07/03/2017 Fatto in modo che se la matricola contiene > o < l'html venga scritto
    ale01            correttamente.

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

set link_tab [iter_links_form $cod_impianto $nome_funz_caller $url_list_aimp $url_aimp]
set dett_tab [iter_tab_form $cod_impianto]

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

# imposto la directory degli spool ed il loro nome.
set spool_dir     [iter_set_spool_dir]
set spool_dir_url [iter_set_spool_dir_url]
set logo_dir      [iter_set_logo_dir]


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

regsub -all {<} $matricola {\&lt;} matricola; #ale01
regsub -all {>} $matricola {\&gt;} matricola; #ale01

set testata2 "
              <table width=100% ><tr>
               <td width=100% align=center><table >
               <tr>
                  <td align=center><b><small>$ente</small></b></td>
               </tr><tr>
                   <td align=center><b><small>$ufficio</small></b></td></tr>
               </tr><tr>
                   <td align=center><small>$assessorato</small></td>
               </tr><tr>
                  <td align=center><small>$indirizzo_ufficio</small></td>
               </tr><tr>
                  <td align=center><small>$telefono_ufficio</small></td></tr></td></tr><small>
<table width=100% border>
    <tr>
        <td colspan=2 align=center>RAPPORTO DI CONTROLLO TECNICO (Allegato G)
        <br><small>PER IMPIANTO CON POTENZA TERMICA NOMINALE AL FOCOLARE < 35 kw</small></td>
    </tr>
 </table>"

set testata ""

append stampa "
               <table align=center width=100% cellpadding=2 cellspacing=0>
               <tr>
                  <td colspan=2 width=50%><small>Rapporto di controllo N&deg; $num_autocert</small></td>
                  <td width=50%><small>Data $data_controllo</small></td>
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

<tr><td>&nbsp</td></tr>
<tr><td><table width=100% border=0>
    <tr>
        <td><b><small>A. IDENTIFICAZIONE DELL'IMPIANTO</small></b></td>
        <td><small>Catasto impianti/codice $cod_impianto_est</small></td>
    </tr>
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
</table>
<!-- @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ -->
           </table><table align=center width=100% border=1  cellpadding=2 cellspacing=\"0\">
              <tr><td colspan=2 size=3><small><small><b>B. DOCUMENTAZIONE TECNICA DI CORREDO</b></small></small></td>
                  <td colspan=2 size=3><small><small><b>F. CONTROLLO DELL'APPARECCHIO</b></small></small></td>
              </tr>
                  <tr><td size=3 width=48%><small><small>Dichiarazione di conformit&agrave; dell'impianto</small></small></td>
                  <td width=2%><small><small>[iter_edit_flag_mh $conformita]</small></small></td>
                  <td size=3 width=48%><small><small>Ugelli del bruciatore principale e del bruciatore pilota (se esiste) puliti<small/></td>
                  <td width=2%><small><small>[iter_edit_flag_mh $pulizia_ugelli]</small></td>
              </tr>
              <tr><td><small><small>Libretto d'impianto</small></small></td>
                  <td><small><small>[iter_edit_flag_mh $lib_impianto]</small></small></td>
                  <td><small><small>Dispositivo rompitiraggio-antivento privo di evidenti tracce di deterioramento, ossidazione e/o corrosione</small></small></td>
                  <td><small><small>[iter_edit_flag_mh $antivento]</small></small></td>
              </tr>
              <tr><td><small><small>Libretto d'uso e manutenzione</small></small></td>
                  <td><small><small>[iter_edit_flag_mh $lib_uso_man]</small></small></td>
                  <td><small><small>Scambiatore lato fumi pulito</small></small></td>
                  <td><small><small>[iter_edit_flag_mh $scambiatore]</small></small></td>
              </tr>
              <tr><td colspan=2 size=2><small><small><b>C. ESAME VISIVO DEL LOCALE DI INSTALLAZIONE</b></small></small></td>
                  <td><small><small>Accensione e funzionamento regolari</small></small></td>
                  <td><small><small>[iter_edit_flag_mh $accens_reg]</small></small></small></td>
              </tr>
              <tr><td><small><small>Idoneit&agrave; del locale di installazione</small></small></td>
                  <td><small><small>[iter_edit_flag_mh $idoneita_locale]</small></small></td>
                  <td><small><small>Dispositivi di comando e regolazione funzionanti correttamente</small></small></td>
                  <td><small><small>[iter_edit_flag_mh $disp_comando]</small></small></td>
              </tr>
              <tr><td><small><small>Adeguate dimensioni delle aperture di ventilazione</small></small></td>
                  <td><small><small>[iter_edit_flag_mh $ap_ventilaz]</small></small></td>
                  <td><small><small>Assenza di perdite e ossidazioni dai/sui comandi</small></small></td>
                  <td><small><small>[iter_edit_flag_mh $ass_perdite]</small></small></td>
              </tr>
              <tr><td><small><small>Aperture di ventilazione libere da ostruzioni</small></small></td>
                  <td><small><small>[iter_edit_flag_mh $ap_vent_ostruz]</small></small></td>
                  <td><small><small>Valvola di sicurezza contro la sovrapressione a scarico libero</small></small></td>
                  <td><small><small>[iter_edit_flag_mh $valvola_sicur]</small></small></td>
              </tr>
              <tr><td colspan=2 size=2><small><small><b>D. ESAME VISIVO DEI CANALI DA FUMO</b></small></small></td>
                  <td><small><small>Vaso di espansione carico</small></small></td>
                  <td><small><small>[iter_edit_flag_mh $vaso_esp]</small></small></td>
              </tr>
              <tr><td><small><small>Pendenza corretta</small></small></td>
                  <td><small><small>[iter_edit_flag_mh $pendenza]</small></small></td>
                  <td><small><small>Dispositivi di sicurezza non manomessi e/o cortocircuitati</small></small></td>
                  <td><small><small>[iter_edit_flag_mh $disp_sic_manom]</small></small></td>
              </tr>
              <tr><td><small><small>Sezioni corrette</small></small></td>
                  <td><small><small>[iter_edit_flag_mh $sezioni]</small></small></td>
                  <td><small><small>Organi soggetti a sollecitazioni termiche integri
                            e senza segni di usura e/o deformazione</small></small></td>
                  <td><small><small>[iter_edit_flag_mh $organi_integri]</small></small></td>
              </tr>
              <tr><td><small><small>Curve corrette</small></small></td>
                  <td><small><small>[iter_edit_flag_mh $curve]</small></small></td>
                  <td><small><small>Circuito aria pulito e libero da qualsiasi impedimento</small></small></td>
                  <td><small><small>[iter_edit_flag_mh $circ_aria]</small></small></td>
              </tr>
              <tr><td><small><small>Lunghezza corretta</small></small></td>
                  <td><small><small>[iter_edit_flag_mh $lunghezza]</small></small></td>
                  <td><small><small>Guarnizione di accoppiamento al generatore integra</small></small></td>
                  <td><small><small>[iter_edit_flag_mh $guarn_accop]</small></small></td>
              </tr>
              <tr><td><small><small>Buono stato di conservazione</small></small></td>
                  <td><small><small>[iter_edit_flag_mh $conservazione]</small></small></td>
                  <td colspan=2>&nbsp;</td>
              </tr>
              <tr><td colspan=2 size=2><small><small><b>E. CONTROLLO EVACUAZIONE PRODOTTI DI COMBUSTIONE</b></small></small></td>
                  <td colspan=2 size=2><small><small><b>G. CONTROLLO DELL'IMPIANTO</b></small></small></td>
              </tr>
              <tr><td><small><small>Scarico in camino singolo</small></small></td>
                  <td><small><small>[iter_edit_flag_mh $scar_ca_si]</small></small></td>
                  <td><small><small>Controllo assenza fughe di gas</small></small></td>
                  <td><small><small>[iter_edit_flag_mh6 $assenza_fughe]</small></small></td>
              </tr>
              <tr>
                  <td><small><small>Scarico in canna fumaria colletiva ramificata</small></small></td>
                  <td><small><small>[iter_edit_flag_mh $scar_can_fu]</small></small></td>
                  <td><small><small>Verifica visiva coibentazioni</small></small></td>
                  <td><small><small>[iter_edit_flag_mh6 $coibentazione]</small></small></td>
              </tr>
              <tr><td><small><small>L'apparecchio scarica a parete</small></small></td>
                  <td><small><small>[iter_edit_flag_mh $scar_parete]</small></small></td>
                  <td><small><small>Verifica efficienza evacuazione fumi</small></small></td>
                  <td><small><small>[iter_edit_flag_mh6 $eff_evac_fum]</small></small></td>
              </tr>
              <tr><td><small><small>Per apparecchio a tiraggio naturale:
                         non esistono riflussi dei fumi nel locale</small></small></td>
                  <td><small><small>[iter_edit_flag_mh $riflussi_locale]</small></small></td>
                  <td colspan=2 size=2><small><small>Legenda: N.C.=Non Controllabile, N.A.=Non Applicabile, ES=Esterno</small></small></td>
              </tr>
              <tr><td><small><small>Per apparecchio a tiraggio forzato:
                         assenza di perdite da condotti di scarico</small></small></td>
                  <td><small><small>[iter_edit_flag_mh $assenza_perdite]</small></small></td>
              </tr>

              </table>
              <tr><td colspan=8 size=2><small><b>H. CONTROLLO DEL RENDIMENTO DI COMBUSTIONE</b>&nbsp;&nbsp;&nbsp;[iter_edit_flag_mh $cont_rend]</small></td></tr>
              <table align=center width=100% border=1 cellpadding=3 cellspacing=\"0\">
              <tr><td><small>Temperatura fumi(&deg;C)</small></td>
                  <td><small>Temperatura aria comb.(&deg;C)</small></td>
                  <td><small>O<sub><small>2</small></sub>(%)</small></td>
                  <td><small>CO<sub><small>2</small></sub>(%)</small></td>
                  <td><small>Bacharach(n&deg;)</small></td>
                  <td><small>CO $misura_co</small></td>
                  <td><small>Rend.to Combustione</small></td>
                  <td><small>Tiraggio (Pa)</small></td>
              </tr>
              <tr><td align=right><small>$temp_fumi</small></td>
                  <td align=right><small>$temp_ambi</small></td>
                  <td align=right><small>$o2</small></td>
                  <td align=right><small>$co2</small></td>
                  <td align=right><small>$bacharach</small></td>
                  <td align=right><small>$co</small></td>
                  <td align=right><small>$rend_combust</small></td>
                  <td align=right><small>$tiraggio_fumi</small></td>
              </tr>
              </table>
              <table width=100% border=0 cellpadding=2 cellspacing=0>
              <tr>
                <td><small><b>OSSERVAZIONI</b>: $osservazioni</small>
                </td>
              </tr>
              <tr>
                <td><small><b>RACCOMANDAZIONI</b> (in attesa di questi interventi l'impianto pu&ograve; essere messo in funzione): $raccomandazioni</small>
                </td>
              </tr>
              <tr>
                <td><small><b>PRESCRIZIONI</b> (in attesa di questi interventi l'impianto non pu&ograve; essere messo in funzione): $prescrizioni"

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

if {[db_0or1row sel_manu ""] == 1} {
    set manuten "$nome $cognome"
    set indir_man "$indirizzo $localita $provincia $telefono" 
} else {
    # codice non trovato
    set manuten "" 
    set indir_man ""
}

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
                  <td  valign=top align=left class=form_title><small>In mancanza di prescrizione esplicite, il tecnico dichiara che l'apparecchio pu&ograve; essere messo in servizio ed usato normalmente senza compromettere la sicurezza delle persone, degli animali e dei beni.<b>Ai fini della sicurezza l'impianto pu&ograve; funzionare</b> [iter_edit_flag_mh $flag_status]</small></td>
                </tr>
              </table>
            </td>
          </tr>
          <tr><td align=center><table width=100% ><tr>
            <td  valign=top align=left class=form_title><small><small>Il tecnico declina altresi ogni responsabilit&agrave; per sinistri a persone, animali o cose derivanti da manomissione dell'impianto o dell'apparecchio da parte di terzi, ovvero da carenze di manutenzione successiva. In presenza di carenza riscontrate e non eliminate, il responsabile dell'impianto si impegna, entro breve tempo a provvedere alla loro risoluzione dandone notizia all'operatore incaricato.</small></small></td>
          </tr>
          </table>
        </td>
      </tr>
             <table width=100% border=0 cellpadding=2 cellspacing=0>
               <tr>
                    <td colspan=2><small><b>TECNICO CHE HA EFFETTUATO IL CONTROLLO:</b></small></td>
               </tr>
               <tr>
                  <td colspan=2><small>Nome e cognome: $manuten </small></td>
               </tr>
               <tr>
                  <td colspan=2><small>Indirizzo $indir_man<small>
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
set nome_file        "stampa modello h"
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
