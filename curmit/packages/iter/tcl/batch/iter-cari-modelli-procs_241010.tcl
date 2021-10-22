ad_proc iter_cari_modelli {
    {
	-cod_batc      ""
        -id_utente     ""
	-file_name     ""
	-nome_tabella  ""
    }
} {
    Elaborazione     Caricamento controlli/modelli per manutentori
    @author          Gianni Prosperi
    @creation-date   28/08/2007
    @cvs-id          iter_cari_manu

    se swc_solo_aimp vale "S" allora non si creano i controlli
} {

    # aggiorno stato di coimbatc
    iter_batch_upd_flg_sta -iniz $cod_batc
    
    
#    ns_log Notice "Inizio della procedura iter-cari-modelli-g ... id_utente = $id_utente file_name = $file_name nome_tabella = $nome_tabella"
    
    with_catch error_msg {
	
	if {![string equal $nome_tabella ""]} {
	    set nome_tabella_anom [string map {GCARI ANOM} $nome_tabella]
	    set nome_sequence $nome_tabella
	    append nome_sequence "_s"
	    db_dml upd_table   "update $nome_tabella set flag_stato = null, numero_anomalie = null, cod_impianto_catasto = null, gen_prog_catasto = null where flag_stato = 'P'"
	    db_dml delete_anom "delete from $nome_tabella_anom where id_riga in (select id_riga from $nome_tabella where flag_stato is null)"
	}
	
	# reperisco le colonne della tabella parametri
	iter_get_coimtgen
	set flag_cod_aimp_auto $coimtgen(flag_cod_aimp_auto)
	set flag_codifica_reg  $coimtgen(flag_codifica_reg)
	
	set stato_tgen [db_string sel_stato_tgen "select cod_imst_cari_manu as stato_tgen from coimtgen"]
	set flag_scarta_via_nt [db_string sel_stato_tgen "select flag_scarta_via_nt from coimtgen"]
	set flag_cod_imp_obblig [db_string sel_stato_tgen "select flag_cod_imp_obblig from coimtgen"]
	set flag_portafoglio [db_string sel_tgen_portafoglio "select flag_portafoglio from coimtgen"]
	set num_anom_max [db_string sel_num_anom_max "select num_anom_max from coimtgen"]

	#provvisori
	set tariffa_reg ""
	set importo_contr ""	
	
	# valorizzo la data_corrente (serve per l'inserimento)
	set data_corrente  [iter_set_sysdate]
	set ora_corrente   [iter_set_systime]
	
	set permanenti_dir [iter_set_permanenti_dir]
	set permanenti_dir_url [iter_set_permanenti_dir_url]
	
	#se non mi viene passato il nome della tabella da analizzare significa che  un nuovo caricamento
	if {[string equal $nome_tabella ""]} {
	    set file_inp_name  "Caricamento-manutentori-input"
	    set file_inp_name  [iter_temp_file_name -permanenti $file_inp_name]
	    
	    set file_table_name  "create-table"
	    set file_table_name  [iter_temp_file_name -permanenti $file_table_name]
	}
	
	set file_esi_name  "Caricamento-manutentori-esito"
	set file_esi_name  [iter_temp_file_name -permanenti $file_esi_name]
	
	set file_err_name  "Caricamento-manutentori-scartati"
	set file_err_name  [iter_temp_file_name -permanenti $file_err_name]
	
	set file_tot_name  "Caricamento-manutentori-file"
	set file_tot_name  [iter_temp_file_name -permanenti $file_tot_name]
	
	# salvo i file di output come .txt in modo che excel permetta di
	# indicare il formato delle colonne (testo) al momento
	# dell'importazione del file.
	# in caso contrario i numeri di telefono rimarrebbero senza lo zero
	# ed i civici 8/10 diverrebbero una data!
	# bisogna fare in modo che excel apra correttamente il file
	# degli scarti perche' l'utente potrebbe correggere gli errori
	# e provare a ricaricarli.
	if {[string equal $nome_tabella ""]} {
	    set file_inp       "${permanenti_dir}/$file_inp_name.csv"
	    set file_inp_url   "${permanenti_dir_url}/$file_inp_name.csv"
	    # rinomino il file (che per ora ha lo stesso nome di origine)
	    # con un nome legato al programma ed all'ora di esecuzione
	    file rename -force $file_name $file_inp
	}
	set file_esi       "${permanenti_dir}/$file_esi_name.adp"
	set file_err       "${permanenti_dir}/$file_err_name.txt"
	set file_tot       "${permanenti_dir}/$file_tot_name.txt"
	# in file_esi_url non metto .adp altrimenti su vestademo non
	# viene trovata la url!!
	set file_esi_url   "${permanenti_dir_url}/$file_esi_name"
	set file_err_url   "${permanenti_dir_url}/$file_err_name.txt"
	set file_tot_url   "${permanenti_dir_url}/$file_tot_name.txt"
	
	if {[string equal $nome_tabella ""]} {
	    # apro il file in lettura e metto in file_inp_id l'identificativo
	    # del file per poterlo leggere successivamente
	    if {[catch {set file_inp_id [open $file_inp r]}]} {
		iter_return_complaint "File csv di input non aperto: $file_inp"
	    }
	    # dichiaro di leggere in formato iso West European e di utilizzare
	    # crlf come fine riga (di default andrebbe a capo anche con gli
	    # eventuali lf contenuti tra doppi apici).
	    fconfigure $file_inp_id -encoding iso8859-15
	}	
	
	# apro il file in scrittura e metto in file_esi_id l'identificativo
	# del file per poterlo scrivere successivamente
	if {[catch {set file_esi_id [open $file_esi w]}]} {
	    iter_return_complaint "File di esito caricamento non aperto: $file_esi"
	}
	# dichiaro di scrivere in formato iso West European
	fconfigure $file_esi_id -encoding iso8859-15 -translation crlf
	
	# apro il file in scrittura e metto in file_err_id l'identificativo
	# del file per poterlo scrivere successivamente
	if {[catch {set file_err_id [open $file_err w]}]} {
	    iter_return_complaint "File csv dei record scartati non aperto: $file_err"
	}
	# dichiaro di scrivere in formato iso West European
	fconfigure $file_err_id -encoding iso8859-15
	
	
	# apro il file in scrittura e metto in file_tot_id l'identificativo
	# del file per poterlo scrivere successivamente
	if {[catch {set file_tot_id [open $file_tot w]}]} {
	    iter_return_complaint "File csv dei record scartati non aperto: $file_tot"
	}
	# dichiaro di scrivere in formato iso West European
	fconfigure $file_tot_id -encoding iso8859-15
	
	
	# PRIMO STEP: Controllo che il file riporti lo stesso manutentore su tutte le righe (Nel caso di utente manutentore deve riportare la sua ditta)
	set cod_manutentore_chk [iter_check_uten_manu $id_utente]
	
	# preparo e scrivo scrivo la riga di intestazione per file out
	set     head_cols ""
	
	# definisco il tracciato record del file di input
	set     file_cols ""
	# Setto il nome della tabella da cui leggere le intestazioni
	set csv_name "modellog"
	set count_fields 0
	# Eseguo la query che reperisce i campi della lista dal db
	db_foreach sel_liste_csv "select nome_colonna
     	                               , denominazione
	                               , tipo_dato
	                               , dimensione
	                               , obbligatorio
	                               , default_value
	                               , range_value
	                            from coimtabs 
	                            where nome_tabella = :csv_name 
	                         order by ordinamento" {

				     lappend head_cols $denominazione
				     
				     # Popolo i campi della lista
				     lappend file_cols $nome_colonna
				     
				     #Memorizzo in un array tutti i dati relativi ad un singoloo campo, necessari per la successiva analisi
				     set file_fields($count_fields) [list $nome_colonna $denominazione $tipo_dato $dimensione $obbligatorio $default_value $range_value]
				     incr count_fields		
				 }

	set err_log ""
        if {[string equal $nome_tabella ""]} {
	    # Setto la lunghezza standard del tracciato in base ai campi letti dal database
	    set lunghezza_attesa [expr $count_fields]
	    
	    # Salto il primo record che deve essere di testata
	    iter_get_csv $file_inp_id file_inp_col_list |
	    
	    # Ciclo di lettura sul file di input
	    # uso la proc perche' i file csv hanno caratteristiche 'particolari'
	    iter_get_csv $file_inp_id file_inp_col_list |
	    set lunghezza_letta [llength $file_inp_col_list]
	    
#ns_log notice "prova dob  inizio ciclo lettura file di input"
	    while {![eof $file_inp_id]} {
		# valorizzo le relative colonne
		set ind 0

#ns_log notice "prova dob  file_cols = $file_cols"


		foreach column_name $file_cols {

#ns_log notice "prova dob colonna $column_name indice $ind contenuto $file_inp_col_list "

		    set $column_name [lindex $file_inp_col_list $ind]
		    incr ind
		}

#ns_log notice "prova dob valorizzate colonne"
		
		if {$lunghezza_letta == $lunghezza_attesa
		    || $lunghezza_letta == [expr $lunghezza_attesa + 6]} {

#ns_log notice "prova dob cod_manutentore_chk $cod_manutentore_chk"
		    
		    if {[string equal $cod_manutentore_chk ""]} {
				set cod_manutentore_chk $cod_manutentore
		    } else {
				if {$cod_manutentore != $cod_manutentore_chk
				    || [string equal $cod_manutentore ""]} {
				    append err_log "L'intero lotto &egrave; stato scartato in quanto l'utente che effettua il caricamento non corrisponde alla ditta presente nel file."
				    break
				}
		    }
		} else {
		    append err_log "L'intero lotto &egrave; stato scartato in quanto una o pi&ugrave; righe hanno lunghezza diversa rispetto a quella prevista (lunghezza letta: $lunghezza_letta lunghezza prevista: $lunghezza_attesa)."
		    break
		}
		
		
		# lettura del record successivo
		iter_get_csv $file_inp_id file_inp_col_list |
		set lunghezza_letta [llength $file_inp_col_list]
	    }
	    
	    if {[string equal $err_log ""]} {
		if {[db_0or1row sel_cari_manu "select '1' from coimcari_manu where cod_manutentore = :cod_manutentore"]} {
		    append err_log "L'intero lotto &egrave; stato scartato in quanto la ditta di manutenzione con codice $cod_manutentore sta gi&agrave effettuando un caricamento su questo ente."
		}
	    }
	    
	    if {[string equal $err_log ""]} {
		
		db_dml ins_cari "insert into coimcari_manu (cod_manutentore) values (:cod_manutentore)"
		
		# Creo la tabella temporanea e la carico
		set nome_tabella "GCARI_"
		append nome_tabella $cod_manutentore
		append nome_tabella "_"
		append nome_tabella $data_corrente
		append nome_tabella "_"
		set ora_corrente_edit [string map {: _}  $ora_corrente]
		append nome_tabella $ora_corrente_edit
		set nome_tabella_anom "ANOM_"
		append nome_tabella_anom $cod_manutentore
		append nome_tabella_anom "_"
		append nome_tabella_anom $data_corrente
		append nome_tabella_anom "_"
		append nome_tabella_anom $ora_corrente_edit
		
		append sql "create table $nome_tabella
                                        ( "
		
		set i 0
		while {$i < $count_fields} {
		    
		    util_unlist $file_fields($i) nome_colonna denominazione type dimensione obbligatorio default_value range_value
		    if {![string equal $dimensione ""]} {
			set virgola [string first "," $dimensione]
			if {$virgola > 0} {
			    set dimensione 30
			} else {
			    set dimensione [expr $dimensione + 10]
			}
		    } else {
			set dimensione 10
		    }
		    
		    append sql "$nome_colonna   varchar($dimensione)
                                     , "
		    incr i
		}
		
		set nome_index $nome_tabella
		append nome_index "_00"
		set nome_sequence $nome_tabella
		append nome_sequence "_s"
		append sql "id_riga            varchar(08)
                                 , flag_stato           char (01)
                                 , numero_anomalie      integer 
                                 , cod_impianto_catasto varchar(08)
                                 , gen_prog_catasto     varchar(08) );

                                 create unique index $nome_index
                                     on $nome_tabella
                                   ( id_riga);

                                 create sequence $nome_sequence start 1;

                                 create table $nome_tabella_anom
                                            ( id_riga          varchar(08)
                                            , cod_manutentore  varchar(08)
                                            , nome_colonna     varchar(40)
                                            , desc_errore      varchar(1000)
                                            );
                                "
		
                db_exec_plsql query $sql
		
		if {[catch {set file_inp_id [open $file_inp r]}]} {
		    iter_return_complaint "File csv di input non aperto: $file_inp"
		}
		
		# Salto il primo record che deve essere di testata
		iter_get_csv $file_inp_id file_inp_col_list |
		
		# Ciclo di lettura sul file di input
		# uso la proc perche' i file csv hanno caratteristiche particolari
		iter_get_csv $file_inp_id file_inp_col_list |
		
		while {![eof $file_inp_id]} {
		    
		    set i 0
		    set variabili_da_ins ""
		    while {$i < $count_fields} {
			
			set colonna [lindex $file_inp_col_list $i]
			set colonna [string trim $colonna]

			util_unlist $file_fields($i) campo titolo tipo dimensione obblig valore valorepossibile
			if {$campo != "matricola" && $campo != "modello"} { 
			    set colonna [string toupper $colonna]
			}

			# Bonifico l'elemento da possibili caratteri che non vengono accettati dal database
			set colonna [string map {\\ "" \r " " \n " " \r\n " " ' "''"} $colonna]
			
			if {$i > 0} {
			    append variabili_da_ins ","
			}
			append variabili_da_ins "'$colonna'"
			
			incr i
		    }
		    
		    db_dml ins_tabs "insert into $nome_tabella
                                             values ( $variabili_da_ins , nextval('$nome_sequence'), null, 0 )"
		    
		    
		    # lettura del record successivo
		    iter_get_csv $file_inp_id file_inp_col_list |
		}
		close $file_inp_id
	    }
	}
	
	#setto un array contenente tutti i codici delle anomalie per verificare la loro esistenza durante il caricamento dei modelli
	db_foreach sel_cod_tanom "select cod_tano as codice_anomalia from coimtano" {
	    set anomalie($codice_anomalia) 1
	    
	}
	# Setto una sola volta l'array dei comuni possibili all'interno dell'ente
	db_foreach sel_comuni "select cod_comune , 
                                      denominazione as nome_comune 
                                 from coimcomu
                                where cod_comune <> 'ZZZZZZZZ' " {
	    set comuni($nome_comune) $cod_comune
	}
	# Setto una sola volta l'array delle province
	db_foreach sel_prov "select cod_provincia as cod_prov, sigla as sigla_prov from coimprov" {
	    set province($sigla_prov) $cod_prov
	}
	# Setto una sola volta l'array dei combustibili
	db_foreach sel_comb "select cod_combustibile, descr_comb from coimcomb" {
	    set combustibili($descr_comb) $cod_combustibile
	}
	# Setto una sola volta l'array dei costruttori
	db_foreach sel_cost "select cod_cost, descr_cost from coimcost" {
	    set costruttori($descr_cost) $cod_cost
	}
	
	if {[string equal $err_log ""]} {
	    
	    db_foreach sel_coimcari_manu "select * from $nome_tabella where flag_stato is null" {
		set errori 0
		set i 0
		while {$i < $count_fields} {
		    
		    util_unlist $file_fields($i) col_name denominazione type dimension obbligatorio default_value range_value
		    incr i
		    
		    set colonna [set $col_name]
		    if {[string equal $colonna ""]} {
			if {[string equal $obbligatorio "S"]} {
			    if {(![string equal $data_rottamaz_gen ""]
				&& ($col_name == "matricola"
				    || $col_name == "modello"
				    || $col_name == "combustibile"
				    || $col_name == "cod_manutentore"
				    || $col_name == "cod_fiscale_resp"
				    || $col_name == "potenza_utile_nom"
				    || $col_name == "potenza_foc_nom"
				    || $col_name == "toponimo"
				    || $col_name == "indirizzo"
				    || $col_name == "comune"
				    || $col_name == "provincia"
				    || $col_name == "marca"
				    || $col_name == "flag_responsabile"))
				    || [string equal $data_rottamaz_gen ""]} {				
				set valori_possibili ""
				if {![string equal $range_value ""]} {
				    set valori_possibili "con $range_value"
				}
				set desc_errore "Il campo &egrave; obbligatorio. Valorizzare $valori_possibili."
				incr errori
				db_dml ins_anom "insert into $nome_tabella_anom values ( :id_riga , :cod_manutentore, :col_name , :desc_errore )"
			    }
			}
		    } else {

			if {(![string equal $data_rottamaz_gen ""]
			     && ($col_name == "matricola"
				 || $col_name == "modello"
				 || $col_name == "combustibile"
				 || $col_name == "cod_manutentore"
				 || $col_name == "cod_fiscale_resp"
				 || $col_name == "potenza_utile_nom"
				 || $col_name == "potenza_foc_nom"
				 || $col_name == "toponimo"
				 || $col_name == "indirizzo"
				 || $col_name == "comune"
				 || $col_name == "provincia"
				 || $col_name == "marca"
				 || $col_name == "flag_responsabile"))
			    || [string equal $data_rottamaz_gen ""]} {							
			    switch $type {
				date {
				    set colonna [string map {- ""}  $colonna]
				    set date [iter_edit_date $colonna]
				    if {[iter_check_date $date] == "0"} {
					set desc_errore "Il campo deve essere una data (in formato AAAA-MM-GG)"
					incr errori
					db_dml ins_anom "insert into $nome_tabella_anom values ( :id_riga , :cod_manutentore, :col_name , :desc_errore )"
				    }
				}
				numeric {
				    set int_dec [split $dimension \,]
				    util_unlist $int_dec intero decimale
				    if {[iter_edit_num $colonna $decimale] != "Error"} {
					
					set element_int_dec [split $colonna \.]
					util_unlist $element_int_dec parte_intera parte_decimale
					set max_value [expr pow(10,[expr $intero - $decimale]) - 1]
					
					if {($parte_intera > [expr $max_value - 1]) || ($parte_intera < [expr (-1 * $max_value) +1])} {
					set desc_errore "Il campo deve essere numerico di [expr $intero-$decimale] cifre"
					    incr errori
					    db_dml ins_anom "insert into $nome_tabella_anom values ( :id_riga , :cod_manutentore, :col_name , :desc_errore )"
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
						    set desc_errore "Il campo deve assumere uno dei seguenti valori: '$range_value'"
						    incr errori
						    db_dml ins_anom "insert into $nome_tabella_anom values ( :id_riga , :cod_manutentore, :col_name , :desc_errore )"
						}			
					    }
					}			    		     
					set max_value [expr pow(10,$decimale)]
					if {($parte_decimale > [expr $max_value - 1])} {
					    set desc_errore "Il campo deve avere $decimale cifre decimali"
					    incr errori
					    db_dml ins_anom "insert into $nome_tabella_anom values ( :id_riga , :cod_manutentore, :col_name , :desc_errore )"
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
						    set desc_errore "Il campo deve assumere uno dei seguenti valori: '$range_value'"
						    incr errori
						    db_dml ins_anom "insert into $nome_tabella_anom values ( :id_riga , :cod_manutentore, :col_name , :desc_errore )"
						}   
					    }	
					}
					
				    } else {
					set desc_errore "Il campo deve essere un numero (per i decimali usare il separatore . )"
					incr errori
					db_dml ins_anom "insert into $nome_tabella_anom values ( :id_riga , :cod_manutentore, :col_name , :desc_errore )"
				    }
				}
				
				varchar {
				    set colonna [string toupper $colonna]
				    set colonna_length [string length $colonna]
				    if {$colonna_length > $dimension} {
					set desc_errore "Il campo deve essere al massimo di $dimension caratteri"
					incr errori
					db_dml ins_anom "insert into $nome_tabella_anom values ( :id_riga , :cod_manutentore, :col_name , :desc_errore )"
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
						set desc_errore "Il campo deve assumere uno dei seguenti valori: '$range_value'"
						incr errori
						db_dml ins_anom "insert into $nome_tabella_anom values ( :id_riga , :cod_manutentore, :col_name , :desc_errore )"
					    }
					}
				    }
				}
			    }
			}
		    }
		}
		
		if {$errori > 0} {
		    if {$errori > $num_anom_max} {
			db_dml upd_riga "update $nome_tabella set numero_anomalie = :errori , flag_stato = 'S' where id_riga = :id_riga"
		    } else {
			set cod_comune_chk ""
			if {![string equal $comune ""]} {
			    if {![info exist comuni($comune)]} {
				set desc_errore "Comune inesistente"
				incr errori
				db_dml ins_anom "insert into $nome_tabella_anom values ( :id_riga , :cod_manutentore, 'comune' , :desc_errore )"
			    } else {
				set cod_comune_chk $comuni($comune)
			    }
			}
			if {![string equal $toponimo ""] && ![string equal $indirizzo ""] && ![string equal $cod_comune_chk ""]} {
			    # Controllo sull'indirizzo		    
			    if {$coimtgen(flag_viario) == "F"} {
				set where_indirizzo "and upper(toponimo) = :toponimo
	                                                         and upper(indirizzo) = :indirizzo"
			    } else {
				if {[db_0or1row sel_viae_check "select cod_via
	  	                                                              from coimviae
	  	                                                             where upper(descr_topo)  = :toponimo
		                                                               and upper(descrizione) = :indirizzo
	                                                                       and cod_via_new is null
		                                                               and cod_comune = :cod_comune_chk
	                                                                       limit 1"]} {
				    set where_indirizzo "and cod_via = :cod_via"
				} else {
				    set desc_errore "Indirizzo inesistente nel viario"
				    incr errori
				    db_dml ins_anom "insert into $nome_tabella_anom values ( :id_riga , :cod_manutentore, 'indirizzo' , :desc_errore )"
				    db_dml ins_anom "insert into $nome_tabella_anom values ( :id_riga , :cod_manutentore, 'toponimo' , null )"
				}
			    }
			}
			db_dml upd_riga "update $nome_tabella set numero_anomalie = :errori , flag_stato = 'P' where id_riga = :id_riga"
		    }
		} else {

		    #superati controlli integrita eseguo controlli esistenza: comune provincia responsabile
		    # indirizzo costruttore costruttore bruciatore operatore manutentore combustibile
		    
		    # Controllo sul comune dell'impianto
		    set cod_comune_chk ""
		    if {![info exist comuni($comune)]} {
			set desc_errore "Comune inesistente"
			incr errori
			db_dml ins_anom "insert into $nome_tabella_anom values ( :id_riga , :cod_manutentore, 'comune' , :desc_errore )"
		    } else {
			set cod_comune_chk $comuni($comune)
		    }
		    
		    # Controllo sulla provincia dell'impianto
		    set cod_prov_chk ""
		    set sigla_prov $coimtgen(sigla_prov)
		    set denom_prov [db_string sel_provincia "select denominazione as denom_prov from coimprov where sigla = :sigla_prov"]
		    set cod_prov_chk ""
		    if {$sigla_prov == $provincia
			|| $denom_prov == $provincia} {
			set provincia $sigla_prov
			set cod_prov_chk $province($provincia)
		    } else {
			set desc_errore "Provincia non di competenza dell'ente"
			incr errori
			db_dml ins_anom "insert into $nome_tabella_anom values ( :id_riga , :cod_manutentore, 'provincia' , :desc_errore )"
		    }
		    
		    # Controllo sul responsabile
		    switch $flag_responsabile {
			"A" { 
			    if {[string equal $cognome_resp ""]} {
				set desc_errore "Il responsabile (amministratore) non &egrave; valorizzato"
				incr errori
				db_dml ins_anom "insert into $nome_tabella_anom values ( :id_riga , :cod_manutentore, 'cognome_resp' , :desc_errore )"
			    } else {
				if {[string equal $nome_resp ""]} {
				    set where_nome_chk " and nome is null"
				} else {
				    set where_nome_chk " and upper(nome) = :nome_resp"
				}
				if {[string equal $indirizzo_resp ""]} {
				    set where_indirizzo_chk " and indirizzo is null"
				} else {
				    set where_indirizzo_chk " and upper(indirizzo) = :indirizzo_resp"
				}
				if {[string equal $comune_resp ""]} {
				    set where_comune_chk " and comune is null"
				} else {
				    set where_comune_chk " and upper(comune) = :comune_resp"
				}
				if {[string equal $provincia_resp ""]} {
				    set where_provincia_chk " and provincia is null"
				} else {
				    set where_provincia_chk " and upper(provincia) = :provincia_resp"
				}

				if {[db_0or1row sel_citt_check "select max(cod_cittadino) as cod_citt from coimcitt
		                                                         where upper(cognome) = :cognome_resp
	                                                                $where_nome_chk
	                                                                $where_indirizzo_chk
	                                                                $where_comune_chk
	                                                                $where_provincia_chk
                                                                   and cod_cittadino like 'AM%'"] == "0"} {
				    set desc_errore "Il responsabile (amministratore) non &egrave; presente nell'anagrafica ricontrolla i dati relativi"
				    incr errori
				    db_dml ins_anom "insert into $nome_tabella_anom values ( :id_riga , :cod_manutentore, 'cognome_resp' , :desc_errore )"
				    db_dml ins_anom "insert into $nome_tabella_anom values ( :id_riga , :cod_manutentore, 'nome_resp' , :desc_errore )"
				    db_dml ins_anom "insert into $nome_tabella_anom values ( :id_riga , :cod_manutentore, 'indirizzo_resp' , :desc_errore )"
				    db_dml ins_anom "insert into $nome_tabella_anom values ( :id_riga , :cod_manutentore, 'comune_resp' , :desc_errore )"
				    db_dml ins_anom "insert into $nome_tabella_anom values ( :id_riga , :cod_manutentore, 'provincia_resp' , :desc_errore )"
				}
			    }
			}
			"I" {
			    if {[string equal $cognome_inte ""]
				&& [string equal $cognome_resp ""]} {
				set desc_errore "Il responsabile (intestatario) non &egrave; valorizzato"
				incr errori
				db_dml ins_anom "insert into $nome_tabella_anom values ( :id_riga , :cod_manutentore, 'cognome_inte' , :desc_errore )"
			    }
			}
			"O" {
			    if {[string equal $cognome_occu ""]
				&& [string equal $cognome_resp ""]} {
				set desc_errore "Il responsabile (occupante) non &egrave; valorizzato"
				incr errori
				db_dml ins_anom "insert into $nome_tabella_anom values ( :id_riga , :cod_manutentore, 'cognome_occu' , :desc_errore )"
			    }
			}
			"P" {
			    if {[string equal $cognome_prop ""]
				&& [string equal $cognome_resp ""]} {
				set desc_errore "Il responsabile (proprietario) non &egrave; valorizzato"
				incr errori
				db_dml ins_anom "insert into $nome_tabella_anom values ( :id_riga , :cod_manutentore, 'cognome_prop' , :desc_errore )"
			    }
			}
			"T" {
			    if {[string equal $cognome_resp ""]} {
				set desc_errore "Il responsabile (terzo) non &egrave; valorizzato"
				incr errori
				db_dml ins_anom "insert into $nome_tabella_anom values ( :id_riga , :cod_manutentore, 'cognome_resp' , :desc_errore )"
			    } else {
				if {[string equal $nome_resp ""]} {
				    set where_nome_chk " and nome is null"
				} else {
				    set where_nome_chk " and upper(nome) = :nome_resp"
				}
				if {[string equal $indirizzo_resp ""]} {
				    set where_indirizzo_chk " and indirizzo is null"
				} else {
				    set where_indirizzo_chk " and upper(indirizzo) = :indirizzo_resp"
				}
				if {[string equal $comune_resp ""]} {
				    set where_comune_chk " and comune is null"
				} else {
				    set where_comune_chk " and upper(comune) = :comune_resp"
						}
				if {[string equal $provincia_resp ""]} {
				    set where_provincia_chk " and provincia is null"
				} else {
				    set where_provincia_chk " and upper(provincia) = :provincia_resp"
				}

				if {[db_0or1row sel_citt_check "select cod_cittadino as cod_terzi from coimcitt
			                                                         where upper(cognome) = :cognome_resp
		                                                                $where_nome_chk
		                                                                $where_indirizzo_chk
		                                                                $where_comune_chk
		                                                                $where_provincia_chk and 
                                                                   exists (select 1 from coimmanu 
                                                                         where cod_manutentore = :cod_manutentore
                                                                           and cod_legale_rapp = cod_cittadino)"] == 0} {
				    
				    set desc_errore "Il terzo responsabile non esiste in anagrafica soggetti o non corrisponde a quello della ditta di manutenzione, ricontrolla i dati relativi"
				    
				    incr errori
				    db_dml ins_anom "insert into $nome_tabella_anom values ( :id_riga , :cod_manutentore, 'cognome_resp' , :desc_errore )"
				    db_dml ins_anom "insert into $nome_tabella_anom values ( :id_riga , :cod_manutentore, 'nome_resp' , :desc_errore )"
				    db_dml ins_anom "insert into $nome_tabella_anom values ( :id_riga , :cod_manutentore, 'indirizzo_resp' , :desc_errore )"
				    db_dml ins_anom "insert into $nome_tabella_anom values ( :id_riga , :cod_manutentore, 'comune_resp' , :desc_errore )"
				    db_dml ins_anom "insert into $nome_tabella_anom values ( :id_riga , :cod_manutentore, 'provincia_resp' , :desc_errore )"
				}

			    }
			}
		    }
		    
		    # Controllo sull'indirizzo		    
		    if {$coimtgen(flag_viario) == "F"} {
				set where_indirizzo "and upper(toponimo) = :toponimo
	                                                         and upper(indirizzo) = :indirizzo"
		    } else {

			if {[db_0or1row sel_viae_check "select cod_via
	  	                                                              from coimviae
	  	                                                             where upper(descr_topo)  = :toponimo
		                                                               and upper(descrizione) = :indirizzo
	                                                                       and cod_via_new is null
		                                                               and cod_comune = :cod_comune_chk
	                                                                       limit 1"]} {
			    set where_indirizzo "and cod_via = :cod_via"
			} else {
			    set desc_errore "Indirizzo inesistente nel viario"
			    incr errori
			    db_dml ins_anom "insert into $nome_tabella_anom values ( :id_riga , :cod_manutentore, 'indirizzo' , :desc_errore )"
			    db_dml ins_anom "insert into $nome_tabella_anom values ( :id_riga , :cod_manutentore, 'toponimo' , null )"
			    db_dml upd_riga "update $nome_tabella set numero_anomalie = :errori , flag_stato = 'P' where id_riga = :id_riga"
			}
		    }
		    
		    # Controllo sul costruttore
		    set cod_cost_chk ""
		    if {![info exist costruttori($marca)]} {
				set desc_errore "Marca generatore inesistente"
				incr errori
				db_dml ins_anom "insert into $nome_tabella_anom values ( :id_riga , :cod_manutentore, 'marca' , :desc_errore )"
		    } else {
				set cod_cost_chk $costruttori($marca)
		    }
		     
		    #controllo sul operatore manutentore
		    if {![string equal $cod_opmanu ""]} {

			if {[db_0or1row sel_opma "select '1' from coimopma where cod_opma = :cod_opmanu and cod_manutentore = :cod_manutentore"] == 0} {
			    set desc_errore "Operatore manutentore inesistente"
			    incr errori
			    db_dml ins_anom "insert into $nome_tabella_anom values ( :id_riga , :cod_manutentore, 'cod_opmanu' , :desc_errore )"
			}
		    }
		    
		    # Controllo sul combustibile

                    set cod_comb_chk "0"
		    if {![info exist combustibili($combustibile)]} {
			set desc_errore "Combustibile inesistente"
			incr errori
			db_dml ins_anom "insert into $nome_tabella_anom values ( :id_riga , :cod_manutentore, 'combustibile' , :desc_errore )"
		    } else {
			set cod_comb_chk $combustibili($combustibile)
		    }


		    #controllo sulla potenza

#		    if {![string is double $potenza_foc_nom]} {
#			set desc_errore "La potenza al focolare nominale  e' formalmente errata"
#			incr errori
#			db_dml ins_anom "insert into $nome_tabella_anom values ( :id_riga , :cod_manutentore, 'potenza_foc_nom' , :desc_errore )"
#
#		    }

#		    if {![string is double $potenza_utile_nom]} {
#			set desc_errore "La potenza utile nominale e' formalmente errata"
#			incr errori
#			db_dml ins_anom "insert into $nome_tabella_anom values ( :id_riga , :cod_manutentore, 'potenza_utile_nom' , :desc_errore )"
#
#		    }
    
		    if {$potenza_foc_nom == "0"} {
			set desc_errore "La potenza deve essere superiore a 0 kW"
			incr errori
			db_dml ins_anom "insert into $nome_tabella_anom values ( :id_riga , :cod_manutentore, 'potenza_foc_nom' , :desc_errore )"
		    } else {

			
			if {[db_0or1row sel_pot "select '1' from coimpote where potenza_min <= :potenza_foc_nom and potenza_max >= :potenza_foc_nom limit 1"] == 0} {
			    set desc_errore "La potenza non &egrave; compresa in nessuna fascia."
			    incr errori
			    db_dml ins_anom "insert into $nome_tabella_anom values ( :id_riga , :cod_manutentore, 'potenza_foc_nom' , :desc_errore )"
			}
			
		    }

# inizio controllo codice fiscale responsabile
		    if {$cod_fiscale_resp == "XXXXXXXXXXXXXXXX"} {
			set desc_errore "Identificatore fiscale responsabile non valido"
			incr errori
			db_dml ins_anom "insert into $nome_tabella_anom values ( :id_riga , :cod_manutentore, 'cod_fiscale_resp' , :desc_errore )"
		    }


		    if {[regexp {[^A-Za-z0-9]+} $cod_fiscale_resp] > 0 } {
			set desc_errore "L'identificatore fiscale resp. contiene caratteri non validi"
			incr errori
			db_dml ins_anom "insert into $nome_tabella_anom values ( :id_riga , :cod_manutentore, 'cod_fiscale_resp' , :desc_errore )"
		    }
		    set lcf [string length $cod_fiscale_resp]
		    if {$lcf != 16 && $lcf != 11} {
			set desc_errore "Lunghezza CF resp. errata"
			incr errori
			db_dml ins_anom "insert into $nome_tabella_anom values ( :id_riga , :cod_manutentore, 'cod_fiscale_resp' , :desc_errore )"
		    } elseif {$lcf == 16 && [iter::verifyfc -xcodfis $cod_fiscale_resp] == 0} {
			set desc_errore "codice fiscale resp. errato"
			incr errori
			db_dml ins_anom "insert into $nome_tabella_anom values ( :id_riga , :cod_manutentore, 'cod_fiscale_resp' , :desc_errore )"
		    } elseif {$lcf == 11 && [iter::verifyvc -xcodfis $cod_fiscale_resp] == 0} {
			set desc_errore "codice fiscale resp. errato"
			incr errori
			db_dml ins_anom "insert into $nome_tabella_anom values ( :id_riga , :cod_manutentore, 'cod_fiscale_resp' , :desc_errore )"
		    }
		    
# fine controllo codice fiscale responsabile





		    if {$errori > 0} {
			if {$errori > $num_anom_max} {
			    db_dml upd_riga "update $nome_tabella set numero_anomalie = :errori , flag_stato = 'S' where id_riga = :id_riga"
			} else {
			    db_dml upd_riga "update $nome_tabella set numero_anomalie = :errori , flag_stato = 'P' where id_riga = :id_riga"
			}
		    } else {
			set cod_impianto ""
			#superati controlli esistenza ricerco l'impianto nel catasto
			if {![string equal $cod_impianto_est ""]} {
			    #caso in cui cod impianto  valorizzato
			    if {[db_0or1row sel_impianto "select cod_impianto from coimaimp where cod_comune = :cod_comune_chk and cod_provincia = :cod_prov_chk and cod_impianto_est = :cod_impianto_est"]} {
				
				#trovato impianto per comune e provincia
					if {[db_0or1row sel_aimp_check "select cod_impianto 
                                                                          from coimaimp 
                                                                         where 1 = 1 
                                                                               $where_indirizzo 
                                                                           and cod_impianto_est = :cod_impianto_est"]} {
					    #impianto trovato per indirizzo
					    db_dml upd_riga "update $nome_tabella 
                                                                set cod_impianto_catasto = :cod_impianto 
                                                              where id_riga = :id_riga"

#***************************************************************************

					    if {[db_0or1row sel_generatore "select b.gen_prog as gen_prog_check,
                                                                                   b.matricola as matricola_esistente,
                                                                                   b.cod_cost as costruttore_esistente  
                                                                            from coimaimp a
	                                                                       , coimgend b
	                                                                   where a.cod_impianto = b.cod_impianto
	                                                                     and a.cod_impianto_est = :cod_impianto_est
	                                                                     and b.gen_prog = :gen_prog"]} {
						
#ns_log notice "prova dob2 matricole = $matricola matricola_esistente = $matricola_esistente cod_cost_chk = $cod_cost_chk costruttore_esistente = $costruttore_esistente "
						
    			if {($matricola != $matricola_esistente && "" != $matricola_esistente) || ($cod_cost_chk != $costruttore_esistente && "" != $costruttore_esistente)} {

#ns_log notice "prova dob3 "
						    
						    set desc_errore "Impianto trovato ma il generatore ha marca o matricola diversa"
						    incr errori
						    db_dml ins_anom "insert into $nome_tabella_anom values ( :id_riga , :cod_manutentore, 'marca o matricola' , :desc_errore )"
						    db_dml upd_riga "update $nome_tabella set numero_anomalie = :errori , flag_stato = 'S' where id_riga = :id_riga"
						} 						    
						db_dml upd_riga "update $nome_tabella 
                                                                    set gen_prog_catasto = :gen_prog_check 
                                                                  where id_riga = :id_riga"
						
						
					    } else {


						set desc_errore "Impianto trovato ma il generatore manca o ha un progressivo divero da quello di caricamento"
						incr errori
						db_dml ins_anom "insert into $nome_tabella_anom values ( :id_riga , :cod_manutentore, 'marca o matricola' , :desc_errore )"
						db_dml upd_riga "update $nome_tabella set numero_anomalie = :errori , flag_stato = 'S' where id_riga = :id_riga"
					    }


#**********************************************************************


					} else {
					    set desc_errore "Impianto trovato ma con indirizzo diverso"
					    incr errori
					    db_dml ins_anom "insert into $nome_tabella_anom values ( :id_riga , :cod_manutentore, 'indirizzo' , :desc_errore )"
					    db_dml ins_anom "insert into $nome_tabella_anom values ( :id_riga , :cod_manutentore, 'toponimo' , null )"
					    db_dml upd_riga "update $nome_tabella set numero_anomalie = :errori , flag_stato = 'P' where id_riga = :id_riga"
					}
				
			    } else {
					set desc_errore "Impianto non trovato per comune e provincia. Il codice impianto non &egrave; stato assegnato correttamente"
					incr errori
					db_dml ins_anom "insert into $nome_tabella_anom values ( :id_riga , :cod_manutentore, 'cod_impianto_est' , :desc_errore )"
					db_dml upd_riga "update $nome_tabella set numero_anomalie = :errori , flag_stato = 'S' where id_riga = :id_riga"
			    }
			} else {
			    #rinisci query
			    db_1row sel_n_impianti "select count(*) as conta_impianti_trovati from coimaimp a
                                                                               , coimgend b
                                                                         where a.cod_impianto = b.cod_impianto
                                                                           and a.cod_provincia = :cod_prov_chk
                                                                           and a.cod_comune = :cod_comune_chk
                                                                           and b.matricola = :matricola
                                                                           and b.cod_cost  = :cod_cost_chk
                                                                           and a.stato = 'A'
                                                                          $where_indirizzo"
				

			    if {$conta_impianti_trovati > 1} {
				
				set desc_errore "Trovati piu impianti attivi aventi stesso indirizzo costruttore e matricola"
				incr errori
				db_dml ins_anom "insert into $nome_tabella_anom values ( :id_riga , :cod_manutentore, 'cod_impianto_est' , :desc_errore )"
				db_dml upd_riga "update $nome_tabella set numero_anomalie = :errori , flag_stato = 'S' where id_riga = :id_riga"
				
			    } else {
				
				if {[db_0or1row sel_impianto "select a.cod_impianto, b.gen_prog as gen_prog_check from coimaimp a
                                                                               , coimgend b
                                                                         where a.cod_impianto = b.cod_impianto
                                                                           and a.cod_provincia = :cod_prov_chk
                                                                           and a.cod_comune = :cod_comune_chk
                                                                           and b.matricola = :matricola
                                                                           and b.cod_cost  = :cod_cost_chk
                                                                           and a.stato = 'A'
                                                                          $where_indirizzo limit 1"]} {
				    db_dml upd_riga "update $nome_tabella set cod_impianto_catasto = :cod_impianto where id_riga = :id_riga"
				    db_dml upd_riga "update $nome_tabella set gen_prog_catasto = :gen_prog_check where id_riga = :id_riga"
				}
			    }
			}
		    }
		}
		
		#controlli sulla dichiarazione
		if {$errori == 0
		    && [string equal $data_rottamaz_gen ""]} {
		    
		    if {![string equal $cod_impianto ""]} {
			if {[db_0or1row sel_dimp "select cod_dimp from coimdimp where cod_impianto = :cod_impianto and data_controllo = :data_controllo limit 1"]} {
			    set desc_errore "Dichiarazione gi&agrave; presente controlla la data"
			    incr errori
			    db_dml ins_anom "insert into $nome_tabella_anom values ( :id_riga , :cod_manutentore, 'data_controllo' , :desc_errore )"
			    db_dml upd_riga "update $nome_tabella set numero_anomalie = :errori , flag_stato = 'P' where id_riga = :id_riga"
			}
		    }
		    
		    #Controllo che le anomalie segnalate siano presenti nella tabella coimtano
		    # e quindi conformi agli standard della regione lombardia	    
		    set anomalie_impianto [split $anomalie_dimp \,]
		    set num_anom [llength $anomalie_impianto]
		    set err_anom ""
		    for {set i 0} {$i < $num_anom} {incr i} {
			set anomalia [lindex $anomalie_impianto $i]
			set anomalia [string trim $anomalia]
			if {![info exists anomalie($anomalia)]} {
			    if {![string equal $err_anom ""]} {
				append err_anom ","
			    }
			    append err_anom "codice anomalia $anomalia non valido "
			}
		    } 
		    if {![string equal $err_anom ""]} {
			set desc_errore $err_anom
			incr errori
			db_dml ins_anom "insert into $nome_tabella_anom values ( :id_riga , :cod_manutentore, 'anomalie_dimp' , :desc_errore )"
			db_dml upd_riga "update $nome_tabella set numero_anomalie = :errori , flag_stato = 'P' where id_riga = :id_riga"
		    }
		}
	    }
	    #chiude db_foreach sulla tabella
	    
	} else {
	    
	    set page_title "Esito caricamento modelli G per manutentori"
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
		
		
		<table>
		<tr><td valign=top class=form_title align=center colspan=4>$err_log</td>
		</tr>
		
		<tr><td>&nbsp;</td>
		
		</table>
		</center>
	    }]
	    
	    puts $file_esi_id $pagina_esi
	    
	    
	    
	    if {[string equal $nome_tabella ""]} {	    
		close $file_inp_id
	    }
	}

	# inserisco i link ai file di esito sulla tabella degli esiti
	# ed aggiorno lo stato del batch a 'Terminato' coimcorr-anom-gest.tcl
	set     esit_list ""
	if {[string equal $err_log ""]} {
	    db_1row sel_count_anom "select count(*) as conta_anom from $nome_tabella where flag_stato = 'P'"
	    if {$conta_anom > 0} {
		
		close $file_esi_id
		close $file_err_id
		close $file_tot_id
		
		ns_unlink $file_esi
		ns_unlink $file_err
		ns_unlink $file_tot
		
		set file_esi_url   "${permanenti_dir_url}/coimcorr-anom-gest?nome_tabella=$nome_tabella&cod_batc=$cod_batc"
		set file_esi       "${permanenti_dir}/coimcorr-anom-gest"
		
		set file_esi_url [string map {permanenti src}  $file_esi_url]
		set file_esi     [string map {permanenti src}  $file_esi]
		
		lappend esit_list [list "Esito provvisorio"  $file_esi_url $file_esi]
		iter_batch_upd_flg_sta -fine $cod_batc $esit_list
	    } else {
		# Scrivo la procedura che controllera' l'esistenza o meno nel db dei cittadini
		# e ne curera' l'eventuale inserimento
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
		    if {[db_0or1row sel_citt_check "select cod_cittadino as cod_citt
    	                                              from coimcitt
	                                             where upper(cognome) = :cognome_citt_chk
                                                    $where_nome_chk
                                                    $where_indirizzo_chk
                                                    $where_comune_chk
                                                    $where_provincia_chk
                                                    limit 1"] == "0"} {
			db_1row sel_dual_cod_citt ""
			db_dml ins_citt ""
			incr count_citt
		    } else {
			set cod_citt [db_string sel_citt_check "select cod_cittadino as cod_citt
                                                               	  from coimcitt
                                                        	 where upper(cognome) = :cognome_citt_chk
                                                                $where_nome_chk
                                                                $where_indirizzo_chk
                                                                $where_comune_chk
                                                                $where_provincia_chk
                                                                limit 1"]
		    }
		}
		
		set count_aimp 0
		set count_dimp 0
		set count_citt 0

		set soldi_spesi "0.00"
		#inizio la routine degli inserimenti
		db_foreach sel_righe_buone "select * from $nome_tabella where flag_stato is null" {


		    if {$riferimento_pag == ""} {
			set riferimento_pag $num_bollo 
		    }

		    
		    if {[string equal $data_rottamaz_gen ""]} {
			set cod_amministratore ""
			
			set nome_citt_chk $nome_resp
			set cognome_citt_chk $cognome_resp
			set indirizzo_citt_chk $indirizzo_resp
			set comune_citt_chk $comune_resp
			set provincia_citt_chk $provincia_resp
			set natura_citt_chk $natura_giuridica_resp
			set cap_chk $cap_resp
			set cod_fiscale_chk $cod_fiscale_resp
			set telefono_chk $telefono_resp
			if {![string equal $cognome_citt_chk ""]} {
			    eval $citt_control
			    set cod_responsabile $cod_citt
			} else {
			    set cod_responsabile ""
			}
			# Proprietario
			set nome_citt_chk $nome_prop
			set cognome_citt_chk $cognome_prop
			set indirizzo_citt_chk $indirizzo_prop
			set comune_citt_chk $comune_prop
			set provincia_citt_chk $provincia_prop
			set natura_citt_chk $natura_giuridica_prop
			set cap_chk $cap_prop
			set cod_fiscale_chk $cod_fiscale_prop
			set telefono_chk $telefono_prop
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
			set cap_chk $cap_occu
			set cod_fiscale_chk $cod_fiscale_occu
			set telefono_chk $telefono_occu
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
			set cap_chk $cap_int
			set cod_fiscale_chk $cod_fiscale_int
			set telefono_chk $telefono_int
			if {![string equal $cognome_citt_chk ""]} {
			    eval $citt_control
			    set cod_intestatario $cod_citt
			} else {
			    set cod_intestatario ""
			}
			
			switch $flag_responsabile {
			    "A" { set cod_amministratore $cod_responsabile }
			    "T" {  }
			    "I" {
				if {[string equal $cod_intestatario ""]} {
				    set cod_intestatario $cod_responsabile
				} else {
				    set cod_responsabile $cod_intestatario
				}
			    }
			    "O" {
				if {[string equal $cod_occupante ""]} {
				    set cod_occupante $cod_responsabile
				} else {
				    set cod_responsabile $cod_occupante
				}
			    }
			    "P" {
				if {[string equal $cod_proprietario ""]} {
				    set cod_proprietario $cod_responsabile
				} else {
				    set cod_responsabile $cod_proprietario
				}
			    }
			}
			
			if {[string equal $data_scadenza ""]} {
			    if {[string range $data_controllo 4 8] < "0731"} {
				set data_scadenza [expr [string range $data_controllo 0 3] + 2]
				set data_scadenza "$data_scadenza-07-31"
			    } else {
				set data_scadenza [expr [string range $data_controllo 0 3] + 3]
				set data_scadenza "$data_scadenza-07-31"
			    }
			}
			
			set cod_comune_chk $comuni($comune)
			set cod_comune $comuni($comune)
			set cod_prov $province($provincia)
			set cod_comb $combustibili($combustibile)		    
			set cod_cost_chk $costruttori($marca)
			set cod_cost $costruttori($marca)
			set cod_potenza [db_string sel_pot "select cod_potenza from coimpote where potenza_min <= :potenza_foc_nom and potenza_max >= :potenza_foc_nom"]
			if {$coimtgen(flag_viario) == "T"} {
			    set cod_via [db_string sel_viae_check "select cod_via
	  	                                                              from coimviae
	  	                                                             where upper(descr_topo)  = :toponimo
		                                                               and upper(descrizione) = :indirizzo
	                                                                       and cod_via_new is null
		                                                               and cod_comune = :cod_comune
	                                                                       limit 1"]
			} else {
			    set cod_via ""
			}
			
			
			set msg_errore ""
			set err_count 0
			
			
			
			if {$flag_portafoglio == "T"
			    && $data_controllo >= "20080801" } {
			    set data_insta_check "19000101"
			    if {![string equal $data_installaz ""]} {
				set data_insta_check [db_string sel_dat "select to_char(add_months(:data_installaz, '1'), 'yyyymmdd')"]
			    }
#			    ns_log notice "prova dob aggiornamento potafoglio dtata controllo $data_controllo data installazione $data_insta_check"
			    
			    if {$data_controllo >= $data_insta_check} {
#				ns_log notice "prova dob aggiornamento potafoglio dtata controllo $data_controllo data installazione $data_insta_check"
				if {(![string equal $cod_impianto_catasto ""]) && ([db_0or1row sel_dimp_check_data_controllo ""] == 1)} {
				    set tariffa_reg "7"
				    set importo_contr "0.00"
				    db_1row sel_dual_cod_dimp ""
				} else {
				    set tariffa_reg "7"
				    set pot_focolare_nom_check [iter_edit_num $potenza_foc_nom 2]
				    set pot_focolare_nom_check [iter_check_num $pot_focolare_nom_check 2]

				    if {$pot_focolare_nom_check == "0.00"
					|| $pot_focolare_nom_check == "0" || $pot_focolare_nom_check == "Error"} {
					incr err_count
					append msg_errore "Non &egrave; stato possibile calcolare l'importo del contributo regionale in quanto la potenza &egrave; errata o 0,00 ($potenza_foc_nom)" 
				    } else {
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
					    if {$risultato == "OK"} {
						
					    } else {
						incr err_count
						append msg_errore "Transazione non avvenuta correttamente ($result(page))" 
					    }
					}
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
			
			set cod_cost	$cod_cost_chk
			if {$err_count == 0} {
			    if {![string equal $cod_impianto_catasto ""]} {

#**************************************************************				
			
				set cod_impianto 	$cod_impianto_catasto
				set cod_cost		$cod_cost_chk

				if {![string equal $cod_impianto_est ""]} {
				    db_dml query "update coimgend 
                                                     set matricola         = :matricola,
                                                         cod_cost          = :cod_cost,
                                                         pot_focolare_nom  = :potenza_foc_nom,
                                                         pot_utile_nom     = :potenza_utile_nom
                                                   where cod_impianto      = :cod_impianto
                                                     and gen_prog          = :gen_prog"
				    
				    db_1row sel_tot_potenza_aimp "select sum(pot_focolare_nom) as tot_potenza_aimp 
                                                                    from coimgend 
                                                                   where cod_impianto = :cod_impianto_catasto"
				    db_1row sel_tot_potenza_aimp "select sum(pot_utile_nom) as tot_potenza_utile_aimp 
                                                                    from coimgend 
                                                                   where cod_impianto = :cod_impianto_catasto"
				    db_dml upd_aimp ""
				}


#************************************************				
	
				if {[string equal $flag_status ""]} {
				    set flag_status $flag_status_g
				    if {[string equal $flag_status "S"]} {
					set flag_status "P"
				    }
				}
				
				db_dml ins_dimp ""
				
				incr count_dimp
				
				if {$flag_portafoglio == "T" && ![string equal $importo_contr ""]} {
				    set soldi_spesi [expr $soldi_spesi + $importo_contr]
				}
				
			    } else {
				
				if {[string equal $flag_status ""]} {
				    set flag_status $flag_status_g
				    if {[string equal $flag_status "S"]} {
					set flag_status "P"
				    }
				}
				
				db_1row sel_dual_cod_impianto ""

				if {[string equal $potenza_foc_nom ""]} {
				    set potenza_foc_nom "0.00"
				}
				if {[string equal $potenza_utile_nom ""]} {
				    set potenza_utile_nom "0.00"
				}
				set cod_potenza [db_string sel_pot "select coalesce(cod_potenza, '') from coimpote where potenza_min <= :potenza_foc_nom and potenza_max >= :potenza_foc_nom" -default "0"]
				if {$flag_codifica_reg == "T"} {
				    
				    if {![string equal $cod_comune ""]} {
					db_1row sel_dati_comu "select coalesce(lpad((progressivo + 1), 7, '0'), '0000001') as progressivo
							                                    , cod_istat
							                                    from coimcomu
							                                    where cod_comune = :cod_comune"
					if {![string equal $potenza_foc_nom "0.00"]
					    && ![string equal $potenza_foc_nom ""]} {
					    if {$potenza_foc_nom < 35} {
						set tipologia "IN"
					    } else {
						set tipologia "CT"
					    }
					    set cod_impianto_est "$cod_istat$tipologia$progressivo"
					    db_dml upd_prog_comu "update coimcomu
									                                       set progressivo = :progressivo
									                                     where cod_comune  = :cod_comune"
					} else {
					    if {![string equal $cod_potenza "0"]
						&& ![string equal $cod_potenza ""]} { 
						switch $cod_potenza {
						    "B"  {set tipologia "IN"}
						    "A"  {set tipologia "CT"}
						    "MA" {set tipologia "CT"}
						    "MB" {set tipologia "CT"}
						}
						
						set cod_impianto_est "$cod_istat$tipologia$progressivo"
						db_dml upd_prog_comu "update coimcomu
									                                           set progressivo = :progressivo
									                                         where cod_comune  = :cod_comune"
					    } else {
						set cod_impianto_est ""
					    }
					}
				    } else {
					set cod_impianto_est ""
				    }
				} else {
				    db_1row sel_dual_cod_impianto_est ""
				}




				db_dml ins_aimp ""
				db_dml ins_gend ""
				db_dml ins_dimp ""
				
				incr count_aimp
				incr count_dimp
				
				if {$flag_portafoglio == "T" && ![string equal $importo_contr ""]} {
				    set soldi_spesi [expr $soldi_spesi + $importo_contr]
				}
			    }
			} else {
			    db_dml ins_anom "insert into $nome_tabella_anom values ( :id_riga , :cod_manutentore, 'cod_impianto_est' , :msg_errore )"
			    db_dml upd_riga "update $nome_tabella set numero_anomalie = '1' , flag_stato = 'S' where id_riga = :id_riga"
			}
		    } else {
			if {![string equal $cod_impianto_catasto ""]
			    && ![string equal $gen_prog_catasto ""]} {
			    db_dml upd_gen_rott ""
			} else {
			    set msg_errore "Il generatore &egrave; da rottamare ma non &egrave; stato trovato nel database."
			    db_dml ins_anom "insert into $nome_tabella_anom values ( :id_riga , :cod_manutentore, 'cod_impianto_est' , :msg_errore )"
			    db_dml upd_riga "update $nome_tabella set numero_anomalie = '1' , flag_stato = 'S' where id_riga = :id_riga"
			}
		    }
		}

		set count_scartati 0
		db_foreach sel_scarti "select * from $nome_tabella where flag_stato = 'S'" {
		    
		    set i 0
		    set riga ""
		    while {$i < $count_fields} {
			util_unlist $file_fields($i) nome_colonna denominazione type dimensione obbligatorio default_value range_value		    
			set colonna [set $nome_colonna]
			if {$i != "0"} {
			    append riga "|"
			}
			
			append riga $colonna
			incr i
		    }
		    
		    append riga " --di seguito riportati alcuni errori -> "
		    
		    db_foreach sel_anom "select * from $nome_tabella_anom where id_riga = :id_riga limit 5" {
			append riga "$nome_colonna: $desc_errore , "
		    }
		    
		    puts $file_err_id $riga
		    
		    incr count_scartati
		}
		
		set count_totale 0
		db_foreach sel_file "select * from $nome_tabella" {
		    
		    set i 0
		    set riga ""
		    while {$i < $count_fields} {
			util_unlist $file_fields($i) nome_colonna denominazione type dimensione obbligatorio default_value range_value		    
			set colonna [set $nome_colonna]
			if {$i != "0"} {
			    append riga "|"
			}
			
			append riga $colonna
			incr i
		    }
		    
		    puts $file_tot_id $riga
		    
		    incr count_totale
		}
		
		db_dml del_tabella "drop table $nome_tabella"
		db_dml del_tabella_anom "drop table $nome_tabella_anom"
		db_dml del_seq "drop sequence $nome_sequence"
		db_dml del_tabella_anom "delete from coimcari_manu where cod_manutentore = :cod_manutentore"
		
		# scrivo la pagina di esito
		set page_title "Esito caricamento modelli g per manutentori"
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
		    <td valign=top class=form_title>$count_totale</td>
		    <td>&nbsp;</td>
		    <td>&nbsp;</td>
		    </tr>
		    
		    <tr><td valign=top class=form_title>Modelli scartati:</td>
		    <td valign=top class=form_title>$count_scartati</td>
		    <td>&nbsp;</td>
		    <td>&nbsp;</td>
		    </tr>
		    
		    <tr><td colspan=4>&nbsp;</td>
		    
		    <tr><td valign=top class=form_title colspan=2>&nbsp;&nbsp;&nbsp;Inseriti nuovi Soggetti:</td>
		    <td valign=top class=form_title>$count_citt</td>
		    <td>&nbsp;</td>
		    </tr>
		    
		    <tr><td valign=top class=form_title colspan=2>&nbsp;&nbsp;&nbsp;Inseriti nuovi Impianti:</td>
		    <td valign=top class=form_title>$count_aimp</td>
		    <td>&nbsp;</td>
		    </tr>
		    
		    
		    <tr><td valign=top class=form_title colspan=2>&nbsp;&nbsp;&nbsp;Modelli inseriti:</td>
		    <td valign=top class=form_title>$count_dimp</td>
		    <td>&nbsp;</td>
		    </tr>

		    <tr><td valign=top class=form_title colspan=2>&nbsp;&nbsp;&nbsp;Sono stati spesi euro:</td>
		    <td valign=top class=form_title>$soldi_spesi</td>
		    <td>&nbsp;</td>
		    </tr>
		    <tr><td colspan=4>&nbsp;</td>
		    
		    
		    <tr><td valign=top class=form_title>Modelli scartati:</td>
		    <td>&nbsp;</td>
		    <td>&nbsp;</td>
		    <td valign=top class=form_title><a target="Modelli scartati" href="$file_err_url">Scarica il file csv dei controlli/impianti scartati</a></td>
		    </tr>
		    
		    
		    <tr><td valign=top class=form_title>Modelli totali:</td>
		    <td>&nbsp;</td>
		    <td>&nbsp;</td>
		    <td valign=top class=form_title><a target="Modelli scartati" href="$file_tot_url">Scarica il file csv dei controlli/impianti completo</a></td>
		    </tr>
		    
		}]
		
		puts $file_esi_id $pagina_esi
		
		close $file_esi_id
		close $file_err_id
		close $file_tot_id
		
		lappend esit_list [list "Esito caricamento"  $file_esi_url $file_esi]
		iter_batch_upd_flg_sta -fine $cod_batc $esit_list
		
	    }
	    
	} else {

	    close $file_esi_id
	    close $file_err_id
	    close $file_tot_id
	    
	    ns_unlink $file_err
	    ns_unlink $file_tot
	    
	    lappend esit_list [list "Esito caricamento"  $file_esi_url $file_esi]
	    iter_batch_upd_flg_sta -fine $cod_batc $esit_list
	}
	
    } {
	iter_batch_upd_flg_sta -abend $cod_batc
	ns_log Error "iter-cari-modelli-g: $error_msg"
    }
    
    ns_log Notice "Fine della procedura iter-cari-modelli-g"
    
    return
    
    
}
