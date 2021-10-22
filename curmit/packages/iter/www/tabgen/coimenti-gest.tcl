ad_page_contract {
    Add/Edit/Delete  form per la tabella "coimenti"
    @author          Tobia Loschiavo
    @creation-date   24/10/2005

    @param funzione  I=insert M=edit D=delete V=view
    @param caller    caller della lista da restituire alla lista:
                     serve se lista e' uno zoom che permetti aggiungi.
    @param nome_funz identifica l'entrata di menu, server per le autorizzazioni
                     serve se lista e' uno zoom che permetti aggiungi.
    @param nome_funz_caller identifica l'entrata di menu, serve per la 
                     navigazione con navigation bar
    @param extra_par Variabili extra da restituire alla lista
    @cvs-id          coimenti-gest.tcl
} {
    
   {cod_ente           ""}
   {cod_enre           ""}
   {last_denominazione ""}
   {funzione          "V"}
   {caller        "index"}
   {nome_funz          ""}
   {nome_funz_caller   ""}
   {extra_par          ""}
   {url_enve           ""}
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
set link_gest [export_url_vars cod_ente cod_enre last_denominazione nome_funz nome_funz_caller extra_par caller url_enve]
# imposta le class css della barra delle funzioni
iter_set_func_class $funzione

# controllo il parametro di "propagazione" per la navigation bar
if {[string is space $nome_funz_caller]} {
    set nome_funz_caller $nome_funz
}


# Personalizzo la pagina
set link_list_script {[export_url_vars cod_enre cod_ente last_denominazione caller nome_funz_caller nome_funz url_enve] &[iter_set_url_vars $extra_par]}
set link_list        [subst $link_list_script]
set titolo           "Ente competente per anomalie"
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
# compongo la testata
set den_enre ""
if {[db_0or1row sel_enti_denominenre {}] == 1} {
    set den_enre $enre_denominazione
}

set context_bar  [iter_context_bar -nome_funz $nome_funz_caller]

# sproteggo la chiave solo in inserimento e gli attributi in inserimento e mod.
set form_name    "coimenti"
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

element create $form_name denominazione \
-label   "denominazione" \
-widget   text \
-datatype text \
-html    "size 40 maxlength 40 $readonly_fld {} class form_element" \
-optional

element create $form_name indirizzo \
-label   "indirizzo" \
-widget   text \
-datatype text \
-html    "size 40 maxlength 40 $readonly_fld {} class form_element" \
-optional

element create $form_name numero \
-label   "numero" \
-widget   text \
-datatype text \
-html    "size 8 maxlength 8 $readonly_fld {} class form_element" \
-optional

element create $form_name cap \
-label   "cap" \
-widget   text \
-datatype text \
-html    "size 5 maxlength 5 $readonly_fld {} class form_element" \
-optional

element create $form_name localita \
-label   "localita" \
-widget   text \
-datatype text \
-html    "size 40 maxlength 40 $readonly_fld {} class form_element" \
-optional


element create $form_name comune \
-label   "comune" \
-widget   text \
-datatype text \
-html    "size 40 maxlength 40 $readonly_fld {} class form_element" \
-optional

element create $form_name provincia \
-label   "provincia" \
-widget   text \
-datatype text \
-html    "size 4 maxlength 4 $readonly_fld {} class form_element" \
-optional

element create $form_name cod_area \
-label   "cod_area" \
-widget   select \
-datatype text \
-html    "$disabled_fld {} class form_element tabindex 5" \
-optional \
-options [iter_selbox_from_table coimarea cod_area descrizione]


#aggiunta
element create $form_name cod_ente  -widget hidden -datatype text -optional
#fine-aggiunta
element create $form_name cod_enre  -widget hidden -datatype text -optional
element create $form_name url_enve  -widget hidden -datatype text -optional
element create $form_name funzione  -widget hidden -datatype text -optional
element create $form_name caller    -widget hidden -datatype text -optional
element create $form_name nome_funz -widget hidden -datatype text -optional
element create $form_name nome_funz_caller -widget hidden -datatype text -optional
element create $form_name extra_par -widget hidden -datatype text -optional
element create $form_name submit    -widget submit -datatype text -label "$button_label" -html "class form_submit"
element create $form_name last_denominazione -widget hidden -datatype text -optional

if {[form is_request $form_name]} {
    element set_properties $form_name funzione         -value $funzione
    element set_properties $form_name caller           -value $caller
    element set_properties $form_name nome_funz        -value $nome_funz
    element set_properties $form_name nome_funz_caller -value $nome_funz_caller
    element set_properties $form_name extra_par        -value $extra_par
    element set_properties $form_name url_enve         -value $url_enve
    element set_properties $form_name last_denominazione     -value $last_denominazione

    if {$funzione == "I"} {
      # valorizzo eventuali default!!
        element set_properties $form_name cod_enre -value $cod_enre
    } else {
      # leggo riga
        if {[db_0or1row sel_enti {}] == 0} {
            iter_return_complaint "Record non trovato"
	}

	element set_properties $form_name cod_enre -value $cod_enre
        element set_properties $form_name cod_ente -value $cod_ente
        element set_properties $form_name denominazione -value $denominazione
        element set_properties $form_name indirizzo -value $indirizzo
        element set_properties $form_name numero -value $numero
        element set_properties $form_name cap -value $cap
        element set_properties $form_name localita -value $localita
        element set_properties $form_name comune -value $comune
        element set_properties $form_name provincia -value $provincia
        element set_properties $form_name cod_area -value $cod_area

    }
}

if {[form is_valid $form_name]} {
  # form valido dal punto di vista del templating system

    set cod_enre [element::get_value $form_name cod_enre]
    set cod_ente [element::get_value $form_name cod_ente]
    set denominazione [element::get_value $form_name denominazione]
    set indirizzo [element::get_value $form_name indirizzo]
    set numero [element::get_value $form_name numero]
    set cap [element::get_value $form_name cap]
    set localita [element::get_value $form_name localita]
    set comune [element::get_value $form_name comune]
    set provincia [element::get_value $form_name provincia]
    set cod_area [element::get_value $form_name cod_area]


  # controlli standard su numeri e date, per Ins ed Upd
    set error_num 0
  if {$funzione == "I" || $funzione == "M"} {
        if {[string is space $cap]} { 
	    element::set_error $form_name cap "Il cap deve essere inizializzato."
	      incr error_num
	} else {
	    if {![string is integer -strict $cap]} { 
		element::set_error $form_name cap "Il cap deve essere numerico."
		incr error_num
	    }
	}

    }
  if {$funzione == "I"} {
       if {[db_0or1row sel_enti_denom_check {} ] == 1} {
	    element::set_error $form_name denominazione "La denominazione non &egrave univoca."
        incr error_num
       }
  }
     

  
    # TODO: inserire eventuali controlli CUSTOM, tra cui
    #       i controlli di integrita' referenziale per I/M e D.
    #       non contemplati dalle references.

   # if {$funzione  == "D"
   # &&  [db_0or1row sel_enti_check {}] == 1
   # } {
      # controllo univocita'/protezione da double_click
    #    element::set_error $form_name denominazione "Il record che stai tentando di inserire &egrave; gi&agrave; esistente nel Data Base."
    #    incr error_num
   # }

    if {$error_num > 0} {
        ad_return_template
        return
    }

    switch $funzione {
        I {
	    # valorizzo cod_ente con un progressivo per ogni cod_enre
	    set max [db_string sel_enti_max_cod_ente {}]
	    if {$max == ""} {
		set max 0
	    }
	    set cod_ente [expr $max + 1]
	    set dml_sql [db_map ins_enti]
	}
        M {set dml_sql [db_map upd_enti]}
        D {set dml_sql [db_map del_enti]}
    }

  # Lancio la query di manipolazione dati contenute in dml_sql
    if {[info exists dml_sql]} {
        with_catch error_msg {
            db_transaction {
                db_dml dml_coimenti $dml_sql
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
        set last_denominazione $denominazione
    }
    set link_list      [subst $link_list_script]
    set link_gest      [export_url_vars cod_ente cod_enre last_denominazione nome_funz nome_funz_caller extra_par caller url_enve]
    switch $funzione {
        M {set return_url   "coimenti-gest?funzione=V&$link_gest"}
        D {set return_url   "coimenti-list?$link_list"}
        I {set return_url   "coimenti-gest?funzione=V&$link_gest"}
        V {set return_url   "coimenti-list?$link_list"}
    }

    ad_returnredirect $return_url
    ad_script_abort
}

ad_return_template
