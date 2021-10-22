ad_page_contract {
    Pagina di sfondo.

    @author Luca Romitti
    @date   09/08/2018

    @cvs_id coimgend-ins-help.tcl

    USER  DATA       MODIFICHE
    ===== ========== ====================================================================================
    rom01 25/06/2021 Ricevo e uso il flag_tipo_impianto per mostrare la dicitura corretta in base alla
    rom01            tipologia di impianto che richiama il pop-up.

} {
    {caller ""}
    {flag_tipo_impianto ""}
}

iter_get_coimtgen
set flag_ente   $coimtgen(flag_ente)
set flag_viario $coimtgen(flag_viario)
# posso valorizzare eventuali variabili tcl a disposizione del master
set logo_url [iter_set_logo_dir_url]
set css_url  [iter_set_css_dir_url]

set dicitura_impianto "Pi&ugrave; generatori";#rom01

switch $flag_tipo_impianto {

    "R" {
	set dicitura_impianto "Pi&ugrave; gruppi termici o generatori"
    }
    "F" {
	set dicitura_impianto "Pi&ugrave; gruppi frigo o pompe di calore"
    }
    "T" {
	set dicitura_impianto "Pi&ugrave; scambiatori di calore"
    }
    "C" {
	set dicitura_impianto "Pi&ugrave; cogeneratori o trigeneratori"
    }
};#rom01






ad_return_template
