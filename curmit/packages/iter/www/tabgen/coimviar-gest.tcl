ad_page_contract {
    Add/Edit/Delete  form per la tabella "coimviar"
    @author          Katia Coazzoli Adhoc
    @creation-date   27/04/2004

    @param funzione  I=insert M=edit D=delete V=view
    @param caller    caller della lista da restituire alla lista:
                     serve se lista e' uno zoom che permetti aggiungi.
    @param nome_funz identifica l'entrata di menu, server per le autorizzazioni
                     serve se lista e' uno zoom che permetti aggiungi.
    @param nome_funz_caller identifica l'entrata di menu, serve per la 
                     navigazione con navigation bar
    @param extra_par Variabili extra da restituire alla lista
    @cvs-id          coimviar-gest.tcl
} {
    
   {cod_area         ""}
   {cod_comune       ""}
   {cod_via          ""}
   {last_cod_via     ""}
   {funzione        "V"}
   {caller      "index"}
   {nome_funz        ""}
   {nome_funz_caller ""}
   {extra_par        ""}
   {url_list_area    ""}
   {url_area         ""}
   {f_cod_via        ""}
} -properties {
    page_title:onevalue
    context_bar:onevalue
    form_name:onevalue
}

# Controlla lo user
# Se il programma e' 'delicato', mettere livello 5 (amministratore).

switch $funzione {
    "V" {set lvl 1}
    "I" {set lvl 2}
    "M" {set lvl 3}
    "D" {set lvl 4}
}

set link_tab [iter_links_area $cod_area $nome_funz_caller $url_list_area $url_area]
set dett_tab [iter_tab_area $cod_area]

set id_utente [lindex [iter_check_login $lvl $nome_funz] 1]
set link_gest [export_url_vars cod_area cod_comune cod_via last_cod_via url_list_area url_area nome_funz nome_funz_caller extra_par caller]
# imposta le class css della barra delle funzioni
iter_set_func_class $funzione

# controllo il parametro di "propagazione" per la navigation bar
if {[string is space $nome_funz_caller]} {
    set nome_funz_caller $nome_funz
}

iter_get_coimtgen
set flag_viario $coimtgen(flag_viario)
set flag_ente   $coimtgen(flag_ente)

# Personalizzo la pagina
set link_list_script {[export_url_vars cod_area cod_comune last_cod_via caller url_list_area url_area nome_funz_caller nome_funz]&[iter_set_url_vars $extra_par]}

set link_list        [subst $link_list_script]
set titolo           "Relazione via / area "
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

#if {$caller == "index"} {
    set context_bar  [iter_context_bar -nome_funz $nome_funz_caller]
#} else {
#    set context_bar  [iter_context_bar \
#                     [list "javascript:window.close()" "Torna alla Gestione"] \
#                     [list coimviar-list?$link_list "Lista Relazioni vie / area"] \
#                     "$page_title"]
#}

# sproteggo la chiave solo in inserimento e gli attributi in inserimento e mod.
set form_name    "coimviar"
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

if {$flag_ente == "P"} {
    if {$funzione != "I"} {
       element create $form_name descr_comu \
       -label   "Comune" \
       -widget   text \
       -datatype text \
       -html    "size 20 maxlength 30 $readonly_key {} class form_element" \
       -optional
    } else {
       element create $form_name cod_comune \
       -label   "Comune" \
       -widget   select \
       -options [iter_selbox_from_comu]\
       -datatype text \
       -html    "$readonly_key {} class form_element" \
       -optional
    }
}

element create $form_name descr_via \
-label   "Via" \
-widget   text \
-datatype text \
-html    "size 25 maxlength 40 $readonly_key {} class form_element" \
-optional

element create $form_name descr_topo \
-label   "Descrizione toponimo" \
-widget   text \
-datatype text \
-html    "size 05 maxlength 10 $readonly_key {} class form_element" \
-optional

element create $form_name civico_iniz \
-label   "Civico da" \
-widget   text \
-datatype text \
-html    "size 8 maxlength 8 $readonly_fld {} class form_element" \
-optional

element create $form_name civico_fine \
-label   "Civico a" \
-widget   text \
-datatype text \
-html    "size 8 maxlength 8 $readonly_fld {} class form_element" \
-optional

