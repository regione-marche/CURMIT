ad_page_contract {
    Add/Edit/Delete  form per la tabella "coimlist"
    @author          Giulio Laurenzi
    @creation-date   19/05/2004

    @param funzione  I=insert M=edit D=delete V=view
    @param caller    caller della lista da restituire alla lista:
                     serve se lista e' uno zoom che permetti aggiungi.
    @param nome_funz identifica l'entrata di menu, server per le autorizzazioni
                     serve se lista e' uno zoom che permetti aggiungi.
    @param nome_funz_caller identifica l'entrata di menu, serve per la 
                     navigazione con navigation bar
    @param extra_par Variabili extra da restituire alla lista
    @cvs-id          coimlist-gest.tcl
} {
    
    {cod_sanzione ""}
    {last_sanz    ""}
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
set link_gest [export_url_vars cod_sanzione last_sanz nome_funz nome_funz_caller extra_par caller]
set link_add [export_url_vars cod_sanzione last_sanz nome_funz_caller extra_par caller]ink
# imposta le class css della barra delle funzioni
iter_set_func_class $funzione

# controllo il parametro di "propagazione" per la navigation bar
if {[string is space $nome_funz_caller]} {
    set nome_funz_caller $nome_funz
}

# Personalizzo la pagina
# TODO: controllare impostazione della context_bar adattando come necessario
set link_list_script {[export_url_vars cod_sanzione last_sanz caller nome_funz_caller nome_funz]&[iter_set_url_vars $extra_par]}
set link_list        [subst $link_list_script]
set titolo           "Sanzione"
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
set form_name    "coimsanz"
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

element create $form_name cod_sanzione \
-label   "Codice Sanzione" \
-widget   text \
-datatype text \
-html    "size 8 maxlength 8 $readonly_key {} class form_element" \
-optional

element create $form_name descr_breve \
-label   "Descrizione" \
-widget   text \
-datatype text \
-html    "size 25 maxlength 50 $readonly_fld {} class form_element" \
-optional

element create $form_name descr_estesa \
-label   "Descrizione" \
-widget   text \
-datatype text \
-html    "size 50 maxlength 50 $readonly_fld {} class form_element" \
-optional

element create $form_name importo_min \
-label   "imp. min." \
-widget   text \
-datatype text \
-html    "size 25 maxlength 50 $readonly_fld {} class form_element" \
-optional

element create $form_name importo_max \
-label   "imp. max." \
-widget   text \
-datatype text \
-html    "size 25 maxlength 50 $readonly_fld {} class form_element" \
-optionl

element create $form_name tipo_soggetto \
-label   "tipo sogg." \
-widget   select \
-datatype text \
-html    "size 1 maxlength 1 $disabled_fld {} class form_element" \
-optional \
-options {{{} {}} {Responsabile R} {Manutentore M} {Distributore D}}

element create $form_name funzione  -widget hidden -datatype text -optional
element create $form_name caller    -widget hidden -datatype text -optional
element create $form_name nome_funz -widget hidden -datatype text -optional
element create $form_name extra_par -widget hidden -datatype text -optional
element create $form_name submit    -widget submit -datatype text -label "$button_label" -html "class form_submit"
element create $form_name last_sanz -widget hidden -datatype text -optional

if {[form is_request $form_name]} {

    element set_properties $form_name funzione  -value $funzione
    element set_properties $form_name caller    -value $caller
    element set_properties $form_name nome_funz -value $nome_funz
    element set_properties $form_name extra_par -value $extra_par
    element set_properties $form_name last_sanz -value $last_sanz

    if {$funzione == "I"} {
        
    } else {
      # leggo riga
        if {[db_0or1row sel_sanz {}] == 0} {
            iter_return_complaint "Record non trovato"
	}

	element set_properties $form_name cod_sanzione     -value $cod_sanzione
        element set_properties $form_name descr_breve      -value $descr_breve
        element set_properties $form_name descr_estesa     -value $descr_estesa
        element set_properties $form_name importo_min      -value $importo_min
        element set_properties $form_name importo_max      -value $importo_max
        element set_properties $form_name tipo_soggetto    -value $tipo_soggetto
    }
}

if {[form is_valid $form_name]} {
  # form valido dal punto di vista del templating system

    set cod_sanzione  [element::get_value $form_name cod_sanzione]
    set descr_breve   [element::get_value $form_name descr_breve]
    set descr_estesa  [element::get_value $form_name descr_estesa]
    set importo_min   [element::get_value $form_name importo_min]
    set importo_max   [element::get_value $form_name importo_max]
    set tipo_soggetto [element::get_value $form_name tipo_soggetto]

  # controlli standard su numeri e date, per Ins ed Upd
    set error_num 0
    if {$funzione == "I"
    ||  $funzione == "M"
    } {

        if {[string equal $cod_sanzione ""]} {
            element::set_error $form_name cod_sanzione "Inserire Codice Sanzione"
            incr error_num
        } 
    }

    if {![string equal $importo_min ""]} {
	set importo_min [iter_check_num $importo_min 2]
	if {$importo_min == "Error"} {
	    element::set_error $form_name importo_min "numerico con al massimo 2 decimali"
	    incr error_num
	}
    }

    if {![string equal $importo_max ""]} {
	set importo_max [iter_check_num $importo_max 2]
	if {$importo_max == "Error"} {
	    element::set_error $form_name importo_max "numerico con al massimo 2 decimali"
	    incr error_num
	}
    }

    if {$funzione == "I"
    &&  $error_num == 0
    &&  [db_0or1row sel_sanz_check {}] == 1
    } {
      # controllo univocita'/protezione da double_click
        element::set_error $form_name cod_sanzione "Il record che stai tentando di inserire &egrave; gi&agrave; esistente nel Data Base."
        incr error_num
    }

#    if {$funzione == "D"
#    &&  [db_0or1row sel_movi_check {}] == 1
#    } {
#        element::set_error $form_name cod_sanzione "Il record che stai tentando di cancellare &egrave; collegato a dei pagamenti"
#        incr error_num
#    }

    if {$error_num > 0} {
        ad_return_template
        return
    }

    switch $funzione {
        I {db_1row sel_sanz_s ""
           set dml_sql [db_map ins_sanz]}
        M {set dml_sql [db_map upd_sanz]}
        D {set dml_sql [db_map del_sanz]}
    }

  # Lancio la query di manipolazione dati contenute in dml_sql
    if {[info exists dml_sql]} {
        with_catch error_msg {
            db_transaction {
                db_dml dml_coimsanz $dml_sql
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
        set last_sanz $cod_sanzione
    }
    set link_list      [subst $link_list_script]
    set link_gest      [export_url_vars cod_sanzione last_sanz nome_funz nome_funz_caller extra_par caller]
    set link_add       [export_url_vars cod_sanzione last_sanz nome_funz_caller extra_par caller]
    switch $funzione {
        M {set return_url   "coimsanz-gest?funzione=V&$link_gest"}
        D {set return_url   "coimsanz-list?$link_list"}
        I {set return_url   "coimsanz-gest?funzione=V&$link_gest"}
        V {set return_url   "coimsanz-list?$link_list"}
    }

    ad_returnredirect $return_url
    ad_script_abort
}

ad_return_template
