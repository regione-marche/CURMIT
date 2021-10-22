ad_proc iter_cari_manu {
    {
	-cod_batc      ""
	-id_utente     ""
	-cod_cinc      ""
	-file_name     ""
    }
} {
    Elaborazione     Caricamento controlli/modelli per manutentori
    @author          Gianni Prosperi
    @creation-date   28/08/2007
    @cvs-id          iter_cari_manu
    
    se swc_solo_aimp vale "S" allora non si creano i controlli

    USER  DATA       MODIFICHE
    ===== ========== ==========================================================================
    sim04 22/05/2017 Personaliz. per Comune di Jesi: ricodificare gli impianti come da Legge
    sim04            Reg. Marche CMJE.
    sim04            Per Comune di Senigalli: CMSE

    gab01 12/04/2017 Gestito cod_impianto_est per provincia di Ancona

    sim03 08/02/2017 Gestito cod_impianto_est per Ancona

    sim02 28/09/2016 Taranto ha il cod. impianto composto dalle ultime 3 cifre del codice istat
    sim02            + un progressivo

    nic01 04/02/2016 Gestito coimtgen.lun_num_cod_impianto_est per regione MARCHE

    sim01 28/09/2015 Da ottobre 2015 gli enti della regione marche devono costruire il codice
    sim01            impianto con una sigla imposta dalla regione (es: CMPS) + un progressivo
    sim01            di 6 cifre.
} {
    # aggiorno stato di coimbatc
    iter_batch_upd_flg_sta -iniz $cod_batc


    ns_log Notice "Valentina - Inizio della procedura iter_cari_manu"
    
    with_catch error_msg {
	#   db_transaction {
	
	# reperisco le colonne della tabella parametri
	iter_get_coimtgen
	set flag_cod_aimp_auto  $coimtgen(flag_cod_aimp_auto)
	set flag_codifica_reg   $coimtgen(flag_codifica_reg)
	set lun_num_cod_imp_est $coimtgen(lun_num_cod_imp_est);#nic01
	
	set stato_tgen [db_string sel_stato_tgen "select cod_imst_cari_manu as stato_tgen from coimtgen"]
	set flag_scarta_via_nt [db_string sel_stato_tgen "select flag_scarta_via_nt from coimtgen"]
	set flag_cod_imp_obblig [db_string sel_stato_tgen "select flag_cod_imp_obblig from coimtgen"]
	set flag_portafoglio [db_string sel_tgen_portafoglio "select flag_portafoglio from coimtgen"]
	
	# valorizzo la data_corrente (serve per l'inserimento)
	set data_corrente  [iter_set_sysdate]
	
	set permanenti_dir [iter_set_permanenti_dir]
	set permanenti_dir_url [iter_set_permanenti_dir_url]
	set file_inp_name  "Caricamento-manutentori-input"
	set file_inp_name  [iter_temp_file_name -permanenti $file_inp_name]
	set file_esi_name  "Caricamento-manutentori-esito"
	set file_esi_name  [iter_temp_file_name -permanenti $file_esi_name]
	set file_out_name  "Caricamento-manutentori-motivi-scarto"
	set file_out_name  [iter_temp_file_name -permanenti $file_out_name]
	set file_err_name  "Caricamento-manutentori-scartati"
	set file_err_name  [iter_temp_file_name -permanenti $file_err_name]
	
	# salvo i file di output come .txt in modo che excel permetta di
	# indicare il formato delle colonne (testo) al momento
	# dell'importazione del file.
	# in caso contrario i numeri di telefono rimarrebbero senza lo zero
	# ed i civici 8/10 diverrebbero una data!
	# bisogna fare in modo che excel apra correttamente il file
	# degli scarti perche' l'utente potrebbe correggere gli errori
	# e provare a ricaricarli.
	set file_inp       "${permanenti_dir}/$file_inp_name.csv"
	set file_esi       "${permanenti_dir}/$file_esi_name.adp"
	set file_out       "${permanenti_dir}/$file_out_name.txt"
	set file_err       "${permanenti_dir}/$file_err_name.txt"
	set file_inp_url   "${permanenti_dir_url}/$file_inp_name.csv"
	# in file_esi_url non metto .adp altrimenti su vestademo non
	# viene trovata la url!!
	set file_esi_url   "${permanenti_dir_url}/$file_esi_name"
	set file_out_url   "${permanenti_dir_url}/$file_out_name.txt"
	set file_err_url   "${permanenti_dir_url}/$file_err_name.txt"
	
	# rinomino il file (che per ora ha lo stesso nome di origine)
	# con un nome legato al programma ed all'ora di esecuzione
	exec mv $file_name $file_inp
	
	# apro il file in lettura e metto in file_inp_id l'identificativo
	# del file per poterlo leggere successivamente
	if {[catch {set file_inp_id [open $file_inp r]}]} {
	    iter_return_complaint "File csv di input non aperto: $file_inp"
	}
	# dichiaro di leggere in formato iso West European e di utilizzare
	# crlf come fine riga (di default andrebbe a capo anche con gli
	# eventuali lf contenuti tra doppi apici).
	#fconfigure $file_inp_id -encoding iso8859-15 -translation crlf
	fconfigure $file_inp_id -encoding iso8859-1
	
	# apro il file in scrittura e metto in file_esi_id l'identificativo
	# del file per poterlo scrivere successivamente
	if {[catch {set file_esi_id [open $file_esi w]}]} {
	    iter_return_complaint "File di esito caricamento non aperto: $file_esi"
	}
	# dichiaro di scrivere in formato iso West European
	fconfigure $file_esi_id -encoding iso8859-1 -translation crlf
	
	# apro il file in scrittura e metto in file_out_id l'identificativo
	# del file per poterlo scrivere successivamente
	if {[catch {set file_out_id [open $file_out w]}]} {
	    iter_return_complaint "File csv dei record caricati non aperto: $file_out"
	}
	# dichiaro di scrivere in formato iso West European
	fconfigure $file_out_id -encoding iso8859-1 -translation crlf
	
	# apro il file in scrittura e metto in file_err_id l'identificativo
	# del file per poterlo scrivere successivamente
	if {[catch {set file_err_id [open $file_err w]}]} {
	    iter_return_complaint "File csv dei record scartati non aperto: $file_err"
	}
	# dichiaro di scrivere in formato iso West European
	fconfigure $file_err_id -encoding iso8859-1
	
	
	# Scrivo la procedura che controllerà l'esistenza o meno nel db dei cittadini
	# e ne curerà l'eventuale inserimento
	set citt_control {
	    if {[string equal $nome_citt_chk ""]} {
		set where_nome_chk " and nome is null"
	    } else {
		set where_nome_chk " and upper(nome) = upper(:nome_citt_chk)"
	    }
	    if {[string equal $indirizzo_citt_chk ""]} {
		set where_indirizzo_chk " and indirizzo is null"
	    } else {
		set where_indirizzo_chk " and upper(indirizzo) = upper(:indirizzo_citt_chk)"
	    }
	    if {[string equal $comune_citt_chk ""]} {
		set where_comune_chk " and comune is null"
	    } else {
		set where_comune_chk " and upper(comune) = upper(:comune_citt_chk)"
	    }
	    if {[string equal $provincia_citt_chk ""]} {
		set where_provincia_chk " and provincia is null"
	    } else {
		set where_provincia_chk " and upper(provincia) = upper(:provincia_citt_chk)"
	    }
	    if {[db_0or1row sel_citt_check ""] == "0"} {
		db_1row sel_dual_cod_citt ""
		db_dml ins_citt ""
		incr citt_insered
		#       ns_log notice "AAAA - codice: $cod_citt - cognome: $cognome_citt_chk - NOME $where_nome_chk $nome_citt_chk
		#                                                      - INDIRIZZO $where_indirizzo_chk $indirizzo_citt_chk
		#                                                      - COMUNE $where_comune_chk $comune_citt_chk
		#                                                      - PROVINCIA $where_provincia_chk $provincia_citt_chk"
	    } else {
		set cod_citt [db_string sel_citt_check ""]
	    }
	}
	
	
	# Scrivo la sottoprocedura di controllo integrità dei singoli campi
	set controllo_integrita {
	    switch $type {
		date {
		    if {[string equal $colonna ""]} {
			# Se è vuoto e non obbligatorio non faccio niente, se è obbligatorio
			# ho già controllato prima
		    } else {
				if {$colonna == "0000-00-00" || $colonna == "0"} {
				    set colonna "19000101"
				    set file_inp_ok_list [lreplace $file_inp_ok_list $i $i $colonna]
				}
				set colonna [string map {- ""}  $colonna]
				#ns_log Notice "$col_name ||$colonna || $date<br>"
				set date [iter_edit_date $colonna]              
				if {[iter_check_date $date] == "0"} {
				    set file_inp_ok_list [lreplace $file_inp_ok_list $i $i ""]
				    append riserva_log "Modificato $denominazione da $colonna a null,"
				    append err_log "Il valore $denominazione ($colonna) deve essere una data,"
				    incr err_count
				    incr err_riserva
				}
		    }
		}
		numeric {
		    if {[string equal $colonna ""]} {
			# Se è vuoto e non obbligatorio non faccio niente, se è obbligatorio
			# ho già controllato prima
		    } else {
			
				set int_dec [split $dimension \,]
				util_unlist $int_dec intero decimale
				if {[iter_edit_num $colonna $decimale] != "Error"} {
				    
				    set element_int_dec [split $colonna \.]
				    util_unlist $element_int_dec parte_intera parte_decimale
				    set max_value [expr pow(10,[expr $intero - $decimale]) - 1]
				    
				    if {($parte_intera > [expr $max_value - 1]) || ($parte_intera < [expr (-1 * $max_value) +1])} {
					set file_inp_ok_list [lreplace $file_inp_ok_list $i $i ""]
					append riserva_log "Modificato $denominazione da $colonna a null,"
					append err_log "Il campo $denominazione ($colonna) deve essere numerico di [expr $intero-$decimale] cifre,"
					incr err_count
					incr err_riserva
				    } else {
					
					if {![string equal $range_value ""]} {
					    set range_list [split $range_value \,]
					    set num_range [llength $range_list]
					    
					    set x 0
					    set ok_range 0
					    while {$x < $num_range} {
						if {$colonna == [lindex $range_list $x]} {
						    incr ok_range
						}
						incr x
					    }
					    if {$ok_range == 0} {
						set file_inp_ok_list [lreplace $file_inp_ok_list $i $i $default_value]
						append riserva_log "Modificato $denominazione da $colonna a $default_value,"
						append err_log "Il campo $denominazione ($colonna) deve assumere uno dei seguenti valori: '$range_value' ,"
						incr err_count
						incr err_riserva
					    }               
					}
				    }                            
				    set max_value [expr pow(10,$decimale)]
				    if {($parte_decimale > [expr $max_value - 1])} {
					set file_inp_ok_list [lreplace $file_inp_ok_list $i $i ""]
					append riserva_log "Modificato $denominazione da $colonna a null,"
					append err_log "Il campo $denominazione ($colonna) deve avere $decimale cifre decimali,"
					incr err_count
					incr err_riserva
				    } else {            
					if {![string equal $range_value ""]} {
					    set range_list [split $range_value \,]
					    set num_range [llength $range_list]
					    
					    set x 0
					    set ok_range 0
					    while {$x < $num_range} {
						if {$colonna == [lindex $range_list $x]} {
						    incr ok_range
						}
						incr x
					    }
					    if {$ok_range == 0} {
						set file_inp_ok_list [lreplace $file_inp_ok_list $i $i $default_value]
						append riserva_log "Modificato $denominazione da $colonna a $default_value,"
						append err_log "Il campo $denominazione ($colonna) deve assumere uno dei seguenti valori: '$range_value' ,"
						incr err_count
						incr err_riserva
					    }   
					}   
				    }
				    
				} else {
				    set file_inp_ok_list [lreplace $file_inp_ok_list $i $i ""]
				    append riserva_log "Modificato $denominazione da $colonna a null,"
				    append err_log "Il campo $denominazione ($colonna) deve essere un numero,"
				    incr err_count
				    incr err_riserva
				}
		    }
		}
		varchar {
		    if {[string equal $colonna ""]} {
			# Se è vuoto e non obbligatorio non faccio niente, se è obbligatorio
			# ho già controllato prima
		    } else {
				set colonna [string toupper $colonna]
				set colonna_length [string length $colonna]
				if {$colonna_length > $dimension} {
				    set file_inp_ok_list [lreplace $file_inp_ok_list $i $i ""]
				    append riserva_log "Modificato $denominazione da $colonna a null,"
				    append err_log "Il campo $denominazione ($colonna) deve essere al massimo di $dimension caratteri,"
				    incr err_count
				    incr err_riserva
				} else {
				    
				    if {![string equal $range_value ""]} {
						set range_list [split $range_value \,]
						set num_range [llength $range_list]
						
						set x 0
						set ok_range 0
						while {$x < $num_range} {
						    if {$colonna == [lindex $range_list $x]} {
								incr ok_range
						    }
						    incr x
						}
						if {$ok_range == 0} {
						    set file_inp_ok_list [lreplace $file_inp_ok_list $i $i $default_value]
						    append riserva_log "Modificato $denominazione da $colonna a $default_value,"
						    append err_log "Il campo $denominazione ($colonna) deve assumere uno dei seguenti valori: '$range_value' ,"
						    incr err_count
						    incr err_riserva
						}
				    }
				}
		    }
		}
	    }
	    # Fine del controllo
	}
	
	# Scrivo la procedura che controlla o meno l'esistenza dell'impianto
	set controllo_inserimento_aimp {
	    ns_log Notice "Inizio analisi impianto $cod_impianto_est"
	    set count 0
	    set flag_new_aimp "F"
	    foreach column_name $file_cols {
		set $column_name [lindex $file_inp_ok_list $count]
		incr count
	    }
	    
	    set err_count 0
	    set msg_errore ""
	    
	    if {[string length $interno] > 3} {
		set interno [string range $interno 0 2]
	    }
	    set cod_comune_chk ""
	    set where_comune ""
	    set comune [string toupper $comune]
	    if {![info exist comuni($comune)]} {
		set where_comune "and cod_comune = ''"
	    } else {
		set cod_comune_chk [db_string sel_cod_comu "select cod_comune as cod_comune_chk from coimcomu where denominazione = :comune"]
		set where_comune "and cod_comune = :cod_comune_chk"
	    }
	    
	    # Cerco di ricavare dal campo indirizzo toponimo e via
	    set toponimo_chk $toponimo
	    set indirizzo_chk $indirizzo
	    set numero_chk $civico
	    
	    set msg_err "" 
	    
	    set flag_via ""
	    set cod_via ""
	    set where_indirizzo ""
	    if {$coimtgen(flag_viario) == "F"} {
		set where_indirizzo "and upper(a.toponimo) = upper(:toponimo_chk)
	                             and upper(a.indirizzo) = upper(:indirizzo_chk)"
	    } else {
		if {[db_0or1row sel_viae_check ""] == 0} {
		    set where_indirizzo "and upper(a.toponimo) = upper(:toponimo_chk)
		                         and upper(a.indirizzo) = upper(:indirizzo_chk)"
		    
		    if {$flag_scarta_via_nt == "N"} {
			set flag_via "F"
		    } else {
			incr err_count
			append msg_errore "Via inesistente nel viario "
		    }
		} else {
		    set where_indirizzo "and a.cod_via = :cod_via"
		    set flag_via "T"
		}
	    }
	    
	    if {[string equal $cod_impianto_est ""]} {
	        
		set nome_citt_chk $nome_resp
		set cognome_citt_chk $cognome_resp
		set indirizzo_citt_chk $indirizzo_resp
		set comune_citt_chk $comune_resp
		set provincia_citt_chk $provincia_resp
		set natura_citt_chk $natura_giuridica_resp
		set telefono_citt_chk $telefono_resp
		set cod_fiscale_citt_chk $cod_fiscale_resp
		if {[string equal $nome_citt_chk ""]} {
		    set where_nome_chk " and nome is null"
		} else {
		    set where_nome_chk " and nome = :nome_citt_chk"
		}
		if {[string equal $indirizzo_citt_chk ""]} {
		    set where_indirizzo_chk " and indirizzo is null"
		} else {
		    set where_indirizzo_chk " and indirizzo = :indirizzo_citt_chk"
		}
		if {[string equal $comune_citt_chk ""]} {
		    set where_comune_chk " and comune is null"
		} else {
		    set where_comune_chk " and comune = :comune_citt_chk"
		}
		if {[string equal $provincia_citt_chk ""]} {
		    set where_provincia_chk " and provincia is null"
		} else {
		    set where_provincia_chk " and provincia = :provincia_citt_chk"
		}
		
		set matricola_chk $matricola
		set modello_chk   $modello
		if {[db_0or1row sel_cost "select cod_cost as cod_cost from coimcost where upper(descr_cost) = upper(:marca)  limit 1"] == 0} {
		    incr err_count
		    append msg_errore "L'impianto è privo di codice: marca inesistente database"
		} else {
		    set cod_cost [db_string sel_cost "select cod_cost as cod_cost from coimcost where upper(descr_cost) = upper(:marca)  limit 1"]
		    
		    db_1row sel_aimp_check_no_cod_count ""
		    if {$conta_impianti > 1} {
			incr err_count
			append msg_errore "Trovati piu impianti con stessa matricola, indirizzo, costruttore"
		    } else {
			if {[db_0or1row sel_aimp_check_no_cod ""] == "0"} {
			    #incr err_count
			    #append msg_errore "L'impianto è privo di codice: non è stato trovato nel database"
			    set flag_new_aimp "T"
			} else {
			    db_1row sel_aimp_no_cod ""
			    set flag_new_aimp "F"
			}
		    }
		}
		
		# Preparo l'inserimento dell'impianto con una serie di controlli
		# Controllo sul comune dell'impianto
		set cod_comune_chk ""
		set comune [string toupper $comune]
		if {![info exist comuni($comune)]} {
		    incr err_count
		    append msg_errore "Comune $comune inesistente nel database; "
		} else {
		    set cod_comune_chk $comuni($comune)
		}
		
		# Controllo sulla provincia dell'impianto
		set provincia [string toupper $provincia]
		set sigla_prov $coimtgen(sigla_prov)
		set denom_prov [db_string sel_provincia "select denominazione as denom_prov from coimprov where sigla = :sigla_prov"]
		set cod_prov_chk ""
		if {$coimtgen(sigla_prov) == $provincia
		||  $denom_prov == $provincia} {
		    set cod_prov_chk $province($provincia)
		} else {
		    incr err_count
		    append msg_errore "Provincia $provincia non di competenza dell'ente; "
		}
		
		# Controllo sul combustibile
		set cod_comb_chk ""
		set combustibile [string toupper $combustibile]
		if {$combustibile == "0"} {
		    set cod_comb_chk "0"
		} else {
		    if {![info exist combustibili($combustibile)]} {
			incr err_count
			append msg_errore "Combustibile $combustibile inesistente; "
		    } else {
			set cod_comb_chk $combustibili($combustibile)
		    }
		}
		
		# Controllo l'esattezza del manutentore
		# Se l'utente è amministratore non effettuo il controllo, altrimenti si
		db_1row sel_utente_status ""
		if {($user_sett == "system") && ($user_ruol == "admin")} {
		    if {[db_0or1row sel_manu_check ""] == 0} {
			incr err_count
			append msg_errore "Manutentore non presente nel database; "
		    }
		} else {
		    set cod_manutentore_chk [iter_check_uten_manu $id_utente]
		    if {[string equal $cod_manutentore_chk ""] || $cod_manutentore_chk != $cod_manutentore} {
			# Errore, manutentore inesistente o errato
			incr err_count
			append msg_errore "Utente non collegato a nessun manutentore o manutentore inesistente; " 
		    }
		}
		
		if {$err_count == 0} {
		    # Controllo sui cittadini da inserire o meno
		    # Proprietario
		    set nome_citt_chk $nome_prop
		    set cognome_citt_chk $cognome_prop
		    set indirizzo_citt_chk $indirizzo_prop
		    set comune_citt_chk $comune_prop
		    set provincia_citt_chk $provincia_prop
		    set natura_citt_chk $natura_giuridica_prop
		    set telefono_citt_chk $telefono_pop
		    set cod_fiscale_citt_chk $cod_fiscale_prop
		    if {![string equal $cognome_citt_chk ""]} {
			eval $citt_control
			set cod_proprietario $cod_citt
		    } else {
			set cod_proprietario ""
		    }
		    # Occupante
		    set nome_citt_chk $nome_occu
		    set cognome_citt_chk $cognome_occu
		    set indirizzo_citt_chk $indirizzo_occu
		    set comune_citt_chk $comune_occu
		    set provincia_citt_chk $provincia_occu
		    set natura_citt_chk $natura_giuridica_occu
		    set telefono_citt_chk $telefono
		    set cod_fiscale_citt_chk $cod_fiscale_occu
		    if {![string equal $cognome_citt_chk ""]} {
			eval $citt_control
			set cod_occupante $cod_citt
		    } else {
			set cod_occupante ""
		    }
		    # Intestatario
		    set nome_citt_chk $nome_int
		    set cognome_citt_chk $cognome_int
		    set indirizzo_citt_chk $indirizzo_int
		    set comune_citt_chk $comune_int
		    set provincia_citt_chk $provincia_int
		    set natura_citt_chk $natura_giuridica_int
		    set telefono_citt_chk $telefono_int
		    set cod_fiscale_citt_chk $cod_fiscale_int
		    if {![string equal $cognome_citt_chk ""]} {
			eval $citt_control
			set cod_intestatario $cod_citt
		    } else {
			set cod_intestatario ""
		    }
		    # Controllo chi è il responsabile: se il responsabile non coincide lo registro come terzo responsabile
		    set flag_resp ""
		    set cod_responsabile ""
		    if {![string equal $cognome_resp ""]} {
			if {($nome_resp == $nome_prop) && ($cognome_resp == $cognome_prop)} {
			    set flag_resp "P"
			    set cod_responsabile $cod_proprietario
			} else {
			    if {($nome_resp == $nome_occu) && ($cognome_resp == $cognome_occu)} {
				set flag_resp "O"
				set cod_responsabile $cod_occupante
			    } else {
				if {($nome_resp == $nome_int) && ($cognome_resp == $cognome_int)} {
				    set flag_resp "I"
				    set cod_responsabile $cod_intestatario
				} else {
				    set nome_citt_chk $nome_resp
				    set cognome_citt_chk $cognome_resp
				    set indirizzo_citt_chk $indirizzo_resp
				    set comune_citt_chk $comune_resp
				    set provincia_citt_chk $provincia_resp
				    set natura_citt_chk $natura_giuridica_resp
				    set telefono_citt_chk $telefono_resp
				    set cod_fiscale_citt_chk $cod_fiscale_resp
				    if {![string equal $cognome_citt_chk ""]} {
					eval $citt_control
					set cod_terzi $cod_citt
					set flag_resp "T"
					set cod_responsabile $cod_terzi
				    }
				}
			    }
			}
		    } else {
			if {![string equal $cognome_occu ""]} {
			    set flag_resp "O"
			    set cod_responsabile $cod_occupante
			} else {
			    if {![string equal $cognome_prop ""]} {
				set flag_resp "P"
				set cod_responsabile $cod_proprietario
			    } else {
				incr err_count
				append msg_errore "Nessun soggetto valorizzato (responsabile, occupante, proprietario)" 
			    }
			}
		    }
		}
		
		if {$err_count == 0} {
		    db_transaction {
			if {$flag_new_aimp == "T"} {
			    if {$flag_scarta_via_nt == "N"} {
				if {$flag_via == "F"} {
				    # Inserisco la nuova via
				    ns_log Notice "Inserisco una nuova via"
				    db_1row sel_dual_cod_via ""
				    db_dml ins_viae ""
				}
			    }
			    # Assegno cod_impianto
			    ns_log Notice "Inserisco un nuovo impianto"
			    db_1row sel_dual_cod_impianto ""
			    if {[string equal $potenza_foc_nom ""]} {
				set potenza_foc_nom "0.00"
			    }
			    if {[string equal $potenza_utile_nom ""]} {
				set potenza_utile_nom "0.00"
			    }
			    set cod_potenza [db_string sel_pot "select coalesce(cod_potenza, '') from coimpote where potenza_min <= :potenza_foc_nom and potenza_max >= :potenza_foc_nom" -default "0"]
			    if {$flag_codifica_reg == "T"} {
                                #gab01 aggiunto || su provincia di Ancona
				#sim03 Aggiunto || su Ancona
                                if {$coimtgen(ente) eq "CPESARO" || $coimtgen(ente) eq "PPU" || $coimtgen(ente) eq "CFANO" || $coimtgen(ente) eq "CANCONA" || $coimtgen(ente) eq "PAN" || $coimtgen(ente) eq "CJESI" || $coimtgen(ente) eq "CSENIGALLIA"} {#sim01: aggiunta if ed il suo contenuto
                                    if {$coimtgen(ente) eq "CPESARO"} {
                                        set sigla_est "CMPS"
				    } elseif {$coimtgen(ente) eq "CFANO"} {
					set sigla_est "CMFA"
				    } elseif {$coimtgen(ente) eq "CANCONA"} {;#sim03
					set sigla_est "CMAN"
                                    } elseif {$coimtgen(ente) eq "PAN"} {;#gab01
					set sigla_est "PRAN"
				    } elseif {$coimtgen(ente) eq "CJESI"} {;#sim04
					set sigla_est "CMJE"
				    } elseif {$coimtgen(ente) eq "CSENIGALLIA"} {;#sim04
					set sigla_est "CMSE"
				    } else {
                                        set sigla_est "PRPU"
                                    }
				    
                                    set progressivo_est [db_string sel "select nextval('coimaimp_est_s')"]

                                    # devo fare l'lpad con una seconda query altrimenti mi va in errore
                                    #nic01 set progressivo_est [db_string sel "select lpad(:progressivo_est,6,'0')"]
				    set progressivo_est [db_string sel "select lpad(:progressivo_est,:lun_num_cod_imp_est,'0')"];#nic01

                                    set cod_impianto_est "$sigla_est$progressivo_est"
				    
                                } else {#sim01
				    # caso standard
				    if {![string equal $cod_comune ""]} {
					db_1row sel_dati_comu "
                                        select coalesce(progressivo,0) + 1 as progressivo --sim02
                                       --sim02 coalesce(lpad((progressivo + 1),7,'0'),'0000001') as progressivo
                                             , cod_istat
		                          from coimcomu
		                         where cod_comune = :cod_comune"

					#sim02 uniformato agli altri pogrammi che codificano l'impianto
					if {$coimtgen(ente) eq "PMS"} {#sim02: Riportate modifiche fatte per Massa in data 03/12/2015 per gli altri programmi dove è presente la codifica dell'impianto 
					    set progressivo [db_string query "select lpad(:progressivo, 5, '0')"]
					    set cod_istat  "[string range $cod_istat 5 6]/"
					} elseif {$coimtgen(ente) eq "PTA"} {#sim02: aggiunta if e suo contenuto
					    set progressivo [db_string query "select lpad(:progressivo, 7, '0')"]
					    set fine_istat  [string length $cod_istat]
					    set iniz_ist    [expr $fine_istat -3]
					    set cod_istat  "[string range $cod_istat $iniz_ist $fine_istat]"
					} else {#sim02
					    set progessivo [db_string query "select lpad(:progressivo, 7, '0')"];#sim01
					};#sim02

					if {![string equal $potenza_foc_nom "0.00"]
					&&  ![string equal $potenza_foc_nom ""]} {
					    if {$potenza_foc_nom < 35} {
						set tipologia "IN"
					    } else {
						set tipologia "CT"
					    }
					    #sim02 set cod_impianto_est "$cod_istat$tipologia$progressivo"
					    set cod_impianto_est "$cod_istat$progressivo";#sim02
					    db_dml upd_prog_comu "
                                            update coimcomu
                                               set progressivo = :progressivo
                                             where cod_comune  = :cod_comune"
					} else {
					    if {![string equal $cod_potenza "0"]
					    &&  ![string equal $cod_potenza ""]} { 
						switch $cod_potenza {
						    "B"  {set tipologia "IN"}
						    "A"  {set tipologia "CT"}
						    "MA" {set tipologia "CT"}
						    "MB" {set tipologia "CT"}
						}
						
						#sim02 set cod_impianto_est "$cod_istat$tipologia$progressivo"
						set cod_impianto_est "$cod_istat$progressivo";#sim02
						db_dml upd_prog_comu "
                                                update coimcomu
						   set progressivo = :progressivo
						 where cod_comune  = :cod_comune"
					    } else {
						set cod_impianto_est ""
					    }
					}
				    } else {
					set cod_impianto_est ""
				    }
				};#sim01
			    } else {
				db_1row sel_dual_cod_impianto_est ""
			    }
			    
			    db_dml ins_aimp ""
			    if {[string equal $gen_prog ""]} {
				set gen_prog 1
			    }
			    db_dml ins_gend ""
			    incr aimp_ok
			} else {
			    db_1row sel_resp_impianto ""
			    if {$cod_resp_imp != $cod_responsabile} {
				db_dml upd_resp "update coimaimp set cod_responsabile = :cod_citt where cod_impianto = :cod_impianto"
			    }
			}
		    }
		}
		
	    } else {
		
		#con il codice impianto esterno
		if {[db_0or1row sel_cost "select cod_cost as cod_cost from coimcost where upper(descr_cost) = upper(:marca)  limit 1"] == 0} {
		    incr err_count
		    append msg_errore "Marca inesistente database"
		} else {
		    set cod_cost [db_string sel_cost "select cod_cost as cod_cost from coimcost where upper(descr_cost) = upper(:marca) limit 1"]
		}
		
		if {[db_0or1row sel_aimp_check ""] == 0} {
		    set where_comune ""
		    if {[db_0or1row sel_aimp_check ""] == 1} {
			incr err_count
			append msg_errore "Impianto: $cod_impianto_est presente nel database ma con comune diverso."
		    }
		    
		    # Preparo l'inserimento dell'impianto con una serie di controlli
		    # Controllo sul comune dell'impianto
		    set cod_comune_chk ""
		    set comune [string toupper $comune]
		    if {![info exist comuni($comune)]} {
			incr err_count
			append msg_errore "Comune $comune inesistente nel database; "
		    } else {
			set cod_comune_chk $comuni($comune)
		    }
		    
		    # Controllo sulla provincia dell'impianto
		    set provincia [string toupper $provincia]
		    set sigla_prov $coimtgen(sigla_prov)
		    set denom_prov [db_string sel_provincia "select denominazione as denom_prov from coimprov where sigla = :sigla_prov"]
		    set cod_prov_chk ""
		    if {$coimtgen(sigla_prov) == $provincia
			|| $denom_prov == $provincia} {
			set cod_prov_chk $province($provincia)
		    } else {
			incr err_count
			append msg_errore "Provincia $provincia non di competenza dell'ente; "
		    }
			    
		    # Controllo sul combustibile
		    set cod_comb_chk ""
		    set combustibile [string toupper $combustibile]
		    if {$combustibile == "0"} {
			set cod_comb_chk "0"
		    } else {
			if {![info exist combustibili($combustibile)]} {
					    incr err_count
			    append msg_errore "Combustibile $combustibile inesistente; "
			} else {
			    set cod_comb_chk $combustibili($combustibile)
			}
		    }
		    
		    # Controllo l'esattezza del manutentore
		    # Se l'utente è amministratore non effettuo il controllo, altrimenti si
		    db_1row sel_utente_status ""
		    if {($user_sett == "system") && ($user_ruol == "admin")} {
			if {[db_0or1row sel_manu_check ""] == 0} {
			    incr err_count
			    append msg_errore "Manutentore non presente nel database; "
			}
		    } else {
			set cod_manutentore_chk [iter_check_uten_manu $id_utente]
			if {[string equal $cod_manutentore_chk ""] || $cod_manutentore_chk != $cod_manutentore} {
			    # Errore, manutentore inesistente o errato
			    incr err_count
			    append msg_errore "Utente non collegato a nessun manutentore o manutentore inesistente; " 
			}
		    }
		    
		    if {$err_count == 0} {
			set nome_citt_chk $nome_prop
			set cognome_citt_chk $cognome_prop
			set indirizzo_citt_chk $indirizzo_prop
			set comune_citt_chk $comune_prop
			set provincia_citt_chk $provincia_prop
			set natura_citt_chk $natura_giuridica_prop
			set telefono_citt_chk $telefono_pop
			set cod_fiscale_citt_chk $cod_fiscale_prop
			if {![string equal $cognome_citt_chk ""]} {
			    eval $citt_control
			    set cod_proprietario $cod_citt
			} else {
			    set cod_proprietario ""
			}
			# Occupante
			set nome_citt_chk $nome_occu
			set cognome_citt_chk $cognome_occu
			set indirizzo_citt_chk $indirizzo_occu
			set comune_citt_chk $comune_occu
			set provincia_citt_chk $provincia_occu
			set natura_citt_ch $natura_giuridica_occu
			set telefono_citt_chk $telefono
			set cod_fiscale_citt_chk $cod_fiscale_occu
			if {![string equal $cognome_citt_chk ""]} {
			    eval $citt_control
			    set cod_occupante $cod_citt
			} else {
			    set cod_occupante ""
			}
			# Intestatario
			set nome_citt_chk $nome_int
			set cognome_citt_chk $cognome_int
			set indirizzo_citt_chk $indirizzo_int
			set comune_citt_chk $comune_int
			set provincia_citt_chk $provincia_int
			set natura_citt_chk $natura_giuridica_int
			set telefono_citt_chk $telefono_int
			set cod_fiscale_citt_chk $cod_fiscale_int
			if {![string equal $cognome_citt_chk ""]} {
			    eval $citt_control
			    set cod_intestatario $cod_citt
			} else {
			    set cod_intestatario ""
			}
			
			# Controllo chi è il responsabile: se il responsabile non coincide lo registro come terzo responsabile
			set flag_resp ""
			set cod_responsabile ""
			if {![string equal $cognome_resp ""]} {
			    if {($nome_resp == $nome_prop) && ($cognome_resp == $cognome_prop)} {
				set flag_resp "P"
				set cod_responsabile $cod_proprietario
			    } else {
				if {($nome_resp == $nome_occu) && ($cognome_resp == $cognome_occu)} {
				    set flag_resp "O"
				    set cod_responsabile $cod_occupante
				} else {
				    if {($nome_resp == $nome_int) && ($cognome_resp == $cognome_int)} {
					set flag_resp "I"
					set cod_responsabile $cod_intestatario
				    } else {
					set nome_citt_chk $nome_resp
					set cognome_citt_chk $cognome_resp
					set indirizzo_citt_chk $indirizzo_resp
					set comune_citt_chk $comune_resp
					set provincia_citt_chk $provincia_resp
					set natura_citt_chk $natura_giuridica_resp
					set telefono_citt_chk $telefono_resp
					set cod_fiscale_citt_chk $cod_fiscale_resp
					if {![string equal $cognome_citt_chk ""]} {
					    eval $citt_control
					    set cod_terzi $cod_citt
					    set flag_resp "T"
					    set cod_responsabile $cod_terzi
					}
				    }
				}
			    }
			} else {
			    if {![string equal $cognome_occu ""]} {
				set flag_resp "O"
				set cod_responsabile $cod_occupante
			    } else {
				if {![string equal $cognome_prop ""]} {
				    set flag_resp "P"
				    set cod_responsabile $cod_proprietario
				} else {
				    incr err_count
				    append msg_errore "Nessun soggetto valorizzato (responsabile, occupante, proprietario)" 
				}
			    }
			}
		    }
		    
		    if {$err_count == 0} {
			db_transaction {
			    if {$flag_scarta_via_nt == "N"} {
				if {$flag_via == "F"} {
				    # Inserisco la nuova via
				    ns_log Notice "Inserisco una nuova via"
				    db_1row sel_dual_cod_via ""
				    db_dml ins_viae ""
				}
			    }
			    # Assegno cod_impianto
			    ns_log Notice "Inserisco un nuovo impianto"
			    db_1row sel_dual_cod_impianto ""
			    if {[string equal $potenza_foc_nom ""]} {
				set potenza_foc_nom "0.00"
			    }
			    if {[string equal $potenza_utile_nom ""]} {
				set potenza_utile_nom "0.00"
			    }
			    set cod_potenza [db_string sel_pot "select coalesce(cod_potenza, '') from coimpote where potenza_min <= :potenza_foc_nom and potenza_max >= :potenza_foc_nom" -default "0"]
			    if {$flag_codifica_reg == "T"} {
                                #gab01 aggiunto || su provincia di Ancona
				#sim03 Aggiunto || su Ancona 
				if {$coimtgen(ente) eq "CPESARO" || $coimtgen(ente) eq "PPU" || $coimtgen(ente) eq "CFANO" || $coimtgen(ente) eq "CANCONA" || $coimtgen(ente) eq "PAN" || $coimtgen(ente) eq "CJESI" || $coimtgen(ente) eq "CSENIGALLIA"} {#sim01: aggiunta if ed il suo contenuto
                                    if {$coimtgen(ente) eq "CPESARO"} {
                                        set sigla_est "CMPS"
				    } elseif {$coimtgen(ente) eq "CFANO"} {
					set sigla_est "CMFA"
				    } elseif {$coimtgen(ente) eq "CANCONA"} {;#sim03
					set sigla_est "CMAN"
                                    } elseif {$coimtgen(ente) eq "PAN"} {;#gab01
					set sigla_est "PRAN"
				    } elseif {$coimtgen(ente) eq "CJESI"} {;#sim04
					set sigla_est "CMJE"
				    } elseif {$coimtgen(ente) eq "CSENIGALLIA"} {;#sim04
					set sigla_est "CMSE"
				    } else {
                                        set sigla_est "PRPU"
                                    }
				    
                                    set progressivo_est [db_string sel "select nextval('coimaimp_est_s')"]

                                    # devo fare l'lpad con una seconda query altrimenti mi va in errore
                                    #nic01 set progressivo_est [db_string sel "select lpad(:progressivo_est,6,'0')"]
				    set progressivo_est [db_string sel "select lpad(:progressivo_est,:lun_num_cod_imp_est,'0')"];#nic01

                                    set cod_impianto_est "$sigla_est$progressivo_est"
				    
                                } else {#sim01

				    # caso standard

				    if {![string equal $cod_comune ""]} {
					db_1row sel_dati_comu "
                                        select coalesce(lpad((progressivo + 1), 7, '0'), '0000001') as progressivo
                                             , cod_istat
	                                  from coimcomu
	                                 where cod_comune = :cod_comune"
					if {![string equal $potenza_foc_nom "0.00"]
					&&  ![string equal $potenza_foc_nom ""]} {
					    if {$potenza_foc_nom < 35} {
						set tipologia "IN"
					    } else {
						set tipologia "CT"
					    }
					    set cod_impianto_est "$cod_istat$tipologia$progressivo"
					    db_dml upd_prog_comu "
                                            update coimcomu
                                               set progressivo = :progressivo
                                             where cod_comune  = :cod_comune"
					} else {
					    if {![string equal $cod_potenza "0"]
					    &&  ![string equal $cod_potenza ""]} { 
						switch $cod_potenza {
						    "B"  {set tipologia "IN"}
						    "A"  {set tipologia "CT"}
						    "MA" {set tipologia "CT"}
						    "MB" {set tipologia "CT"}
						}
						
						set cod_impianto_est "$cod_istat$tipologia$progressivo"
						db_dml upd_prog_comu "
                                                update coimcomu
                                                   set progressivo = :progressivo
                                                 where cod_comune  = :cod_comune"
					    } else {
						set cod_impianto_est ""
					    }
					}
				    } else {
					set cod_impianto_est ""
				    }
				};#sim01
			    } else {
				db_1row sel_dual_cod_impianto_est ""
			    }
			    db_dml ins_aimp ""
			    if {[string equal $gen_prog ""]} {
				set gen_prog 1
			    }
			    db_dml ins_gend ""
			    set flag_new_aimp "T"
			    incr aimp_ok
			}
		    }
		} else {
		    # Controllo se, ad impianto esistente, corrisponde anche un generatore esistente
		    # se non esiste, lo inserisco e aggiorno eventuali soggetti
		    set flag_upd_aimp ""
		    if {[string equal $gen_prog ""]} {
			set gen_prog "1"
		    }
		    if {[db_0or1row sel_aimp_gend_check ""] == 0} {
			if {![string equal $cod_impianto_est ""]} {
			    set where_cod "where cod_impianto_est = :cod_impianto_est"
			} else {
			    set where_cod "where cod_impianto = :cod_impianto"
			}
			db_1row sel_aimp_data ""
			set cod_comb_chk ""
			set combustibile [string toupper $combustibile]
			if {$combustibile == "0"} {
			    set cod_comb_chk "0"
			} else {
			    if {![info exist combustibili($combustibile)]} {
				incr err_count
				append msg_errore "Combustibile $combustibile inesistente; "
			    } else {
				set cod_comb_chk $combustibili($combustibile)
			    }
			}
			
			# Controllo l'esattezza del manutentore
			# Se l'utente è amministratore non effettuo il controllo, altrimenti si
			db_1row sel_utente_status ""
			if {($user_sett == "system") && ($user_ruol == "admin")} {
			    if {[db_0or1row sel_manu_check ""] == 0} {
				incr err_count
				append msg_errore "Manutentore non presente nel database; "
			    } else {
				# Controllo che il manutentore non sia cambiato
				if {$cod_manutentore != $cod_manutentore_ok} {
				    set flag_upd_aimp "T"
				    set cod_manutentore_upd $cod_manutentore
				} else {
				    set cod_manutentore_upd $cod_manutentore_ok
				}
			    }
			} else {
			    set cod_manutentore_chk [iter_check_uten_manu $id_utente]
			    if {[string equal $cod_manutentore_chk  ""] || $cod_manutentore_chk != $cod_manutentore} {
				# Errore, manutentore inesistente o errato
				incr err_count
				append msg_errore "Utente non collegato a nessun manutentore o manutentore inesistente; " 
			    } else {
				# Controllo che il manutentore non sia cambiato
				if {$cod_manutentore_chk != $cod_manutentore_ok} {
				    set flag_upd_aimp "T"
				    set cod_manutentore_upd $cod_manutentore_chk
				} else {
				    set cod_manutentore_upd $cod_manutentore_ok
				}
			    }
			}
			
			if {$err_count == 0} {          
			    # Eseguo il controllo so se l'impianto non è stato appena inserito
			    set flag_upd_aimp "F"
			    # Proprietario
			    set nome_citt_chk $nome_prop
			    set cognome_citt_chk $cognome_prop
			    set indirizzo_citt_chk $indirizzo_prop
			    set comune_citt_chk $comune_prop
			    set provincia_citt_chk $provincia_prop
			    set natura_citt_chk $natura_giuridica_prop
			    set telefono_citt_chk $telefono_pop
			    set cod_fiscale_citt_chk $cod_fiscale_prop
			    if {![string equal $cognome_citt_chk ""]} {
				eval $citt_control
				set cod_proprietario $cod_citt
				
				if {$cod_proprietario != $cod_proprietario_ok} {
				    set flag_upd_aimp "T"
				    set cod_proprietario_upd $cod_proprietario
				} else {
				    set cod_proprietario_upd $cod_proprietario_ok
				}
			    } else {
				set cod_proprietario_upd "" 
				set cod_proprietario "" 
			    }
			    
			    # Occupante
			    set nome_citt_chk $nome_occu
			    set cognome_citt_chk $cognome_occu
			    set indirizzo_citt_chk $indirizzo_occu
			    set comune_citt_chk $comune_occu
			    set provincia_citt_chk $provincia_occu
			    set natura_citt_ch $natura_giuridica_occu
			    set telefono_citt_chk $telefono
			    set cod_fiscale_citt_chk $cod_fiscale_occu
			    if {![string equal $cognome_citt_chk ""]} {
				eval $citt_control
				set cod_occupante $cod_citt
				
				if {$cod_occupante != $cod_occupante_ok} {
				    set flag_upd_aimp "T"
				    set cod_occupante_upd $cod_occupante
				} else {
				    set cod_occupante_upd $cod_occupante_ok
				}
			    } else {
				set cod_occupante_upd ""
				set cod_occupante ""
			    }  
			    
			    # Controllo chi è il responsabile: se il responsabile non coincide lo registro come terzo responsabile
			    set flag_resp ""
			    set cod_responsabile ""
			    if {![string equal $cognome_resp ""]} {
				if {($nome_resp == $nome_prop) && ($cognome_resp == $cognome_prop)} {
				    set flag_resp "P"
				    set cod_responsabile $cod_proprietario
				} else {
				    if {($nome_resp == $nome_occu) && ($cognome_resp == $cognome_occu)} {
					set flag_resp "O"
					set cod_responsabile $cod_occupante
				    } else {
					if {($nome_resp == $nome_int) && ($cognome_resp == $cognome_int)} {
					    set flag_resp "I"
					    set cod_responsabile $cod_intestatario
					} else {
					    set nome_citt_chk $nome_resp
					    set cognome_citt_chk $cognome_resp
					    set indirizzo_citt_chk $indirizzo_resp
					    set comune_citt_chk $comune_resp
					    set provincia_citt_chk $provincia_resp
					    set natura_citt_chk $natura_giuridica_resp
					    set telefono_citt_chk $telefono_resp
					    set cod_fiscale_citt_chk $cod_fiscale_resp
					    if {![string equal $cognome_citt_chk ""]} {
						eval $citt_control
						set cod_terzi $cod_citt
						set flag_resp "T"
						set cod_responsabile $cod_terzi
					    }
					}
				    }
				}
			    } else {
				if {![string equal $cognome_occu ""]} {
				    set flag_resp "O"
				    set cod_responsabile $cod_occupante
				} else {
				    if {![string equal $cognome_prop ""]} {
					set flag_resp "P"
					set cod_responsabile $cod_proprietario
				    } else {
					incr err_count
					append msg_errore "Nessun soggetto valorizzato (responsabile, occupante, proprietario)" 
				    }
				}
			    }
			}
			if {$err_count == 0} {
			    db_transaction {
				# Inserisco un nuovo generatore
				ns_log Notice "Inserisco un nuovo generatore sull'impianto $cod_impianto_est"
				db_dml ins_gend ""
				set flag_new_aimp "F"
				incr gend_new
				ns_log Notice "controllo dopo l'ins. il cod_propr:'$cod_proprietario_upd' e il cod_occ:'$cod_occupante_upd'"
				if {$flag_upd_aimp == "T"} {
				    db_dml upd_aimp_citt ""
				}
			    }
			} else {
			    # Scrivo la riga sull'output del csv da scaricare
			    iter_put_csv $file_err_id file_inp_col_list |
			    # Incremento il conteggio degli modelli non accettati
			    incr line_not_ok
			    # Aggiungo una riga al pdf di output con le motivazioni per il singolo modello
			    puts $file_out_id "$cod_impianto_est: $msg_errore\n\n"          
			}  
		    } 
		}
	    }
	}
	
	# Scrivo la procedura che inserisce i modelli
	set inserimento_dimp {
	    ns_log Notice "Inizio controllo per dimp impianto $cod_impianto_est"
	    set cod_impianto_est_old $cod_impianto_est
	    set count 0
	    foreach column_name $file_cols {
		set $column_name [lindex $file_inp_ok_list $count]
		incr count
	    }
	    set err_count 0
	    set flag_upd_aimp ""
	    set cod_comb_chk ""
	    set combustibile [string toupper $combustibile]
	    if {$combustibile == "0"} {
		set cod_comb_chk "0"
	    } else {
		if {![info exist combustibili($combustibile)]} {
		    incr err_count
		    append msg_errore "Combustibile $combustibile inesistente; "
		} else {
		    set cod_comb_chk $combustibili($combustibile)
		}
	    }
	    if {[string equal $cod_impianto_est ""]
	        || $cod_impianto_est != $cod_impianto_est_old} {
		set cod_impianto_est $cod_impianto_est_old
	    }
	    set cod_potenza [db_string sel_pot "select coalesce(cod_potenza, '') from coimpote where potenza_min <= :potenza_foc_nom and potenza_max >= :potenza_foc_nom" -default ""]
	    
	    if {[info exists cod_impianto] && ![string equal $cod_impianto ""]} {
		set where_cod "where cod_impianto = :cod_impianto"
	    } else {
		set where_cod "where cod_impianto_est = :cod_impianto_est"
	    }
	    db_1row sel_aimp_data ""
	    # Estraggo dall'impianto alcuni dati di riferimento utili per l'inserimento
	    # Controllo che non esista un modello con stessa data e stesso gen_prog
	    if {[string equal $gen_prog ""]} {
		set where_gen_prog " and gen_prog is null"
	    } else {
		set where_gen_prog " and gen_prog = :gen_prog"
	    }
	    
	    # Proprietario
	    set nome_citt_chk $nome_prop
	    set cognome_citt_chk $cognome_prop
	    set indirizzo_citt_chk $indirizzo_prop
	    set comune_citt_chk $comune_prop
	    set provincia_citt_chk $provincia_prop
	    set natura_citt_chk $natura_giuridica_prop
	    set telefono_citt_chk $telefono_pop
	    set cod_fiscale_citt_chk $cod_fiscale_prop
	    if {![string equal $cognome_citt_chk ""]} {
		eval $citt_control
		set cod_proprietario $cod_citt
		
		if {$cod_proprietario != $cod_proprietario_ok} {
		    set flag_upd_aimp "T"
		    set cod_proprietario_upd $cod_proprietario
		} else {
		    set cod_proprietario_upd $cod_proprietario_ok
		}
	    } else {
		set cod_proprietario_upd "" 
		set cod_proprietario "" 
	    }
	    
	    # Occupante
	    set nome_citt_chk $nome_occu
	    set cognome_citt_chk $cognome_occu
	    set indirizzo_citt_chk $indirizzo_occu
	    set comune_citt_chk $comune_occu
	    set provincia_citt_chk $provincia_occu
	    set natura_citt_ch $natura_giuridica_occu
	    set telefono_citt_chk $telefono
	    set cod_fiscale_citt_chk $cod_fiscale_occu
	    if {![string equal $cognome_citt_chk ""]} {
		eval $citt_control
		set cod_occupante $cod_citt
		
		if {$cod_occupante != $cod_occupante_ok} {
		    set flag_upd_aimp "T"
		    set cod_occupante_upd $cod_occupante
		} else {
		    set cod_occupante_upd $cod_occupante_ok
		}
	    } else {
		set cod_occupante_upd ""
		set cod_occupante ""
	    }
	    
	    # Intestatario
	    set nome_citt_chk $nome_int
	    set cognome_citt_chk $cognome_int
	    set indirizzo_citt_chk $indirizzo_int
	    set comune_citt_chk $comune_int
	    set provincia_citt_chk $provincia_int
	    set natura_citt_chk $natura_giuridica_int
	    set telefono_citt_chk $telefono_int
	    set cod_fiscale_citt_chk $cod_fiscale_int
	    if {![string equal $cognome_citt_chk ""]} {
		eval $citt_control
		set cod_intestatario $cod_citt
	    } else {
		set cod_intestatario ""
	    }
	    # Controllo chi è il responsabile: se il responsabile non coincide lo registro come terzo responsabile
	    set flag_resp ""
	    set cod_responsabile ""
	    if {![string equal $cognome_resp ""]} {
		if {($nome_resp == $nome_prop) && ($cognome_resp == $cognome_prop)} {
		    set flag_resp "P"
		    set cod_responsabile $cod_proprietario
		} else {
		    if {($nome_resp == $nome_occu) && ($cognome_resp == $cognome_occu)} {
			set flag_resp "O"
			set cod_responsabile $cod_occupante
		    } else {
			if {($nome_resp == $nome_int) && ($cognome_resp == $cognome_int)} {
			    set flag_resp "I"
			    set cod_responsabile $cod_intestatario
			} else {
			    set nome_citt_chk $nome_resp
			    set cognome_citt_chk $cognome_resp
			    set indirizzo_citt_chk $indirizzo_resp
			    set comune_citt_chk $comune_resp
			    set provincia_citt_chk $provincia_resp
			    set natura_citt_chk $natura_giuridica_resp
			    set telefono_citt_chk $telefono_resp
			    set cod_fiscale_citt_chk $cod_fiscale_resp
			    if {![string equal $cognome_citt_chk ""]} {
				eval $citt_control
				set cod_terzi $cod_citt
				set flag_resp "T"
				set cod_responsabile $cod_terzi
			    }
			}
		    }
		}
	    } else {
		if {![string equal $cognome_occu ""]} {
		    set flag_resp "O"
		    set cod_responsabile $cod_occupante
		} else {
		    if {![string equal $cognome_prop ""]} {
			set flag_resp "P"
			set cod_responsabile $cod_proprietario
		    } else {
			incr err_count
			append msg_errore "Nessun soggetto valorizzato (responsabile, occupante, proprietario)" 
		    }
		}
	    }
	    set provincia [string toupper $provincia]
	    set cod_prov_chk ""
	    if {$coimtgen(sigla_prov) == $provincia
	        || $denom_prov == $provincia} {
		set cod_prov_chk $province($provincia)
	    } else {
		incr err_count
		append msg_errore "Provincia $provincia non di competenza dell'ente; "
	    }
	    
	    if {[db_0or1row sel_dimp_check ""] == 0} {
		# Comincio i controlli per l'inserimento del modello
		# Controllo che le anagrafiche legate all'impianto siano le stesse
		if {$flag_new_aimp == "F"} {
		    # Eseguo il controllo so se l'impianto non è stato appena inserito
		    set flag_upd_aimp "F"
		}
		
		# Controllo l'esattezza del manutentore
		# Se l'utente è amministratore non effettuo il controllo, altrimenti si
		db_1row sel_utente_status ""
		if {($user_sett == "system") && ($user_ruol == "admin")} {
		    if {[db_0or1row sel_manu_check ""] == 0} {
			incr err_count
			append msg_errore "Manutentore non presente nel database; "
		    } else {
			# Controllo che il manutentore non sia cambiato
			if {$cod_manutentore != $cod_manutentore_ok} {
			    set flag_upd_aimp "T"
			    set cod_manutentore_upd $cod_manutentore
			} else {
			    set cod_manutentore_upd $cod_manutentore_ok
			}
		    }
		} else {
		    set cod_manutentore_chk [iter_check_uten_manu $id_utente]
		    if {[string equal $cod_manutentore_chk ""] || $cod_manutentore_chk != $cod_manutentore} {
			# Errore, manutentore inesistente o errato
			incr err_count
			append msg_errore "Utente non collegato a nessun manutentore o manutentore inesistente; " 
		    } else {
			# Controllo che il manutentore non sia cambiato
			if {$cod_manutentore_chk != $cod_manutentore_ok} {
			    set flag_upd_aimp "T"
			    set cod_manutentore_upd $cod_manutentore_chk
			} else {
			    set cod_manutentore_upd $cod_manutentore_ok
			}
		    }
		}
		if {![string equal $num_bollo ""]} {
		    set riferimento_pag $num_bollo
		}           
		
		#Controllo che le anomalie segnalate siano presenti nella tabella coimtano
		# e quindi conformi agli standard della regione lombardia       
		set anomalie_impianto [split $anomalie_dimp \,]
		set num_anom [llength $anomalie_impianto]
		set errore_tanom 0
		for {set i 0} {$i < $num_anom} {incr i} {
		    set anomalia [lindex $anomalie_impianto $i]
		    set anomalia [string trim $anomalia]
		    if {![info exists anomalie($anomalia)]} {
			append err_log "Codice anomalia $anomalia non valido,"
			set errore_tanom 1
		    }
		} 
		if {$errore_tanom == 1} {
		    incr err_count
		}
		
		if {$data_controllo > [db_string sel_date "select to_char(current_date, 'yyyymmdd')"] } {
		    incr err_count
		    append msg_errore "Data controllo deve essere inferiore o uguale alla data odierna" 
		}
		
		if {$err_count == 0} {
		    if {$flag_portafoglio == "T"
			&& $data_controllo >= "20080801" } {
			set data_insta_check "19000101"
			if {![string equal $data_installazione_aimp ""]} {
			    set data_insta_check [db_string sel_dat "select to_char(add_months(:data_installazione_aimp, '1'), 'yyyymmdd')"]
			}                   
			if {$data_controllo >= $data_insta_check} {
			    set tariffa_reg "7"
			    set pot_focolare_nom_check [iter_edit_num $potenza_foc_nom 2]
			    set pot_focolare_nom_check [iter_check_num $pot_focolare_nom_check 2]
			    db_1row sel_cod_potenza ""
			    db_1row sel_tari_contributo ""
			    set oggi [db_string sel_date "select current_date"]
			    set url "lotto/balance?iter_code=$cod_manutentore"
			    set data [iter_httpget_wallet $url]
			    array set result $data
			    set risultato [string range $result(page) 0 [expr [string first " " $result(page)] - 1]]
			    set parte_2 [string range $result(page) [expr [string first " " $result(page)] + 1] end]
			    set saldo [string range $parte_2 0 [expr [string first " " $parte_2] - 1]]
			    set conto_manu [string range $parte_2 [expr [string first " " $parte_2] + 1] end]
			    
			    if {$saldo < $importo_contr} {  
				incr err_count
				append msg_errore "Saldo manutentore ($saldo) non sufficiente" 
			    } else {
				db_1row sel_dual_cod_dimp ""
				set database [db_get_database]
				set reference "$cod_dimp+$database"
				
				set url "lotto/itermove?iter_code=$cod_manutentore&body_id=3&tran_type_id=2&payment_type=1&payment_date=$oggi&reference=$reference&description=pagamento&amount=$importo_contr"
				set data [iter_httpget_wallet $url]
				array set result $data
				set risultato [string range $result(page) 0 [expr [string first " " $result(page)] - 1]]
				#				set risultato "OK"
				if {$risultato == "OK"} {
				    
				} else {
				    incr err_count
				    append msg_errore "Transazione non avvenuta correttamente ($result(page))" 
				}
			    }
			} else {
			    db_1row sel_dual_cod_dimp ""
			    set tariffa_reg "8" 
			    set importo_contr "0.00"
			}
		    } else {
			db_1row sel_dual_cod_dimp ""
			set importo_contr ""
			set tariffa_reg ""
		    }
		}
		
		if {$err_count == 0} {
		    db_transaction {
			# Aggiorno l'impianto anche per quanto riguarda le anagrafiche
			ns_log Notice "controllo per l'aggiorn. il cod_propr:'$cod_proprietario_upd' e il cod_occ:'$cod_occupante_upd'"
			if {$flag_upd_aimp == "T"} {
			    #ns_log Notice "(Aggiorno l'impianto) $cod_proprietario_upd $cod_occupante_upd"
			    db_dml upd_aimp_citt ""
			}
			# Aggiorno l'impianto solo per quanto riguarda le date
			if {[string equal $data_scadenza ""]} {
			    if {[string range $data_controllo 4 8] < "0731"} {
				set data_scadenza [expr [string range $data_controllo 0 3] + 2]
				set data_scadenza "$data_scadenza-07-31"
			    } else {
				set data_scadenza [expr [string range $data_controllo 0 3] + 3]
				set data_scadenza "$data_scadenza-07-31"
			    }
			}
			if {[string toupper $flag_tracciato] == "G"
			    && ![string equal $flag_status_g ""]} {
			    if {$flag_status_g == "S"} {
				set flag_status_g "P"
			    }
			    set flag_status $flag_status_g
			}
			if {[string equal $scar_ca_si "N"]
			    && [string equal $scar_parete "N"]} {
			    set scar_can_fu "S"
			} else {
			    set scar_can_fu "N"
			}
			if {$flag_status == "N"
			    && ![string equal $prescrizioni ""]} {
			    set conf_aimp "N"
			} else {
			    set conf_aimp "S"
			}
			db_dml upd_aimp_dates ""
			# Inserisco la dichiarazione
			db_dml ins_dimp ""
			
			if {$flag_portafoglio == "T"
			    && $data_controllo >= "20080801" } {
			    set azione "I"
			    db_dml ins_trans ""
			}
			
			incr dimp_ok
			
			set conta 0
			for {set i 0} {$i < $num_anom} {incr i} {
			    incr conta
			    set prog_anom $conta
			    set anomalia [lindex $anomalie_impianto $i]
			    set anomalia [string trim $anomalia]
			    db_dml ins_anom ""
			}
			
			if {$flag_new_aimp == "F"} {
			    db_1row sel_pot_old "select potenza as pot_foc_old from coimaimp where cod_impianto = :cod_impianto"
			    if {![string equal $potenza_foc_nom ""]
				&& $potenza_foc_nom != $pot_foc_old} { 
				set note_todo "I dati impianto/generatore sono stati modificati. Potenza impianto $pot_foc_old aggiornata a $potenza_foc_nom"
				db_dml upd_dati_impianto ""
				db_dml upd_dati_generatore ""
				db_dml ins_todo ""
			    }
			}
		    }
		} else {
		    # Scrivo la riga sull'output del csv da scaricare
		    iter_put_csv $file_err_id file_inp_col_list |
		    # Incremento il conteggio degli modelli non accettati
		    incr line_not_ok
		    # Aggiungo una riga al pdf di output con le motivazioni per il singolo modello
		    puts $file_out_id "$cod_impianto_est: $msg_errore\n\n"          
		}
	    } else {
		if {[string length $interno] > 3} {
		    set interno [string range $interno 0 2]
		}
		db_1row sel_pot_old "select potenza as pot_foc_old from coimaimp where cod_impianto = :cod_impianto"
		if {![string equal $potenza_foc_nom ""]
		    && $potenza_foc_nom != $pot_foc_old} { 
		    set note_todo "I dati impianto/generatore sono stati modificati. Potenza impianto $pot_foc_old aggiornata a $potenza_foc_nom"
		    db_dml upd_dati_impianto ""
		    db_dml upd_dati_generatore ""
		    db_dml ins_todo ""
		    append msg_errore "Dichiarazione già presente nel database (AGGIORNATI DATI IMPIANTO)"
		} else {
		    append msg_errore "Dichiarazione già presente nel database controlla la data del controllo e il progressivo generatore"
		}
		
		# Scrivo la riga sull'output del csv da scaricare
		iter_put_csv $file_err_id file_inp_col_list |
		# Incremento il conteggio degli modelli non accettati
		incr line_not_ok
		# Aggiungo una riga al pdf di output con le motivazioni per il singolo modello
		puts $file_out_id "$cod_impianto_est: $msg_errore\n\n"          
	    }
	}
	
	# preparo e scrivo scrivo la riga di intestazione per file out
	set     head_cols ""
	
	# definisco il tracciato record del file di input
	set     file_cols ""
	
	# Setto il nome della tabella da cui leggere le intestazioni
	set csv_name "dimpmanu"
	set count_fields 0
	# Eseguo la query che reperisce i campi della lista dal db

	db_foreach sel_liste_csv "" {
	    #Creo la lista
	    lappend head_cols $denominazione
	    
	    # Popolo i campi della lista
	    lappend file_cols $nome_colonna
	    
	    #Memorizzo in un array tutti i dati relativi ad un singoloo campo, necessari per la successiva analisi
	    set file_fields($count_fields) [list $nome_colonna $denominazione $tipo_dato $dimensione $obbligatorio $default_value $range_value]
	    incr count_fields       
	}
	
	# Setto la lunghezza standard del tracciato in base ai campi letti dal database
	set lunghezza_attesa [expr $count_fields]
	
	# Scrivo le testate nei csv di output
	iter_put_csv $file_err_id head_cols |
	#iter_put_csv $file_out_id head_cols |
	puts $file_out_id "Motivi di scarto per ogni modello scartato\n\n"
	
	#   set ctr_inp 0
	#   set ctr_err 0
	#   set ctr_out 0
	#   set ctr_ins_citt 0
	#   set ctr_ins_aimp 0
	#   set ctr_ins_gend 0
	#   set ctr_ins_inco 0
	
	# Imposto le variabili che contano i modelli e gli impianti caricati e scartati
	set aimp_ok 0
	set aimp_not_ok 0
	set dimp_ok 0
	set dimp_not_ok 0
	set citt_insered 0
	set line_read 0
	set line_not_ok 0
	set gend_new 0
	
	# reperisco una volta sola max_cod_impianto_est
	#if {$coimtgen(flag_cod_aimp_auto) != "T"} {
	#set max_cod_impianto_est [db_string sel_aimp_max_cod_impianto_est ""]
	#}
	
	#setto un array contenente tutti i codici delle anomalie per verificare la loro esistenza durante il caricamento dei modelli
	db_foreach sel_cod_tanom "" {
	    set anomalie($codice_anomalia) 1
	    
	}
	# Setto una sola volta l'array dei comuni possibili all'interno dell'ente
	db_foreach sel_comuni "" {
	    set comuni($nome_comune) $cod_comune
	}
	# Setto una sola volta l'array delle province
	db_foreach sel_prov_denom "" {
	    set province($denom_provincia) $cod_prov
	}
	db_foreach sel_prov "" {
	    set province($sigla_prov) $cod_prov
	}
	# Setto una sola volta l'array dei combustibili presenti nel db
	db_foreach sel_comb "" {
	    set combustibili($descr_comb) $cod_combustibile
	}
	
	# Salto il primo record che deve essere di testata
	iter_get_csv $file_inp_id file_inp_col_list |
	
	# Ciclo di lettura sul file di input
	# uso la proc perche' i file csv hanno caratteristiche 'particolari'
	iter_get_csv $file_inp_id file_inp_col_list |
	
	set totale_contr 0
	set err_log ""
	set cod_manutentore_salva ""
	
	if {$flag_portafoglio == "T"} {
	    while {![eof $file_inp_id]} {
	        
		# valorizzo le relative colonne
		set ind 0
		foreach column_name $file_cols {
		    set $column_name [lindex $file_inp_col_list $ind]
		    incr ind
		}
		
		if {[string equal $cod_manutentore_salva ""]} {
		    set cod_manutentore_salva $cod_manutentore
		} else {
		    if {$cod_manutentore != $cod_manutentore_salva} {
			set err_log "Il file presenta diverse ditte di manutenzione: creare un file per ogni ditta"
			puts $file_out_id "$err_log"
			break           
		    }
		}
		
		if {$data_controllo >= "20080801"
		    && $data_controllo <= [db_string sel_date "select to_char(current_date, 'yyyymmdd')"] } {
		    if {[string equal $potenza_foc_nom ""]
			|| $potenza_foc_nom < "0.01"} {
			set err_log "Non è stato possibile calcolare l'importo del contributo regionale in quanto una o più potenze sono nulle o 0,00"
			puts $file_out_id "$err_log"
			break
		    } else {
			set pot_focolare_nom_check [iter_edit_num $potenza_foc_nom 2]
			set pot_focolare_nom_check [iter_check_num $pot_focolare_nom_check 2]
			if {[db_0or1row sel_cod_potenza ""] == 0} {
			    set err_log "Non è stato possibile calcolare l'importo del contributo regionale in quanto una o più potenze non rientrano in nessuna fascia"
			    puts $file_out_id "$err_log"
			    break               
			} else {
			    if {[db_0or1row sel_tari_contributo ""] == 0} {
				set err_log "Non è stato possibile calcolare l'importo del contributo regionale in quanto una o più potenze non rientrano in nessuna tariffa"
				puts $file_out_id "$err_log"
				break
			    } else {
				if {![string equal $data_installazione_aimp ""]} {
				    set data_insta_check [db_string sel_dat "select to_char(add_months(:data_installazione_aimp, '1'), 'yyyymmdd')"]
				    if {$data_controllo >= $data_insta_check} {
					set totale_contr [expr $totale_contr + $importo_contr]
				    }
				} else {
				    set totale_contr [expr $totale_contr + $importo_contr]
				}
			    }
			}
		    }
		}
		# lettura del record successivo
		iter_get_csv $file_inp_id file_inp_col_list |
	    }
	    
	    set url "lotto/balance?iter_code=$cod_manutentore_salva"
	    set data [iter_httpget_wallet $url]
	    array set result $data
	    set risultato [string range $result(page) 0 [expr [string first " " $result(page)] - 1]]
	    set parte_2 [string range $result(page) [expr [string first " " $result(page)] + 1] end]
	    set saldo [string range $parte_2 0 [expr [string first " " $parte_2] - 1]]
	    set conto_manu [string range $parte_2 [expr [string first " " $parte_2] + 1] end]
	    
	    if {[string is double $saldo]} {
		if {$saldo < $totale_contr} {
		    set err_log "Saldo manutentore non sufficiente ($saldo) per l'importo totale del file ($totale_contr)"
		    puts $file_out_id "$err_log"
		}
	    } else {
		set err_log "Errore nel estrazione del saldo: $risultato"
		puts $file_out_id "$err_log"                
	    }
	    
	    if {[catch {set file_inp_id [open $file_inp r]}]} {
		iter_return_complaint "File csv di input non aperto: $file_inp"
	    }
	    
	    # Salto il primo record che deve essere di testata
	    iter_get_csv $file_inp_id file_inp_col_list |
	    
	    # Ciclo di lettura sul file di input
	    # uso la proc perche' i file csv hanno caratteristiche 'particolari'
	    iter_get_csv $file_inp_id file_inp_col_list |
	}
	
	if {[string equal $err_log ""]} {
	    set file_inp_ok_list $file_inp_col_list
	    set lunghezza_letta [llength $file_inp_col_list]
	    
	    while {![eof $file_inp_id]} {
		incr line_read
		
		#log degli errori
		set riserva_log ""
		set err_log ""
		set err_count 0
		set err_obblig 0
		set err_riserva 0
		
		# valorizzo le relative colonne
		set ind 0
		foreach column_name $file_cols {
		    set $column_name [lindex $file_inp_col_list $ind]
		    incr ind
		}
		
		if {$lunghezza_letta == $lunghezza_attesa} {
		    
		    set i 0
		    while {$i < $count_fields} {
			
			set colonna [lindex $file_inp_col_list $i]
			set colonna [string trim $colonna]
			
			util_unlist $file_fields($i) col_name denominazione type dimension obbligatorio default_value range_value
			#ns_log Notice "$i || $col_name || $colonna || $type || $dimension || $obbligatorio || $default_value || $range_value<br>"
			
			set element [set col_name]
			
			# Bonifico l'elemento da possibili caratteri che non vengono accettati dal database
			set colonna [string map {\\ "" \r " " \n " " \r\n " "} $colonna]
			set file_inp_ok_list [lreplace $file_inp_ok_list $i $i $colonna]
			set colonna [string toupper $colonna]
			
			if {[string equal $flag_cod_imp_obblig "S"]
			    && $col_name == "cod_impianto_est" } {
			    if {[string equal $colonna ""] || [string is space $colonna]} {
				append err_log "Il campo $denominazione è obbligatorio,"
				incr err_obblig
				incr err_count
			    } else {
				eval $controllo_integrita
			    }
			    incr i
			} else {
			    
			    if {[string equal $obbligatorio "S"]} {
				if {[string equal $colonna ""] || [string is space $colonna]} {
				    append err_log "Il campo $denominazione è obbligatorio,"
				    incr err_obblig
				    incr err_count
				} else {
				    eval $controllo_integrita
				}
				
			    } else {
				eval $controllo_integrita
			    }    
			    incr i
			}
		    }
		    
		} else {
		    append err_log "Il numero dei campi letti ($lunghezza_letta) non corrisponde alla lunghezza prevista ($lunghezza_attesa)"
		    incr err_count
		}
		
		# Se ci sono errori nell'integrita dei dati
		if {$err_count > 0} {
		    # Scrivo la riga sull'output del csv da scaricare
		    iter_put_csv $file_err_id file_inp_col_list |
		    # Incremento il conteggio degli modelli non accettati
		    incr line_not_ok
		    # Aggiungo una riga al pdf di output con le motivazioni per il singolo modello
		    puts $file_out_id "$cod_impianto_est: $err_log\n\n"
		} else {
		    # todo with no errors
		    
		    # Incremento il conteggio dei modelli accettati
		    #incr dimp_ok   ----> Commentato perchè da fare in un passo successivo
		    # Controllo se esiste già un impianto con le caratteristiche analizzate
		    # se non esiste lo creo
		    set cod_impianto ""
		    eval $controllo_inserimento_aimp
		    # se esiste inserisco il modello e aggiorno le date delle dichiarazioni
		    if {$err_count > 0} {
			iter_put_csv $file_err_id file_inp_col_list |
			incr line_not_ok
			puts $file_out_id "$cod_impianto_est: $msg_errore;\n\n"
		    } else {
			eval $inserimento_dimp
			# Aggiungo una riga al pdf dei modelli accettati contenente il codice esterno dell'impianto in questione.
		    }
		}
		
		
		# lettura del record successivo
		iter_get_csv $file_inp_id file_inp_col_list |
		set file_inp_ok_list $file_inp_col_list
		set lunghezza_letta [llength $file_inp_col_list]
	    }
	}
	
	# scrivo la pagina di esito
	set page_title "Esito caricamento modelli per manutentori"
	set context_bar [iter_context_bar \
			     [list "javascript:window.close()" "Chiudi finestra"] \
			     "$page_title"]
	
	set pagina_esi [subst {
	    <master   src="../../master">
	    <property name="title">$page_title</property>
	    <property name="context_bar">$context_bar</property>
	    
	    <center>
	    
	    <table>
	    <tr><td valign=top class=form_title align=center colspan=4>
	    <b>ELABORAZIONE TERMINATA</b>
	    </td>
	    </tr>
	    
	    <tr><td valign=top class=form_title>Modelli letti:</td>
	    <td valign=top class=form_title>$line_read</td>
	    <td>&nbsp;</td>
	    <td>&nbsp;</td>
	    </tr>
	    
	    <tr><td valign=top class=form_title>Modelli scartati:</td>
	    <td valign=top class=form_title>$line_not_ok</td>
	    <td>&nbsp;</td>
	    <td>&nbsp;</td>
	    </tr>
	    
	    <tr><td colspan=4>&nbsp;</td>
	    
	    <tr><td valign=top class=form_title colspan=2>&nbsp;&nbsp;&nbsp;Inseriti nuovi Soggetti:</td>
	    <td valign=top class=form_title>$citt_insered</td>
	    <td>&nbsp;</td>
	    </tr>
	    
	    <tr><td valign=top class=form_title colspan=2>&nbsp;&nbsp;&nbsp;Inseriti nuovi Impianti:</td>
	    <td valign=top class=form_title>$aimp_ok</td>
	    <td>&nbsp;</td>
	    </tr>
	    
	    <tr><td valign=top class=form_title colspan=2>&nbsp;&nbsp;&nbsp;Inseriti nuovi Generatori:</td>
	    <td valign=top class=form_title>$gend_new</td>
	    <td>&nbsp;</td>
	    </tr>
	    
	    <tr><td valign=top class=form_title colspan=2>&nbsp;&nbsp;&nbsp;Modelli inseriti:</td>
	    <td valign=top class=form_title>$dimp_ok</td>
	    <td>&nbsp;</td>
	    </tr>
	    <tr><td colspan=4>&nbsp;</td>
	    
	    <tr><td valign=top class=form_title>Modelli scartati:</td>
	    <td>&nbsp;</td>
	    <td>&nbsp;</td>
	    <td valign=top class=form_title><a target="Modelli scartati" href="$file_err_url">Scarica il file csv dei controlli/impianti scartati</a></td>
	    </tr>
	    
	    <tr><td valign=top class=form_title>Motivi Scarto Modelli:</td>
	    <td>&nbsp;</td>
	    <td>&nbsp;</td>
	    <td valign=top class=form_title><a target="Motivi Scarto Modelli" href="$file_out_url">Scarica il file con i motivi di scarto per ogni modello</a></td>
	    </tr>
	    
	}]
	
	foreach motivo_scarto [lsort [array names ctr_scarto]] {
	    set ws_mot_scarto $motivo_scarto
	    regsub -all "à" $ws_mot_scarto {\&agrave;} ws_mot_scarto
	    regsub -all "è" $ws_mot_scarto {\&egrave;} ws_mot_scarto
	    regsub -all "ì" $ws_mot_scarto {\&igrave;} ws_mot_scarto
	    regsub -all "ò" $ws_mot_scarto {\&ograve;} ws_mot_scarto
	    regsub -all "ù" $ws_mot_scarto {\&ugrave;} ws_mot_scarto
	    
	    append pagina_esi [subst {
	        <tr>
	        <td valign=top class=form_title colspan=2>&nbsp;&nbsp;&nbsp;Per [ad_quotehtml $ws_mot_scarto]:</td>
	        <td valign=top class=form_title>$ctr_scarto($motivo_scarto)</td>
	        <td>&nbsp;</td>
	        </tr>
	    }]
	}
	
	append pagina_esi [subst {
	    <tr><td colspan=4>&nbsp;</td>
	    
	    </table>
	    </center>
	}]
	
	puts $file_esi_id $pagina_esi
	
	close $file_inp_id
	close $file_esi_id
	close $file_out_id
	close $file_err_id
	
	# inserisco i link ai file di esito sulla tabella degli esiti
	# ed aggiorno lo stato del batch a 'Terminato'
	set     esit_list ""
	lappend esit_list [list "Esito caricamento"  $file_esi_url $file_esi]
	iter_batch_upd_flg_sta -fine $cod_batc $esit_list
	#   }
	# fine db_transaction ed ora fine with_catch
    } {
	iter_batch_upd_flg_sta -abend $cod_batc
	ns_log Error "iter_cari_manu: $error_msg"
    }
    
    ns_log Notice "Fine della procedura iter_cari_manu"
    
    return
}