element create $form_name f_cod_via -widget hidden -datatype text -optional
element create $form_name funzione  -widget hidden -datatype text -optional
element create $form_name caller    -widget hidden -datatype text -optional
element create $form_name nome_funz -widget hidden -datatype text -optional
element create $form_name nome_funz_caller -widget hidden -datatype text -optional
element create $form_name extra_par -widget hidden -datatype text -optional
element create $form_name cod_area  -widget hidden -datatype text -optional
element create $form_name cod_via   -widget hidden -datatype text -optional
element create $form_name last_cod_via -widget hidden -datatype text -optional
element create $form_name url_list_area -widget hidden -datatype text -optional
element create $form_name url_area  -widget hidden -datatype text -optional
element create $form_name dummy     -widget hidden -datatype text -optional
element create $form_name submit    -widget submit -datatype text -label "$button_label" -html "class form_submit"

if {[string equal $flag_ente "C"]} {
    #se l'ente è un comune assegno di default a dati di ambiente
    element create $form_name descr_comu  -widget hidden -datatype text -optional
    element create $form_name cod_comune  -widget hidden -datatype text -optional

} else {
    if {$funzione != "I"} {
       element create $form_name cod_comune  -widget hidden -datatype text -optional
    }
}

if {$flag_viario == "T"} {
    set cerca_viae [iter_search $form_name [ad_conn package_url]/tabgen/coimviae-filter [list dummy f_cod_via dummy descr_via dummy descr_topo cod_comune cod_comune]]
} else {
    set cerca_viae ""
}


if {[form is_request $form_name]} {
    element set_properties $form_name f_cod_via    -value $f_cod_via
    element set_properties $form_name funzione     -value $funzione
    element set_properties $form_name caller       -value $caller
    element set_properties $form_name nome_funz    -value $nome_funz
    element set_properties $form_name nome_funz_caller -value $nome_funz_caller
    element set_properties $form_name extra_par    -value $extra_par
    element set_properties $form_name url_list_area -value $url_list_area
    element set_properties $form_name url_area     -value $url_area
    element set_properties $form_name last_cod_via -value $last_cod_via

    if {$funzione == "I"} {
        element set_properties $form_name cod_area   -value $cod_area 
        if {[string equal $flag_ente "C"]} {
            #se l'ente è un comune assegno di default a dati di ambiente
            element set_properties $form_name cod_comune   -value $coimtgen(cod_comu)
            element set_properties $form_name descr_comu   -value $coimtgen(denom_comune)
        }
        
    } else {
      # leggo riga
        if {[db_0or1row sel_viar {}] == 0} {
            iter_return_complaint "Record non trovato"
	}
	element set_properties $form_name f_cod_via   -value $f_cod_via
        element set_properties $form_name cod_area    -value $cod_area
        element set_properties $form_name cod_comune  -value $cod_comune
        #if {[string equal $ente "C"]} {
           element set_properties $form_name descr_comu  -value $descr_comu
	#}
        element set_properties $form_name cod_via     -value $cod_via
        element set_properties $form_name descr_via   -value $descr_via
        element set_properties $form_name descr_topo  -value $descr_topo
        element set_properties $form_name civico_iniz -value $civico_iniz
        element set_properties $form_name civico_fine -value $civico_fine
    }
}

