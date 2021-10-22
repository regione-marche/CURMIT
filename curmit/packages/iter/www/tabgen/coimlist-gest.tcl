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
    
    {cod_listino ""}
    {descrizione ""}
    {last_tari ""}
    {funzione  "V"}
    {caller    "index"}
    {nome_funz ""}
    {nome_funz_caller ""}
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
set link_gest [export_url_vars cod_listino last_tari nome_funz nome_funz_caller extra_par caller]
set link_add [export_url_vars cod_listino descrizione last_tari nome_funz_caller extra_par caller]ink
# imposta le class css della barra delle funzioni
iter_set_func_class $funzione

# controllo il parametro di "propagazione" per la navigation bar
if {[string is space $nome_funz_caller]} {
    set nome_funz_caller $nome_funz
}


# Personalizzo la pagina
# TODO: controllare impostazione della context_bar adattando come necessario
set link_list_script {[export_url_vars cod_listino last_tari caller nome_funz_caller nome_funz]&[iter_set_url_vars $extra_par]}
set link_list        [subst $link_list_script]
set titolo           "Listino"
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
set form_name    "coimlist"
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

element create $form_name cod_listino \
-label   "Codice Listino" \
-widget   text \
-datatype text \
-html    "size 8 maxlength 8 $readonly_key {} class form_element" \
-optional

element create $form_name descrizione \
-label   "Descrizione" \
-widget   text \
-datatype text \
-html    "size 25 maxlength 50 $readonly_fld {} class form_element" \
-optional

element create $form_name funzione  -widget hidden -datatype text -optional
element create $form_name caller    -widget hidden -datatype text -optional
element create $form_name nome_funz -widget hidden -datatype text -optional
element create $form_name extra_par -widget hidden -datatype text -optional
element create $form_name submit    -widget submit -datatype text -label "$button_label" -html "class form_submit"
element create $form_name last_tari -widget hidden -datatype text -optional

if {[form is_request $form_name]} {

    element set_properties $form_name funzione  -value $funzione
    element set_properties $form_name caller    -value $caller
    element set_properties $form_name nome_funz -value $nome_funz
    element set_properties $form_name extra_par -value $extra_par
    element set_properties $form_name last_tari -value $last_tari

    if {$funzione == "I"} {
        
    } else {
      # leggo riga
        if {[db_0or1row sel_tari {}] == 0} {
            iter_return_complaint "Record non trovato"
	}

	element set_properties $form_name cod_listino      -value $cod_listino
        element set_properties $form_name descrizione      -value $descrizione

    }
}

if {[form is_valid $form_name]} {
  # form valido dal punto di vista del templating system

    set cod_listino  [element::get_value $form_name cod_listino]
    set descrizione  [element::get_value $form_name descrizione]

  # controlli standard su numeri e date, per Ins ed Upd
    set error_num 0
    if {$funzione == "I"
    ||  $funzione == "M"
    } {

        if {[string equal $cod_listino ""]} {
            element::set_error $form_name cod_listino "Inserire Codice Listino"
            incr error_num
        } 

        if {[string equal $descrizione ""]} {
            element::set_error $form_name descrizione "Inserire Descrizione"
            incr error_num
        }
    }

    if {$funzione == "I"
    &&  $error_num == 0
    &&  [db_0or1row sel_tari_check {}] == 1
    } {
      # controllo univocita'/protezione da double_click
        element::set_error $form_name data_inizio "Il record che stai tentando di inserire &egrave; gi&agrave; esistente nel Data Base."
        incr error_num
    }

    if {$funzione == "D"
    &&  [db_0or1row sel_list_check {}] == 1
    } {
        element::set_error $form_name cod_listino "Il record che stai tentando di cancellare &egrave; collegato a delle tariffe"
        incr error_num
    }

    if {$error_num > 0} {
        ad_return_template
        return
    }

    switch $funzione {
        I {set dml_sql [db_map ins_tari]}
        M {set dml_sql [db_map upd_tari]}
        D {set dml_sql [db_map del_tari]}
    }

  # Lancio la query di manipolazione dati contenute in dml_sql
    if {[info exists dml_sql]} {
        with_catch error_msg {
            db_transaction {
                db_dml dml_coimtari $dml_sql
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
        set last_tari [list $cod_listino]
    }
    set link_list      [subst $link_list_script]
    set link_gest      [export_url_vars cod_listino last_tari nome_funz nome_funz_caller extra_par caller]
    set link_add       [export_url_vars cod_listino last_tari nome_funz_caller extra_par caller]
    switch $funzione {
        M {set return_url   "coimlist-gest?funzione=V&$link_gest"}
        D {set return_url   "coimlist-list?$link_list"}
        I {set return_url   "coimlist-gest?funzione=V&$link_gest"}
        V {set return_url   "coimlist-list?$link_list"}
    }

    ad_returnredirect $return_url
    ad_script_abort
}

ad_return_template
