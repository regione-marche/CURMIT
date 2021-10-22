ad_page_contract {
    @author          Paolo Formizzi Adhoc
    @creation-date   27/01/2004

    @param funzione  I=insert M=edit D=delete V=view
    @param caller    caller della lista da restituire alla lista:
                     serve se lista e' uno zoom che permetti aggiungi.
    @param nome_funz identifica l'entrata di menu, server per le autorizzazioni
                     serve se lista e' uno zoom che permetti aggiungi.
    @cvs-id          coimcar4-gest.tcl
} {
    
   {funzione    "V"}
   {caller  "index"}
   {nome_funz    ""}
   {cod_acts     ""}
   {nome_file_n  ""}
   {nome_funz_caller ""}
} -properties {
    page_title:onevalue
    context_bar:onevalue
    form_name:onevalue
}


# Controlla lo user
set lvl 1
set id_utente [lindex [iter_check_login $lvl $nome_funz] 1]

# controllo il parametro di "propagazione" per la navigation bar
if {[string is space $nome_funz_caller]} {
    set nome_funz_caller $nome_funz
}


# Personalizzo la pagina
set titolo       "Risultato Caricamento Dati"
set page_title   "Risultato Caricamento Dati"


set context_bar  [iter_context_bar -nome_funz $nome_funz_caller]

db_1row sel_date ""

set leggifile [open $nome_file_n r]
fconfigure $leggifile -encoding iso8859-1 -translation auto

set flag_leggi "S"
set ctr_caricati  0
set ctr_scartati  0
set ctr_esistente 0
set ctr_nuovo     0
set ctr_totale    0

gets $leggifile record_file
if {[eof $leggifile]} {
    set flag_leggi "N"
}

if {![string equal $cod_acts ""]} {
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
} else {
    set nome_dist ""
}

if {![string equal $data_caric ""]} {
    set save_data_caric [iter_edit_date $data_caric]
    if {$save_data_caric != 0} {
	set data_caric $save_data_caric
    } else {
	set data_caric [iter_edit_date $data_caric]
    }
}

set ctr_invariati 0

