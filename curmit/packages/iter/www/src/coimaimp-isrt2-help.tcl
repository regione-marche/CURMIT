ad_page_contract {
    Help inserimento veloce

    @author Giulio Laurenzi
    @date   21/02/2006

    @cvs_id coiminco-help.tcl
} {
}

iter_get_coimtgen
# posso valorizzare eventuali variabili tcl a disposizione del master
set logo_url [iter_set_logo_dir_url]
set css_url  [iter_set_css_dir_url]

ad_return_template
