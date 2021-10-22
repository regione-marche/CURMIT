ad_page_contract {
    Add/Edit/Delete  form per la tabella "coimtpnu"
    @author          Adhoc
    @creation-date   04/03/2004

    @param funzione  I=insert M=edit D=delete V=view
    @param caller    caller della lista da restituire alla lista:
                     serve se lista e' uno zoom che permetti aggiungi.
    @param nome_funz identifica l'entrata di menu, server per le autorizzazioni
                     serve se lista e' uno zoom che permetti aggiungi.
    @param extra_par Variabili extra da restituire alla lista
    @cvs-id          coimtpnu-gest.tcl
} {
    
   {cod_tpnu ""}
   {last_descr ""}
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
set link_gest [export_url_vars cod_tpnu last_descr nome_funz extra_par caller]
# imposta le class css della barra delle funzioni
iter_set_func_class $funzione

# Personalizzo la pagina
set link_list_script {[export_url_vars last_descr caller nome_funz]&[iter_set_url_vars $extra_par]}
set link_list        [subst $link_list_script]
set titolo           "Tipo progressivo"
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
                     [list coimtpnu-list?$link_list "Lista tipi progressivo"] \
                     "$page_title"]
}


# sproteggo la chiave solo in inserimento e gli attributi in inserimento e mod.
set form_name    "coimtpnu"
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

element create $form_name cod_tpnu \
-label   "Codice" \
-widget   text \
-datatype text \
-html    "size 8 maxlength 8 $readonly_key {} class form_element" \
-optional

element create $form_name descr \
-label   "Descrizione" \
-widget   text \
-datatype text \
-html    "size 50 maxlength 100 $readonly_fld {} class form_element" \
-optional


element create $form_name descr_est \
-label   "Descrizione estesa" \
-widget   textarea \
-datatype text \
-html    "cols 50 rows 5 $readonly_fld {} class form_element" \
-optional

element create $form_name progressivo \
-label   "Progressivo" \
-widget   text \
-datatype integer \
-html    "size 10 maxlength 10 $readonly_fld {} class form_element" \
-optional


element create $form_name funzione  -widget hidden -datatype text -optional
element create $form_name caller    -widget hidden -datatype text -optional
element create $form_name nome_funz -widget hidden -datatype text -optional
element create $form_name extra_par -widget hidden -datatype text -optional
element create $form_name submit    -widget submit -datatype text -label "$button_label" -html "class form_submit"
element create $form_name last_descr -widget hidden -datatype text -optional

if {[form is_request $form_name]} {

    element set_properties $form_name funzione  -value $funzione
    element set_properties $form_name caller    -value $caller
    element set_properties $form_name nome_funz -value $nome_funz
    element set_properties $form_name extra_par -value $extra_par
    element set_properties $form_name last_descr -value $last_descr

    if {$funzione == "I"} {

    } else {
      # leggo riga
        if {[db_0or1row sel_tpnu {}] == 0} {
            iter_return_complaint "Record non trovato"
	}
        element set_properties $form_name cod_tpnu         -value $cod_tpnu
        element set_properties $form_name descr            -value $descr
        element set_properties $form_name descr_est        -value $descr_est
        element set_properties $form_name progressivo      -value $progressivo

    }
}

if {[form is_valid $form_name]} {
  # form valido dal punto di vista del templating system

    set cod_tpnu         [element::get_value $form_name cod_tpnu]
    set descr            [element::get_value $form_name descr]
    set descr_est        [element::get_value $form_name descr_est]
    set progressivo      [element::get_value $form_name progressivo]

  # controlli standard su numeri e date, per Ins ed Upd
    set error_num 0
    if {$funzione == "I"
    ||  $funzione == "M"
    } {

	if {$funzione == "I"} {
	    set where_cod ""
	} else {
	    set where_cod " and cod_tpnu <> :cod_tpnu"
	}

        if {[string equal $cod_tpnu ""]} {
            element::set_error $form_name cod_tpnu "Inserire Codice"
            incr error_num
        } else {
	    if {[db_0or1row sel_tpnu_2 ""] == 0} {
		set conta 0
	    }
	    if {$conta > 0} {
		element::set_error $form_name cod_tpnu "Codice gi&agrave; presente"
		incr error_num
	    }
	}
		

        if {[string equal $descr ""]} {
            element::set_error $form_name descr "Inserire Descrizione"
            incr error_num
        }

        if {[string equal $progressivo ""]} {
            element::set_error $form_name progressivo "Inserire progressivo"
            incr error_num
        }


    }

    if {$funzione == "I"
    &&  $error_num == 0
    &&  [db_0or1row sel_tpnu_check {}] == 1
    } {
      # controllo univocita'/protezione da double_click
        element::set_error $form_name cod_tpnu "Il record che stai tentando di inserire &egrave; gi&agrave; esistente nel Data Base."
        incr error_num
    }

    if {$error_num > 0} {
        ad_return_template
        return
    }

    switch $funzione {
        I {set dml_sql [db_map ins_tpnu]}
        M {set dml_sql [db_map upd_tpnu]}
        D {set dml_sql [db_map del_tpnu]}
    }

  # Lancio la query di manipolazione dati contenute in dml_sql
    if {[info exists dml_sql]} {
        with_catch error_msg {
            db_transaction {
                db_dml dml_coimtpnu $dml_sql
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
        set last_descr $descr
    }
    set link_list      [subst $link_list_script]
    set link_gest      [export_url_vars cod_tpnu last_descr nome_funz extra_par caller]
    switch $funzione {
        M {set return_url   "coimtpnu-gest?funzione=V&$link_gest"}
        D {set return_url   "coimtpnu-list?$link_list"}
        I {set return_url   "coimtpnu-gest?funzione=V&$link_gest"}
        V {set return_url   "coimtpnu-list?$link_list"}
    }

    ad_returnredirect $return_url
    ad_script_abort
}

ad_return_template
