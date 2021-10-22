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
    {cod_inco          ""}
    {funzione         "V"}
    {caller       "index"}
    {nome_funz         ""}
    {nome_funz_caller  ""}
    {flag_inco         ""}
    {extra_par         ""}
    {extra_par_inco    ""}
    {cod_impianto      ""}
    {url_list_aimp     ""}
    {url_aimp          ""}   
    {conta_flag        ""}
    {do                ""}
    {flag_avviso       ""}

    {f_tipo_data       ""}
    {f_data            ""}
    {f_cod_impianto    ""}
    {f_tipo_estrazione ""}
    {f_anno_inst_da    ""}
    {f_anno_inst_a     ""}
    {f_cod_comb        ""}
    {f_cod_enve        ""}
    {f_cod_tecn        ""}
    {f_cod_comune      ""}
    {f_descr_topo      ""}
    {f_descr_via       ""}
    {f_cod_via         ""}
    {f_num_max         ""}
    {f_cod_area        ""}
} -properties {
    page_title:onevalue
    context_bar:onevalue
    list_head:onevalue
    table_result:onevalue
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
set link_gest [export_url_vars cod_inco cod_impianto url_list_aimp url_aimp flag_avviso nome_funz nome_funz_caller extra_par caller]

if {![string equal $cod_inco ""]} {
    set link_inco [iter_link_inco $cod_inco $nome_funz_caller $url_list_aimp $url_aimp $nome_funz $do $extra_par_inco]
    set dett_tab [iter_tab_form $cod_impianto]
} else {
    set link_inco ""
    set dett_tab ""
}

# Personalizzo la pagina
set main_directory   [ad_conn package_url]

set button_label "Stampa" 
set page_title   "Stampa Documento"

set link_list [export_url_vars caller funzione nome_funz nome_funz_caller flag_avviso $url_list_aimp $url_aimp]

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

element create $form_name funzione          -widget hidden -datatype text -optional
element create $form_name url_list_aimp     -widget hidden -datatype text -optional
element create $form_name url_aimp          -widget hidden -datatype text -optional
element create $form_name flag_avviso       -widget hidden -datatype text -optional
element create $form_name caller            -widget hidden -datatype text -optional
element create $form_name nome_funz         -widget hidden -datatype text -optional
element create $form_name nome_funz_caller  -widget hidden -datatype text -optional
element create $form_name extra_par         -widget hidden -datatype text -optional
element create $form_name cod_impianto      -widget hidden -datatype text -optional
element create $form_name cod_inco          -widget hidden -datatype text -optional
element create $form_name submit            -widget submit -datatype text -label "$button_label" -html "class form_submit"
element create $form_name f_tipo_data       -widget hidden -datatype text -optional
element create $form_name f_data            -widget hidden -datatype text -optional
element create $form_name f_cod_impianto    -widget hidden -datatype text -optional
element create $form_name f_tipo_estrazione -widget hidden -datatype text -optional
element create $form_name f_anno_inst_da    -widget hidden -datatype text -optional
element create $form_name f_anno_inst_a     -widget hidden -datatype text -optional
element create $form_name f_cod_comb        -widget hidden -datatype text -optional
element create $form_name f_cod_enve        -widget hidden -datatype text -optional
element create $form_name f_cod_tecn        -widget hidden -datatype text -optional
element create $form_name f_cod_comune      -widget hidden -datatype text -optional
element create $form_name f_descr_topo      -widget hidden -datatype text -optional
element create $form_name f_descr_via       -widget hidden -datatype text -optional
element create $form_name f_cod_via         -widget hidden -datatype text -optional
element create $form_name f_num_max         -widget hidden -datatype text -optional
element create $form_name f_cod_area        -widget hidden -datatype text -optional

if {[form is_request $form_name]} {
    element set_properties $form_name funzione          -value $funzione
    element set_properties $form_name url_list_aimp     -value $url_list_aimp
    element set_properties $form_name url_aimp          -value $url_aimp
    element set_properties $form_name flag_avviso       -value $flag_avviso
    element set_properties $form_name caller            -value $caller
    element set_properties $form_name nome_funz         -value $nome_funz
    element set_properties $form_name nome_funz_caller  -value $nome_funz_caller
    element set_properties $form_name extra_par         -value $extra_par
    element set_properties $form_name cod_inco          -value $cod_inco
    element set_properties $form_name cod_impianto      -value $cod_impianto
    element set_properties $form_name f_tipo_data       -value $f_tipo_data
    element set_properties $form_name f_data            -value $f_data
    element set_properties $form_name f_cod_impianto    -value $f_cod_impianto
    element set_properties $form_name f_tipo_estrazione -value $f_tipo_estrazione
    element set_properties $form_name f_anno_inst_da    -value $f_anno_inst_da
    element set_properties $form_name f_anno_inst_a     -value $f_anno_inst_a
    element set_properties $form_name f_cod_comb        -value $f_cod_comb
    element set_properties $form_name f_cod_enve        -value $f_cod_enve
    element set_properties $form_name f_cod_tecn        -value $f_cod_tecn
    element set_properties $form_name f_cod_comune      -value $f_cod_comune
    element set_properties $form_name f_descr_topo      -value $f_descr_topo
    element set_properties $form_name f_descr_via       -value $f_descr_via
    element set_properties $form_name f_cod_via         -value $f_cod_via
    element set_properties $form_name f_num_max         -value $f_num_max
    element set_properties $form_name f_cod_area        -value $f_cod_area
}

if {[form is_valid $form_name]} {
# form valido dal punto di vista del templating system
    set id_stampa                 [element::get_value $form_name id_stampa]
    
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

    if {$error_num > 0} {
        ad_return_template
        return
    }    
   
    # dopo l'inserimento posiziono la lista sul record inserito
    set link_gest      [export_url_vars id_stampa tipo_stampa cod_inco caller nome_funz nome_funz_caller flag_inco extra_par extra_par_inco cod_impianto url_list_aimp url_aimp flag_avviso conta_flag f_tipo_data f_data f_cod_impianto f_tipo_estrazione f_anno_inst_da f_anno_inst_a f_cod_comb f_cod_enve f_cod_tecn f_cod_comune f_descr_topo f_descr_via f_cod_via f_num_max f_cod_area]
    set return_url     "coimstpm-prnt-da-app?$link_gest"
    
    ad_returnredirect $return_url
    ad_script_abort


}
ad_return_template
