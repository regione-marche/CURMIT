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
    {maintainer_id     ""}
    {name              ""}
    {wallet_id         ""}
    {body_id           ""}
    {from_date         ""}
    {from_date_ansi    ""}
    {to_date           ""}
    {to_date_ansi      ""}
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
set titolo       "Selezione Movimenti"
set button_label "Seleziona" 
set page_title   "Selezione Movimenti"

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

set body_id ""
set body_options [db_list_of_lists query "
            select body_name
                 , body_id
            from wal_bodies
            order by body_name"]

#lappend body_options {"Tutti" ""}

set readonly_fld \{\}
set disabled_fld \{\}
form create $form_name \
    -html    $onsubmit_cmd

element create $form_name maintainer_id \
    -label   "Codice Manutentore" \
    -widget   text \
    -datatype text \
    -html    "size 10 maxlength 10 $readonly_fld {} class form_element" \
    -optional

element create $form_name name \
    -label   "Nominativo Manutentore" \
    -widget   text \
    -datatype text \
    -html    "size 40 maxlength 100 $readonly_fld {} class form_element" \
    -optional

element create $form_name wallet_id \
    -label   "Cod portafoglio" \
    -widget   text \
    -datatype text \
    -html    "size 40 maxlength 100 $readonly_fld {} class form_element" \
    -optional

element create $form_name body_id \
    -label   "Ruolo" \
    -widget   select \
    -datatype text \
    -html    "$disabled_fld {} class form_element" \
    -optional \
    -options  "{{Tutti} {}} $body_options"

element create $form_name from_date \
    -label   "Da data movimento" \
    -widget   text \
    -datatype text \
    -html    "$disabled_fld {} class form_element" \
    -optional 

element create $form_name to_date \
    -label   "A data movimento" \
    -widget   text \
    -datatype text \
    -html    "$disabled_fld {} class form_element" \
    -optional 

element create $form_name funzione    -widget hidden -datatype text -optional
element create $form_name caller      -widget hidden -datatype text -optional
element create $form_name nome_funz   -widget hidden -datatype text -optional
element create $form_name receiving_element -widget hidden -datatype text -optional
element create $form_name submit      -widget submit -datatype text -label "$button_label" -html "class form_submit"

if {[form is_request $form_name]} {
    
    if {$from_date eq ""} {
	set from_date      [db_string from "select to_char(current_date - interval '1 month', 'DD/MM/YYYY')"]
	set from_date_ansi [db_string ansi "select to_char(current_date - interval '1 month', 'YYYY-MM-DD')"]
    }

    if {$to_date eq ""} {
	set to_date        [ah::today_pretty]
	set to_date_ansi   [ah::today_ansi]
    }
    
    element set_properties $form_name maintainer_id     -value $maintainer_id    
    element set_properties $form_name name              -value $name
    element set_properties $form_name wallet_id         -value $wallet_id 
    element set_properties $form_name body_id           -value $body_id
    element set_properties $form_name from_date         -value $from_date        
    element set_properties $form_name to_date           -value $to_date
    element set_properties $form_name funzione          -value $funzione
    element set_properties $form_name caller            -value $caller
    element set_properties $form_name nome_funz         -value $nome_funz
    element set_properties $form_name receiving_element -value $receiving_element
}

if {[form is_valid $form_name]} {
    # form valido dal punto di vista del templating system
    
    set maintainer_id     [string trim [element::get_value $form_name maintainer_id]]
    set name              [string trim [element::get_value $form_name name]]
    set wallet_id         [string trim [element::get_value $form_name wallet_id]]
    set body_id           [string trim [element::get_value $form_name body_id]]
    set from_date         [string trim [element::get_value $form_name from_date]]
    set to_date           [string trim [element::get_value $form_name to_date]]
    
    # controlli standard su numeri e date, per Ins ed Upd
    set error_num 0
    
    set errnum 0
    
    if {$from_date eq ""} {
	set from_date "01/01/2008"
    }
    
    if {$to_date eq ""} {
	set to_date "01/01/2100"
    }
    
    set from_date_ansi [ah::check_date -ansi -input_date $from_date]
    if {$from_date_ansi == 0} {
	template::form::set_error filter from_date "Data inizio errata."
	incr errnum
    }
    set to_date_ansi [ah::check_date -ansi -input_date $to_date]
    if {$to_date_ansi == 0} {
	template::form::set_error filter to_date "Data fine errata."
	incr errnum
    }
    
    if {$error_num > 0} {
        ad_return_template
        return
    }
    
    set f_name $name
    set f_maintainer_id $maintainer_id
    set link_list [export_url_vars caller nome_funz receiving_element f_maintainer_id f_name wallet_id body_id from_date from_date_ansi to_date to_date_ansi]
    
    set return_url "transactions?$link_list"
    
    ad_returnredirect $return_url
    ad_script_abort
}

ad_return_template
