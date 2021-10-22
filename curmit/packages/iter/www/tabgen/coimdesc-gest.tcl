ad_page_contract {
    Add/Edit/Delete  form per la tabella "coimdesc"
    @author          Giulio Laurenzi
    @creation-date   13/05/2004

    @param funzione  I=insert M=edit D=delete V=view
    @param caller    caller della lista da restituire alla lista:
                     serve se lista e' uno zoom che permetti aggiungi.
    @param nome_funz identifica l'entrata di menu, server per le autorizzazioni
                     serve se lista e' uno zoom che permetti aggiungi.
    @param nome_funz_caller identifica l'entrata di menu, serve per la 
                     navigazione con navigation bar
    @param extra_par Variabili extra da restituire alla lista
    @cvs-id          coimdesc-gest.tcl

    USER  DATA       MODIFICHE
    ===== ========== =======================================================================
    sim01 18/03/2016 Sandro ha detto che nel campo uff_info va salvata la email che poi va 
    sim01            negli storni e che deve essere sempre obbligatoria per tutti i clienti.
} {
    
   {cod_desc        "1"}
   {last_cod_desc    ""}
   {funzione        "V"}
   {caller      "index"}
   {nome_funz        ""}
   {nome_funz_caller ""}
   {extra_par        ""}
} -properties {
    page_title:onevalue
    context_bar:onevalue
    form_name:onevalue
}

# Controlla lo user

db_1row sel_desc_count ""
if {$conta_desc == 0} {
    set funzione "I"
}

set package_dir [ad_conn package_url]

switch $funzione {
    "V" {set lvl 1}
    "I" {set lvl 2}
    "M" {set lvl 3}
    "D" {set lvl 4}
}
set id_utente [lindex [iter_check_login $lvl $nome_funz] 1]
set link_gest [export_url_vars cod_desc last_cod_desc nome_funz nome_funz_caller extra_par caller]
# imposta le class css della barra delle funzioni
iter_set_func_class $funzione

# controllo il parametro di "propagazione" per la navigation bar
if {[string is space $nome_funz_caller]} {
    set nome_funz_caller $nome_funz
}


# Personalizzo la pagina
# TODO: controllare impostazione della context_bar adattando come necessario
set link_list_script {[export_url_vars last_cod_desc caller nome_funz_caller nome_funz]&[iter_set_url_vars $extra_par]}
set link_list        [subst $link_list_script]
set titolo           "Dati dell'ente"
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
set form_name    "coimdesc"
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

element create $form_name nome_ente \
-label   "Nome ente" \
-widget   text \
-datatype text \
-html    "size 40 maxlength 80 $readonly_fld {} class form_element" \
-optional

element create $form_name tipo_ufficio \
-label   "Tipo ufficio" \
-widget   text \
-datatype text \
-html    "size 40 maxlength 80 $readonly_fld {} class form_element" \
-optional

element create $form_name assessorato \
-label   "Assessorato" \
-widget   text \
-datatype text \
-html    "size 40 maxlength 80 $readonly_fld {} class form_element" \
-optional

element create $form_name indirizzo \
-label   "Indirizzo" \
-widget   text \
-datatype text \
-html    "size 40 maxlength 80 $readonly_fld {} class form_element" \
-optional

element create $form_name telefono \
-label   "Telefono" \
-widget   text \
-datatype text \
-html    "size 40 maxlength 50 $readonly_fld {} class form_element" \
-optional

element create $form_name resp_uff \
-label   "Responsabile Ufficio" \
-widget   text \
-datatype text \
-html    "size 40 maxlength 40 $readonly_fld {} class form_element" \
-optional

element create $form_name uff_info \
-label   "Email" \
-widget   text \
-datatype text \
-html    "size 40 maxlength 80 $readonly_fld {} class form_element" 

element create $form_name dirigente \
-label   "Dirigente" \
-widget   text \
-datatype text \
-html    "size 40 maxlength 40 $readonly_fld {} class form_element" \
-optional

