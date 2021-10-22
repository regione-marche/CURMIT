ad_page_contract {

    Lettura di 3 file sequenziali contenenti gli impianti, le autocertificazioni e i rapporti di verifica
    seguendo un tracciato record prefissato e validandone i dati al fine di ottenere un caricamento veloce e pulito
    delle tabelle *** di iter
    Il programma restituisce un report visivo con il riassunto adei dati validati, 
    tre file csv contenenti gli errori riscontrati

    @creation-date   18/10/2006

    @cvs-id          coimcari-files.tcl
} {
    {funzione         "V"}
    {caller       "index"}
    {nome_funz         ""}
    {nome_funz_caller  ""}
} -properties {
    page_title:onevalue
    context_bar:onevalue
    form_name:onevalue
}

ReturnHeaders

# Prendo i dati dell'ente dalla coimtgen
iter_get_coimtgen

# Controlla lo user
set lvl 1
set id_utente [lindex [iter_check_login $lvl $nome_funz] 1]

# controllo il parametro di "propagazione" per la navigation bar
if {[string equal $nome_funz_caller ""]} {
    set nome_funz_caller $nome_funz
}

set link_gest [export_url_vars nome_funz nome_funz_caller caller]

# Personalizzo la pagina
set page_title   "Caricamento dati"
set context_bar  [iter_context_bar -nome_funz $nome_funz_caller]
# Setto le directory per il salvataggio degli output temporanei
set dir           [iter_set_spool_dir]
set spool_dir_url [iter_set_spool_dir_url]

# Setto le directory in cui creerò i file temporanei di nanalisi
if {$coimtgen(flag_ente) eq "P"} {
    set corretti_dir "corretti_[string tolower $coimtgen(flag_ente)][string tolower $coimtgen(sigla_prov)]"
    set errati_dir "errati_[string tolower $coimtgen(flag_ente)][string tolower $coimtgen(sigla_prov)]"
    set regsub_dir "regsub_[string tolower $coimtgen(flag_ente)][string tolower $coimtgen(sigla_prov)]"
} else {
    regsub -all " " $coimtgen(denom_comune) "" coimtgen(denom_comune)
    set corretti_dir "corretti_[string tolower $coimtgen(flag_ente)][string tolower $coimtgen(denom_comune)]"
    set errati_dir "errati_[string tolower $coimtgen(flag_ente)][string tolower $coimtgen(denom_comune)]"
    set regsub_dir "regsub_[string tolower $coimtgen(flag_ente)][string tolower $coimtgen(denom_comune)]"
}

if {$coimtgen(flag_ente) eq "P"} {
    set files_dir "dati_connettori_[string tolower $coimtgen(flag_ente)][string tolower $coimtgen(sigla_prov)]"
} else {
    regsub -all " " $coimtgen(denom_comune) "" coimtgen(denom_comune)
    set files_dir "dati_connettori_[string tolower $coimtgen(flag_ente)][string tolower $coimtgen(denom_comune)]"
}

cd [iter_set_spool_dir]
# Creo le directory per i file temporanei
file mkdir $corretti_dir
file mkdir $errati_dir

#Nome dei file da elaborare
set file_1 "$files_dir/impianti.csv"
set file_2 "$files_dir/rapporti.csv"
set file_3 "$files_dir/autocertificazioni.csv"

#log di errori
set err_file_1 "err_impianti.csv"
set err_file_2 "err_rapporti.csv"
set err_file_3 "err_autocertificazioni.csv"

#tracciato dati codificati correttamente
set cor_file_1 "corretti_impianti.csv"
set cor_file_2 "corretti_rapporti.csv"
set cor_file_3 "corretti_autocertificazioni.csv"

# Setto il file di log per tenere traccia delle operazioni compiute
if {$coimtgen(flag_ente) eq "P"} {
    set log "log_file$coimtgen(flag_ente)$coimtgen(sigla_prov)"
} else {
    set log "log_file$coimtgen(flag_ente)$coimtgen(denom_comune)"
}
# Setto la directory di log
set log_dir "log"

#Settaggio del file di log
set log_file [open $dir/$log_dir/$log w]

#file di output per i dati purificati
set impianti_file [open $dir/$file_1 r]
set rapporti_file [open $dir/$file_2 r]
set autocertificazioni_file [open $dir/$file_3 r]

#file di output per gli impianti errati
set err_impianti [open $dir/$errati_dir/$err_file_1 w]
set err_rapporti [open $dir/$errati_dir/$err_file_2 w]
set err_autocertificazioni [open $dir/$errati_dir/$err_file_3 w]

#file di output per gli impianti corretti
set corretti_impianti [open $dir/$corretti_dir/$cor_file_1 w]
set corretti_rapporti [open $dir/$corretti_dir/$cor_file_2 w]
set corretti_autocertificazioni [open $dir/$corretti_dir/$cor_file_3 w]

#encoding dei dati caricati
fconfigure $impianti_file -encoding iso8859-15 -translation crlf
fconfigure $rapporti_file -encoding iso8859-15 -translation crlf
fconfigure $autocertificazioni_file -encoding iso8859-15 -translation crlf

#Attenzione, nei prossimi 2 casi -translation lf è fuorviante.
#I files vengono scritti da iter_put_csv con terminatore di record crlf
#non funziona se uso fconfigure con -translation crlf
#e quindi esplicito il default -traslation lf

#encoding dei dati caricati
fconfigure $err_impianti -encoding iso8859-15 -translation lf
fconfigure $err_rapporti -encoding iso8859-15 -translation lf
fconfigure $err_autocertificazioni -encoding iso8859-15 -translation lf

#encoding dei dati caricati
fconfigure $corretti_impianti -encoding iso8859-15 -translation lf
fconfigure $corretti_rapporti -encoding iso8859-15 -translation lf
fconfigure $corretti_autocertificazioni -encoding iso8859-15 -translation lf

#@letti contatore di righe lette
set impianti_letti 0
set impianti_scarti 0
set impianti_riserva 0
set rapporti_letti 0
set rapporti_scarti 0
set rapporti_riserva 0
set autocertificazioni_letti 0
set autocertificazioni_scarti 0
set autocertificazioni_riserva 0

#contatori per valutare lo stato di avanzamento
set count_1 0
set count_2 0 
set count_3 0

#contatori di servizio
set service_counter_0 0
set service_counter_1 0
set service_counter_2 0

#settaggio fattore di visualizzazione avanzamento
set dividendo 500


#Settaggio delle variabili con i messaggi di errore

#######

#setto un array contenente tutti i codici delle anomalie per verificare la loro esistenza durante il caricamento dei rapporti di verifica
db_foreach sel_cod_tanom "" {
    set anomalie_lombardia($codice_anomalia) 1
}

#Inizio dell'analisi dei file per la creazione dei file dat che andranno a popolare le tabelle del database
 #ora di inizio flusso
set time_start [clock format [clock seconds]]
ns_write "Inizio analisi flusso dati da file csv: ora di inizio <b>$time_start</b> <br>"
puts $log_file "Inizio analisi flusso dati da file csv: ora di inizio $time_start"
#Inizio della lettura degli impianti dal file csv dato in input

#Riporto a 0 i contatori di avanzamento
set count_1 0
set count_2 0
set count_3 0


#Setto la variabile con la quale identifica il file che vado a leggere
set csv_name "impianti"

