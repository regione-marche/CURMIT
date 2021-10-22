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
    {f_cod_tecn       ""}
    {f_cod_enve        ""}
    
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

db_1row sel_opve "" 

# imposto variabili usate nel programma:
set nome_dir $cognome
set nome_file_1 "impianti"
set nome_file_2 "rapporti"
set nome_file_3 "autocertificazioni"
set nome_file_4 "incontri"
set nome_file_5 "parametri"
set link "dir=$nome_dir&nome_file_1=$nome_file_1&nome_file_2=$nome_file_2&nome_file_3=$nome_file_3&nome_file_4=$nome_file_4&nome_file_5=$nome_file_5"



# imposto la directory degli spool ed il loro nome.
set spool_dir          [iter_set_spool_dir]
set spool_dir_url      [iter_set_spool_dir_url]

#setto la cartella di destinazione dati
cd [iter_set_spool_dir]
#creo la directory di destinazione dati
file mkdir $nome_dir

# leggo la tabella dei dati generali
iter_get_coimtgen

# imposto il nome dei file
set nome_file     "$nome_file_1"
set file_csv      "$spool_dir/$nome_dir/$nome_file.csv"
set file_csv_url  "$spool_dir_url/$nome_dir/$nome_file.csv"


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

set counter 0
db_foreach sel_scar "" {
    incr counter
    set file_col_list ""

    if {$sw_primo_rec == "t"} {
	set sw_primo_rec "f"
	iter_put_csv $file_id head_cols |
    }

    foreach column_name $file_cols {
	lappend file_col_list [set $column_name]
    }
#    lappend file_col_list $civico_manu
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
foreach {idx_array valore_array} [array get impianti_elaborati] {
    util_unlist $valore_array cod_impianto gen_prog

    db_foreach sel_cimp "" {
	incr count
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

set nome_file     "$nome_file_3"
set file_csv      "$spool_dir/$nome_dir/$nome_file.csv"
set file_csv_url  "$spool_dir_url/$nome_dir/$nome_file.csv"

set file_id       [open $file_csv w]
fconfigure $file_id -encoding iso8859-15 -translation lf

#impongo la classe di dati da estrarre dalla tabella coimtabs
set table_name "autocert"

set     head_cols ""
set     file_cols ""
db_foreach sel_tab_fields "" {
# imposto la prima riga del file csv
    lappend head_cols $nome_colonna_decodificata
# imposto il tracciato record del file csv
    lappend file_cols $nome_colonna
}

lappend head_cols "ANOMALIE RISCONTRATE"

set null ""
set sw_primo_rec "t"
set N "N"
set flag_orig "MH"
set ctu 0
foreach {idx_array valore_array} [array get impianti_elaborati] {
    util_unlist $valore_array cod_impianto gen_prog
    db_foreach sel_auto "" {
	incr ctu
	set file_col_list ""
	
	if {$sw_primo_rec == "t"} {
	    set sw_primo_rec "f"
	    iter_put_csv $file_id head_cols |
	}
	

	foreach column_name $file_cols {
	    regsub -all \n $osservazioni "" osservazioni
	    regsub -all \n $raccomandazioni "" raccomandazioni
	    regsub -all \n $prescrizioni "" prescrizioni
	    
	    regsub -all \r $osservazioni "" osservazioni
	    regsub -all \r $raccomandazioni "" raccomandazioni
	    regsub -all \r $prescrizioni "" prescrizioni
	   
	    if {$flag_co_perc eq "t"} {
		set co [expr $co/10000.0000]
	    }

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


set nome_file     "$nome_file_4"
set file_csv      "$spool_dir/$nome_dir/$nome_file.csv"
set file_csv_url  "$spool_dir_url/$nome_dir/$nome_file.csv"

set file_id       [open $file_csv w]
fconfigure $file_id -encoding iso8859-15 -translation lf


#impongo la classe di dati da estrarre dalla tabella coimtabs
set table_name "incontri"

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

set counter 0
db_foreach sel_inco "" {
    incr counter
    set file_col_list ""

    if {$sw_primo_rec == "t"} {
	set sw_primo_rec "f"
	iter_put_csv $file_id head_cols |
    }

    foreach column_name $file_cols {
	regsub -all \n $note "" note
	regsub -all \r $note "" note
	lappend file_col_list [set $column_name]
    }
#    lappend file_col_list $civico_manu
    iter_put_csv $file_id file_col_list	|

    #faccio un array per poi scaricare tutti i file in modo più rapido 
    set impianti_elaborati([list $cod_impianto_est $gen_prog]) [list $cod_impianto $gen_prog]


} if_no_rows {
    set msg_err      "Nessun impianto attivo presente in archivio"
    set msg_err_list [list $msg_err]
    iter_put_csv $file_id msg_err_list |
}


set nome_file     "$nome_file_5"
set file_csv      "$spool_dir/$nome_dir/$nome_file.csv"
set file_csv_url  "$spool_dir_url/$nome_dir/$nome_file.csv"

if {![string equal $f_cod_enve ""]} {
    set where_enve "where cod_enve = :f_cod_enve"
} else {
    set where_enve ""
}

if {![string equal $f_cod_tecn ""]} {
    db_1row sel_opve ""
    set where_opve "where cod_opve = :f_cod_tecn"
} else {
    set where_opve ""
    set cognome ""
    set nome ""
}

set file_id       [open $file_csv w]
fconfigure $file_id -encoding iso8859-15

# cancello e ricreo la tabella dei parametri
db_dml del_parm ""
db_dml ins_comb ""
db_dml ins_tppr ""
db_dml ins_pote ""
db_dml ins_tpim ""
db_dml ins_cted ""
db_dml ins_cost ""
db_dml ins_tpem ""
db_dml ins_utgi ""
db_dml ins_fuge ""
db_dml ins_enve ""
db_dml ins_opve ""
db_dml ins_tano ""
db_dml ins_cinc ""
db_dml ins_tpes ""
db_dml ins_inst ""

# imposto la prima riga del file csv
set     head_cols ""
lappend head_cols "NOME CAMPO"
lappend head_cols "CHIAVE"
lappend head_cols "DESCRIZIONE"
lappend head_cols "TABELLA RIFERIMENTO"

# imposto il tracciato record del file csv
set     file_cols ""
lappend file_cols "gruppo"
lappend file_cols "chiave"
lappend file_cols "descrizione"
lappend file_cols "tab_prov"

set null ""
set sw_primo_rec "t"
set N "N"

db_foreach sel_parm "" {
    set file_col_list ""

    if {$sw_primo_rec == "t"} {
	set sw_primo_rec "f"
	iter_put_csv $file_id head_cols |
    }

    foreach column_name $file_cols {

	lappend file_col_list [set $column_name]
    }
    iter_put_csv $file_id file_col_list |

} if_no_rows {
    set msg_err      "Nessun impianto attivo presente in archivio"
    set msg_err_list [list $msg_err]
    iter_put_csv $file_id msg_err_list |
}




#creo il tar dei dati scaricato per poter agevolare il downloads da parte dell'utente
exec tar czf $nome_dir.tar.gz $nome_dir
#scateno il downloads automatico del file creato
#ad_returnredirect "$spool_dir_url/$nome_dir"
ad_returnredirect "coimscar-aimp-filter?nome_funz=scar-aimp&return=1&$link"

ad_script_abort
