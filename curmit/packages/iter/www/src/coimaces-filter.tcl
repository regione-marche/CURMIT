ad_page_contract {
    @author          Katia Coazzoli Adhoc
    @creation-date   11/05/2004

    @param funzione  V=view
    @param caller    caller della lista da restituire alla lista:
                     serve se lista e' uno zoom che permetti aggiungi.
    @param nome_funz identifica l'entrata di menu, server per le autorizzazioni
                     serve se lista e' uno zoom che permetti aggiungi.
    @cvs-id          coimaces-filter.tcl
} {
    
   {funzione          "V"}
   {caller        "index"}
   {nome_funz          ""}
   {nome_funz_caller   ""} 
   {f_indirizzo        ""}
} -properties {
    page_title:onevalue
    context_bar:onevalue
    form_name:onevalue
}

# Controlla lo user
set lvl 1
set id_utente [lindex [iter_check_login $lvl $nome_funz] 1]

# controllo il parametro di "propagazione" per la navigation bar
if {[string is space $nome_funz_caller]} {
    set nome_funz_caller $nome_funz
}

# Personalizzo la pagina
set titolo       "Selezione impianti acquisiti esternamente"
set button_label "Seleziona" 
set page_title   "Selezione impianti acquisiti esternamente"

iter_get_coimtgen
set flag_ente    $coimtgen(flag_ente)
set flag_viario  $coimtgen(flag_viario)
set cod_comune   $coimtgen(cod_comu)
set context_bar  [iter_context_bar -nome_funz $nome_funz_caller] 

# sproteggo la chiave solo in inserimento e gli attributi in inserimento e mod.
set form_name    "coimaces"
set readonly_key "readonly"
set readonly_fld "readonly"
set disabled_fld "disabled"
set onsubmit_cmd ""

set readonly_fld \{\}
set disabled_fld \{\}
form create $form_name \
-html    $onsubmit_cmd

element create $form_name f_cod_aces_est \
-label   "Codice_utenza" \
-widget   text \
-datatype text \
-html    "size 15 maxlength 15 $readonly_fld {} class form_element" \
-optional

set l_of_l [db_list_of_lists sel_lol_2 ""]
set options_cod_acts [linsert $l_of_l 0 [list "" ""]]

element create $form_name f_cod_acts \
-label   "Testata" \
-widget   select \
-datatype text \
-html    "$readonly_fld {} class form_element" \
-optional \
-options $options_cod_acts

if {$flag_ente == "P"} {
    element create $form_name f_comune \
    -label   "Comune" \
    -widget   select \
    -datatype text \
    -html    "$disabled_fld {} class form_element tabindex 3" \
    -optional \
    -options [iter_selbox_from_comu]
} else {
    element create $form_name f_comune -widget hidden -datatype text -optional
}

element create $form_name f_indirizzo \
-label   "Via" \
-widget   text \
-datatype text \
-html    "size 25 maxlength 40 $readonly_fld {} class form_element tabindex 5" \
-optional

element create $form_name f_natura_giuridica \
-label   "Natura_giuridica" \
-widget   select \
-datatype text \
-html    " $readonly_fld {} class form_element" \
-options {{{} {}} {Fisica F} {Giuridica G}} \
-optional

element create $form_name f_cognome \
-label   "Cognome" \
-widget   text \
-datatype text \
-html    "size 40 maxlength 36 $readonly_fld {} class form_element" \
-optional

element create $form_name f_cod_combustibile \
-label   "Cod_combustibile" \
-widget   select \
-datatype text \
-html    "$readonly_fld {} class form_element" \
-options [iter_selbox_from_table coimcomb cod_combustibile descr_comb] \
-optional

element create $form_name f_stato \
-label   "Stato" \
-widget   select \
-datatype text \
-html    "$readonly_fld {} class form_element" \
-options {{{Da analizzare} D} {{Invariato su catasto} I} {{Record scartato} S} {{Caricato su catasto} P} {{Gi&agrave; segnalato} E} {{Variato su catasto} V}} \
-optional

element create $form_name funzione    -widget hidden -datatype text -optional
element create $form_name caller      -widget hidden -datatype text -optional
element create $form_name nome_funz   -widget hidden -datatype text -optional
element create $form_name submit      -widget submit -datatype text -label "$button_label" -html "class form_submit"


if {[form is_request $form_name]} {
    if {$flag_ente == "C"} {
	element set_properties $form_name f_comune   -value $cod_comune
    }

    element set_properties $form_name funzione       -value $funzione
    element set_properties $form_name caller         -value $caller
    element set_properties $form_name nome_funz      -value $nome_funz
    element set_properties $form_name f_indirizzo    -value $f_indirizzo
}

if {[form is_valid $form_name]} {
    # form valido dal punto di vista del templating system
    
    set f_cod_aces_est     [element::get_value $form_name f_cod_aces_est]
    set f_cod_acts         [element::get_value $form_name f_cod_acts]
    set f_comune           [element::get_value $form_name f_comune]
    set f_natura_giuridica [element::get_value $form_name f_natura_giuridica]
    set f_cognome          [element::get_value $form_name f_cognome]
    set f_cod_combustibile [element::get_value $form_name f_cod_combustibile]
    set f_stato            [element::get_value $form_name f_stato]
    set f_indirizzo        [element::get_value $form_name f_indirizzo]
    set error_num 0 

    if { [string equal $f_cod_acts ""]
     && ![string equal $f_cod_aces_est ""]} {
	 element::set_error $form_name f_cod_acts "Valorizzare il codice dichiarazione assieme al codice utenza"
	 incr error_num
    }

    if {$error_num > 0} {
        ad_return_template
        return
    }
    
    set link_list [export_url_vars f_cod_aces_est f_cod_acts f_comune f_indirizzo f_cognome f_natura_giuridica f_cod_combustibile f_stato caller funzione nome_funz]

    set return_url "coimaces-list?$link_list"    
    
    ad_returnredirect $return_url
    ad_script_abort
}

ad_return_template
