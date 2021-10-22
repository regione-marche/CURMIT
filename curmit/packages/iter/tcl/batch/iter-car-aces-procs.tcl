ad_proc iter_car_aces {
    {
	-cod_batc     ""
	-cod_acts     ""
	-nome_file_n  ""
	-id_utente    ""
    }
} {
    Elaborazione     Protocollazione dichiarazione distributori
    @author          Paolo Formizzi Adhoc
    @creation-date   27/01/2004
    @cvs-id          iter_car_aces
} {

    iter_get_coimtgen
    set flag_ente   $coimtgen(flag_ente)
    set cod_comu    $coimtgen(cod_comu)
    set denom_comu  $coimtgen(denom_comune)
    set cod_prov    $coimtgen(cod_provincia)
    set flag_viario $coimtgen(flag_viario)

    # aggiorno stato di coimbatc
    iter_batch_upd_flg_sta -iniz $cod_batc
    set cod_acts_input $cod_acts
    with_catch error_msg {
	# imposto variabili usate nel programma:
	set data_corrente      [iter_set_sysdate]
	set sysdate_edit       [iter_edit_date $data_corrente]

	# imposto la directory degli permanenti ed il loro nome.
	set permanenti_dir     [iter_set_permanenti_dir]
	set permanenti_dir_url [iter_set_permanenti_dir_url]

	# imposto il nome dei file
	set nome_file_esito     "Prot. dic. distr. Esito "
	set nome_file_scarti    "Prot. dic. distr. Scarti"
	# Protocollazione dichiarazione distributori"
	set nome_file_esito  [iter_temp_file_name -permanenti $nome_file_esito]
	set file_html     "$permanenti_dir/$nome_file_esito.html"
	set file_pdf      "$permanenti_dir/$nome_file_esito.pdf"
	set file_pdf_url  "$permanenti_dir_url/$nome_file_esito.pdf"

	set nome_file_scarti [iter_temp_file_name -permanenti $nome_file_scarti]
	set file_scarti      "$permanenti_dir/$nome_file_scarti.csv"
	set file_scarti_url  "$permanenti_dir_url/$nome_file_scarti.csv"

	# apro il file in lettura e metto in leggifile l'identificativo del 
	# file per poterlo leggere successivamente
	if {[catch {set leggifile [open $nome_file_n r]}]} {
	    idri_return_complaint "File csv di input non aperto: $nome_file_n"
	}
	# dichiaro di leggere in formato iso West European e di utilizzare crlf
	# come fine riga (di default andrebbe a capo anche con gli eventuali lf
	# contenuti tra doppi apici).
	fconfigure $leggifile -encoding iso8859-1 -translation crlf


	# apro il file in scrittura e metto in file_id l'identificativo 
	# del file per poterlo scrivere successivamente
	if {[catch {set file_id [open $file_html w]}]} {
	    iter_return_complaint "File html degli esiti non aperto: $file_html"
	}
	# dichiaro di scrivere in formato iso West European
	fconfigure $file_id -encoding iso8859-1

	# apro il file in scrittura e metto in file_err_id l'identificativo 
	# del file per poterlo scrivere successivamente
	if {[catch {set file_scarti_id [open $file_scarti w]}]} {
	    iter_return_complaint "File csv dei record scartati non aperto: $file_scarti"
	}
	# dichiaro di scrivere in formato iso West European
	fconfigure $file_scarti_id -encoding iso8859-1

	if {![string equal $cod_acts_input ""]} {
	    if {[db_0or1row sel_acts ""] == 0} {
		set cod_distr ""
		set data_caric ""
	    }
	} else {
	    set cod_distr ""
	    set data_caric ""
	}

	if {![string equal $cod_distr ""]} {
	    if {[db_0or1row sel_dist ""] == 0} {
		set nome_dist ""
	    }
	    set nome_dist [string trim $nome_dist]
	    set cod_acts_list [list]
	    db_foreach sel_cods_acts "" {
		lappend cod_acts_list $cod_acts_dif
	    }
	    set cod_acts_list [join $cod_acts_list ","]
	} else {
	    set nome_dist ""
	    set cod_acts_list ""
	}

	if {![string equal $data_caric ""]} {
	    set save_data_caric [iter_edit_date $data_caric]
	    if {$save_data_caric != 0} {
		set data_caric $save_data_caric
	    } else {
		set data_caric [iter_edit_date $data_caric]
	    }
	}


	# modifica per comune di padova nel caso il fornitore sia APS: vado ad
	# aggiungere nel tracciato record il cod_via che ci viene fornito da 
	# APS 
	if {$flag_ente  == "C"
	&&  $denom_comu == "PADOVA"
	&&  $nome_dist  == "APS"
	} {
	    # definisco il tracciato record del file di input
	    set     carv_cols ""
	    lappend carv_cols "cod_aces"
	    lappend carv_cols "cod_aces_est"
	    lappend carv_cols "cod_acts"
	    lappend carv_cols "cod_cittadino"
	    lappend carv_cols "cod_impianto"
	    lappend carv_cols "cod_combustibile"
	    lappend carv_cols "natura_giuridica"
	    lappend carv_cols "cognome"
	    lappend carv_cols "nome"
	    lappend carv_cols "cod_via_aps"
	    lappend carv_cols "indirizzo"
	    lappend carv_cols "numero"
	    lappend carv_cols "esponente"
	    lappend carv_cols "scala"
	    lappend carv_cols "piano"
	    lappend carv_cols "interno"
	    lappend carv_cols "cap"
	    lappend carv_cols "localita"
	    lappend carv_cols "comune"
	    lappend carv_cols "provincia"
	    lappend carv_cols "cod_fiscale_piva"
	    lappend carv_cols "telefono"
	    lappend carv_cols "data_nas"
	    lappend carv_cols "comune_nas"
	    lappend carv_cols "stato_01"
	    lappend carv_cols "stato_02"
	    lappend carv_cols "note"
	    lappend carv_cols "consumo_annuo"
	    lappend carv_cols "tariffa"
	    lappend carv_cols "data_ins"
	    lappend carv_cols "data_mod"
	    lappend carv_cols "utente"
	} else {
	    # definisco il tracciato record del file di input
	    set     carv_cols ""
	    lappend carv_cols "cod_aces"
	    lappend carv_cols "cod_aces_est"
	    lappend carv_cols "cod_acts"
	    lappend carv_cols "cod_cittadino"
	    lappend carv_cols "cod_impianto"
	    lappend carv_cols "cod_combustibile"
	    lappend carv_cols "natura_giuridica"
	    lappend carv_cols "cognome"
	    lappend carv_cols "nome"
	    lappend carv_cols "indirizzo"
	    lappend carv_cols "numero"
	    lappend carv_cols "esponente"
	    lappend carv_cols "scala"
	    lappend carv_cols "piano"
	    lappend carv_cols "interno"
	    lappend carv_cols "cap"
	    lappend carv_cols "localita"
	    lappend carv_cols "comune"
	    lappend carv_cols "provincia"
	    lappend carv_cols "cod_fiscale_piva"
	    lappend carv_cols "telefono"
	    lappend carv_cols "data_nas"
	    lappend carv_cols "comune_nas"
	    lappend carv_cols "stato_01"
	    lappend carv_cols "stato_02"
	    lappend carv_cols "note"
	    lappend carv_cols "consumo_annuo"
	    lappend carv_cols "tariffa"
	    lappend carv_cols "data_ins"
	    lappend carv_cols "data_mod"
	    lappend carv_cols "utente"
	}

	set flag_leggi "S"
	set ctr_caricati   0
	set ctr_scartati   0
	# ctr_esistente sono i record presenti su aces
	set ctr_esistente  0
	# ctr_invariati sono i record presenti su aimp ma non aces
	set ctr_invariati  0
	set ctr_nuovo      0
	set ctr_totale     0


	# leggo e salto sempre la prima riga di testata
	iter_get_csv $leggifile file_inp_col_list

	# scrivo la riga di testata del file degli scarti
	set     file_out_col_list    $carv_cols
	lappend file_out_col_list    "motivo_scarto"
	iter_put_csv $file_scarti_id  file_out_col_list

	# leggo il primo record di dati
	iter_get_csv $leggifile file_inp_col_list

	while {![eof $leggifile]} {
	    set ctr_transaction        0
	    
	    db_transaction {
		while {![eof $leggifile]
		&&  $ctr_transaction < 1000
		   } {
		    incr ctr_transaction
		    
		    # valorizzo le relative colonne
		    set ind 0
		    foreach column_name $carv_cols {
			# set $column_name [lindex $file_inp_col_list $ind]
			# aggiunto trim x eliminare gli spazi non significativi
			set $column_name [string trim [lindex $file_inp_col_list $ind]]
			incr ind
		    }
		    
		    set carica "S"
		    
		    set natura_giuridica [string toupper $natura_giuridica]
		    
		    # nuova modifica perche' il file APS ha il campo 
		    # natura giuridica valorizzato con 0 o 1 
			switch $natura_giuridica {
			    "F" {}
			    "G" {}
			    "0" {set natura_giuridica "F"}
			    "1" {set natura_giuridica "G"}
			default {set carica           "N"
			 	 set motivo_scarto "Natura giuridica scorretta"
				 incr ctr_scartati}
			}
		    
		    set consumo_annuo [iter_check_num $consumo_annuo 2]
		    if {$consumo_annuo == "Error"} {
			set consumo_annuo 0
		    }

		    # Controlli
		    if {$carica == "S"
                    && (    [string is space $cognome]
			||  [string is space $indirizzo])
		    } {
			set carica "N"
			set motivo_scarto "Cognome o Indirizzo non valorizzati"
			incr ctr_scartati
		    }

		    if {$carica == "S"
		    && [string is space $numero]
		    } {
			# se numero e' null, provo ad estrappolarlo
			# dall'indirizzo.
			set indirizzo_old    $indirizzo
			set numero_old       $numero
			set indirizzo        ""
			set numero           ""
			set sw_iniz_num      "f"
			set ind              [string length $indirizzo_old]
			incr ind -1
			while {$ind >= 0} {
			    set ws_ind [string range $indirizzo_old $ind $ind]
			    if {$sw_iniz_num == "f"} {
				# metto in numero anche eventuali esponenti
				set numero ${ws_ind}${numero}

				if {[string is digit $ws_ind]} {
				    # inizia il numero vero e proprio
				    set sw_iniz_num "t"
				}
			    } else {
				if {[string is digit $ws_ind]
				||  [string equal $ws_ind "/"]
				||  [string equal $ws_ind "-"]
				} {
				    # metto nel numero le varie cifre
                                    # che lo compongono
				    set numero ${ws_ind}${numero}
				} else {
				    set indirizzo [string range $indirizzo_old 0 $ind]
				    break
				}
			    }

			    incr ind -1
			}

			if {$sw_iniz_num == "f"} {
			    # se non c'era alcun numero ripristino i valori
                            # di input
			    set indirizzo $indirizzo_old
			    set numero    $numero_old
			} else {
			    if {[string is space $indirizzo]} {
				# se indirizzo null + numero, ripristino input
				set indirizzo $indirizzo_old
				set numero    $numero_old
			    } else {
				# separazione indirizzo - numero effettuata
				# elimino N. , e spazi a destra dell'indirizzo
				set indirizzo [string trimright $indirizzo]
				set indirizzo [string trimright $indirizzo ","]
				set indirizzo [string trimright $indirizzo "N."]
				set indirizzo [string trimright $indirizzo]

			    }
			}
		    };#fine if string is space $numero

		    set numero [string trimleft $numero "0"]

		    if {$carica == "S"
		    && ![string is space $numero]
		    && ![string is digit $numero]
		    } {
			# se numero non e' numerico, separo la parte numerica
			# di sinistra mettendola in numero e la restante parte
			# mettendola nell'esponente.
			set numciv_espciv_list [iter_separa_numciv_espciv $numero]
			set numero_old    $numero
			set esponente_old $esponente
			set numero       [lindex $numciv_espciv_list 0]
			set esponente    [lindex $numciv_espciv_list 1]
			set msg_err      [lindex $numciv_espciv_list 2]

			set esponente    "${esponente_old}${esponente}"
			# ignoro eventuali messaggi di errore.
			# al massimo dentro al numero e' rimasto l'esponente.

		    };#fine if ![string is digit $numero]

		    if {$carica == "S"
		    && [string length $numero] > 8
		    } {
			set carica "N"
			set motivo_scarto "Numero troppo lungo"
			incr ctr_scartati
		    }

		    if {$carica == "S"
		    && [string length $esponente] > 3
		    } {
			set carica "N"
			set motivo_scarto "Esponente troppo lungo"
			incr ctr_scartati
		    }

		    if {$carica == "S"
   		    &&  ![string equal $cod_combustibile ""]
		    } {
			if {[db_0or1row sel_cod_comb ""] == 0} {
			    set carica "N"
			    set motivo_scarto "Combustibile non esistente in anagrafica"
			    incr ctr_scartati
			} else {
			    set cod_combustibile $cod_comb
			}
		    }
		    if {$carica == "S"
                    &&  [db_0or1row get_cod_comu ""] == 0
		    } {
			set carica "N"
			set motivo_scarto "Comune non presente in anagrafica"
			incr ctr_scartati
			set cod_com ""
		    }
		    if {$carica == "S"
		    &&  [db_0or1row get_cod_prov ""] == 0
		    } {
			set carica "N"
			set motivo_scarto "Provincia non presente in anagrafica"
			incr ctr_scartati
			set cod_prv ""
		    }
		    if {$carica == "S"
		    &&  $flag_viario == "T"
		    &&  ![string equal $cod_com ""]
		    } {
			# modifica comune padova + APS
			if {$flag_ente  == "C"
			&&  $denom_comu == "PADOVA"
			&&  $nome_dist  == "APS"
			} {
			    if {[db_0or1row sel_indir ""]== 1} {
				set where_topon_indiriz "and descr_topo||' '||descr_estesa = upper(:indirizzo_xaps)"
			    } else {
				set where_topon_indiriz "and descr_topo||' '||descr_estesa = upper(:indirizzo)"
			    }
			} else {
			    set where_topon_indiriz "and descr_topo||' '||descr_estesa = upper(:indirizzo)"
			}
			if {[db_0or1row sel_cod_viae ""] == 0} {
			    # in qeusto caso non scarto il record perche' 
			    # potremmo avere delle vie scritte male
			    set cod_via ""
			}
		    }

		    incr ctr_totale
		    
		    if {$carica == "S"} {
			incr ctr_caricati

			if {![string equal $cod_acts_list ""]} {
			    set where_cod_acts  "and cod_acts in ($cod_acts_list)"
			} else {
			    set where_cod_acts ""
			}

			if {[string equal $cod_aces_est ""]} {
			    set where_cod_aces_est " is null"
			} else {
			    # modifica per comune di padova: vado a 
			    # fare un lpad del campo cod_aces_est con 
			    # il carattere "0" (zero) per una lunghezza
			    # totale di 8 carattire
			    if {$flag_ente  == "C"
			    &&  $denom_comu == "PADOVA"
			    } {
				set where_cod_aces_est "  = ltrim(upper(:cod_aces_est),'0')"
			    } else {
				set where_cod_aces_est "  = upper(:cod_aces_est)"
			    }
			    # fine modifica per comune di padova
			    #	set where_cod_aces_est "= :cod_aces_est"
			}
			
			if {[string equal $cod_combustibile ""]} {
			    set where_cod_combustibile " is null"
			} else {
			    set where_cod_combustibile "= :cod_combustibile"
			}
			set where_cognome_nome [db_map set_where_cognome_nome]
			if {[string equal $indirizzo ""]} {
			    set where_indirizzo "is null"
			} else {
			    set where_indirizzo "= upper(:indirizzo)"
			}
			if {[string equal $numero ""]} {
			    set where_numero "is null"
			} else {
			    set where_numero "= :numero"
			}
#			if {[string equal $esponente ""]} {
#			    set where_esponente "is null"
#			} else {
#			    set where_esponente "= upper(:esponente)"
#			}
#			if {[string equal $scala ""]} {
#			    set where_scala "is null"
#			} else {
#			    set where_scala "= upper(:scala)"
#			}
#			if {[string equal $piano ""]} {
#			    set where_piano " is null"
#			} else {
#			    set where_piano "= upper(:piano)"
#			}
#			if {[string equal $interno ""]} {
#			    set where_interno " is null"
#			} else {
#			    set where_interno " = upper(:interno)"
#			}
#			if {[string equal $localita ""]} {
#			    set where_localita " is null"
#			} else {
#			    set where_localita "= upper(:localita)"
#			}
			if {[string equal $comune ""]} {
			    set where_comune "is null"
			} else {
			    set where_comune "= upper(:comune)"
			}
			if {[string equal $provincia ""]} {
			    set where_provincia " is null"
			} else {
			    set where_provincia "= upper(:provincia)"
			}
			if {[string equal $cod_fiscale_piva ""]} {
			    set where_cod_fiscale_piva " is null"
			} else {
			    set where_cod_fiscale_piva "= upper(:cod_fiscale_piva)"
			}
			
			if {[string equal $data_nas ""]} {
			    set where_data_nas " is null"
			} else {
			    set where_data_nas "= :data_nas"
			}
			if {[string equal $comune_nas ""]} {
			    set where_comune_nas " is null"
			} else {
			    set where_comune_nas "= upper(:comune_nas)"
			}
			db_1row sel_aces_count ""
			set stato_02 ""
			if {$conta > 0} {
			    incr ctr_esistente
			    set stato_01 "E"
			} else {
			    set flag_nuovo_aces "t"
			    set stato_01 "D"
				
 ## Controllo tutti i record della coimaces con stato D (da analizzare) e li
 ## confronto con quelli sulla coimaimp per rilevare gli impianti invariati.
 ## Per questi modifico lo stato sulla aces da D a I (invariato sulla coimaimp)
				    	    
			    if {![string equal $cod_distr ""]} {
				set where_dist "and cod_distributore = :cod_distr"
			    } 
			    set conta_aimp 0
			    #ricerco stesso codice utenza
			    
			    if {![string equal $cod_aces_est ""]} {
				# modifica per comune di padova: vado a 
				# fare un lpad del campo cod_aces_est con 
				# il carattere "0" (zero) per una lunghezza
				# totale di 9 caratteri
				if {$flag_ente  == "C"
				&&  $denom_comu == "PADOVA"
				} {
				    set where_cod_amag "  = ltrim(upper(:cod_aces_est),'0')"
				} else {
				    set where_cod_amag "  = upper(:cod_aces_est)"
				}
				# fine modifica per comune di padova
			    } 

			    set flag_continua "f"
			    if {![string equal $cod_distr ""]
			    &&  ![string equal $cod_aces_est ""]
			    } {
				db_1row  sel_count_aimp1 ""
			    } else {
				set conta_aimp 1
			    }

			    if {$conta_aimp > 0} { 
				if {![string equal $cod_com ""]} {
				    set where_comu "and a.cod_comune = :cod_com"
				} else {
				    set where_comu ""
				}				   
				
				if {$flag_viario == "T"} {
				    # modifica per comune di padova: vado a 
				    # fare un lpad del campo cod_via_apst con 
				    # il carattere "0" (zero) per una lunghezza
				    # totale di 5 carattire
				    if {$flag_ente  == "C"
				    &&  $denom_comu == "PADOVA"
				    &&  $nome_dist  == "APS"
				    } {
					if {![string equal $cod_via_aps ""]} {
					    set where_via "and cod_via = lpad(:cod_via_aps,5,'0') "
					} else {
					    set where_via ""
					}
				    } else {
					if {![string equal $cod_via ""]} {
					    set where_via "and cod_via = :cod_via"
					} else {
					    set where_via ""
					}
				    }
				} else {
				    if {![string equal $indirizzo ""]} {
					set where_via "and a.toponimo||' '||a.indirizzo = upper(:indirizzo)"
					
				    } else {
					set where_via ""
				    }
				}
#				if {![string equal $esponente ""]} {
#				    set where_espo "and a.esponente = upper(:esponente)"
#				} else {
#				    set where_espo ""
#				}
#				if {![string equal $scala ""]} {
#				    set where_scala "and a.scala = upper(:scala)"
#				} else {
#				    set where_scala ""
#				}
#				if {![string equal $piano ""]} {
#				    set where_piano "and a.piano = upper(:piano)"
#				} else {
#				    set where_piano ""
#				}
#				if {![string equal $interno ""]} {
#				    set where_inte "and a.interno = upper(:interno)"
#				} else {
#				    set where_inte ""
#				}
				

				if {![string equal $cod_prv ""]} {
				    set where_prov "and a.cod_provincia = :cod_prv"
				} else {
				    set where_prov ""
				}
				set conta_aimp 0	

				#ricerco stessa ubicazione
				db_1row  sel_count_aimp2 ""
				if {$conta_aimp > 0} {
				    	   
				    set where_cogn_nome [db_map where_cogn_nome]
				    if {![string equal $cod_com ""]} {
					set where_comu "and b.cod_comune = :cod_com"
				    } else {
					set where_comu ""
				    }				   
				
				    if {$flag_viario == "T"} {
					if {![string equal $cod_via ""]} {
					    set where_via "and b.cod_via = :cod_via"
					} else {
					    set where_via ""
					}
				    } else {
					if {![string equal $indirizzo ""]} {
					    # modifica per comune padova
					    if {$flag_ente  == "C"
					    &&  $denom_comu == "PADOVA"
				            &&  $nome_dist  == "APS"
					    } {
						set where_via "and b.toponimo||'  '||b.indirizzo = upper(:indirizzo)"
					    } else {
						set where_via "and b.toponimo||' '||b.indirizzo = upper(:indirizzo)"
					    }
					} else {
					    set where_via ""
					}
				    }

				    if {![string equal $cod_fiscale_piva ""]} {
					set where_piva "and a.cod_fiscale = upper(:cod_fiscale_piva)"
				    } else {
					set where_piva "and a.cod_fiscale is null"
				    }
				    set conta_aimp 0
				    
				    #ricerco stesso soggetto
				    db_1row  sel_count_aimp3-1 ""
				    db_1row  sel_count_aimp3-2 ""
				    db_1row  sel_count_aimp3-3 ""
				    if {$conta_aimp1 > 0
				    ||  $conta_aimp2 > 0
				    ||  $conta_aimp3 > 0
				    } {
					# cambio lo stato al record della aces
					set stato_01 "I"
					incr ctr_invariati
				    } else {
					incr ctr_nuovo
					# scarto per nominativo
					set stato_02 "N"
				    }
				} else {
				    # scarto per indirizzo
				    set stato_02 "I"
				}
			    } else {
				# scarto per codice
				set stato_02 "C"
			    }
			}
			db_1row sel_aces_2  ""
			set cod_cittadino ""
			set cod_impianto  ""
			set data_ins      $data_corrente
			set utente        $id_utente
				    
			# modifica per comune di padova: vado a fare un
			# lpad del campo cod_aces_est con il carattere "0" 
			# (zero) per una lunghezza totale di 8 carattire
			
			if {$flag_ente  == "C"
			&&  $denom_comu == "PADOVA"
			} {
			    set ins_cod_aces_est " ltrim(upper(:cod_aces_est),'0')"
			} else {
			    set ins_cod_aces_est ":cod_aces_est"
			}

			# fine modifica per comune di padova
			set dml_ins_aces [db_map ins_aces]
			# Lancio la query di manipolazione 
			# dati contenute in dml_sql
			if {[info exists dml_ins_aces]} {
			    db_dml dml_coimaces $dml_ins_aces
			}			
		    } else {
			# ricostruisco il record di output
			# set file_out_col_list ""
			# set ind 0
			# foreach column_name $carv_cols {
			#    lappend file_out_col_list [set $column_name]
			#    incr ind
			# }

			# dato che le variabili vengono trattate nel programma
			# ma si desidera scrivere esattamente cio' che e' stato
			# letto, valorizzo il record di output esattamente
			# con quello di input.
			set file_out_col_list     $file_inp_col_list
			lappend file_out_col_list $motivo_scarto
			iter_put_csv $file_scarti_id file_out_col_list
			#			    incr ctr_scartati
		    }
		    # lettura del record successivo
		    iter_get_csv $leggifile file_inp_col_list
		}
		
		## la statistica "invariati" e': tot invariat su
		## aimp + tot esistenti su aces
		set ctr_invariati_t   [expr $ctr_invariati +  $ctr_esistente]
		set ctr_da_analizzare [expr $ctr_caricati  -  $ctr_invariati_t]

		if {[eof $leggifile]} {
		    if {$ctr_da_analizzare == 0} {
			set stato_acts "C"
		    } else {
			set stato_acts "E"
		    }
		} else {
		    set stato_acts "I"
		}
		set dml_upd_acts [db_map upd_acts]
		db_dml dml_coimaces2 $dml_upd_acts
	    }
	}

    	set ctr_caricati_edit  [iter_edit_num $ctr_caricati]
	set ctr_scartati_edit  [iter_edit_num $ctr_scartati]
	set ctr_invariati_edit [iter_edit_num $ctr_invariati_t]
	set ctr_da_analizzare_edit [iter_edit_num $ctr_da_analizzare]
	set ctr_nuovo_edit     [iter_edit_num $ctr_nuovo]
	set ctr_totale_edit    [iter_edit_num $ctr_totale]

	puts $file_id "
            <center>
            <table align=center>
            <tr>
               <td align=center><big><b>Caricamento dati effettuato</b></big></td>
            </tr>
            <tr>
               <td align=center>Fornitore di energia: <b>$nome_dist</b></td>
            </tr>
            <tr>
               <td align=center>Data caricamento: <b>$data_caric</b></td>
            </tr>
            </table>
            <br>
            <table align=center border=1 cellspacing=1>
            <tr>
               <td align=center colspan=3><b>Risultati caricamento</b></td>
            </tr>
            <tr>
               <td align=left>Caricati totali</td>
               <td>&nbsp;</td>
               <td align=right><b>$ctr_caricati_edit</b></td>
            </tr>
            <tr>
               <td>&nbsp;</td>
               <td align=left>di cui da analizzare</td>
               <td align=right><b>$ctr_da_analizzare_edit</b></td>
            </tr>
            <tr>
               <td>&nbsp;</td>
               <td align=left>di cui esistenti</td>
               <td align=right><b>$ctr_invariati_edit</b></td>
            </tr>
            <tr>
               <td align=left>Scartati</td>
               <td>&nbsp;</td>
               <td align=right><b>$ctr_scartati_edit</b></td>
            </tr>
            <tr>
               <td align=left>Totale</td>
               <td>&nbsp;</td>
               <td align=right><b>$ctr_totale_edit</b></td>
            </tr>
            </table>"
	close $file_id

#######

	iter_crea_pdf [list exec htmldoc --webpage --header ... --footer ... --quiet --bodyfont arial --left 1cm --right 1cm --top 0cm --footer ... --bottom 0cm --landscape -f $file_pdf $file_html]

	ns_unlink $file_html

	set esit_list     ""
	set esit_riga     [list "Esito" $file_pdf_url $file_pdf]
	set scar_riga     [list "Scarti" $file_scarti_url $file_scarti]
	lappend esit_list $esit_riga
	if {$ctr_scartati > 0} {
	    lappend esit_list $scar_riga
	}
	iter_batch_upd_flg_sta -fine $cod_batc $esit_list

	# fine with_catch    
    } {
	iter_batch_upd_flg_sta -abend $cod_batc
	ns_log Error "iter_car_aces: $error_msg"
    }
    return
}

