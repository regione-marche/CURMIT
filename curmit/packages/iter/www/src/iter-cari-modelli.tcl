ad_page_contract {
 @author dob
} {
    tipo_modello
    cod_manutentore
    file_name
}     

# reperisco le colonne della tabella parametri
iter_get_coimtgen
set flag_cod_aimp_auto $coimtgen(flag_cod_aimp_auto)
set flag_codifica_reg  $coimtgen(flag_codifica_reg)
set num_anom_max [db_string sel_num_anom_max "select num_anom_max from coimtgen"]
set flag_portafoglio [db_string query "select flag_portafoglio from coimtgen"]


# valorizzo la data_corrente (serve per l'inserimento)
set data_corrente  [iter_set_sysdate]
set ora_corrente   [iter_set_systime]

set permanenti_dir [iter_set_permanenti_dir]

set file_inp_name  "Caricamento-manutentori-input"
set file_inp_name  [iter_temp_file_name -permanenti $file_inp_name]

set file_table_name  "create-table"
set file_table_name  [iter_temp_file_name -permanenti $file_table_name]

set file_esi_name  "Caricamento-manutentori-esito"
set file_esi_name  [iter_temp_file_name -permanenti $file_esi_name]

ns_log notice "prova dob 1 file_esi_name = $file_esi_name file_table_name = $file_table_name file_inp_name = $file_inp_name "

# rinomino il file (che per ora ha lo stesso nome di origine)
# con un nome legato al programma ed all'ora di esecuzione

set file_inp       "${permanenti_dir}/$file_inp_name.csv"
exec mv $file_name $file_inp

set file_table     "${permanenti_dir}/$file_table_name.sql"
set file_esi       "${permanenti_dir}/$file_esi_name.adp"

ns_log notice "prova dob 2 file_esi = $file_esi file_table = $file_table file_inp = $file_inp "

if {[catch {set file_inp_id [open $file_inp r]}]} {
    iter_return_complaint "File csv di input non aperto: $file_inp"
}
fconfigure $file_inp_id -encoding iso8859-1

if {[catch {set file_table_id [open $file_table w]}]} {
    iter_return_complaint "File creazione tabella non aperto: $file_table"
}

if {[catch {set file_esi_id [open $file_esi w]}]} {
    iter_return_complaint "File di esito caricamento non aperto: $file_esi"
}
fconfigure $file_esi_id -encoding iso8859-1 -translation crlf

# PRIMO STEP: Controllo che il file riporti lo stesso manutentore su tutte le righe (Nel caso di utente manutentore deve riportare la sua ditta)
set cod_manutentore_chk $cod_manutentore
set head_cols ""
set file_cols ""
set count_fields 0

db_foreach sel_liste_csv "select nome_colonna
                               , denominazione
                               , tipo_dato
	                       , dimensione
	                       , obbligatorio
	                       , default_value
	                       , range_value
	                   from coimtabs 
	                  where nome_tabella = :tipo_modello 
	                   order by ordinamento
" {
    
    lappend head_cols $denominazione
    lappend file_cols $nome_colonna
    set file_fields($count_fields) [list $nome_colonna $denominazione $tipo_dato $dimensione $obbligatorio $default_value $range_value]
    incr count_fields		
}


set err_log ""

set lunghezza_attesa [expr $count_fields]

#record titoli da saltare
iter_get_csv $file_inp_id file_inp_col_list |

iter_get_csv $file_inp_id file_inp_col_list |
set lunghezza_letta [llength $file_inp_col_list]

while {![eof $file_inp_id]} {
    set ind 0
    foreach column_name $file_cols {
	set $column_name [lindex $file_inp_col_list $ind]
	incr ind
    }
    
    if {$lunghezza_letta == $lunghezza_attesa
	|| $lunghezza_letta == [expr $lunghezza_attesa + 6]} {
	
	if {[string equal $cod_manutentore_chk ""]} {
	    set cod_manutentore_chk $cod_manutentore
	} else {
	    if {$cod_manutentore != $cod_manutentore_chk
		|| [string equal $cod_manutentore ""]} {
		append err_log "L'intero lotto &egrave; stato scartato in quanto non presenta un'unica ditta di manutenzione o l'utente manutentore non corrisponde alla ditta del file ($cod_manutentore $cod_manutentore_chk)"
		break
	    }
	}
    } else {
	append err_log "L'intero lotto &egrave; stato scartato in quanto la lunghezza di una riga ($lunghezza_letta) non corrisponde alla lunghezza prevista ($lunghezza_attesa)."
	break
    }
    iter_get_csv $file_inp_id file_inp_col_list |
    set lunghezza_letta [llength $file_inp_col_list]
}

