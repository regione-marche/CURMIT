ad_page_contract {

    @author          Giulio Laurenzi
    @creation-date   04/10//2005

    @param funzione  I=insert M=edit D=delete V=view
    @param caller    caller della lista da restituire alla lista:
                     serve se lista e' uno zoom che permetti aggiungi.
    @param nome_funz identifica l'entrata di menu, server per le autorizzazioni
                     serve se lista e' uno zoom che permetti aggiungi.
    @param nome_funz_caller identifica l'entrata di menu, serve per la 
                     navigazione con navigation bar
    @param extra_par Variabili extra da restituire alla lista
    @cvs-id          coimboll-layout.tcl
} {

    {nome_funz         ""}
    {nome_funz_caller  ""}
    {f_cod_manu        ""}
    {f_data_ril_da     ""}
    {f_data_ril_a      ""}
    {cod_manutentore   ""}
    {cod_bollini       ""}
} -properties {
    page_title:onevalue
    context_bar:onevalue
    form_name:onevalue
}

set lvl 1

set id_utente [lindex [iter_check_login $lvl $nome_funz] 1]

iter_get_coimtgen
set flag_ente    $coimtgen(flag_ente)
set denom_comune $coimtgen(denom_comune)
set sigla_prov   $coimtgen(sigla_prov)
set link_stp     [export_ns_set_vars "url"]

set pack_key [iter_package_key]
set pack_dir [apm_package_url_from_key $pack_key]
append pack_dir "srcpers"

switch $flag_ente {
    "P" {set directory "$flag_ente$sigla_prov"}
    "C" {set directory "$flag_ente$denom_comune"}
default {set "standard"}
}

ad_returnredirect $pack_dir/$directory/coimboll-layout?$link_stp