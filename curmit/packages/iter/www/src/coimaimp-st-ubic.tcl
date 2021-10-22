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
   {st_progressivo    ""}
   {st_data_validita  ""}
   {last_cod_impianto ""}
   {funzione         "V"}
   {caller       "index"}
   {nome_funz         ""}
   {nome_funz_caller  ""}
   {extra_par         ""}
   {url_list_aimp     ""}
   {url_aimp          ""}
   {f_cod_via         ""}
} -properties {
    page_title:onevalue
    context_bar:onevalue
    form_name:onevalue
}

# Controlla lo user
switch $funzione {
    "V" {set lvl 1}
}
 
set id_utente [lindex [iter_check_login $lvl $nome_funz] 1]
set link_gest [export_url_vars cod_impianto st_progressivo st_data_validita url_list_aimp url_aimp last_cod_impianto nome_funz nome_funz_caller extra_par caller]

# controllo il parametro di "propagazione" per la navigation bar
if {[string is space $nome_funz_caller]} {
    set nome_funz_caller $nome_funz
}
set link_tab [iter_links_st_form $cod_impianto $st_progressivo $nome_funz_caller $url_list_aimp $url_aimp $st_data_validita]
set dett_tab [iter_tab_st_form $cod_impianto $st_progressivo]

# imposta le class css della barra delle funzioni
iter_set_func_class $funzione

iter_get_coimtgen
set flag_viario $coimtgen(flag_viario)
set flag_ente $coimtgen(flag_ente)
set cod_provincia $coimtgen(cod_provincia)
set provincia $coimtgen(sigla_prov)

# Personalizzo la pagina

set link_list_script {[export_url_vars last_cod_impianto caller nome_funz nome_funz_caller]&[iter_set_url_vars $extra_par]}
set link_list        [subst $link_list_script]
set link_return $url_list_aimp 
set titolo           "Ubicazione Storico"
switch $funzione {
    V {set button_label "Torna alla lista"
       set page_title   "Visualizzazione $titolo"}
}

if {$caller == "index"} {
    set context_bar  [iter_context_bar -nome_funz $nome_funz_caller]
} else {
    set context_bar  [iter_context_bar \
                     [list "javascript:window.close()" "Torna alla Gestione"] \
                     [list coimaimp-st-list?$link_list "Lista Impianti"] \
                     "$page_title"]
}

#preparo il link al programma Storico ubicazioni
set link_stub  [export_url_vars cod_impianto st_progressivo st_data_validita nome_funz_caller url_aimp url_list_aimp]&nome_funz=[iter_get_nomefunz coimstub-list]

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
    -html    "$disabled_fld {} class form_element" \
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

element create $form_name cod_qua \
-label   "Quartiere" \
-widget   select \
-datatype text \
-html    "$disabled_fld {} class form_element tabindex 4" \
-optional \
-options [iter_selbox_from_table coimcqua cod_qua descrizione]

element create $form_name cod_urb \
-label   "Unita urbana" \
-widget   select \
-datatype text \
-html    "$disabled_fld {} class form_element" \
-optional \
-options [iter_selbox_from_curb]

element create $form_name cod_tpdu \
-label   "Destinazione d'uso" \
-widget   select \
-datatype text \
-html    "$disabled_fld {} class form_element" \
-optional \
-options [iter_selbox_from_table coimtpdu cod_tpdu descr_tpdu]

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

element create $form_name data_variaz \
-label   "data_variaz" \
-widget   text \
-datatype text \
-html    "size 10 maxlength 10 $readonly_fld {} class form_element" \
-optional

element create $form_name palazzo \
-label   "palazzo"\
-widget   text \
-datatype text \
-html    "size 20 maxlength 100 $readonly_fld {} class form_element" \
-optional 

if {$funzione == "M"
 || $funzione == "D"} {
    element create $form_name data_ini_valid \
    -label   "data_ini_valid" \
    -widget   text \
    -datatype text \
    -html    "size 10 maxlength 10 $readonly_fld {} class form_element" \
    -optional
}

element create $form_name gb_x \
-label   "coordinate longitudine" \
-widget   text \
-datatype text \
-html    "size 20 maxlength 50 $readonly_fld {} class form_element" \
-optional

element create $form_name gb_y \
-label   "coordinate latitudine" \
-widget   text \
-datatype text \
-html    "size 20 maxlength 50 $readonly_fld {} class form_element" \
-optional

