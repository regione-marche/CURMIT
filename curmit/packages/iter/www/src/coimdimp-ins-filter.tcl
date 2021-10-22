ad_page_contract {
    @author          Giulio Laurenzi
    @creation-date   22/08/2005

    @param funzione  V=view
    @param caller    caller della lista da restituire alla lista:
                     serve se lista e' uno zoom che permetti aggiungi.
    @param nome_funz identifica l'entrata di menu, serve per le autorizzazioni
                     serve se lista e' uno zoom che permetti aggiungi.
    @cvs-id          coiminco-filter.tcl
} {
    
   {funzione            "V"}
   {caller          "index"}
   {nome_funz            ""}
   {nome_funz_caller     ""}
   {cod_impianto_old     ""}
   {cod_dimp_old         ""}
   {cod_impianto_est_new ""}

   {f_resp_cogn          ""} 
   {f_resp_nome          ""} 

   {f_comune             ""}
   {f_cod_via            ""}
   {flag_tracciato       ""}
   {f_desc_via           ""}
   {f_desc_topo          ""}
   {f_civico_da          ""}
   {f_civico_a           ""}
} -properties {
    page_title:onevalue
    context_bar:onevalue
    form_name:onevalue
}

# Controlla lo user
set lvl 1
set id_utente [lindex [iter_check_login $lvl $nome_funz] 1]

set cod_comune_chk [iter_check_uten_comu $id_utente]

# controllo il parametro di "propagazione" per la navigation bar
if {[string is space $nome_funz_caller]} {
    set nome_funz_caller $nome_funz
}

if {![string equal $cod_impianto_old ""]} {
    if {[db_0or1row sel_aimp_cod_est ""] == 0} {
	set cod_impianto_est_old ""
    }
    set impianto_old_adp "
       <tr><td colspan=2 align=center>
           <a href=coimaimp-gest?funzione=V&[export_url_vars nome_funz_caller flag_tracciato]&cod_impianto=$cod_impianto_old&nome_funz=impianti ><b>Ultimo allegato inserito con codice: $cod_dimp_old sull'impianto $cod_impianto_est_old</b></a>
         </td>
      </tr>"
} else {
    set impianto_old_adp ""
}

# Personalizzo la pagina

switch $nome_funz {
    "insmodh"  {set page_title      "Inserimento Allegati - Bonifica impianti"
	set titolo          "Inserimento mod H - Ricerca Impianti"     
	set flag_tracciato "H"
    }
    "insmodhbis" {set page_title      "Inserimento Allegati - Bonifica impianti" 
	set titolo          "Inserimento mod. H bis - Bonifica impianti"
	set flag_tracciato "HBIS"
    }
    "insmodg"  {set page_title      "Inserimento Allegati - Bonifica impianti" 
	set titolo          "Inserimento mod. G - Bonifica impianti"
	set flag_tracciato "G"
    }
    "insmodf"  {set page_title      "Inserimento Allegati - Bonifica impianti" 
	set titolo          "Inserimento mod. F - Bonifica impianti"
	set flag_tracciato "F"
    }
    "insmodh-manu"  {set page_title      "Inserimento allegato H per manutentori - Bonifica impianti"
	set titolo          "Inserimento allegato H per manutentori - Ricerca Impianti"     
	set flag_tracciato "HMANU"
    }
    "insmodi-manu"  {set page_title      "Inserimento allegato I per manutentori - Bonifica impianti"
	set titolo          "Inserimento allegato I per manutentori - Ricerca Impianti"     
	set flag_tracciato "IMANU"
    }
	"insmodl-manu"  {set page_title      "Inserimento allegato L per amministratori - Bonifica impianti"
	set titolo          "Inserimento allegato L per amministratori - Ricerca Impianti"     
	set flag_tracciato "LMANU"
    }
    default {set page_title      "Inserimento mod. H - Bonifica impianti"
	set titolo          "Inserimento mod. H - Bonifica impianti"
    }
}


set button_label "Ricerca" 

iter_get_coimtgen
set flag_ente    $coimtgen(flag_ente)
set flag_viario  $coimtgen(flag_viario)
set cod_comune   $coimtgen(cod_comu)
set sigla_prov   $coimtgen(sigla_prov)

set context_bar  [iter_context_bar -nome_funz $nome_funz_caller] 

