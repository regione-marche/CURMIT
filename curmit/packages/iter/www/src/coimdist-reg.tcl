ad_page_contract {
    Login utente
    @author        Nicola Mortoni
    @creation_date 30/10/2002

    @cvs-id index.tcl
} -properties {
    page_title:onevalue
    context_bar:onevalue
}

set page_title   "Controllo esistenza"
set context_bar  "&nbsp;"
set form_name    "distributore"

form create $form_name

element create $form_name cod_fisc \
-label "Codice fiscale" \
-widget text \
-datatype text \
-html {size 16 maxlength 16}

element create $form_name submit \
-label "Conferma" \
-widget submit \
-datatype text



if {[form is_valid $form_name]} {

  # form valido dal punto di vista del templating system

    set cod_fisc     [element::get_value $form_name cod_fisc]

    set error_num 0
    set flag_funzione "I"
    if {![string equal $cod_fisc ""]} {
	if {[db_0or1row sel_cod_fisc ""] == 1} {
	    if {![string equal $id_utente ""]} {
		incr error_num
		element::set_error $form_name cod_fisc "Codice fiscale gi&agrave; inserito"
	    } else {
		set flag_funzione "M"
	    }
	} else {
	    if {[string length $cod_fisc] == 16
	      ||[string length $cod_fisc] == 11} {
		#ok
	    } else {
		incr error_num
		element::set_error $form_name cod_fisc "Il codice fiscale pu&ograve; essere lungo 16 o 11 caratteri"
	    }
	}
    } else {
#	incr error_num
#	element::set_error $form_name cod_fisc "Inserisci codice fiscale"
    }	

    if {$error_num > 0} {
        ad_return_template
        return
    }
 

    if {$flag_funzione == "I"} {
	ad_returnredirect "coimdist-ins?&cod_fisc=$cod_fisc&funzione=I"
    } else {
	ad_returnredirect "coimdist-ins?&cod_fisc=$cod_fisc&cod_distr=$cod_distr&funzione=M"
    }

    ad_script_abort
}

ad_return_template
