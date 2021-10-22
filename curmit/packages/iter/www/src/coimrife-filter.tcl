ad_page_contract {
    @author          Adhoc
    @creation-date   11/05/2004

    @param funzione  V=view
    @param caller    caller della lista da restituire alla lista:
    serve se lista e' uno zoom che permetti aggiungi.
    @param nome_funz identifica l'entrata di menu, server per le autorizzazioni
    serve se lista e' uno zoom che permetti aggiungi.
    @cvs-id          coimrife-filter.tcl
} {
    
    {funzione          "V"}
    {caller        "index"}
    {nome_funz          ""}
    {nome_funz_caller   ""} 
    {f_riferimento      ""}
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
set titolo       "Selezione riferimento bollino"
set button_label "Seleziona" 
set page_title   "Selezione riferimento bollino"

set context_bar  [iter_context_bar -nome_funz $nome_funz_caller] 

# sproteggo la chiave solo in inserimento e gli attributi in inserimento e mod.
set form_name    "coimrife"
set readonly_key "readonly"
set readonly_fld "readonly"
set disabled_fld "disabled"
set onsubmit_cmd ""

set readonly_fld \{\}
set disabled_fld \{\}
form create $form_name \
    -html    $onsubmit_cmd

element create $form_name f_riferimento \
    -label   "Rif. bollino" \
    -widget   text \
    -datatype text \
    -html    "size 20 maxlength 20 $readonly_fld {} class form_element" \
    -optional

element create $form_name funzione    -widget hidden -datatype text -optional
element create $form_name caller      -widget hidden -datatype text -optional
element create $form_name nome_funz   -widget hidden -datatype text -optional
element create $form_name submit      -widget submit -datatype text -label "$button_label" -html "class form_submit"

if {[form is_request $form_name]} {

    element set_properties $form_name funzione       -value $funzione
    element set_properties $form_name caller         -value $caller
    element set_properties $form_name nome_funz      -value $nome_funz
}

if {[form is_valid $form_name]} {
    # form valido dal punto di vista del templating system
    
    set f_riferimento     [element::get_value $form_name f_riferimento]

    set error_num 0 

    if {[string equal $f_riferimento ""]} {
	element::set_error $form_name f_riferimento "Inserisci riferimento bollino"
	incr error_num
    }
    
    if {$error_num > 0} {
        ad_return_template
        return
    }
    
    set link_gest [export_url_vars f_riferimento caller funzione nome_funz]

    set return_url "coimrife-gest?$link_gest"    
    
    ad_returnredirect $return_url
    ad_script_abort
}

ad_return_template
