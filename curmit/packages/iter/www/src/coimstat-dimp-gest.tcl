ad_page_contract {
    Add/Edit/Delete  form per la tabella "coimdimp"
    @author          Giulio Laurenzi
    @creation-date   01/09/2004

    @param funzione  I=insert M=edit D=delete V=view
    @param caller    caller della lista da restituire alla lista:
                     serve se lista e' uno zoom che permetti aggiungi.
    @param nome_funz identifica l'entrata di menu, server per le autorizzazioni
                     serve se lista e' uno zoom che permetti aggiungi.
    @param nome_funz_caller identifica l'entrata di menu, serve per la 
                     navigazione con navigation bar
    @cvs-id          coimstat-dimp-gest.tcl
} {
    {funzione        "I"}
    {caller      "index"}
    {nome_funz        ""}
    {nome_funz_caller ""}
    {f_data_inizio    ""}
    {f_data_fine      ""}
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

# imposta le class css della barra delle funzioni
iter_set_func_class $funzione

# controllo il parametro di "propagazione" per la navigation bar
if {[string is space $nome_funz_caller]} {
    set nome_funz_caller $nome_funz
}

# imposto variabili usate nel programma:
set sysdate_edit [iter_edit_date [iter_set_sysdate]]

# imposto la directory degli permanenti ed il loro nome.
set permanenti_dir     [iter_set_permanenti_dir]
set permanenti_dir_url [iter_set_permanenti_dir_url]

# imposto il nome dei file
set nome_file     "Statistica modelli h"
set nome_file     [iter_temp_file_name -permanenti $nome_file]
set file_csv      "$permanenti_dir/$nome_file.csv"
set file_csv_url  "$permanenti_dir_url/$nome_file.csv"

set file_id       [open $file_csv w]
fconfigure $file_id -encoding iso8859-1

set where_data ""

if {![string equal $f_data_inizio ""]
    &&  [string equal $f_data_fine ""]
} {
    set where_data "and a.data_controllo >= :f_data_inizio"
}
if { [string equal $f_data_inizio ""]
     &&  ![string equal $f_data_fine   ""]
 } {
    set where_data "and a.data_controllo <= :f_data_fine"
}
if {![string equal $f_data_inizio ""]
    &&  ![string equal $f_data_fine   ""]
} {
    set where_data "and a.data_controllo between :f_data_inizio and :f_data_fine"
}


iter_get_coimtgen
# per la provincia raggruppo per comune
# per il comune    raggruppo per quartiere
if {$coimtgen(flag_ente) == "C"} {
    set tit_terr      "Quartiere"
    set cod_terr      "b.cod_qua"
    set des_terr      "e.descrizione";# nell'xql aggiungo as h_des_terr
    set from_terr_ora ", coimcqua e"
    set join_terr_ora "and e.cod_qua (+)= b.cod_qua"
    set from_terr_pos "left outer join coimcqua e"
    set join_terr_pos "on e.cod_qua = b.cod_qua"
} else {
    set tit_terr      "Comune"
    set cod_terr      "b.cod_comune"
    set des_terr      "e.denominazione";# nell'xql aggiungo as h_des_terr
    set from_terr_ora ", coimcomu e"
    set join_terr_ora "and e.cod_comune (+)= b.cod_comune"
    set from_terr_pos "left outer join coimcomu e"
    set join_terr_pos "on e.cod_comune = b.cod_comune"
}

# imposto la prima riga del file csv
set     head_cols ""
lappend head_cols $tit_terr
lappend head_cols "Tipo Imp."
lappend head_cols "Fascia potenza"
lappend head_cols "Combustibile"
lappend head_cols "N. modelli H"
lappend head_cols "Max Temperatura fumi"
lappend head_cols "Min Temperatura fumi"
lappend head_cols "Media Temperatura fumi"
lappend head_cols "Campioni riferimento"
lappend head_cols "Max Temperatura Ambiente"
lappend head_cols "Min Temperatura Ambiente"
lappend head_cols "Media Temparatura Ambiente"
lappend head_cols "Campioni riferimento"
lappend head_cols "Max O2"
lappend head_cols "Min O2"
lappend head_cols "Media O2"
lappend head_cols "Campioni riferimento"
lappend head_cols "Max CO2"
lappend head_cols "Min CO2"
lappend head_cols "Media CO2"
lappend head_cols "Campioni riferimento"
lappend head_cols "Max Bacharach"
lappend head_cols "Min Bacharach"
lappend head_cols "Media Bacharach"
lappend head_cols "Campioni riferimento"
lappend head_cols "Max CO"
lappend head_cols "Min CO"
lappend head_cols "Media CO"
lappend head_cols "Campioni riferimento"
lappend head_cols "Max Rendimento combustibile"
lappend head_cols "Min Rendimento combustibile"
lappend head_cols "Media Rendimento combustibile"
lappend head_cols "Campioni riferimento"

# imposto il tracciato record del file csv
set     file_cols ""
lappend file_cols "h_des_terr"
lappend file_cols "flag_tipo_impianto"
lappend file_cols "descr_potenza"
lappend file_cols "descr_comb"
lappend file_cols "contatore"
lappend file_cols "max_temp_fumi"
lappend file_cols "min_temp_fumi"
lappend file_cols "temp_fumi"
lappend file_cols "num_temp_fumi"
lappend file_cols "max_temp_ambi"
lappend file_cols "min_temp_ambi"
lappend file_cols "temp_ambi"
lappend file_cols "num_temp_ambi"
lappend file_cols "max_o2"
lappend file_cols "min_o2"
lappend file_cols "o2"
lappend file_cols "num_o2"
lappend file_cols "max_co2"
lappend file_cols "min_co2"
lappend file_cols "co2"
lappend file_cols "num_co2"
lappend file_cols "max_bacharach"
lappend file_cols "min_bacharach"
lappend file_cols "bacharach"
lappend file_cols "num_bacharach"
lappend file_cols "max_co"
lappend file_cols "min_co"
lappend file_cols "co"
lappend file_cols "num_co"
lappend file_cols "max_rend_combust"
lappend file_cols "min_rend_combust"
lappend file_cols "rend_combust"
lappend file_cols "num_rend_combust"

set sw_primo_rec "t"
db_foreach sel_stat "" {

    if {$sw_primo_rec == "t"} {
	set sw_primo_rec "f"
	iter_put_csv $file_id head_cols
    }
    set file_col_list ""
    foreach column_name $file_cols {
	lappend file_col_list [set $column_name]
    }
    iter_put_csv $file_id file_col_list

} if_no_rows {
    set msg_err      "Nessuna dato selezionato con i criteri utilizzati"
    set msg_err_list [list $msg_err]
    iter_put_csv $file_id msg_err_list
}
db_foreach sel_stat2 "" {

    set file_col_list ""
    set h_des_terr "Totali"
    set flag_tipo_impianto ""
    set descr_potenza ""
    set descr_comb ""
    set max_temp_fumi ""
    set min_temp_fumi ""
    set temp_fumi ""
    set max_temp_ambi ""
    set min_temp_ambi ""
    set temp_ambi ""
    set max_o2 ""
    set min_o2 ""
    set o2 ""
    set max_co2 ""
    set min_co2 ""
    set co2 ""
    set max_bacharach ""
    set min_bacharach ""
    set bacharach ""
    set max_co ""
    set min_co ""
    set co ""
    set max_rend_combust ""
    set min_rend_combust ""
    set rend_combust ""

    foreach column_name $file_cols {
	lappend file_col_list [set $column_name]
    }
    iter_put_csv $file_id file_col_list
}

  
ad_returnredirect $file_csv_url
ad_script_abort
