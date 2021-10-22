ad_page_contract {
    Add/Edit/Delete  form per la tabella "coimdimp"
    @author          Adhoc
    @creation-date   13/03/2006

    @param funzione  I=insert M=edit D=delete V=view
    @param caller    caller della lista da restituire alla lista:
                     serve se lista e' uno zoom che permetti aggiungi.
    @param nome_funz identifica l'entrata di menu, server per le autorizzazioni
                     serve se lista e' uno zoom che permetti aggiungi.
    @param nome_funz_caller identifica l'entrata di menu, serve per la 
                     navigazione con navigation bar
    @param extra_par Variabili extra da restituire alla lista
    @cvs-id          coimcimp-gest.tcl
} {
    {cod_as_resp             ""}
    {last_cod_as_resp        ""}
    {funzione            "V"}
    {caller          "index"}
    {nome_funz            ""}
    {nome_funz_caller     ""}
    {extra_par            ""}
    {cod_impianto         ""}
    {url_aimp             ""} 
    {url_list_aimp        ""}
    {flag_tracciato       ""}
} -properties {
    page_title:onevalue
    context_bar:onevalue
    form_name:onevalue
}

# Controlla lo user

ns_log notice "prova dob1 coim_as_resp_gest $flag_tracciato"

switch $funzione {
    "V" {set lvl 1}
    "I" {set lvl 2}
    "M" {set lvl 3}
    "D" {set lvl 4}
}

set id_utente [lindex [iter_check_login $lvl $nome_funz] 1]


iter_get_coimtgen
set flag_ente    $coimtgen(flag_ente)
set denom_comune $coimtgen(denom_comune)
set sigla_prov   $coimtgen(sigla_prov)
set link         [export_ns_set_vars "url"]

set pack_key [iter_package_key]
set pack_dir [apm_package_url_from_key $pack_key]
append pack_dir "src"

set directory ""

if {$funzione != "I"} {
    if {[db_0or1row sel_dimp_flag_tracciato "select flag_tracciato
                                               from coim_as_resp
                                              where cod_as_resp = :cod_as_resp"] == 0} {
	iter_return_complaint "Modello non trovato"
        return
    }
} 

switch $flag_tracciato {
    "HMANU"  {set return_url $pack_dir/$directory/coim_as_manu-gest?$link}
    "IMANU"  {set return_url $pack_dir/$directory/coim_as_manu-gest?$link}
    "LMANU"  {set return_url $pack_dir/$directory/coim_as_ammi-gest?$link}
    default {set return_url $pack_dir/$directory/coim_as_manu-gest?$link}
}

ad_returnredirect $return_url


