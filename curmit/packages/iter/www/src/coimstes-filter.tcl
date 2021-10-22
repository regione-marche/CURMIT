ad_page_contract {
    @author          Giulio Laurenzi
    @creation-date   12/09/2005

    @param funzione  V=view
    @param caller    caller della lista da restituire alla lista:
                     serve se lista e' uno zoom che permetti aggiungi.
    @param nome_funz identifica l'entrata di menu, server per le autorizzazioni
                     serve se lista e' uno zoom che permetti aggiungi.
    @cvs-id          coiminco-filter.tcl
} {  
   {f_campagna        ""}
   {f_tipo_stat       ""}
   {caller       "index"}
   {funzione         "V"}
   {nome_funz         ""}
   {nome_funz_caller  ""}
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
set titolo       "Parametri per riepilogo estrazione incontri"
set button_label "Seleziona"
set page_title   "Parametri per riepilogo estrazione incontri"

iter_get_coimtgen
set flag_ente $coimtgen(flag_ente)

set context_bar  [iter_context_bar -nome_funz $nome_funz_caller] 

# sproteggo la chiave solo in inserimento e gli attributi in inserimento e mod.
set form_name    "coimstes"
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

element create $form_name f_campagna \
-label   "data inizio" \
-widget   select \
-datatype text \
-html    "$disabled_fld {} class form_element" \
-optional \
-options [iter_selbox_from_table coimcinc cod_cinc descrizione]

element create $form_name f_tipo_stat \
-label   "Tipo statistica" \
-widget   select \
-datatype text \
-html    "$disabled_fld {} class form_element" \
-optional \
-options {{"Per Comune" C} {"Per Verificatore" V}}


element create $form_name funzione    -widget hidden -datatype text -optional
element create $form_name caller      -widget hidden -datatype text -optional
element create $form_name nome_funz   -widget hidden -datatype text -optional
element create $form_name submit      -widget submit -datatype text -label "$button_label" -html "class form_submit"

if {[form is_request $form_name]} {
    if {[db_0or1row sel_cinc_att ""] == 0} {
	set cod_cinc_att ""
    }
    element set_properties $form_name f_campagna     -value $cod_cinc_att
    element set_properties $form_name f_tipo_stat    -value $f_tipo_stat

    element set_properties $form_name funzione       -value $funzione
    element set_properties $form_name caller         -value $caller
    element set_properties $form_name nome_funz      -value $nome_funz
}

if {[form is_valid $form_name]} {
    # form valido dal punto di vista del templating system
    set f_campagna    [element::get_value $form_name f_campagna]
    set f_tipo_stat   [element::get_value $form_name f_tipo_stat]
   
    set error_num 0
    
    if {[string equal $f_campagna ""]} {
	element::set_error $form_name f_campagna "Inserire la campagna"
	incr error_num
    }

    if {[string equal $f_tipo_stat "" ]} {
	element::set_error $form_name f_tioi_stat "Inserire il tipo statistica"
	incr error_num
    } 

    if {$error_num > 0} {
        ad_return_template
        return
    }

    set link [export_url_vars f_tipo_stat f_campagna caller funzione nome_funz nome_funz_caller]

    set return_url "coimstes-gest?$link"    
    ad_returnredirect $return_url
    ad_script_abort
}

ad_return_template
