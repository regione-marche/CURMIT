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
set form_name    "coimcitt"
set readonly_key "readonly"
set readonly_fld "readonly"
set disabled_fld "disabled"
set onsubmit_cmd ""

set readonly_fld \{\}
set disabled_fld \{\}
form create $form_name \
-html    $onsubmit_cmd

element create $form_name f_cod_cittadino \
-label   "Codice Soggetto" \
-widget   text \
-datatype text \
-html    "size 10 maxlength 10 $readonly_fld {} class form_element" \
-optional

element create $form_name f_cognome \
-label   "Cognome" \
-widget   text \
-datatype text \
-html    "size 20 maxlength 100 $readonly_fld {} class form_element" \
-optional

element create $form_name f_nome \
-label   "Nome" \
-widget   text \
-datatype text \
-html    "size 20 maxlength 100 $readonly_fld {} class form_element" \
-optional

element create $form_name f_cod_fiscale \
-label   "Cod.Fisc./P.Iva" \
-widget   text \
-datatype text \
-html    "size 16 maxlength 16 $readonly_fld {} class form_element" \
-optional

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

    element set_properties $form_name funzione          -value $funzione
    element set_properties $form_name caller            -value $caller
    element set_properties $form_name nome_funz         -value $nome_funz
    element set_properties $form_name receiving_element -value $receiving_element
}

if {[form is_valid $form_name]} {
    # form valido dal punto di vista del templating system
    
    set f_cod_cittadino [element::get_value $form_name f_cod_cittadino]
    set f_cognome       [element::get_value $form_name f_cognome]
    set f_nome          [element::get_value $form_name f_nome]
    set f_cod_fiscale   [element::get_value $form_name f_cod_fiscale]

  # controlli standard su numeri e date, per Ins ed Upd
    set error_num 0

    set ctr_filter    0
    set first_element ""

    if {![string equal $f_cod_fiscale ""]} {
        incr ctr_filter
        set first_element "f_cod_fiscale"
    }
    if {(![string equal $f_cognome ""]
    ||   ![string equal $f_nome ""])
    } {
        incr ctr_filter
        set first_element "f_cognome"
    }
    if {![string equal $f_cod_cittadino ""]} {
        incr ctr_filter
        set first_element "f_cod_cittadino"
    }

    if {$ctr_filter == 0} {
        element::set_error $form_name f_cod_cittadino "Indicare almeno un criterio di ricerca"
        incr error_num
    }

    if {$ctr_filter > 1} {
        element::set_error $form_name $first_element  "La ricerca pu&ograve; essere effettuata per un solo criterio di selezione"
        incr error_num
    }

    if {$ctr_filter == 1} {
	if {![string equal $f_nome ""]
	    &&  [string equal $f_cognome ""]
	} {
	    element::set_error $form_name f_cognome "Oltre al nome va indicato anche il cognome"
	    incr error_num
	}
    }

    if {$error_num > 0} {
        ad_return_template
        return
    }

    set link_list [export_url_vars caller nome_funz receiving_element f_cod_cittadino f_cognome f_nome f_cod_fiscale]

    set return_url "coimcitt-list-palm?$link_list"

    ad_returnredirect $return_url
    ad_script_abort
}

ad_return_template
