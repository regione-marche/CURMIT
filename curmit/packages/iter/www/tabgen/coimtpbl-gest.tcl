ad_page_contract {
    Add/Edit/Delete  form per la tabella "coimtpbl"
    @author          Valentina Catte
    @creation-date   13/01/2004

    @param funzione  I=insert M=edit D=delete V=view
    @param caller    caller della lista da restituire alla lista:
                     serve se lista e' uno zoom che permetti aggiungi.
    @param nome_funz identifica l'entrata di menu, server per le autorizzazioni
                     serve se lista e' uno zoom che permetti aggiungi.
    @param extra_par Variabili extra da restituire alla lista
    @cvs-id          coimtpbl-gest.tcl
} {
    
   {cod_tipo_bol ""}
   {last_cod_tipo_bol ""}
   {funzione  "V"}
   {caller    "index"}
   {nome_funz ""}
   {extra_par ""}
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
set link_gest [export_url_vars cod_tipo_bol last_cod_tipo_bol nome_funz extra_par]

iter_set_func_class $funzione

# Personalizzo la pagina
set link_list_script {[export_url_vars last_cod_tipo_bol caller nome_funz]&[iter_set_url_vars $extra_par]}
set link_list        [subst $link_list_script]
set titolo           "Gestione addizionali regionali"
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

set context_bar  [iter_context_bar -nome_funz $nome_funz]

# sproteggo la chiave solo in inserimento e gli attributi in inserimento e mod.
set form_name    "coimtpbl"
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

element create $form_name cod_tipo_bol \
-label   "Codice" \
-widget   text \
-datatype text \
-html    "size 8 maxlength 8 readonly {} class form_element" \
-optional

element create $form_name descrizione \
-label   "Descrizione" \
-widget   text \
-datatype text \
-html    "size 50 maxlength 300 $readonly_fld {} class form_element" \
-optional

element create $form_name data_fine_valid \
-label   "Data" \
-widget   text \
-datatype text \
-html    "size 10 maxlength 10 $readonly_fld {} class form_element" \
-optional

element create $form_name cod_potenza \
-label   "cod_potenza" \
-widget   select \
-datatype text \
-html    "$disabled_fld {} class form_element" \
-optional \
-options [iter_selbox_from_table coimpote cod_potenza descr_potenza potenza_min]

element create $form_name funzione      -widget hidden -datatype text -optional
element create $form_name caller        -widget hidden -datatype text -optional
element create $form_name nome_funz     -widget hidden -datatype text -optional
element create $form_name extra_par     -widget hidden -datatype text -optional
element create $form_name submit        -widget submit -datatype text -label "$button_label" -html "class form_submit"
element create $form_name last_cod_tipo_bol -widget hidden -datatype text -optional

if {[form is_request $form_name]} {

    element set_properties $form_name funzione      -value $funzione
    element set_properties $form_name caller        -value $caller
    element set_properties $form_name nome_funz     -value $nome_funz
    element set_properties $form_name extra_par     -value $extra_par
    element set_properties $form_name last_cod_tipo_bol -value $last_cod_tipo_bol

    if {$funzione == "I"} {
        
    } else {
      # leggo riga
        if {[db_0or1row sel_tpbl ""] == 0} {
            iter_return_complaint "Record non trovato"
	}

        element set_properties $form_name cod_tipo_bol    -value $cod_tipo_bol
        element set_properties $form_name descrizione     -value $descrizione
        element set_properties $form_name data_fine_valid -value $data_fine_valid
        element set_properties $form_name cod_potenza     -value $cod_potenza

    }
}

if {[form is_valid $form_name]} {
  # form valido dal punto di vista del templating system

    set cod_tipo_bol    [element::get_value $form_name cod_tipo_bol]
    set descrizione     [element::get_value $form_name descrizione]
    set data_fine_valid [element::get_value $form_name data_fine_valid]
    set cod_potenza     [element::get_value $form_name cod_potenza]

  # controlli standard su numeri e date, per Ins ed Upd
    set error_num 0
    if {$funzione == "I"
    ||  $funzione == "M"
    } {

        if {![string equal $data_fine_valid ""]} {
            set data_fine_valid [iter_check_date $data_fine_valid]
            if {$data_fine_valid == 0} {
                element::set_error $form_name data_fine_valid "Data fine validit&agrave; deve essere una data"
                incr error_num
            }
        }

        if {[string equal $descrizione ""]} {
	    element::set_error $form_name descrizione "Inserisci descrizione"
               incr error_num
	} else {
	    if {[db_0or1row sel_desc_check ""] == 1} {
		element::set_error $form_name descrizione "Descrizione gi&agrave; presente"
                incr error_num
	    }
	}
    }

    if {$error_num > 0} {
        ad_return_template
        return
    }

    switch $funzione {
        I {set dml_sql [db_map ins_tpbl]}
        M {set dml_sql [db_map upd_tpbl]}
        D {set dml_sql [db_map del_tpbl]}
    }

  # Lancio la query di manipolazione dati contenute in dml_sql
    if {[info exists dml_sql]} {
        with_catch error_msg {
            db_transaction {
                db_dml dml_coimtpbl $dml_sql
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
	db_1row sel_last_cod ""
	set last_cod_tipo_bol $cod_tipo_bol
    }
    set link_list      [subst $link_list_script]
    set link_gest      [export_url_vars cod_tipo_bol last_cod_tipo_bol nome_funz extra_par caller]
    switch $funzione {
        M {set return_url   "coimtpbl-gest?funzione=V&$link_gest"}
        D {set return_url   "coimtpbl-list?$link_list"}
        I {set return_url   "coimtpbl-gest?funzione=V&$link_gest"}
        V {set return_url   "coimtpbl-list?$link_list"}
    }

    ad_returnredirect $return_url
    ad_script_abort
}

ad_return_template
