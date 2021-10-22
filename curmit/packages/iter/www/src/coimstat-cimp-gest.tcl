ad_page_contract {
    Add/Edit/Delete  form per la tabella "coimcimp"
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
set nome_file     "Statistica rapporti ispezione"
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
lappend head_cols "Esito (P/N)"
lappend head_cols "N. rapporti di ispezione"
lappend head_cols "Stato coibentazione \"Buono\""
lappend head_cols "Stato coibentazione \"Mediocre\""
lappend head_cols "Stato coibentazione \"Scarso\""
lappend head_cols "Stato coibentazione \"Non noto\""
lappend head_cols "Stato canna fumaria \"Buono\""
lappend head_cols "Stato canna fumaria \"Mediocre\""
lappend head_cols "Stato canna fumaria \"Scarso\""
lappend head_cols "Stato canna fumaria \"Non noto\""
lappend head_cols "Verifica dispositivo regolazione e controllo \"Positivo\""
lappend head_cols "Verifica dispositivo regolazione e controllo \"Negativoe\""
lappend head_cols "Verifica dispositivo regolazione e controllo \"Non noto\""
lappend head_cols "Verifica aerazione locali \"Positivo\""
lappend head_cols "Verifica aerazione locali \"Negativo\""
lappend head_cols "Verifica aerazione locali \"Non noto\""
lappend head_cols "Taratura dispositivo regolazione e controllo \"Effettuato\""
lappend head_cols "Taratura dispositivo regolazione e controllo \"Non effettuato\""
lappend head_cols "Taratura dispositivo regolazione e controllo \"Non noto\""
lappend head_cols "Max Temperatura fumi"
lappend head_cols "Min Temperatura fumi"
lappend head_cols "Media Temperatura fumi"
lappend head_cols "Campioni di riferimento"
lappend head_cols "Max Temperatura aria comburente"
lappend head_cols "Min Temperatura aria comburente"
lappend head_cols "Media Temperatura aria comburente"
lappend head_cols "Campioni di riferimento"
lappend head_cols "Max Temperatura mantello"
lappend head_cols "Min Temperatura mantello"
lappend head_cols "Media Temperatura mantello"
lappend head_cols "Campioni di riferimento"
lappend head_cols "Max Temperatura fluido in mandata"
lappend head_cols "Min Temperatura fluido in mandata"
lappend head_cols "Media Temperatura fluido in mandata"
lappend head_cols "Campioni di riferimento"
lappend head_cols "Max CO2"
lappend head_cols "Min CO2"
lappend head_cols "Media CO2"
lappend head_cols "Campioni di riferimento"
lappend head_cols "Max O2"
lappend head_cols "Min O2"
lappend head_cols "Media O2"
lappend head_cols "Campioni di riferimento"
lappend head_cols "Max CO(ppm)"
lappend head_cols "Min CO(ppm)"
lappend head_cols "Media CO(ppm)"
lappend head_cols "Campioni di riferimento"
lappend head_cols "Max Indice di fumosita' bacharach"
lappend head_cols "Min Indice di fumosita' bacharach"
lappend head_cols "Media Indice di fumosita' bacharach"
lappend head_cols "Campioni di riferimento"
lappend head_cols "Max CO nei fumi secchi e senz'aria"
lappend head_cols "Min CO nei fumi secchi e senz'aria"
lappend head_cols "Media CO nei fumi secchi e senz'aria"
lappend head_cols "Campioni di riferimento"
lappend head_cols "Max CO nei fumi secchi e senz'aria (ppm)"
lappend head_cols "Min CO nei fumi secchi e senz'aria (ppm)"
lappend head_cols "Media CO nei fumi secchi e senz'aria (ppm)"
lappend head_cols "Campioni di riferimento"
lappend head_cols "Max Eccesso d'aria %"
lappend head_cols "Min Eccesso d'aria %"
lappend head_cols "Media Eccesso d'aria %"
lappend head_cols "Campioni di riferimento"
lappend head_cols "Max Perdita ai fumi%"
lappend head_cols "Min Perdita ai fumi%"
lappend head_cols "Media Perdita ai fumi%"
lappend head_cols "Campioni di riferimento"

# imposto il tracciato record del file csv
set     file_cols ""
lappend file_cols "h_des_terr"
lappend file_cols "flag_tipo_impianto"
lappend file_cols "descr_potenza"
lappend file_cols "descr_comb"
lappend file_cols "esito_verifica"
lappend file_cols "contatore"
lappend file_cols "stato_coiben_b"
lappend file_cols "stato_coiben_m"
lappend file_cols "stato_coiben_s"
lappend file_cols "stato_coiben_n"
lappend file_cols "stato_canna_fum_b"
lappend file_cols "stato_canna_fum_m"
lappend file_cols "stato_canna_fum_s"
lappend file_cols "stato_canna_fum_n"
lappend file_cols "verifica_dispo_p"
lappend file_cols "verifica_dispo_n"
lappend file_cols "verifica_dispo_no"
lappend file_cols "verifica_areaz_p"
lappend file_cols "verifica_areaz_n"
lappend file_cols "verifica_areaz_no"
lappend file_cols "taratura_dispos_si"
lappend file_cols "taratura_dispos_no"
lappend file_cols "taratura_dispos_n"
lappend file_cols "max_temp_fumi"
lappend file_cols "min_temp_fumi"
lappend file_cols "med_temp_fumi"
lappend file_cols "campioni_temp_fumi"
lappend file_cols "max_t_aria_comb"
lappend file_cols "min_t_aria_comb"
lappend file_cols "med_t_aria_comb"
lappend file_cols "campioni_t_aria_comb"
lappend file_cols "max_temp_mant"
lappend file_cols "min_temp_mant"
lappend file_cols "med_temp_mant"
lappend file_cols "campioni_temp_mant"
lappend file_cols "max_temp_h2o_out"
lappend file_cols "min_temp_h2o_out"
lappend file_cols "med_temp_h2o_out"
lappend file_cols "campioni_temp_h2o_out"
lappend file_cols "max_co2"
lappend file_cols "min_co2"
lappend file_cols "med_co2"
lappend file_cols "campioni_co2"
lappend file_cols "max_o2"
lappend file_cols "min_o2"
lappend file_cols "med_o2"
lappend file_cols "campioni_o2"
lappend file_cols "max_co"
lappend file_cols "min_co"
lappend file_cols "med_co"
lappend file_cols "campioni_co"
lappend file_cols "max_indic_fumosita"
lappend file_cols "min_indic_fumosita"
lappend file_cols "med_indic_fumosita"
lappend file_cols "campioni_indic_fumosita"
lappend file_cols "max_co_fumi_secchi"
lappend file_cols "min_co_fumi_secchi"
lappend file_cols "med_co_fumi_secchi"
lappend file_cols "campioni_co_fumi_secchi"
lappend file_cols "max_ppm"
lappend file_cols "min_ppm"
lappend file_cols "med_ppm"
lappend file_cols "campioni_ppm"
lappend file_cols "max_eccesso_aria_perc"
lappend file_cols "min_eccesso_aria_perc"
lappend file_cols "med_eccesso_aria_perc"
lappend file_cols "campioni_eccesso_aria_perc"
lappend file_cols "max_perdita_ai_fumi"
lappend file_cols "min_perdita_ai_fumi"
lappend file_cols "med_perdita_ai_fumi"
lappend file_cols "campioni_perdita_ai_fumi"

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
    set esito_verifica ""
    #    set stato_coiben_b ""
    #    set stato_coiben_m ""
    #    set stato_coiben_s ""
    #    set stato_coiben_n ""
    #    set stato_canna_fum_b ""
    #    set stato_canna_fum_m ""
    #    set stato_canna_fum_s ""
    #    set stato_canna_fum_n ""
    #    set verifica_dispo_b ""
    #    set verifica_dispo_m ""
    #    set verifica_dispo_s ""
    #    set verifica_dispo_n ""
    #    set verifica_areaz_b ""
    #    set verifica_areaz_m ""
    #    set verifica_areaz_s ""
    #    set verifica_areaz_n ""
    #    set taratura_dispos_si ""
    #    set taratura_dispos_no ""
    #    set taratura_dispos_n ""
    set max_temp_fumi ""
    set min_temp_fumi ""
    set med_temp_fumi ""
    set max_t_aria_comb ""
    set min_t_aria_comb ""
    set med_t_aria_comb ""
    set max_temp_mant ""
    set min_temp_mant ""
    set med_temp_mant ""
    set max_temp_h2o_out ""
    set min_temp_h2o_out ""
    set med_temp_h2o_out ""
    set max_co2 ""
    set min_co2 ""
    set med_co2 ""
    set max_o2 ""
    set min_o2 ""
    set med_o2 ""
    set max_co ""
    set min_co ""
    set med_co ""
    set max_indic_fumosita ""
    set min_indic_fumosita ""
    set med_indic_fumosita ""
    set max_co_fumi_secchi ""
    set min_co_fumi_secchi ""
    set med_co_fumi_secchi ""
    set max_ppm ""
    set min_ppm ""
    set med_ppm ""
    set max_eccesso_aria_perc ""
    set min_eccesso_aria_perc ""
    set med_eccesso_aria_perc ""
    set max_perdita_ai_fumi ""
    set min_perdita_ai_fumi ""
    set med_perdita_ai_fumi ""

    foreach column_name $file_cols {
	lappend file_col_list [set $column_name]
    }
    iter_put_csv $file_id file_col_list
}


ad_returnredirect $file_csv_url
ad_script_abort
