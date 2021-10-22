ad_page_contract {
    Add/Edit/Delete  form per la tabella "coimcomu"
    @author          Adhoc
    @creation-date   20/02/2004

    @param funzione  I=insert M=edit D=delete V=view
    @param caller    caller della lista da restituire alla lista:
                     serve se lista e' uno zoom che permetti aggiungi.
    @param nome_funz identifica l'entrata di menu, server per le autorizzazioni
                     serve se lista e' uno zoom che permetti aggiungi.
    @param extra_par Variabili extra da restituire alla lista
    @cvs-id          coimcomu-gest.tcl

    USER  DATA       MODIFICHE
    ===== ========== =======================================================================
    sim01 25/10/2016 Gestito nuovo flag flag_viario_manutentore 

} {
    
    {cod_comune         ""}
    {cod_provincia      ""}
    {last_cod_comune    ""}
    {last_denominazione ""}
    {funzione          "V"}
    {caller        "index"}
    {nome_funz          ""}
    {extra_par          ""}
   cerca_prov:optional
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
set link_gest [export_url_vars cod_comune last_cod_comune last_denominazione nome_funz extra_par]

iter_set_func_class $funzione

# Personalizzo la pagina
set link_list_script {[export_url_vars cod_comune last_cod_comune last_denominazione caller nome_funz]&[iter_set_url_vars $extra_par]}
set link_list        [subst $link_list_script]
set titolo           "Comune"
set nodelete "F"
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
			  [list coimcomu-list?$link_list "Lista Comuni"] \
			  "$page_title"]
}

db_1row sel_aimp_count ""

# sproteggo la chiave solo in inserimento e gli attributi in inserimento e mod.
set form_name    "coimcomu"
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

element create $form_name nome_prov \
-label   "Provincia" \
-widget   text \
-datatype text \
    -html    "size 40 maxlength 80 readonly {} class form_element" \
-optional

element create $form_name denominazione \
-label   "Denominazione" \
-widget   text \
-datatype text \
    -html    "size 40 maxlength 40 $readonly_fld {} class form_element" \
-optional

element create $form_name flag_val \
    -label   "Flag validit&agrave;" \
-widget   checkbox \
-datatype text \
    -html    "$disabled_fld {} class form_element" \
-optional \
    -options {{No T}}

element create $form_name cap \
-label   "C.A.P" \
-widget   text \
-datatype text \
    -html    "size 5 maxlength 5 $readonly_fld {} class form_element" \
-optional

element create $form_name id_belfiore \
-label   "Cod.Belfiore" \
-widget   text \
-datatype text \
    -html    "size 4 maxlength 4 $readonly_fld {} class form_element" \
-optional

element create $form_name cod_istat \
-label   "Cod.ISTAT" \
-widget   text \
-datatype text \
    -html    "size 7 maxlength 7 $readonly_fld {} class form_element" \
-optional

element create $form_name popolaz_citt \
-label   "Popolazione anagrafica" \
-widget   text \
-datatype text \
    -html    "size 10 maxlength 10 $readonly_fld {} class form_element" \
-optional

element create $form_name popolaz_aimp \
-label   "Popolazione anagrafica" \
-widget   text \
-datatype text \
    -html    "size 10 maxlength 10 $readonly_fld {} class form_element" \
-optional

#sim01
element create $form_name flag_viario_manutentore  \
    -label   "Flag viario manutentore" \
    -widget   checkbox \
    -datatype text \
    -html    "$disabled_fld {} class form_element" \
    -optional \
    -options {{No T}}

#rom01
element create $form_name pec \
    -label   "PEC" \
    -widget   text \
    -datatype text \
    -html    "size 40 maxlength 100 $readonly_fld {} class form_element" \
    -optional


if {$funzione == "I"
||  $funzione == "M"
} {
    set cerca_prov [iter_search coimcomu coimprov-list [list denominazione nome_prov cod_provincia cod_provincia]]
} else {
    set cerca_prov ""
}


element create $form_name funzione      -widget hidden -datatype text -optional
element create $form_name caller        -widget hidden -datatype text -optional
element create $form_name nome_funz     -widget hidden -datatype text -optional
element create $form_name extra_par     -widget hidden -datatype text -optional
element create $form_name submit        -widget submit -datatype text -label "$button_label" -html "class form_submit"
element create $form_name last_cod_comune -widget hidden -datatype text -optional
element create $form_name last_denominazione -widget hidden -datatype text -optional
element create $form_name cod_comune    -widget hidden -datatype text -optional
element create $form_name cod_provincia -widget hidden -datatype text -optional

