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

# leggo la tabella dei dati generali
iter_get_coimtgen

# imposto variabili usate nel programma:
if {$coimtgen(flag_ente) eq "P"} {
    set nome_dir "scarico[string tolower $coimtgen(flag_ente)][string tolower $coimtgen(sigla_prov)]"
} else {
    set nome_dir "scarico[string tolower $coimtgen(flag_ente)][string tolower $coimtgen(denom_comune)]"
}

set nome_file_1 "impianti"
set nome_file_2 "rapporti"
set nome_file_3 "autocertificazioni"

#setto la cartella di destinazione dati
cd [iter_set_spool_dir]
#creo la directory di destinazione dati
file mkdir $nome_dir
# imposto la directory degli spool ed il loro nome.
set spool_dir          [iter_set_spool_dir]
set spool_dir_url      [iter_set_spool_dir_url]


# imposto il nome dei file
set nome_file     "$nome_file_1"
set file_csv      "$spool_dir/$nome_dir/$nome_file.csv"
set file_csv_url  "$spool_dir_url/$nome_dir/$nome_file.csv"

set begin_time [clock format [clock seconds] -f "%Y-%m-%d %H:%M:%S"]
set start_time [clock format [clock seconds] -f "%Y-%m-%d %H:%M:%S"]
ns_log notice "Scarico Dati Globale $start_time "

set file_id       [open $file_csv w]
fconfigure $file_id -encoding iso8859-15 -translation lf

#impongo la classe di dati da estrarre dalla tabella coimtabs
set table_name "impianti"

set     head_cols ""
set     file_cols ""
db_foreach sel_tab_fields "" {
# imposto la prima riga del file csv
    lappend head_cols $nome_colonna_decodificata
# imposto il tracciato record del file csv
    lappend file_cols $nome_colonna
}


set sw_primo_rec "t"
set N "N"
set parziale 0
set counter 0
db_foreach sel_scar "" {
    incr counter

    incr parziale
    if {$parziale > 999} {
	ns_log notice "coimscar-file scarico impianti arrivato a $counter"
	set parziale 0
    }

    set file_col_list ""

    if {$sw_primo_rec == "t"} {
	set sw_primo_rec "f"
	iter_put_csv $file_id head_cols |
    }

    foreach column_name $file_cols {
	lappend file_col_list [set $column_name]
    }
#   lappend file_col_list $civico_manu
    iter_put_csv $file_id file_col_list	|

    #faccio un array per poi scaricare tutti i file in modo più rapido 
    set impianti_elaborati([list $cod_impianto_est $gen_prog]) [list $cod_impianto $gen_prog]


} if_no_rows {
    set msg_err      "Nessun impianto attivo presente in archivio"
    set msg_err_list [list $msg_err]
    iter_put_csv $file_id msg_err_list |
}


# imposto il nome dei file
set nome_file     "$nome_file_2"
set file_csv      "$spool_dir/$nome_dir/$nome_file.csv"
set file_csv_url  "$spool_dir_url/$nome_dir/$nome_file.csv"

set file_id       [open $file_csv w]
fconfigure $file_id -encoding iso8859-15 -translation lf

set end_time [clock format [clock seconds] -f "%Y-%m-%d %H:%M:%S"]
ns_log notice "Scarico Dati Globale $end_time "

set start_time [clock format [clock seconds] -f "%Y-%m-%d %H:%M:%S"]
ns_log notice "Scarico Dati Globale $start_time "

#impongo la classe di dati da estrarre dalla tabella coimtabs
set table_name "rapporti"

set     head_cols ""
set     file_cols ""
db_foreach sel_tab_fields "" {
# imposto la prima riga del file csv
    lappend head_cols $nome_colonna_decodificata
# imposto il tracciato record del file csv
    lappend file_cols $nome_colonna
}
    lappend head_cols "ANOMALIE RISCONTRATE"

