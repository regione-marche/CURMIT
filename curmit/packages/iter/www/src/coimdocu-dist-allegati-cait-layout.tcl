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
	{cod_legale_rapp	""}
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

set page_title      "Stampa distinta allegati H, I, L"
set context_bar     [iter_context_bar -nome_funz $nome_funz_caller]

# preparo link per ritorno alla lista distinte:
set link_docu_dist_list   [export_url_vars caller nome_funz_caller nome_funz]&[iter_set_url_vars $extra_par]



# imposto la directory degli spool ed il loro nome.
set spool_dir       [iter_set_spool_dir]
set spool_dir_url   [iter_set_spool_dir_url]



set nome_file_tot    "Stampa distinta allegati HIL"
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
set nome_ente    		$coimdesc(nome_ente)
set tipo_ufficio_ente 	$coimdesc(tipo_ufficio)
set assessorato_ente	$coimdesc(assessorato)
set indirizzo_ente	    $coimdesc(indirizzo)
set telefono_ente   	$coimdesc(telefono)

# imposto la query SQL 
# scrivo due query diverse a seconda se c'e' o meno il viario
iter_get_coimtgen
if {$coimtgen(flag_viario) == "T"} {
    set nome_col_toponimo  "e.descr_topo"
    set nome_col_via       "e.descrizione"
    if {[iter_get_parameter database] == "postgres"} {
		set from_coimviae  "left outer join coimviae e on e.cod_comune = a.cod_comune and e.cod_via = a.cod_via"
    } else {
		set from_coimviae  "  , coimviae e"
		set where_coimviae "  and e.cod_comune (+)= a.cod_comune and e.cod_via (+)= a.cod_via"
    }
} else {
    set nome_col_toponimo  "a.toponimo"
    set nome_col_via       "a.indirizzo"
    set from_coimviae      ""
    set where_coimviae     ""
}

