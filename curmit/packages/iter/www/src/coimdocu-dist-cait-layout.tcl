ad_page_contract {
    Stampa distinta di consegna Modelli H

    @author                  Nicola Mortoni
    @creation-date           07/07/2006

    @param caller            se diverso da index rappresenta il nome del form 
                             da cui e' partita la ricerca ed in questo caso
                             imposta solo azione "sel"
    @param nome_funz         identifica l'entrata di menu,
                             serve per le autorizzazioni
    @param nome_funz_caller  identifica l'entrata di menu,
                             serve per la navigation bar

    @cvs-id coimdimp-scar-list.tcl 
} { 
   {caller            "index"}
   {nome_funz         ""}
   {nome_funz_caller  ""} 

   {last_cod_documento ""}
   {extra_par          ""}
    {f_cod_manu        ""}
}  -properties {
    page_title:onevalue
    context_bar:onevalue
}

# Controlla lo user
set lvl        1
set id_utente [lindex [iter_check_login $lvl $nome_funz] 1]

# controllo il parametro di "propagazione" per la navigation bar
if {[string is space $nome_funz_caller]} {
    set nome_funz_caller $nome_funz
}

set page_title      "Stampa distinta di consegna dichiarazioni"
set context_bar     [iter_context_bar -nome_funz $nome_funz_caller]

# preparo link per ritorno alla lista distinte:
set link_docu_dist_list   [export_url_vars caller nome_funz_caller nome_funz]&[iter_set_url_vars $extra_par]



# imposto la directory degli spool ed il loro nome.
set spool_dir       [iter_set_spool_dir]
set spool_dir_url   [iter_set_spool_dir_url]



set nome_file_tot    "Stampa distinta di consegna dichiarazioni globale"
set nome_file_tot    [iter_temp_file_name $nome_file_tot]
set file_html_tot    "$spool_dir/$nome_file_tot.html"
set file_pdf_tot     "$spool_dir/$nome_file_tot.pdf"
set file_pdf_url_tot "$spool_dir_url/$nome_file_tot.pdf"

# apro il file html temporaneo
set file_id_tot [open $file_html_tot w]
fconfigure $file_id_tot -encoding iso8859-1



set sysdate       [iter_set_sysdate];#viene usato anche nell'insert
set sysdate_edit  [iter_edit_date $sysdate]

iter_get_coimdesc
set nome_ente    $coimdesc(nome_ente)
set tipo_ufficio $coimdesc(tipo_ufficio)
set assessorato  $coimdesc(assessorato)
set indirizzo    $coimdesc(indirizzo)
set telefono     $coimdesc(telefono)

# imposto la query SQL 
# scrivo due query diverse a seconda se c'e' o meno il viario
iter_get_coimtgen
if {$coimtgen(flag_viario) == "T"} {
    set nome_col_toponimo  "e.descr_topo"
    set nome_col_via       "e.descrizione"
    if {[iter_get_parameter database] == "postgres"} {
	set from_coimviae  "left outer join coimviae e"
	set where_coimviae "             on e.cod_comune    = b.cod_comune
                                        and e.cod_via       = b.cod_via"
    } else {
	set from_coimviae  "              , coimviae e"
	set where_coimviae "            and e.cod_comune (+)= b.cod_comune
                                        and e.cod_via    (+)= b.cod_via"
    }
} else {
    set nome_col_toponimo  "b.toponimo"
    set nome_col_via       "b.indirizzo"
    set from_coimviae      ""
    set where_coimviae     ""
}

set lista_manu ""
if {[string equal $f_cod_manu ""]} {
    db_foreach sel_codici_manu "" {
	lappend lista_manu [list $f_cod_manu]
    }
} else {
    lappend lista_manu [list $f_cod_manu]
}

