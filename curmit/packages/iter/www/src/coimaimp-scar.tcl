#www/caldaie/src/
ad_page_contract {
    lista per scarico impianti censiti

    @author         Katia Coazzoli
    @creation-date  14/06/2004

    @cvs-id coimaimp-scar.tcl

} {
    {nome_funz         ""}
}

# Imposto variabili tipiche di ogni funzione
set lvl 1

set current_datetime [clock format [clock seconds] -f "%Y-%m-%d %H:%M:%S"]
set nome_file        "Estrazione impianti ${current_datetime}"
set permanenti_dir     [iter_set_permanenti_dir]
set permanenti_dir_url [iter_set_permanenti_dir_url]
set file_csv         "$permanenti_dir/$nome_file.csv"
set file_csv_url     "$permanenti_dir_url/$nome_file.csv"

set file_id [open $file_csv w]
fconfigure $file_id -encoding iso8859-1

# imposto la prima riga del file csv
set     head_cols ""
lappend head_cols "Codice utenza"
lappend head_cols "Natura giuridica"
lappend head_cols "Cognome intestatario"
lappend head_cols "Nome intestatario"
lappend head_cols "Codice fiscale"
lappend head_cols "Partita iva"
lappend head_cols "Telefono intestatario"
lappend head_cols "Data nascita intestatario"
lappend head_cols "Comune nascita intestatario"
lappend head_cols "Indirizzo"
lappend head_cols "Numero"
lappend head_cols "Esponente"
lappend head_cols "Scala"
lappend head_cols "Piano"
lappend head_cols "Interno"
lappend head_cols "Cap"
lappend head_cols "Localita"
lappend head_cols "Comune"
lappend head_cols "Provincia"
lappend head_cols "Combustibile"
lappend head_cols "Consumo annuo"
lappend head_cols "Tariffa"

# imposto il tracciato record del file csv
set     file_cols ""
lappend file_cols "cod_utenza"
lappend file_cols "natura_giuridica"
lappend file_cols "cognome_inte"
lappend file_cols "nome_inte"
lappend file_cols "cod_fiscale_piva_inte"
lappend file_cols "telefono_inte"
lappend file_cols "data_nas_inte"
lappend file_cols "comune_nas_inte"
lappend file_cols "indirizzo"
lappend file_cols "numero"
lappend file_cols "esponente"
lappend file_cols "scala"
lappend file_cols "piano"
lappend file_cols "interno"
lappend file_cols "cap"
lappend file_cols "localita"
lappend file_cols "comune"
lappend file_cols "provincia"
lappend file_cols "descr_comb"
lappend file_cols "consumo_annuo"
lappend file_cols "tariffa"


# inizio del ciclo
set sw_primo_rec "t"
db_foreach sel_aimp "" {

    if {$sw_primo_rec == "t"} {
	set sw_primo_rec "f"
	iter_put_csv $file_id head_cols
    }

    if {![string equal $cod_fiscale ""]} {
        set cod_fiscale_piva_inte  $cod_fiscale
    } else {
        if {![string equal $cod_piva ""]} { 
            set cod_fiscale_piva_inte  $cod_piva
	} else {
            set cod_fiscale_piva_inte ""
	}
    }

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
