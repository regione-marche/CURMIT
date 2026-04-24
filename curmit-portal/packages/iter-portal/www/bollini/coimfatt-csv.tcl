ad_page_contract {
    Lista tabella "coimfatt"

    @author                  Tonolli Alessandro Adhoc
    @creation-date           10/10/2005

    @param search_word       parola da ricercare con una query
    @param rows_per_page     una delle dimensioni della tabella  
    @param caller            se diverso da index rappresenta il nome del form 
                             da cui e' partita la ricerca ed in questo caso
                             imposta solo azione "sel"
    @param receiving_element nomi dei campi di form che riceveranno gli
                             argomenti restituiti dallo script di zoom,
                             separati da '|' ed impostarli come segue:

    @cvs-id coimfatt-csv.tcl 

    USER   DATA       MODIFICHE
    ====== ========== =======================================================================
    san01  08/02/2018 Aggiunto codice fiscale

} {
    {nome_funz        ""}
    {nome_funz_caller ""}
    {a_data           ""}
    {da_data          ""}
} 

# Controlla lo user
set id_utente [auth::require_login]

if {![string equal $da_data ""]} {
    set where_da_data "and to_char(data_fatt,'yyyymmdd') >= :da_data"
} else {
    set where_da_data ""
}

if {![string equal $a_data ""]} {
    set where_a_data  "and to_char(data_fatt,'yyyymmdd') <= :a_data"
} else {
    set where_a_data  ""
}

set current_datetime [clock format [clock seconds] -f "%Y-%m-%d %H:%M:%S"]
set nome_file          "Scarico Elenco Fatture"
set nome_file          [iter_temp_file_name -permanenti $nome_file]
set permanenti_dir     [iter_set_permanenti_dir]
set permanenti_dir_url [iter_set_permanenti_dir_url]
set file_csv           "$permanenti_dir/$nome_file.csv"
set file_csv_url       "$permanenti_dir_url/$nome_file.csv"

set file_id [open $file_csv w]
fconfigure $file_id -encoding iso8859-1

# imposto la prima riga del file csv
set     head_cols ""
lappend head_cols "Numero_fattura"
lappend head_cols "Data_Fattura"
lappend head_cols "Cognome"
lappend head_cols "Nome"
lappend head_cols "Toponimo"
lappend head_cols "Nome_via"
lappend head_cols "n_civico"
lappend head_cols "Cap"
lappend head_cols "Localita"
lappend head_cols "Comune"
lappend head_cols "Provincia"
lappend head_cols "Imponibile"
lappend head_cols "Iva"
lappend head_cols "Totale"
lappend head_cols "Spese postali"
lappend head_cols "Spese legali"
lappend head_cols "Partita iva"
lappend head_cols "Codice fiscale";#san01
lappend head_cols "Data pagam."
lappend head_cols "Importo pagato"
lappend head_cols "Da_matricola"
lappend head_cols "A_matricola"

# imposto il tracciato record del file csv
set     file_cols ""
lappend file_cols "num_fatt"
lappend file_cols "fatt_dt"
lappend file_cols "cognome"
lappend file_cols "nome"
lappend file_cols "toponimo"
lappend file_cols "nome_via"
lappend file_cols "n_civ"
lappend file_cols "cap"
lappend file_cols "localita"
lappend file_cols "comune"
lappend file_cols "provincia"
lappend file_cols "imponibile"
lappend file_cols "iva"
lappend file_cols "totale"
lappend file_cols "spe_postali"
lappend file_cols "spe_legali"
lappend file_cols "partita_iva"
lappend file_cols "codice_fiscale";#san01
lappend file_cols "data_pag_edit"
lappend file_cols "importo_pag_edit"
lappend file_cols "matr_da"
lappend file_cols "matr_a"

set sw_primo_rec "t"
db_foreach sel_fatt "" {
    if {$sw_primo_rec eq "t"} {
	set sw_primo_rec "f"
	iter_put_csv $file_id head_cols
    }

    set toponimo ""
    switch $tipo_sogg {
	"M" { 
	    set n_civ ""
	    set nome  ""
	    if {[db_0or1row sel_manu {}] == 0} {
		set cognome     ""
		set nome_via    ""
		set cap         ""
		set localita    ""
		set comune      ""
		set provincia   ""
		set partita_iva ""
	    }
	}
	"C" {
	    if {[db_0or1row sel_citt {}] == 0} {
		set cognome     ""
		set nome        ""
		set nome_via    ""
		set n_civ       ""
		set cap         ""
		set localita    ""
		set comune      ""
		set provincia   ""
		set partita_iva ""
	    } 
	}
	default {
	    set cognome     ""
	    set nome        ""
	    set nome_via    ""
	    set n_civ       ""
	    set cap         ""
	    set localita    ""
	    set comune      ""
	    set provincia   ""
	    set partita_iva ""
	}
    }
 
    if {$perc_iva eq ""} {
	set perc_iva 0
    }
    set iva [expr $importo_num - $imponibile_num]
    set iva [iter_edit_num $iva 2]

    set file_col_list ""
    foreach column_name $file_cols {
	lappend file_col_list [set $column_name]
    }
    iter_put_csv $file_id file_col_list

} if_no_rows {
    set msg_err "Nessuna incontro selezionato con i criteri utilizzati"
    set msg_err_list [list $msg_err]
    iter_put_csv $file_id msg_err_list
}

ad_returnredirect $file_csv_url
ad_script_abort
