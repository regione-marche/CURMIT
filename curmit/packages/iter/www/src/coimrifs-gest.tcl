ad_page_contract {
    Add/Edit/Delete  form per la tabella "coimrife"
    @author          Giulio Laurenzi
    @creation-date   05/08/2004

    @param funzione  I=insert M=edit D=delete V=view
    @param caller    caller della lista da restituire alla lista:
                     serve se lista e' uno zoom che permetti aggiungi.
    @param nome_funz identifica l'entrata di menu, server per le autorizzazioni
                     serve se lista e' uno zoom che permetti aggiungi.
    @param nome_funz_caller identifica l'entrata di menu, serve per la 
                     navigazione con navigation bar
    @param extra_par Variabili extra da restituire alla lista
    @cvs-id          coimrife-gest-gest.tcl
} {
    
   {cod_impianto      ""}
   {last_cod_impianto ""}
   {funzione         "V"}
   {caller       "index"}
   {nome_funz         ""}
   {nome_funz_caller  ""}
   {extra_par         ""}
   {ruolo             ""}
   {data_fin_valid    ""}
   {cod_soggetto      ""}
   {url_aimp          ""}
   {url_list_aimp     ""}
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
set id_utente [lindex [iter_check_login $lvl $nome_funz] 1]
set link_gest [export_url_vars cod_impianto last_cod_impianto nome_funz nome_funz_caller extra_par caller]
# imposta le class css della barra delle funzioni
iter_set_func_class $funzione

# controllo il parametro di "propagazione" per la navigation bar
if {[string is space $nome_funz_caller]} {
    set nome_funz_caller $nome_funz
}


# Personalizzo la pagina
set link_list_script {[export_url_vars cod_impianto last_cod_impianto caller nome_funz_caller nome_funz url_aimp url_list_aimp]&[iter_set_url_vars $extra_par]}
set link_list        [subst $link_list_script]
set titolo           "storico soggetti "
set button_label "Conferma Cancellazione"
set page_title   "Cancellazione $titolo"

set context_bar  [iter_context_bar -nome_funz $nome_funz_caller]

# sproteggo la chiave solo in inserimento e gli attributi in inserimento e mod.
set form_name    "coimrife_gest"
set readonly_key "readonly"
set readonly_fld "readonly"
set disabled_fld "disabled"
set onsubmit_cmd ""

form create $form_name \
-html    $onsubmit_cmd

element create $form_name ruolo_desc \
-label   "Ruolo" \
-widget   text \
-datatype text \
-html    "size 15 readonly {} class form_element" \
-optional

element create $form_name data_fin_valid \
-label   "Data fine validit&agrave;" \
-widget   text \
-datatype text \
-html    "size 10 readonly {} class form_element" \
-optional

element create $form_name cognome \
-label   "cod_soggetto" \
-widget   text \
-datatype text \
-html    "size 30 readonly {} class form_element" \
-optional

element create $form_name nome \
-label   "cod_soggetto" \
-widget   text \
-datatype text \
-html    "size 30 readonly {} class form_element" \
-optional

element create $form_name cf \
-label   "cod fiscale" \
-widget   text \
-datatype text \
-html    "size 16 readonly {} class form_element" \
-optional

element create $form_name nome_funz_caller -widget hidden -datatype text -optional
element create $form_name url_list_aimp -widget hidden -datatype text -optional
element create $form_name url_aimp     -widget hidden -datatype text -optional
element create $form_name cod_impianto -widget hidden -datatype text -optional
element create $form_name ruolo        -widget hidden -datatype text -optional
element create $form_name cod_soggetto -widget hidden -datatype text -optional

element create $form_name funzione     -widget hidden -datatype text -optional
element create $form_name caller       -widget hidden -datatype text -optional
element create $form_name nome_funz    -widget hidden -datatype text -optional
element create $form_name extra_par    -widget hidden -datatype text -optional
element create $form_name submit       -widget submit -datatype text -label "$button_label" -html "class form_submit"
element create $form_name last_cod_impianto -widget hidden -datatype text -optional

if {[form is_request $form_name]} {
    element set_properties $form_name url_list_aimp -value $url_list_aimp
    element set_properties $form_name url_aimp      -value $url_aimp    
    element set_properties $form_name cod_impianto  -value $cod_impianto
    element set_properties $form_name ruolo         -value $ruolo       
    element set_properties $form_name cod_soggetto  -value $cod_soggetto
    element set_properties $form_name funzione      -value $funzione
    element set_properties $form_name caller        -value $caller
    element set_properties $form_name nome_funz     -value $nome_funz
    element set_properties $form_name nome_funz_caller -value $nome_funz_caller
    element set_properties $form_name extra_par     -value $extra_par
    element set_properties $form_name last_cod_impianto -value $last_cod_impianto

    # leggo riga
    if {[db_0or1row sel_gest {}] == 0} {
	iter_return_complaint "Record non trovato"
    }
    
    element set_properties $form_name ruolo_desc     -value $ruolo_desc
    element set_properties $form_name data_fin_valid -value $data_fin_valid_edit
    element set_properties $form_name cognome        -value $cognome      
    element set_properties $form_name nome           -value $nome
    element set_properties $form_name cf             -value $cod_fiscale
}

if {[form is_valid $form_name]} {

    set data_fin_valid [element::get_value $form_name data_fin_valid]
    set data_fin_valid [iter_check_date $data_fin_valid]

  # controlli standard su numeri e date, per Ins ed Upd

     set dml_sql [db_map del_sogg]
    

  # Lancio la query di manipolazione dati contenute in dml_sql
    if {[info exists dml_sql]} {
        with_catch error_msg {
            db_transaction {
                db_dml dml_coimrife $dml_sql
            }
        } {
            iter_return_complaint "Spiacente, ma il DBMS ha restituito il
            seguente messaggio di errore <br><b>$error_msg</b><br>
            Contattare amministratore di sistema e comunicare il messaggio
            d'errore. Grazie."
 	}
    }

  # dopo l'inserimento posiziono la lista sul record inserito
    set return_url   "coimrifs-list?$link_list"

    ad_returnredirect $return_url
    ad_script_abort
}

ad_return_template
