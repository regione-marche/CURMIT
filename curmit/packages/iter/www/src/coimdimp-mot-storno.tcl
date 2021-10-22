ad_page_contract {
    Pagina di sfondo.

    @author Luca Romitti
    @date   29/10/2018

    @cvs_id coimdimp-mot-storno.tcl
} {
    {cod_impianto ""}
    {cod_dimp     ""}
}
iter_get_coimtgen
set flag_ente   $coimtgen(flag_ente)
set flag_viario $coimtgen(flag_viario)
# posso valorizzare eventuali variabili tcl a disposizione del master
set logo_url [iter_set_logo_dir_url]
set css_url  [iter_set_css_dir_url]

db_1row q "select motivo_storno
             from coimdimp
            where cod_dimp     = :cod_dimp
              and cod_impianto = :cod_impianto"

ad_return_template
