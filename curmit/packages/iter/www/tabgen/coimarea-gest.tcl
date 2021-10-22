ad_page_contract {
    Add/Edit/Delete  form per la tabella "coimarea"
    @author          Adhoc
    @creation-date   19/02/2004

    @param funzione  I=insert M=edit D=delete V=view
    @param caller    caller della lista da restituire alla lista:
                     serve se lista e' uno zoom che permetti aggiungi.
    @param nome_funz identifica l'entrata di menu, server per le autorizzazioni
                     serve se lista e' uno zoom che permetti aggiungi.
    @param extra_par Variabili extra da restituire alla lista
    @cvs-id          coimarea-gest.tcl
} {
   {cod_area      ""}
   {last_cod_area ""}
   {funzione     "V"}
   {caller   "index"}
   {nome_funz     ""}
   {nome_funz_caller ""}
   {extra_par     ""}
   {url_list_area ""}
   {url_area ""}
   {cod_comune ""}
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
    "D2" {set lvl 4}
}

if {[string equal $url_area ""]} {
    set url_area  [list [ad_conn url]?[export_ns_set_vars url "url_list_area url_area"]]
}
set id_utente [lindex [iter_check_login $lvl $nome_funz] 1]
set link_gest [export_url_vars cod_area last_cod_area nome_funz nome_funz_caller url_list_area url_area extra_par]

# controllo il parametro di "propagazione" per la navigation bar
if {[string is space $nome_funz_caller]} {
    set nome_funz_caller $nome_funz
}

set curr_prog       [file tail [ns_conn url]]

if {$funzione == "D2"} {
    set comu_canc $cod_comune

    set dml_sql [db_map del_cmar]
    # Lancio la query di manipolazione dati contenute in dml_sql
    if {[info exists dml_sql]} {
	with_catch error_msg {
	    db_transaction {
		db_dml dml_coimcmar $dml_sql
	    }
	} {
	    iter_return_complaint "Spiacente, ma il DBMS ha restituito il
            seguente messaggio di errore <br><b>$error_msg</b><br>
            Contattare amministratore di sistema e comunicare il messaggio
            d'errore. Grazie."
	}
    }
    
    set link    "\[export_url_vars cod_area nome_funz nome_funz_caller extra_par url_list_area url_area\]"
    
    ad_returnredirect $curr_prog?funzione=M&[export_url_vars cod_area nome_funz nome_funz_caller extra_par url_list_area url_area]
    ad_script_abort
}


iter_set_func_class $funzione

if {$funzione != "I"} {
   set dett_tab [iter_tab_area $cod_area]
}

# Personalizzo la pagina
set link_list_script {[export_url_vars last_cod_area caller nome_funz nome_funz_caller url_list_area url_area]&[iter_set_url_vars $extra_par]}
set link_list        [subst $link_list_script]
set titolo           "Area geografica"
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
                     [list coimarea-list?$link_list "Lista Aree geografiche"] \
                     "$page_title"]
}

# sproteggo la chiave solo in inserimento e gli attributi in inserimento e mod.
set form_name    "coimarea"
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

element create $form_name descrizione \
-label   "Descrizione" \
-widget   text \
-datatype text \
-html    "size 50 maxlength 50 $readonly_fld {} class form_element" \
-optional

element create $form_name funzione      -widget hidden -datatype text -optional
element create $form_name caller        -widget hidden -datatype text -optional
element create $form_name nome_funz     -widget hidden -datatype text -optional
element create $form_name extra_par     -widget hidden -datatype text -optional
element create $form_name submit        -widget submit -datatype text -label "$button_label" -html "class form_submit"
element create $form_name last_cod_area -widget hidden -datatype text -optional
element create $form_name cod_area      -widget hidden -datatype text -optional
element create $form_name url_area      -widget hidden -datatype text -optional
element create $form_name url_list_area -widget hidden -datatype text -optional

