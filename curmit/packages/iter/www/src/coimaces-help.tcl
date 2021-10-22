ad_page_contract {
    Pagina di sfondo.

    @author Katia Coazzoli
    @date   11/05/2004

    @cvs_id coimaces-help.tcl
} {
}

iter_get_coimtgen
set flag_ente   $coimtgen(flag_ente)
set flag_viario $coimtgen(flag_viario)
# posso valorizzare eventuali variabili tcl a disposizione del master
set logo_url [iter_set_logo_dir_url]
set css_url  [iter_set_css_dir_url]

ad_return_template
