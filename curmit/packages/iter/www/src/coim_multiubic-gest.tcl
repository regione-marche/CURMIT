ad_page_contract {
    Add/Edit/Delete  form per la tabella "coimaimp"
    @author          Giulio Laurenzi / Katia Coazzoli
    @creation-date   01/04/2004

    @param funzione  I=insert M=edit D=delete V=view
    @param caller    caller della lista da restituire alla lista:
    serve se lista e' uno zoom che permetti aggiungi.
    @param nome_funz identifica l'entrata di menu, server per le autorizzazioni
    serve se lista e' uno zoom che permetti aggiungi.
    @param extra_par Variabili extra da restituire alla lista
    @cvs-id          coimaimp-gest.tcl
} {
    
    {cod_impianto      ""}
    {last_cod_impianto ""}
    {funzione         "V"}
    {caller       "index"}
    {nome_funz         ""}
    {nome_funz_caller  ""}
    {extra_par         ""}
    {url_list_aimp     ""}
    {url_aimp          ""}
    {f_cod_via         ""}
    {cod_ubicazione    ""}
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

#set id_utente [lindex [iter_check_login $lvl $nome_funz] 1]
#set id_utente [ad_get_cookie iter_login_[ns_conn location]]
set id_utente [iter_get_id_utente]

set link_gest [export_url_vars cod_impianto url_list_aimp url_aimp last_cod_impianto nome_funz nome_funz_caller extra_par caller cod_ubicazione]

# controllo il parametro di "propagazione" per la navigation bar
if {[string is space $nome_funz_caller]} {
    set nome_funz_caller $nome_funz
}
set link_tab [iter_links_form $cod_impianto $nome_funz_caller $url_list_aimp $url_aimp]
set dett_tab [iter_tab_form $cod_impianto]

# imposta le class css della barra delle funzioni
iter_set_func_class $funzione

db_1row sel_flag_multivie "select flag_multivie from coimtgen"
iter_get_coimtgen
set flag_viario $coimtgen(flag_viario)
set flag_ente $coimtgen(flag_ente)
set cod_provincia $coimtgen(cod_provincia)
set provincia $coimtgen(sigla_prov)
set cod_comune $coimtgen(cod_comu)
if {$flag_ente == "P"} {
    set cod_ente "P$cod_provincia"
} else {
    set cod_ente "C$cod_comune"
}

set location [ad_conn location]


# Personalizzo la pagina

set link_list_script {[export_url_vars last_cod_impianto caller nome_funz nome_funz_caller]&[iter_set_url_vars $extra_par]}
set link_list        [subst $link_list_script]
set link_return $url_list_aimp 
set titolo           "Ubicazione"
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
    set context_bar  [iter_context_bar -nome_funz $nome_funz_caller]
} else {
    set context_bar  [iter_context_bar \
			  [list "javascript:window.close()" "Torna alla Gestione"] \
			  [list coimaimp-list?$link_list "Lista Impianti"] \
			  "$page_title"]
}

#preparo il link al programma Storico ubicazioni
set link_stub  [export_url_vars cod_impianto nome_funz_caller url_aimp url_list_aimp]&nome_funz=[iter_get_nomefunz coimstub-list]

# sproteggo la chiave solo in inserimento e gli attributi in inserimento e mod.
set form_name    "coimubic"
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
    element create $form_name cod_comune \
	-label   "Comune" \
	-widget   select \
	-datatype text \
	-html    "disabled {} class form_element" \
	-optional \
	-options [iter_selbox_from_comu]
} else {
    element create $form_name cod_comune  -widget hidden -datatype text -optional  
    element create $form_name descr_comune \
	-label   "Comune" \
	-widget   text \
	-datatype text \
	-html    "size 20 readonly {} class form_element" \
	-optional
    element set_properties $form_name cod_comune       -value $coimtgen(cod_comu)
    element set_properties $form_name descr_comune     -value $coimtgen(denom_comune)
}

element create $form_name cap \
    -label   "cap" \
    -widget   text \
    -datatype text \
    -html    "size 5 maxlength 5 $readonly_fld {} class form_element" \
    -optional

element create $form_name provincia \
    -label   "Prvincia" \
    -widget   text \
    -datatype text \
    -html    "size 2  2 $readonly_key {} class form_element" \
    -optional

