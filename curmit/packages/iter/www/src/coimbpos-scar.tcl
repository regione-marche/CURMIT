ad_page_contract {
    Creazione file csv da lista bollettini postali

    @author         Simone Pesci
    @creation-date  09/07/2014

    @cvs-id         coimbpos-scar.tcl

} {
    {search_word             ""}
    {f_data_controllo_da     ""}
    {f_data_controllo_a      ""}
    {f_data_emissione_da     ""}
    {f_data_emissione_a      ""}
    {f_data_scarico_da       ""}
    {f_data_scarico_a        ""}
    {f_data_pagamento_da     ""}
    {f_data_pagamento_a      ""}
    {f_flag_pagati           ""}
    {f_quinto_campo          ""}
    {f_resp_cogn             ""}
    {f_resp_nome             ""}
    {f_cod_impianto_est      ""}
    {f_stato                 ""}

    {nome_funz               ""}
}

# Imposto variabili tipiche di ogni funzione
set lvl 1
set id_utente [lindex [iter_check_login $lvl $nome_funz] 1]

# Imposto filtro
if {![string equal $search_word ""]} {
    set f_resp_nome ""
} else {
    if {![string equal $f_resp_cogn ""]} {
	set search_word $f_resp_cogn
    }
}

if {[string equal $search_word ""]} {
    set where_word ""
} else {
    set search_word_1 [iter_search_word $search_word]
    set where_word  " and coimcitt.cognome like upper(:search_word_1)"
}

if {[string equal $f_resp_nome ""]} {
    set where_nome ""
} else {
    set f_resp_nome_1 [iter_search_word $f_resp_nome]
    set where_nome  " and coimcitt.nome like upper(:f_resp_nome_1)"
}

# imposto filtro per le date
if {![string equal $f_data_controllo_da ""] || ![string equal $f_data_controllo_a ""]} {
    if {[string equal $f_data_controllo_da ""]} {
        set f_data_controllo_da "18000101"
    }
    if {[string equal $f_data_controllo_a ""]} {
        set f_data_controllo_a  "21001231"
    }
    set where_data_controllo    "and coiminco.data_verifica between :f_data_controllo_da
                                                                and :f_data_controllo_a"
} else {
    set where_data_controllo ""
}

if {![string equal $f_data_emissione_da ""] || ![string equal $f_data_emissione_a ""]} {
    if {[string equal $f_data_emissione_da ""]} {
        set f_data_emissione_da "18000101"
    }
    if {[string equal $f_data_emissione_a ""]} {
        set f_data_emissione_a  "21001231"
    }
    set where_data_emissione    "and coimbpos.data_emissione between :f_data_emissione_da
                                                                 and :f_data_emissione_a"
} else {
    set where_data_emissione ""
}

if {![string equal $f_data_scarico_da ""] || ![string equal $f_data_scarico_a ""]} {
    if {[string equal $f_data_scarico_da ""]} {
        set f_data_scarico_da "18000101"
    }
    if {[string equal $f_data_scarico_a ""]} {
        set f_data_scarico_a  "21001231"
    }
    set where_data_scarico    "and coimbpos.data_scarico between :$f_data_scarico_da
                                                             and :$f_data_scarico_a"
} else {
    set where_data_scarico ""
}

if {![string equal $f_data_pagamento_da ""] || ![string equal $f_data_pagamento_a ""]} {
    if {[string equal $f_data_pagamento_da ""]} {
        set f_data_pagamento_da "18000101"
    }
    if {[string equal $f_data_pagamento_a ""]} {
        set f_data_pagamento_a  "21001231"
    }
    set where_data_pagamento    "and coimbpos.data_pagamento between :f_data_pagamento_da
                                                                 and :f_data_pagamento_a"
} else {
    set where_data_pagamento    ""
}

if {![string equal $f_flag_pagati ""]} {
    if {[string equal $f_flag_pagati "S"]} {
	set where_pagati "and coimbpos.importo_pagato  > 0"
    }
    if {[string equal $f_flag_pagati "N"]} {
	set where_pagati "and coimbpos.importo_pagato <= 0"
    }
} else {
    set where_pagati ""
}

if {![string equal $f_quinto_campo ""]} {
    set where_quinto_campo "and coimbpos.quinto_campo = :f_quinto_campo"
} else {
    set where_quinto_campo ""
}

# I filtri su f_resp_cogn e f_resp_nome sono gia' stati impostati prima

if {![string equal $f_cod_impianto_est ""]} {
    set where_codimp_est " and coimaimp.cod_impianto_est = upper(:f_cod_impianto_est)"
} else {
    set where_codimp_est ""
}

if {![string equal $f_stato ""]} {
    set where_stato      " and coimbpos.stato = upper:f_stato"
} else {
    set where_stato      ""
}


set nome_file          "Estrazione Bollettini Postali"
set nome_file          [iter_temp_file_name $nome_file]
set spool_dir          [iter_set_spool_dir]
set spool_dir_url      [iter_set_spool_dir_url]
set file_csv           "$spool_dir/$nome_file.csv"
set file_csv_url       "$spool_dir_url/$nome_file.csv"

set file_id            [open $file_csv w]
fconfigure $file_id -encoding iso8859-1

# imposto la prima riga del file csv
set     head_cols ""
lappend head_cols "Data estraz."
lappend head_cols "Quinto campo"
lappend head_cols "Cod.Imp."
lappend head_cols "Responsabile"
lappend head_cols "Indirizzo"
lappend head_cols "CAP"
lappend head_cols "Comune"
lappend head_cols "Data appunt."
lappend head_cols "Imp. da pagare"
lappend head_cols "Imp. pagato"
lappend head_cols "Data pag."
lappend head_cols "Stato"

# imposto il tracciato record del file csv
set     file_cols ""
lappend file_cols "data_emissione_edit"
lappend file_cols "quinto_campo"
lappend file_cols "cod_impianto_est"
lappend file_cols "nominativo_resp"
lappend file_cols "indirizzo"
lappend file_cols "cap"
lappend file_cols "comune"
lappend file_cols "data_verifica_edit"
lappend file_cols "importo_emesso_edit"
lappend file_cols "importo_pagato_edit"
lappend file_cols "data_pagamento_edit"
lappend file_cols "stato"
set sw_primo_rec "t"

db_foreach sel_bpos "" {
    set file_col_list ""

    if {$sw_primo_rec == "t"} {
        set sw_primo_rec "f"
        iter_put_csv $file_id head_cols
    }

    #Formatto opportunamente il quinto campo per excel
    set quinto_campo "=TESTO($quinto_campo;\"0000000000000000\")"

    foreach column_name $file_cols {
        lappend file_col_list [set $column_name]
    }
    iter_put_csv $file_id file_col_list

} if_no_rows {
    set msg_err      "Nessun bollettino postale selezionato con i criteri utilizzati"
    set msg_err_list [list $msg_err]
    iter_put_csv $file_id msg_err_list
}

close $file_id
ad_returnredirect $file_csv_url
ad_script_abort