#scrivo la lista delle variabili per il file degli impianti
set impianti_file_cols "" 

set count_fields 0
db_foreach sel_liste_csv "" {
    #Creo la lista
    lappend impianti_file_cols $nome_colonna
    #Memorizzo in un array tutti i dati relativi ad un singoloo campo, necessari per la successiva analisi
    set impianti_fields($count_fields) [list $nome_colonna $denominazione $tipo_dato $dimensione $obbligatorio $default_value $range_value]
    incr count_fields
}

#Salto la prima riga di intestazione del file csv, andando a scrivere l'intestazione nei file in uscita 
iter_get_csv $impianti_file impianti_file_cols_list |

iter_put_csv $corretti_impianti impianti_file_cols_list |
iter_put_csv $err_impianti impianti_file_cols_list |

#Setto la variabile contenente il numero di elementi attesi nella lista
set waited_length_file_list $count_fields
#modifica per vigevano
#set waited_length_file_list [expr $count_fields +2]

#Comincio la lettura dei records
iter_get_csv $impianti_file impianti_file_cols_list |

set impianti_file_ok_list $impianti_file_cols_list

while {![eof $impianti_file]} {
    
    #@found_length_file_list contiene il numero di variabili presenti nella lista
    set found_length_file_list [llength $impianti_file_cols_list]

    
    incr impianti_letti
    incr count_1
    set righe_contate [expr $count_1%$dividendo]
    if {$righe_contate eq 0} {
	set time [clock format [clock seconds]]
	puts $log_file "Analisi completata per $count_1 impianti $time"
	ns_write "Analisi completata per $count_1 impianti $time <br>"
    }   
    
    #log degli errori
    set riserva_log ""
    set err_log ""
    set err_count 0
    set err_obblig 0
    set err_riserva 0
    set ind 0
    
    foreach column_name $impianti_file_cols {
	set $column_name [lindex $impianti_file_cols_list $ind]
	incr ind
    }

    if {$found_length_file_list == $waited_length_file_list} {
	# Controllo che l'impianto analizzato sia unico
	set impianti_elaborati(0) 1	
	
	set i 0
	while {$i < $count_fields} {
	    
	    set colonna [lindex $impianti_file_ok_list $i]
	    set colonna [string trim $colonna]
	    
	    util_unlist $impianti_fields($i) col_name denominazione type dimension obbligatorio default_value range_value
	    
	    set element [set col_name]
	    
	    # Bonifico l'elemento da possibili caratteri accentati che non vengono accettati dal database
	    set colonna [string map {\\ "" \r " " \n " " \r\n " "} $colonna]
	    set impianti_file_ok_list [lreplace $impianti_file_ok_list $i $i $colonna]
	    
	    if {$obbligatorio eq "S"} {
		if {$element eq "" || [string is space $element]} {
		    append err_log "Il campo $denominazione è obbligatorio,"
		    incr err_obblig
		} else {
		    switch $type {
			date {
			    if {$colonna eq "0000-00-00" || $colonna eq "0"} {
				set colonna "19000101"
				set impianti_file_ok_list [lreplace $impianti_file_ok_list $i $i $colonna]
			    }
			    set date [iter_edit_date $colonna]
			    #ns_write "$col_name ||$colonna || $date<br>"
			    if {[iter_check_date $date] eq "0"} {
				set impianti_file_ok_list [lreplace $impianti_file_ok_list $i $i ""]
				append riserva_log "Modificato $denominazione da $colonna a null,"
				append err_log "Il valore $denominazione deve essere una data,"
				incr err_count
				incr err_riserva
			    } 
			}
			numeric {
			    set int_dec [split $dimension \,]
			    util_unlist $int_dec intero decimale

			    if {[iter_edit_num $colonna $decimale] ne "Error"} {

				set element_int_dec [split $colonna \.]
				util_unlist $element_int_dec parte_intera parte_decimale
				set max_value [expr pow(10,[expr $intero - $decimale]) -1]
				
				if {($parte_intera > [expr $max_value - 1]) || ($parte_intera < [expr (-1 * $max_value) +1])} {
				    set impianti_file_ok_list [lreplace $impianti_file_ok_list $i $i ""]
				    append riserva_log "Modificato $denominazione da $colonna a null,"
				    append err_log "Il campo $denominazione ($colonna) deve essere numerico di [expr $intero-$decimale] cifre,"
				    incr err_count
				    incr err_riserva
				} else {
				    
				    if {$range_value ne ""} {
					set range_list [split $range_value \,]
					set num_range [llength $range_list]
					
					set x 0
					set ok_range 0
					while {$x < $num_range} {
					    if {$colonna eq [lindex $range_list]} {
						incr ok_range
					    }
					    incr x
					}
					if {$ok_range == 0} {
					    set impianti_file_ok_list [lreplace $impianti_file_ok_list $i $i $default_value]
					    append riserva_log "Modificato $denominazione da $colonna a $default_value,"
					    append err_log "Il campo $denominazione ($colonna) deve assumere uno dei seguenti valori: '$range_value' ,"
					    incr err_count
					    incr err_riserva
					}
					
				    }
				    
				} 
				set max_value [expr pow(10,$decimale)]
				if {($parte_decimale > [expr $max_value - 1])} {
				    set impianti_file_ok_list [lreplace $impianti_file_ok_list $i $i ""]
				    append riserva_log "Modificato $denominazione da $colonna a null,"
				    append err_log "Il campo $denominazione ($colonna) deve avere $decimale cifre decimali,"
				    incr err_count
				    incr err_riserva
				} else {
				    
				    if {$range_value ne ""} {
					set range_list [split $range_value \,]
					set num_range [llength $range_list]
					
					set x 0
					set ok_range 0
					while {$x < $num_range} {
					    if {$colonna eq [lindex $range_list]} {
						incr ok_range
					    }
					    incr x
					}
					if {$ok_range == 0} {
					    set impianti_file_ok_list [lreplace $impianti_file_ok_list $i $i $default_value]
					    append riserva_log "Modificato $denominazione da $colonna a $default_value,"
					    append err_log "Il campo $denominazione ($colonna) deve assumere uno dei seguenti valori: '$range_value' ,"
					    incr err_count
					    incr err_riserva
					}
					
				    }
				    
				}
			    } else {
				set impianti_file_ok_list [lreplace $impianti_file_ok_list $i $i ""]
				append riserva_log "Modificato $denominazione da $colonna a null,"
				append err_log "Il campo $denominazione ($colonna) deve essere un numero,"
				incr err_count
				incr err_riserva
			    }
			}
			varchar {
			    set colonna [string toupper $colonna]
			    set colonna_length [string length $colonna]
			    if {$colonna_length > $dimension} {
				set impianti_file_ok_list [lreplace $impianti_file_ok_list $i $i [string range $colonna 0 [expr $dimension - 1]]]
				append riserva_log "Modificato $denominazione da $colonna a null,"
				append err_log "Il campo $denominazione ($colonna) deve essere al massimo di $dimension caratteri,"
				incr err_count
				incr err_riserva
			    } else {
				
				if {$range_value ne ""} {
				    set range_list [split $range_value \,]
				    set num_range [llength $range_list]
				    
				    set x 0
				    set ok_range 0
				    while {$x < $num_range} {
					if {$colonna eq [lindex $range_list]} {
					    incr ok_range
					}
					incr x
				    }
				    if {$ok_range == 0} {
					set impianti_file_ok_list [lreplace $impianti_file_ok_list $i $i $default_value]
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
	    } else {
		if {$colonna ne ""} {
		    switch $type {
			date {
			    if {$colonna eq "0000-00-00" || $colonna eq "0"} {
				set colonna "19000101"
				set impianti_file_ok_list [lreplace $impianti_file_ok_list $i $i $colonna]
			    }
			    set date [iter_edit_date $colonna]
			    #ns_write "$col_name ||$colonna || $date<br>"
			    if {[iter_check_date $date] eq "0"} {
				set impianti_file_ok_list [lreplace $impianti_file_ok_list $i $i ""]
				append riserva_log "Modificato $denominazione da $colonna a null,"
				append err_log "Il valore $denominazione ($colonna) deve essere una data,"
				incr err_count
				incr err_riserva
			    }
			}
			numeric {
			    set int_dec [split $dimension \,]
			    util_unlist $int_dec intero decimale
			    if {[iter_edit_num $colonna $decimale] ne "Error"} {
				
				set element_int_dec [split $colonna \.]
				util_unlist $element_int_dec parte_intera parte_decimale
				set max_value [expr pow(10,[expr $intero - $decimale]) - 1]
				
				if {($parte_intera > [expr $max_value - 1]) || ($parte_intera < [expr (-1 * $max_value) +1])} {
				    set impianti_file_ok_list [lreplace $impianti_file_ok_list $i $i ""]
				    append riserva_log "Modificato $denominazione da $colonna a null,"
				    append err_log "Il campo $denominazione ($colonna) deve essere numerico di [expr $intero-$decimale] cifre,"
				    incr err_count
				    incr err_riserva
				} else {
				    
				    if {$range_value ne ""} {
					set range_list [split $range_value \,]
					set num_range [llength $range_list]
					
					set x 0
					set ok_range 0
					while {$x < $num_range} {
					    if {$colonna eq [lindex $range_list]} {
						incr ok_range
					    }
					    incr x
					}
					if {$ok_range == 0} {
					    set impianti_file_ok_list [lreplace $impianti_file_ok_list $i $i $default_value]
					    append riserva_log "Modificato $denominazione da $colonna a $default_value,"
					    append err_log "Il campo $denominazione ($colonna) deve assumere uno dei seguenti valori: '$range_value' ,"
					    incr err_count
					    incr err_riserva
					}
					
				    }
				    
				} 
				set max_value [expr pow(10,$decimale)]
				if {($parte_decimale > [expr $max_value - 1])} {
				    set impianti_file_ok_list [lreplace $impianti_file_ok_list $i $i ""]
				    append riserva_log "Modificato $denominazione da $colonna a null,"
				    append err_log "Il campo $denominazione ($colonna) deve avere $decimale cifre decimali,"
				    incr err_count
				    incr err_riserva
				} else {
				    
				    if {$range_value ne ""} {
					set range_list [split $range_value \,]
					set num_range [llength $range_list]
					
					set x 0
					set ok_range 0
					while {$x < $num_range} {
					    if {$colonna eq [lindex $range_list]} {
						incr ok_range
					    }
					    incr x
					}
					if {$ok_range == 0} {
					    set impianti_file_ok_list [lreplace $impianti_file_ok_list $i $i $default_value]
					    append riserva_log "Modificato $denominazione da $colonna a $default_value,"
					    append err_log "Il campo $denominazione ($colonna) deve assumere uno dei seguenti valori: '$range_value' ,"
					    incr err_count
					    incr err_riserva
					}
					
				    }
				    
				}
			    } else {
				set impianti_file_ok_list [lreplace $impianti_file_ok_list $i $i ""]
				append riserva_log "Modificato $denominazione da $colonna a null,"
				append err_log "Il campo $denominazione ($colonna) deve essere un numero,"
				incr err_count
				incr err_riserva
			    }
			    
			}
			varchar {
			    set colonna [string toupper $colonna]
			    set colonna_length [string length $colonna]
			    if {$colonna_length > $dimension} {
				set impianti_file_ok_list [lreplace $impianti_file_ok_list $i $i [string range $colonna 0 [expr $dimension - 1]]]
				append riserva_log "Modificato $denominazione perche superava $dimension caratteri,"
				append err_log "Il campo $denominazione ($colonna) deve essere al massimo di $dimension caratteri,"
				incr err_count
				incr err_riserva
			    } else {
				
				if {($range_value ne "") && ($colonna ne "")} {
				    set range_list [split $range_value \,]
				    set num_range [llength $range_list]
				    
				    set x 0
				    set ok_range 0
				    while {$x < $num_range} {
					
					if {$colonna eq [lindex $range_list $x]} {
					    incr ok_range
					}
					incr x
				    }
				    if {$ok_range == 0} {
					set impianti_file_ok_list [lreplace $impianti_file_ok_list $i $i $default_value]
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
	    }
	    
	    incr i
	    
	} 
# 	set flag_resp [string toupper $flag_resp]
# 	switch $flag_resp {
# 	    A {
# 		if {([string toupper $natura_amm] eq "F") || ($natura_amm eq "")} {
# 		    if {($cognome_amm eq "")} {
# 			append err_log "Il campo cognome_amm e il campo nome_amm sono obbligatori,"
# 			incr err_obblig
# 		    }
# 		}
# 		if {[string toupper $natura_amm] eq "G"} {
# 		    if {$cognome_amm eq ""} {
# 			append err_log "Il campo cognome_amm è obbligatorio,"
# 			incr err_obblig
# 		    }
# 		}
# 	    }
# 	    I {
# 		if {([string toupper $natura_intestatario] eq "F") || ($natura_intestatario eq "")} { 
# 		    if {($cognome_intestatario eq "")} {
# 			append err_log "Il campo cognome_intestatario e il campo nome_intestatario sono obbligatori,"
# 			incr err_obblig
# 		    }
# 		}
# 		if {[string toupper $natura_intestatario] eq "G"} {
# 		    if {$cognome_intestatario eq ""} {
# 			append err_log "Il campo cognome_intestatario è obbligatorio,"
# 			incr err_obblig
# 		    }
# 		}
# 	    }
# 	    P {
# 		if {([string toupper $natura_prop] eq "F") || ($natura_prop eq "")} { 
# 		    if {($cognome_prop eq "")} {
# 			append err_log "Il campo cognome_prop e il campo nome_prop sono obbligatori,"
# 			incr err_obblig
# 		    }
# 		}
# 		if {[string toupper $natura_prop] eq "G"} {
# 		    if {$cognome_prop eq ""} {
# 			append err_log "Il campo cognome_prop è obbligatorio,"
# 			incr err_obblig
# 		    }
# 		}
# 	    }
# 	    T {
# 		if {([string toupper $natura_terzi] eq "F") || ($natura_terzi eq "")} { 
# 		    if {($cognome_terzi eq "")} {
# 			append err_log "Il campo cognome_terzi e il campo nome_terzi sono obbligatori,"
# 			incr err_obblig
# 		    }
# 		}
# 		if {[string toupper $natura_terzi] eq "G"} {
# 		    if {$cognome_terzi eq ""} {
# 			append err_log "Il campo cognome_terzi è obbligatorio,"
# 			incr err_obblig
# 		    }
# 		}
# 	    }
# 	    O {
# 		if {([string toupper $natura_occu] eq "F") || ($natura_occu eq "")} { 
# 		    if {($cognome_occu eq "")} {
# 			append err_log "Il campo cognome_occu e il campo nome_occu sono obbligatori,"
# 			incr err_obblig
# 		    }
# 		}
# 		if {([string toupper $natura_occu] eq "G")} {
# 		    if {$cognome_occu eq ""} {
# 			append err_log "Il campo cognome_occu è obbligatorio,"
# 			incr err_obblig
# 		    }
# 		}
# 	    }
#  	    default {
#  		if {([string toupper $natura_occu] eq "F") || ($natura_occu eq "")} { 
# 		    if {($cognome_occu eq "")} {
#  			append err_log "Il campo cognome_occu e il campo nome_occu sono obbligatori,"
#  			incr err_obblig
#  		    }
#  		}
#  		if {([string toupper $natura_occu] eq "G")} {
#  		    if {$cognome_occu eq ""} {
#  			append err_log "Il campo cognome_occu è obbligatorio,"
#  			incr err_obblig
#  		    }
#  		}
#  	    }
# 	}	

	
	if {$err_obblig > 0} {
	    #Scarto la riga perchè mancano dei valori obbligatori
	    lappend impianti_file_cols_list "Impianto scartato: $err_log"
	    iter_put_csv $err_impianti impianti_file_cols_list |
	    incr impianti_scarti
	} else {
	    if {($err_count > 0) && ($err_riserva > 0)} {
		#Vado a scrivere la lista tra gli errati, ma porto avanti quella con le correzioni
		lappend impianti_file_cols_list "$err_log"
		iter_put_csv $err_impianti impianti_file_cols_list |
		
		lappend impianti_file_ok_list "Impianto accettato con riserva: $riserva_log"
		iter_put_csv $corretti_impianti impianti_file_ok_list |
		incr impianti_riserva
	    } else {
		if {($err_count > 0) && ($err_riserva == 0)} {
		    lappend impianti_file_cols_list "Impianto scartato: $err_log"
		    iter_put_csv $err_impianti impianti_file_cols_list |
		    incr impianti_scartati
		} else {
		    
		    lappend impianti_file_ok_list "Impianto accettato"
		    #Vado a scrivere la lista nel file degli impianti corretti
		    iter_put_csv $corretti_impianti impianti_file_ok_list |
		}
	    }
	}
	
    } else {
	incr service_counter_0
	lappend impianti_file_cols_list "Impianto scartato: il numero di record letti ($found_length_file_list) non corrisponde al tracciato ($waited_length_file_list)"
	puts $log_file "Impianto scartato: il numero di record letti ($found_length_file_list) non corrisponde al tracciato ($waited_length_file_list)"
	iter_put_csv $err_impianti impianti_file_cols_list |
    }
    
    iter_get_csv $impianti_file impianti_file_cols_list |
    set impianti_file_ok_list $impianti_file_cols_list
    
}

# Setto a "" tutte le variabili usate
db_foreach sel_liste_csv "" {
    set nome_colonna ""
}

#Setto la variabile con la quale identifica il file che vado a leggere
set csv_name "rapporti"

#scrivo la lista delle variabili per il file degli rapporti
set rapporti_file_cols "" 

set count_fields 0
db_foreach sel_liste_csv "" {
    #Creo la lista
    lappend rapporti_file_cols $nome_colonna
    #Memorizzo in un array tutti i dati relativi ad un singoloo campo, necessari per la successiva analisi
    set rapporti_fields($count_fields) [list $nome_colonna $denominazione $tipo_dato $dimensione $obbligatorio $default_value $range_value]
    incr count_fields
}
lappend rapporti_file_cols cod_tanom

#Lettura del file dei rapporti

#Salto la prima riga di intestazione del file csv, andando a scrivere l'intestazione nei file in uscita 
iter_get_csv $rapporti_file rapporti_file_cols_list |

iter_put_csv $corretti_rapporti rapporti_file_cols_list |
iter_put_csv $err_rapporti rapporti_file_cols_list |

#Setto la variabile contenente il numero di elementi attesi nella lista
set waited_length_file_list [expr $count_fields +1]
#Modifica per vigevano
#set waited_length_file_list [expr $waited_length_file_list +1]

#Comincio la lettura dei records
iter_get_csv $rapporti_file rapporti_file_cols_list |

set rapporti_file_ok_list $rapporti_file_cols_list

while {![eof $rapporti_file]} {

    #@found_length_file_list contiene il numero di record    
    set found_length_file_list [llength $rapporti_file_cols_list]

    incr rapporti_letti
    incr count_2
    set righe_contate [expr $count_2%$dividendo]
    if {$righe_contate eq 0} {
	set time [clock format [clock seconds]]
	puts $log_file "Analisi completata per $count_2 rapporti $time"
	ns_write "Analisi completata per $count_2 rapporti $time <br>"
    }   

    #log degli errori
    set riserva_log ""
    set err_log ""
    set err_count 0
    set err_obblig 0
    set err_riserva 0
    set ind 0

    foreach column_name $rapporti_file_cols {
	set $column_name [lindex $rapporti_file_cols_list $ind]
	incr ind
    }
    if {$found_length_file_list == $waited_length_file_list} {

	set i 0
	while {$i < $count_fields} {
	    
	    set colonna [lindex $rapporti_file_ok_list $i]
	    set colonna [string trim $colonna]
	    
	    util_unlist $rapporti_fields($i) col_name denominazione type dimension obbligatorio default_value range_value
	    #	ns_write "$col_name || $colonna || $type || $dimension || $obbligatorio || $default_value || $range_value<br>"
	    
	    set element [set col_name]
	    
	    # Bonifico l'elemento da possibili caratteri accentati che non vengono accettati dal database
	    set colonna [string map {\\ "" \r " " \n " " \r\n " "} $colonna]
	    set rapporti_file_ok_list [lreplace $rapporti_file_ok_list $i $i $colonna]
	    
	    
	    if {$obbligatorio eq "S"} {
		if {$element eq "" || [string is space $element]} {
		    append err_log "Il campo $denominazione è obbligatorio,"
		    incr err_obblig
		} else {
		    switch $type {
			date {
			    if {$colonna eq "0000-00-00" || $colonna eq "0"} {
				set colonna "19000101"
				set rapporti_file_ok_list [lreplace $rapporti_file_ok_list $i $i $colonna]
			    }
			    set date [iter_edit_date $colonna]			    
			    #ns_write "$col_name ||$colonna || $date<br>"
			    if {[iter_check_date $date] eq "0"} {
				set rapporti_file_ok_list [lreplace $rapporti_file_ok_list $i $i ""]
				append riserva_log "Modificato $denominazione da $colonna a null,"
				append err_log "Il valore $denominazione ($colonna) deve essere una data,"
				incr err_count
				incr err_riserva
			    }
			}
			numeric {
			    set int_dec [split $dimension \,]
			    util_unlist $int_dec intero decimale
			    if {[iter_edit_num $colonna $decimale] ne "Error"} {
				
				set element_int_dec [split $colonna \.]
				util_unlist $element_int_dec parte_intera parte_decimale
				set max_value [expr pow(10,[expr $intero - $decimale]) - 1]
				
				if {($parte_intera > $max_value) || ($parte_intera < [expr (-1) * $max_value])} {
				    set rapporti_file_ok_list [lreplace $rapporti_file_ok_list $i $i ""]
				    append riserva_log "Modificato $denominazione da $colonna a null,"
				    append err_log "Il campo $denominazione ($colonna) deve essere numerico di [expr $intero-$decimale] cifre,"
				    incr err_count
				    incr err_riserva
				} else {
				    
				    if {$range_value ne ""} {
					set range_list [split $range_value \,]
					set num_range [llength $range_list]
					
					set x 0
					set ok_range 0
					while {$x < $num_range} {
					    if {$colonna eq [lindex $range_list $x]} {
						incr ok_range
					    }
					    incr x
					}
					if {$ok_range == 0} {
					    set rapporti_file_ok_list [lreplace $rapporti_file_ok_list $i $i $default_value]
					    append riserva_log "Modificato $denominazione da $colonna a $default_value,"
					    append err_log "Il campo $denominazione ($colonna) deve assumere uno dei seguenti valori: '$range_value' ,"
					    incr err_count
					    incr err_riserva
					}
					
				    }
				    
				} 
				set max_value [expr pow(10,$decimale)]
				if {($parte_decimale > [expr $max_value - 1])} {
				    set rapporti_file_ok_list [lreplace $rapporti_file_ok_list $i $i ""]
				    append riserva_log "Modificato $denominazione da $colonna a null,"
				    append err_log "Il campo $denominazione ($colonna) deve avere $decimale cifre decimali,"
				    incr err_count
				    incr err_riserva
				} else {
				    
				    if {$range_value ne ""} {
					set range_list [split $range_value \,]
					set num_range [llength $range_list]
					
					set x 0
					set ok_range 0
					while {$x < $num_range} {
					    if {$colonna eq [lindex $range_list $x]} {
						incr ok_range
					    }
					    incr x
					}
					if {$ok_range == 0} {
					    set rapporti_file_ok_list [lreplace $rapporti_file_ok_list $i $i $default_value]
					    append riserva_log "Modificato $denominazione da $colonna a $default_value,"
					    append err_log "Il campo $denominazione ($colonna) deve assumere uno dei seguenti valori: '$range_value' ,"
					    incr err_count
					    incr err_riserva
					}
					
				    }
				    
				}
				
			    } else {
				set rapporti_file_ok_list [lreplace $rapporti_file_ok_list $i $i ""]
				append riserva_log "Modificato $denominazione da $colonna a null,"
				append err_log "Il campo $denominazione ($colonna) deve essere un numero,"
				incr err_count
				incr err_riserva
			    }
			}
			
			varchar {
			    set colonna [string toupper $colonna]
			    set colonna_length [string length $colonna]
			    if {$colonna_length > $dimension} {
				set rapporti_file_ok_list [lreplace $rapporti_file_ok_list $i $i [string range $colonna 0 [expr $dimension - 1]]]
				append riserva_log "Modificato $denominazione da $colonna a null,"
				append err_log "Il campo $denominazione ($colonna) deve essere al massimo di $dimension caratteri,"
				incr err_count
				incr err_riserva
			    } else {
				
				if {$range_value ne ""} {
				    set range_list [split $range_value \,]
				    set num_range [llength $range_list]
				    
				    set x 0
				    set ok_range 0
				    while {$x < $num_range} {
					if {$colonna eq [lindex $range_list $x]} {
					    incr ok_range
					}
					incr x
				    }
				    if {$ok_range == 0} {
					set rapporti_file_ok_list [lreplace $rapporti_file_ok_list $i $i $default_value]
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
		
	    } else {
		if {$colonna ne ""} {
		    switch $type {
			date {
			    if {$colonna eq "0000-00-00" || $colonna eq "0"} {
				set colonna "19000101" 
				set rapporti_file_ok_list [lreplace $rapporti_file_ok_list $i $i $colonna]
			    }
			    set date [iter_edit_date $colonna]
			    #ns_write "$col_name ||$colonna || $date<br>"
			    if {[iter_check_date $date] eq "0"} {
				set rapporti_file_ok_list [lreplace $rapporti_file_ok_list $i $i ""]
				append riserva_log "Modificato $denominazione,"
				append err_log "Il valore $denominazione deve essere una data,"
				incr err_count
				incr err_riserva
			    }
			}
			numeric {
			    set int_dec [split $dimension \,]
			    util_unlist $int_dec intero decimale
			    if {[iter_edit_num $colonna $decimale] ne "Error"} {
				
				set element_int_dec [split $colonna \.]
				util_unlist $element_int_dec parte_intera parte_decimale
				set max_value [expr pow(10,[expr $intero - $decimale]) - 1]
				
				if {($parte_intera > $max_value) || ($parte_intera < [expr (-1) * $max_value])} {
				    set rapporti_file_ok_list [lreplace $rapporti_file_ok_list $i $i ""]
				    append riserva_log "Modificato $denominazione da $colonna a null,"
				    append err_log "Il campo $denominazione ($colonna) deve essere numerico di [expr $intero-$decimale] cifre,"
				    incr err_count
				    incr err_riserva
				} else {
				    
				    if {$range_value ne ""} {
					set range_list [split $range_value \,]
					set num_range [llength $range_list]
					
					set x 0
					set ok_range 0
					while {$x < $num_range} {
					    if {$colonna eq [lindex $range_list $x]} {
						incr ok_range
					    }
					    incr x
					}
					if {$ok_range == 0} {
					    set rapporti_file_ok_list [lreplace $rapporti_file_ok_list $i $i $default_value]
					    append riserva_log "Modificato $denominazione da $colonna a $default_value,"
					    append err_log "Il campo $denominazione ($colonna) deve assumere uno dei seguenti valori: '$range_value' ,"
					    incr err_count
					    incr err_riserva
					}				       
				    }				   
				} 
				set max_value [expr pow(10,$decimale)]
				if {($parte_decimale > [expr $max_value - 1])} {
				    set rapporti_file_ok_list [lreplace $rapporti_file_ok_list $i $i ""]
				    append riserva_log "Modificato $denominazione da $colonna a null,"
				    append err_log "Il campo $denominazione ($colonna) deve avere $decimale cifre decimali,"
				    incr err_count
				    incr err_riserva
				} else {
				    
				    if {$range_value ne ""} {
					set range_list [split $range_value \,]
					set num_range [llength $range_list]
					
					set x 0
					set ok_range 0
					while {$x < $num_range} {
					    if {$colonna eq [lindex $range_list $x]} {
						incr ok_range
					    }
					    incr x
					}
					if {$ok_range == 0} {
					    set rapporti_file_ok_list [lreplace $rapporti_file_ok_list $i $i $default_value]
					    append riserva_log "Modificato $denominazione da $colonna a $default_value,"
					    append err_log "Il campo $denominazione ($colonna) deve assumere uno dei seguenti valori: '$range_value' ,"
					    incr err_count
					    incr err_riserva
					}
					
				    }
				    
				}
			    } else {
				set rapporti_file_ok_list [lreplace $rapporti_file_ok_list $i $i ""]
				append riserva_log "Modificato $denominazione da $colonna a null,"
				append err_log "Il campo $denominazione ($colonna) deve essere un numero,"
				incr err_count
				incr err_riserva
			    }
			}
			
			varchar {
			    set colonna [string toupper $colonna]
			    set colonna_length [string length $colonna]
			    if {$colonna_length > $dimension} {
				set rapporti_file_ok_list [lreplace $rapporti_file_ok_list $i $i [string range $colonna 0 [expr $dimension - 1]]]
				append riserva_log "Modificato $denominazione perche superava $dimension caratteri,"
				append err_log "Il campo $denominazione ($colonna) deve essere al massimo di $dimension caratteri,"
				incr err_count
				incr err_riserva
			    } else {
				
				if {($range_value ne "") && ($colonna ne "")} {
				    set range_list [split $range_value \,]
				    set num_range [llength $range_list]
				    
				    set x 0
				    set ok_range 0
				    while {$x < $num_range} {
					
					if {$colonna eq [lindex $range_list $x]} {
					    incr ok_range
					}
					incr x
				    }
				    if {$ok_range == 0} {
					set rapporti_file_ok_list [lreplace $rapporti_file_ok_list $i $i $default_value]
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
	    }    
	    incr i
	}
	
	#Controllo che le anomalie segnalate siano presenti nella tabella coimtano
	# e quindi conformi agli standard della regione lombardia	    
 	set anomalie_impianto [split $cod_tanom \,]
	set num_anom [llength $anomalie_impianto]
 	set errore_tanom 0
	for {set i 0} {$i < $num_anom-1} {incr i} { 
		if {[string trim [lindex $anomalie_impianto $i]] ne ""} {
	    set anomalia [lindex $anomalie_impianto $i]
 	    set anomalia [string trim $anomalia]
 		    if {![info exists anomalie_lombardia($anomalia)]} {
 			append err_log "Codice anomalia $anomalia non valido,"
 			incr errore_tanom
 		    }
 		}
 	} 

	# Se il rapporto contiene anomalie non valide viene scartato...	
	if {$errore_tanom > 0} {
	    incr err_obblig
	}    
	
	if {$err_obblig > 0} {
	    # Scarto la riga perchè mancano dei valori obbligatori
	    lappend rapporti_file_cols_list "Rapporto scartato: $err_log"
	    iter_put_csv $err_rapporti rapporti_file_cols_list |
	    incr rapporti_scarti
	} else {
	    if {($err_count > 0) && ($err_riserva > 0)} {
		# Vado a scrivere la lista tra gli errati, ma porto avanti quella con le correzioni
		lappend rapporti_file_cols_list "$err_log"
		iter_put_csv $err_rapporti rapporti_file_cols_list |
		
		lappend rapporti_file_ok_list "Rapporto accettato con riserva: $riserva_log"
		iter_put_csv $corretti_rapporti rapporti_file_ok_list |
		incr rapporti_riserva
	    } else {
		if {($err_count > 0) && ($err_riserva == 0)} {
		    lappend rapporti_file_cols_list "Rapporto scartato: $err_log"
		    iter_put_csv $err_rapporti rapporti_file_cols_list |
		    incr rapporti_scartati
		} else {
		    
		    lappend rapporti_file_ok_list "Rapporto accettato"
		    # Vado a scrivere la lista nel file degli rapporti corretti
		    iter_put_csv $corretti_rapporti rapporti_file_ok_list |
		}
	    }
	}

    } else {
	incr service_counter_1
	lappend rapporti_file_cols_list "Rapporto scartato: il numero di record non corrisponde al tracciato"
	puts $log_file "Rapporto scartato: il numero di record letti ($found_length_file_list) non corrisponde al tracciato ($waited_length_file_list)"
	iter_put_csv $err_rapporti rapporti_file_cols_list |
    }
	
    iter_get_csv $rapporti_file rapporti_file_cols_list |
    set rapporti_file_ok_list $rapporti_file_cols_list
}

# Setto a "" tutte le variabili usate
db_foreach sel_liste_csv "" {
    set nome_colonna ""
}
set cod_tanom ""

#Setto la variabile con la quale identifica il file che vado a leggere
set csv_name "autocert"

#scrivo la lista delle variabili per il file degli autocertificazioni
set autocertificazioni_file_cols "" 

set count_fields 0
db_foreach sel_liste_csv "" {
    #Creo la lista
    lappend autocertificazioni_file_cols $nome_colonna
    #Memorizzo in un array tutti i dati relativi ad un singoloo campo, necessari per la successiva analisi
    set autocertificazioni_fields($count_fields) [list $nome_colonna $denominazione $tipo_dato $dimensione $obbligatorio $default_value $range_value]
    incr count_fields
}
lappend sutocertificazioni_file_cols cod_tanom

#Salto la prima riga di intestazione del file csv, andando a scrivere l'intestazione nei file in uscita 
iter_get_csv $autocertificazioni_file autocertificazioni_file_cols_list |

iter_put_csv $corretti_autocertificazioni autocertificazioni_file_cols_list |
iter_put_csv $err_autocertificazioni autocertificazioni_file_cols_list |

#Setto la variabile contenente il numero di elementi attesi nella lista
set waited_length_file_list [expr $count_fields +1]

#Comincio la lettura dei records
iter_get_csv $autocertificazioni_file autocertificazioni_file_cols_list |

set autocertificazioni_file_ok_list $autocertificazioni_file_cols_list

while {![eof $autocertificazioni_file]} {
    
    incr autocertificazioni_letti
    incr count_3
    set righe_contate [expr $count_3%$dividendo]
    if {$righe_contate eq 0} {
	set time [clock format [clock seconds]]
	puts $log_file "Analisi completata per $count_3 autocertificazioni $time"
	ns_write "Analisi completata per $count_3 autocertificazioni $time <br>"
    }   
    
    #log degli errori
    set riserva_log ""
    set err_log ""
    set err_count 0
    set err_obblig 0
    set err_riserva 0
    set ind 0
    #@found_length_file_list contiene il numero di record presenti nella lista
    set found_length_file_list [llength $autocertificazioni_file_cols_list]     
#ns_write "$waited_length_file_list<br>$autocertificazioni_file_ok_list <br>$found_length_file_list <br>"    
    foreach column_name $autocertificazioni_file_cols {
	set $column_name [lindex $autocertificazioni_file_cols_list $ind]
	incr ind
    }
    if {$found_length_file_list == $waited_length_file_list} {
	
	set i 0
	while {$i < $count_fields} {
	    
	    set colonna [lindex $autocertificazioni_file_ok_list $i]
	    set colonna [string trim $colonna]
	    
	    util_unlist $autocertificazioni_fields($i) col_name denominazione type dimension obbligatorio default_value range_value
	    #	#ns_write "$col_name || $colonna || $type || $dimension || $obbligatorio || $default_value || $range_value<br>"
	    
	    set element [set col_name]
	    
	    # Bonifico l'elemento da possibili caratteri accentati che non vengono accettati dal database
	    set colonna [string map {\\ "" \r " " \n " " \r\n " "} $colonna]
	    set autocertificazioni_file_ok_list [lreplace $autocertificazioni_file_ok_list $i $i $colonna]
	    
	    
	    if {$obbligatorio eq "S"} {
		if {$element eq "" || [string is space $element]} {
		    append err_log "Il campo $denominazione è obbligatorio,"
		    incr err_obblig
		} else {
		    switch $type {
			date {
			    if {$colonna eq "0000-00-00" || $colonna eq "0"} {
				set colonna "19000101"
				set autocertificazioni_file_ok_list [lreplace $autocertificazioni_file_ok_list $i $i $colonna]
			    }
			    set date [iter_edit_date $colonna]			    
			    #ns_write "$col_name ||$colonna || $date<br>"
			    if {[iter_check_date $date] eq "0"} {
				set autocertificazioni_file_ok_list [lreplace $autocertificazioni_file_ok_list $i $i ""]
				append riserva_log "Modificato $denominazione da $colonna a null,"
				append err_log "Il valore $denominazione ($colonna) deve essere una data,"
				incr err_count
				incr err_riserva
			    }
			}
			numeric {
			    set int_dec [split $dimension \,]
			    util_unlist $int_dec intero decimale
			    if {[iter_edit_num $colonna $decimale] ne "Error"} {

				set element_int_dec [split $colonna \.]
				util_unlist $element_int_dec parte_intera parte_decimale
				set max_value [expr pow(10,[expr $intero - $decimale]) - 1]
				
				if {($parte_intera > [expr $max_value - 1]) || ($parte_intera < [expr (-1 * $max_value) +1])} {
				    set autocertificazioni_file_ok_list [lreplace $autocertificazioni_file_ok_list $i $i ""]
				    append riserva_log "Modificato $denominazione da $colonna a null,"
				    append err_log "Il campo $denominazione ($colonna) deve essere numerico di [expr $intero-$decimale] cifre,"
				    incr err_count
				    incr err_riserva
				} else {
				    
				    if {$range_value ne ""} {
					set range_list [split $range_value \,]
					set num_range [llength $range_list]
					
					set x 0
					set ok_range 0
					while {$x < $num_range} {
					    if {$colonna eq [lindex $range_list $x]} {
						incr ok_range
					    }
					    incr x
					}
					if {$ok_range == 0} {
					    set autocertificazioni_file_ok_list [lreplace $autocertificazioni_file_ok_list $i $i $default_value]
					    append riserva_log "Modificato $denominazione da $colonna a $default_value,"
					    append err_log "Il campo $denominazione ($colonna) deve assumere uno dei seguenti valori: '$range_value' ,"
					    incr err_count
					    incr err_riserva
					}
					
				    }
				    
				} 
				set max_value [expr pow(10,$decimale)]
				if {($parte_decimale > [expr $max_value - 1])} {
				    set autocertificazioni_file_ok_list [lreplace $autocertificazioni_file_ok_list $i $i ""]
				    append riserva_log "Modificato $denominazione da $colonna a null,"
				    append err_log "Il campo $denominazione ($colonna) deve avere $decimale cifre decimali,"
				    incr err_count
				    incr err_riserva
				} else {
				    
				    if {$range_value ne ""} {
					set range_list [split $range_value \,]
					set num_range [llength $range_list]
					
					set x 0
					set ok_range 0
					while {$x < $num_range} {
					    if {$colonna eq [lindex $range_list $x]} {
						incr ok_range
					    }
					    incr x
					}
					if {$ok_range == 0} {
					    set autocertificazioni_file_ok_list [lreplace $autocertificazioni_file_ok_list $i $i $default_value]
					    append riserva_log "Modificato $denominazione da $colonna a $default_value,"
					    append err_log "Il campo $denominazione ($colonna) deve assumere uno dei seguenti valori: '$range_value' ,"
					    incr err_count
					    incr err_riserva
					}
				    
				    }
				    
				}
			    } else {
				set autocertificazioni_file_ok_list [lreplace $autocertificazioni_file_ok_list $i $i ""]
				append riserva_log "Modificato $denominazione da $colonna a null,"
				append err_log "Il campo $denominazione ($colonna) deve essere un numero,"
				incr err_count
				incr err_riserva
			    }
			    
			}
			varchar {
			    set colonna [string toupper $colonna]
			    set colonna_length [string length $colonna]
			    if {$colonna_length > $dimension} {
				set autocertificazioni_file_ok_list [lreplace $autocertificazioni_file_ok_list $i $i [string range $colonna 0 [expr $dimension - 1]]]
				append riserva_log "Modificato $denominazione da $colonna a null,"
				append err_log "Il campo $denominazione ($colonna) deve essere al massimo di $dimension caratteri,"
				incr err_count
				incr err_riserva
			    } else {
				
				if {$range_value ne ""} {
				    set range_list [split $range_value \,]
				    set num_range [llength $range_list]
				    
				    set x 0
				    set ok_range 0
				    while {$x < $num_range} {
					if {$colonna eq [lindex $range_list $x]} {
					    incr ok_range
					}
					incr x
				    }
				    if {$ok_range == 0} {
					set autocertificazioni_file_ok_list [lreplace $autocertificazioni_file_ok_list $i $i $default_value]
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
		
	    } else {
		if {$colonna ne ""} {
		    switch $type {
			date {
			    if {$colonna eq "0000-00-00" || $colonna eq "0"} {
				set colonna "19000101"
				set autocertificazioni_file_ok_list [lreplace $autocertificazioni_file_ok_list $i $i $colonna]
			    }
			    set date [iter_edit_date $colonna]
			    #ns_write "$col_name ||$colonna || $date<br>"
			    if {[iter_check_date $date] eq "0"} {
				set autocertificazioni_file_ok_list [lreplace $autocertificazioni_file_ok_list $i $i ""]
				append riserva_log "Modificato $denominazione da $colonna a null,"
				append err_log "Il valore $denominazione ($colonna) deve essere una data,"
				incr err_count
				incr err_riserva
			    }
			}
			numeric {
			    set int_dec [split $dimension \,]
			    util_unlist $int_dec intero decimale
			    if {[iter_edit_num $colonna $decimale] ne "Error"} {
				
				set element_int_dec [split $colonna \.]
				util_unlist $element_int_dec parte_intera parte_decimale
				set max_value [expr pow(10,[expr $intero - $decimale]) - 1]
				
				if {($parte_intera > [expr $max_value - 1]) || ($parte_intera < [expr (-1 * $max_value) +1])} {
				    set autocertificazioni_file_ok_list [lreplace $autocertificazioni_file_ok_list $i $i ""]
				    append riserva_log "Modificato $denominazione da $colonna a null,"
				    append err_log "Il campo $denominazione ($colonna) deve essere numerico di [expr $intero-$decimale] cifre,"
				    incr err_count
				    incr err_riserva
				} else {
				    
				    if {$range_value ne ""} {
					set range_list [split $range_value \,]
					set num_range [llength $range_list]
					
					set x 0
					set ok_range 0
					while {$x < $num_range} {
					    if {$colonna eq [lindex $range_list $x]} {
						incr ok_range
					    }
					    incr x
					}
					if {$ok_range == 0} {
					    set autocertificazioni_file_ok_list [lreplace $autocertificazioni_file_ok_list $i $i $default_value]
					    append riserva_log "Modificato $denominazione da $colonna a $default_value,"
					    append err_log "Il campo $denominazione ($colonna) deve assumere uno dei seguenti valori: '$range_value' ,"
					    incr err_count
					    incr err_riserva
					}
					
				    }
				    
				} 
				set max_value [expr pow(10,$decimale)]
				if {($parte_decimale > [expr $max_value - 1])} {
				    set autocertificazioni_file_ok_list [lreplace $autocertificazioni_file_ok_list $i $i ""]
				    append riserva_log "Modificato $denominazione da $colonna a null,"
				    append err_log "Il campo $denominazione ($colonna) deve avere $decimale cifre decimali,"
				    incr err_count
				    incr err_riserva
				} else {
				    
				    if {$range_value ne ""} {
					set range_list [split $range_value \,]
					set num_range [llength $range_list]
					
					set x 0
					set ok_range 0
					while {$x < $num_range} {
					    if {$colonna eq [lindex $range_list $x]} {
						incr ok_range
					    }
					    incr x
					}
					if {$ok_range == 0} {
					    set autocertificazioni_file_ok_list [lreplace $autocertificazioni_file_ok_list $i $i $default_value]
					    append riserva_log "Modificato $denominazione da $colonna a $default_value,"
					    append err_log "Il campo $denominazione ($colonna) deve assumere uno dei seguenti valori: '$range_value' ,"
					    incr err_count
					    incr err_riserva
					}
					
				    }
				    
				}
			    } else {
				set autocertificazioni_file_ok_list [lreplace $autocertificazioni_file_ok_list $i $i ""]
				append riserva_log "Modificato $denominazione da $colonna a null,"
				append err_log "Il campo $denominazione ($colonna) deve essere un numero,"
				incr err_count
				incr err_riserva
			    }
			    
			}
			varchar {
			    set colonna [string toupper $colonna]
			    set colonna_length [string length $colonna]
			    if {$colonna_length > $dimension} {
				set autocertificazioni_file_ok_list [lreplace $autocertificazioni_file_ok_list $i $i [string range $colonna 0 [expr $dimension - 1]]]
				append riserva_log "Modificato $denominazione perche superava $dimension caratteri,"
				append err_log "Il campo $denominazione ($colonna) deve essere al massimo di $dimension caratteri,"
				incr err_count
				incr err_riserva
			    } else {
				
				if {($range_value ne "") && ($colonna ne "")} {
				    set range_list [split $range_value \,]
				    set num_range [llength $range_list]
				    
				    set x 0
				    set ok_range 0
				    while {$x < $num_range} {
					
					if {$colonna eq [lindex $range_list $x]} {
					    incr ok_range
					}
					incr x
				    }
				    if {$ok_range == 0} {
					set autocertificazioni_file_ok_list [lreplace $autocertificazioni_file_ok_list $i $i $default_value]
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
	    }    
	    incr i
	}
	
	#Controllo che le anomalie segnalate siano presenti nella tabella coimtano
	# e quindi conformi agli standard della regione lombardia	    
	set anomalie_impianto [split $cod_tanom \,]
	set num_anom [llength $anomalie_impianto]
	set errore_tanom 0
 	for {set i 0} {$i < $num_anom-1} {incr i} {
 		if {[string trim [lindex $anomalie_impianto $i]] ne ""} {
 	    set anomalia [lindex $anomalie_impianto $i]
 	    set anomalia [string trim $anomalia]
 		    if {![info exists anomalie_lombardia($anomalia)]} {
 			append err_log "Codice anomalia $anomalia non valido,"
 			set errore_tanom 1
 		    }
 		}
 	} 
	
	if {$errore_tanom == 1} {
	    incr err_obblig
	}    
        
	
	if {$err_obblig > 0} {
	    #Scarto la riga perchè mancano dei valori obbligatori
	    lappend autocertificazioni_file_cols_list "Autocertificazione scartata: $err_log"
	    iter_put_csv $err_autocertificazioni autocertificazioni_file_cols_list |
	    incr autocertificazioni_scarti
	} else {
	    if {($err_count > 0) && ($err_riserva > 0)} {
		#Vado a scrivere la lista tra gli errati, ma porto avanti quella con le correzioni
		lappend autocertificazioni_file_cols_list "$err_log"
		iter_put_csv $err_autocertificazioni autocertificazioni_file_cols_list |
		
		lappend autocertificazioni_file_ok_list "Autocertificazione accettata con riserva: $riserva_log"
		iter_put_csv $corretti_autocertificazioni autocertificazioni_file_ok_list |
		incr autocertificazioni_riserva
	    } else {
		if {($err_count > 0) && ($err_riserva == 0)} {
		    lappend autocertificazioni_file_cols_list "Autocertificazione scartata: $err_log"
		    iter_put_csv $err_autocertificazioni autocertificazioni_file_cols_list |
		    incr autocertificazioni_scartati
		} else {
		    
		    lappend autocertificazioni_file_ok_list "Autocertificazione accettata"
		    #Vado a scrivere la lista nel file degli autocertificazioni corretti
		    iter_put_csv $corretti_autocertificazioni autocertificazioni_file_ok_list |
		}
	    }
	}
    } else {
	incr service_counter_2
	lappend autocertificazioni_file_cols_list "Autocertificazione scartata: il numero di record non corrisponde al tracciato"
	puts $log_file "Autocertificazione scarata: il numero di record letti ($found_length_file_list) non corrisponde al tracciato ($waited_length_file_list)"
	iter_put_csv $err_autocertificazioni autocertificazioni_file_cols_list |
    }
	
    iter_get_csv $autocertificazioni_file autocertificazioni_file_cols_list |
    set autocertificazioni_file_ok_list $autocertificazioni_file_cols_list
}

# Setto a "" tutte le variabili usate
db_foreach sel_liste_csv "" {
    set nome_colonna ""
}
set cod_tanom ""

#ora di fine flusso
set time_end [clock format [clock seconds]]

# Chiudo tutti i file utilizzati
close $impianti_file
close $rapporti_file
close $autocertificazioni_file

close $corretti_impianti
close $corretti_rapporti
close $corretti_autocertificazioni

close $err_impianti
close $err_rapporti
close $err_autocertificazioni

# Creo i pacchetti dei file da scaricare dall'utente
#exec tar czf "dati_corretti.tar.gz" $corretti_dir
#exec tar czf "dati_errati.tar.gz" $errati_dir

set report_url "coimcari-report?nome_funz=cari-report&aimp_mod=$service_counter_0&cimp_mod=$service_counter_1&dimp_mod=$service_counter_2&impianti_letti=$impianti_letti&impianti_scarti=$impianti_scarti&impianti_riserva=$impianti_riserva&rapporti_letti=$rapporti_letti&rapporti_scarti=$rapporti_scarti&rapporti_riserva=$rapporti_riserva&autocertificazioni_riserva=$autocertificazioni_riserva&autocertificazioni_letti=$autocertificazioni_letti&autocertificazioni_scarti=$autocertificazioni_scarti"

#Scrivo nel file di log il report dell'analisi dati
puts $log_file "Errori di impaginazione nel file degli impianti:$service_counter_0;\nErrori di impaginazione del file dei rapporti: $service_counter_1;\nErrori di impaginazione nel file delle autocertificazioni: $service_counter_2;\nImpianti letti: $impianti_letti;\nImpianti scartati: $impianti_scarti;\nImpianti accettati con riserva: $impianti_riserva;\nRapporti letti: $rapporti_letti;\nRapporti scartati: $rapporti_scarti;\nRapporti accettati con riserva: $rapporti_riserva;\nAutocertificazioni lette: $autocertificazioni_letti;\nAutocertificazioni scartate: $autocertificazioni_scarti;\nAutocertificazioni accettate con riserva: $autocertificazioni_riserva;\n"

ns_write "Analisi completata: ora di fine <b>$time_end</b> <br>"
puts $log_file "Analisi completata: ora di fine $time_end"
ns_write "Fine<br><br>"
puts $log_file "Fine"
ns_write "<a href=$report_url>Visualizza i risultati del caricamento</a>"

close $log_file
#ad_return_template

