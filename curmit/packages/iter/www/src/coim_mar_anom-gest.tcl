ad_page_contract {
    Add/Edit/Delete  form per la tabella "coim_d_anom"
    @author          Adhoc
    @creation-date   16/04/2004

    @param funzione  I=insert M=edit D=delete V=view
    @param caller    caller della lista da restituire alla lista:
                     serve se lista e' uno zoom che permetti aggiungi.
    @param nome_funz identifica l'entrata di menu, server per le autorizzazioni
                     serve se lista e' uno zoom che permetti aggiungi.
    @param nome_funz_caller identifica l'entrata di menu, serve per la 
                     navigazione con navigation bar
    @param extra_par Variabili extra da restituire alla lista
    @cvs-id          coim_d_anom-gest.tcl
} {
    
   {cod_d_tano          ""}
   {last_data_controllo ""}
   {funzione        "V"}
   {caller      "index"}
   {nome_funz        ""}
   {nome_funz_caller ""}
   {extra_par        ""}
   {url_aimp         ""}
   {url_list_aimp    ""}
   {cod_impianto     ""}
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
set link_gest [export_url_vars url_aimp url_list_aimp cod_impianto cod_d_tano last_data_controllo nome_funz nome_funz_caller extra_par caller]
# imposta le class css della barra delle funzioni
iter_set_func_class $funzione

# controllo il parametro di "propagazione" per la navigation bar
if {[string is space $nome_funz_caller]} {
    set nome_funz_caller $nome_funz
}

set link_tab [iter_links_form $cod_impianto $nome_funz_caller $url_list_aimp $url_aimp]
set dett_tab [iter_tab_form $cod_impianto]

# Personalizzo la pagina
set link_list_script {[export_url_vars url_aimp url_list_aimp cod_impianto last_data_controllo caller nome_funz_caller nome_funz]&[iter_set_url_vars $extra_par]}
set link_list        [subst $link_list_script]
set titolo           "Anomalia"
switch $funzione {
    M {set button_label "Conferma Modifica" 
       set page_title   "Modifica $titolo"}
    D {set button_label "Conferma Cancellazione"
       set page_title   "Cancellazione $titolo"}
    I {set button_label "Conferma Inserimento"
       set page_title   "Inserimento $titolo"}
    V {set button_label "Torna alla lista"
       set page_title   "Visualizzazione $titolo"}
}

set context_bar  [iter_context_bar -nome_funz $nome_funz_caller]

# sproteggo la chiave solo in inserimento e gli attributi in inserimento e mod.
set form_name    "coim_d_anom"
set readonly_key "readonly"
set readonly_fld "readonly"
set disabled_fld "disabled"
set onsubmit_cmd ""
switch $funzione {
   "I" {set readonly_key \{\}
        set readonly_fld \{\}
        set disabled_fld \{\}
       }
   "M" {set readonly_fld \{\}
        set disabled_fld \{\}
       }
}

form create $form_name \
-html    $onsubmit_cmd

element create $form_name cod_d_tano \
-label   "cod_d_tano" \
-widget   text \
-datatype text \
-html    "size 8 maxlength 8 $readonly_fld {} class form_element" \
-optional

element create $form_name data_controllo \
-label   "Data controllo" \
-widget   text \
-datatype text \
-html    "size 10 maxlength 10 $readonly_fld {} class form_element" \
-optional

element create $form_name descr_breve \
-label   "Data evento" \
-widget   text \
-datatype text \
-html    "size 60 maxlength 80 $readonly_key {} class form_element" \
-optional

element create $form_name data_invio_lettera \
-label   "Data invio_lettera" \
-widget   text \
-datatype text \
-html    "size 10 maxlength 10 $readonly_fld {} class form_element" \
-optional


element create $form_name url_aimp  -widget hidden -datatype text -optional
element create $form_name url_list_aimp -widget hidden -datatype text -optional
element create $form_name cod_impianto  -widget hidden -datatype text -optional
element create $form_name funzione  -widget hidden -datatype text -optional
element create $form_name caller    -widget hidden -datatype text -optional
element create $form_name nome_funz -widget hidden -datatype text -optional
element create $form_name nome_funz_caller -widget hidden -datatype text -optional
element create $form_name extra_par -widget hidden -datatype text -optional
element create $form_name submit    -widget submit -datatype text -label "$button_label" -html "class form_submit"
element create $form_name last_data_controllo -widget hidden -datatype text -optional

if {[form is_request $form_name]} {

    element set_properties $form_name url_aimp      -value $url_aimp
    element set_properties $form_name url_list_aimp -value $url_list_aimp
    element set_properties $form_name cod_impianto  -value $cod_impianto
    element set_properties $form_name funzione      -value $funzione
    element set_properties $form_name caller        -value $caller
    element set_properties $form_name nome_funz     -value $nome_funz
    element set_properties $form_name nome_funz_caller -value $nome_funz_caller
    element set_properties $form_name extra_par     -value $extra_par
    element set_properties $form_name last_data_controllo -value $last_data_controllo
    
    if {$funzione == "I"} {
        
    } else {
	# leggo riga
        if {[db_0or1row sel_anom {}] == 0} {
            iter_return_complaint "Record non trovato"
	}
	
        element set_properties $form_name cod_d_tano         -value $cod_d_tano
        element set_properties $form_name data_controllo     -value $data_controllo
	element set_properties $form_name descr_breve        -value $descr_breve
	element set_properties $form_name data_invio_lettera -value $data_invio_lettera

    }
}

if {[form is_valid $form_name]} {
    # form valido dal punto di vista del templating system

    set cod_d_tano         [element::get_value $form_name cod_d_tano]
    set data_controllo     [element::get_value $form_name data_controllo]
    set descr_breve        [element::get_value $form_name descr_breve]
    set data_invio_lettera [element::get_value $form_name data_invio_lettera]
    
    # controlli standard su numeri e date, per Ins ed Upd
    set error_num 0
    if {$funzione == "I"
    ||  $funzione == "M"
    } {

    }
   
    if {$error_num > 0} {
        ad_return_template
        return
    }

    switch $funzione {
        I {}
        M {}
        D {}
    }
    
    # Lancio la query di manipolazione dati contenute in dml_sql
    if {[info exists dml_sql]} {
        with_catch error_msg {
            db_transaction {
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
    set link_gest      [export_url_vars cod_d_tano last_data_controllo nome_funz nome_funz_caller extra_par url_aimp url_list_aimp cod_impianto caller]
    switch $funzione {
        M {set return_url   "coim_d_anom-gest?funzione=V&$link_gest"}
        D {set return_url   "coim_d_anom-list?$link_list"}
        I {set return_url   "coim_d_anom-gest?funzione=V&$link_gest"}
        V {set return_url   "coim_d_anom-list?$link_list"}
    }
    
    ad_returnredirect $return_url
    ad_script_abort
}


ad_return_template
