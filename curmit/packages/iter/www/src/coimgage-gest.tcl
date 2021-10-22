ad_page_contract {
    Add/Edit/Delete  form per la tabella "coimgage"
    @author          Giulio Laurenzi
    @creation-date   07/07/2004

    @param funzione  M=edit D=delete V=view
    @param caller    caller della lista da restituire alla lista:
                     serve se lista e' uno zoom che permetti aggiungi.
    @param nome_funz identifica l'entrata di menu, server per le autorizzazioni
                     serve se lista e' uno zoom che permetti aggiungi.
    @param nome_funz_caller identifica l'entrata di menu, serve per la 
                     navigazione con navigation bar
    @param extra_par Variabili extra da restituire alla lista
    @cvs-id          coimgage-gest.tcl

    USER  DATA       MODIFICHE
    ===== ========== =======================================================================
    sim01 20/03/2019 Il programma puntava ancora ai vecchi modelli G. Ora a seconda del tipo
    sim01            impianto punta al programma corretto.

} {
    
   {cod_opma          ""}
   {cod_impianto      ""}
   {data_ins          ""}
   {last_key          ""}
   {funzione         "V"}
   {caller       "index"}
   {nome_funz         ""}
   {nome_funz_caller  ""}
   {extra_par         ""}
} -properties {
    page_title:onevalue
    context_bar:onevalue
    form_name:onevalue
}

# Controlla lo user
switch $funzione {
    "V" {set lvl 1}
    "M" {set lvl 3}
    "D" {set lvl 4}

}

set id_utente [lindex [iter_check_login $lvl $nome_funz] 1]

# imposta le class css della barra delle funzioni
iter_set_func_class $funzione

set link_gest [export_url_vars cod_opma cod_impianto data_ins last_key nome_funz nome_funz_caller extra_par caller]
set url_gage  $link_gest

iter_get_coimtgen
if {$coimtgen(regione) eq "MARCHE"} {
    set label_dimp "Inserimento Modelli Regionali"
    set label_dimp_gest "Gestione Modelli Regionali"
    set label_dimp_ultima "Ultimo Modello Regionale"
} else {
    set label_dimp "Inserimento Autocertificazione"
    set label_dimp_gest "Gestione Autocertificazione"
    set label_dimp_ultima "Ultima Autocertificazione"
}

set prep_link_dimp {
    # giro data_esecuzione
    set sw_ins_dimp "t"
    if {![string is space $data_esecuzione]} {
	set data_controllo  [iter_check_date $data_esecuzione]
	if {[db_0or1row sel_dimp_check ""] == 1} {
	    set sw_ins_dimp "f"
	}
    }
    if {$sw_ins_dimp == "t"} {
	if {[db_0or1row sel_dimp_last ""] == 0} {
	    set cod_dimp ""
	}
    }


    set flag_tipo_impianto [db_string q "select flag_tipo_impianto from coimaimp where cod_impianto = :cod_impianto"];#sim01

    if {$flag_tipo_impianto == "F"} {#sim01 if e suo contenuto
	set flag_tracciato "R2"
    }

    if {$flag_tipo_impianto == "T"} {#sim01 if e suo contenuto
	set flag_tracciato "R3"
    }

    if {$flag_tipo_impianto == "C"} {#sim01 if e suo contenuto
	set flag_tracciato "R4"
    }

    if {$flag_tipo_impianto == "R"} {#sim01 if e suo contenuto
	set flag_tracciato "R1"
    }

    #sim01 aggiunto flag_tracciato
    set link_dimp [export_url_vars cod_opma cod_impianto data_ins url_gage nome_funz_caller cod_dimp flag_tracciato]&nome_funz=[iter_get_nomefunz coimdimp-gest]&flag_no_link=T
}

# controllo il parametro di "propagazione" per la navigation bar
if {[string is space $nome_funz_caller]} {
    set nome_funz_caller $nome_funz
}

set dett_tab [iter_tab_form $cod_impianto]

# Personalizzo la pagina
set link_list_script {[export_url_vars last_key caller nome_funz_caller nome_funz]&[iter_set_url_vars $extra_par]}
set link_list        [subst $link_list_script]
set titolo           "Controllo Manutentore"
switch $funzione {
    M {set button_label "Conferma Modifica" 
       set page_title   "Modifica $titolo"}
    D {set button_label "Conferma Cancellazione"
       set page_title   "Cancellazione $titolo"}
    V {set button_label "Torna alla lista"
       set page_title   "Visualizzazione $titolo"}
}

set context_bar  [iter_context_bar -nome_funz $nome_funz_caller]

# sproteggo la chiave solo in inserimento e gli attributi in inserimento e mod.
set form_name     "coimgage"
set readonly_key  "readonly"
set readonly_fld  "readonly"
set disabled_fld  "disabled"
set onsubmit_cmd  ""
switch $funzione {
   "M" {set readonly_fld  \{\}
        set disabled_fld  \{\}
       }
}

form create $form_name \
-html    $onsubmit_cmd

element create $form_name stato_ed \
-label   "Stato" \
-widget   text \
-datatype text \
-html    "size 15 readonly {} class form_element" \
-optional

