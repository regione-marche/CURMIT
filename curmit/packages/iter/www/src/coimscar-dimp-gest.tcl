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

    {f_cod_enve        ""}
    {f_cod_tecn        ""}
    {nome_file_3       ""}
    {nome_dir          ""}

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

# imposto variabili usate nel programma:
#set current_date [iter_set_sysdate]
#set data_cor [string range $current_date 0 3]
#set data_pre [expr $data_cor - 1]
#append data_pre "0101"
#append data_cor "1231"

# leggo la tabella dei dati generali
iter_get_coimtgen

# imposto la directory degli permanenti ed il loro nome.
set permanenti_dir     [iter_set_permanenti_dir]
set permanenti_dir_url [iter_set_permanenti_dir_url]

# imposto la directory degli spool ed il loro nome.
set spool_dir          [iter_set_spool_dir]
set spool_dir_url      [iter_set_spool_dir_url]

db_1row sel_opve ""
# imposto il nome dei file
set nome_file     "$nome_file_3"
#set nome_file     [iter_temp_file_name -permanenti $nome_file]
set file_csv      "$spool_dir/$nome_dir/$nome_file.csv"
set file_csv_url  "$spool_dir_url/$nome_dir/$nome_file.csv"

set file_id       [open $file_csv w]
fconfigure $file_id -encoding iso8859-15

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

db_foreach sel_auto "" {
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
	
	lappend file_col_list [set $column_name]
    }

    set tanom_list ""
    db_foreach list_anom "" {
	lappend tanom_list "$cod_tanom,"
    }

    lappend file_col_list $tanom_list

    iter_put_csv $file_id file_col_list |

} if_no_rows {
    set msg_err      "Nessun impianto attivo presente in archivio"
    set msg_err_list [list $msg_err]
    iter_put_csv $file_id msg_err_list |
}

# visualizzo il file creato
#ns_returnfile 200 text/plain $file_csv
#ns_returnfile 200 application/csv $file_path
# questa e' la migliore se sul proprio pc si sceglie di aprire i file csv
# sempre con blocco note e non con xls
# tra l'altro e' possibile fare direttamente sul link 'salva oggetto con nome'

#ad_returnredirect $file_csv_url

set nome_funz "scar-all"
set step 3
set link_list [export_url_vars caller funzione nome_funz nome_funz_caller f_cod_tecn f_cod_enve]
set return_url "coimscar-all-filter?step=$step&$link_list"
ad_returnredirect $return_url

ad_script_abort