set lista_manu ""
#if {[string equal $f_cod_manu ""] && [string equal $cod_legale_rapp ""]} {
#    db_foreach sel_codici_manu "" {
#		lappend lista_manu [list $f_cod_manu]
#    }
#} else
if {![string equal $f_cod_manu ""]} {
    lappend lista_manu [list $f_cod_manu]
	set where_cod_manu " a.cod_manutentore= :f_cod_manu"
} elseif {![string equal $cod_legale_rapp ""]} {
	lappend lista_manu [list ""]
	set where_cod_manu " a.cod_manutentore is null and cod_legale_rapp = :cod_legale_rapp"
}
with_catch error_msg {
    db_transaction {
		foreach manutentore $lista_manu {
            set f_cod_manu [lindex $manutentore 0]
			set lista_all	[db_list_of_lists sel_allegati ""]
			set ctr_rec     [llength $lista_all]
			if {$ctr_rec == 0} {
				iter_return_complaint "Nessun dato corrisponde ai criteri impostati"
				return
		    }
			
			set note "nota:
						La trasmissione per via telematica delle dichiarazioni e delle comunicazioni di cui sopra deve essere 
						finalizzata non oltre la fine del mese successivo a quello della redazione originale. La trasmissione 
						per via telematica non sostituisce la compilazione di una copia autentica dei moduli che deve comunque 
						essere inviata all’Ente competente. Sono disponibili sul portale Curit i moduli in bianco da stamparsi 
						e compilarsi in originale a cura dei soggetti incaricati"
			
		    if {$ctr_rec > 0} {
				set mese_rif ""
				set anno_rif ""
				foreach riga_all $lista_all {
				  
				    util_unlist $riga_all cod_as_resp flag_tracciato cod_impianto_est data_ins_edit responsabile comune indirizzo potenza
	
				    set mese_controllo [string range $data_ins_edit 3 4]
				    set anno_controllo [string range $data_ins_edit 6 9]
		
				    if {[string equal $mese_rif ""]
		                        || $mese_rif != $mese_controllo
		                        || $anno_rif != $anno_controllo} {
						    
						if {![string equal $mese_rif ""]} {
							append righe_stampa "\
										</table>
										<table><tr><td align=\"justify\"><small>$note</small></td></tr></table>"
							puts $file_id $righe_stampa
						    close $file_id
						    
						    # creo il file pdf
						    iter_crea_pdf [list exec htmldoc --webpage --header ... --footer ... --quiet --bodyfont arial --fontsize 10 --headfootfont arial --headfootsize 10 --landscape --top 2.5cm --bottom 2cm --left 2cm --right 2cm -f $file_pdf $file_html]
						    
						    # cancello il file temporaneo creato
						    ns_unlink     $file_html
						    
						    #   cod_documento e' gia' valorizzato con db_string sel_docu_s
						   	if {![string equal $f_cod_manu ""]} {
							    set cod_soggetto  	$f_cod_manu
								set tipo_soggetto 	"M"
							} elseif {![string equal $cod_legale_rapp ""]} {
								set cod_soggetto	$cod_legale_rapp
								set tipo_soggetto	"C"
							}
							set tipo_documento    "DA"
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
										<!-- PAGE BREAK -->"
						    append stampa_tot $righe_stampa
						}
		
						set righe_stampa 	""
						set mese_rif 		$mese_controllo
						set anno_rif 		$anno_controllo
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
										
						set nome_file       "Stampa distinta allegati HIL di $nome_mese"
						set nome_file       [iter_temp_file_name $nome_file]
						set file_html       "$spool_dir/$nome_file.html"
						set file_pdf        "$spool_dir/$nome_file.pdf"
						set file_pdf_url    "$spool_dir_url/$nome_file.pdf"
						
						set file_id [open $file_html w]
						fconfigure $file_id -encoding iso8859-1
			
						append righe_stampa "
									<!-- FOOTER LEFT   \"$sysdate_edit\"-->
			                        <!-- FOOTER CENTER \"Distinta allegati H,I,L\"-->
			                        <!-- FOOTER RIGHT  \"Pagina \$PAGE(1) di \$PAGES(1)\"--> "
						
						append righe_stampa "
			                        <table width=100%>
			                              <tr>
			                                 <td align=center>$nome_ente</td>
			                              </tr>
			                              <tr>
			                                 <td align=center>$tipo_ufficio_ente</td>
			                              </tr>
			                              <tr>
			                                 <td align=center>$assessorato_ente</td>
			                              </tr>
			                              <tr>
			                                 <td align=center><small>$indirizzo_ente</small></td>
			                              </tr>
			                              <tr>
			                                 <td align=center><small>$telefono_ente</small></td>
			                              </tr>
			                        </table>"
						
						if {![string equal $f_cod_manu ""]} {
							db_1row sel_manu ""
							set uten_cognome_nome "Manutentore: <b>$manu_cognome $manu_nome</b>"
						} elseif {![string equal $cod_legale_rapp ""]} {
							db_1row sel_legale ""
							set uten_cognome_nome "Amministratore: <b>$cognome_legale $nome_legale</b>"
						} 
									
						set cod_documento [db_string sel_docu_s ""]
						db_1row sel_count_mese "select count(*) as ctr_rec_mese
			                                    from coim_as_resp a
												where $where_cod_manu
												and a.utente = :id_utente
			                                    and substr(a.data_ins, 6, 2) = :mese_controllo
			                                    and substr(a.data_ins, 1, 4) = :anno_controllo
												and a.cod_docu_distinta is null"
						
						append righe_stampa "
			                        <br>
			                        <h2>Distinta allegati H,I,L n. $cod_documento del $sysdate_edit - Mese di $nome_mese</h2>
			                        $uten_cognome_nome - Numero allegati: $ctr_rec_mese
			                        <br>
			                        <br>"
			
						append righe_stampa "
			                        <table width=100% border=1>
			                            <tr>
			                                <th align=center valign=top>Tipo allegato</th>
			                                <th align=left   valign=top>Cod. imp.</th>
			                                <th align=center valign=top>Data ins.</th>
			                                <th align=left   valign=top>Propriet&agrave;</th>
			                                <th align=left   valign=top>Comune</th>
			                                <th align=left   valign=top>Indirizzo</th>
			                                <th align=center valign=top>Potenza</th>
			                            </tr>"	
				    }
						
					if {[string is space $cod_impianto_est]} {
						set cod_impianto_est	"&nbsp;"
				    }
				    if {[string is space $data_ins_edit]} {
						set data_ins_edit	    "&nbsp;"
				    }
				    if {[string is space $responsabile]} {
						set responsabile 		"&nbsp;"
				    }
				    if {[string is space $comune]} {
						set comune           	"&nbsp;"
				    }
				    if {[string is space $indirizzo]} {
						set indirizzo			"&nbsp;"
				    }
				    if {[string is space $potenza]} {
						set potenza			  	"&nbsp;"
				    }
		
				    append righe_stampa "
		                            <tr>
		                                <td align=center valign=top>$flag_tracciato</td>
		                                <td align=left   valign=top>$cod_impianto_est</td>
		                                <td align=center valign=top>$data_ins_edit</td>
		                                <td align=left   valign=top>$responsabile</td>
		                                <td align=left   valign=top>$comune</td>
		                                <td align=left   valign=top>$indirizzo</td>
		                                <td align=center valign=top>$potenza</td>
		                            </tr>"
					set cod_docu_distinta 	$cod_documento
				    db_dml upd_as_resp		""
				}
				append righe_stampa "\
									</table>
									<table><tr><td align=\"justify\"><small>$note</small></td></tr></table>"
				puts $file_id $righe_stampa
				close $file_id
				
				# creo il file pdf
				iter_crea_pdf [list exec htmldoc --webpage --header ... --footer ... --quiet --bodyfont arial --fontsize 10 --headfootfont arial --headfootsize 10 --landscape --top 2.5cm --bottom 2cm --left 2cm --right 2cm -f $file_pdf $file_html]
				
				# cancello il file temporaneo creato
				ns_unlink     $file_html
				
				#   cod_documento e' gia' valorizzato con db_string sel_docu_s
				if {![string equal $f_cod_manu ""]} {
				    set cod_soggetto  	$f_cod_manu
					set tipo_soggetto 	"M"
				}  elseif {![string equal $cod_legale_rapp ""]} {
					set cod_soggetto	$cod_legale_rapp
					set tipo_soggetto	"C"
				}
				set tipo_documento  "DA"
				set cod_impianto    ""
				set data_documento  $sysdate
				set data_stampa     $sysdate
				set data_ins        $sysdate
				set data_mod        $sysdate
				set utente          $id_utente
				
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
# cancello il file temporaneo creato
ns_unlink     $file_html_tot

ad_returnredirect $file_pdf_url_tot
ad_script_abort
			
			
