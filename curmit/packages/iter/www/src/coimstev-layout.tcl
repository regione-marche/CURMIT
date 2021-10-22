ad_page_contract {

    @author          Paolo Formizzi Adhoc
    @creation-date   17/05/2004

    @param funzione  I=insert M=edit D=delete V=view
    @param caller    caller della lista da restituire alla lista:
                     serve se lista e' uno zoom che permetti aggiungi.
    @param nome_funz identifica l'entrata di menu, server per le autorizzazioni
                     serve se lista e' uno zoom che permetti aggiungi.
    @param nome_funz_caller identifica l'entrata di menu, serve per la 
                     navigazione con navigation bar
    @param extra_par Variabili extra da restituire alla lista
    @cvs-id          coimstev-layout.tcl
} {
    {cod_inco          ""}
    {funzione          ""}
    {caller       "index"}
    {nome_funz         ""}
    {nome_funz_caller  ""}
    {f_data            ""}
    {f_tipo_data       ""}
    {f_cod_impianto    ""}
    {f_cod_tecn        ""}
    {f_cod_esito       ""}
    {f_cod_comune      ""}
    {f_cod_via         ""}
    {f_descr_via       ""}
    {f_descr_topo      ""}
    {f_tipo_estrazione ""}

    {f_cod_enve        ""}
    {f_cod_comb        ""}
    {f_anno_inst_da    ""}
    {f_anno_inst_a     ""}

    {flag_inco         ""}
    {extra_par         ""}
    {cod_impianto      ""}
    {url_list_aimp     ""}
    {url_aimp          ""}
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

ad_returnredirect $pack_dir/$directory/coimstev-layout?$link_stp

