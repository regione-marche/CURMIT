#www/caldaie/src/
ad_page_contract {
    lista per scarico impianti censiti

    @author         Katia Coazzoli
    @creation-date  14/06/2004

    @cvs-id coimscar-viae.tcl

} {
   {funzione         "V"}
   {caller       "index"}
   {nome_funz         ""}
   {nome_funz_caller  ""}
   {f_comune          ""}
}

# Imposto variabili tipiche di ogni funzione
set lvl 1

set current_datetime [clock format [clock seconds] -f "%Y-%m-%d %H:%M:%S"]
set nome_file        "scarico viario ${current_datetime}"
set spool_dir        [iter_set_spool_dir]
set spool_dir_url    [iter_set_spool_dir_url]
set file_csv         "$spool_dir/$nome_file.csv"
set file_csv_url     "$spool_dir_url/$nome_file.csv"

set file_id [open $file_csv w]
fconfigure $file_id -encoding iso8859-1

# imposto la prima riga del file csv
set     head_cols ""
lappend head_cols "Codice via"
lappend head_cols "Codice comune"
lappend head_cols "Descrizione"
lappend head_cols "Descr. toponimo"
lappend head_cols "Descr. estesa"
lappend head_cols "Cap"
lappend head_cols "Da numero"
lappend head_cols "A numero"
lappend head_cols "Codice via nuovo"
lappend head_cols  "flag_ente"
lappend head_cols  "comune_ente"
lappend head_cols  "provincia_ente"

# imposto il tracciato record del file csv
set     file_cols ""
lappend file_cols "cod_via"
lappend file_cols "cod_comune"
lappend file_cols "descrizione"
lappend file_cols "descr_topo"
lappend file_cols "descr_estesa"
lappend file_cols "cap"
lappend file_cols "da_numero"
lappend file_cols "a_numero"
lappend file_cols "cod_via_new"
lappend file_cols  "flag_ente"
lappend file_cols  "comune_ente"
lappend file_cols  "provincia_ente"

iter_get_coimtgen
set flag_ente   $coimtgen(flag_ente)
db_1row sel_ente "select cod_prov as provincia_ente, cod_comu as comune_ente from coimtgen"

if {![string equal $f_comune ""]} {
    set where_comune " and a.cod_comune = :f_comune and disattiva is null"
} else {
    set where_comune " and disattiva is null"
}

iter_get_coimtgen
set tipo_ente   $coimtgen(flag_ente)
if {$tipo_ente == "P"} {
    db_1row sel_ente "select substr(lpad(b.cod_istat,6,'0'),1,3) as cod_prov 
                                from coimtgen a, coimcomu b where a.cod_prov = b.cod_provincia and b.cod_istat is not null limit 1"
    set cod_comu "000"
   }
if {$tipo_ente == "C"} {
    db_1row sel_ente "select substr(lpad(b.cod_istat,6,'0'),1,3) as cod_prov
                                   , substr(lpad(b.cod_istat,6,'0'),4,3) as cod_comu
                                from coimtgen a, coimcomu b where a.cod_comu = b.cod_comune"
}


# inizio del ciclo
set sw_primo_rec "t"
db_foreach sel_viae "" {
    set file_col_list ""

    set flag_ente $tipo_ente
    set comune_ente $cod_comu
    set provincia_ente $cod_prov
    

    if {$sw_primo_rec == "t"} {
	set sw_primo_rec "f"
	iter_put_csv $file_id head_cols |
    }

    foreach column_name $file_cols {
	lappend file_col_list [set $column_name]
    }
    iter_put_csv $file_id file_col_list |

} if_no_rows {
    set msg_err      "Nessuna incontro selezionato con i criteri utilizzati"
    set msg_err_list [list $msg_err]
    iter_put_csv $file_id msg_err_list
}

ad_returnredirect $file_csv_url
ad_script_abort
