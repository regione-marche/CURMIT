ad_page_contract {
    Add/Edit/Delete  statistiche per la tabella "coimscar"

    @author          Nicola Pelagatti
    @creation-date   29/08/2006

    @param funzione  V=view
    @param caller    caller della lista da restituire alla lista:
                     serve se lista e' uno zoom che permetti aggiungi.
    @param nome_funz identifica l'entrata di menu, server per le autorizzazioni
                     serve se lista e' uno zoom che permetti aggiungi.
    @param nome_funz_caller identifica l'entrata di menu, serve per la 
                     navigazione con navigation bar
    @cvs-id          coimscar-aimp
} {
    {funzione        "I"}
    {caller      "index"}
    {nome_funz        ""}
    {nome_funz_caller ""}
    
} -properties {
    page_title:onevalue
    context_bar:onevalue
    form_name:onevalue
}

switch $funzione {
    "V" {set lvl 1}
    "I" {set lvl 2}
}

set id_utente [lindex [iter_check_login $lvl $nome_funz] 1]
set link_gest [export_url_vars nome_funz nome_funz_caller caller]

# controllo il parametro di "propagazione" per la navigation bar
if {[string is space $nome_funz_caller]} {
    set nome_funz_caller $nome_funz
}

iter_get_coimtgen

# imposto variabili usate nel programma:
set nome_dir "estrazione_dati_coimimpr"
if {$coimtgen(flag_ente) eq "P"} {
    set nome_file_1 "estrazione_dati_$coimtgen(flag_ente)$coimtgen(sigla_prov)"
} else {
    set nome_file_1 "estrazione_dati_$coimtgen(flag_ente)$coimtgen(denom_comune)"
}

#setto la cartella di destinazione dati
cd [iter_set_spool_dir]
#creo la directory di lavoro
file mkdir $nome_dir
# imposto la directory degli spool ed il loro nome.
set spool_dir          [iter_set_spool_dir]
set spool_dir_url      [iter_set_spool_dir_url]

# leggo la tabella dei dati generali
iter_get_coimtgen

# imposto il nome dei file
set nome_file     "$nome_file_1"
set file_csv      "$spool_dir/$nome_dir/$nome_file.csv"
set file_csv_url  "$spool_dir_url/$nome_dir/$nome_file.csv"

set file_id       [open $file_csv w]
fconfigure $file_id -encoding iso8859-15 -translation lf

#impongo la classe di dati da estrarre dalla tabella coimtabs
set table_name "impraimp"
set file_cols ""
db_foreach sel_tab_fields "" {
# imposto la prima riga del file csv
#    lappend head_cols $nome_colonna_decodificata
# imposto il tracciato record del file csv
    lappend file_cols $nome_colonna
}
set table_name "imprdimp"
set file_cols_2 ""
db_foreach sel_tab_fields "" {
    # imposto la prima riga del file csv
#    lappend head_cols $nome_colonna_decodificata
# imposto il tracciato record del file csv
    lappend file_cols_2 $nome_colonna
}
#lappend head_cols "FLAG AUTOCERTIFICAZIONE ANOMALIE"
set table_name "imprcimp"
set file_cols_3 ""
db_foreach sel_tab_fields "" {
    # imposto la prima riga del file csv
#    lappend head_cols $nome_colonna_decodificata
    # imposto il tracciato record del file csv
    lappend file_cols_3 $nome_colonna
}
#lappend head_cols "FLAG VERIFICA ANOMALIE"
# Il campo data_rif_impr serve ad identificare il livello di aggiornamento dei dati scaricati
#lappend head_cols "DATA RIFERIMENTO IMPR"

