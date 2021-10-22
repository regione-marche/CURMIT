ad_page_contract {
    Add/Edit/Delete  form per la tabella "coimstub"
    @author          Adhoc
    @creation-date   04/08/2004

    @param funzione  I=insert M=edit D=delete V=view
    @param caller    caller della lista da restituire alla lista:
                     serve se lista e' uno zoom che permetti aggiungi.
    @param nome_funz identifica l'entrata di menu, server per le autorizzazioni
                     serve se lista e' uno zoom che permetti aggiungi.
    @param nome_funz_caller identifica l'entrata di menu, serve per la 
                     navigazione con navigation bar
    @param extra_par Variabili extra da restituire alla lista
    @cvs-id          coimstub-gest.tcl
} {
    {cod_impianto ""}
    {last_cod_impianto ""}
    {funzione  "V"}
    {caller    "index"}
    {nome_funz ""}
    {nome_funz_caller ""}
    {data_fin_valid ""}
    {extra_par ""}
    {url_list_aimp ""}
    {url_aimp      ""}
} -properties {
    page_title:onevalue
    context_bar:onevalue
    form_name:onevalue
}

# Controlla lo user
# TODO: controllare il livello richiesto,
# Se il programma e' 'delicato', mettere livello 5 (amministratore).

switch $funzione {
    "V" {set lvl 1}
    "I" {set lvl 2}
    "M" {set lvl 3}
    "D" {set lvl 4}
}
set id_utente [lindex [iter_check_login $lvl $nome_funz] 1]
set link_gest [export_url_vars cod_impianto last_cod_impianto nome_funz nome_funz_caller extra_par caller url_list_aimp url_aimp]
# imposta le class css della barra delle funzioni
iter_set_func_class $funzione

# controllo il parametro di "propagazione" per la navigation bar
if {[string is space $nome_funz_caller]} {
    set nome_funz_caller $nome_funz
}


# Personalizzo la pagina
# TODO: controllare impostazione della context_bar adattando come necessario
set link_list_script {[export_url_vars last_cod_impianto caller nome_funz_caller nome_funz cod_impianto url_list_aimp url_aimp]&[iter_set_url_vars $extra_par]}
set link_list        [subst $link_list_script]
set titolo           "Storico ubicazione"

set button_label "Conferma Cancellazione"
set page_title   "Cancellazione $titolo"
set context_bar  [iter_context_bar -nome_funz $nome_funz_caller]

# sproteggo la chiave solo in inserimento e gli attributi in inserimento e mod.
set form_name    "coimstub"
set readonly_key "readonly"
set readonly_fld "readonly"
set disabled_fld "disabled"
set onsubmit_cmd ""

form create $form_name \
-html    $onsubmit_cmd

element create $form_name data_fin_valid \
-label   "Data fine validit&agrave;" \
-widget   text \
-datatype text \
-html    "size 10 maxlength 10 readonly {} class form_element" \
-optional

element create $form_name localita \
-label   "localita" \
-widget   textarea \
-datatype text \
-html    "rows 2 cols 60 readonly {} class form_element" \
-optional

element create $form_name nome_funz_caller -widget hidden -datatype text -optional
element create $form_name url_list_aimp -widget hidden -datatype text -optional
element create $form_name url_aimp     -widget hidden -datatype text -optional
element create $form_name cod_impianto -widget hidden -datatype text -optional
element create $form_name funzione  -widget hidden -datatype text -optional
element create $form_name caller    -widget hidden -datatype text -optional
element create $form_name nome_funz -widget hidden -datatype text -optional
element create $form_name extra_par -widget hidden -datatype text -optional
element create $form_name submit    -widget submit -datatype text -label "$button_label" -html "class form_submit"
element create $form_name last_cod_impianto -widget hidden -datatype text -optional

if {[form is_request $form_name]} {
    element set_properties $form_name nome_funz_caller -value $nome_funz_caller
    element set_properties $form_name funzione  -value $funzione
    element set_properties $form_name caller    -value $caller
    element set_properties $form_name nome_funz -value $nome_funz
    element set_properties $form_name extra_par -value $extra_par
    element set_properties $form_name last_cod_impianto -value $last_cod_impianto

    if {[db_0or1row sel_stub {}] == 0} {
	iter_return_complaint "Record non trovato"
    }
 
    element set_properties $form_name data_fin_valid  -value $data_fin_valid_edit
    element set_properties $form_name localita        -value $localita
    element set_properties $form_name cod_impianto    -value $cod_impianto
    element set_properties $form_name url_list_aimp   -value $url_list_aimp
    element set_properties $form_name url_aimp        -value $url_aimp    
}

if {[form is_valid $form_name]} {

  # form valido dal punto di vista del templating system

    set localita       [element::get_value $form_name localita]
    set data_fin_valid [element::get_value $form_name data_fin_valid]

    set data_fin_valid [iter_check_date $data_fin_valid]

    set dml_sql [db_map del_stub]

  # Lancio la query di manipolazione dati contenute in dml_sql
    if {[info exists dml_sql]} {
        with_catch error_msg {
            db_transaction {
                db_dml dml_coimstub $dml_sql
            }
        } {
            iter_return_complaint "Spiacente, ma il DBMS ha restituito il
            seguente messaggio di errore <br><b>$error_msg</b><br>
            Contattare amministratore di sistema e comunicare il messaggio
            d'errore. Grazie."
 	}
    }
  # dopo l'inserimento posiziono la lista sul record inserito
    set link_list      [subst $link_list_script]
    set return_url   "coimstub-list?$link_list"

    ad_returnredirect $return_url
    ad_script_abort
}

ad_return_template