set link_aggiungi ""
set table_result ""
if {[form is_request $form_name]} {

    element set_properties $form_name funzione      -value $funzione
    element set_properties $form_name caller        -value $caller
    element set_properties $form_name nome_funz     -value $nome_funz
    element set_properties $form_name extra_par     -value $extra_par
    element set_properties $form_name last_cod_area -value $last_cod_area
    element set_properties $form_name cod_area      -value $cod_area
    element set_properties $form_name url_list_area -value $url_list_area
    element set_properties $form_name url_area      -value $url_area


    if {$funzione == "I"} {

    } else {
	
	# leggo riga
        if {[db_0or1row sel_area ""] == 0
        } {
            iter_return_complaint "Record non trovato"
	}

        element set_properties $form_name descrizione -value $descrizione

 #####
	set link    "\[export_url_vars nome_funz cod_area cod_comune last_comune curr_comune nome_funz_caller url_list_area url_area extra_par\]"


	set actions "<td nowrap><a href=\"$curr_prog?funzione=D2&$link\">Canc.</a></td>"

#	set comu_canc $cod_comune
	set js_function ""
	set rows_per_page 60
	# imposto la struttura della tabella
	if {$funzione != "I"
        &&  $funzione != "V"
	} {

	    set link_aggiungi   "<a target=comuni href=\"coimcmar-gest?funzione=I&[export_url_vars cod_area caller extra_par nome_funz_caller url_list_area url_area]&nome_funz=[iter_get_nomefunz coimcmar-gest]\">Aggiungi</a>"

	    set table_def [list \
		          [list actions                "Azioni" no_sort $actions] \
		          [list denominazione          "Comune"      no_sort {l}] \
		           ]
	} else {
	    set link_aggiungi ""
	    set table_def [list \
		          [list denominazione          "Comune"      no_sort {l}] \
 	                  ]	
	}
	set sel_cmar [db_map sel_cmar]
	
	set table_result [ad_table -Tmax_rows $rows_per_page -Tmissing_text "Nessun dato corrisponde ai criteri impostati." -Textra_vars {cod_area cod_comune last_comune curr_comune nome_funz denominazione nome_funz_caller url_list_area url_area extra_par} go $sel_cmar $table_def]
	
    }
}

if {[form is_valid $form_name]} {
  # form valido dal punto di vista del templating system

    set descrizione   [element::get_value $form_name descrizione]
    set url_list_area [element::get_value $form_name url_list_area]

  # settaggio current_date
    db_1row sel_dual_date ""

  # controlli standard su numeri e date, per Ins ed Upd
    set error_num 0
    if {$funzione == "I"
    ||  $funzione == "M"
    } {

        if {[string equal $descrizione ""]} {
            element::set_error $form_name descrizione "Inserire Descrizione"
            incr error_num
        }
    }

    if {$funzione =="D"} {
	db_1row count_manu ""
        db_1row count_tecn ""
        db_1row count_comu ""
        db_1row count_uten ""

	set flag_coun "f"
	set tabelle   ""
	if {$count_manu > 0
	||  $count_tecn > 0
        ||  $count_comu > 0
        ||  $count_uten > 0
	} {
	    element::set_error $form_name descrizione "Non &egrave; possibile eliminare l'area causa presenza di collegamenti con:<br> manutentori, tecnici, comuni, utenti"
            incr error_num
	}
    }

    if {$error_num > 0} {
        ad_return_template
        return
    }

    switch $funzione {
        I {db_1row sel_area_s ""
	   set tipo_01 "C" 
           set dml_sql [db_map ins_area]}
        M {set dml_sql [db_map upd_area]}
        D {set dml_sql [db_map del_area]}
    }


  # Lancio la query di manipolazione dati contenute in dml_sql
    if {[info exists dml_sql]} {
        with_catch error_msg {
            db_transaction {
                db_dml dml_coimarea $dml_sql
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
        set last_cod_area $descrizione
    }
    set link_list      [subst $link_list_script]
    set link_gest      [export_url_vars cod_area last_cod_area nome_funz nome_funz_caller url_list_area url_area extra_par caller]
    switch $funzione {
        M {set return_url   "coimarea-gest?funzione=V&$link_gest"}
        D {set return_url   "coimarea-list?$link_list"}
        I {set return_url   "coimarea-gest?funzione=V&$link_gest"}
        V {set return_url   "coimarea-list?$link_list"}
    }

    ad_returnredirect $return_url
    ad_script_abort
}

ad_return_template
