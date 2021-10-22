ad_page_contract {
    Pagina di sfondo.

    @author Katia Coazzoli
    @date   10/03/2004

    @cvs_id coimcitt-help.tcl
} {
}

# posso valorizzare eventuali variabili tcl a disposizione del master
set logo_url [iter_set_logo_dir_url]
set css_url  [iter_set_css_dir_url]

ad_return_template
