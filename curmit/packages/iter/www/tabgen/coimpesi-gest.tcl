ad_page_contract {
    Add/Edit/Delete  form per la tabella "coimpesi"
    @author          Valentina Catte
    @creation-date   07/06/2007

    @param funzione  I=insert M=edit D=delete V=view
    @param caller    caller della lista da restituire alla lista:
                     serve se lista e' uno zoom che permetti aggiungi.
    @param nome_funz identifica l'entrata di menu, server per le autorizzazioni
                     serve se lista e' uno zoom che permetti aggiungi.
    @param nome_funz_caller identifica l'entrata di menu, serve per la 
                     navigazione con navigation bar
    @param extra_par Variabili extra da restituire alla lista
    @cvs-id          coimpesi-gest.tcl
} {
    
    {nome_campo   ""}
    {tipo_peso    ""}
    {last_campo   ""}
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
set link_gest [export_url_vars nome_campo tipo_peso last_campo nome_funz nome_funz_caller extra_par caller]
set link_add [export_url_vars nome_campo tipo_peso last_campo nome_funz_caller extra_par caller]ink
# imposta le class css della barra delle funzioni
iter_set_func_class $funzione

# controllo il parametro di "propagazione" per la navigation bar
if {[string is space $nome_funz_caller]} {
    set nome_funz_caller $nome_funz
}

# Personalizzo la pagina
# TODO: controllare impostazione della context_bar adattando come necessario
set link_list_script {[export_url_vars nome_campo tipo_peso last_campo caller nome_funz_caller nome_funz]&[iter_set_url_vars $extra_par]}
set link_list        [subst $link_list_script]
set titolo           "Gestione Pesi"
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
set form_name    "coimpesi"
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

element create $form_name nome_campo \
-label   "Nome Campo" \
-widget   text \
-datatype text \
-html    "size 20 maxlength 30 readonly {} class form_element" \
-optional

element create $form_name codice_esterno \
-label   "Descrizione" \
-widget   text \
-datatype text \
-html    "size 20 maxlength 20 $readonly_fld {} class form_element" \
-optional

element create $form_name descrizione_dimp \
-label   "Descrione dimp" \
-widget   text \
-datatype text \
-html    "size 50 maxlength 200 readonly {} class form_element" \
-optional

element create $form_name descrizione_uten \
-label   "Descrizione utente" \
-widget   text \
-datatype text \
-html    "size 50 maxlength 200 $readonly_fld {} class form_element" \
-optional

element create $form_name peso \
-label   "Peso" \
-widget   text \
-datatype text \
-html    "maxlength 9 $readonly_fld {} class form_element" \
-optional

if {$funzione eq "I"} {
    element create $form_name tipo_peso \
	-label   "Tipo Peso" \
	-widget   select \
	-datatype text \
	-html    "disabled {} class form_element" \
	-optional \
	-options {{} {} {No N} {N.C. C} {N.A. A}}
} else {
    element create $form_name tipo_peso_ed \
	-label   "Tipo Peso" \
	-widget   text \
	-datatype text \
	-html    " size 3 disabled {} class form_element" \
	-optional \
	-options 
element create $form_name tipo_peso   -widget hidden -datatype text -optional
}



element create $form_name cod_raggruppamento \
-label   "raggruppamento" \
-widget   select \
-datatype text \
-html    "$disabled_fld {} class form_element" \
-optional \
-options [iter_selbox_from_table coimragr cod_raggruppamento descrizione]

element create $form_name funzione   -widget hidden -datatype text -optional
element create $form_name caller     -widget hidden -datatype text -optional
element create $form_name nome_funz  -widget hidden -datatype text -optional
element create $form_name extra_par  -widget hidden -datatype text -optional
element create $form_name submit     -widget submit -datatype text -label "$button_label" -html "class form_submit"
element create $form_name last_campo -widget hidden -datatype text -optional

if {[form is_request $form_name]} {

    element set_properties $form_name funzione   -value $funzione
    element set_properties $form_name caller     -value $caller
    element set_properties $form_name nome_funz  -value $nome_funz
    element set_properties $form_name extra_par  -value $extra_par
    element set_properties $form_name last_campo -value $last_campo

    if {$funzione == "I"} {
    } else {
      # leggo riga
        if {[db_0or1row sel_pesi {}] == 0} {
            iter_return_complaint "Record non trovato"
	}

        element set_properties $form_name nome_campo             -value $nome_campo
        element set_properties $form_name codice_esterno         -value $codice_esterno
        element set_properties $form_name descrizione_dimp       -value $descrizione_dimp
        element set_properties $form_name descrizione_uten       -value $descrizione_uten
        element set_properties $form_name peso                   -value $peso
        element set_properties $form_name tipo_peso_ed           -value $tipo_peso_ed
	element set_properties $form_name tipo_peso              -value $tipo_peso
	element set_properties $form_name cod_raggruppamento     -value $cod_raggruppamento

    }
}

if {[form is_valid $form_name]} {
  # form valido dal punto di vista del templating system

    set nome_campo             [element::get_value $form_name nome_campo]
    set codice_esterno         [element::get_value $form_name codice_esterno]
    set descrizione_dimp       [element::get_value $form_name descrizione_dimp]
    set descrizione_uten       [element::get_value $form_name descrizione_uten]
    set peso                   [element::get_value $form_name peso]
    set tipo_peso              [element::get_value $form_name tipo_peso]
    set cod_raggruppamento     [element::get_value $form_name cod_raggruppamento]

  # controlli standard su numeri e date, per Ins ed Upd
    set error_num 0
    if {$funzione == "I"
    ||  $funzione == "M"
    } {
	
	if {![string equal $peso ""]} {
	    set peso [iter_check_num $peso 0]
	    if {$peso == "Error"} {
		element::set_error $form_name peso "campo numerico"
		incr error_num
	    }
	}

        if {![string equal $peso ""]
	    && [string equal $cod_raggruppamento ""]} {
	    db_0or1row sel_ragr "select cod_raggruppamento from coimragr where :peso between peso_da and peso_a"

	}

        if {![string equal $peso ""]
	    && ![string equal $cod_raggruppamento ""]} {
	    if {[db_0or1row sel_ragr "select cod_raggruppamento as cod_ragr_check from coimragr where :peso between peso_da and peso_a"] == 1} {
		if {$cod_raggruppamento != $cod_ragr_check} {
		    element::set_error $form_name peso "Peso non compreso nel raggruppamento selezionato"
		    incr error_num
		}
	    } else {
		element::set_error $form_name peso "Peso non compreso nel raggruppamento selezionato"
		incr error_num
	    }
	}
    }

    if {$error_num > 0} {
        ad_return_template
        return
    }

    switch $funzione {
        I {set dml_sql [db_map ins_pesi]}
        M {set dml_sql [db_map upd_pesi]}
        D {set dml_sql [db_map del_pesi]}
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
        set last_campo $nome_campo
    }
    set link_list      [subst $link_list_script]
    set link_gest      [export_url_vars nome_campo tipo_peso last_campo nome_funz nome_funz_caller extra_par caller]
    set link_add       [export_url_vars nome_campo tipo_peso last_campo nome_funz_caller extra_par caller]
    switch $funzione {
        M {set return_url   "coimpesi-gest?funzione=V&$link_gest"}
        D {set return_url   "coimpesi-list?$link_list"}
        I {set return_url   "coimpesi-gest?funzione=V&$link_gest"}
        V {set return_url   "coimpesi-list?$link_list"}
    }

    ad_returnredirect $return_url
    ad_script_abort
}

ad_return_template
