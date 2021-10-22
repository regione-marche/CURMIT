ad_page_contract {
    Pagina di sfondo.

    @author Luca Romitti
    @date   09/08/2018

    @cvs_id coiminco-help.tcl
} {
    {cod_impianto      ""}
    {last_cod_impianto ""}
    {nome_funz         ""}
    {nome_funz_caller  ""}
    {extra_par         ""}
    {caller            ""}
    {flag_assegnazione ""}
    {url_list_aimp     ""}
    {url_aimp          ""}
    {funzione "V"}
    {cod_impianto_old   ""}
} -properties {
    context_bar:onevalue
    form_name:onevalue
}

iter_get_coimtgen
set flag_ente   $coimtgen(flag_ente)
set flag_viario $coimtgen(flag_viario)
# posso valorizzare eventuali variabili tcl a disposizione del master
set logo_url [iter_set_logo_dir_url]
set css_url  [iter_set_css_dir_url]
if {$caller eq "seleziona"} {
    set page_title "Conferma selezione Impianto"
    set titolo     "Conferma selezione Impianto"
} elseif {$caller eq "inserimento"} {
    set page_title "Conferma inserimento Impianto"
    set titolo     "Conferma inserimento Impianto"
} elseif {$caller eq "acquisizione"} {
    set page_title "Conferma acquisizione Impianto"
    set titolo     "Conferma acquisizione Impianto"
} else {
    set page_title "Conferma l'Impianto"
    set titolo     "Conferma l'Impianto"
}
set link_tab [iter_links_form $cod_impianto $nome_funz_caller $url_list_aimp $url_aimp $extra_par]
set dett_tab [iter_tab_form $cod_impianto]

set context_bar  [iter_context_bar \
		      [list "/../iter/main" "Home"] \
		      [list $url_list_aimp  "Lista Impianti"] \
		      "$page_title"]

set classe       "func-menu"
set form_name    "coimaimp"
set link    [export_url_vars cod_impianto last_cod_impianto nome_funz nome_funz_caller extra_par url_list_aimp]

if {$caller eq "acquisizione"} {
    set gest_prog "coimaimp-tecn"
    set return_url      "$gest_prog?$link&funzione=A"
} else {
    set gest_prog       "coimaimp-gest"
    set return_url      "$gest_prog?$link"
}

ad_return_template
