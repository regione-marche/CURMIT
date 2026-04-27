ad_page_contract {
    Pagina di sfondo.

    @author Nicola Mortoni
    @date   01/10/2003

    @cvs_id master.tcl
} {
}

# posso valorizzare eventuali variabili tcl a disposizione del master
set logo_url    [iter_set_logo_dir_url]
set css_url     [iter_set_css_dir_url]
set package_url [ad_conn package_url]