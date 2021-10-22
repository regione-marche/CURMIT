ad_page_contract {

    @author         Valentina Catte
    @creation-date  14/06/2004

    @cvs-id coimmanu-list-csv.tcl

} {
   {f_cod_manutentore ""}
   {f_cognome         ""}
   {f_nome            ""}
   {f_ruolo           ""}
   {f_convenzionato   ""}
   {f_stato           ""}
   {nome_funz         ""}
}

# Imposto variabili tipiche di ogni funzione
set lvl 1
set id_utente [lindex [iter_check_login $lvl $nome_funz] 1]

# imposto filtro
if {[string equal $f_cognome ""]} {
    set where_cognome ""
} else {
    set f_cognome_1 [iter_search_word $f_cognome]
    set where_cognome  " and upper(a.cognome) like upper(:f_cognome_1)"
}

if {[string equal $f_nome ""]} {
    set where_nome ""
} else {
    set f_nome_1    [iter_search_word $f_nome]
    set where_nome  " and upper(a.nome) like upper(:f_nome_1)"
}

if {[string equal $f_cod_manutentore ""]} {
    set where_cod_manutentore ""
} else {
    set where_cod_manutentore " and a.cod_manutentore = :f_cod_manutentore"
}

if {[string equal $f_ruolo ""]} {
    set where_ruolo ""
} else {
    if {$f_ruolo == "M"} {
	set where_ruolo " and (a.flag_ruolo in ('M','T') or a.flag_ruolo is null)"
    }
    if {$f_ruolo == "I"} {
	set where_ruolo " and (a.flag_ruolo in ('I','T') or a.flag_ruolo is null)"
    }
    if {$f_ruolo == "T"} {
	set where_ruolo " and (a.flag_ruolo = 'T' or a.flag_ruolo is null)"
    }
}

if {[string equal $f_convenzionato ""]} {
    set where_convenzionato ""
} else {
    if {$f_convenzionato == "S"} {
	set where_convenzionato " and flag_convenzionato = 'S'"
    }
    if {$f_convenzionato == "N"} {
	set where_convenzionato " and flag_convenzionato = 'N'"
    }
}

if {[string equal $f_stato ""]} {
    set where_stato ""
} else {
    if {$f_stato == "A"} {
	set where_stato " and data_fine is null"
    }
    if {$f_stato == "C"} {
	set where_stato " and data_fine is not null"
    }
}

set current_datetime [clock format [clock seconds] -f "%Y-%m-%d %H:%M:%S"]
set nome_file        "Estrazione manutentori"
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
lappend head_cols "Ragione sociale"
lappend head_cols "Indirizzo"
lappend head_cols "Località"
lappend head_cols "Provincia"
lappend head_cols "Cap"
lappend head_cols "Comune"
lappend head_cols "Codice Fiscale"
lappend head_cols "Partita Iva"
lappend head_cols "Telefono"
lappend head_cols "Cellulare"
lappend head_cols "Fax"
lappend head_cols "E-mail"
lappend head_cols "Pec"
lappend head_cols "Registro Imprese"
lappend head_cols "Località Registro Imprese"
lappend head_cols "Rea"
lappend head_cols "Località Rea"
lappend head_cols "Capitale sociale"
lappend head_cols "Note"
lappend head_cols "Convenzionato"
lappend head_cols "Protocollo convenzione"
lappend head_cols "Data protocollo convenzione"
lappend head_cols "Ruolo"
lappend head_cols "Data inizio attività"
lappend head_cols "Data fine attività"
lappend head_cols "Legale rappresentante"
lappend head_cols "Indirizzo Legale rap."
lappend head_cols "Località Legale rap."
lappend head_cols "Provincia Legale rap."
lappend head_cols "Cap Legale rap."
lappend head_cols "Comune Legale rap."
lappend head_cols "Codice Fiscale Legale rap."



# imposto il tracciato record del file csv
set     file_cols ""
lappend file_cols "cod_manutentore"
lappend file_cols "rag_soc"
lappend file_cols "indirizzo"
lappend file_cols "localita"
lappend file_cols "provincia"
lappend file_cols "cap"
lappend file_cols "comune"
lappend file_cols "cod_fiscale"
lappend file_cols "cod_piva"
lappend file_cols "telefono"
lappend file_cols "cellulare"
lappend file_cols "fax"
lappend file_cols "email"
lappend file_cols "pec"
lappend file_cols "reg_imprese"
lappend file_cols "localita_reg"
lappend file_cols "rea"
lappend file_cols "localita_rea"
lappend file_cols "capit_sociale"
lappend file_cols "note"
lappend file_cols "flag_convenzionato"
lappend file_cols "prot_convenzione"
lappend file_cols "prot_convenzione_dt"
lappend file_cols "flag_ruolo"
lappend file_cols "data_inizio"
lappend file_cols "data_fine"
lappend file_cols "legale_rap"
lappend file_cols "legale_ind"
lappend file_cols "legale_loc"
lappend file_cols "legale_prov"
lappend file_cols "legale_cap"
lappend file_cols "legale_comune"
lappend file_cols "legale_cf"

set sw_primo_rec "t"
db_foreach sel_manu "" {
    set file_col_list ""

    if {$sw_primo_rec == "t"} {
	set sw_primo_rec "f"
	iter_put_csv $file_id head_cols
    }

    foreach column_name $file_cols {
	lappend file_col_list [set $column_name]
    }
    iter_put_csv $file_id file_col_list
    
} if_no_rows {
    set msg_err      "Nessun manutentore selezionato con i criteri utilizzati"
    set msg_err_list [list $msg_err]
    iter_put_csv $file_id msg_err_list
}

ad_returnredirect $file_csv_url
ad_script_abort

