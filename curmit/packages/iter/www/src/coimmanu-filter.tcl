ad_page_contract {
    @author          Valentina Catte Adhoc
    @creation-date   10/03/2004

    @param funzione  V=view
    @param caller    caller della lista da restituire alla lista:
                     serve se lista e' uno zoom che permetti aggiungi.
    @param nome_funz identifica l'entrata di menu, server per le autorizzazioni
                     serve se lista e' uno zoom che permetti aggiungi.
    @cvs-id          coimmanu-filter.tcl
} {
    
   {funzione         "V"}
   {caller       "index"}
   {nome_funz         ""}
   {receiving_element ""}
   {f_cod_manutentore ""}
   {f_nome            ""}
   {f_cognome         ""}
   {f_ruolo           ""}
   {f_convenzionato   ""}
   {f_stato           ""}
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

# Personalizzo la pagina
set titolo       "Selezione Manutentori"
set button_label "Seleziona" 
set page_title   "Selezione Manutentori"

if {$caller == "index"} {
    set context_bar [iter_context_bar -nome_funz $nome_funz]                   
} else {
    set context_bar [iter_context_bar \
                    [list "javascript:window.close()" "Torna alla Gestione"] \
                    "$page_title"]
}

# sproteggo la chiave solo in inserimento e gli attributi in inserimento e mod.
set form_name    "coimmanu"
set readonly_key "readonly"
set readonly_fld "readonly"
set disabled_fld "disabled"
set onsubmit_cmd ""

set readonly_fld \{\}
set disabled_fld \{\}
form create $form_name \
-html    $onsubmit_cmd

element create $form_name f_cod_manutentore \
-label   "Codice Manutentore" \
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

element create $form_name f_ruolo \
-label   "Ruolo" \
-widget   select \
-datatype text \
-html    "$disabled_fld {} class form_element" \
-optional \
-options {{{} {}} {Manutentore M} {Installatore I} {Manutentore/Installatore T}}

element create $form_name f_convenzionato \
-label   "Convenzionato" \
-widget   select \
-datatype text \
-html    "$disabled_fld {} class form_element" \
-optional \
-options {{{} {}} {Si S} {No N}}

element create $form_name f_stato \
-label   "Stato" \
-widget   select \
-datatype text \
-html    "$disabled_fld {} class form_element" \
-optional \
    -options {{{} {}} {{In attivit&agrave;} A} {Cessato C}}

element create $form_name funzione    -widget hidden -datatype text -optional
element create $form_name caller      -widget hidden -datatype text -optional
element create $form_name nome_funz   -widget hidden -datatype text -optional
element create $form_name receiving_element -widget hidden -datatype text -optional
element create $form_name submit      -widget submit -datatype text -label "$button_label" -html "class form_submit"

if {[form is_request $form_name]} {
    if {![string equal $f_cognome ""]} {
        element set_properties $form_name f_cognome         -value $f_cognome
    }
    if {![string equal $f_nome ""]} {
        element set_properties $form_name f_nome            -value $f_nome
    }

    element set_properties $form_name f_cod_manutentore -value $f_cod_manutentore
    element set_properties $form_name f_cognome         -value $f_cognome
    element set_properties $form_name f_nome            -value $f_nome  
    element set_properties $form_name f_ruolo           -value $f_ruolo
    element set_properties $form_name f_convenzionato   -value $f_convenzionato  
    element set_properties $form_name f_stato           -value $f_stato
    element set_properties $form_name funzione          -value $funzione
    element set_properties $form_name caller            -value $caller
    element set_properties $form_name nome_funz         -value $nome_funz
    element set_properties $form_name receiving_element -value $receiving_element
}

if {[form is_valid $form_name]} {
    # form valido dal punto di vista del templating system
    
    set f_cod_manutentore [string trim [element::get_value $form_name f_cod_manutentore]]
    set f_cognome         [string trim [element::get_value $form_name f_cognome]]
    set f_nome            [string trim [element::get_value $form_name f_nome]]
    set f_ruolo           [string trim [element::get_value $form_name f_ruolo]]
    set f_convenzionato   [string trim [element::get_value $form_name f_convenzionato]]
    set f_stato           [string trim [element::get_value $form_name f_stato]]

  # controlli standard su numeri e date, per Ins ed Upd
    set error_num 0

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

    set link_list [export_url_vars caller nome_funz receiving_element f_cod_manutentore f_cognome f_nome f_ruolo f_convenzionato f_stato]

    set return_url "coimmanu-list?$link_list&flag_filter=S"

    ad_returnredirect $return_url
    ad_script_abort
}

ad_return_template