# sproteggo la chiave solo in inserimento e gli attributi in inserimento e mod.
set form_name    "coimdimpins"
set readonly_key "readonly"
set readonly_fld "readonly"
set disabled_fld "disabled"
set onsubmit_cmd ""

set readonly_fld \{\}
set disabled_fld \{\}
form create $form_name \
-html    $onsubmit_cmd


    element create $form_name cod_impianto_est_new \
    -label   "Codice impianto esterno" \
    -widget   text \
    -datatype text \
    -html    "size 20 maxlength 20 $readonly_fld {} class form_element tabindex 1" \
    -optional


element create $form_name f_resp_cogn \
-label   "Cognome" \
-widget   text \
-datatype text \
-html    "size 20 maxlength 100 $readonly_fld {} class form_element tabindex 2" \
-optional

element create $form_name f_resp_nome \
-label   "Nome" \
-widget   text \
-datatype text \
-html    "size 20 maxlength 100 $readonly_fld {} class form_element tabindex 3" \
-optional


if {$flag_ente == "P"} {
    if {$cod_comune_chk eq ""} {
	element create $form_name f_comune \
	    -label   "Comune" \
	    -widget   select \
	    -datatype text \
	    -html    "$disabled_fld {} class form_element tabindex 4" \
	    -optional \
	    -options [iter_selbox_from_comu]
    } else {
	element create $form_name f_comune \
	    -label   "Comune" \
	    -widget   text \
	    -datatype text \
	    -html    "disabled {} class form_element tabindex 4" \
	    -optional 
		
	element create $form_name cod_comune_chk -widget hidden -datatype text -value $cod_comune_chk
    }
} else {
    element create $form_name f_comune -widget hidden -datatype text -optional
}

element create $form_name f_desc_topo \
-label   "topos" \
-widget   select \
-datatype text \
-html    "$disabled_fld {} class form_element tabindex 5" \
-optional \
-options [iter_selbox_from_table coimtopo descr_topo descr_topo]

element create $form_name f_desc_via \
-label   "Via" \
-widget   text \
-datatype text \
-html    "size 20 maxlength 40 $readonly_fld {} class form_element tabindex 6" \
-optional

element create $form_name f_civico_da \
-label   "Civico da" \
-widget   text \
-datatype text \
-html    "size 4 maxlength 4 $readonly_fld {} class form_element tabindex 8" \
-optional

element create $form_name f_civico_a \
-label   "Civico a" \
-widget   text \
-datatype text \
-html    "size 4 maxlength 4 $readonly_fld {} class form_element tabindex 9" \
-optional

if {$flag_viario == "T"} {
	if {$cod_comune_chk eq ""} {
    set cerca_viae [iter_search $form_name [ad_conn package_url]/tabgen/coimviae-filter [list dummy f_cod_via dummy f_desc_via dummy f_desc_topo cod_comune f_comune dummy dummy dummy dummy]]
	} else {
	set cerca_viae [iter_search $form_name [ad_conn package_url]/tabgen/coimviae-filter [list dummy f_cod_via dummy f_desc_via dummy f_desc_topo cod_comune cod_comune_chk dummy dummy]]	
	}
    regsub {<a href} $cerca_viae {<a tabindex=7 href} cerca_viae
} else {
    set cerca_viae ""
}

element create $form_name f_cod_via      -widget hidden -datatype text -optional
element create $form_name flag_tracciato -widget hidden -datatype text -optional
element create $form_name funzione       -widget hidden -datatype text -optional
element create $form_name caller         -widget hidden -datatype text -optional
element create $form_name nome_funz      -widget hidden -datatype text -optional
element create $form_name dummy          -widget hidden -datatype text -optional
element create $form_name submit         -widget submit -datatype text -label "$button_label" -html "class form_submit tabindex 62"


if {[form is_request $form_name]} {

  # valorizzo i campi di mappa con i parametri ricevuti.
  # serve quando la lista ritorna al filtro.
   	element set_properties $form_name cod_impianto_est_new -value $cod_impianto_est_new
  
    element set_properties $form_name f_resp_cogn        -value $f_resp_cogn
    element set_properties $form_name f_resp_nome        -value $f_resp_nome

    if {$flag_ente == "P"} {
	if {$cod_comune_chk eq ""} {
	    element set_properties $form_name f_comune       -value $f_comune
	} else {
	    element set_properties $form_name f_comune   -value $id_utente
	}
    } else {
	element set_properties $form_name f_comune       -value $cod_comune
    }

    element set_properties $form_name f_cod_via          -value $f_cod_via
    element set_properties $form_name f_desc_topo        -value $f_desc_topo
    element set_properties $form_name f_desc_via         -value $f_desc_via
    element set_properties $form_name f_civico_da        -value $f_civico_da
    element set_properties $form_name f_civico_a         -value $f_civico_a
    element set_properties $form_name funzione            -value $funzione
    element set_properties $form_name caller              -value $caller
    element set_properties $form_name nome_funz           -value $nome_funz
    element set_properties $form_name flag_tracciato      -value $flag_tracciato
}

