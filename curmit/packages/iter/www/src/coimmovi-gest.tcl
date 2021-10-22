ad_page_contract {
    Add/Edit/Delete  form per la tabella "coimmovi"
    @author          Paolo Formizzi Adhoc
    @creation-date   07/05/2004

    @param funzione  I=insert M=edit D=delete V=view
    @param caller    caller della lista da restituire alla lista:
    serve se lista e' uno zoom che permetti aggiungi.
    @param nome_funz identifica l'entrata di menu, server per le autorizzazioni
    serve se lista e' uno zoom che permetti aggiungi.
    @param nome_funz_caller identifica l'entrata di menu, serve per la 
    navigazione con navigation bar
    @param extra_par Variabili extra da restituire alla lista
    @cvs-id          coimmovi-gest.tcl
} {
    {cod_movi         ""}
    {last_cod_movi    ""}
    {funzione        "V"}
    {caller      "index"}
    {nome_funz        ""}
    {nome_funz_caller ""}
    {extra_par        ""}
    {cod_impianto     ""}
    {url_aimp         ""}
    {url_list_aimp    ""}
    {flag_pag         ""}
} -properties {
    page_title:onevalue
    context_bar:onevalue
    form_name:onevalue
}

# Controlla lo user
switch $funzione {
    "V" {set lvl 1}
    "I" {set lvl 2}
    "M" {set lvl 3}
    "D" {set lvl 4}
}

set id_utente [lindex [iter_check_login $lvl $nome_funz] 1]
set link_gest [export_url_vars cod_movi cod_impianto url_aimp url_list_aimp last_cod_movi nome_funz nome_funz_caller extra_par caller]

if {$funzione == "I"} {

    switch $flag_pag {
	"P" {set return_url "coimmovi-paga-gest?funzione=I&$link_gest"}
	"S" {set return_url "coimsanz-ins?funzione=I&$link_gest"}
	default {}
    }

} else {
    db_1row sel_tipo_pag "select tipo_movi, id_caus
                            from coimmovi
                           where cod_movi = :cod_movi"

    switch $tipo_movi {
	"SA"    {set return_url "coimsanz-ins?funzione=V&$link_gest"}
	default {set return_url "coimmovi-paga-gest?funzione=V&$link_gest"}
    }
}

ad_returnredirect $return_url
ad_script_abort
