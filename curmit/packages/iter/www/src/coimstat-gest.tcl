ad_page_contract {
    Add/Edit/Delete  form per la tabella "coimstat"
    @author          dob
    @creation-date   2010
} {
 
   {cod_stato      ""}
   {last_denominazione ""}
   {last_cod_stato ""}
   {funzione          "V"}
   {caller        "index"}
   {nome_funz          ""}
   {extra_par          ""}
}

# Controlla lo user

switch $funzione {
    "V" {set lvl 1}
    "I" {set lvl 2}
    "M" {set lvl 3}
    "D" {set lvl 4}
}

#set id_utente [lindex [iter_check_login $lvl $nome_funz] 1]
set link_gest [export_url_vars cod_stato last_cod_stato last_denominazione nome_funz extra_par]

iter_set_func_class $funzione

# Personalizzo la pagina
set link_list_script {[export_url_vars cod_stato last_cod_stato last_denominazione caller nome_funz]&[iter_set_url_vars $extra_par]}
set link_list        [subst $link_list_script]
set titolo           "Stato"
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
                     [list coimstat-list?$link_list "Lista Stati"] \
                     "$page_title"]
}


# sproteggo la chiave solo in inserimento e gli attributi in inserimento e mod.
set form_name    "coimstat"
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


element create $form_name funzione      -widget hidden -datatype text -optional
element create $form_name caller        -widget hidden -datatype text -optional
element create $form_name nome_funz     -widget hidden -datatype text -optional
element create $form_name extra_par     -widget hidden -datatype text -optional
element create $form_name submit        -widget submit -datatype text -label "$button_label" -html "class form_submit"
element create $form_name last_denominazione -widget hidden -datatype text -optional
element create $form_name last_cod_stato -widget hidden -datatype text -optional
element create $form_name cod_stato -widget hidden -datatype text -optional

if {[form is_request $form_name]} {

    element set_properties $form_name funzione           -value $funzione
    element set_properties $form_name caller             -value $caller
    element set_properties $form_name nome_funz          -value $nome_funz
    element set_properties $form_name extra_par          -value $extra_par
    element set_properties $form_name last_denominazione -value $last_denominazione
    element set_properties $form_name last_cod_stato -value $last_cod_stato
    element set_properties $form_name cod_stato      -value $cod_stato

    set checked ""
    if {$funzione == "I"} {

    } else {
      # leggo riga
        if {[db_0or1row query "select denominazione
   	          	       , cod_istat
		               , sigla
		    from coimstat
		   where cod_stato = :cod_stato
"] == 0
        } {
            iter_return_complaint "Record non trovato"
	}

        element set_properties $form_name denominazione -value $denominazione
        element set_properties $form_name cod_istat     -value $cod_istat
        element set_properties $form_name sigla         -value $sigla
    }
}

if {[form is_valid $form_name]} {
  # form valido dal punto di vista del templating system

    set denominazione [element::get_value $form_name denominazione]
    set cod_istat     [element::get_value $form_name cod_istat]
    set sigla         [element::get_value $form_name sigla]

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


        if {[string equal $sigla ""]} {
            element::set_error $form_name sigla "Inserire Sigla"
            incr error_num
        } else {
            set sigla [string toupper $sigla]
        }


    }

    if {$funzione == "D"} {

	set conta 0
	if {$conta > 0} {
	    element::set_error $form_name denominazione "Stato non cancellabile: esistono cittadini collegati"
	    incr error_num
	}
    }
  
    if {$error_num > 0} {
        ad_return_template
        return
    }

    switch $funzione {
        I {db_1row query "select max(cod_stato::integer) + 1 as cod_stato from coimstat"
	   set dml_sql "insert into coimstat
                                  ( cod_stato, denominazione, cod_istat, sigla)
                           values (:cod_stato,:denominazione,:cod_istat,:sigla)"}
        M {set dml_sql "update coimstat
                           set denominazione = :denominazione
                             , cod_istat     = :cod_istat
                             , sigla         = :sigla
                         where cod_stato = :cod_stato"}
        D {set dml_sql "delete from coimstat
                         where cod_stato = :cod_stato"}
    }

  # Lancio la query di manipolazione dati contenute in dml_sql
    if {[info exists dml_sql]} {
        with_catch error_msg {
            db_transaction {
                db_dml dml_coimstat $dml_sql
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
        set last_cod_stato $cod_stato
        set last_denominazione $denominazione
    }
    set link_list      [subst $link_list_script]
    set link_gest      [export_url_vars cod_stato last_cod_stato last_denominazione nome_funz extra_par caller]
    switch $funzione {
        M {set return_url   "coimstat-gest?funzione=V&$link_gest"}
        D {set return_url   "coimstat-list?$link_list"}
        I {set return_url   "coimstat-gest?funzione=V&$link_gest"}
        V {set return_url   "coimstat-list?$link_list"}
    }

    ad_returnredirect $return_url
    ad_script_abort
}

ad_return_template
