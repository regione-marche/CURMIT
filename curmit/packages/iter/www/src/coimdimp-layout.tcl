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
    set co [expr $co / 10000.0000]
    set co [iter_edit_num $co 4]
    set misura_co "(%)"
} else {
    set misura_co "(ppm)"
    set co [iter_edit_num $co 0]
}

set testata2 "
              <table width=100% ><tr>
   <!--            <td width=20% align=center rowspan=4><img src=\"$root/logo/massa.gif\" width=60></td> -->
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
                  <td align=center><small>$telefono_ufficio</small></td></tr></td></tr><small><hr>
<table width=100%><tr></td><td colspan=2 align=center>MODELLO H</td></tr></table>"


set testata ""

append stampa "<table align=center width=100% border=0  cellpadding=2 cellspacing=\"0\">
               <tr>
                  <td colspan=4><small>Impianto installato nell'immobile sito in : $comune_ubic Via: $indirizzo_ubic</small></td>
               </tr><tr>
                  <td colspan=4><small>Proprietario : $cognome_prop $nome_prop $indirizzo_prop $numero_prop $cap_prop $comune_prop $provincia_prop</small></td>
               </tr><tr>
                  <td colspan=4><small>Occupante : $cognome_util $nome_util $indirizzo_util $numero_util $cap_util $comune_util $provincia_util</small></td>
               </tr>
               </table>
               <hr>
               <table align=center width=100% border=0 cellpadding=2 cellspacing=\"0\">
               <tr><td colspan=4 size=2><small>DATI DI TARGA DELL' APPARECCHIO</small></td></tr>
               <tr><td><small>Caldaia : $descrizione</small></td>
                   <td><small>Costr. : $descr_cost</small></td>
                   <td><small>Modello : $modello</small></td>
                   <td><small>Matricola : $matricola</small></td>
                   <td><small>Anno inst.: $anno_costruzione</small></td>
               </tr>
               <tr><td><small>Potenza Nominale(kW): [iter_edit_num $potenza 2]</small></td>
                   <td><small>Tipo gen.: $des_tipo_foc</small></td>
                   <td><small>Tiraggio : $des_tiraggio</small></td>
                   <td colspan=2 size=2><small>Combustibile : $descr_comb</small></td>
               </tr>
               <tr><td colspan=2 size=2><small>DATA INSTALLAZIONE : $data_installaz</small></td>
                   <td colspan=2 size=2><small>DATA CONTROLLO : $data_controllo</small></td>
               </tr> 

               </table><hr><table align=center width=100% border=1  cellpadding=2 cellspacing=\"0\">
              <tr><td colspan=2 size=3><small><b>Documentazione di impianto</b></td>
                  <td colspan=2 size=3><small><b>Controllo dell'apparecchio</b></td>
              </tr>
                  <tr><td size=3 width=48%><small>Dichiarazione di conformit&agrave; dell'impianto</small></td>
                  <td width=2%><small>[iter_edit_flag_mh $conformita]</small></td>
                  <td size=3 width=48%><small>Ugelli del bruciatore principale e del bruciatore pilota (se esiste) puliti<small/></td>
                  <td width=2%><small>[iter_edit_flag_mh $pulizia_ugelli]</small></td>
              </tr>
              <tr><td><small>Libretto d'impianto</small></td>
                  <td><small>[iter_edit_flag_mh $lib_impianto]</small></td>
                  <td><small>Dispositivo rompitiraggio-antivento privo di evidenti<br>tracce di deterioramento, ossidazione e/o corrosione</small></td>
                  <td><small>[iter_edit_flag_mh $antivento]</small></td>
              </tr>
              <tr><td><small>Libretto d'uso e manutenzione</small></td>
                  <td><small>[iter_edit_flag_mh $lib_uso_man]</small></td>
                  <td><small>Scambiatore lato fumi pulito</small></td>
                  <td><small>[iter_edit_flag_mh $scambiatore]</small></td>
              </tr>
              <tr><td colspan=2 size=2><small><b>Esame visivo del locale di installazione</b></small></td>
                  <td><small>Accensione e funzionamento regolari</small></td>
                  <td><small>[iter_edit_flag_mh $accens_reg]</small></small></td>
              </tr>
              <tr><td><small>Idoneit&agrave; del locale di installazione</small></td>
                  <td><small>[iter_edit_flag_mh $idoneita_locale]</small></td>
                  <td><small>Dispositivi di comando e regolazione funzionanti correttamente</small></td>
                  <td><small>[iter_edit_flag_mh $disp_comando]</small></td>
              </tr>
              <tr><td><small>Adeguate dimensioni delle aperture di ventilazione</small></td>
                  <td><small>[iter_edit_flag_mh $ap_ventilaz]</small></td>
                  <td><small>Assenza di perdite e ossidazioni dai/sui comandi</small></td>
                  <td><small>[iter_edit_flag_mh $ass_perdite]</small></td>
              </tr>
              <tr><td><small>Aperture di ventilazione libere da ostruzioni</small></td>
                  <td><small>[iter_edit_flag_mh $ap_vent_ostruz]</small></td>
                  <td><small>Valvola di sicurezza contro la sovrapressione a scarico libero</small></td>
                  <td><small>[iter_edit_flag_mh $valvola_sicur]</small></td>
              </tr>
              <tr><td colspan=2 size=2><small><b>Esame visivo dei canali da fumo</b></small></td>
                  <td><small>Vaso di espansione carico</small></td>
                  <td><small>[iter_edit_flag_mh $vaso_esp]</small></td>
              </tr>
              <tr><td><small>Pendenza corretta</small></td>
                  <td><small>[iter_edit_flag_mh $pendenza]</small></td>
                  <td><small>Dispositivi di sicurezza non manomessi e/o cortocircuitati</small></td>
                  <td><small>[iter_edit_flag_mh $disp_sic_manom]</small></td>
              </tr>
              <tr><td><small>Sezioni corrette</small></td>
                  <td><small>[iter_edit_flag_mh $sezioni]</small></td>
                  <td><small>Organi soggetti a sollecitazioni termiche integri
                         <br>e senza segni di usura e/o deformazione</small></td>
                  <td><small>[iter_edit_flag_mh $organi_integri]</small></td>
              </tr>
              <tr><td><small>Curve corrette</small></td>
                  <td><small>[iter_edit_flag_mh $curve]</small></td>
                  <td><small>Circuito aria pulito e libero da qualsiasi impedimento</small></td>
                  <td><small>[iter_edit_flag_mh $circ_aria]</small></td>
              </tr>
              <tr><td><small>Lunghezza corretta</small></td>
                  <td><small>[iter_edit_flag_mh $lunghezza]</small></td>
                  <td><small>Guarnizione di accoppiamento al generatore integra</small></td>
                  <td><small>[iter_edit_flag_mh $guarn_accop]</small></td>
              </tr>
              <tr><td><small>Buono stato di conservazione</small></td>
                  <td><small>[iter_edit_flag_mh $conservazione]</small></td>
                  <td colspan=2>&nbsp;</td>
              </tr>
              <tr><td colspan=2 size=2><small><b>Controllo evacuazione dei prodotti della combustione</b></small></td>
                  <td colspan=2 size=2><small><b>Controllo dell'impianto</b></small></td>
              </tr>
              <tr><td><small>L'apparecchio scarica in camino singolo
                         <br>o canna fumaria colletiva ramificata</small></td>
                  <td><small>[iter_edit_flag_mh $scar_ca_si]</small></td>
                  <td><small>Controllo assenza fughe di gas</small></td>
                  <td><small>[iter_edit_flag_mh6 $assenza_fughe]</small></td>
              </tr>
              <tr><td><small>L'apparecchio scarica a parete</small></td>
                  <td><small>[iter_edit_flag_mh $scar_parete]</small></td>
                  <td><small>Verifica visiva coibentazioni</small></td>
                  <td><small>[iter_edit_flag_mh6 $coibentazione]</small></td>
              </tr>
              <tr><td><small>Per apparecchio a tiraggio naturale:
                         <br>non esistono riflussi dei fumi nel locale</small></td>
                  <td><small>[iter_edit_flag_mh $riflussi_locale]</small></td>
                  <td><small>Verifica efficienza evacuazione fumi</small></td>
                  <td><small>[iter_edit_flag_mh6 $eff_evac_fum]</small></td>
              </tr>
              <tr><td><small>Per apparecchio a tiraggio forzato:
                         <br>assenza di perdite da condotti di scarico</small></td>
                  <td><small>[iter_edit_flag_mh $assenza_perdite]</small></td>
                  <td colspan=2 size=2><small>Legenda: N.C.=Non Controllabile, N.A.=Non Applicabile, ES=Esterno</small></td>
              </tr>

              </table>
              <table align=center width=100% border=0 cellpadding=3 cellspacing=\"0\">
              <tr><td colspan=8 size=2><small><b>Controllo del rendimento di combustione</b>&nbsp;&nbsp;&nbsp;[iter_edit_flag_mh $cont_rend]</small></td></tr>
              <tr><td><small>Temperatura fumi(&deg;C)</small></td>
                  <td><small>Temperatura ambiente(&deg;C)</small></td>
                  <td><small>O<sub><small>2</small></sub>(%)</small></td>
                  <td><small>CO<sub><small>2</small></sub>(%)</small></td>
                  <td><small>Bacharach(n&deg;)</small></td>
                  <td><small>CO $misura_co</small></td>
                  <td><small>Rend.combustione a Potenza Nominale</small></td>
              </tr>
              <tr><td><small>$temp_fumi</small></td>
                  <td><small>$temp_ambi</small></td>
                  <td><small>$o2</small></td>
                  <td><small>$co2</small></td>
                  <td><small>$bacharach</small></td>
                  <td><small>$co</small></td>
                  <td><small>$rend_combust</small></td>
              </tr>
              </table>
              <hr>
              <table width=100% border=0 cellpadding=2 cellspacing=0>
              <tr>
                <td><small>OSSERVAZIONI: <b>$osservazioni</b></small>
                </td>
              </tr>
              <tr>
                <td><small>RACCOMANDAZIONI: <b>$raccomandazioni</b></small>
                </td>
              </tr>
              <tr>
                <td><small>PRESCRIZIONI (l'impianto pu&ograve; funzionare solo dopo l'esecuzione di quanto prescritto): <b>$prescrizioni"

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
    set firma_resp $nominativo_prop
}

append stampa "<hr>
               <table width=100% border=0 cellpadding=2 cellspacing=0>
               <tr>
                  <td colspan=2><small>MANUTENTORE: $manuten $indir_man</small>
                  </td>
               </tr>
               <tr>
                  <td width=50%><small>Firma manutentore</small></td>
                  <td width=50%><small>Firma responsabile</small></td>
               </tr>
               <tr>
                  <td><small>$firma_manut</small></td>
                  <td><small>$firma_resp</small></td>
               </tr>
               <tr>
                  <td colspan=2><small>Rif./Numero Bollino: $riferimento_pag</small></td>
               </tr>
               </table>"

# creo file temporaneo html
set stampa1 $testata
append stampa1 $stampa
set stampa2 $testata2
append stampa2 $stampa

# imposto la directory degli spool ed il loro nome.
set spool_dir     [iter_set_spool_dir]
set spool_dir_url [iter_set_spool_dir_url]
set logo_dir      [iter_set_logo_dir]

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