with_catch error_msg {
    db_transaction {

	foreach manutentore $lista_manu {
            set f_cod_manu [lindex $manutentore 0]
	    
	    set where_prescr " and a.prescrizioni is null
                   and (a.flag_status is null or a.flag_status = 'P')"
	    set lista_dimp ""
	    set lista_dimp [db_list_of_lists sel_dimp ""]
	    
	    set where_prescr " and (a.prescrizioni is not null or a.flag_status = 'N')"
	    set lista_dimp_prescr ""
	    set lista_dimp_prescr [db_list_of_lists sel_dimp ""]
	    
	    set ctr_rec        [llength $lista_dimp]
	    set ctr_rec_prescr [llength $lista_dimp_prescr]

	    if {[expr $ctr_rec + $ctr_rec_prescr] == 0} {
		iter_return_complaint "Nessun dato corrisponde ai criteri impostati"
		return
	    }
	    
	    if {$ctr_rec > 0} {
		set mese_rif ""
		set anno_rif ""
		foreach riga_dimp $lista_dimp {
		    
		    util_unlist $riga_dimp cod_dimp cod_impianto data_controllo_edit cod_impianto_est data_ins_edit resp comune indir riferimento_pag costo descr_potenza

		    set mese_controllo [string range $data_controllo_edit 3 4]
		    set anno_controllo [string range $data_controllo_edit 6 9]

		    if {[string equal $mese_rif ""]
                        || $mese_rif != $mese_controllo
                        || $anno_rif != $anno_controllo} {

			if {![string equal $mese_rif ""]} {
			    
			    puts $file_id $righe_stampa
			    close $file_id
			    
			    # creo il file pdf
			    iter_crea_pdf [list exec htmldoc --webpage --header ... --footer ... --quiet --bodyfont arial --fontsize 10 --headfootfont arial --headfootsize 10 --landscape --top 2.5cm --bottom 2cm --left 2cm --right 2cm -f $file_pdf $file_html]
			    
			    # cancello il file temporaneo creato
			    ns_unlink     $file_html
			    
			    #   cod_documento e' gia' valorizzato con db_string sel_docu_s
			    set cod_soggetto  $f_cod_manu
			    set tipo_soggetto "M"
			    set tipo_documento    "DC"
			    set cod_impianto      ""
			    set data_documento    $sysdate
			    set data_stampa       $sysdate
			    set data_ins          $sysdate
			    set data_mod          $sysdate
			    set utente            $id_utente
			    
			    db_dml ins_docu ""
		
			    # controllo se il Database e' Oracle o Postgres
			    set id_db             [iter_get_parameter database]
			    set tipo_contenuto    [ns_guesstype $file_pdf]
			    set contenuto_tmpfile $file_pdf
			    
			    if {$id_db == "postgres"} {
				db_dml upd_docu_ins_dist ""
			    } else {
				db_dml upd_docu_ins_dist "" -blob_files [list $contenuto_tmpfile]
			    }

			    append righe_stampa "
                            </table>
                            <!-- PAGE BREAK -->"
			    append stampa_tot $righe_stampa
			}

			set righe_stampa ""
			set mese_rif $mese_controllo
			set anno_rif $anno_controllo
			switch $mese_rif {
			    "01" {set nome_mese "Gennaio"}
			    "02" {set nome_mese "Febbraio"}
			    "03" {set nome_mese "Marzo"}
			    "04" {set nome_mese "Aprile"}
			    "05" {set nome_mese "Maggio"}
			    "06" {set nome_mese "Giugno"}
			    "07" {set nome_mese "Luglio"}
			    "08" {set nome_mese "Agosto"}
			    "09" {set nome_mese "Settembre"}
			    "10" {set nome_mese "Ottobre"}
			    "11" {set nome_mese "Novembre"}
			    "12" {set nome_mese "Dicembre"}
			}
			    
			# imposto il nome dei file
			set nome_file       "Stampa distinta di consegna dichiarazioni conformi di $nome_mese"
			set nome_file       [iter_temp_file_name $nome_file]
			set file_html       "$spool_dir/$nome_file.html"
			set file_pdf        "$spool_dir/$nome_file.pdf"
			set file_pdf_url    "$spool_dir_url/$nome_file.pdf"
			
			set file_id [open $file_html w]
			fconfigure $file_id -encoding iso8859-1
			
			append righe_stampa "
                        <!-- FOOTER LEFT   \"$sysdate_edit\"-->
                        <!-- FOOTER CENTER \"Distinta di consegna dichiarazioni\"-->
                        <!-- FOOTER RIGHT  \"Pagina \$PAGE(1) di \$PAGES(1)\"-->"
		
			append righe_stampa "
                        <table width=100%>
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
                        </table>"

			db_1row sel_manu ""
			set uten_cognome_nome "Manutentore: <b>$manu_cognome $manu_nome</b>"
		
			set cod_documento [db_string sel_docu_s ""]
			db_1row sel_count_mese "select count(*) as ctr_rec_mese
                                                  from coimdimp a
                                                     , coimaimp b
                                                   where a.cod_manutentore = :f_cod_manu
                                                   and a.prescrizioni is null
                                                   and (a.flag_status is null or a.flag_status = 'P')
                                                   and a.cod_docu_distinta is null
                                                   and a.utente_ins = :id_utente
                                                   and b.stato = 'A'
                                                   and a.cod_impianto = b.cod_impianto
                                                   and substr(data_controllo, 6, 2) = :mese_controllo
                                                   and substr(data_controllo, 1, 4) = :anno_controllo"
		
			append righe_stampa "
                        <br>
                        <h2>Distinta di consegna dichiarazioni conformi n. $cod_documento del $sysdate_edit - Mese di $nome_mese</h2>
                        $uten_cognome_nome - Numero modelli: $ctr_rec_mese
                        <br>
                        <br>
                        <table width=100% border=1>
                            <tr>
                                <th align=center valign=top>Data controllo</th>
                                <th align=left   valign=top>Cod.Imp.</th>
                                <th align=center valign=top>Data ins.</th>
                                <th align=left   valign=top>Responsabile</th>
                                <th align=left   valign=top>Comune</th>
                                <th align=left   valign=top>Indirizzo</th>
                                <th align=left   valign=top>Rif./N. bollino</th>
                                <th align=left   valign=top>Costo</th>
                                <th align=left   valign=top>Fascia potenza</th>
                            </tr>"
		    }			

		    if {[string is space $cod_impianto_est]} {
			set cod_impianto_est "&nbsp;"
		    }
		    if {[string is space $data_ins_edit]} {
			set data_ins_edit    "&nbsp;"
		    }
		    if {[string is space $resp]} {
			set resp             "&nbsp;"
		    }
		    if {[string is space $comune]} {
			set comune           "&nbsp;"
		    }
		    if {[string is space $indir]} {
			set indir            "&nbsp;"
		    }
		    if {[string is space $riferimento_pag]} {
			set riferimento_pag  "&nbsp;"
		    }
		    if {[string is space $costo]} {
			set costo  "&nbsp;"
		    }
		    if {[string is space $descr_potenza]} {
			set descr_potenza  "&nbsp;"
		    }
		    
		    append righe_stampa "
                    <tr>
                        <td align=center valign=top>$data_controllo_edit</td>
                        <td align=left   valign=top>$cod_impianto_est</td>
                        <td align=center valign=top>$data_ins_edit</td>
                        <td align=left   valign=top>$resp</td>
                        <td align=left   valign=top>$comune</td>
                        <td align=left   valign=top>$indir</td>
                        <td align=left   valign=top>$riferimento_pag</td>
                        <td align=left   valign=top>$costo</td>
                        <td align=left   valign=top>$descr_potenza</td>
                    </tr>"

		    set cod_docu_distinta $cod_documento
		    db_dml upd_dimp ""
		}
		puts $file_id $righe_stampa
		close $file_id
		
		# creo il file pdf
		iter_crea_pdf [list exec htmldoc --webpage --header ... --footer ... --quiet --bodyfont arial --fontsize 10 --headfootfont arial --headfootsize 10 --landscape --top 2.5cm --bottom 2cm --left 2cm --right 2cm -f $file_pdf $file_html]
		
		# cancello il file temporaneo creato
		ns_unlink     $file_html
		
		#   cod_documento e' gia' valorizzato con db_string sel_docu_s
		set cod_soggetto  $f_cod_manu
		set tipo_soggetto "M"
		set tipo_documento    "DC"
		set cod_impianto      ""
		set data_documento    $sysdate
		set data_stampa       $sysdate
		set data_ins          $sysdate
		set data_mod          $sysdate
		set utente            $id_utente
		
		db_dml ins_docu ""
		
		# controllo se il Database e' Oracle o Postgres
		set id_db             [iter_get_parameter database]
		set tipo_contenuto    [ns_guesstype $file_pdf]
		set contenuto_tmpfile $file_pdf
		
		if {$id_db == "postgres"} {
		    db_dml upd_docu_ins_dist ""
		} else {
		    db_dml upd_docu_ins_dist "" -blob_files [list $contenuto_tmpfile]
		}
		
		append righe_stampa "
                </table>
                <!-- PAGE BREAK -->"
		append stampa_tot $righe_stampa
	    }   
	    
	    if {$ctr_rec_prescr > 0} {
		set mese_rif ""
		set anno_rif ""
		foreach riga_dimp $lista_dimp_prescr {
		    
		    util_unlist $riga_dimp cod_dimp cod_impianto data_controllo_edit cod_impianto_est data_ins_edit resp comune indir riferimento_pag costo descr_potenza

		    set mese_controllo [string range $data_controllo_edit 3 4]
		    set anno_controllo [string range $data_controllo_edit 6 9]

		    if {[string equal $mese_rif ""]
                        || $mese_rif != $mese_controllo
			|| $anno_rif != $anno_controllo} {

			if {![string equal $mese_rif ""]} {
			    puts $file_id2 $righe_stampa
			    close $file_id2
			    
			    # creo il file pdf
			    iter_crea_pdf [list exec htmldoc --webpage --header ... --footer ... --quiet --bodyfont arial --fontsize 10 --headfootfont arial --headfootsize 10 --landscape --top 2.5cm --bottom 2cm --left 2cm --right 2cm -f $file_pdf2 $file_html2]
			    
			    # cancello il file temporaneo creato
			    ns_unlink     $file_html2
			    
			    #   cod_documento e' gia' valorizzato con db_string sel_docu_s
			    set cod_soggetto  $f_cod_manu
			    set tipo_soggetto     "M"
			    set tipo_documento    "DC"
			    set cod_impianto      ""
			    set data_documento    $sysdate
			    set data_stampa       $sysdate
			    set data_ins          $sysdate
			    set data_mod          $sysdate
			    set utente            $id_utente
			    
			    db_dml ins_docu ""
	    
			    # controllo se il Database e' Oracle o Postgres
			    set id_db             [iter_get_parameter database]
			    set tipo_contenuto    [ns_guesstype $file_pdf2]
			    set contenuto_tmpfile $file_pdf2

			    if {$id_db == "postgres"} {
				db_dml upd_docu_ins_dist ""
			    } else {
				db_dml upd_docu_ins_dist "" -blob_files [list $contenuto_tmpfile]
			    }

			    append righe_stampa "
                            </table>
                            <!-- PAGE BREAK -->"
			    append stampa_tot $righe_stampa
			}

			set righe_stampa ""
			set mese_rif $mese_controllo
			set anno_rif $anno_controllo
			switch $mese_rif {
			    "01" {set nome_mese "Gennaio"}
			    "02" {set nome_mese "Febbraio"}
			    "03" {set nome_mese "Marzo"}
			    "04" {set nome_mese "Aprile"}
			    "05" {set nome_mese "Maggio"}
			    "06" {set nome_mese "Giugno"}
			    "07" {set nome_mese "Luglio"}
			    "08" {set nome_mese "Agosto"}
			    "09" {set nome_mese "Settembre"}
			    "10" {set nome_mese "Ottobre"}
			    "11" {set nome_mese "Novembre"}
			    "12" {set nome_mese "Dicembre"}
			}

			set nome_file2      "Stampa distinta di consegna dichiarazioni non conformi di $nome_mese"
			set nome_file2      [iter_temp_file_name $nome_file2]
			set file_html2      "$spool_dir/$nome_file2.html"
			set file_pdf2       "$spool_dir/$nome_file2.pdf"
			set file_pdf_url2   "$spool_dir_url/$nome_file2.pdf"
			
			set file_id2 [open $file_html2 w]
			fconfigure $file_id2 -encoding iso8859-1
			
			set righe_stampa ""
			append righe_stampa "
                        <!-- FOOTER LEFT   \"$sysdate_edit\"-->
                        <!-- FOOTER CENTER \"Distinta di consegna dichiarazioni\"-->
                        <!-- FOOTER RIGHT  \"Pagina \$PAGE(1) di \$PAGES(1)\"-->"
		
			append righe_stampa "
                <table width=100%>
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
                  </table>"

			db_1row sel_manu ""
			set uten_cognome_nome "Manutentore: <b>$manu_cognome $manu_nome</b>"
			
			set cod_documento [db_string sel_docu_s ""]
			db_1row sel_count_mese "select count(*) as ctr_rec_mese_prescr
                                                  from coimdimp a
                                                     , coimaimp b
                                                   where a.cod_manutentore = :f_cod_manu
                                                   and (a.prescrizioni is not null or a.flag_status = 'N')
                                                   and a.cod_docu_distinta is null
                                                   and b.stato = 'A'
                                                   and a.utente_ins = :id_utente
                                                   and a.cod_impianto = b.cod_impianto
                                                   and substr(data_controllo, 6, 2) = :mese_controllo
                                                   and substr(data_controllo, 1, 4) = :anno_controllo"

			
			append righe_stampa "
                        <br>
                        <h2>Distinta di consegna dichiarazioni con prescrizioni o impianto non funzionante n. $cod_documento del $sysdate_edit - Mese di $nome_mese</h2>
                        $uten_cognome_nome - Numero modelli: $ctr_rec_mese_prescr
                        <br>
                        <br>
                        <table width=100% border=1>
                        <tr>
                           <th align=center valign=top>Data controllo</th>
                           <th align=left   valign=top>Cod.Imp.</th>
                           <th align=center valign=top>Data ins.</th>
                           <th align=left   valign=top>Responsabile</th>
                           <th align=left   valign=top>Comune</th>
                           <th align=left   valign=top>Indirizzo</th>
                           <th align=left   valign=top>Rif./N. bollino</th>
                           <th align=left   valign=top>Costo</th>
                           <th align=left   valign=top>Fascia potenza</th>
                        </tr>"
		    }
		    
		    if {[string is space $cod_impianto_est]} {
			set cod_impianto_est "&nbsp;"
		    }
		    if {[string is space $data_ins_edit]} {
			set data_ins_edit    "&nbsp;"
		    }
		    if {[string is space $resp]} {
			set resp             "&nbsp;"
		    }
		    if {[string is space $comune]} {
			set comune           "&nbsp;"
		    }
		    if {[string is space $indir]} {
			set indir            "&nbsp;"
		    }
		    if {[string is space $riferimento_pag]} {
			set riferimento_pag  "&nbsp;"
		    }
		    if {[string is space $costo]} {
			set costo  "&nbsp;"
		    }
		    if {[string is space $descr_potenza]} {
			set descr_potenza  "&nbsp;"
		    }
		    
		    append righe_stampa "
                    <tr>
                       <td align=center valign=top>$data_controllo_edit</td>
                       <td align=left   valign=top>$cod_impianto_est</td>
                       <td align=center valign=top>$data_ins_edit</td>
                       <td align=left   valign=top>$resp</td>
                       <td align=left   valign=top>$comune</td>
                       <td align=left   valign=top>$indir</td>
                       <td align=left   valign=top>$riferimento_pag</td>
                       <td align=left   valign=top>$costo</td>
                       <td align=left   valign=top>$descr_potenza</td>
                   </tr>"

		    set cod_docu_distinta $cod_documento
		    db_dml upd_dimp ""
		}
		puts $file_id2 $righe_stampa
		close $file_id2
		
		# creo il file pdf
		iter_crea_pdf [list exec htmldoc --webpage --header ... --footer ... --quiet --bodyfont arial --fontsize 10 --headfootfont arial --headfootsize 10 --landscape --top 2.5cm --bottom 2cm --left 2cm --right 2cm -f $file_pdf2 $file_html2]
		
		# cancello il file temporaneo creato
		ns_unlink     $file_html2
		
		#   cod_documento e' gia' valorizzato con db_string sel_docu_s
		set cod_soggetto  $f_cod_manu
		set tipo_soggetto     "M"
		set tipo_documento    "DC"
		set cod_impianto      ""
		set data_documento    $sysdate
		set data_stampa       $sysdate
		set data_ins          $sysdate
		set data_mod          $sysdate
		set utente            $id_utente
			    
		db_dml ins_docu ""
		
		# controllo se il Database e' Oracle o Postgres
		set id_db             [iter_get_parameter database]
		set tipo_contenuto    [ns_guesstype $file_pdf2]
		set contenuto_tmpfile $file_pdf2
		
		if {$id_db == "postgres"} {
		    db_dml upd_docu_ins_dist ""
		} else {
		    db_dml upd_docu_ins_dist "" -blob_files [list $contenuto_tmpfile]
		}
		
		append righe_stampa "
                </table>
                <!-- PAGE BREAK -->"
		append stampa_tot $righe_stampa		
	    }
	}
    }
} {
    iter_return_complaint "Spiacente, ma il DBMS ha restituito il
    seguente messaggio di errore <br><b>$error_msg</b><br>
    Contattare amministratore di sistema e comunicare il messaggio
    d'errore. Grazie."
}

puts $file_id_tot $stampa_tot
close $file_id_tot

# creo il file pdf
iter_crea_pdf [list exec htmldoc --webpage --header ... --footer ... --quiet --bodyfont arial --fontsize 10 --headfootfont arial --headfootsize 10 --landscape --top 2.5cm --bottom 2cm --left 2cm --right 2cm -f $file_pdf_tot $file_html_tot]

ns_unlink     $file_html_tot

ad_returnredirect $file_pdf_url_tot
ad_script_abort
