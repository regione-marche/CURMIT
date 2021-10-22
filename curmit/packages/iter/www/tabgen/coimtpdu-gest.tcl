ad_page_contract {
    Add/Edit/Delete  form per la tabella "coimtpdu"
    @author          Katia Coazzoli Adhoc
    @creation-date   11/03/2004

    @param funzione  I=insert M=edit D=delete V=view
    @param caller    caller della lista da restituire alla lista:
                     serve se lista e' uno zoom che permetti aggiungi.
    @param nome_funz identifica l'entrata di menu, server per le autorizzazioni
                     serve se lista e' uno zoom che permetti aggiungi.
    @param extra_par Variabili extra da restituire alla lista
    @cvs-id          coimtpdu-gest.tcl
} {
    
   {cod_tpdu ""}
   {last_descr_tpdu ""}
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
# Se il programma e' 'delicato', mettere livello 5 (amministratore).

switch $funzione {
    "V" {set lvl 1}
    "I" {set lvl 2}
    "M" {set lvl 3}
    "D" {set lvl 4}
}
set id_utente [lindex [iter_check_login $lvl $nome_funz] 1]
set link_gest [export_url_vars cod_tpdu last_descr_tpdu nome_funz extra_par caller]
# imposta le class css della barra delle funzioni
iter_set_func_class $funzione

# Personalizzo la pagina
set link_list_script {[export_url_vars last_descr_tpdu caller nome_funz]&[iter_set_url_vars $extra_par]}
set link_list        [subst $link_list_script]
set titolo           "tipo destinazione d'uso"
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
                     [list coimtpdu-list?$link_list "Lista tipi destinazioni d'uso"] \
                     "$page_title"]
}


# sproteggo la chiave solo in inserimento e gli attributi in inserimento e mod.
set form_name    "coimtpdu"
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

element create $form_name cod_tpdu \
-label   "codice" \
-widget   text \
-datatype text \
-html    "size 8 maxlength 8 $readonly_key {} class form_element" \
-optional

element create $form_name descr_tpdu \
-label   "descr. tipi d'uso" \
-widget   text \
-datatype text \
-html    "size 45 maxlength 45 $readonly_fld {} class form_element" \
-optional


element create $form_name funzione  -widget hidden -datatype text -optional
element create $form_name caller    -widget hidden -datatype text -optional
element create $form_name nome_funz -widget hidden -datatype text -optional
element create $form_name extra_par -widget hidden -datatype text -optional
element create $form_name submit    -widget submit -datatype text -label "$button_label" -html "class form_submit"
element create $form_name last_descr_tpdu -widget hidden -datatype text -optional

if {[form is_request $form_name]} {

    element set_properties $form_name funzione        -value $funzione
    element set_properties $form_name caller          -value $caller
    element set_properties $form_name nome_funz       -value $nome_funz
    element set_properties $form_name extra_par       -value $extra_par
    element set_properties $form_name last_descr_tpdu -value $last_descr_tpdu

    if {$funzione == "I"} {
        
    } else {
      # leggo riga
        if {[db_0or1row sel_tpdu {}] == 0} {
            iter_return_complaint "Record non trovato"
	}

        element set_properties $form_name cod_tpdu   -value $cod_tpdu
        element set_properties $form_name descr_tpdu -value $descr_tpdu

    }
}

if {[form is_valid $form_name]} {
  # form valido dal punto di vista del templating system

    set cod_tpdu   [element::get_value $form_name cod_tpdu]
    set descr_tpdu [element::get_value $form_name descr_tpdu]


  # controlli standard su numeri e date, per Ins ed Upd
    set error_num 0
    if {$funzione == "I"
    ||  $funzione == "M"
    } {

        if {[string equal $cod_tpdu ""]} {
            element::set_error $form_name cod_tpdu "Inserire codice"
            incr error_num
        }

        if {[string equal $descr_tpdu ""]} {
            element::set_error $form_name descr_tpdu "Inserire descr. tipi d'uso"
            incr error_num
        }
 
	if {$funzione == "M"} {
	    set where_cod "and cod_tpdu <> :cod_tpdu"
	} else {
	    set where_cod ""
	}
        
        if {[db_0or1row check_desc ""] == 1} {
            element::set_error $form_name descr_tpdu "La descrizione inserita &egrave; gi&agrave; censita nella base-dati"
            incr error_num
	}
    }

    if {$funzione == "I"
    &&  $error_num == 0
    &&  [db_0or1row sel_tpdu_check {}] == 1
    } {
     # controllo univocita'/protezione da double_click
        element::set_error $form_name cod_tpdu "Il record che stai tentando di inserire &egrave; gi&agrave; esistente nel Data Base."
        incr error_num
    }

    if {$funzione == "D"
    &&  [db_0or1row sel_aimp_check {}] == 1
    } {
        element::set_error $form_name cod_tpdu "Il record che stai tentando di cancellare &egrave; collegato a degli impianti"
        incr error_num
    }

    if {$error_num > 0} {
        ad_return_template
        return
    }

    switch $funzione {
        I {set dml_sql [db_map ins_tpdu]}
        M {set dml_sql [db_map upd_tpdu]}
        D {set dml_sql [db_map del_tpdu]}
    }

  # Lancio la query di manipolazione dati contenute in dml_sql
    if {[info exists dml_sql]} {
        with_catch error_msg {
            db_transaction {
                db_dml dml_coimtpdu $dml_sql
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
        set last_descr_tpdu $descr_tpdu
    }
    set link_list      [subst $link_list_script]
    set link_gest      [export_url_vars cod_tpdu last_descr_tpdu nome_funz extra_par caller]
    switch $funzione {
        M {set return_url   "coimtpdu-gest?funzione=V&$link_gest"}
        D {set return_url   "coimtpdu-list?$link_list"}
        I {set return_url   "coimtpdu-gest?funzione=V&$link_gest"}
        V {set return_url   "coimtpdu-list?$link_list"}
    }

    ad_returnredirect $return_url
    ad_script_abort
}

ad_return_template
