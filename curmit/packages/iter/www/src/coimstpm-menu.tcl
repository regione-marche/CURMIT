ad_page_contract {
    Add/Edit/Delete  Form per selezione stampe
    @author          Tania Masullo Adhoc
    @creation-date   17/08/2005

    @param funzione  I=insert M=edit D=delete V=view
    @param caller    caller della lista da restituire alla lista:
                     serve se lista e' uno zoom che permetti aggiungi.
    @param nome_funz identifica l'entrata di menu, server per le autorizzazioni
                     serve se lista e' uno zoom che permetti aggiungi.
    @param extra_par Variabili extra da restituire alla lista

    @cvs-id          coimstpm-menu.tcl
}  {
    {cod_impianto      ""}
    {last_cod_impianto ""}
    {funzione         "V"}
    {caller       "index"}
    {nome_funz         ""}
    {nome_funz_caller  ""}
    {extra_par         ""}
    {url_list_aimp     ""}
    {url_aimp          ""}
} -properties {
    page_title:onevalue
    context_bar:onevalue
    form_name:onevalue
    tab_attributi:multirow
}

# Controlla lo user
switch $funzione {
    "V" {set lvl 1}
    "I" {set lvl 2}
    "M" {set lvl 3}
    "D" {set lvl 4}
}
 
set id_utente [lindex [iter_check_login $lvl $nome_funz] 1]
set link_gest [export_url_vars cod_impianto url_list_aimp url_aimp last_cod_impianto nome_funz nome_funz_caller extra_par caller]

set link_tab [iter_links_form $cod_impianto $nome_funz_caller $url_list_aimp $url_aimp]
set dett_tab [iter_tab_form $cod_impianto]

# Personalizzo la pagina
set main_directory   [ad_conn package_url]

set button_label "Stampa" 
set page_title   "Stampa Documento"

set link_list [export_url_vars caller funzione nome_funz nome_funz_caller $url_list_aimp $url_aimp]

if {$caller == "index"} {
    set context_bar  [iter_context_bar -nome_funz $nome_funz_caller]
} else {
    set context_bar  [iter_context_bar \
                     [list "javascript:window.close()" "Torna alla Gestione"] \
                     [list coimaimp-list?$link_list "Lista Impianti"] \
                     "$page_title"]
}

# sproteggo la chiave solo in inserimento e gli attributi in inserimento e mod.
set form_name    "coimstpm"
set readonly_key "readonly"
set readonly_fld "readonly"
set disabled_fld "disabled"
set onsubmit_cmd ""

form create $form_name \
    -html    $onsubmit_cmd

element create $form_name id_stampa \
-label   "Denominazione stampa" \
-widget   select \
-options  [iter_selbox_from_table coimstpm id_stampa descrizione] \
-datatype text \
-html    "class form_element" \
-optional

element create $form_name cod_rgen \
-label   "Codice ragruppamenti" \
-widget   select \
-options  [iter_selbox_from_table coimrgen cod_rgen descrizione] \
-datatype text \
-html    "class form_element" \
-optional

element create $form_name funzione          -widget hidden -datatype text -optional
element create $form_name url_list_aimp     -widget hidden -datatype text -optional
element create $form_name url_aimp          -widget hidden -datatype text -optional
element create $form_name caller            -widget hidden -datatype text -optional
element create $form_name nome_funz         -widget hidden -datatype text -optional
element create $form_name nome_funz_caller  -widget hidden -datatype text -optional
element create $form_name extra_par         -widget hidden -datatype text -optional
element create $form_name last_cod_impianto -widget hidden -datatype texxt optional
element create $form_name cod_impianto      -widget hidden -datatype text -optional
element create $form_name submit            -widget submit -datatype text -label "$button_label" -html "class form_submit"

if {[form is_request $form_name]} {
    element set_properties $form_name funzione          -value $funzione
    element set_properties $form_name url_list_aimp     -value $url_list_aimp
    element set_properties $form_name url_aimp          -value $url_aimp
    element set_properties $form_name caller            -value $caller
    element set_properties $form_name nome_funz         -value $nome_funz
    element set_properties $form_name nome_funz_caller  -value $nome_funz_caller
    element set_properties $form_name extra_par         -value $extra_par
    element set_properties $form_name last_cod_impianto -value $last_cod_impianto
    element set_properties $form_name cod_impianto      -value $cod_impianto
}

if {[form is_valid $form_name]} {
# form valido dal punto di vista del templating system
    set id_stampa                 [element::get_value $form_name id_stampa]
    set cod_rgen                  [element::get_value $form_name cod_rgen]
    
 # controlli standard su numeri e date, per Ins ed Upd
    set error_num 0

    # controlli sulla tipologia di occupazione
    if {[string is space $id_stampa]} {
	element::set_error $form_name id_stampa "Inserire la stampa desiderata"
	incr error_num
    }
    if {[db_0or1row sel_stpm ""] == 0} {
	set testo ""
    }
    if {[string equal $cod_rgen ""]
    &&  [string first "destinatario" $testo] > 0
    } {
	element::set_error $form_name id_stampa "Per questa stampa &egrave; necessario inserire il raggruppamento enti"
	incr error_num
    }

    if {$error_num > 0} {
        ad_return_template
        return
    }    

    # dopo l'inserimento posiziono la lista sul record inserito
    set link_gest      [export_url_vars cod_impianto last_cod_impianto url_list_aimp url_aimp nome_funz nome_funz_caller id_stampa cod_rgen extra_par caller]
    set return_url     "coimstpm-prnt?$link_gest"
    
    ad_returnredirect $return_url
    ad_script_abort


}
ad_return_template
