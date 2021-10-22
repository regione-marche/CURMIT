ad_page_contract {
    Add/Edit/Delete  form per la tabella "coimviae"
    @author          Adhoc
    @creation-date   13/01/2004

    @param funzione  I=insert M=edit D=delete V=view
    @param caller    caller della lista da restituire alla lista:
                     serve se lista e' uno zoom che permetti aggiungi.
    @param nome_funz identifica l'entrata di menu, server per le autorizzazioni
                     serve se lista e' uno zoom che permetti aggiungi.
    @param extra_par Variabili extra da restituire alla lista
    @cvs-id          coimviae-gest.tcl

    USER  DATA       MODIFICHE
    ===== ========== =======================================================================
    gab01 02/05/2016 Aggiunta colonna cod_zona ed esposto quartiere solo per i comuni.
} {
    cod_comune
   {cod_via ""}
   {last_cod_via ""}
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
set link_gest [export_url_vars cod_via last_cod_via cod_comune nome_funz extra_par]

iter_set_func_class $funzione

# Personalizzo la pagina
set link_list_script {[export_url_vars cod_comune last_cod_via caller nome_funz]&[iter_set_url_vars $extra_par]}
set link_list        [subst $link_list_script]
set titolo           "Viario"
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
 
set context_bar  [iter_context_bar -nome_funz $nome_funz]

iter_get_coimtgen
set flag_cod_via_auto $coimtgen(flag_cod_via_auto)
set flag_viario       $coimtgen(flag_viario)
set flag_ente         $coimtgen(flag_ente);#gab01

# sproteggo la chiave solo in inserimento e gli attributi in inserimento e mod.
set form_name    "coimviae"
set readonly_key "readonly"
set readonly_fld "readonly"
set disabled_fld "disabled"
set onsubmit_cmd ""
switch $funzione {
   "I" {set readonly_fld \{\}
        set disabled_fld \{\}
        if {$flag_cod_via_auto == "F"} {
	   set readonly_key \{\}
        }
       }
   "M" {set readonly_fld \{\}
        set disabled_fld \{\}
       }
}

form create $form_name \
-html    $onsubmit_cmd

element create $form_name cod_via \
-label   "Codice" \
-widget   text \
-datatype text \
-html    "size 8 maxlength 8 $readonly_key {} class form_element" \
-optional

element create $form_name denom_comune \
-label   "Comune" \
-widget   text \
-datatype text \
-html    "size 50 maxlength 50 readonly {} class form_element" \
-optional

element create $form_name descr_topo \
-label   "Tipo Toponom." \
-widget   select \
-options  [iter_selbox_from_table coimtopo descr_topo descr_topo] \
-datatype text \
-html    "$disabled_fld {} class form_element" \
-optional

element create $form_name descrizione \
-label   "Descrizione" \
-widget   text \
-datatype text \
-html    "size 50 maxlength 50 $readonly_fld {} class form_element" \
-optional

element create $form_name descr_estesa \
-label   "Descrizione Estesa" \
-widget   text \
-datatype text \
-html    "size 50 maxlength 50 $readonly_fld {} class form_element" \
-optional

element create $form_name cap \
-label   "CAP" \
-widget   text \
-datatype text \
-html    "size 10 maxlength 5 $readonly_fld {} class form_element" \
-optional

element create $form_name da_numero \
-label   "Da Numero" \
-widget   text \
-datatype text \
-html    "size 20 maxlength 5 $readonly_fld {} class form_element" \
-optional

element create $form_name a_numero \
-label   "A Numero" \
-widget   text \
-datatype text \
-html    "size 20 maxlength 5 $readonly_fld {} class form_element" \
-optional

if {$flag_ente eq "C"} {#gab01: aggiunta solo la if
    element create $form_name cod_qua \
	-label   "Quartiere" \
	-widget   select \
	-datatype text \
	-html    "$disabled_fld {} class form_element" \
	-optional \
	-options [iter_selbox_from_table coimcqua cod_qua descrizione]
} else {#gab01
    element create $form_name cod_qua  -widget hidden -datatype text -optional;#gab01
};#gab01

element create $form_name cod_zona \
    -label   "Zone geografiche" \
    -widget   text \
    -datatype text \
    -html    "size 8 maxlength 8 $readonly_fld {} class form_element" \
    -optional;#gab01


element create $form_name funzione      -widget hidden -datatype text -optional
element create $form_name caller        -widget hidden -datatype text -optional
element create $form_name nome_funz     -widget hidden -datatype text -optional
element create $form_name extra_par     -widget hidden -datatype text -optional
element create $form_name cod_comune    -widget hidden -datatype text -optional
element create $form_name submit        -widget submit -datatype text -label "$button_label" -html "class form_submit"
element create $form_name last_cod_via  -widget hidden -datatype text -optional


if {[form is_request $form_name]} {
    element set_properties $form_name funzione      -value $funzione
    element set_properties $form_name caller        -value $caller
    element set_properties $form_name nome_funz     -value $nome_funz
    element set_properties $form_name extra_par     -value $extra_par
    element set_properties $form_name last_cod_via  -value $last_cod_via
    element set_properties $form_name cod_comune    -value $cod_comune
    element set_properties $form_name cod_via       -value $cod_via
    
    # leggo la denominazione del comune
    if {[db_0or1row sel_comu ""] == 0} {
	iter_return_complaint "Comune non trovato"
    }
    element set_properties $form_name denom_comune  -value $denom_comune

    if {$funzione != "I"} {
      # leggo riga
        if {[db_0or1row sel_viae ""] == 0
	} {
            iter_return_complaint "Record non trovato"
	}

        element set_properties $form_name cod_via      -value $cod_via
	element set_properties $form_name descr_topo   -value $descr_topo
        element set_properties $form_name descrizione  -value $descrizione
        element set_properties $form_name descr_estesa -value $descr_estesa
	element set_properties $form_name cap          -value $cap
	element set_properties $form_name da_numero    -value $da_numero
	element set_properties $form_name a_numero     -value $a_numero
        element set_properties $form_name cod_qua      -value $cod_qua
        element set_properties $form_name cod_zona     -value $cod_zona;#gab01
    }
}

if {[form is_valid $form_name]} {
  # form valido dal punto di vista del templating system
    set cod_via      [element::get_value $form_name cod_via]
    set cod_comune   [element::get_value $form_name cod_comune]
    set descr_topo   [element::get_value $form_name descr_topo]
    set descrizione  [element::get_value $form_name descrizione]
    set descr_estesa [element::get_value $form_name descr_estesa]
    set denom_comune [element::get_value $form_name denom_comune]
    set cap          [element::get_value $form_name cap]
    set da_numero    [element::get_value $form_name da_numero]
    set a_numero     [element::get_value $form_name a_numero]
    set cod_qua      [element::get_value $form_name cod_qua]
    set cod_zona     [element::get_value $form_name cod_zona];#gab01

    # controlli standard su numeri e date, per Ins ed Upd
    set error_num 0
    if {$funzione == "I"
    ||  $funzione == "M"
    } {
        switch $funzione {
	    "I" {set where_cod ""}
	    "M" {set where_cod "and cod_via <> :cod_via"}
	}

	if {$flag_cod_via_auto == "F"} {
	    if {[string equal $cod_via ""]} {
		element::set_error $form_name cod_via "Inserire Codice"
		incr error_num
	    }
	}

        if {[string is space $cod_comune]} {
            element::set_error $form_name denom_comune "Inserire Comune"
            incr error_num
        }
	
        if {[string equal $descr_topo ""]} {
            element::set_error $form_name descr_topo "Inserire Tipo Topon."
            incr error_num
        }
	
        if {[string equal $descrizione ""]} {
            element::set_error $form_name descrizione "Inserire Descrizione"
            incr error_num
        } else {
	    if {[db_0or1row sel_check_viae_2 "" ] == 1} {
		element::set_error $form_name descrizione "Descrizione gi&agrave; presente in anagrafica"
		incr error_num
	    }  
	}
	
        if {[string equal $descr_estesa ""]} {
            element::set_error $form_name descr_estesa "Inserire Descrizione Estesa"
            incr error_num
        }

	if {![string equal $cap ""]} {
	    if {[iter_check_num $cap 0] eq "Error"} {
		element::set_error $form_name cap "Il CAP deve essere un numero intero"
		incr error_num
	    }
	}

	if {![string equal $da_numero ""]} {
	    if {[iter_check_num $da_numero 0] eq "Error"} {
		element::set_error $form_name da_numero "Da Numero deve essere un numero intero"
		incr error_num
	    }
	}

	if {![string equal $a_numero ""]} {
	    if {[iter_check_num $a_numero 0] eq "Error"} {
		element::set_error $form_name a_numero "A Numero deve essere un numero intero"
		incr error_num
	    }
	}

	if {![string equal $cod_qua ""]} {
            if {[db_0or1row sel_d_cqua {}] == 0} {
                # controllo esistenza del quartiere per il comune interessato
                element::set_error $form_name clas_funz "Quartiere inesistente per il comune"
                incr error_num
            }
        }
    }

    if {$funzione == "I"
    &&  $error_num == 0
    &&  [db_0or1row sel_check_viae ""] == 1
    } {
	# controllo univocita'/protezione da double_click
        element::set_error $form_name cod_via "Il record che stai tentando di inserire &egrave; gi&agrave; esistente nel Data Base."
        incr error_num
    }

    if {$funzione == "D"
    &&  $flag_viario == "T"} {
	db_0or1row sel_aimp ""
	if {$conta_aimp > 0} {
	    element::set_error $form_name cod_via "Il record che stai tentando di cancellare &egrave; collegato a degli impianti"
	    incr error_num
	}
    }

    if {$error_num > 0} {
        ad_return_template
        return
    }

    switch $funzione {
        I {
	    if {$flag_cod_via_auto == "T"} {
		db_1row sel_cod ""
	    }
	    set dml_sql  [db_map ins_viae]
	    set dml_aimp [db_map upd_aimp]
	}
        M {
	    set dml_sql  [db_map upd_viae]
	    set dml_aimp [db_map upd_aimp]
	}
        D {
	    set dml_sql  [db_map del_viae]
	}
    }

  # Lancio la query di manipolazione dati contenute in dml_sql
    if {[info exists dml_sql]} {
        with_catch error_msg {
            db_transaction {
                db_dml dml_coimviae $dml_sql
		if {[info exists dml_aimp]} {
                    db_dml dml_coimaimp $dml_aimp
                }
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
	set cod_via      [string toupper $cod_via]
	set descrizione  [string toupper $descrizione]
	set last_cod_via [list $descrizione $cod_via]
    }

    set link_list      [subst $link_list_script]
    set link_gest      [export_url_vars cod_via last_cod_via cod_comune nome_funz extra_par caller]
    switch $funzione {
        M {set return_url   "coimviae-gest?funzione=V&$link_gest"}
        D {set return_url   "coimviae-list?$link_list"}
        I {set return_url   "coimviae-gest?funzione=V&$link_gest"}
        V {set return_url   "coimviae-list?$link_list"}
    }

    ad_returnredirect $return_url
    ad_script_abort
}

ad_return_template