with_catch error_msg {
    while {$flag_leggi == "S"} {
	set ctr_transaction        0
	db_transaction {
	    while {$flag_leggi     == "S"
	       &&  $ctr_transaction < 1000
	       } {
		incr ctr_transaction
		
		set carica "S"
    
		set record                 [split $record_file ";"]
		set cod_aces_est           [lindex $record 0]
		set natura_giuridica       [lindex $record 1]
		set cognome                [lindex $record 2]
		set nome                   [lindex $record 3]
		set cod_fiscale_piva       [lindex $record 4]
		set telefono               [lindex $record 5]
		set data_nas               [lindex $record 6]
		set comune_nas             [lindex $record 7]
		set indirizzo              [lindex $record 8]
		set numero                 [lindex $record 9]
		set esponente              [lindex $record 10]
		set scala                  [lindex $record 11]
		set piano                  [lindex $record 12]
		set interno                [lindex $record 13]
		set cap                    [lindex $record 14]
		set localita               [lindex $record 15]
		set comune                 [lindex $record 16]
		set provincia              [lindex $record 17]
		set cod_combustibile       [lindex $record 18]
		set consumo_annuo          [lindex $record 19]
		set tariffa                [lindex $record 20]

		set consumo_annuo [iter_check_num $consumo_annuo 2]
		if {$consumo_annuo == "Error"} {
		    set consumo_annuo ""
		}
	     
		# Controlli
		if {[string equal $cognome ""]
                    || [string is space $cognome]
		    || [string equal $indirizzo ""]
                    || [string is space $indirizzo]
		    || [string equal $numero ""]
                    || [string is space $numero]} {
		    set carica "N"
		}
	     
		switch $natura_giuridica {
		    "f" {
			if {[string equal $nome ""]} {
			    set carica "N"
			}
		    }
		    "g" {
		    }
		    "F" {
			if {[string equal $nome ""]} {
			    set carica "N"
			}
		    }
		    "G" {
		    }
		    default {
			set carica "N"
		    }
		}
		
		incr ctr_totale
		if {$carica == "S"} {
		    set ctr_caricati [expr $ctr_caricati + 1]
		    if {[db_0or1row sel_aces ""]} {
			
			if {$conta > 0} {
			    set ctr_esistente [expr $ctr_esistente + 1]
			    set stato_01  "E"
			} else {
			    set ctr_nuovo [expr $ctr_nuovo + 1]
			    set stato_01 "D"
			    
			    ### Controllo tutti i record della coimaces con stato D (da analizzare) e li confronto con quelli sulla coimaimp per rilevare gli impianti invariati. Per questi modifico lo stato sulla aces da D a I (invariato sulla coimaimp)
			    
			    if {![string equal $cod_distr ""]} {
				set where_dist "and cod_distributore = :cod_distr"
			    } else {
				set where_dist "and cod_distributore is null"
			    }
			    set conta_aimp 0
			    #ricerco stesso codice utenza

			    db_1row  sel_count_aimp1 ""

			    if {$conta_aimp > 0} { 

				if {![string equal $esponente ""]} {
                                    set where_espo "and a.esponente = upper(:esponente)"
				} else {
				    set where_espo "and a.esponente is null"
				}
				if {![string equal $scala ""]} {
                                    set where_scala "and a.scala = upper(:scala)"
				} else {
				    set where_scala "and a.scala is null"
				}
				if {![string equal $piano ""]} {
                                    set where_piano "and a.piano = upper(:piano)"
				} else {
				    set where_piano "and a.piano is null"
				}
				if {![string equal $interno ""]} {
                                    set where_inte "and a.interno = upper(:interno)"
				} else {
				    set where_inte "and a.interno is null"
				}
				if {![string equal $localita ""]} {
                                    set where_loc "and a.localita = upper(:localita)"
				} else {
				    set where_loc "and a.localita is null"
				}
				if {![string equal $consumo_annuo ""]} {

                                    set where_cons "and a.consumo_annuo = :consumo_annuo"

				} else {
				   set where_cons "and a.consumo_annuo is null"
				}

				if {![string equal $tariffa ""]} {
                                    set where_tari "and a.tariffa = :tariffa"
				} else {
				    set where_tari "and a.tariffa is null"
				}
				if {![string equal $comune ""]} {
                                    set where_comu "and b.denominazione = upper(:comune)"
				} else {
				   set where_comu "and b.denominazione is null"
				}
				if {![string equal $cap ""]} {
                                    set where_cap "and b.cap = :cap"
				} else {
				    set where_cap "and b.cap is null"
				}
				if {![string equal $provincia ""]} {
                                    set where_prov "and c.sigla = upper(:provincia)"
				} else {
				   set where_prov "and c.sigla is null"
				}
				set conta_aimp 0

				#ricerco stessa ubicazione
				db_1row  sel_count_aimp2 ""

				if {$conta_aimp > 0} {
				    
				    if {![string equal $nome ""]} {
					set where_nome "and a.nome = upper(:nome)"
				    } else {
					set where_nome "and a.nome is null"
				    }
				    if {![string equal $cod_fiscale_piva ""]} {
					set where_piva "and a.cod_fiscale = upper(:cod_fiscale_piva)"
				    } else {
					set where_piva "and a.cod_fiscale is null"
				    }
				    set conta_aimp 0

				    #ricerco stesso soggetto
				    db_1row  sel_count_aimp3 ""

				    if {$conta_aimp > 0} {
					# cambio lo stato al record della aces
					set stato_01 "I"
                                        incr ctr_invariati
				    }
				}
			    }
			}
		    }

		    db_1row sel_aces_2  ""
		    set stato_02      ""
		    set cod_cittadino ""
		    set cod_impianto  ""
		    set data_ins      $data_corrente
		    set utente        $id_utente
		    
		    set dml_ins_aces [db_map ins_aces]
		    
		    # Lancio la query di manipolazione dati contenute in dml_sql
		    if {[info exists dml_ins_aces]} {
			db_dml dml_coimaces $dml_ins_aces
			
		    }
		} else {
		    set ctr_scartati [expr $ctr_scartati + 1]
		}
		
		gets $leggifile record_file
		if {[eof $leggifile]} {
		    set flag_leggi "N"
		}
	    }
	
	    #la statistica "invariati" é: tot invariati su aimp + tot esistenti su aces
	    set ctr_invariati     [expr $ctr_invariati +  $ctr_esistente ]
	    set ctr_da_analizzare [expr $ctr_caricati  -  $ctr_invariati ]

	    set da_analizzare $ctr_da_analizzare
	    set invariati     $ctr_invariati
	    set caricati      $ctr_caricati
	    set scartati      $ctr_scartati
            if {$flag_leggi == "N"} {
	       if {$da_analizzare == 0} {
		   set stato_acts "C"
	       } else {
		   set stato_acts "E"
	       }
	    } else {
               set stato_acts "I"
	    }

	    set dml_upd_acts [db_map upd_acts]
	    db_dml dml_coimaces $dml_upd_acts
	}
    }
} {
    iter_return_complaint "Spiacente, ma il DBMS ha restituito il
                seguente messaggio di errore <br><b>$error_msg</b><br>
                Contattare amministratore di sistema e comunicare il messaggio
                d'errore. Grazie."
}

set ctr_caricati_edit  [iter_edit_num $ctr_caricati]
set ctr_scartati_edit  [iter_edit_num $ctr_scartati]
set ctr_esistente_edit [iter_edit_num $ctr_esistente]
set ctr_nuovo_edit     [iter_edit_num $ctr_nuovo]
set ctr_totale_edit    [iter_edit_num $ctr_totale]


ad_return_template
