ad_page_contract {
    Add/Edit/Delete  statistiche per la tabella "coimaimp"
    @author          Giulio Laurenzi
    @creation-date   31/08/2004

    @param funzione  V=view
    @param caller    caller della lista da restituire alla lista:
                     serve se lista e' uno zoom che permetti aggiungi.
    @param nome_funz identifica l'entrata di menu, server per le autorizzazioni
                     serve se lista e' uno zoom che permetti aggiungi.
    @param nome_funz_caller identifica l'entrata di menu, serve per la 
                     navigazione con navigation bar
    @cvs-id          coimstat-aimp-gest.tcl
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
set link_gest [export_url_vars cod_batc nome_funz nome_funz_caller caller]

# controllo il parametro di "propagazione" per la navigation bar
if {[string is space $nome_funz_caller]} {
    set nome_funz_caller $nome_funz
}

# imposto variabili usate nel programma:
set sysdate_edit [iter_edit_date [iter_set_sysdate]]

# leggo la tabella dei dati generali
iter_get_coimtgen

# per la provincia raggruppo per comune
# per il comune    raggruppo per quartiere
if {$coimtgen(flag_ente) == "C"} {
    set tit_terr      "Quartiere"
    set cod_terr      "a.cod_qua"
    set des_terr      "e.descrizione";# nell'xql aggiungo as h_des_terr
    set from_terr_ora ", coimcqua e"
    set join_terr_ora "and e.cod_qua (+)= a.cod_qua"
    set from_terr_pos "left outer join coimcqua e"
    set join_terr_pos "on e.cod_qua = a.cod_qua"
} else {
    set tit_terr      "Comune"
    set cod_terr      "a.cod_comune"
    set des_terr      "e.denominazione";# nell'xql aggiungo as h_des_terr
    set from_terr_ora ", coimcomu e"
    set join_terr_ora "and e.cod_comune (+)= a.cod_comune"
    set from_terr_pos "left outer join coimcomu e"
    set join_terr_pos "on e.cod_comune = a.cod_comune"
}

# imposto la directory degli permanenti ed il loro nome.
set permanenti_dir     [iter_set_permanenti_dir]
set permanenti_dir_url [iter_set_permanenti_dir_url]

# imposto il nome dei file
set nome_file     "Statistica impianti "
set nome_file     [iter_temp_file_name -permanenti $nome_file]
set file_csv      "$permanenti_dir/$nome_file.csv"
set file_csv_url  "$permanenti_dir_url/$nome_file.csv"

set file_id       [open $file_csv w]
fconfigure $file_id -encoding iso8859-1

# imposto la prima riga del file csv
set     head_cols ""
lappend head_cols $tit_terr
lappend head_cols "Tipo Impianto"
lappend head_cols "Fascia potenza"
lappend head_cols "Tipo Impianto"
lappend head_cols "Dichiarato"
lappend head_cols "Anno installazione"
lappend head_cols "Combustibile"
lappend head_cols "N. impianti"

# imposto il tracciato record del file csv
set     file_cols ""
lappend file_cols "h_des_terr"
lappend file_cols "desc_tipo_impianto"
lappend file_cols "descr_potenza"
lappend file_cols "descr_tpim"
lappend file_cols "flag_dichiarato"
lappend file_cols "anno_inst"
lappend file_cols "descr_comb"
lappend file_cols "contatore"

set sw_primo_rec "t"
db_foreach sel_stat "" {
    set file_col_list ""

    if {$sw_primo_rec == "t"} {
	set sw_primo_rec "f"
	iter_put_csv $file_id head_cols
    }
    set file_col_list ""
    foreach column_name $file_cols {
#dpr74

set desc_tipo_impianto ""

if {[string equal $flag_tipo_impianto ""]} {
   set desc_tipo_impianto "Globale"
} 
if {[string equal $flag_tipo_impianto "R"]} {
   set desc_tipo_impianto "Riscaldamento"
} 
if {[string equal $flag_tipo_impianto "F"]} {
   set desc_tipo_impianto "Raffreddamento"
} 
if {[string equal $flag_tipo_impianto "C"]} {
   set desc_tipo_impianto "Cogenerazione"
} 
if {[string equal $flag_tipo_impianto "T"]} {
   set desc_tipo_impianto "Teleriscaldamento"
} 
#fine dpr74

	lappend file_col_list [set $column_name]
    }
    iter_put_csv $file_id file_col_list

} if_no_rows {
    set msg_err      "Nessun impianto attivo presente in archivio"
    set msg_err_list [list $msg_err]
    iter_put_csv $file_id msg_err_list
}

ad_returnredirect $file_csv_url
ad_script_abort



