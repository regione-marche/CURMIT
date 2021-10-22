ad_page_contract {
    Pagina di sfondo.

    @author Giulio Laurenzi
    @date   18/03/2004

    @cvs_id coiminco-help.tcl

    USER  DATA       MODIFICHE
    ===== ========== ==========================================================================
    rom01 09/09/2021 Aggiunto parametro link_caller, in base a come arriva valorizzato
    rom01            al programma mostro o meno il testo contenuto nell adp.

} {
    {link_caller   ""}
}

iter_get_coimtgen
set flag_ente   $coimtgen(flag_ente)
set flag_viario $coimtgen(flag_viario)
# posso valorizzare eventuali variabili tcl a disposizione del master
set logo_url [iter_set_logo_dir_url]
set css_url  [iter_set_css_dir_url]

ad_return_template
