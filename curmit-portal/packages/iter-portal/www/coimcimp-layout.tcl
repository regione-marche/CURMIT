ad_page_contract {
    Stampa Rapporto di verifica
    
    @author        Romitti Luca        
    @creation-date 21/06/2018

    @cvs-id coimcimp-layout.tcl

    USER  DATA       MODIFICHE
    ===== ========== =======================================================================
    innes 21/06/2018 Innesto da iter-dev a iter-portal-dev. Tutte le query verranno eseguite
    innes            passando il dbn che riceviamo dalla pagina di filtro.

    san01 12/08/2016 Gestito il nuovo rapporto di ispezione RE usato solo da A.F.E.

    sim01 15/04/2015 Gestito il nuovo rapporto di ispezione RI

} {
    {cod_cimp         ""}
    {funzione        "V"}
    {caller      "index"}
    {nome_funz        ""}
    {nome_funz_caller ""}
    {flag_ins        "S"}
    {flag_tracciato   ""}
    {dbn_iter         ""}
} -properties {
    page_title:onevalue
    context_bar:onevalue
    form_name:onevalue
}

# Controlla lo user
#innesif {![string is space $nome_funz]} {
#innes    set lvl        1
#innes    set id_utente [lindex [iter_check_login $lvl $nome_funz] 1]
#innes} else {
  # se la lista viene chiamata da un cerca, allora nome_funz non viene passato
  # e bisogna reperire id_utente dai cookie
    #set id_utente [ad_get_cookie iter_login_[ns_conn location]]
#innes    set id_utente [iter_get_id_utente]
#innes    if {$id_utente  == ""} {
#innes	set login [ad_conn package_url]
#innes        iter_return_complaint "Per accedere a questo programma devi prima eseguire la procedura di <a href=$login>Login.</a>"
#innes        return 0
#innes    }
#innes}

set login_cohesion_marche_p [parameter::get_from_package_key -package_key iter-portal -parameter login_cohesion_marche_p];#innes

set login_cittadino_p [parameter::get_from_package_key -package_key iter-portal -parameter login_cittadino_p];#innes

if {$login_cohesion_marche_p eq "1"} {#innes: aggiunta if, else e loro contenuto
    set codice_fiscale [iter::check_login_cohesion -nome_array_output array_cohesion -dbn_iter $dbn_iter -cod_impianto $cod_impianto]
    # Se in futuro ci sara' bisogno di altri campi useremo i valori di array_cohesion
} else {
    if {$login_cittadino_p} {
	set user_id [iter::script_init_cittadino]
    }
}

set id_utente "";#innes (dove e' rimasto l'utilizzo di id_utente, non serve)


iter_get_coimtgen -dbn $dbn_iter;#innes
set flag_ente    $coimtgen(flag_ente)
set denom_comune $coimtgen(denom_comune)
set sigla_prov   $coimtgen(sigla_prov)
set link         [export_ns_set_vars "url"]

set pack_key [iter_package_key]
set pack_dir [apm_package_url_from_key $pack_key]

switch $flag_ente {
    "P" {set directory "srcpers/$flag_ente$sigla_prov"}
    "C" {set directory "srcpers/$flag_ente$denom_comune"}
default {set "standard"}
}

if {[db_0or1row -dbn $dbn_iter sel_flag_tracciato_cimp ""] == 0} {
    iter_return_complaint "Rapporto di ispezione non trovato"
    return
}
#sim01 Aggiunto RI
switch $flag_tracciato {
    "AA" {set return_url $pack_dir/$directory/coimcimp-a-layout?$link}
    "AB" {set return_url $pack_dir/$directory/coimcimp-b-layout?$link}
    "RI" {set return_url $pack_dir/$directory/coimcimp-ri-layout?$link}
    "RE" {set return_url $pack_dir/$directory/coimcimp-re-layout?$link}
 default {set return_url $pack_dir/$directory/coimcimp-a-layout?$link}
}



ad_returnredirect $return_url