element create $form_name data_prevista \
-label   "Data prevista" \
-widget   text \
-datatype text \
-html    "size 10 maxlength 10 $readonly_fld {} class form_element" \
-optional

element create $form_name data_esecuzione \
-label   "Data esecuzione" \
-widget   text \
-datatype text \
-html    "size 10 maxlength 10 readonly_fld {} class form_element" \
-optional

element create $form_name note \
-label   "Note" \
-widget   textarea \
-datatype text \
-html    "cols 50 rows 4 $readonly_fld {} class form_element" \
-optional

element create $form_name funzione  -widget hidden -datatype text -optional
element create $form_name caller    -widget hidden -datatype text -optional
element create $form_name nome_funz -widget hidden -datatype text -optional
element create $form_name extra_par -widget hidden -datatype text -optional
element create $form_name submit    -widget submit -datatype text -label "$button_label" -html "class form_submit"
element create $form_name last_key  -widget hidden -datatype text -optional
element create $form_name stato     -widget hidden -datatype text -optional
element create $form_name cod_impianto -widget hidden -datatype text -optional
element create $form_name data_ins  -widget hidden -datatype text -optional
element create $form_name cod_opma  -widget hidden -datatype text -optional

if {[form is_request $form_name]} {

    element set_properties $form_name funzione     -value $funzione
    element set_properties $form_name caller       -value $caller
    element set_properties $form_name nome_funz    -value $nome_funz
    element set_properties $form_name extra_par    -value $extra_par
    element set_properties $form_name last_key     -value $last_key
    element set_properties $form_name cod_opma     -value $cod_opma
    element set_properties $form_name cod_impianto -value $cod_impianto
    element set_properties $form_name data_ins     -value $data_ins    

    # leggo riga
    if {[db_0or1row sel_gage {}] == 0} {
	iter_return_complaint "Record non trovato"
    }

    element set_properties $form_name stato           -value $stato
    element set_properties $form_name stato_ed        -value $stato_ed
    element set_properties $form_name data_prevista   -value $data_prevista
    element set_properties $form_name data_esecuzione -value $data_esecuzione
    element set_properties $form_name note            -value $note
}

if {[form is_valid $form_name]} {
  # form valido dal punto di vista del templating system

    set cod_opma        [element::get_value $form_name cod_opma]
    set cod_impianto    [element::get_value $form_name cod_impianto]
    set stato           [element::get_value $form_name stato]
    set data_prevista   [element::get_value $form_name data_prevista]
    set data_esecuzione [element::get_value $form_name data_esecuzione]
    set note            [element::get_value $form_name note]

  # controlli standard su numeri e date, per Ins ed Upd
    set error_num 0
    if {$funzione == "M"} {

        if {[string equal $data_prevista ""]} {
                element::set_error $form_name data_prevista "Inserire data prevista"
                incr error_num
	} else {
            set data_prevista [iter_check_date $data_prevista]
            if {$data_prevista == 0} {
                element::set_error $form_name data_prevista "Data prevista deve essere una data"
                incr error_num
            }
        }
     if {![string is space $data_esecuzione ]} {
                   set data_esecuzione [iter_check_date $data_esecuzione]
            if {$data_prevista == 0} {
                element::set_error $form_name data_prevista "Data esecuzione deve essere una data"
                incr error_num
            }
        }


        if {![string is space $data_esecuzione ]} {
                   set stato  2           }
            
       if {[string is space $data_esecuzione ]} {
                   set stato  1           }
            }

    if {$funzione == "D"} {
	# giro la data_esecuzione
	if {![string is space $data_esecuzione]} {
	    set data_controllo  [iter_check_date $data_esecuzione]
	    if {[db_0or1row sel_dimp_check ""] == 1} {
		element::set_error $form_name stato_ed "Il controllo non &egrave; eliminabile: &egrave; presente una dichiarazione correlata"
		incr error_num
	    }
	}
    }

    if {$error_num > 0} {
	eval $prep_link_dimp
        ad_return_template
        return
    }

    switch $funzione {
        M {
	    set dml_sql [db_map upd_gage]
	}
        D {
	    set dml_sql [db_map del_gage]
	}
    }

  # Lancio la query di manipolazione dati contenute in dml_sql
    if {[info exists dml_sql]} {
        with_catch error_msg {
            db_transaction {
                db_dml dml_coimgage $dml_sql
            }
        } {
            iter_return_complaint "Spiacente, ma il DBMS ha restituito il
            seguente messaggio di errore <br><b>$error_msg</b><br>
            Contattare amministratore di sistema e comunicare il messaggio
            d'errore. Grazie."
 	}
    }

    set link_list      [subst $link_list_script]
    set link_gest      [export_url_vars cod_opma cod_impianto data_ins last_key nome_funz nome_funz_caller extra_par caller]

    switch $funzione {
        M {set return_url   "coimgage-gest?funzione=V&$link_gest"}
        D {set return_url   "coimgage-list?$link_list"}
        V {set return_url   "coimgage-list?$link_list"}
    }

    ad_returnredirect $return_url
    ad_script_abort
}

eval $prep_link_dimp
ad_return_template
