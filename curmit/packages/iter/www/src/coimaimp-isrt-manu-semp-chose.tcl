ad_page_contract {
    @author          Giulio Laurenzi
    @creation-date   11/05/2004

    @param funzione  V=view
    @param caller    caller della lista da restituire alla lista:
                     serve se lista e' uno zoom che permetti aggiungi.
    @param nome_funz identifica l'entrata di menu, server per le autorizzazioni
                     serve se lista e' uno zoom che permetti aggiungi.
    @cvs-id           coimaimp-isrt-manu-chose.tcl
} {  
    {funzione             "I"}
    {caller          "index"}
    {nome_funz            ""}
    {nome_funz_caller     ""}
    {flag_tipo_impianto       ""}
} -properties {
    page_title:onevalue
    context_bar:onevalue
    form_name:onevalue
}

# Controlla lo user
switch $funzione {
    "V" {set lvl 1}
    "I" {set lvl 2}
    "M" {set lvl 3}
    "D" {set lvl 4}
}

set id_utente [lindex  [iter_check_login $lvl $nome_funz] 1]

# controllo il parametro di "propagazione" per la navigation bar
if {[string is space $nome_funz_caller]} {
    set nome_funz_caller $nome_funz
}

# Personalizzo la pagina
set titolo       "Scelta tipologia impianto"
set button_label "Seleziona"
set page_title   "Scelta tipologia impianto"

iter_get_coimtgen
set flag_ente $coimtgen(flag_ente)

set context_bar  [iter_context_bar -nome_funz $nome_funz_caller] 

# sproteggo la chiave solo in inserimento e gli attributi in inserimento e mod.
set form_name "coimaimp"
set focus_field  ""
set readonly_key "readonly"
set readonly_fld "readonly"
set disabled_fld "disabled"
set onsubmit_cmd ""

iter_get_coimtgen
set flag_viario $coimtgen(flag_viario)

set readonly_fld \{\}
set disabled_fld \{\}
form create $form_name \
    -html    $onsubmit_cmd

element create $form_name flag_tipo_impianto \
    -label   "flag_tipo_impianto" \
    -widget   select \
    -datatype text \
    -html   "class form_element" \
    -optional \
    -options {{Riscaldamento R} {Raffreddamento F} {Cogenerazione C} {Teleriscaldamento T}}

element create $form_name funzione    -widget hidden -datatype text -optional
element create $form_name caller      -widget hidden -datatype text -optional
element create $form_name nome_funz   -widget hidden -datatype text -optional
element create $form_name nome_funz_caller -widget hidden -datatype text -optional
element create $form_name dummy       -widget hidden -datatype text -optional
element create $form_name submit      -widget submit -datatype text -label "$button_label" -html "class form_submit"


if {[form is_request $form_name]} {
    
    element set_properties $form_name funzione       -value $funzione
    element set_properties $form_name caller         -value $caller
    element set_properties $form_name nome_funz      -value $nome_funz
    element set_properties $form_name nome_funz_caller -value $nome_funz_caller
}

if {[form is_valid $form_name]} {
    #form valido dal punto di vista del templating system

    set flag_tipo_impianto [element::get_value $form_name flag_tipo_impianto]

    if { $flag_tipo_impianto == "R"} {
	set return_url "coimaimp-isrt-manu-semp"
    }
    if { $flag_tipo_impianto == "F"} {
	set return_url "coimaimp-isrt-manu-semp-fr"
    }
    if { $flag_tipo_impianto == "T"} {
        set return_url "coimaimp-isrt-manu-semp-te"
    }
    if { $flag_tipo_impianto == "C"} {
        set return_url "coimaimp-isrt-manu-semp-co"
    }

    set link [export_url_vars  flag_tipo_impianto nome_funz nome_funz_caller]
    
    set return_url "$return_url?$link"    
    
    ad_returnredirect $return_url 
    ad_script_abort
}

ad_return_template
