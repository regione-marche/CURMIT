ad_page_contract {
    Add/Edit/Delete  form per la tabella "coimprov"
    @author          Paolo Formizzi Adhoc
    @creation-date   06/02/2004

    @param funzione  I=insert M=edit D=delete V=view
    @param caller    caller della lista da restituire alla lista:
                     serve se lista e' uno zoom che permetti aggiungi.
    @param nome_funz identifica l'entrata di menu, server per le autorizzazioni
                     serve se lista e' uno zoom che permetti aggiungi.
    @param extra_par Variabili extra da restituire alla lista
    @cvs-id          coimprov-gest.tcl
} {
    
   {cod_provincia      ""}
   {last_denominazione ""}
   {last_cod_provincia ""}
   {funzione          "V"}
   {caller        "index"}
   {nome_funz          ""}
   {extra_par          ""}
   {cod_regione        ""}
   cerca_regi:optional
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
set link_gest [export_url_vars cod_provincia last_cod_provincia last_denominazione nome_funz extra_par]

iter_set_func_class $funzione

# Personalizzo la pagina
set link_list_script {[export_url_vars cod_provincia last_cod_provincia last_denominazione caller nome_funz]&[iter_set_url_vars $extra_par]}
set link_list        [subst $link_list_script]
set titolo           "Provincia"
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

if {$caller == "index"} {
    set context_bar  [iter_context_bar -nome_funz $nome_funz]
} else {
    set context_bar  [iter_context_bar \
                     [list "javascript:window.close()" "Torna alla Gestione"] \
                     [list coimprov-list?$link_list "Lista Province"] \
                     "$page_title"]
}


# sproteggo la chiave solo in inserimento e gli attributi in inserimento e mod.
set form_name    "coimprov"
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
        set checked ""
       }
}

form create $form_name \
-html    $onsubmit_cmd

element create $form_name denominazione \
-label   "Denominazione" \
-widget   text \
-datatype text \
-html    "size 40 maxlength 40 $readonly_fld {} class form_element" \
-optional

element create $form_name nome_regi \
-label   "Regione" \
-widget   text \
-datatype text \
-html    "size 40 maxlength 40 readonly {} class form_element" \
-optional

element create $form_name flag_val \
-label   "Flag validit&agrave;" \
-widget   checkbox \
-datatype text \
-html    "$disabled_fld {} class form_element" \
-optional \
-options {{F T}}

element create $form_name cod_istat \
-label   "Codice Istat" \
-widget   text \
-datatype text \
-html    "size 7 maxlength 7 $readonly_fld {} class form_element" \
-optional

element create $form_name sigla \
-label   "Sigla" \
-widget   text \
-datatype text \
-html    "size 4 maxlength 4 $readonly_fld {} class form_element" \
-optional

if {$funzione == "I"
||  $funzione == "M"
} {
    set cerca_regi [iter_search coimprov coimregi-list [list denominazione nome_regi cod_regione cod_regione]]
} else {
    set cerca_regi ""
}

element create $form_name funzione      -widget hidden -datatype text -optional
element create $form_name caller        -widget hidden -datatype text -optional
element create $form_name nome_funz     -widget hidden -datatype text -optional
element create $form_name extra_par     -widget hidden -datatype text -optional
element create $form_name submit        -widget submit -datatype text -label "$button_label" -html "class form_submit"
element create $form_name last_denominazione -widget hidden -datatype text -optional
element create $form_name last_cod_provincia -widget hidden -datatype text -optional
element create $form_name cod_provincia -widget hidden -datatype text -optional
element create $form_name cod_regione   -widget hidden -datatype text -optional

if {[form is_request $form_name]} {

    element set_properties $form_name funzione           -value $funzione
    element set_properties $form_name caller             -value $caller
    element set_properties $form_name nome_funz          -value $nome_funz
    element set_properties $form_name extra_par          -value $extra_par
    element set_properties $form_name last_denominazione -value $last_denominazione
    element set_properties $form_name last_cod_provincia -value $last_cod_provincia
    element set_properties $form_name cod_provincia      -value $cod_provincia

    set checked ""
    if {$funzione == "I"} {

	element set_properties $form_name flag_val -value "T"

    } else {
      # leggo riga
        if {[db_0or1row sel_prov_1 ""] == 0
        } {
            iter_return_complaint "Record non trovato"
	}

	if {[db_0or1row sel_regi_1 ""] == 0} {
	    set nome_regi ""
	}

        element set_properties $form_name cod_regione   -value $cod_regione
        element set_properties $form_name denominazione -value $denominazione
        element set_properties $form_name flag_val      -value $flag_val
        element set_properties $form_name cod_istat     -value $cod_istat
        element set_properties $form_name sigla         -value $sigla
        element set_properties $form_name nome_regi     -value $nome_regi
    }
}

if {[form is_valid $form_name]} {
  # form valido dal punto di vista del templating system

    set denominazione [element::get_value $form_name denominazione]
    set flag_val      [element::get_value $form_name flag_val]
    set cod_istat     [element::get_value $form_name cod_istat]
    set sigla         [element::get_value $form_name sigla]
    set nome_regi     [element::get_value $form_name nome_regi]

    # controlli standard su numeri e date, per Ins ed Upd
    set error_num 0
    if {$funzione == "I"
    ||  $funzione == "M"
    } {

        if {[string equal $denominazione ""]} {
            element::set_error $form_name denominazione "Inserire Denominazione"
            incr error_num
        } else {
            set denominazione [string toupper $denominazione]
        }

        if {[string equal $nome_regi ""]} {
            element::set_error $form_name nome_reg "Inserire Regione"
            incr error_num
	}

        if {[string equal $sigla ""]} {
            element::set_error $form_name sigla "Inserire Sigla"
            incr error_num
        } else {
            set sigla [string toupper $sigla]
        }

        if {$flag_val != "T"} {
	    set flag_val "F" 
        }

    }

    if {$funzione == "D"} {
	if {[db_0or1row sel_comu ""] == 0} {
	    set conta 0
	}
	if {$conta > 0} {
	    element::set_error $form_name denominazione "Provincia non cancellabile: esistono comuni collegati"
	    incr error_num
	}
    }
  
    if {$error_num > 0} {
        ad_return_template
        return
    }

    switch $funzione {
        I {db_0or1row sel_prov_next ""
	   set dml_sql [db_map ins_prov]}
        M {set dml_sql [db_map upd_prov]}
        D {set dml_sql [db_map del_prov]}
    }

  # Lancio la query di manipolazione dati contenute in dml_sql
    if {[info exists dml_sql]} {
        with_catch error_msg {
            db_transaction {
                db_dml dml_coimprov $dml_sql
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
        set last_cod_provincia $cod_provincia
        set last_denominazione $denominazione
    }
    set link_list      [subst $link_list_script]
    set link_gest      [export_url_vars cod_provincia last_cod_provincia last_denominazione nome_funz extra_par caller]
    switch $funzione {
        M {set return_url   "coimprov-gest?funzione=V&$link_gest"}
        D {set return_url   "coimprov-list?$link_list"}
        I {set return_url   "coimprov-gest?funzione=V&$link_gest"}
        V {set return_url   "coimprov-list?$link_list"}
    }

    ad_returnredirect $return_url
    ad_script_abort
}

ad_return_template