if {[form is_valid $form_name]} {
    # form valido dal punto di vista del templating system
    set cod_impianto_est_new [string trim [element::get_value $form_name cod_impianto_est_new]]
    
    set f_resp_cogn        [string trim [element::get_value $form_name f_resp_cogn]]
    set f_resp_nome        [string trim [element::get_value $form_name f_resp_nome]]

    if {$cod_comune_chk eq ""} {
	set f_comune           [string trim [element::get_value $form_name f_comune]]
    } else {
	set f_comune       $cod_comune_chk
    }
    set f_cod_via          [string trim [element::get_value $form_name f_cod_via]]
    set f_desc_topo        [string trim [element::get_value $form_name f_desc_topo]]
    set f_civico_da        [string trim [element::get_value $form_name f_civico_da]]
    set f_civico_a         [string trim [element::get_value $form_name f_civico_a]]
    set f_desc_via         [string trim [element::get_value $form_name f_desc_via]]  
    set flag_tracciato     [string trim [element::get_value $form_name flag_tracciato]]

    set error_num 0

    if  {[string equal $cod_impianto_est_new ""]} {
	set sw_filtro_ind "t"
	# per capire se si e' cercato di fare un filtro per indirizzo,
	# per la Provincia e' sufficiente sapere se e' indicato il comune
	# per il Comune    e' necessario sapere se e' indicato il quartiere o la via
	
	if {$flag_ente == "P"} {
	    if {[string equal $f_comune ""]} {
		set sw_filtro_ind "f"
	    }
	} else {
	    if {[string equal $f_desc_via  ""]
		&&  [string equal $f_desc_topo ""]
	    } {
		set sw_filtro_ind "f"
	    }
	}
	
	set mex_err_cod_impianto ""
	if {[string equal $f_resp_cogn        ""]
	    &&  [string equal $f_resp_nome        ""]
	    &&  $sw_filtro_ind == "f"
	} {
	    if {$flag_ente == "P"} {
		set errore_indirizzo "comune"
	    } else {
		set errore_indirizzo "indirizzo"
	    }
	    append mex_err_cod_impianto "Indicare almeno responsabile o $errore_indirizzo<br>"
	}
	if {[string equal $f_resp_cogn        "*"]
	    &&  [string equal $f_resp_nome        ""]
	    &&  $sw_filtro_ind == "f"
	} {
	    if {$flag_ente == "P"} {
		set errore_indirizzo "comune"
	    } else {
		set errore_indirizzo "indirizzo"
	    }
	    append mex_err_cod_impianto "Indicare almeno responsabile o $errore_indirizzo<br>"
	}
	if {[string equal $f_resp_cogn        "*"]
	    &&  [string equal $f_resp_nome        "*"]
	    &&  $sw_filtro_ind == "f"
	} {
	    if {$flag_ente == "P"} {
		set errore_indirizzo "comune"
	    } else {
		set errore_indirizzo "indirizzo"
	    }
	    append mex_err_cod_impianto "Indicare almeno responsabile o $errore_indirizzo o solo il codice impianto<br>"
	}

  
	 #if {![string equal $mex_err_cod_impianto ""]} {
	 #   element::set_error $form_name cod_impianto_est_new $mex_err_cod_impianto
	 #  incr error_num
	 #} else {
	 #   element::set_error $form_name f_resp_cogn $mex_err_cod_impianto
	 #   incr error_num
        #}
    

	if {[string equal $f_resp_cogn ""]
	    && ![string equal $f_resp_nome ""]
	} {
	    element::set_error $form_name f_resp_cogn "Indicare anche il cognome"
	    incr error_num
	}
	
	# si controlla la via solo se il primo test e' andato bene.
	# in questo modo si e' sicuri che f_comune e' stato valorizzato.
	if {$error_num        ==  0
	    &&  $flag_viario      == "T"
	} {
	    if {[string equal $f_desc_via  ""]
		&&  [string equal $f_desc_topo ""]
	    } {
		set f_cod_via ""
	    } else {
		# controllo codice via
		set chk_out_rc      0
		set chk_out_msg     ""
		set chk_out_cod_via ""
		set ctr_viae        0
		if {[string equal $f_desc_topo ""]} {
		    set eq_descr_topo  "is null"
		} else {
		    set eq_descr_topo  "= upper(:f_desc_topo)"
		}
		if {[string equal $f_desc_via ""]} {
		    set eq_descrizione "is null"
		} else {
		    set eq_descrizione "= upper(:f_desc_via)"
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
		if {$chk_out_rc == 0} {
		    element::set_error $form_name f_desc_via $chk_out_msg
		    incr error_num
		}
	    }
	} else {
	    set f_cod_via ""
	}

	if {(    [string equal $f_desc_topo ""]
		 &&  [string equal $f_desc_via  ""]
		 &&  [string equal $f_cod_via   ""])
	    &&  (   ![string equal $f_civico_da ""]
		    || ![string equal $f_civico_a  ""])
	} {
	    element::set_error $form_name f_desc_via "La selezione per numero civico viene effettuata solo insieme alla selezione per via"
	    incr error_num
	}
	set err_civico ""
	set check_civico_da "f"
	if {![string equal $f_civico_da ""]} {
	    if {![string is integer $f_civico_da]} {
		append err_civico "Civico di Inizio deve essere un numero intero"
		element::set_error $form_name f_civico_da $err_civico
		incr error_num
	    } else {
		set check_civico_da "t"
	    }
	}
	
	set check_civico_a  "f"
	if {![string equal $f_civico_a ""]} {
	    if {![string is integer $f_civico_a]} {
		if {![string equal $err_civico ""]} {
		    append err_civico "<br>"
		}
		append err_civico "Civico di Fine deve essere un numero intero"
		element::set_error $form_name f_civico_da $err_civico
		incr error_num
	    } else {
		set check_civico_a  "t"
	    }
	}
	
	if {$check_civico_a  == "t"
	    &&  $check_civico_da == "t"
	    &&  $f_civico_a < $f_civico_da
	} {
	    if {![string equal $err_civico ""]} {
		append err_civico "<br>"
	    }
	    append err_civico "Civico iniziale deve essere minore del civico finale"
	    element::set_error $form_name f_civico_da $err_civico
	    incr error_num
	}

    } else {

	if {[string length $cod_impianto_est_new] > 20} {
	    element::set_error $form_name cod_impianto_est_new "Indicare  almeno il codice impianto oppure Responsabile o indirizzo"
	    incr error_num
	}
       if {![string equal $f_resp_cogn ""]} {
	    element::set_error $form_name cod_impianto_est_new "Con il Codice Impianto non  Indicare il Responsabile"
	    incr error_num
	}
       if {![string equal $f_resp_nome ""]} {
	    element::set_error $form_name cod_impianto_est_new "Con il Codice Impianto non Indicare  il Responsabile"
	    incr error_num
	}
     if {![string equal $f_desc_via ""]} {
	    element::set_error $form_name cod_impianto_est_new "Con il Codice Impianto non Indicare l'indirizzo"
	    incr error_num
	}
      if {![string equal $f_desc_topo ""]} {
	    element::set_error $form_name cod_impianto_est_new "Con il Codice Impianto non Indicare l'indirizzo"
	    incr error_num
	}
      if {![string equal $f_civico_a ""]} {
	    element::set_error $form_name cod_impianto_est_new "Con il Codice Impianto non Indicare l'indirizzo"
	    incr error_num
	}
    if {![string equal $f_civico_da ""]} {
	    element::set_error $form_name cod_impianto_est_new "Con il Codice Impianto non Indicare l'indirizzo"
	    incr error_num
	}
    }
    if {$error_num > 0} {
        ad_return_template
        return
    }

    set link_list [export_url_vars flag_tracciato cod_impianto_est_new f_resp_cogn f_resp_nome f_comune f_cod_via f_desc_via f_desc_topo f_civico_da f_civico_a caller funzione nome_funz_caller nome_funz]

    set return_url "coimdimp-ins-list?$link_list"    

    ad_returnredirect $return_url
    ad_script_abort
}
 
ad_return_template