set sw_primo_rec "t"
set N "N"
set flag_orig "RV"
set count 0
set parziale 0
foreach {idx_array valore_array} [array get impianti_elaborati] {
    util_unlist $valore_array cod_impianto gen_prog

    db_foreach sel_cimp "" {
	incr count

	incr parziale
	if {$parziale > 999} {
	    ns_log notice "coimscar-file scarico controlli arrivato a $count"
	    set parziale 0
	}

	set file_col_list ""
	
	if {$sw_primo_rec == "t"} {
	    set sw_primo_rec "f"
	    iter_put_csv $file_id head_cols |
	}
	
	#itero i generatori del sistema
	foreach column_name $file_cols {
	    
	    regsub -all \n $new1_note_manu "" new1_note_manu
	    regsub -all \n $note_verificatore "" note_verificatore
	    regsub -all \n $note_resp "" note_resp
	    regsub -all \n $note_conf "" note_conf
	    regsub -all \n $nominativo_pres "" nominativo_pres
	    
	    regsub -all \r $new1_note_manu "" new1_note_manu
	    regsub -all \r $note_verificatore "" note_verificatore
	    regsub -all \r $note_resp "" note_resp
	    regsub -all \r $note_conf "" note_conf
	    regsub -all \r $nominativo_pres "" nominativo_pres
	    
	    lappend file_col_list [set $column_name]
	}
	set tanom_list ""
	db_foreach list_anom "" {
	    lappend tanom_list "$cod_tanom,"
	}
	
	lappend file_col_list $tanom_list
	
	iter_put_csv $file_id file_col_list |
	
    }
}

#set nome_file     "$nome_file_3"
#set file_csv      "$spool_dir/$nome_dir/$nome_file.csv"
#set file_csv_url  "$spool_dir_url/$nome_dir/$nome_file.csv"
#
#set file_id       [open $file_csv w]
#fconfigure $file_id -encoding iso8859-15 -translation lf
#
#set end_time [clock format [clock seconds] -f "%Y-%m-%d %H:%M:%S"]
#ns_log notice "Scarico Dati Globale $end_time "
#
#set start_time [clock format [clock seconds] -f "%Y-%m-%d %H:%M:%S"]
#ns_log notice "Scarico Dati Globale $start_time "
#
##impongo la classe di dati da estrarre dalla tabella coimtabs
#set table_name "autocert"
#
#set     head_cols ""
#set     file_cols ""
#db_foreach sel_tab_fields "" {
## imposto la prima riga del file csv
#    lappend head_cols $nome_colonna_decodificata
## imposto il tracciato record del file csv
#    lappend file_cols $nome_colonna
#}

#lappend head_cols "ANOMALIE RISCONTRATE"
#
#set null ""
#set sw_primo_rec "t"
#set N "N"
#set flag_orig "MH"
#set ctu 0
#foreach {idx_array valore_array} [array get impianti_elaborati] {
#    util_unlist $valore_array cod_impianto gen_prog
#    db_foreach sel_auto "" {
#	incr ctu
#	set file_col_list ""
#	
#	if {$sw_primo_rec == "t"} {
#	    set sw_primo_rec "f"
#	    iter_put_csv $file_id head_cols |
#	}
#	
#
#	foreach column_name $file_cols {
#	    regsub -all \n $osservazioni "" osservazioni
#	    regsub -all \n $raccomandazioni "" raccomandazioni
#	    regsub -all \n $prescrizioni "" prescrizioni
#	    
#	    regsub -all \r $osservazioni "" osservazioni
#	    regsub -all \r $raccomandazioni "" raccomandazioni
#	    regsub -all \r $prescrizioni "" prescrizioni
#	   
#	    if {$flag_co_perc eq "t"} {
#		set co [expr $co/10000.0000]
#	    }
#
#	    lappend file_col_list [set $column_name]
#	}
#	
#	set tanom_list ""
#	db_foreach list_anom "" {
#	    lappend tanom_list "$cod_tanom,"
#	}
#	
#	lappend file_col_list $tanom_list
#	
#	iter_put_csv $file_id file_col_list |
#    }
#}

set end_time [clock format [clock seconds] -f "%Y-%m-%d %H:%M:%S"]
ns_log notice "Scarico Dati Globale $end_time "

ns_log notice "START $begin_time "


set nome_funz "scar-all"
set return_url "coimscar-all-filter?nome_funz=scar-all"

ad_returnredirect $return_url


ad_script_abort