element create $form_name numero \
    -label   "numero" \
    -widget   text \
    -datatype text \
    -html    "size 3 maxlength 8 $readonly_fld {} class form_element" \
    -optional

element create $form_name esponente \
    -label   "esopnente" \
    -widget   text \
    -datatype text \
    -html    "size 2 maxlength 3 $readonly_fld {} class form_element" \
    -optional

element create $form_name scala \
    -label   "scala" \
    -widget   text \
    -datatype text \
    -html    "size 2 maxlength 5 $readonly_fld {} class form_element" \
    -optional

element create $form_name piano \
    -label   "paino"\
    -widget   text \
    -datatype text \
    -html    "size 2 maxlength 5 $readonly_fld {} class form_element" \
    -optional 

element create $form_name interno \
    -label   "interno" \
    -widget   text \
    -datatype text \
    -html    "size 2 maxlength 3 $readonly_fld {} class form_element" \
    -optional

element create $form_name descr_topo \
    -label   "toponimo" \
    -widget   text \
    -datatype text \
    -html    "size 5 maxlength 10 $readonly_fld {} class form_element" \
    -optional

element create $form_name descr_via \
    -label   "via" \
    -widget   text \
    -datatype text \
    -html    "size 27 maxlength 80 $readonly_fld {} class form_element" \
    -optional \

if {$flag_viario == "T"
    && ($funzione == "I"
	||  $funzione == "M")
} {
    set cerca_viae [iter_search $form_name [ad_conn package_url]/tabgen/coimviae-filter [list dummy f_cod_via dummy descr_via dummy descr_topo cod_comune cod_comune dummy dummy dummy dummy dummy dummy]]
} else {
    set cerca_viae ""
}

element create $form_name localita \
    -label   "localita" \
    -widget   text \
    -datatype text \
    -html    "size 40 maxlength 40 $readonly_fld {} class form_element" \
    -optional

element create $form_name f_cod_via     -widget hidden -datatype text -optional
element create $form_name cod_impianto  -widget hidden -datatype text -optional
element create $form_name url_list_aimp -widget hidden -datatype text -optional
element create $form_name url_aimp      -widget hidden -datatype text -optional
element create $form_name funzione      -widget hidden -datatype text -optional
element create $form_name caller        -widget hidden -datatype text -optional
element create $form_name nome_funz     -widget hidden -datatype text -optional
element create $form_name nome_funz_caller -widget hidden -datatype text -optional
element create $form_name extra_par     -widget hidden -datatype text -optional
element create $form_name submit        -widget submit -datatype text -label "$button_label" -html "class form_submit"
element create $form_name last_cod_impianto -widget hidden -datatype text -optional
element create $form_name dummy             -widget hidden -datatype text -optional
element create $form_name cod_ubicazione    -widget hidden -datatype text -optional

if {[form is_request $form_name]} {
    element set_properties $form_name funzione          -value $funzione
    element set_properties $form_name url_list_aimp     -value $url_list_aimp
    element set_properties $form_name url_aimp          -value $url_aimp
    element set_properties $form_name caller            -value $caller
    element set_properties $form_name nome_funz         -value $nome_funz
    element set_properties $form_name nome_funz_caller  -value $nome_funz_caller
    element set_properties $form_name extra_par         -value $extra_par
    element set_properties $form_name last_cod_impianto -value $last_cod_impianto
    element set_properties $form_name f_cod_via         -value $f_cod_via
    element set_properties $form_name provincia         -value $provincia 
    element set_properties $form_name cod_ubicazione    -value $cod_ubicazione
    element set_properties $form_name cod_impianto     -value $cod_impianto
    
    if {$funzione == "I"} {
	# TODO: settare eventuali default!!
		if {$flag_ente == "P"} {
		    db_1row sel_com "select cod_comune as comune_imp from coimaimp where cod_impianto = :cod_impianto"
		    element set_properties $form_name cod_comune       -value $comune_imp
        }
    } else {

		# leggo riga
		if {$flag_viario == "T"} {
		    set sel_ubic   [db_map sel_ubic_si_vie]
		} else {
		    set sel_ubic   [db_map sel_ubic_no_vie]
		}
	
	        if {[db_0or1row sel_ubic $sel_ubic] == 0} {
	            iter_return_complaint "Record non trovato"
		}
   
        element set_properties $form_name localita         -value $localita   
        element set_properties $form_name descr_via        -value $descr_via
		element set_properties $form_name descr_topo       -value $descr_topo
        element set_properties $form_name numero           -value $numero
        element set_properties $form_name esponente        -value $esponente
        element set_properties $form_name scala            -value $scala  
        element set_properties $form_name piano            -value $piano
        element set_properties $form_name interno          -value $interno
        element set_properties $form_name cod_comune       -value $cod_comune
        element set_properties $form_name cap              -value $cap
        element set_properties $form_name f_cod_via        -value $cod_via
    }
}

