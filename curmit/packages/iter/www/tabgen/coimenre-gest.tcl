ad_page_contract {
    Add/Edit/Delete  form per la tabella "coimenre"
    @author          Giulio Laurenzi
    @creation-date   01/08/2005

    @param funzione  I=insert M=edit D=delete V=view
    @param caller    caller della lista da restituire alla lista:
                     serve se lista e' uno zoom che permetti aggiungi.
    @param nome_funz identifica l'entrata di menu, server per le autorizzazioni
                     serve se lista e' uno zoom che permetti aggiungi.
    @param nome_funz_caller identifica l'entrata di menu, serve per la 
                     navigazione con navigation bar
    @param extra_par Variabili extra da restituire alla lista
    @cvs-id          coimenre-gest.tcl
} {
    
   {cod_enre ""}
   {last_cod_enre ""}
   {funzione  "V"}
   {caller    "index"}
   {nome_funz ""}
   {nome_funz_caller ""}
   {url_enve      ""}
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

# preparo la url che serve agli opve per tornare agli enve
if {$funzione != "I"
&&  [string equal $url_enve ""]
} {
    set url_enve [list [ad_conn url]?[export_ns_set_vars url]]
}

set id_utente [lindex [iter_check_login $lvl $nome_funz] 1]
set link_gest [export_url_vars cod_enre last_cod_enre nome_funz nome_funz_caller extra_par caller]


# imposta le class css della barra delle funzioni
iter_set_func_class $funzione

# controllo il parametro di "propagazione" per la navigation bar
if {[string is space $nome_funz_caller]} {
    set nome_funz_caller $nome_funz
}


# Personalizzo la pagina
set link_list_script {[export_url_vars last_cod_enre caller nome_funz_caller nome_funz]&[iter_set_url_vars $extra_par]}
set link_list        [subst $link_list_script]
set titolo           "Ente competente per anomalie"
set link_enti        [export_url_vars last_cod_enre caller cod_enre nome_funz_caller]&nome_funz=[iter_get_nomefunz coimenti-list]

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
set form_name    "coimenre"
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

element create $form_name cod_enre \
-label   "Codice" \
-widget   text \
-datatype text \
-html    "size 8 maxlength 8 $readonly_key {} class form_element" \
-optional

element create $form_name denominazione \
-label   "Denominazione" \
-widget   text \
-datatype text \
-html    "size 40 maxlength 40 $readonly_fld {} class form_element" \
-optional

element create $form_name indirizzo \
-label   "Indirizzo" \
-widget   text \
-datatype text \
-html    "size 40 maxlength 40 $readonly_fld {} class form_element" \
-optional

element create $form_name numero \
-label   "numero " \
-widget   text \
-datatype text \
-html    "size 8 maxlength 80 $readonly_fld {} class form_element" \
-optional

element create $form_name cap \
-label   "cap" \
-widget   text \
-datatype text \
-html    "size 5 maxlength 5 $readonly_fld {} class form_element" \
-optional

element create $form_name localita \
-label   "Indirizzo" \
-widget   text \
-datatype text \
-html    "size 40 maxlength 40 $readonly_fld {} class form_element" \
-optional

element create $form_name comune \
-label   "comune" \
-widget   text \
-datatype text \
-html    "size 40 maxlength 40 $readonly_fld {} class form_element" \
-optional

element create $form_name provincia \
-label   "Indirizzo" \
-widget   text \
-datatype text \
-html    "size 4 maxlength 4 $readonly_fld {} class form_element" \
-optional

element create $form_name denominazione2 \
-label   "Raggruppamento" \
-widget   text \
-datatype text \
-html    "size 40 maxlength 40 $readonly_fld {} class form_element" \
-optional


element create $form_name url_enve  -widget hidden -datatype text -optional
element create $form_name funzione  -widget hidden -datatype text -optional
element create $form_name caller    -widget hidden -datatype text -optional
element create $form_name nome_funz -widget hidden -datatype text -optional
element create $form_name nome_funz_caller -widget hidden -datatype text -optional
element create $form_name extra_par -widget hidden -datatype text -optional
element create $form_name submit    -widget submit -datatype text -label "$button_label" -html "class form_submit"
element create $form_name last_cod_enre -widget hidden -datatype text -optional

if {[form is_request $form_name]} {
    element set_properties $form_name url_enve         -value $url_enve
    element set_properties $form_name funzione         -value $funzione
    element set_properties $form_name caller           -value $caller
    element set_properties $form_name nome_funz        -value $nome_funz
    element set_properties $form_name nome_funz_caller -value $nome_funz_caller
    element set_properties $form_name extra_par        -value $extra_par
    element set_properties $form_name last_cod_enre    -value $last_cod_enre

    if {$funzione == "I"} {
        
    } else {
      # leggo riga
        if {[db_0or1row sel_enre {}] == 0} {
            iter_return_complaint "Record non trovato"
	}

        element set_properties $form_name cod_enre       -value $cod_enre
        element set_properties $form_name denominazione  -value $denominazione
        element set_properties $form_name indirizzo      -value $indirizzo
        element set_properties $form_name numero         -value $numero   
        element set_properties $form_name cap            -value $cap      
        element set_properties $form_name localita       -value $localita 
        element set_properties $form_name comune         -value $comune   
        element set_properties $form_name provincia      -value $provincia
        element set_properties $form_name denominazione2 -value $denominazione2
    }
}

if {[form is_valid $form_name]} {
  # form valido dal punto di vista del templating system

    set cod_enre       [element::get_value $form_name cod_enre]
    set denominazione  [element::get_value $form_name denominazione]
    set indirizzo      [element::get_value $form_name indirizzo]
    set numero         [element::get_value $form_name numero]
    set cap            [element::get_value $form_name cap]
    set localita       [element::get_value $form_name localita]
    set comune         [element::get_value $form_name comune]
    set provincia      [element::get_value $form_name provincia]
    set denominazione2 [element::get_value $form_name denominazione2]

  # controlli standard su numeri e date, per Ins ed Upd
    set error_num 0
    if {$funzione == "I"
    ||  $funzione == "M"
    } {
	if {[string equal $cod_enre ""]} {
	    element::set_error $form_name cod_enre "Inserire il record"
	    incr error_num	    
	}

	if {[string equal $denominazione ""]} {
	    element::set_error $form_name denominazione "Inserire la denominazione"
	    incr error_num	    
	} else {
	    set where_cod ""
	    if {$funzione == "M"} {
		set where_cod "and cod_enre <> :cod_enre"
	    } 
	    db_1row sel_enre_count ""
	    if {$count_enre > 0} {
		element::set_error $form_name denominazione "Denominazione gi&agrave; presente sul data base"
		incr error_num	 		
	    }

	}
	
    }

    if {$funzione == "I"
    &&  $error_num == 0
    &&  [db_0or1row sel_enre_check {}] == 1
    } {
      # controllo univocita'/protezione da double_click
        element::set_error $form_name cod_enre "Il record che stai tentando di inserire &egrave; gi&agrave; esistente nel Data Base."
        incr error_num
    }

    if {$funzione == "D"} {
	db_1row sel_enti_count ""
	if {$conta_enti > 0} {
	    element::set_error $form_name cod_enre "Impossibile cancellare il soggetto: ha degli enti collegati"
            incr error_num
	}
    }

    if {$funzione == "I"} {
	# inserisco nella tipologia soggetti il tipo soggetto legato all'ente competente e inserisco 
        # il tipo soggetto anche sulla tabella coimenve.
  
        # dato che savazzi non vuole cambiare il tipo_soggetto char(1) sulla tabella documenti qui 
        # di seguito faccio un piccolo algoritmo per poter ricavare una chiave univoca di un carattere
        # sfruttando la prima libera.
	set lista_key [list A B C D E F G H I J K L M N O P Q R S T U V W X Y Z a b c d e f g h i j k l m n o p q r s t u v w x y z 1 2 3 4 5 6 7 8 9 0]
	set flag_key "f"
	foreach key $lista_key {
	    if {[db_0or1row check_cod ""] == 0} {
		set tipo_soggetto $key
		set flag_key "t"
		set dml_tpsg_sql [db_map ins_tpsg]
		break
	    }
	}
	if {$flag_key == "f"} {
	    element::set_error $form_name cod_enre "Tipi soggetti non pi&ugrave; disponibili"
            incr error_num
	}
    }


    if {$error_num > 0} {
        ad_return_template
        return
    }

    switch $funzione {
        I {set dml_sql [db_map ins_enre]}
        M {set dml_sql [db_map upd_enre]}
        D {set dml_sql [db_map del_enre]
	   # in cancellazione elimino anche il tipo-soggetto, ma  su richiesta di savazzi NON 
           # vado ad eliminare i documenti collegati a questo tipo soggetto.
	    if {[db_0or1row sel_tpsg ""] == 1} {
		set dml_tpsg_sql [db_map del_tpsg]
	    }
	}
    }


  # Lancio la query di manipolazione dati contenute in dml_sql
    if {[info exists dml_sql]} {
        with_catch error_msg {
            db_transaction {
                db_dml dml_coimenre $dml_sql
		# in cancellazione elimino anche il tipo-soggetto, ma  su richiesta di savazzi NON 
		# vado ad eliminare i documenti collegati a questo tipo soggetto.
		if {[info exists dml_tpsg_sql]} {
		    db_dml dml_coimtpsg $dml_tpsg_sql
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
        set last_cod_enre $cod_enre
    }
    set link_list      [subst $link_list_script]
    set link_gest      [export_url_vars cod_enre last_cod_enre nome_funz nome_funz_caller extra_par caller url_enve]
    switch $funzione {
        M {set return_url   "coimenre-gest?funzione=V&$link_gest"}
        D {set return_url   "coimenre-list?$link_list"}
        I {set return_url   "coimenre-gest?funzione=V&$link_gest"}
        V {set return_url   "coimenre-list?$link_list"}
    }

    ad_returnredirect $return_url
    ad_script_abort
}

ad_return_template
