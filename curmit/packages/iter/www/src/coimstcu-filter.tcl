ad_page_contract {

    @creation-date   10/05/2004

    @param funzione  V=view
    @param caller    caller della lista da restituire alla lista:
                     serve se lista e' uno zoom che permetti aggiungi.
    @param nome_funz identifica l'entrata di menu, server per le autorizzazioni
                     serve se lista e' uno zoom che permetti aggiungi.
    @cvs-id          coiminco-filter.tcl
} {  
   {f_stato           ""}
   {f_comune          ""}
   {f_escludi         ""}
   {f_da_impianto     ""}
   {f_a_impianto      ""}
   {id_stampa         ""}
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
set titolo       "Parametri per stampa comunicazione utenti"
set button_label "Seleziona"
set page_title   "Parametri per stampa comunicazione utenti"

iter_get_coimtgen
set flag_ente $coimtgen(flag_ente)

set context_bar  [iter_context_bar -nome_funz $nome_funz_caller] 

# sproteggo la chiave solo in inserimento e gli attributi in inserimento e mod.
set form_name    "coimstcu"
set readonly_key "readonly"
set readonly_fld "readonly"
set disabled_fld "disabled"
set onsubmit_cmd ""

set readonly_fld \{\}
set disabled_fld \{\}
form create $form_name \
-html    $onsubmit_cmd

element create $form_name f_stato \
-label   "stato" \
-widget   select \
-datatype text \
-html    "$disabled_fld {} class form_element" \
-optional \
-options {{{Attivo} A} {{Da accatastare} D}}

element create $form_name f_comune \
-label   "Comune" \
-widget   select \
-datatype text \
-html    "$disabled_fld {} class form_element tabindex 4" \
-optional \
-options [iter_selbox_from_comu]

element create $form_name id_stampa \
-label   "Denominazione stampa" \
-widget   select \
-options  [iter_selbox_from_table coimstpm id_stampa descrizione] \
-datatype text \
-html    "class form_element" \
-optional

element create $form_name f_escludi \
-label   "stato" \
-widget   select \
-datatype text \
-html    "$disabled_fld {} class form_element" \
-optional \
-options {{{Impianti con \"Informativa utenti con MESSA A NORMA\" gi&agrave; stampato} 1}}

element create $form_name f_da_impianto \
-label   "Codice impianto esterno" \
-widget   text \
-datatype text \
-html    "size 20 maxlength 20 $readonly_fld {} class form_element" \
-optional

element create $form_name f_a_impianto \
-label   "Codice impianto esterno" \
-widget   text \
-datatype text \
-html    "size 20 maxlength 20 $readonly_fld {} class form_element" \
-optional

element create $form_name funzione    -widget hidden -datatype text -optional
element create $form_name caller      -widget hidden -datatype text -optional
element create $form_name nome_funz   -widget hidden -datatype text -optional
element create $form_name submit      -widget submit -datatype text -label "$button_label" -html "class form_submit"


if {[form is_request $form_name]} {
    
    element set_properties $form_name f_stato         -value [iter_edit_date $f_stato]
    element set_properties $form_name f_comune        -value [iter_edit_date $f_comune]
    element set_properties $form_name f_escludi       -value [iter_edit_date $f_escludi]
    element set_properties $form_name f_da_impianto   -value [iter_edit_date $f_da_impianto]
    element set_properties $form_name f_a_impianto    -value [iter_edit_date $f_a_impianto]

    element set_properties $form_name funzione       -value $funzione
    element set_properties $form_name caller         -value $caller
    element set_properties $form_name nome_funz      -value $nome_funz

}

if {[form is_valid $form_name]} {
    # form valido dal punto di vista del templating system
    set f_stato      [element::get_value $form_name f_stato]
    set f_comune     [element::get_value $form_name f_comune]
    set f_escludi    [element::get_value $form_name f_escludi]
    set f_da_impianto [element::get_value $form_name f_da_impianto]
    set f_a_impianto [element::get_value $form_name f_a_impianto]
    set id_stampa    [element::get_value $form_name id_stampa]
   
    set error_num 0

    if {[string equal $id_stampa ""]} {
	element::set_error $form_name id_stampa "Inserire la stampa"
	incr error_num
    }
    
    if {[string equal $f_comune ""]} {
	element::set_error $form_name f_comune "Inserire la comune"
	incr error_num
    }

    if {$error_num > 0} {
        ad_return_template
        return
    }

    set link [export_url_vars f_comune f_stato f_escludi f_da_impianto f_a_impianto id_stampa caller funzione nome_funz nome_funz_caller]
   
    set return_url "coimstcu-list?$link"    

    
    ad_returnredirect $return_url
    ad_script_abort
}

ad_return_template
