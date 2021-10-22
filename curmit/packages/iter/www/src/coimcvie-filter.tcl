ad_page_contract {
    @author          Nicola Mortoni Adhoc
    @creation-date   17/04/2004

    @param caller    caller della lista da restituire alla lista:
                     serve se lista e' uno zoom che permette aggiungi.
    @param nome_funz identifica l'entrata di menu, serve per le autorizzazioni
                     serve se lista e' uno zoom che permette aggiungi.
    @cvs-id          coimviae-filter.tcl
} {
   {caller       "index"}
   {nome_funz         ""}
   {nome_funz_caller  ""}
   {receiving_element ""}
   {cod_comune        ""}
} -properties {
    page_title:onevalue
    context_bar:onevalue
    form_name:onevalue
}

# Controlla lo user
if {![string is space $nome_funz]} {
    set lvl        1
    set id_utente [lindex [iter_check_login $lvl $nome_funz] 1]
} else {
  # se il filtro viene chiamata da un cerca, allora nome_funz non viene passato
  # e bisogna reperire id_utente dai cookie
    #set id_utente [ad_get_cookie   iter_login_[ns_conn location]]
    set id_utente [iter_get_id_utente]
    if {$id_utente  == ""} {
	set login [ad_conn package_url]
        iter_return_complaint "Per accedere a questo programma devi prima eseguire la procedura di <a href=$login>Login.</a>"
        return 0
    }
}

# controllo il parametro di "propagazione" per la navigation bar
if {[string is space $nome_funz_caller]} {
    set nome_funz_caller $nome_funz
}


set fine {
    set link_list [export_url_vars caller nome_funz nome_funz_caller receiving_element cod_comune search_word]
    set return_url "coimcvie-list?$link_list"
    ad_returnredirect $return_url
    ad_script_abort
}

iter_get_coimtgen
set flag_ente $coimtgen(flag_ente)

#if {![string equal $cod_comune ""]} {
#    eval $fine
#}

# Personalizzo la pagina
set titolo       "Bonifica Viario"
set button_label "Seleziona"
set page_title   "Bonifica Viario"
if {$caller == "index"} {
    set context_bar [iter_context_bar -nome_funz $nome_funz_caller]
} else {
    set context_bar [iter_context_bar \
                    [list "javascript:window.close()" "Torna alla Gestione"] \
                    "$page_title"]
}

# sproteggo la chiave solo in inserimento e gli attributi in inserimento e mod.
set form_name    "coimcvie"
set readonly_key "readonly"
set readonly_fld "readonly"
set disabled_fld "disabled"
set onsubmit_cmd ""

set readonly_fld \{\}
set disabled_fld \{\}
form create $form_name \
-html    $onsubmit_cmd

if {$flag_ente == "C"} {
    element create $form_name f_cod_comune -widget hidden -datatype text -optional
} else {
    element create $form_name f_cod_comune \
    -label   "Comune" \
    -widget   select \
    -datatype text \
    -html    "$disabled_fld {} class form_element" \
    -optional \
    -options [iter_selbox_from_comu]
}
element create $form_name f_descrizione \
-label   "Descrizione Via" \
-widget   text \
-datatype text \
-html    "size 50 maxlength 50 $readonly_fld {} class form_element" \
-optional

element create $form_name caller      -widget hidden -datatype text -optional
element create $form_name nome_funz   -widget hidden -datatype text -optional
element create $form_name receiving_element -widget hidden -datatype text -optional
element create $form_name submit      -widget submit -datatype text -label "$button_label" -html "class form_submit"

if {[form is_request $form_name]} {
    element set_properties $form_name caller            -value $caller
    element set_properties $form_name nome_funz         -value $nome_funz
    element set_properties $form_name receiving_element -value $receiving_element
    if {$flag_ente == "C"} {
	element set_properties $form_name f_cod_comune -value $coimtgen(cod_comu)
    }

}

if {[form is_valid $form_name]} {
   # form valido dal punto di vista del templating system
    set f_cod_comune      [element::get_value $form_name f_cod_comune]
    set f_descrizione     [element::get_value $form_name f_descrizione]
#    ns_return 200 text/html $f_cod_comune; return
  # controlli standard su numeri e date, per Ins ed Upd
    set error_num 0
    if {[string equal $f_cod_comune ""]} {
        element::set_error $form_name f_cod_comune "Indicare il Comune"
        incr error_num
    }

    if {$error_num > 0} {
        ad_return_template
        return
    }

    set cod_comune  $f_cod_comune
    set search_word $f_descrizione
    eval $fine
}

ad_return_template