set sw_primo_rec "t"
set N "N"
set counter 0
db_foreach sel_scar "" {
    incr counter
    set file_col_list ""
    
    # Come primo campo scrivo il codice ente di iter riferito all'ente che sta eseguendo lo scarico.
    if {$coimtgen(flag_ente) eq "P"} {
	set cod_ente $coimtgen(cod_provincia)
    } else {
	set cod_ente $coimtgen(cod_comu)
    }
    
    #Scrittura nella lista dei valori ottenuti dalla tabella coimaimp    
    foreach column_name $file_cols {
	lappend file_col_list [set $column_name]
    }
    # Analisi e successiva scrittura nella lista dei valori estratti dalla tabella coimdimp
    set tot_autocert 0
    db_foreach sel_dimp "" {
	incr tot_autocert
	if {![info exists dimp(osservazioni)]} {
	    set dimp(osservazioni) $osservazioni
	}
	
	if {![info exists dimp(raccomandazioni)]} {
	    set dimp(raccomandazioni) $raccomandazioni
	}
	
	if {![info exists dimp(prescrizioni)]} {
	    set dimp(prescrizioni) $prescrizioni
	}
	set flag_orig "MH"
	db_1row sel_anom_dimp "" 
    }
    if {$dimp(osservazioni) eq ""} {
	set osservazioni "N"
    } else {
	set osservazioni "S"
    }
    if {$dimp(raccomandazioni) eq ""} {
	set raccomandazioni "N"
    } else {
	set raccomandazioni "S"
    }
    if {$dimp(prescrizioni) eq ""} {
	set prescrizioni "N"
    } else {
	set prescrizioni "S"
    }
    
    foreach column_name_2 $file_cols_2 {
	lappend file_col_list [set $column_name_2]
    }
    
    if {$f_anomalie_autocert eq "0"} {
	set f_anomalie_autocert "N"
    } else {
	set f_anomalie_autocert "S"
    }
    lappend file_col_list $f_anomalie_autocert
    
    #Analisi e successiva scrittura dei valori estratti dalla coimcimp
    set tot_rapporti 0
    set f_anomalie_rapporto ""
    set cimp(note_conf) ""
    db_foreach sel_cimp "" {
	incr tot_rapporti
	if {![info exists cimp(note_conf)]} {
	    set cimp(note_conf) $note_conf
	}
	if {![info exists data_primo_rapporto]} {
	    set data_primo_rapporto $data_controllo
	} else {
	    if {$data_controllo < $data_primo_rapporto} {
		set data_primo_rapporto $data_controllo
	    }
	}
	
	if {![info exists data_ultim_rapporto]} {
	    set data_ultim_rapporto $data_controllo
	} else {
	    if {$data_controllo > $data_ultim_rapporto} {
		set data_ultim_rapporto $data_controllo
	    }
	}
	
	set flag_orig "RV"
	db_1row sel_anom_cimp ""
    }
    # Assegno un valore flag (N o S) a note_conf
    if {$cimp(note_conf) eq ""} {
	set note_conf "N"
    } else {
	set note_conf "S"
    }
    
    foreach column_name_3 $file_cols_3 {
	lappend file_col_list [set $column_name_3]
    }
    
    if {$f_anomalie_rapporto eq "0"} {
	set f_anomalie_rapporto "N"
    } else {
	set f_anomalie_rapporto "S"
    }
    
    lappend file_col_list $f_anomalie_rapporto
    
    #assegno a $data_rif_impr la data presente nel momento in cui viene effettuato lo scarico
    set data_rif_impr [clock format [clock seconds] -format "%Y-%m-%d"]
    lappend file_col_list $data_rif_impr

    iter_put_csv $file_id file_col_list	|
} if_no_rows {
    set msg_err      "Nessun impianto attivo presente in archivio"
    set msg_err_list [list $msg_err]
    iter_put_csv $file_id msg_err_list |
}

close $file_id

#
#collegamento alla copy
#
# creo il file in cui saranno salvate le istruzioni sql per le copy
set nome_dir_sql "estrazione_dati_coimimpr_sql"
#creo la directory di lavoro
file mkdir $nome_dir_sql
if {$coimtgen(flag_ente) eq "P"} {
    set nome_file_sql "estrazione_dati_$coimtgen(flag_ente)$coimtgen(sigla_prov)"
} else {
    set nome_file_sql "estrazione_dati_$coimtgen(flag_ente)$coimtgen(denom_comune)"
}
# imposto il nome dei file
set file_sql      "$spool_dir/$nome_dir_sql/$nome_file_sql.sql"
set file_sql_url  "$spool_dir_url/$nome_dir_sql/$nome_file_sql.sql"

set file_sql_id       [open $file_sql w]
fconfigure $file_sql_id -encoding iso8859-15 -translation lf

puts $file_sql_id "delete from coimimpr;"
puts $file_sql_id "\\encoding iso-8859-15"
puts $file_sql_id "\\copy coimimpr (cod_ente, cod_impianto, cod_impianto_est, potenza, potenza_utile, cod_potenza, tipo_impianto, n_generatori, flag_dpr412, cod_combustibile, stato, cod_via, localita, toponimo, indirizzo, numero, esponente, scala, piano, interno, cod_qua, cod_urb, cod_comune, cod_provincia, cap, gb_x, gb_y, flag_gb, flag_dichiarato, anno_costruzione, data_installaz, data_attivaz, data_rottamaz, stato_conformita, cod_cted, cod_tpdu, marc_effic_energ, volimetria_risc, consumo_annuo, funz_consumo_um, data_ins, data_mod, utente, tot_autocert, data_prima_autocert, data_ultim_autocert, data_scad_autocert, f_osservazioni_autocert, f_raccomandazioni_autocert, f_prescrizioni_autocert, f_anomalie_autocert, tot_rapporti, data_primo_rapporto, data_ultim_rapporto, f_osservazioni_rapporto, esito_verifica, f_anomalie_rapporto, data_rif_impr) from $spool_dir/$nome_dir/$nome_file_1.csv using delimiters '|' with null as ''"

close $file_sql_id

# Ricavo il nome del database per l'ente che segue lo scaricamento
set codice_ente ""
if {$coimtgen(flag_ente) eq "P"} {
    set codice_ente $coimtgen(cod_provincia)
} else {
    set codice_ente = cod_comu
}

db_1row sel_database_ente ""

set error_msg ""
with_catch error_msg {
    ns_log notice "Inizio procedura COIMIMPR"
    exec psql $database_ente -f $nome_dir_sql/$nome_file_sql.sql > /dev/null
} {}
if {$error_msg ne ""} {
    ns_log notice "IMPR  Terminata con errore: $error_msg"
} else {
    ns_log notice "IMPR  Terminata correttamente"
}


ns_return 200 text/html "Stop"; return


set nome_funz "scar-all"
set step 5
set link_list [export_url_vars caller funzione nome_funz nome_funz_caller f_cod_tecn f_cod_enve]
set return_url "coimscar-all-filter?step=$step&$link_list"

ad_returnredirect $return_url


ad_script_abort
