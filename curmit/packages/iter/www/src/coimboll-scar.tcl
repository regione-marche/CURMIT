#www/caldaie/src/
ad_page_contract {
    lista per scarico bollini

    @author         Katia Coazzoli
    @creation-date  14/06/2004

    @cvs-id coimboll-scar.tcl

    USER  DATA       MODIFICHE
    ===== ========== =======================================================================
    san01 12/08/2016 Aggiunto campo note.

} {
    {f_cod_manu        ""}
    {f_data_ril_da     ""}
    {f_data_ril_a      ""}
    {nome_funz         ""}
}

# Imposto variabili tipiche di ogni funzione
set lvl 1
set id_utente [lindex [iter_check_login $lvl $nome_funz] 1]


# imposto filtro per data consegna
if {![string equal $f_data_ril_da ""]
||  ![string equal $f_data_ril_a ""]
} {
    if {[string equal $f_data_ril_da ""]} {
	set f_data_ril_da "18000101"
    }
    if {[string equal $f_data_ril_a ""]} {
	set f_data_ril_a "21001231"
    }
    set where_range "and a.data_consegna between :f_data_ril_da and :f_data_ril_a"
} else {
    set where_range ""
}

if {![string equal $f_cod_manu ""]} {
    set where_manu "and a.cod_manutentore = :f_cod_manu"
} else {
    set where_manu ""
}

set current_datetime [clock format [clock seconds] -f "%Y-%m-%d %H:%M:%S"]
set nome_file        "Estrazione bollini"
set nome_file         [iter_temp_file_name -permanenti $nome_file]
set permanenti_dir     [iter_set_permanenti_dir]
set permanenti_dir_url [iter_set_permanenti_dir_url]
set file_csv         "$permanenti_dir/$nome_file.csv"
set file_csv_url     "$permanenti_dir_url/$nome_file.csv"

set file_id [open $file_csv w]
fconfigure $file_id -encoding iso8859-1

# imposto la prima riga del file csv
set     head_cols ""
lappend head_cols "Codice"
lappend head_cols "Manutentore"
lappend head_cols "Data consegna"
lappend head_cols "Nr. Bollini"
lappend head_cols "Nr. Resi"
lappend head_cols "Matricola da"
lappend head_cols "Matricola A"
lappend head_cols "Costu unitario"
lappend head_cols "Pagati"
lappend head_cols "Importo dovuto"
lappend head_cols "Importo pagato"
lappend head_cols "Utente"
lappend head_cols "Cod man."
lappend head_cols "Cod_uten."
lappend head_cols "Note";#san01

# imposto il tracciato record del file csv
set     file_cols ""
lappend file_cols "cod_bollini"
lappend file_cols "manutentore"
lappend file_cols "data_consegna_edit"
lappend file_cols "nr_bollini_edit"
lappend file_cols "nr_bollini_resi_edit"
lappend file_cols "matricola_da"
lappend file_cols "matricola_a"
lappend file_cols "costo_unitario"
lappend file_cols "pagati"
lappend file_cols "importo"
lappend file_cols "imp_pagato"
lappend file_cols "utente"
lappend file_cols "cod_manutentore"
lappend file_cols "id_utente"
lappend file_cols "note";#san01


set sw_primo_rec "t"
db_foreach sel_boll "" {
    set file_col_list ""

    if {$sw_primo_rec == "t"} {
	set sw_primo_rec "f"
	iter_put_csv $file_id head_cols
    }

    set note [regsub -all \r $note " "];#san01
    set note [regsub -all \n $note " "];#san01

    foreach column_name $file_cols {
	lappend file_col_list [set $column_name]
    }
    iter_put_csv $file_id file_col_list
    
} if_no_rows {
    set msg_err      "Nessuna incontro selezionato con i criteri utilizzati"
    set msg_err_list [list $msg_err]
    iter_put_csv $file_id msg_err_list
}

ad_returnredirect $file_csv_url
ad_script_abort

