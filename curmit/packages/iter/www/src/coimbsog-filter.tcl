ad_page_contract {
    @author          Giulio Laurenzi
    @creation-date   31/05/2005

    @param funzione  V=view
    @param caller    caller della lista da restituire alla lista:
                     serve se lista e' uno zoom che permetti aggiungi.
    @param nome_funz identifica l'entrata di menu, server per le autorizzazioni
                     serve se lista e' uno zoom che permetti aggiungi.
    @cvs-id          coimcitt-filter.tcl
} {
    
   {funzione         "V"}
   {caller       "index"}
   {nome_funz         ""}
   {nome_funz_caller  ""}
   {receiving_element ""}
   {f_cognome         ""}
   {f_nome            ""}
   {f_comune          ""}
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

# Personalizzo la pagina
set titolo       "Bonifica Soggetti"
set button_label "Seleziona" 
set page_title   "Bonifica Soggetti"

set context_bar [iter_context_bar -nome_funz $nome_funz_caller]


# sproteggo la chiave solo in inserimento e gli attributi in inserimento e mod.
set form_name    "coimbsog"
set readonly_key "readonly"
set readonly_fld "readonly"
set disabled_fld "disabled"
set onsubmit_cmd ""

set readonly_fld \{\}
set disabled_fld \{\}
form create $form_name \
-html    $onsubmit_cmd

element create $form_name f_cognome \
-label   "Cognome" \
-widget   text \
-datatype text \
-html    "size 40 maxlength 100 $readonly_fld {} class form_element" \
-optional

element create $form_name f_nome \
-label   "Nome" \
-widget   text \
-datatype text \
-html    "size 40 maxlength 100 $readonly_fld {} class form_element" \
-optional

element create $form_name f_comune \
-label   "Comune" \
-widget   text \
-datatype text \
-html    "size 30 maxlength 35 $readonly_fld {} class form_element" \
-optional

set link_comune [iter_search coimbsog [ad_conn package_url]tabgen/coimcomu-list [list dummy_1 dummy search_word f_comune dummy_2 dummy dummy_3 dummy]]

element create $form_name funzione    -widget hidden -datatype text -optional
element create $form_name caller      -widget hidden -datatype text -optional
element create $form_name nome_funz   -widget hidden -datatype text -optional
element create $form_name nome_funz_caller -widget hidden -datatype text -optional
element create $form_name dummy             -widget hidden -datatype text -optional
element create $form_name receiving_element -widget hidden -datatype text -optional
element create $form_name submit      -widget submit -datatype text -label "$button_label" -html "class form_submit"

if {[form is_request $form_name]} {
    if {![string equal $f_cognome ""]} {
        element set_properties $form_name f_cognome         -value $f_cognome
    }
    if {![string equal $f_nome ""]} {
        element set_properties $form_name f_nome            -value $f_nome
    }

    element set_properties $form_name f_cognome         -value $f_cognome
    element set_properties $form_name f_nome            -value $f_nome
    element set_properties $form_name f_comune          -value $f_comune
    element set_properties $form_name funzione          -value $funzione
    element set_properties $form_name caller            -value $caller
    element set_properties $form_name nome_funz         -value $nome_funz
    element set_properties $form_name nome_funz_caller  -value $nome_funz_caller
    element set_properties $form_name receiving_element -value $receiving_element
}

if {[form is_valid $form_name]} {
    # form valido dal punto di vista del templating system
    
    set f_cognome     [element::get_value $form_name f_cognome]
    set f_nome        [element::get_value $form_name f_nome]
    set f_comune      [element::get_value $form_name f_comune]

    # controlli standard su numeri e date, per Ins ed Upd
    set error_num 0

    set ctr_filter    0
    set first_element ""
    
    if {![string equal $f_nome ""]
    &&  [string equal $f_cognome ""]
    } {
	element::set_error $form_name f_cognome "Oltre al nome va indicato anche il cognome"
	incr error_num
    }

    if {$error_num > 0} {
        ad_return_template
        return
    }

    set link_list [export_url_vars caller nome_funz nome_funz_caller receiving_element f_cognome f_nome f_comune]

    set return_url "coimbsog-list?$link_list"

    ad_returnredirect $return_url
    ad_script_abort
}

ad_return_template
