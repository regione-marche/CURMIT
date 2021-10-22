ad_page_contract {
    Add/Edit/Delete  form per la tabella "coimragr"
    @author          Gianni Prosperi
    @creation-date   07/06/2007

    @param funzione  I=insert M=edit D=delete V=view
    @param caller    caller della lista da restituire alla lista:
                     serve se lista e' uno zoom che permetti aggiungi.
    @param nome_funz identifica l'entrata di menu, server per le autorizzazioni
                     serve se lista e' uno zoom che permetti aggiungi.
    @param nome_funz_caller identifica l'entrata di menu, serve per la 
                     navigazione con navigation bar
    @param extra_par Variabili extra da restituire alla lista
    @cvs-id          coimragr-gest.tcl
} {
    
    {cod_raggruppamento ""}
    {last_ragr    ""}
    {funzione    "V"}
    {caller  "index"}
    {nome_funz    ""}
    {nome_funz_caller ""}
    {extra_par    ""}
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
set link_gest [export_url_vars cod_raggruppamento last_ragr nome_funz nome_funz_caller extra_par caller]
set link_add [export_url_vars cod_ragruppamento last_ragr nome_funz_caller extra_par caller]ink
# imposta le class css della barra delle funzioni
iter_set_func_class $funzione

# controllo il parametro di "propagazione" per la navigation bar
if {[string is space $nome_funz_caller]} {
    set nome_funz_caller $nome_funz
}

# Personalizzo la pagina
# TODO: controllare impostazione della context_bar adattando come necessario
set link_list_script {[export_url_vars cod_raggruppamento last_ragr caller nome_funz_caller nome_funz]&[iter_set_url_vars $extra_par]}
set link_list        [subst $link_list_script]
set titolo           "Raggruppamento Pesi"
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
set form_name    "coimragr"
set readonly_key "readonly"
set readonly_fld "readonly"
set disabled_fld "disabled"
set disabled_key "disabled"
set onsubmit_cmd ""
switch $funzione {
   "I" {set readonly_key \{\}
        set readonly_fld \{\}
        set disabled_fld \{\}
        set disabled_key \{\}
       }
   "M" {set readonly_fld \{\}
        set disabled_fld \{\}
       }
}

form create $form_name \
-html    $onsubmit_cmd

element create $form_name cod_raggruppamento \
-label   "Codice Raggruppamento" \
-widget   text \
-datatype text \
-html    "size 8 maxlength 8 readonly {} class form_element" \
-optional

element create $form_name descrizione \
-label   "Descrizione" \
-widget   text \
-datatype text \
-html    "size 25 maxlength 50 $readonly_fld {} class form_element" \
-optional

element create $form_name peso_da \
-label   "peso minimo" \
-widget   text \
-datatype text \
-html    "size 20 maxlength 9 $readonly_fld {} class form_element" \
-optional

element create $form_name peso_a \
-label   "peso massimo." \
-widget   text \
-datatype text \
-html    "size 20 maxlength 9 $readonly_fld {} class form_element" \
-optional

element create $form_name funzione  -widget hidden -datatype text -optional
element create $form_name caller    -widget hidden -datatype text -optional
element create $form_name nome_funz -widget hidden -datatype text -optional
element create $form_name extra_par -widget hidden -datatype text -optional
element create $form_name submit    -widget submit -datatype text -label "$button_label" -html "class form_submit"
element create $form_name last_ragr -widget hidden -datatype text -optional

if {[form is_request $form_name]} {

    element set_properties $form_name funzione  -value $funzione
    element set_properties $form_name caller    -value $caller
    element set_properties $form_name nome_funz -value $nome_funz
    element set_properties $form_name extra_par -value $extra_par
    element set_properties $form_name last_ragr -value $last_ragr

    if {$funzione == "I"} {
    } else {
      # leggo riga
        if {[db_0or1row sel_ragr {}] == 0} {
            iter_return_complaint "Record non trovato"
	}

	element set_properties $form_name cod_raggruppamento     -value $cod_raggruppamento
        element set_properties $form_name descrizione           -value $descrizione
        element set_properties $form_name peso_da               -value $peso_da
        element set_properties $form_name peso_a                -value $peso_a
    }
}

if {[form is_valid $form_name]} {
  # form valido dal punto di vista del templating system

    set cod_raggruppamento  [element::get_value $form_name cod_raggruppamento]
    set descrizione         [element::get_value $form_name descrizione]
    set peso_da             [element::get_value $form_name peso_da]
    set peso_a              [element::get_value $form_name peso_a]

  # controlli standard su numeri e date, per Ins ed Upd
    set error_num 0
    if {$funzione == "I"
    ||  $funzione == "M"
    } {
	db_1row sel_ragr_s ""
    }

    if {[string equal $descrizione ""]} {
	element::set_error $form_name descrizione "inserire"
	incr error_num
    }

    if {[string equal $peso_da ""]} {
	element::set_error $form_name peso_da "inserire"
	incr error_num
    } else {
	set peso_da [iter_check_num $peso_da 0]
	if {$peso_da == "Error"} {
	    element::set_error $form_name peso_da "campo numerico"
	    incr error_num
	}
    }

    if {[string equal $peso_a ""]} {
	element::set_error $form_name peso_a "inserire"
	incr error_num
    } else {
	set peso_a [iter_check_num $peso_a 0]
	if {$peso_a == "Error"} {
	    element::set_error $form_name peso_a "campo numerico"
	    incr error_num
	}
    }

    if {$funzione == "I"
    &&  $error_num == 0
    &&  [db_0or1row sel_ragr_check {}] == 1
    } {
      # controllo univocita'/protezione da double_click
        element::set_error $form_name cod_raggruppamento "Il record che stai tentando di inserire &egrave; gi&agrave; esistente nel Data Base."
        incr error_num
    }



    if {$error_num > 0} {
        ad_return_template
        return
    }

    switch $funzione {
        I {set dml_sql [db_map ins_ragr]}
        M {set dml_sql [db_map upd_ragr]}
        D {set dml_sql [db_map del_ragr]}
    }

  # Lancio la query di manipolazione dati contenute in dml_sql
    if {[info exists dml_sql]} {
        with_catch error_msg {
            db_transaction {
                db_dml dml_coimragr $dml_sql
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
        set last_ragr $cod_raggruppamento
    }
    set link_list      [subst $link_list_script]
    set link_gest      [export_url_vars cod_raggruppamento last_ragr nome_funz nome_funz_caller extra_par caller]
    set link_add       [export_url_vars cod_raggruppamento last_ragr nome_funz_caller extra_par caller]
    switch $funzione {
        M {set return_url   "coimragr-gest?funzione=V&$link_gest"}
        D {set return_url   "coimragr-list?$link_list"}
        I {set return_url   "coimragr-gest?funzione=V&$link_gest"}
        V {set return_url   "coimragr-list?$link_list"}
    }

    ad_returnredirect $return_url
    ad_script_abort
}

ad_return_template