if {$flag_viario == "T"
&& ($funzione == "I"
||  $funzione == "M")
} {
    set cerca_viae [iter_search $form_name [ad_conn package_url]/tabgen/coimviae-filter [list dummy f_cod_via dummy descr_via dummy descr_topo cod_comune cod_comune dummy dummy]]
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
element create $form_name data_fin_valid -widget hidden -datatype text -optional
element create $form_name submit        -widget submit -datatype text -label "$button_label" -html "class form_submit"
element create $form_name last_cod_impianto -widget hidden -datatype text -optional
element create $form_name dummy         -widget hidden -datatype text -optional
if {$funzione != "M"
 && $funzione != "D"} {
    element create $form_name data_ini_valid -widget hidden -datatype text -optional
}

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

    if {![db_0or1row recup_date {}] == 0} {
        element set_properties $form_name data_ini_valid  -value $data_ini_valid
        element set_properties $form_name data_fin_valid  -value $data_fin_valid
    }
   
    if {$funzione == "I"} {
      # TODO: settare eventuali default!!
        
    } else {

      # leggo riga
	if {$flag_viario == "T"} {
	    set indirizzo   [db_map sel_aimp_coimviae3]
	    set coimviae    [db_map sel_aimp_coimviae1]
	    set where_viae  [db_map sel_aimp_coimviae2]
	} else {
	    set indirizzo ", a.indirizzo as descr_via
                           , a.toponimo  as descr_topo"
            set coimviae   ""
	    set where_viae ""
	}

        if {[db_0or1row sel_aimp {}] == 0} {
            iter_return_complaint "Record non trovato"
	}
   
        element set_properties $form_name cod_impianto     -value $cod_impianto
        element set_properties $form_name localita         -value $localita   
        element set_properties $form_name descr_via        -value $descr_via
	element set_properties $form_name descr_topo       -value $descr_topo
        element set_properties $form_name numero           -value $numero
        element set_properties $form_name esponente        -value $esponente
        element set_properties $form_name scala            -value $scala  
        element set_properties $form_name piano            -value $piano
        element set_properties $form_name interno          -value $interno
        element set_properties $form_name cod_comune       -value $cod_comune
        element set_properties $form_name cod_qua          -value $cod_qua
        element set_properties $form_name cod_urb          -value $cod_urb
        element set_properties $form_name cap              -value $cap
        element set_properties $form_name cod_tpdu         -value $cod_tpdu
        #data_installazione
        element set_properties $form_name data_variaz      -value $data_variaz
        element set_properties $form_name f_cod_via        -value $cod_via
	element set_properties $form_name gb_x             -value $gb_x
	element set_properties $form_name gb_y             -value $gb_y

	element set_properties $form_name palazzo             -value $palazzo
        #recupero ultima variazione effettuata
        db_1row ultima_mod ""
        if {![string equal $data_variaz ""]} {
            element set_properties $form_name data_variaz  -value $data_variaz
	}
    }

}