if {[form is_request $form_name]} {

    element set_properties $form_name funzione          -value $funzione
    element set_properties $form_name caller            -value $caller
    element set_properties $form_name nome_funz         -value $nome_funz
    element set_properties $form_name extra_par         -value $extra_par
    element set_properties $form_name last_cod_comune   -value $last_cod_comune
    element set_properties $form_name last_denominazione -value $last_denominazione
    element set_properties $form_name cod_comune        -value $cod_comune

    if {$funzione eq "D"} {
	set aimps ""
	set viae ""
	db_0or1row sel_comu_aimp ""
	db_0or1row sel_comu_viae ""
	
	if {$aimps == 1 || $viae == 1} {
	    set nodelete "T"
	    element::set_error $form_name denominazione "Impossibile cancellare: sono presenti impianti collegati al comune"
	} 
    }
    
    
    if {$funzione == "I"} {
      
        element set_properties $form_name flag_val -value "T"
        element set_properties $form_name flag_viario_manutentore -value "T";#sim01

    } else {
      # leggo riga
        if {[db_0or1row sel_comu ""] == 0
        } {
            iter_return_complaint "Record non trovato"
	}
        

	if {[db_0or1row sel_prov ""] == 0} {
	        set nome_prov ""
	}

        element set_properties $form_name cod_provincia  -value $cod_provincia
        element set_properties $form_name nome_prov      -value $nome_prov
        element set_properties $form_name denominazione  -value $denominazione
        element set_properties $form_name flag_val       -value $flag_val
        element set_properties $form_name cap            -value $cap
        element set_properties $form_name id_belfiore    -value $id_belfiore
        element set_properties $form_name cod_istat      -value $cod_istat
        element set_properties $form_name popolaz_citt   -value $popolaz_citt
        element set_properties $form_name popolaz_aimp   -value $popolaz_aimp
	element set_properties $form_name flag_viario_manutentore -value $flag_viario_manutentore;#sim01
	element set_properties $form_name pec            -value $pec;#rom01
    }
}
if {[form is_valid $form_name]} {
  # form valido dal punto di vista del templating system

    set nome_prov      [element::get_value $form_name nome_prov]
    set denominazione  [element::get_value $form_name denominazione]
    set flag_val       [element::get_value $form_name flag_val]
    set cap            [element::get_value $form_name cap]
    set id_belfiore    [element::get_value $form_name id_belfiore]
    set cod_istat      [element::get_value $form_name cod_istat]
    set popolaz_citt   [element::get_value $form_name popolaz_citt]
    set popolaz_aimp   [element::get_value $form_name popolaz_aimp]
    set flag_viario_manutentore [element::get_value $form_name flag_viario_manutentore]
    set pec            [element::get_value $form_name pec];#rom01
 
    # data corrente
    db_1row sel_dual_date ""

  # controlli standard su numeri e date, per Ins ed Upd
    set error_num 0
    if {$funzione == "I"
    ||  $funzione == "M"
    } {

        if {[string equal $nome_prov ""]} {
            element::set_error $form_name nome_prov "Inserire Provincia"
            incr error_num
        }

        if {[string equal $denominazione ""]} {
            element::set_error $form_name denominazione "Inserire Denominazione"
            incr error_num
        } else {
            set denominazione [string toupper $denominazione]
        }

        
        if {[string equal $cap ""]} {
            element::set_error $form_name cap "Inserire il CAP"
            incr error_num
        } else {
	    set cap [iter_check_num $cap]
	    if {$cap == "Error"} {
                element::set_error $form_name cap "CAP deve essere numerico"
                incr error_num
	    }
        }
    
        if {[string equal $id_belfiore ""]} {
            element::set_error $form_name id_belfiore "Inserire il Codice Belfiore"
            incr error_num
        }

        if {[string equal $cod_istat ""]} {
            element::set_error $form_name cod_istat "Inserire il Codice ISTAT"
            incr error_num
        } 

        if {$flag_val != "T"} {
	        set flag_val "F" 
        }

	if {$flag_viario_manutentore != "T"} {#sim01
                set flag_viario_manutentore "F"
        }

        if {![string equal $popolaz_citt ""]} {
            set popolaz_citt [iter_check_num $popolaz_citt 0]
            if {$popolaz_citt == "Error"} {
                element::set_error $form_name popolaz_citt "Deve essere un numero intero"
                incr error_num
            } else {
                if {[iter_set_double $popolaz_citt] >=  [expr pow(10,7)]
		    ||  [iter_set_double $popolaz_citt] <= -[expr pow(10,7)]} {
                    element::set_error $form_name popolaz_citt "Deve essere inferiore di 10.000.000"
                    incr error_num
                }
            }
        }

        if {![string equal $popolaz_aimp ""]} {
            set popolaz_aimp [iter_check_num $popolaz_aimp 0]
            if {$popolaz_aimp == "Error"} {
                element::set_error $form_name popolaz_aimp "Deve essere un numero intero"
                incr error_num
            } else {
                if {[iter_set_double $popolaz_aimp] >=  [expr pow(10,7)]
		    ||  [iter_set_double $popolaz_aimp] <= -[expr pow(10,7)]} {
                    element::set_error $form_name popolaz_aimp "Deve essere inferiore di 10.000.000"
                    incr error_num
                }
            }
        }

    }
    
    if {$error_num > 0} {
        ad_return_template
        return
    }


    
    switch $funzione {
        I {db_1row sel_nextval_comu ""
	    set dml_sql [db_map ins_comu]}
        M {set dml_sql [db_map upd_comu]}
        D {set dml_sql [db_map del_comu]}
    }

  # Lancio la query di manipolazione dati contenute in dml_sql
    if {[info exists dml_sql]} {
        with_catch error_msg {
            db_transaction {
               
                db_dml dml_coimcomu $dml_sql
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
        set last_cod_comune    $cod_comune
        set last_denominazione $denominazione
    }
    set link_list      [subst $link_list_script]
    set link_gest      [export_url_vars cod_comune last_cod_comune last_denominazione nome_funz extra_par caller]
    switch $funzione {
        M {set return_url   "coimcomu-gest?funzione=V&$link_gest"}
        D {set return_url   "coimcomu-list?$link_list"}
        I {set return_url   "coimcomu-gest?funzione=V&$link_gest"}
        V {set return_url   "coimcomu-list?$link_list"}
    }

    ad_returnredirect $return_url
    ad_script_abort
}

ad_return_template