if {[form is_valid $form_name]} {
  # form valido dal punto di vista del templating system
    set cod_area          [element::get_value $form_name cod_area]
    if {[string equal $flag_ente "C"]} {
        set descr_comu    [element::get_value $form_name descr_comu]
    }
    if {[string equal $flag_ente "P"]
     && $funzione != "I"} {
        set descr_comu    [element::get_value $form_name descr_comu]
    }
    set cod_comune        [element::get_value $form_name cod_comune]
    set cod_via           [element::get_value $form_name cod_via]
    set descr_via         [element::get_value $form_name descr_via]
    set descr_topo        [element::get_value $form_name descr_topo]
    set civico_iniz       [element::get_value $form_name civico_iniz]
    set civico_fine       [element::get_value $form_name civico_fine]
    set url_list_area     [element::get_value $form_name url_list_area]
    set url_area          [element::get_value $form_name url_area]
    set f_cod_via         [element::get_value $form_name f_cod_via]

  # controlli standard su numeri e date, per Ins ed Upd
    set error_num 0
    if {$funzione == "I"
    ||  $funzione == "M"
    } {
	if {[string equal $cod_comune ""]} {
	    if {$coimtgen(flag_ente) == "P"} {
		element::set_error $form_name cod_comune "valorizzare il Comune" 
	    } else {
		element::set_error $form_name descr_comu "valorizzare il Comune"
	    } 
	    incr error_num
	} 
    }

    # si controlla la via solo se il primo test e' andato bene.
    # in questo modo si e' sicuri che f_comune e' stato valorizzato.

    if {[string equal $descr_via  ""]
    &&  [string equal $descr_topo ""]
    } {
	set f_cod_via ""
    } else {

	if {[string equal $cod_comune ""]} {
	    element::set_error $form_name cod_comune "Inserire il comune"
	    incr error_num
	} else {

	    # controllo codice via
	    set chk_out_rc      0
	    set chk_out_msg     ""
	    set chk_out_cod_via ""
	    set ctr_viae        0
	    if {[string equal $descr_topo ""]} {
		set eq_descr_topo  "is null"
	    } else {
		set eq_descr_topo  "= upper(:descr_topo)"
	    }
	    if {[string equal $descr_via ""]} {
		set eq_descrizione "is null"
	    } else {
		set eq_descrizione "= upper(:descr_via)"
	    }
	    db_foreach sel_via "" {
		incr ctr_viae
		if {$cod_via == $f_cod_via} {
		    set chk_out_cod_via $cod_via
		    set chk_out_rc       1
		}
	    }
            switch $ctr_viae {
 		0 { set chk_out_msg "Via non trovata"}
	 	1 { set chk_out_cod_via $cod_via
		    set chk_out_rc       1 }
	    default {
		     if {$chk_out_rc == 0} {
			set chk_out_msg "Trovate pi&ugrave; vie: usa il link cerca"
		    }
 		}
	    }
            set f_cod_via $chk_out_cod_via
	    set cod_via   $chk_out_cod_via
            if {$chk_out_rc == 0} {
                element::set_error $form_name descr_via $chk_out_msg
                incr error_num
	
	    }
	}
    }
   
	    
    if {[string equal $civico_iniz ""]} {
	element::set_error $form_name civico_iniz "Inserire il numero civico d'inizio"
	incr error_num
    }
    
    if {[string equal $civico_fine ""]} {
	element::set_error $form_name civico_fine "Inserire il numero civico di fine"
	incr error_num
    }

    if {$funzione == "I"
    &&  $error_num == 0
    &&  [db_0or1row sel_viar_check {}] == 1
    } {
      # controllo univocita'/protezione da double_click
        element::set_error $form_name descr_via "Il record che stai tentando di inserire &egrave; gi&agrave; esistente nel Data Base."
        incr error_num
    }


    if {$error_num > 0} {
        ad_return_template
        return
    }

    switch $funzione {
        I {set dml_sql [db_map ins_viar]}
        M {set dml_sql [db_map upd_viar]}
        D {set dml_sql [db_map del_viar]}
    }

  # Lancio la query di manipolazione dati contenute in dml_sql
    if {[info exists dml_sql]} {
        with_catch error_msg {
            db_transaction {
                db_dml dml_coimviar $dml_sql
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

        if {[string equal $flag_ente "C"]} {
            set last_cod_via [list  $descr_comu $descr_via]
	} else {
            if {[db_0or1row sel_descr_comu {}] == 1} {
                 set last_cod_via [list  $descr_comu $descr_via]
	    }
	}
    }

    set link_list      [subst $link_list_script]
    set link_gest      [export_url_vars cod_area cod_comune cod_via last_cod_via url_list_area url_area nome_funz nome_funz_caller extra_par caller]
    switch $funzione {
        M {set return_url   "coimviar-gest?funzione=V&$link_gest"}
        D {set return_url   "coimviar-list?$link_list"}
        I {set return_url   "coimviar-gest?funzione=V&$link_gest"}
        V {set return_url   "coimviar-list?$link_list"}
    }

    ad_returnredirect $return_url
    ad_script_abort
}

ad_return_template