element create $form_name cod_desc  -widget hidden -datatype text -optional
element create $form_name funzione  -widget hidden -datatype text -optional
element create $form_name caller    -widget hidden -datatype text -optional
element create $form_name nome_funz -widget hidden -datatype text -optional
element create $form_name extra_par -widget hidden -datatype text -optional
element create $form_name submit    -widget submit -datatype text -label "$button_label" -html "class form_submit"
element create $form_name last_cod_desc -widget hidden -datatype text -optional

if {[form is_request $form_name]} {

    
    element set_properties $form_name funzione      -value $funzione
    element set_properties $form_name caller        -value $caller
    element set_properties $form_name nome_funz     -value $nome_funz
    element set_properties $form_name extra_par     -value $extra_par
    element set_properties $form_name last_cod_desc -value $last_cod_desc
    element set_properties $form_name cod_desc      -value $cod_desc

    if {$funzione == "I"} {
      # TODO: settare eventuali default!!
        
    } else {
      # leggo riga
        if {[db_0or1row sel_desc {}] == 0} {
            iter_return_complaint "Record non trovato"
	}

        element set_properties $form_name cod_desc     -value $cod_desc
        element set_properties $form_name nome_ente    -value $nome_ente
        element set_properties $form_name tipo_ufficio -value $tipo_ufficio
        element set_properties $form_name assessorato  -value $assessorato
        element set_properties $form_name indirizzo    -value $indirizzo
        element set_properties $form_name telefono     -value $telefono
        element set_properties $form_name resp_uff     -value $resp_uff
        element set_properties $form_name uff_info     -value $uff_info
        element set_properties $form_name dirigente    -value $dirigente

    }
}

if {[form is_valid $form_name]} {
  # form valido dal punto di vista del templating system

    set cod_desc     [element::get_value $form_name cod_desc]
    set nome_ente    [element::get_value $form_name nome_ente]
    set tipo_ufficio [element::get_value $form_name tipo_ufficio]
    set assessorato  [element::get_value $form_name assessorato]
    set indirizzo    [element::get_value $form_name indirizzo]
    set telefono     [element::get_value $form_name telefono]
    set resp_uff     [element::get_value $form_name resp_uff]
    set uff_info     [element::get_value $form_name uff_info]
    set dirigente    [element::get_value $form_name dirigente]


  # controlli standard su numeri e date, per Ins ed Upd
    set error_num 0
    if {$funzione == "I"
    ||  $funzione == "M"
    } {

    }

    if {$funzione == "I"
    &&  $error_num == 0
    &&  [db_0or1row sel_desc_check {}] == 1
    } {
      # controllo univocita'/protezione da double_click
        element::set_error $form_name cod_desc "Il record che stai tentando di inserire &egrave; gi&agrave; esistente nel Data Base."
        incr error_num
    }
 
    if {$error_num > 0} {
        ad_return_template
        return
    }

    switch $funzione {
        I {set dml_sql [db_map ins_desc]}
        M {set dml_sql [db_map upd_desc]}
        D {set dml_sql [db_map del_desc]}
    }

  # Lancio la query di manipolazione dati contenute in dml_sql
    if {[info exists dml_sql]} {
        with_catch error_msg {
            db_transaction {
                db_dml dml_coimdesc $dml_sql
            }
        } {
            iter_return_complaint "Spiacente, ma il DBMS ha restituito il
            seguente messaggio di errore <br><b>$error_msg</b><br>
            Contattare amministratore di sistema e comunicare il messaggio
            d'errore. Grazie."
 	}
    }

  # dopo l'inserimento posiziono la lista sul record inserito
    if {$funzione == "I"} {
        set last_cod_desc $cod_desc
    }
    set link_list      [subst $link_list_script]
    set link_gest      [export_url_vars cod_desc last_cod_desc nome_funz nome_funz_caller extra_par caller]
    switch $funzione {
        M {set return_url   "coimdesc-gest?funzione=V&$link_gest"}
        D {set return_url   "coimdesc-gest?funzione=V&$link_gest"}
        I {set return_url   "coimdesc-gest?funzione=V&$link_gest"}

    }

    ad_returnredirect $return_url
    ad_script_abort
}

ad_return_template