if {[form is_valid $form_name]} {
  # form valido dal punto di vista del templating system

    set localita         [element::get_value $form_name localita]
    set descr_topo       [element::get_value $form_name descr_topo]
    set descr_via        [element::get_value $form_name descr_via]
    set numero           [element::get_value $form_name numero]
    set esponente        [element::get_value $form_name esponente]
    set scala            [element::get_value $form_name scala]
    set piano            [element::get_value $form_name piano]
    set interno          [element::get_value $form_name interno]
    set cod_comune       [element::get_value $form_name cod_comune]
    set cod_qua          [element::get_value $form_name cod_qua]
    set cod_urb          [element::get_value $form_name cod_urb]
    set cap              [element::get_value $form_name cap]
    set cod_tpdu         [element::get_value $form_name cod_tpdu]
    set url_list_aimp    [element::get_value $form_name url_list_aimp]
    set url_aimp         [element::get_value $form_name url_aimp]
    set data_ini_valid   [element::get_value $form_name data_ini_valid]
    set data_fin_valid   [element::get_value $form_name data_fin_valid]
    set data_variaz      [element::get_value $form_name data_variaz]
    set f_cod_via        [element::get_value $form_name f_cod_via]
    set cod_via          ""
    set gb_x             [string trim [element::get_value $form_name gb_x]]
    set gb_y             [string trim [element::get_value $form_name gb_y]]
    set palazzo          [string trim [element::get_value $form_name palazzo]]


  # controlli standard su numeri e date, per Ins ed Upd
    set error_num 0
    if {$funzione == "I"
    ||  $funzione == "M"
    } {
	# se la via è valorizzata, ma manca il comune: errore
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
        #se il quartiere è valorizzato, ma manca il comune: errore
        if {![string equal $cod_qua ""]
          && [string equal $cod_comune ""]} {
              element::set_error $form_name cod_comune "valorizzare il Comune"
              incr error_num
        } 

        #se il quartiere ha un comune diverso da quello selezionato: errore
        if {![string equal $cod_qua ""]
         && ![string equal $cod_comune ""]} {
         if {[db_0or1row  recup_comune_qua ""] ==0} {
              element::set_error $form_name cod_qua "quartiere estraneo al Comune"
              incr error_num
	    }
        }

        #se l'area urbana è valorizzata, ma manca il comune: errore
        if {![string equal $cod_urb ""]
          && [string equal $cod_comune ""]} {
              element::set_error $form_name cod_comune "valorizzare il Comune"
              incr error_num
        } 

        #se l'area urbana ha un comune diverso da quello selezionato: errore
        if {![string equal $cod_urb ""]
         && ![string equal $cod_comune ""]} {
         if {[db_0or1row  recup_comune_urb ""] ==0} {
              element::set_error $form_name cod_urb "area urbana estranea al Comune"
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
       
        if {![string equal $gb_x ""]} {
            set gb_x [iter_check_num $gb_x 10]
            if {$gb_x == "Error"} {
                element::set_error $form_name gb_x "numerico con al massimo 17 decimali"
                incr error_num
            } else {
                if {[iter_set_double $gb_x] >=  [expr pow(10,2)]
                ||  [iter_set_double $gb_x] <= -[expr pow(10,2)]} {
                    element::set_error $form_name gb_x "deve essere < di 100"
                    incr error_num
		}
            }
        }

        if {![string equal $gb_y ""]} {
            set gb_y [iter_check_num $gb_y 10]
            if {$gb_y == "Error"} {
                element::set_error $form_name gb_y "numerico con al massimo 17 decimali"
                incr error_num
            } else {
                if {[iter_set_double $gb_y] >=  [expr pow(10,2)]
                ||  [iter_set_double $gb_y] <= -[expr pow(10,2)]} {
                    element::set_error $form_name gb_y "deve essere < di 100"
                    incr error_num
		}
            }
        }

    }

    if {$funzione == "M"
    ||  $funzione == "D"} {
        if {[string equal $data_ini_valid ""]} {
            element::set_error $form_name data_ini_valid "Inserire data"
            incr error_num
        } else {
            set data_ini_valid [iter_check_date $data_ini_valid]
            if {$data_ini_valid == 0} {
                element::set_error $form_name data_ini_valid "data inizio validit&agrave; deve essere una data"
                incr error_num
            }
        }

        #non è possibile storicizzare modifiche con data_validità inferiore a mod         ifiche già storicizzate 
 
       if {![string equal $data_ini_valid ""]} {
            db_1row sel_max_data ""
            if {$data_ini_valid <= $data_max_valid} {
                if {![db_0or1row aggiungi_data {$data_max_valid}] == 0} {
                    element::set_error $form_name data_ini_valid "data validit&agrave; non accettata: situazione attuale valida dal $data_max_valid"
                    incr error_num
		}
	    } else {
                if {![db_0or1row sottrai_data {$data_ini_valid}] == 0} {
                    element set_properties $form_name data_fin_valid  -value $data_fin_valid
                    set data_fin_valid   [element::get_value $form_name data_fin_valid]
                }
   	    }
       }
    }
       

    if {$error_num > 0} {
        ad_return_template
        return
    }
  
    set sw_query "N"
    set dml_sql_stub ""

    if {$funzione == "M"
    ||  $funzione == "D"} {
        #leggo il record originale(prima delle modifiche)dalla tabella coimaimp
        if {![db_0or1row sel_aimp_db {}] == 0} {
            #se almeno un campo dell'ubicazioni è stato modificato rispetto al r             ecord originale (tranne il caso in cui l'originale fosse = ""),viene             storicizzato il record pre-modifica.
	    if {(![string equal $db_localita ""] &&
                 $db_localita       != $localita) 
             || (![string equal $db_cod_via ""] &&
                 $db_cod_via        != $cod_via)
             || (![string equal $db_numero ""] &&
                 $db_numero         != $numero)
             || (![string equal $db_esponente ""] &&
                 $db_esponente      != $esponente)
             || (![string equal $db_scala ""] &&
                 $db_scala          != $scala)
             || (![string equal $db_piano ""] &&
                 $db_piano          != $piano)
             || (![string equal $db_interno ""] &&
                 $db_interno        != $interno)
             || (![string equal $db_cod_comune ""] &&
                 $db_cod_comune     != $cod_comune)
             || (![string equal $db_cap ""] &&
                 $db_cap            != $cap) 
             || (![string equal $db_cod_provincia ""] &&
                 $db_cod_provincia  != $cod_provincia)     
             || (![string equal $db_cod_tpdu ""] &&
                 $db_cod_tpdu       != $cod_tpdu)
             || (![string equal $db_descr_topo ""] &&
                 $db_descr_topo     != $descr_topo)
             || (![string equal $db_descr_via ""] &&
                 $db_descr_via      != $descr_via)
	    } {
                if {[db_0or1row  sel_stub_check ""] ==0} {
                    set sw_query "S"
		}
	    }
	}
    }


  # Lancio la query di manipolazione dati contenute in dml_sql

  # dopo l'inserimento posiziono la lista sul record inserito
    if {$funzione == "I"} {
        set last_cod_impianto $cod_impianto
    }
    set link_list      [subst $link_list_script]
    set link_gest      [export_url_vars cod_impianto last_cod_impianto url_list_aimp url_aimp nome_funz nome_funz_caller extra_par caller]
    switch $funzione {
        V {set return_url   "coimaimp-gest?&url_list_aimp&url_aimp"}
    }

    ad_returnredirect $return_url
    ad_script_abort
}

ad_return_template
