ad_page_contract {
    @author          Katia Coazzoli Adhoc
    @creation-date   10/03/2004

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
   {receiving_element ""}
   {f_cognome         ""}
   {f_nome            ""}
   {f_data_inizio     ""}
   {f_data_fine       ""}
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
#   set id_utente [ad_get_cookie   iter_login_[ns_conn location]]
    set id_utente [iter_get_id_utente]
    if {$id_utente  == ""} {
	set login [ad_conn package_url]
	iter_return_complaint "Per accedere a questo programma devi prima eseguire la procedura di <a href=$login>Login.</a>"
	return 0
    }
}

# Personalizzo la pagina
set titolo       "Selezione terzi responsabili"
set button_label "Seleziona" 
set page_title   "Selezione terzi responsabili"

if {$caller == "index"} {
    set context_bar [iter_context_bar -nome_funz $nome_funz]                   
} else {
    set context_bar [iter_context_bar \
                    [list "javascript:window.close()" "Torna alla Gestione"] \
                    "$page_title"]
}

# sproteggo la chiave solo in inserimento e gli attributi in inserimento e mod.
set form_name    "coimcitt"
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

element create $form_name f_data_inizio \
-label   "Nome" \
-widget   text \
-datatype text \
-html    "size 10 maxlength 10 $readonly_fld {} class form_element" \
-optional

element create $form_name f_data_fine \
-label   "Nome" \
-widget   text \
-datatype text \
-html    "size 10 maxlength 10 $readonly_fld {} class form_element" \
-optional

element create $form_name funzione          -widget hidden -datatype text -optional
element create $form_name caller            -widget hidden -datatype text -optional
element create $form_name nome_funz         -widget hidden -datatype text -optional
element create $form_name receiving_element -widget hidden -datatype text -optional
element create $form_name dummy             -widget hidden -datatype text -optional
element create $form_name submit            -widget submit -datatype text -label "$button_label" -html "class form_submit"

if {[form is_request $form_name]} {
    element set_properties $form_name f_cognome         -value $f_cognome
    element set_properties $form_name f_nome            -value $f_nome
    element set_properties $form_name f_data_inizio     -value $f_data_inizio
    element set_properties $form_name f_data_fine       -value $f_data_fine
    element set_properties $form_name funzione          -value $funzione
    element set_properties $form_name caller            -value $caller
    element set_properties $form_name nome_funz         -value $nome_funz
    element set_properties $form_name receiving_element -value $receiving_element
}

if {[form is_valid $form_name]} {
    # form valido dal punto di vista del templating system
    set f_cognome       [string trim [element::get_value $form_name f_cognome]]
    set f_nome          [string trim [element::get_value $form_name f_nome]]
    set f_data_inizio   [string trim [element::get_value $form_name f_data_inizio]]
    set f_data_fine     [string trim [element::get_value $form_name f_data_fine]]

  # controlli standard su numeri e date, per Ins ed Upd
    set error_num 0
    if {![string equal $f_nome ""]
	&&  [string equal $f_cognome ""]
    } {
	element::set_error $form_name f_cognome "Oltre al nome va indicato anche il cognome"
	incr error_num
    }
    if {![string equal $f_data_inizio ""]} {
	set f_data_inizio [iter_check_date $f_data_inizio]
	if {$f_data_inizio == 0} {
	    element::set_error $form_name f_data_inizio "Inserire correttamente la data" 
	    incr error_num
	}
    }
    if {![string equal $f_data_fine ""]} {
	if {![string equal $f_data_inizio ""]} {
	    element::set_error $form_name f_data_fine "Non si pu&ograve; inserire entrambe le date" 
	    incr error_num
	} else {
	    set f_data_fine [iter_check_date $f_data_fine]
	    if {$f_data_fine == 0} {
		element::set_error $form_name f_data_fine "Inserire correttamente la data" 
		incr error_num
	    }
	}
    }

    if {$error_num > 0} {
        ad_return_template
        return
    }

    set link_list [export_url_vars caller nome_funz receiving_element f_cognome f_nome f_data_inizio f_data_fine]

    set return_url "coim_as_resp_admin-list?$link_list"

    ad_returnredirect $return_url
    ad_script_abort
}

ad_return_template
