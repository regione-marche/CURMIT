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
    {nome_file_4       "parametri"}
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
set current_date [iter_set_sysdate]

# leggo la tabella dei dati generali
iter_get_coimtgen

# imposto la directory degli permanenti ed il loro nome.
set permanenti_dir     [iter_set_permanenti_dir]
set permanenti_dir_url [iter_set_permanenti_dir_url]

# imposto la directory degli spool ed il loro nome.
set spool_dir          [iter_set_spool_dir]
set spool_dir_url      [iter_set_spool_dir_url]

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

# controllo se l'utente � un manutentore
set cod_manu_check [iter_check_uten_manu $id_utente]

# imposto il nome dei file
set nome_file     "$nome_file_4"
#set nome_file     [iter_temp_file_name -permanenti $nome_file]
set file_csv      "$spool_dir/$nome_dir/$nome_file.csv"
set file_csv_url  "$spool_dir_url/$nome_dir/$nome_file.csv"

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
if {[string equal $cod_manu_check ""]} {
    db_dml ins_enve ""
    db_dml ins_opve ""
}
db_dml ins_tano ""

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
	iter_get_coimtgen
	set tipo_ente   $coimtgen(flag_ente)
	if {$tipo_ente == "P"} {
	    db_1row sel_ente "select substr(lpad(b.cod_istat,6,'0'),1,3) as cod_prov
                                from coimtgen a, coimcomu b where a.cod_prov = b.cod_provincia
                                                              and b.cod_istat is not null limit 1"
	    set cod_comu "000"
	}
	if {$tipo_ente == "C"} {
	    db_1row sel_ente "select substr(lpad(b.cod_istat,6,'0'),1,3) as cod_prov
                                   , substr(lpad(b.cod_istat,6,'0'),4,3) as cod_comu
                                from coimtgen a, coimcomu b where a.cod_comu = b.cod_comune"
	}

	lappend file_col_list $tipo_ente
	lappend file_col_list $cod_comu
	lappend file_col_list $cod_prov
	iter_put_csv $file_id file_col_list |
	set file_col_list ""
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

# visualizzo il file creato
#ns_returnfile 200 text/plain $file_csv
#ns_returnfile 200 application/csv $file_path
# questa e' la migliore se sul proprio pc si sceglie di aprire i file csv
# sempre con blocco note e non con xls
# tra l'altro e' possibile fare direttamente sul link 'salva oggetto con nome'

#ad_returnredirect $file_csv_url

set nome_funz "scar-all"
set step 4
set link_list [export_url_vars caller funzione nome_funz nome_funz_caller f_cod_tecn f_cod_enve]
set return_url $file_csv_url
#set return_url "coimscar-all-filter?step=$step&$link_list"
ad_returnredirect $return_url

ad_script_abort
