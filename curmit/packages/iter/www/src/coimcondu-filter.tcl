ad_page_contract {
    @author          Gacalin Lufi
    @creation-date   12/04/2018

    @param funzione  V=view

    @param caller    caller della lista da restituire alla lista:
    @                serve se lista e' uno zoom che permetti aggiungi.

    @param nome_funz identifica l'entrata di menu, server per le autorizzazioni
    @                serve se lista e' uno zoom che permetti aggiungi.

    @cvs-id          coimcondu-filter.tcl
} {
    
   {funzione         "V"}
   {caller       "index"}
   {nome_funz         ""}
   {receiving_element ""}
   {f_cognome         ""}
   {f_nome            ""}
   {f_cod_fiscale     ""}
   {f_cod_conduttore  ""}
   {f_comune          ""}
   {flag_ammi         ""}
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
}

# Personalizzo la pagina
set titolo       "Selezione Soggetti"
set button_label "Seleziona" 
set page_title   "Selezione Soggetti"

if {$caller == "index"} {
    set context_bar [iter_context_bar -nome_funz $nome_funz]                   
} else {
    set context_bar [iter_context_bar \
                    [list "javascript:window.close()" "Torna alla Gestione"] \
                    "$page_title"]
}

# sproteggo la chiave solo in inserimento e gli attributi in inserimento e mod.
set form_name    "coimcondu"
set readonly_key "readonly"
set readonly_fld "readonly"
set disabled_fld "disabled"
set onsubmit_cmd ""

set readonly_fld \{\}
set disabled_fld \{\}
form create $form_name \
-html    $onsubmit_cmd

element create $form_name f_cod_conduttore \
-label   "Codice Soggetto Conduttore" \
-widget   text \
-datatype text \
-html    "size 10 maxlength 10 $readonly_fld {} class form_element" \
-optional

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

element create $form_name f_cod_fiscale \
-label   "Cod.Fisc./P.Iva" \
-widget   text \
-datatype text \
-html    "size 16 maxlength 16 $readonly_fld {} class form_element" \
-optional

element create $form_name f_comune \
-label   "Comune" \
-widget   text \
-datatype text \
-html    "size 30 maxlength 35 $readonly_fld {} class form_element" \
-optional

set link_comune [iter_search  coimcondu [ad_conn package_url]/tabgen/coimcomu-list [list dummy_1 dummy search_word f_comune dummy_2 dummy dummy_3 dummy]]

element create $form_name funzione          -widget hidden -datatype text -optional
element create $form_name caller            -widget hidden -datatype text -optional
element create $form_name nome_funz         -widget hidden -datatype text -optional
element create $form_name receiving_element -widget hidden -datatype text -optional
element create $form_name dummy             -widget hidden -datatype text -optional
element create $form_name submit            -widget submit -datatype text -label "$button_label" -html "class form_submit"
element create $form_name flag_ammi        -widget hidden -datatype text -optional

if {[form is_request $form_name]} {
    if {![string equal $f_cognome ""]} {
        element set_properties $form_name f_cognome         -value $f_cognome
    }
    if {![string equal $f_nome ""]} {
        element set_properties $form_name f_nome            -value $f_nome
    }

    element set_properties $form_name f_cognome          -value $f_cognome
    element set_properties $form_name f_nome             -value $f_nome  
    element set_properties $form_name f_cod_fiscale      -value $f_cod_fiscale
    element set_properties $form_name f_cod_conduttore    -value $f_cod_conduttore
    element set_properties $form_name f_comune           -value $f_comune
    element set_properties $form_name funzione           -value $funzione
    element set_properties $form_name caller             -value $caller
    element set_properties $form_name nome_funz          -value $nome_funz
    element set_properties $form_name receiving_element  -value $receiving_element
    element set_properties $form_name flag_ammi          -value $flag_ammi
}

if {[form is_valid $form_name]} {
    # form valido dal punto di vista del templating system
    
    set f_cod_conduttore [string trim [element::get_value $form_name f_cod_conduttore]]
    set f_cognome        [string trim [element::get_value $form_name f_cognome]]
    set f_nome           [string trim [element::get_value $form_name f_nome]]
    set f_cod_fiscale    [string trim [element::get_value $form_name f_cod_fiscale]]
    set f_comune         [string trim [element::get_value $form_name f_comune]]
    set flag_ammi        [element::get_value $form_name flag_ammi]
  # controlli standard su numeri e date, per Ins ed Upd
    set error_num 0

    if {$f_cod_conduttore eq "" && $f_cognome eq "" && $f_nome eq "" && $f_cod_fiscale eq "" && $f_comune eq ""} {
	element::set_error $form_name f_cod_conduttore " Indicare almeno un criterio di ricerca"
	incr error_num
    }

    if {$error_num > 0} {
        ad_return_template
        return
    }


    set link_list [export_url_vars caller nome_funz receiving_element f_cod_conduttore f_cognome f_nome f_cod_fiscale f_comune flag_ammi]

    set return_url "coimcondu-list?$link_list"

    ad_returnredirect $return_url
    ad_script_abort
}

ad_return_template
