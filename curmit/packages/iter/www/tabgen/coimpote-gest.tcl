ad_page_contract {
    Add/Edit/Delete  form per la tabella "coimpote"
    @author          Adhoc
    @creation-date   18/02/2004

    @param funzione  I=insert M=edit D=delete V=view
    @param caller    caller della lista da restituire alla lista:
                     serve se lista e' uno zoom che permetti aggiungi.
    @param nome_funz identifica l'entrata di menu, server per le autorizzazioni
                     serve se lista e' uno zoom che permetti aggiungi.
    @param extra_par Variabili extra da restituire alla lista
    @cvs-id          coimpote-gest.tcl
} {
    
   {cod_potenza ""}
   {last_cod_potenza ""}
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
# TODO: controllare il livello richiesto,
# Se il programma e' 'delicato', mettere livello 5 (amministratore).

switch $funzione {
    "V" {set lvl 1}
    "I" {set lvl 2}
    "M" {set lvl 3}
    "D" {set lvl 4}
}
set id_utente [lindex [iter_check_login $lvl $nome_funz] 1]
set link_gest [export_url_vars cod_potenza last_cod_potenza nome_funz extra_par]
iter_set_func_class $funzione

# Personalizzo la pagina
# TODO: controllare impostazione della context_bar adattando come necessario
set link_list_script {[export_url_vars last_cod_potenza caller nome_funz]&[iter_set_url_vars $extra_par]}
set link_list        [subst $link_list_script]
set titolo           "Classe di Potenza"
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

# TODO: se la lista che richiama questo programma e' un pgm di zoom
#       attivare la seguente if
#if {$caller == "index"} {
    set context_bar  [iter_context_bar -nome_funz $nome_funz]
#} else {
#    set context_bar  [iter_context_bar \
#                     [list "javascript:window.close()" "Torna alla Gestione"] \
#                     [list coimpote-list?$link_list "Lista Potenze Nominali"] \
#                     "$page_title"]
#}

# sproteggo la chiave solo in inserimento e gli attributi in inserimento e mod.
set form_name    "coimpote"
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

element create $form_name cod_potenza \
-label   "Cod Potenza" \
-widget   text \
-datatype text \
-html    "size 8 maxlength 8 $readonly_key {} class form_element" \
-optional

element create $form_name descr_potenza \
-label   "Descrizione" \
-widget   text \
-datatype text \
-html    "size 35 maxlength 35 $readonly_fld {} class form_element" \
-optional

element create $form_name potenza_max \
-label   "Valore Max. Potenza" \
-widget   text \
-datatype text \
-html    "size 9 maxlength 9 $readonly_fld {} class form_element" \
-optional

element create $form_name potenza_min \
-label   "Valore Min. Potenza" \
-widget   text \
-datatype text \
-html    "size 9 maxlength 8 $readonly_fld {} class form_element" \
-optional

element create $form_name flag_tipo_impianto \
    -label   "flag_tipo_impianto" \
    -widget   select \
    -datatype text \
    -html   "class form_element" \
    -optional \
    -options { {{} {}} {Riscaldamento R} {Raffreddamento F} {Cogenerazione C} {Teleriscaldamento T}}



element create $form_name funzione    -widget hidden -datatype text -optional
element create $form_name caller      -widget hidden -datatype text -optional
element create $form_name nome_funz   -widget hidden -datatype text -optional
element create $form_name extra_par   -widget hidden -datatype text -optional
element create $form_name submit      -widget submit -datatype text -label "$button_label" -html "class form_submit"
element create $form_name last_cod_potenza -widget hidden -datatype text -optional

if {[form is_request $form_name]} {

    element set_properties $form_name funzione         -value $funzione
    element set_properties $form_name caller           -value $caller
    element set_properties $form_name nome_funz        -value $nome_funz
    element set_properties $form_name extra_par        -value $extra_par
    element set_properties $form_name last_cod_potenza -value $last_cod_potenza

    if {$funzione == "I"} {
        
    } else {
      # leggo riga
        if {[db_0or1row sel_pote ""] == 0
        } {
            iter_return_complaint "Record non trovato"
	}
	element set_properties $form_name cod_potenza   -value $cod_potenza
        element set_properties $form_name descr_potenza -value $descr_potenza
        element set_properties $form_name potenza_max   -value $potenza_max
        element set_properties $form_name potenza_min   -value $potenza_min
        element set_properties $form_name flag_tipo_impianto   -value $flag_tipo_impianto
    }
}  

if {[form is_valid $form_name]} {
  # form valido dal punto di vista del templating system
    set cod_potenza   [element::get_value $form_name cod_potenza]
    set descr_potenza [element::get_value $form_name descr_potenza]
    set potenza_max   [element::get_value $form_name potenza_max]
    set potenza_min   [element::get_value $form_name potenza_min]
    set flag_tipo_impianto   [element::get_value $form_name flag_tipo_impianto]

  # controlli standard su numeri e date, per Ins ed Upd
    set error_num 0
    if {$funzione == "I"
    ||  $funzione == "M"
    } {

        if {[string equal $cod_potenza ""]} {
            element::set_error $form_name cod_potenza "Inserire il Codice"
            incr error_num
        } 

        if {[string equal $descr_potenza ""]} {
            element::set_error $form_name descr_potenza "Inserire Descrizione"
            incr error_num
        } else { 
	            # controllo univocita' di descrizione
		    if {$funzione == "M"} {
				set where_cod "and cod_potenza <> :cod_potenza"
		    } else {
				set where_cod ""
		    }
	#	    set descrizione_comb [string toupper $descr_potenza]
		    if {[db_0or1row check_pote ""] == 1
		    } {
	                element::set_error $form_name descr_potenza "Descrizione gi&agrave esistente"
	                incr error_num
		    }
		}
        set pot_max_ok "f"
        set pot_min_ok "f"
        if {[string equal $potenza_max ""]} {
            element::set_error $form_name potenza_max "Inserire Valore Max. Potenza"
            incr error_num
        } else {
            set potenza_max [iter_check_num $potenza_max 2]
            if {$potenza_max == "Error"} {
                element::set_error $form_name potenza_max "Deve essere numerico e pu&ograve; avere al massimo 2 decimali"
                incr error_num
            } else {
                if {[iter_set_double $potenza_max] >=  [expr pow(10,5)]
                ||  [iter_set_double $potenza_max] <= -[expr pow(10,5)]} {
                    element::set_error $form_name potenza_max "Deve essere inferiore di 100.000"
                    incr error_num
                } else {
		    		set pot_max_ok "t"
				}
            }
        }

        if {[string equal $potenza_min ""]} {
            element::set_error $form_name potenza_min "Inserire Valore Min. Potenza"
            incr error_num
        } else {
            set potenza_min [iter_check_num $potenza_min 2]
            if {$potenza_min == "Error"} {
                element::set_error $form_name potenza_min "Deve essere numerico e pu&ograve; avere al massimo 2 decimali"
                incr error_num
            } else {
                if {[iter_set_double $potenza_min] >=  [expr pow(10,4)]
                ||  [iter_set_double $potenza_min] <= -[expr pow(10,4)]} {
                    element::set_error $form_name potenza_min "Deve essere inferiore di 10.000"
                    incr error_num
                } else {
		  			set pot_min_ok "t"
				}
            }
        }
	
		if {$pot_max_ok == "t"
	        &&  $pot_min_ok == "t"
	        &&  $potenza_min > $potenza_max
		} {
		    element::set_error $form_name potenza_min "Deve essere inferiore alla potenza massima"
		    incr error_num
		}
	
	#        if {[string equal $rendi1 ""]} {
	#            element::set_error $form_name rendi1 "Inserire Min. Ren. prima del 29-10-93"
	#            incr error_num
	#        } else {
	#            set rendi1 [iter_check_num $rendi1 2]
	#            if {$rendi1 == "Error"} {
	#                element::set_error $form_name rendi1 "Deve essere numerico e pu&ograve; avere al massimo 2 decimali"
	#                incr error_num
	#            } else {
	#                if {[iter_set_double $rendi1] >=  [expr pow(10,4)]
	#                ||  [iter_set_double $rendi1] <= -[expr pow(10,4)]} {
	#                    element::set_error $form_name rendi1 "Min. Ren. prima del 29-10-93 deve essere inferiore di 10.000"
	#                    incr error_num
	#                }
	#            }
	#        }
	#
	#        if {[string equal $rendi2 ""]} {
	#            element::set_error $form_name rendi2 "Inserire Min. Rend. dopo del 29-10-93"
	#            incr error_num
	#        } else {
	#            set rendi2 [iter_check_num $rendi2 2]
	#            if {$rendi2 == "Error"} {
	#                element::set_error $form_name rendi2 "Deve essere numerico e pu&ograve; avere al massimo 2 decimali"
	#                incr error_num
	#            } else {
	#                if {[iter_set_double $rendi2] >=  [expr pow(10,4)]
	#                ||  [iter_set_double $rendi2] <= -[expr pow(10,4)]} {
	#                    element::set_error $form_name rendi2 "Deve essere inferiore di 10.000"
	#                    incr error_num
	#                }
	#            }
	#        }
		
		set contr_cod "upper(cod_potenza) <> upper(:cod_potenza)  and"
		if {$funzione == "I"} {
			set contr_cod "upper(cod_potenza) = upper(:cod_potenza) or"
		} 
	
		if {$error_num == 0
		&& [db_0or1row sel_pote_check {}] == 1 
		} {
			#controllo univocita'/protezione da double_click
		    element::set_error $form_name cod_potenza "La fascia di potenza che stai tentando di inserire &egrave; gi&agrave; esistente nel Data Base."
		    incr error_num
		}
	
    }
	if {$funzione == "D"
    &&  [db_0or1row sel_aimp_check {}] == 1
    } {
        element::set_error $form_name cod_potenza "Il record che stai tentando di cancellare &egrave; collegato a degli impianti"
        incr error_num
    }
   
    if {$error_num > 0} {
        ad_return_template
        return
    }

    switch $funzione {
        I {set dml_sql [db_map ins_pote]}
        M {set dml_sql [db_map upd_pote]}
        D {set dml_sql [db_map del_pote]}
    }

  # Lancio la query di manipolazione dati contenute in dml_sql
    if {[info exists dml_sql]} {
        with_catch error_msg {
            db_transaction {
                db_dml dml_coimpote $dml_sql
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
        set last_cod_potenza $cod_potenza
    }
    set link_list      [subst $link_list_script]
    set link_gest      [export_url_vars cod_potenza last_cod_potenza nome_funz extra_par caller]
    switch $funzione {
        M {set return_url   "coimpote-gest?funzione=V&$link_gest"}
        D {set return_url   "coimpote-list?$link_list"}
        I {set return_url   "coimpote-gest?funzione=V&$link_gest"}
        V {set return_url   "coimpote-list?$link_list"}
    }

    ad_returnredirect $return_url
    ad_script_abort
}

ad_return_template