if {[string equal $err_log ""]} {
	
    set nome_tabella $tipo_modello
   
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
    
    puts $file_table_id "create table $nome_tabella
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
	
	puts $file_table_id "$nome_colonna   varchar($dimensione)
                                     , "
	incr i
    }
    
    set nome_index $nome_tabella
    append nome_index "_00"
    set nome_sequence $nome_tabella
    append nome_sequence "_s"
    puts $file_table_id "id_riga  varchar(08)
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
    
    close $file_table_id
    set database [db_get_database]
    exec psql $database -h 10.252.10.3 -f ${permanenti_dir}/$file_table_name.sql
    
    close $file_inp_id
    
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
	    set colonna [string toupper $colonna]
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


#setto un array contenente tutti i codici delle anomalie per verificare la loro esistenza durante il caricamento dei modelli
db_foreach sel_cod_tanom "select cod_tano as codice_anomalia from coimtano" {
    set anomalie($codice_anomalia) 1
    
}
# Setto una sola volta l'array dei comuni possibili all'interno dell'ente
db_foreach sel_comuni "select cod_comune , denominazione as nome_comune from coimcomu" {
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

#ns_log notice "prova dob 2"

if {[string equal $err_log ""]} {

    set count_contributo 0
 
    db_foreach sel_coimcari_manu "select * from $nome_tabella" {
	set errori 0
	set i 0
	while {$i < $count_fields} {
	    
	    util_unlist $file_fields($i) col_name denominazione type dimension obbligatorio default_value range_value
	    incr i
	    
	    set colonna [set $col_name]
	    if {[string equal $colonna ""]} {
		if {[string equal $obbligatorio "S"]} {
		    if { ((![string equal $data_rottamaz_gen ""]) && 
			  ($col_name == "matricola"
			   || $col_name == "modello"
			   || $col_name == "combustibile"
			   || $col_name == "cod_manutentore"
			   || $col_name == "cod_fiscale_resp"
			   || $col_name == "pot_nom_foc_gen"
			   || $col_name == "pot_nom_utile_gen"
			   || $col_name == "pot_utile_nom_mod"
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
			 || $col_name == "pot_nom_foc_gen"
			 || $col_name == "pot_nom_utile_gen"
			 || $col_name == "pot_utile_nom_mod"
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
		    if {[db_0or1row sel_citt_check "select cod_cittadino as cod_citt from coimcitt
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
	
	#ns_return 200 text/html "luk2 |$file_name|$tipo_modello|$cod_manutentore|$file_inp|";ad_script_abort
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
		db_dml ins_anom "insert into $nome_tabella_anom values ( :id_riga , :cod_manutentore, 'toponimo/indirizzo' , :desc_errore )"
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
	
	set cod_cost_bruc_chk ""
	if {[info exist (cod_cost_bruc)]} {
	    if {![string equal $cod_cost_bruc ""]} {
		if {![info exist costruttori($cod_cost_bruc)]} {
		    set desc_errore "Marca bruciatore inesistente"
		    incr errori
		    db_dml ins_anom "insert into $nome_tabella_anom values ( :id_riga , :cod_manutentore, 'cod_cost_bruc' , :desc_errore )"
		}
	    }
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
	if { $tipo_modello == "modellof"} {  
	    if {$potenza_foc_nom < 35} {
		set desc_errore "Per i modelli F la potenza deve essere superiore o uguale a 35 kW"
		incr errori
		db_dml ins_anom "insert into $nome_tabella_anom values ( :id_riga , :cod_manutentore, 'potenza_foc_nom' , :desc_errore )"
	    } else {
		if {[db_0or1row sel_pot "select '1' from coimpote where potenza_min <= :potenza_foc_nom and potenza_max >= :potenza_foc_nom"] == 0} {
		    set desc_errore "La potenza non &egrave; compresa in nessuna fascia."
		    incr errori
		    db_dml ins_anom "insert into $nome_tabella_anom values ( :id_riga , :cod_manutentore, 'potenza_foc_nom' , :desc_errore )"
		}
	    }
	} else {
	    if {$potenza_foc_nom >= 35} {
		set desc_errore "Per i modelli G la potenza deve essere inferiore a 35 kW"
		incr errori
		db_dml ins_anom "insert into $nome_tabella_anom values ( :id_riga , :cod_manutentore, 'potenza_foc_nom' , :desc_errore )"
	    } else {
		if {[db_0or1row sel_pot "select '1' from coimpote where potenza_min <= :potenza_foc_nom and potenza_max >= :potenza_foc_nom"] == 0} {
		    set desc_errore "La potenza non &egrave; compresa in nessuna fascia."
		    incr errori
		    db_dml ins_anom "insert into $nome_tabella_anom values ( :id_riga , :cod_manutentore, 'potenza_foc_nom' , :desc_errore )"
		}
	    }
	}
	
	if {[info exist (pot_nom_utile_gen)] && [info exist (pot_utile_nom_mod)]} {
	    if {$pot_nom_utile_gen != $pot_utile_nom_mod} {
		set desc_errore "La potenza utile del generatore &egrave; diversa da quella relativa al modello ($pot_utile_nom_mod)."
		incr errori
		db_dml ins_anom "insert into $nome_tabella_anom values ( :id_riga , :cod_manutentore, 'pot_nom_utile_gen' , :desc_errore )"
	    }
	}
ns_log notice "prova dob codice fiscale prima $cod_fiscale_resp" 
	set cod_fiscale_resp [db_string query "select replace(:cod_fiscale_resp,' ','')"]
ns_log notice "prova dob codice fiscale dopo $cod_fiscale_resp" 

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

ns_log notice "prova dob codice fiscale2 $cod_fiscale_resp" 


	set lcf [string length $cod_fiscale_resp]

ns_log notice "prova dob codice fiscale3 $lcf" 

	if {$lcf ne 16 && $lcf ne 11} {
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
	
#	    ns_log notice "prova dob 4"
	if {$errori > 0} {
	    if {$errori > $num_anom_max} {
		db_dml upd_riga "update $nome_tabella set numero_anomalie = :errori , flag_stato = 'S' where id_riga = :id_riga"
	    } else {
		db_dml upd_riga "update $nome_tabella set numero_anomalie = :errori , flag_stato = 'P' where id_riga = :id_riga"
	    }
	} else {
	    set cod_impianto ""
	    set impiantotrovato "n"    
	    #superati controlli esistenza ricerco l'impianto nel catasto
	    if {![string equal $cod_impianto_est ""]} {
		#caso in cui cod impianto �� valorizzato
		
		if {[db_0or1row sel_impianto "select cod_impianto from coimaimp where cod_comune = :cod_comune_chk and cod_provincia = :cod_prov_chk and cod_impianto_est = :cod_impianto_est"]} {
		    
		    #trovato impianto per comune e provincia
		    
		    if {[db_0or1row sel_aimp_check "select cod_impianto from coimaimp where 1 = 1 $where_indirizzo and cod_impianto_est = :cod_impianto_est"]} {
			#impianto trovato per indirizzo
			db_dml upd_riga "update $nome_tabella set cod_impianto_catasto = :cod_impianto where id_riga = :id_riga"
			set impiantotrovato "s"

			if {[db_0or1row sel_impianto "select b.gen_prog as gen_prog_check, 
                                                             b.matricola as matricola_esistente,
                                                             b.cod_cost as costruttore_esistente  
                                                        from coimaimp a
	                                                   , coimgend b
	                                               where a.cod_impianto = b.cod_impianto
	                                                 and a.cod_impianto_est = :cod_impianto_est
	                                                 and b.gen_prog = :gen_prog"]} {
			    
			    if {($matricola != $matricola_esistente && "" != $matricola_esistente) || ($cod_cost_chk != $costruttore_esistente && "" != $costruttore_esistente)} {
				
				set desc_errore "Impianto trovato ma il generatore ha marca o matricola diversa"
				incr errori
				db_dml ins_anom "insert into $nome_tabella_anom values ( :id_riga , :cod_manutentore, 'marca o matricola' , :desc_errore )"
				db_dml upd_riga "update $nome_tabella set numero_anomalie = :errori , flag_stato = 'S' where id_riga = :id_riga"
			    } 						    

			    db_dml upd_riga "update $nome_tabella set gen_prog_catasto = :gen_prog_check where id_riga = :id_riga"
			} else {
			    set desc_errore "Impianto trovato ma il generatore manca o ha un progressivo divero da quello di caricamento"
			    incr errori
			    db_dml ins_anom "insert into $nome_tabella_anom values ( :id_riga , :cod_manutentore, 'marca o matricola' , :desc_errore )"
			    db_dml upd_riga "update $nome_tabella set numero_anomalie = :errori , flag_stato = 'S' where id_riga = :id_riga"
			    
			}

		    } else {
			set desc_errore "Impianto trovato ma con indirizzo diverso"
			incr errori
			db_dml ins_anom "insert into $nome_tabella_anom values ( :id_riga , :cod_manutentore, 'toponimo/indirizzo' , :desc_errore )"
			db_dml upd_riga "update $nome_tabella set numero_anomalie = :errori , flag_stato = 'P' where id_riga = :id_riga"
		    }
		    
		} else {
		    set desc_errore "Impianto non trovato per comune e provincia. Il codice impianto non &egrave; stato assegnato correttamente"
		    incr errori
		    db_dml ins_anom "insert into $nome_tabella_anom values ( :id_riga , :cod_manutentore, 'cod_impianto_est' , :desc_errore )"
		    db_dml upd_riga "update $nome_tabella set numero_anomalie = :errori , flag_stato = 'S' where id_riga = :id_riga"
		}
	    } else {
		
		if {$tipo_modello == "modellof"} {
		    set contaimpianti [db_string query "select count(*) as contaimpianti
                                                                         from coimaimp a
                                                                         where a.cod_provincia = :cod_prov_chk
                                                                          and a.cod_comune    = :cod_comune_chk
                                                                          and a.numero        = :civico
                                                                          and a.potenza       = :potenza_foc_nom
                                                                          and a.stato         = 'A'
                                                                          $where_indirizzo"]
		    
		    if {$contaimpianti <= 1} {
			
			if {[db_0or1row sel_impianto "select a.cod_impianto from coimaimp a
                                                                         where a.cod_comune    = :cod_comune_chk
                                                                          and a.numero        = :civico
                                                                          and a.potenza       = :potenza_foc_nom
                                                                          and a.stato         = 'A'
                                                                          $where_indirizzo"]} {
			    
			    
			    db_dml upd_riga "update $nome_tabella set cod_impianto_catasto = :cod_impianto where id_riga = :id_riga"
			    set impiantotrovato "s"				
			    
			    
			    if {[db_0or1row sel_generatore "select b.gen_prog as gen_prog_check from coimgend b
                                                                         where b.cod_impianto = :cod_impianto
                                                                           and b.matricola = :matricola
                                                                           and b.cod_cost  = :cod_cost_chk"]} {
				
				db_dml upd_riga "update $nome_tabella set gen_prog_catasto = :gen_prog_check where id_riga = :id_riga"
			    }
			}
		    } else {
			set desc_errore "Esistono diversi impianti con lo stesso indirizzo. Non e' possibile associare il generatore e il modello in modo certo "
			incr errori
			db_dml ins_anom "insert into $nome_tabella_anom values ( :id_riga , :cod_manutentore, 'cod_impianto_est' , :desc_errore )"
			db_dml upd_riga "update $nome_tabella set numero_anomalie = :errori , flag_stato = 'S' where id_riga = :id_riga"
		    }
		} else {
		    
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
	    if {$impiantotrovato == "s"} {
		if {[db_0or1row query "select coalesce(matricola,'?') as matricola_esistente 
                                                     from coimgend 
                                                    where cod_impianto = :cod_impianto
                                                      and gen_prog = :gen_prog" ]} {
		    if {$matricola != $matricola_esistente} {

ns_log notice "prova dob controllo matricola gen_prog = $gen_prog $matricola - $matricola_esistente"
			set desc_errore "Il generatore $gen_prog esiste con matricola diversa. Verificare. "
			incr errori
			db_dml ins_anom "insert into $nome_tabella_anom values ( :id_riga , :cod_manutentore, 'matricola' , :desc_errore )"
			db_dml upd_riga "update $nome_tabella set numero_anomalie = :errori , flag_stato = 'S' where id_riga = :id_riga"
		    }
		}
	    } else {
		if {[db_0or1row query "select * 
                                         from $nome_tabella
                                        where comune           = :comune
                                          and civico           = :civico
                                          and potenza_foc_nom  = :potenza_foc_nom
                                          and toponimo         = :toponimo
                                          and indirizzo        = :indirizzo
                                          and gen_prog         = :gen_prog
                                          and id_riga          <> :id_riga
                                          and (matricola <> :matricola
                                               or marca <> :marca) limit 1"] == 1 } {

		    set desc_errore "Nel file non possono esserci piu' generatori con lo stesso progressivo $gen_prog allo stesso indirizzo con la stessa potenza ma con matricola o costruttore diversi. Verificare. "
		    incr errori
		    db_dml ins_anom "insert into $nome_tabella_anom values ( :id_riga , :cod_manutentore, 'matricola' , :desc_errore )"
		    db_dml upd_riga "update $nome_tabella set numero_anomalie = :errori , flag_stato = 'S' where id_riga = :id_riga"
		}
	    }
	}
	
	if {$errori == 0  && [string equal $data_rottamaz_gen ""]} {
	    
	    if {![string equal $cod_impianto ""]} {
		if {[db_0or1row sel_dimp "select cod_dimp from coimdimp where cod_impianto = :cod_impianto and data_controllo = :data_controllo limit 1"]} {
		    set desc_errore "Dichiarazione gi&agrave; presente controlla la data"
		    incr errori
		    db_dml ins_anom "insert into $nome_tabella_anom values ( :id_riga , :cod_manutentore, 'data_controllo' , :desc_errore )"
		    db_dml upd_riga "update $nome_tabella set numero_anomalie = :errori , flag_stato = 'P' where id_riga = :id_riga"
		}
	    }
	    
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
	
	
	set importo_contr 0	

	if {$flag_portafoglio == "T" && $data_controllo >= "2008-08-01" } {
	    if {[db_0or1row esistenza__dimp "select 1 
                                                   from coimdimp b,
                                                        coimaimp a 
                                                  where a.cod_impianto = b.cod_impianto
                                                    and a.cod_comune    = :cod_comune_chk
                                                    and a.numero        = :civico
                                                    and a.potenza       = :potenza_foc_nom
                                                    and a.stato         = 'A' 
                                                    and b.data_controllo =:data_controllo limit 1"] == 0} {
		set presentedimp "n"
	    } else {
		set presentedimp "s"
	    }
	    
	    set data_insta_check "1900-01-01"
	    if {![string equal $data_installaz ""]} {
		set data_insta_check [db_string sel_dat "select to_char(add_months(:data_installaz, '1'), 'yyyy-mm-dd')"]
	    }					
	    
	    if {$data_controllo >= $data_insta_check && $presentedimp == "n"} {
		
		set tariffa_reg "7"
		set pot_focolare_nom_check [iter_edit_num $potenza_foc_nom 2]
		set pot_focolare_nom_check [iter_check_num $pot_focolare_nom_check 2]
		
		if {$pot_focolare_nom_check == "0.00" || $pot_focolare_nom_check == "0" || $pot_focolare_nom_check == "Error"} {
		    set desc_errore "Non &egrave; stato possibile calcolare l'importo del contributo regionale in quanto la potenza &egrave; errata ($potenza_foc_nom)" 
		    incr errori
		    db_dml ins_anom "insert into $nome_tabella_anom values ( :id_riga , :cod_manutentore, 'contributo regionale' , :desc_errore )"
		    db_dml upd_riga "update $nome_tabella set numero_anomalie = :errori , flag_stato = 'P' where id_riga = :id_riga"
		} else {

ns_log notice "prova dob $pot_focolare_nom_check"
		    db_1row query "select cod_potenza as cod_potenza_tari
                                  from coimpote
                                  where :pot_focolare_nom_check between potenza_min and potenza_max"
		    db_1row query "select a.importo as importo_contr
                                    from coimtari a
                                   where a.cod_potenza = :cod_potenza_tari
                                     and a.tipo_costo  = '7' 
                                     and a.cod_listino = '0'"
		    set oggi [db_string sel_date "select current_date"]
		    set url "balance?iter_code=$cod_manutentore"
		    set data [iter_httpget_wallet $url]
		    array set result $data
		    set risultato [string range $result(page) 0 [expr [string first " " $result(page)] - 1]]
		    set parte_2 [string range $result(page) [expr [string first " " $result(page)] + 1] end]
		    set saldo [string range $parte_2 0 [expr [string first " " $parte_2] - 1]]
		    set conto_manu [string range $parte_2 [expr [string first " " $parte_2] + 1] end]
		    if {$saldo < $importo_contr} {	
			set desc_errore "Saldo manutentore ($saldo) non sufficiente" 
			incr errori
			db_dml ins_anom "insert into $nome_tabella_anom values ( :id_riga , :cod_manutentore, 'contributo regionale' , :desc_errore )"
			db_dml upd_riga "update $nome_tabella set numero_anomalie = :errori , flag_stato = 'P' where id_riga = :id_riga"
		    } 
		}
		
	    } else {
		set tariffa_reg "8"	
		set importo_contr "0.00"
	    }
	} else {
	    set importo_contr "0.00"
	    set tariffa_reg ""
	}
	
	set count_contributo [expr $count_contributo + $importo_contr]
	
    }
    
    set count_corretti 0
    set count_scartati 0
    set count_totale 0

    set anomalie_trovate ""
    db_foreach sel_file "select * from $nome_tabella" {

	incr count_totale
	if {$numero_anomalie > 0} {
            incr count_scartati
	    append anomalie_trovate "<tr><td>progressivo riga: $id_riga</td><td> Numero anomalie: $numero_anomalie</td> <td colspan=2> &nbsp;</td></tr>"
	    db_foreach query "select * from $nome_tabella_anom where id_riga = :id_riga " {
		append anomalie_trovate "<tr><td>&nbsp;</td> <td valign=top>campo: $nome_colonna</td> <td colspan=2>anomalia: $desc_errore<br></td></tr>"
	    }
	} else {
	    incr count_corretti
	    
	}

    }
    
    db_dml del_tabella "drop table $nome_tabella"
    db_dml del_tabella_anom "drop table $nome_tabella_anom"
    db_dml del_seq "drop sequence $nome_sequence"
    
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
	<tr><td colspan=4><b>ELABORAZIONE TERMINATA (manutentore: $cod_manutentore_chk tipo allegato $tipo_modello) </b></td></tr>
	<tr><td colspan=4>Modelli letti: $count_totale</td></tr>
	<tr><td colspan=4>Modelli corretti: $count_corretti</td></tr>
	<tr><td colspan=4>Modelli da scartare: $count_scartati</td></tr>
	<tr><td colspan=4>Contributo regionale corrispondente: $count_contributo</td></tr>
	<tr><td colspan=4>&nbsp;</td><tr>
	$anomalie_trovate
        </table>
    }]
    
} else {

 
    ns_log notice "prova dob 5"
    
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
	<tr><td align=center colspan=4>
	<b>ELABORAZIONE TERMINATA (manutentore: $cod_manutentore_chk tipo allegato $tipo_modello)</b>
	</td>
	</tr>
	
	
	<table>
	<tr><td align=center colspan=4>$err_log</td>
	</tr>
	
	<tr><td>&nbsp;</td>
	
	</table>
	</center>
    }]
    
}

ns_log notice "prova dob 19"

ns_log notice "prova dob 2 file_esi = $file_esi "


puts $file_esi_id $pagina_esi
close $file_esi_id
ad_return_template "../permanenti/$file_esi_name"


