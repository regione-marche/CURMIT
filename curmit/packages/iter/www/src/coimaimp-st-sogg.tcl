ad_page_contract {
    Add/Edit/Delete  form per la tabella "coimaimp"
    @author          Giulio Laurenzi / Katia Coazzoli
    @creation-date   05/04/2004

    @param funzione  I=insert M=edit D=delete V=view
    @param caller    caller della lista da restituire alla lista:
                     serve se lista e' uno zoom che permetti aggiungi.
    @param nome_funz identifica l'entrata di menu, server per le autorizzazioni
                     serve se lista e' uno zoom che permetti aggiungi.
    @param extra_par Variabili extra da restituire alla lista
    @cvs-id          coimaimp-gest.tcl
} {
    
   {cod_impianto       ""}
   {st_progressivo     ""}
   {st_data_validita   ""}
   {last_cod_impianto  ""}
   {funzione          "V"}
   {caller        "index"}
   {nome_funz          ""}
   {nome_funz_caller   ""}
   {extra_par          ""}
   {url_aimp           ""}
   {url_list_aimp      ""}
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
set link_gest [export_url_vars cod_impianto st_progressivo st_data_validita url_list_aimp url_aimp last_cod_impianto nome_funz nome_funz_caller extra_par caller]

# controllo il parametro di "propagazione" per la navigation bar
if {[string is space $nome_funz_caller]} {
    set nome_funz_caller $nome_funz
}

set link_tab [iter_links_st_form $cod_impianto $st_progressivo $nome_funz_caller $url_list_aimp $url_aimp $st_data_validita]
set dett_tab [iter_tab_st_form $cod_impianto $st_progressivo]

# imposta le class css della barra delle funzioni
iter_set_func_class $funzione

# Personalizzo la pagina

set link_list_script {[export_url_vars last_cod_impianto caller nome_funz nome_funz_caller]&[iter_set_url_vars $extra_par]}
set link_list        [subst $link_list_script]

set titolo           "Soggetti interessati"
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

#preparo il link al programma Storico soggetti
set link_rife  [export_url_vars cod_impianto nome_funz_caller url_list_aimp url_aimp]&nome_funz=[iter_get_nomefunz coimrifs-list]

# sproteggo la chiave solo in inserimento e gli attributi in inserimento e mod.
set form_name    "coimsoggaimp"
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


element create $form_name flag_responsabile \
-label   "responsabile" \
-widget   select \
-datatype text \
-html    "$disabled_fld {} class form_element" \
-optional \
-options {{{} {}} {Proprietario P} {Occupante O} {Amministratore A} {Intestatario I} {Terzi T}}

#intestatario
element create $form_name cognome_inte \
-label   "Cognome intestatario" \
-widget   text \
-datatype text \
-html    "size 35 maxlength 100 $readonly_fld {} class form_element" \
-optional

element create $form_name nome_inte \
-label   "Nome intestatario" \
-widget   text \
-datatype text \
-html    "size 20 maxlength 100 $readonly_fld {} class form_element" \
-optional

if {$funzione == "V"} {
    element create $form_name cod_fiscale_inte \
    -label   "Cod.Fiscale intestatario" \
    -widget   text \
    -datatype text \
    -html    "size 16 maxlength 16 $readonly_key {} class form_element" \
    -optional
}

#proprietario
element create $form_name cognome_prop \
-label   "Cognome proprietario" \
-widget   text \
-datatype text \
-html    "size 35 maxlength 100 $readonly_fld {} class form_element" \
-optional

element create $form_name nome_prop \
-label   "Nome proprietario" \
-widget   text \
-datatype text \
-html    "size 20 maxlength 100 $readonly_fld {} class form_element" \
-optional

if {$funzione == "V"} {
    element create $form_name cod_fiscale_prop \
    -label   "Cod.Fiscale proprietario" \
    -widget   text \
    -datatype text \
    -html    "size 16 maxlength 16 $readonly_key {} class form_element" \
    -optional
}

#occupante
element create $form_name cognome_occ \
-label   "Cognome occupante" \
-widget   text \
-datatype text \
-html    "size 35 maxlength 100 $readonly_fld {} class form_element" \
-optional

element create $form_name nome_occ \
-label   "Nome occupante" \
-widget   text \
-datatype text \
-html    "size 20 maxlength 100 $readonly_fld {} class form_element" \
-optional

if {$funzione == "V"} {
    element create $form_name cod_fiscale_occ \
    -label   "Cod.Fiscale occupante" \
    -widget   text \
    -datatype text \
    -html    "size 16 maxlength 16 $readonly_key {} class form_element" \
    -optional
}

#amministratore
element create $form_name cognome_amm \
-label   "Cognome amministratore" \
-widget   text \
-datatype text \
-html    "size 35 maxlength 100 $readonly_fld {} class form_element" \
-optional

element create $form_name nome_amm \
-label   "Nome amministratore" \
-widget   text \
-datatype text \
-html    "size 20 maxlength 100 $readonly_fld {} class form_element" \
-optional

if {$funzione == "V"} {
    element create $form_name cod_fiscale_amm \
    -label   "Cod.Fiscale amministratore" \
    -widget   text \
    -datatype text \
    -html    "size 16 maxlength 16 $readonly_key {} class form_element" \
    -optional
}

#terzi
element create $form_name cognome_terzi \
-label   "Cognome terzi" \
-widget   text \
-datatype text \
-html    "size 35 maxlength 100 $readonly_fld {} class form_element" \
-optional

element create $form_name nome_terzi \
-label   "Nome terzi" \
-widget   text \
-datatype text \
-html    "size 20 maxlength 100 $readonly_fld {} class form_element" \
-optional

if {$funzione == "V"} {
    element create $form_name cod_fiscale_terzi \
    -label   "Cod.Fiscale terzi" \
    -widget   text \
    -datatype text \
    -html    "size 16 maxlength 16 $readonly_key {} class form_element" \
    -optional
}

element create $form_name data_variaz \
-label   "data_variaz" \
-widget   text \
-datatype text \
-html    "size 10 maxlength 10 $readonly_key {} class form_element" \
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


if {$funzione == "I"
||  $funzione == "M"
} {
    set cerca_inte  [iter_search $form_name coimcitt-filter [list dummy cod_intestatario   f_cognome cognome_inte f_nome nome_inte]]

    set cerca_prop  [iter_search $form_name coimcitt-filter [list dummy cod_proprietario   f_cognome cognome_prop f_nome nome_prop]]

    set cerca_occ   [iter_search $form_name coimcitt-filter [list dummy cod_occupante      f_cognome cognome_occ  f_nome nome_occ ]]

    set cerca_amm   [iter_search $form_name coimcitt-filter [list dummy cod_amministratore f_cognome cognome_amm  f_nome nome_amm ]]

    set cerca_terzi [iter_search $form_name coimmanu-list [list dummy cod_terzi dummy cognome_terzi dummy nome_terzi] [list f_ruolo "M"]]

} else {
    set cerca_inte  ""
    set cerca_prop  ""
    set cerca_occ   ""
    set cerca_amm   ""
    set cerca_terzi ""
}

element create $form_name dummy              -widget hidden -datatype text -optional
element create $form_name cod_manutentore    -widget hidden -datatype text -optional
element create $form_name nome_funz_new      -widget hidden -datatype text -optional
element create $form_name cod_impianto       -widget hidden -datatype text -optional
element create $form_name cod_intestatario   -widget hidden -datatype text -optional
element create $form_name cod_proprietario   -widget hidden -datatype text -optional
element create $form_name cod_occupante      -widget hidden -datatype text -optional
element create $form_name cod_amministratore -widget hidden -datatype text -optional
element create $form_name cod_terzi          -widget hidden -datatype text -optional
element create $form_name url_list_aimp      -widget hidden -datatype text -optional
element create $form_name url_aimp           -widget hidden -datatype text -optional
element create $form_name funzione           -widget hidden -datatype text -optional
element create $form_name caller             -widget hidden -datatype text -optional
element create $form_name nome_funz          -widget hidden -datatype text -optional
element create $form_name nome_funz_caller   -widget hidden -datatype text -optional
element create $form_name extra_par          -widget hidden -datatype text -optional
element create $form_name data_fin_valid     -widget hidden -datatype text -optional
element create $form_name submit             -widget submit -datatype text -label "$button_label" -html "class form_submit"
element create $form_name last_cod_impianto  -widget hidden -datatype text -optional


if {$funzione != "M"
&&  $funzione != "D"
} {
    element create $form_name data_ini_valid -widget hidden -datatype text -optional
}

set label_proprietario   "Proprietario"
set label_occupante      "Occupante"
set label_amministratore "Amministratore"
set label_intestatario   "Intestatario contratto"
set label_terzi          "Terzo responsabile"

if {[form is_request $form_name]} {

    set nome_funz_new [iter_get_nomefunz coimcitt-isrt]

    element set_properties $form_name nome_funz_new   -value $nome_funz_new
    element set_properties $form_name funzione          -value $funzione
    element set_properties $form_name url_aimp          -value $url_aimp
    element set_properties $form_name url_list_aimp     -value $url_list_aimp
    element set_properties $form_name caller            -value $caller
    element set_properties $form_name nome_funz         -value $nome_funz
    element set_properties $form_name nome_funz_caller  -value $nome_funz_caller
    element set_properties $form_name extra_par         -value $extra_par
    element set_properties $form_name last_cod_impianto -value $last_cod_impianto   
    element set_properties $form_name cod_impianto      -value $cod_impianto
    if {![db_0or1row recup_date {}] == 0} {
        element set_properties $form_name data_ini_valid  -value $data_ini_valid
        element set_properties $form_name data_fin_valid  -value $data_fin_valid
    }

    if {$funzione == "I"} {

    } else {
      # leggo riga

	set join_resp_post " left outer join coimcitt e on e.cod_cittadino = a.cod_responsabile"
	set join_resp_ora " , coimcitt e"
	set join_prop_post " left outer join coimcitt b on b.cod_cittadino = a.cod_proprietario"
	set join_prop_ora " , coimcitt b"
	set join_occu_post " left outer join coimcitt c on c.cod_cittadino = a.cod_occupante"
	set join_occu_ora " , coimcitt c"
	set join_ammi_post " left outer join coimcitt d on d.cod_cittadino = a.cod_amministratore"
	set join_ammi_ora " , coimcitt d"
	set join_inte_post " left outer join coimcitt f on f.cod_cittadino = a.cod_intestatario"
	set join_inte_ora " , coimcitt f"

	db_1row sel_data_aimp_st "select st_data_validita as data_aimp_st
                                       , cod_amministratore
                                       , cod_proprietario
                                       , cod_responsabile
                                       , cod_occupante
                                       , cod_intestatario
                                    from coimaimp_st
                                   where st_progressivo = :st_progressivo
                                     and cod_impianto = :cod_impianto"

	# responsabile
	if {![string equal $cod_responsabile ""]
	 && ![string equal $data_aimp_st ""]} {
	    db_0or1row sel_data_sogg_st "select min(st_data_validita) as data_sogg_st
                                            from coimcitt_st
                                           where cod_cittadino = :cod_responsabile
                                             and st_data_validita >= :data_aimp_st"
	    if {[string equal $data_sogg_st ""]} {
		set join_resp_post " left outer join coimcitt e on e.cod_cittadino = a.cod_responsabile"
		set join_resp_ora " , coimcitt e"
	    } else {
		db_1row sel_progressivo "select max(st_progressivo) as st_prog_sogg_resp
                                       from coimcitt_st
                                      where cod_cittadino = :cod_responsabile
                                        and st_data_validita = :data_sogg_st"
		
		db_1row sel_data_sogg_mod "select data_mod as data_mod_sogg from coimcitt where cod_cittadino = :cod_responsabile"
		if {$data_mod_sogg > $data_aimp_st} {
		    set join_resp_post " left outer join coimcitt_st e on e.cod_cittadino = a.cod_responsabile
                                                                  and e.st_progressivo = :st_prog_sogg_resp"
		    set join_resp_ora " , coimcitt_st e"
		} else {
		    if {$data_mod_sogg > $data_sogg_st} {
			set join_resp_post " left outer join coimcitt e on e.cod_cittadino = a.cod_responsabile"
			set join_resp_ora " , coimcitt e"
		    } else {
			set join_resp_post " left outer join coimcitt_st e on e.cod_cittadino = a.cod_responsabile
                                                                  and e.st_progressivo = :st_prog_sogg_resp"
			set join_resp_ora " , coimcitt_st e"
		    }
		}
	    }
	}

	# proprietario
	if {![string equal $cod_proprietario ""]
	 && ![string equal $data_aimp_st ""]} {
	    db_0or1row sel_data_sogg_st "select min(st_data_validita) as data_sogg_st
                                            from coimcitt_st
                                           where cod_cittadino = :cod_proprietario
                                             and st_data_validita >= :data_aimp_st"
	    if {[string equal $data_sogg_st ""]} {
		set join_prop_post " left outer join coimcitt b on b.cod_cittadino = a.cod_proprietario"
		set join_prop_ora " , coimcitt b"
	    } else {
		db_1row sel_progressivo "select max(st_progressivo) as st_prog_sogg_prop
                                       from coimcitt_st
                                      where cod_cittadino = :cod_proprietario
                                        and st_data_validita = :data_sogg_st"

		db_1row sel_data_sogg_mod "select data_mod as data_mod_sogg from coimcitt where cod_cittadino = :cod_proprietario"
		if {$data_mod_sogg > $data_aimp_st} {
		    set join_prop_post " left outer join coimcitt_st b on b.cod_cittadino = a.cod_proprietario
                                                                  and b.st_progressivo = :st_prog_sogg_prop"
		    set join_prop_ora " , coimcitt_st b"
		} else {
		    if {$data_mod_sogg > $data_sogg_st} {
			set join_prop_post " left outer join coimcitt b on b.cod_cittadino = a.cod_proprietario"
			set join_prop_ora " , coimcitt b"
		    } else {
			set join_prop_post " left outer join coimcitt_st b on b.cod_cittadino = a.cod_proprietario
                                                                  and b.st_progressivo = :st_prog_sogg_prop"
			set join_prop_ora " , coimcitt_st b"
		    }
		}
	    }
	}

	# occupante
	if {![string equal $cod_occupante ""]
	 && ![string equal $data_aimp_st ""]} {
	    db_0or1row sel_data_sogg_st "select min(st_data_validita) as data_sogg_st
                                            from coimcitt_st
                                           where cod_cittadino = :cod_occupante
                                             and st_data_validita >= :data_aimp_st"
	    if {[string equal $data_sogg_st ""]} {
		set join_occu_post " left outer join coimcitt c on c.cod_cittadino = a.cod_occupante"
		set join_occu_ora " , coimcitt c"
	    } else {
		db_1row sel_progressivo "select max(st_progressivo) as st_prog_sogg_occu
                                       from coimcitt_st
                                      where cod_cittadino = :cod_occupante
                                        and st_data_validita = :data_sogg_st"

		db_1row sel_data_sogg_mod "select data_mod as data_mod_sogg from coimcitt where cod_cittadino = :cod_occupante"
		if {$data_mod_sogg > $data_aimp_st} {
		    set join_occu_post " left outer join coimcitt_st c on c.cod_cittadino = a.cod_occupante
                                                                  and c.st_progressivo = :st_prog_sogg_occu"
		    set join_occu_ora " , coimcitt_st c"
		} else {
		    if {$data_mod_sogg > $data_sogg_st} {
			set join_occu_post " left outer join coimcitt c on c.cod_cittadino = a.cod_occupante"
			set join_occu_ora " , coimcitt c"
		    } else {
			set join_occu_post " left outer join coimcitt_st c on c.cod_cittadino = a.cod_occupante
                                                                  and c.st_progressivo = :st_prog_sogg_occu"
			set join_occu_ora " , coimcitt_st c"
		    }
		}
	    }
	}

	# amministratore
	if {![string equal $cod_amministratore ""]
	 && ![string equal $data_aimp_st ""]} {
	    db_0or1row sel_data_sogg_st "select min(st_data_validita) as data_sogg_st
                                            from coimcitt_st
                                           where cod_cittadino = :cod_amministratore
                                             and st_data_validita >= :data_aimp_st"
	    if {[string equal $data_sogg_st ""]} {
		set join_ammi_post " left outer join coimcitt d on d.cod_cittadino = a.cod_amministratore"
		set join_ammi_ora " , coimcitt d"
	    } else {
		db_1row sel_progressivo "select max(st_progressivo) as st_prog_sogg_ammi
                                       from coimcitt_st
                                      where cod_cittadino = :cod_amministratore
                                        and st_data_validita = :data_sogg_st"

		db_1row sel_data_sogg_mod "select data_mod as data_mod_sogg from coimcitt where cod_cittadino = :cod_amministratore"
		if {$data_mod_sogg > $data_aimp_st} {
		    set join_ammi_post " left outer join coimcitt_st d on d.cod_cittadino = a.cod_amministratore
                                                                  and d.st_progressivo = :st_prog_sogg_ammi"
		    set join_ammi_ora " , coimcitt_st d"
		} else {
		    if {$data_mod_sogg > $data_sogg_st} {
			set join_ammi_post " left outer join coimcitt d on d.cod_cittadino = a.cod_amministratore"
			set join_ammi_ora " , coimcitt d"
		    } else {
			set join_ammi_post " left outer join coimcitt_st d on d.cod_cittadino = a.cod_amministratore
                                                                  and d.st_progressivo = :st_prog_sogg_ammi"
			set join_ammi_ora " , coimcitt_st d"
		    }
		}
	    }
	}

	# intestatario
	if {![string equal $cod_intestatario ""]
	 && ![string equal $data_aimp_st ""]} {
	    db_0or1row sel_data_sogg_st "select min(st_data_validita) as data_sogg_st
                                            from coimcitt_st
                                           where cod_cittadino = :cod_intestatario
                                             and st_data_validita >= :data_aimp_st"
	    if {[string equal $data_sogg_st ""]} {
		set join_inte_post " left outer join coimcitt f on f.cod_cittadino = a.cod_intestatario"
		set join_inte_ora " , coimcitt f"
	    } else {
		db_1row sel_progressivo "select max(st_progressivo) as st_prog_sogg_inte
                                       from coimcitt_st
                                      where cod_cittadino = :cod_intestatario
                                        and st_data_validita = :data_sogg_st"
		db_1row sel_data_sogg_mod "select data_mod as data_mod_sogg from coimcitt where cod_cittadino = :cod_intestatario"
		if {$data_mod_sogg > $data_aimp_st} {
		    set join_inte_post " left outer join coimcitt_st f on f.cod_cittadino = a.cod_intestatario
                                                                  and f.st_progressivo = :st_prog_sogg_inte"
		    set join_inte_ora " , coimcitt_st f"
		} else {
		    if {$data_mod_sogg > $data_sogg_st} {
			set join_inte_post " left outer join coimcitt f on f.cod_cittadino = a.cod_intestatario"
			set join_inte_ora " , coimcitt f"
		    } else {
			set join_inte_post " left outer join coimcitt_st f on f.cod_cittadino = a.cod_intestatario
                                                                  and f.st_progressivo = :st_prog_sogg_inte"
			set join_inte_ora " , coimcitt_st f"
		    }
		}
	    }
	}

        if {[db_0or1row sel_rif_sogg {}] == 0} {
            iter_return_complaint "Record non trovato"
	}

	if {$funzione == "V"
        ||  $funzione == "D"
	} {
	    if {![string equal $cod_proprietario ""]} {
		if {$join_prop_ora == " , coimcitt b"} {
		    set label_proprietario "<a href=\"coimcitt-gest?funzione=V&nome_funz=[iter_get_nomefunz coimcitt-gest]&cod_cittadino=$cod_proprietario&flag_java=t\" target=proprietario>Proprietario</a>"
		} else {
		    set label_proprietario "<a href=\"coimcitt-st-gest?funzione=V&nome_funz=[iter_get_nomefunz coimcitt-gest]&cod_cittadino=$cod_proprietario&st_progressivo=$st_prog_sogg_prop&flag_java=t\" target=proprietario>Proprietario</a>"
		}
	    }

	    if {![string equal $cod_occupante ""]} {
		if {$join_occu_ora == " , coimcitt c"} {
		    set label_occupante "<a href=\"coimcitt-gest?funzione=V&nome_funz=[iter_get_nomefunz coimcitt-gest]&cod_cittadino=$cod_occupante&flag_java=t\" target=occupante>Occupante</a>"
		} else {
		    set label_occupante "<a href=\"coimcitt-st-gest?funzione=V&nome_funz=[iter_get_nomefunz coimcitt-st-gest]&cod_cittadino=$cod_occupante&st_progressivo=$st_prog_sogg_occu&flag_java=t\" target=occupante>Occupante</a>"
		}
	    }

	    if {![string equal $cod_amministratore ""]} {
		if {$join_ammi_ora == " , coimcitt d"} {
		    set label_amministratore "<a href=\"coimcitt-gest?funzione=V&nome_funz=[iter_get_nomefunz coimcitt-gest]&cod_cittadino=$cod_amministratore&flag_java=t\" target=amministratore>Amministratore</a>"
		} else {
		    set label_amministratore "<a href=\"coimcitt-st-gest?funzione=V&nome_funz=[iter_get_nomefunz coimcitt-gest]&cod_cittadino=$cod_amministratore&st_progressivo=$st_prog_sogg_ammi&flag_java=t\" target=amministratore>Amministratore</a>"
		}
	    }

	    if {![string equal $cod_intestatario ""]} {
		if {$join_inte_ora == " , coimcitt f"} {
		    set label_intestatario "<a href=\"coimcitt-gest?funzione=V&nome_funz=[iter_get_nomefunz coimcitt-gest]&cod_cittadino=$cod_intestatario&flag_java=t\" target=intestatario>Intestatario contratto</a>"
		} else {
		    set label_intestatario "<a href=\"coimcitt-st-gest?funzione=V&nome_funz=[iter_get_nomefunz coimcitt-gest]&cod_cittadino=$cod_intestatario&st_progressivo=$st_prog_sogg_inte&flag_java=t\" target=intestatario>Intestatario contratto</a>"
		}
	    }

	    if {$flag_responsabile == "T"} {
                if {$join_resp_ora == " , coimcitt e"} {
		    set label_terzi "<a href=\"coimcitt-gest?funzione=V&nome_funz=[iter_get_nomefunz coimcitt-gest]&cod_cittadino=$cod_responsabile&flag_java=t\" target=terzo responsabile>Terzo responsabile</a>"
		} else {
		    set label_terzi "<a href=\"coimcitt-gest?funzione=V&nome_funz=[iter_get_nomefunz coimcitt-gest]&cod_cittadino=$cod_responsabile&st_progressivo=$st_prog_sogg_resp&flag_java=t\" target=terzo responsabile>Terzo responsabile</a>"
		}
	    }
	}

	switch $flag_responsabile { 
            T  {element set_properties $form_name cognome_terzi -value $cognome_terzo
                element set_properties $form_name nome_terzi    -value $nome_terzo
                element set_properties $form_name cod_terzi     -value $cod_responsabile
                if {$funzione == "V"} {
                    element set_properties $form_name cod_fiscale_terzi -value $cod_fiscale_terzo
		}
	    }
	}

        element set_properties $form_name cod_proprietario   -value $cod_proprietario
      
        if {$funzione == "V"} {
            element set_properties $form_name cod_fiscale_prop   -value $cod_fiscale_prop
	}
        element set_properties $form_name cod_occupante      -value $cod_occupante
        if {$funzione == "V"} {
            element set_properties $form_name cod_fiscale_occ   -value $cod_fiscale_occ
	}
        element set_properties $form_name cod_amministratore -value $cod_amministratore
        if {$funzione == "V"} {
            element set_properties $form_name cod_fiscale_amm    -value $cod_fiscale_amm
	}
        element set_properties $form_name cod_intestatario   -value $cod_intestatario
        if {$funzione == "V"} {
            element set_properties $form_name cod_fiscale_inte   -value $cod_fiscale_inte
	}
        element set_properties $form_name cognome_prop     -value $cognome_prop
        element set_properties $form_name nome_prop        -value $nome_prop
        element set_properties $form_name cognome_inte     -value $cognome_inte
        element set_properties $form_name nome_inte        -value $nome_inte   
        element set_properties $form_name cognome_occ      -value $cognome_occ 
        element set_properties $form_name nome_occ         -value $nome_occ    
        element set_properties $form_name cognome_amm      -value $cognome_amm
        element set_properties $form_name nome_amm         -value $nome_amm

        element set_properties $form_name flag_responsabile -value $flag_responsabile
        #data_installazione
        element set_properties $form_name data_variaz      -value $data_variaz

        #recupero ultima variazione effettuata
        db_1row ultima_mod ""
        if {![string equal $data_variaz ""]} {
            element set_properties $form_name data_variaz  -value $data_variaz
	}
    }
}

if {[form is_valid $form_name]} {
  # form valido dal punto di vista del templating system
    set flag_responsabile  [element::get_value $form_name flag_responsabile]
    set cod_intestatario   [element::get_value $form_name cod_intestatario]
    if {$funzione == "V"} {
       set cod_fiscale_inte   [element::get_value $form_name cod_fiscale_inte]
    }
    set cognome_inte       [element::get_value $form_name cognome_inte]
    set nome_inte          [element::get_value $form_name nome_inte]
    set cod_proprietario   [element::get_value $form_name cod_proprietario]
    if {$funzione == "V"} {
       set cod_fiscale_prop   [element::get_value $form_name cod_fiscale_prop]
    }
    set cognome_prop       [element::get_value $form_name cognome_prop]
    set nome_prop          [element::get_value $form_name nome_prop]
    set cod_occupante      [element::get_value $form_name cod_occupante]
    if {$funzione == "V"} {
       set cod_fiscale_occ    [element::get_value $form_name cod_fiscale_occ]
    }
    set cognome_occ        [element::get_value $form_name cognome_occ]
    set nome_occ           [element::get_value $form_name nome_occ]
    set cod_amministratore [element::get_value $form_name cod_amministratore]
    if {$funzione == "V"} {
       set cod_fiscale_amm    [element::get_value $form_name cod_fiscale_amm]
    }
    set cognome_amm        [element::get_value $form_name cognome_amm]
    set nome_amm           [element::get_value $form_name nome_amm]
    set cod_terzi          [element::get_value $form_name cod_terzi]
    if {$funzione == "V"} {
       set cod_fiscale_terzi  [element::get_value $form_name cod_fiscale_terzi]
    }
    set cognome_terzi      [element::get_value $form_name cognome_terzi]
    set nome_terzi         [element::get_value $form_name nome_terzi]
    set url_list_aimp      [element::get_value $form_name url_list_aimp]
    set url_aimp           [element::get_value $form_name url_aimp]
    set data_ini_valid     [element::get_value $form_name data_ini_valid]
    set data_fin_valid     [element::get_value $form_name data_fin_valid]
    set data_variaz        [element::get_value $form_name data_variaz]

    if {[db_0or1row sel_aimp ""] == 0} {
	set flag_dichiarato "S"
    }

  # controlli standard su numeri e date, per Ins ed Upd
    set error_num 0

    if {$funzione == "I"
    ||  $funzione == "M"
    } {
        #routine generica per controllo codice soggetto
        set check_cod_citt {
            set chk_out_rc       0
            set chk_out_msg      ""
            set chk_out_cod_citt ""
            set ctr_citt         0
            if {[string equal $chk_inp_cognome ""]} {
                set eq_cognome "is null"
	    } else {
                set eq_cognome "= upper(:chk_inp_cognome)"
	    }
            if {[string equal $chk_inp_nome ""]} {
                set eq_nome    "is null"
	    } else {
                set eq_nome    "= upper(:chk_inp_nome)"
	    }
            db_foreach sel_citt "" {
                incr ctr_citt
                if {$cod_cittadino == $chk_inp_cod_citt} {
		    set chk_out_cod_citt $cod_cittadino
                    set chk_out_rc       1
		}
	    }
            switch $ctr_citt {
 		0 { set chk_out_msg "Soggetto non trovato"}
	 	1 { set chk_out_cod_citt $cod_cittadino
		    set chk_out_rc       1 }
	  default {
                    if {$chk_out_rc == 0} {
			set chk_out_msg "Trovati pi&ugrave; soggetti: usa il link cerca"
		    }
 		}
	    }
 	}

        if {[string equal $cognome_inte ""]
	&&  [string equal $nome_inte    ""]
	} {
            set cod_intestatario ""
	} else {
	    set chk_inp_cod_citt $cod_intestatario
	    set chk_inp_cognome  $cognome_inte
	    set chk_inp_nome     $nome_inte
	    eval $check_cod_citt
            set cod_intestatario $chk_out_cod_citt
            if {$chk_out_rc == 0} {
                element::set_error $form_name cognome_inte $chk_out_msg
                incr error_num
	    }
	}

        if {[string equal $cognome_prop ""]
	&&  [string equal $nome_prop    ""]
	} {
            set cod_proprietario ""
	} else {
	    set chk_inp_cod_citt $cod_proprietario
	    set chk_inp_cognome  $cognome_prop
	    set chk_inp_nome     $nome_prop
	    eval $check_cod_citt
            set cod_proprietario $chk_out_cod_citt
            if {$chk_out_rc == 0} {
                element::set_error $form_name cognome_prop $chk_out_msg
                incr error_num
	    }
	}

        if {[string equal $cognome_occ ""]
	&&  [string equal $nome_occ    ""]
	} {
            set cod_occupante ""
	} else {
	    set chk_inp_cod_citt $cod_occupante
	    set chk_inp_cognome  $cognome_occ
	    set chk_inp_nome     $nome_occ
	    eval $check_cod_citt
            set cod_occupante    $chk_out_cod_citt
            if {$chk_out_rc == 0} {
                element::set_error $form_name cognome_occ $chk_out_msg
                incr error_num
	    }
	}

        if {[string equal $cognome_amm ""]
	&&  [string equal $nome_amm    ""]
	} {
            set cod_amministratore ""
	} else {
	    set chk_inp_cod_citt   $cod_amministratore
	    set chk_inp_cognome    $cognome_amm
	    set chk_inp_nome       $nome_amm
	    eval $check_cod_citt
            set cod_amministratore $chk_out_cod_citt
            if {$chk_out_rc == 0} {
                element::set_error $form_name cognome_amm $chk_out_msg
                incr error_num
	    }
	}

        if {[string equal $cognome_terzi ""]
	&&  [string equal $nome_terzi    ""]
	} {
            set cod_terzi ""
	} else {
	    if {![string equal $flag_responsabile "T"]} {
		element::set_error $form_name cognome_terzi "non inserire terzo responsabile: non &egrave; il responsabile"
		incr error_num
	    } else {
		set cod_manutentore $cod_terzi
		element set_properties $form_name cod_manutentore   -value $cod_manutentore
		if {[db_0or1row sel_cod_legale ""] == 0} {
		    set link_ins_rapp [iter_link_ins $form_name coimcitt-isrt [list cognome cognome_terzi nome nome_terzi nome_funz nome_funz_new dummy cod_terzi dummy dummy  cod_manutentore] "crea auomaticamente legale rappresentante"]

		    element::set_error $form_name cognome_terzi "aggiornare il manutentore con i dati del legale rappresentante <br>o $link_ins_rapp"
		    incr error_num
		} else {
		    set chk_inp_cod_citt $cod_terzi
		    set chk_inp_cognome  $cognome_terzi
		    set chk_inp_nome     $nome_terzi
		    eval $check_cod_citt
		    set cod_terzi        $chk_out_cod_citt
		    if {$chk_out_rc == 0} {
			element::set_error $form_name cognome_terzi $chk_out_msg
			incr error_num
		    }
		}
	    }
	}

        #congruenza cod_resp con rispettivo codice
        switch $flag_responsabile {
	    "T" {
		if {[string equal $cognome_terzi ""]
	        &&  [string equal $nome_terzi ""]
		} {
		    element::set_error $form_name cognome_terzi "inserire terzo responsabile: &egrave; il responsabile"
		    incr error_num
		} else {
		    set cod_responsabile $cod_terzi
		}
	    }
	    "P" {
		if {[string equal $cognome_prop ""]
	        &&  [string equal $nome_prop ""]
		} {
		    element::set_error $form_name cognome_prop "inserire proprietario: &egrave; il responsabile"
		    incr error_num
		} else {
		    set cod_responsabile $cod_proprietario
		}
	    }
	    "O" {
		if {[string equal $cognome_occ ""]
	        &&  [string equal $nome_occ ""]
		} {
		    element::set_error $form_name cognome_occ "inserire occupante: &egrave; il responsabile"
		    incr error_num
		} else {
		    set cod_responsabile $cod_occupante
		}
	    }
	    "A" {
		if {[string equal $cognome_amm  ""]
	        &&  [string equal $nome_amm     ""]
		} {
		    element::set_error $form_name cognome_amm "inserire amministratore: &egrave; il responsabile"
		    incr error_num
		} else {
		    set cod_responsabile $cod_amministratore
		}
	    }
	    "I" {
		if {[string equal $cognome_inte  ""]
	        &&  [string equal $nome_inte     ""]
		} {
		    element::set_error $form_name cognome_inte "inserire intestatario: &egrave; il responsabile"
		    incr error_num
		} else {
		    set cod_responsabile $cod_intestatario
		}
	    }
	    default {
		if {$flag_dichiarato == "S"} {
		    element::set_error $form_name flag_responsabile "Indicare responsabile"
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
   
        #non è possibile storicizzare modifiche con data_validità inferiore
        # a modifiche già storicizzate 
	
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
    set dml_sql_sogg ""

    if {$funzione == "M"
    ||  $funzione == "D"} {
        #leggo il record originale(prima delle modifiche)dalla tabella coimaimp
        if {![db_0or1row sel_aimp_db {}] == 0} {
            # per ogni campo del soggetto che è stato modificato rispetto al
            # record originale (tranne il caso in cui l'originale fosse = ""),
            # viene storicizzato il record pre-modifica.
            set indice 1

            while {$indice <= 5} {
		switch $indice {
		    1 {
			if {![string equal $db_cod_responsabile ""] 
		        &&  $db_cod_responsabile  != $cod_responsabile
			} {
			    set ruolo "R"
			    set db_cod_soggetto $db_cod_responsabile 
			    if {[db_0or1row  sel_sogg_check ""] ==0} {
				set dml_sql_sogg [db_map ins_sogg]
				set sw_query "S"
			    }
			}
		    }
		    2 {
			if {(![string equal $db_cod_intestatario ""]
			&& $db_cod_intestatario  != $cod_intestatario)
			} {
			    set ruolo "T"
			    set db_cod_soggetto $db_cod_intestatario
			    if {[db_0or1row  sel_sogg_check ""] ==0} {
				set dml_sql_sogg [db_map ins_sogg]
				set sw_query "S"
			    }
			}
		    }
		    
		    3 {
			if {(![string equal $db_cod_proprietario ""]
			&&   $db_cod_proprietario  != $cod_proprietario)
			} {
			    set ruolo "P"
			    set db_cod_soggetto $db_cod_proprietario
			    if {[db_0or1row  sel_sogg_check ""] ==0} {
				set dml_sql_sogg [db_map ins_sogg]
				set sw_query "S"
			    }
			}
		    }
		    4 {
			if {(![string equal $db_cod_occupante ""]
			&&   $db_cod_occupante != $cod_occupante)
			} {
			    set ruolo "O"
			    set db_cod_soggetto $db_cod_occupante
			    if {[db_0or1row  sel_sogg_check ""] ==0} {
				set dml_sql_sogg [db_map ins_sogg]
				set sw_query "S"
			    }
			}
		    }
		    5 {
			if {(![string equal $db_cod_amministratore ""]
			&&  $db_cod_amministratore != $cod_amministratore)
			} {
			    set ruolo "A"
			    set db_cod_soggetto $db_cod_amministratore
			    if {[db_0or1row  sel_sogg_check ""] ==0} {
				set dml_sql_sogg [db_map ins_sogg]
				set sw_query "S"
			    }
			}
		    }
		}
		
		# Lancio la query di manipolazione dati contenute in dml_sql
		if {[info exists dml_sql_sogg]} {
		    with_catch error_msg {
			db_transaction {
			    if {$sw_query == "S"} {
				db_dml dml_coimaimp $dml_sql_sogg
			    }
			}
		    } {
			iter_return_complaint "Spiacente, ma il DBMS ha restituito il seguente messaggio di errore <br><b>$error_msg</b><br> Contattare amministratore di sistema e comunicare il messaggio d'errore. Grazie."
		    }
		}
		set sw_query "N"
		set indice [expr $indice + 1] 
	    }
	}
    }

    switch $funzione {
        M {set dml_sql [db_map upd_aimp]}
        D {set dml_sql [db_map del_aimp]}
    }

  # Lancio la query di manipolazione dati contenute in dml_sql
    if {[info exists dml_sql]} {
        with_catch error_msg {
            db_transaction {
                db_dml dml_coimaimp $dml_sql
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
    set link_gest      [export_url_vars cod_impianto last_cod_impianto url_list_aimp url_aimp nome_funz nome_funz_caller extra_par caller]
    switch $funzione {
        M {set return_url   "coimaimp-sogg?funzione=V&$link_gest"}
        D {set return_url   "coimaimp-sogg?funzione=V&$link_gest"}
        I {set return_url   "coimaimp-sogg?funzione=V&$link_gest"}
        V {set return_url   "coimaimp-gest?&url_list_aimp&url_aimp"}
    }

    ad_returnredirect $return_url
    ad_script_abort
}

ad_return_template