if {[form is_valid $form_name]} {
  # form valido dal punto di vista del templating system

    if {$flag_ente == "P"} {
	db_1row sel_com "select cod_comune as comune_imp from coimaimp where cod_impianto = :cod_impianto"
	element set_properties $form_name cod_comune       -value $comune_imp
    }
    set localita         [element::get_value $form_name localita]
    set descr_topo       [element::get_value $form_name descr_topo]
    set descr_via        [element::get_value $form_name descr_via]
    set numero           [element::get_value $form_name numero]
    set esponente        [element::get_value $form_name esponente]
    set scala            [element::get_value $form_name scala]
    set piano            [element::get_value $form_name piano]
    set interno          [element::get_value $form_name interno]
    set cod_comune       [element::get_value $form_name cod_comune]
    set cap              [element::get_value $form_name cap]
    set url_list_aimp    [element::get_value $form_name url_list_aimp]
    set url_aimp         [element::get_value $form_name url_aimp]
    set f_cod_via        [element::get_value $form_name f_cod_via]
    set cod_impianto     [element::get_value $form_name cod_impianto]
    set cod_via          ""

  # controlli standard su numeri e date, per Ins ed Upd
    set error_num 0
    if {$funzione == "I"
    ||  $funzione == "M"
    } {
	# se la via � valorizzata, ma manca il comune: errore
        if {![string equal $descr_via  ""]
	||  ![string equal $descr_topo ""]
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
	if {$flag_viario == "T"} {
	    if {[string equal $descr_via  ""]
	    &&  [string equal $descr_topo ""]
	    } {
		if {($localita ne "") && ([string length $localita] > 3)} {
		    set f_cod_via ""
		} else {
		    set chk_out_msg "Compilare la localit&agrave se non si conosce la via"
		    set chk_out_rc 0
		}
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
		db_foreach sel_viae "" {
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
	    }
	    
	    if {[info exists chk_out_rc] && $chk_out_rc == 0} {
		element::set_error $form_name descr_via $chk_out_msg
		incr error_num
	    }
	}

	if {![string equal $numero ""]} {
            set numero [iter_check_num $numero 0]
            if {$numero == "Error"} {
                element::set_error $form_name numero "il civico deve essere numerico"
                incr error_num
	    }
	}

	if {![string equal $cap ""]
        &&  ![string is integer $cap] 
        } {
            incr error_num
	    element::set_error $form_name cap "Il Cap deve essere numerico"
	}
    }
       

    if {$error_num > 0} {
        ad_return_template
        return
    }

    switch $funzione {
        I {db_1row sel_cod_ubic ""
           set dml_sql [db_map ins_ubic]}
        M {set dml_sql [db_map upd_ubic]}
        D {set dml_sql [db_map del_ubic]}
    }

  # Lancio la query di manipolazione dati contenute in dml_sql
    if {[info exists dml_sql]} {
        with_catch error_msg {
            db_transaction {
                db_dml dml_coim_multiubic $dml_sql
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
        set last_cod_impianto $cod_impianto
    }
    set link_list      [subst $link_list_script]
    set link_gest      [export_url_vars cod_ubicazione cod_impianto last_cod_impianto url_list_aimp url_aimp nome_funz nome_funz_caller extra_par caller]
    switch $funzione {
        M {set return_url   "coim_multiubic-gest?funzione=V&$link_gest"}
        D {set return_url   "coim_multiubic-list?funzione=V&$link_gest"}
        I {set return_url   "coim_multiubic-gest?funzione=V&$link_gest"}
        V {set return_url   "coim_multiubic-list?&url_list_aimp&url_aimp"}
    }

    ad_returnredirect $return_url
    ad_script_abort
}

ad_return_template
