ad_page_contract {
    @author          Giulio Laurenzi
    @creation-date   18/03/2004

    @param funzione  V=view

    @param caller    caller della lista da restituire alla lista:
    @                serve se lista e' uno zoom che permetti aggiungi.

    @param nome_funz identifica l'entrata di menu, serve per le autorizzazioni
    @                serve se lista e' uno zoom che permetti aggiungi.

    @cvs-id          coimmaim-filter.tcl

    USER  DATA       MODIFICHE
    ===== ========== =======================================================================
    rom01 09/02/2018 Aggiunto nuovo parametro tipo_filtro.

    san01 22/03/2016 Impostata la combo dello stato con solo quello attivo (cod_imst = 'A').

} {
    
   {funzione            "V"}
   {caller          "index"}
   {nome_funz            ""}
   {nome_funz_caller     ""}
   {tipo_filtro          ""}

   {f_cod_impianto_est   ""}

   {f_resp_cogn          ""} 
   {f_resp_nome          ""} 

   {f_comune             ""}
   {f_quartiere          ""}

   {f_desc_via           ""}
   {f_desc_topo          ""}
   {f_cod_via            ""}

   {f_potenza_da         ""}
   {f_potenza_a          ""}
   {f_data_installaz_da  ""}
   {f_data_installaz_a   ""}
   {f_flag_dichiarato    ""}
   {f_stato_conformita   ""}
   {f_cod_combustibile   ""}
   {f_cod_tpim           ""}
   {f_cod_tpdu           ""}
   {f_stato_aimp         "A"}

   {f_mesi_scad          ""}
   {f_mesi_scad_manut    ""}

   {f_civico_da          ""}
   {f_civico_a           ""}

} -properties {
    page_title:onevalue
    context_bar:onevalue
    form_name:onevalue
}

# B80: RECUPERO LO USER - INTRUSIONE
set id_utente [ad_get_cookie iter_login_[ns_conn location]]
set id_utente_loggato_vero [ad_get_client_property iter logged_user_id]
set session_id [ad_conn session_id]
set adsession [ad_get_cookie "ad_session_id"]
set referrer [ns_set get [ad_conn headers] Referer]
set clientip [lindex [ns_set iget [ns_conn headers] x-forwarded-for] end]

# if {$referrer == ""} {
#	set login [ad_conn package_url]
#	ns_log Notice "********AUTH-CHECK-MAIM-KO-REFERER;ip-$clientip;$id_utente;$id_utente_loggato_vero;$session_id;$nome_funz;$adsession;"
#	iter_return_complaint "Accesso non consentito! Per accedere a questo programma devi prima eseguire la procedura di <a href=$login>Login.</a>"
#	return 0
#   } 
# if {$id_utente != $id_utente_loggato_vero} {
#	set login [ad_conn package_url]
#	ns_log Notice "********AUTH-CHECK-MAIM-KO-USER;ip-$clientip;$id_utente;$id_utente_loggato_vero;$session_id;$nome_funz;$adsession;"
#	iter_return_complaint "Accesso non consentito! Per accedere a questo programma devi prima eseguire la procedura di <a href=$login>Login.</a>"
#	return 0
#    } else {
#	ns_log Notice "********AUTH-CHECK-MAIM-OK;ip-$clientip;$id_utente;$id_utente_loggato_vero;$session_id;$nome_funz;$adsession;"
#    }
# ***

# Controlla lo user
set lvl 1
set id_utente [lindex [iter_check_login $lvl $nome_funz] 1]

# controllo il parametro di "propagazione" per la navigation bar
if {[string is space $nome_funz_caller]} {
    set nome_funz_caller $nome_funz
}

# controllo se l'utente è un manutentore
set cod_manutentore [iter_check_uten_manu $id_utente]

# Personalizzo la pagina
if {$tipo_filtro == "MAN"} {#rom01: aggiunto if, else e e loro contenuto
    set titolo       "Selezione Impianti con manutenzione in scadenza"
    set button_label "Seleziona" 
    set page_title   "Selezione Impianti con manutenzione in scadenza"
} else {
    set titolo       "Selezione Impianti con RCT in scadenza"
    set button_label "Seleziona"
    set page_title   "Selezione Impianti con RCT in scadenza"
};#rom01


iter_get_coimtgen
set flag_ente    $coimtgen(flag_ente)
set flag_viario  $coimtgen(flag_viario)
set cod_comune   $coimtgen(cod_comu)
set context_bar  [iter_context_bar -nome_funz $nome_funz_caller] 

# sproteggo la chiave solo in inserimento e gli attributi in inserimento e mod.
set form_name    "coimaimp"
set readonly_key "readonly"
set readonly_fld "readonly"
set disabled_fld "disabled"
set onsubmit_cmd ""

set readonly_fld \{\}
set disabled_fld \{\}
form create $form_name \
-html    $onsubmit_cmd

element create $form_name f_cod_impianto_est \
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
    element create $form_name f_comune \
    -label   "Comune" \
    -widget   select \
    -datatype text \
    -html    "$disabled_fld {} class form_element tabindex 4" \
    -optional \
    -options [iter_selbox_from_comu]
} else {
    element create $form_name f_comune -widget hidden -datatype text -optional
    element create $form_name f_quartiere \
    -label   "Quartiere" \
    -widget   select \
    -datatype text \
    -html    "$disabled_fld {} class form_element tabindex 4" \
    -optional \
    -options [iter_selbox_from_table coimcqua cod_qua descrizione]
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

if {$flag_viario == "T"} {
    set cerca_viae [iter_search $form_name [ad_conn package_url]/tabgen/coimviae-filter [list dummy f_cod_via dummy f_desc_via dummy f_desc_topo cod_comune f_comune dummy dummy dummy dummy]]
    regsub {<a href} $cerca_viae {<a tabindex=7 href} cerca_viae
} else {
    set cerca_viae ""
}

element create $form_name f_civico_da \
-label   "Civico da" \
-widget   text \
-datatype text \
-html    "size 4 maxlength 4 $readonly_fld {} class form_element tabindex 7" \
-optional

element create $form_name f_civico_a \
-label   "Civico a" \
-widget   text \
-datatype text \
-html    "size 4 maxlength 4 $readonly_fld {} class form_element tabindex 8" \
-optional

element create $form_name f_mesi_scad \
-label   "Mesi scadenza" \
-widget   text \
-datatype text \
-html    "size 1 maxlength 1 $readonly_fld {} class form_element tabindex 7" \
-optional

element create $form_name f_mesi_scad_manut \
-label   "Mesi scadenza" \
-widget   text \
-datatype text \
-html    "size 1 maxlength 1 $readonly_fld {} class form_element tabindex 7" \
-optional

element create $form_name f_potenza_da \
-label   "Potenza da" \
-widget   text \
-datatype text \
-html    "size 10 maxlength 10 $readonly_fld {} class form_element tabindex 10" \
-optional

element create $form_name f_potenza_a \
-label   "Potenza a" \
-widget   text \
-datatype text \
-html    "size 10 maxlength 10 $readonly_fld {} class form_element tabindex 11" \
-optional

element create $form_name f_data_installaz_da \
-label   "data installazione" \
-widget   text \
-datatype text \
-html    "size 10 maxlength 10 $readonly_fld {} class form_element tabindex 12" \
-optional

element create $form_name f_data_installaz_a \
-label   "data installazione" \
-widget   text \
-datatype text \
-html    "size 10 maxlength 10 $readonly_fld {} class form_element tabindex 13" \
-optional


element create $form_name f_flag_dichiarato \
-label   "Stato dichiarazione" \
-widget   select \
-datatype text \
-html    "$disabled_fld {} class form_element tabindex 14" \
-optional \
-options { {{} {}} {S&igrave; S} {No N} {N.C. C}}

element create $form_name f_stato_conformita \
-label   "Stato Conformita" \
-widget   select \
-datatype text \
-html    "$disabled_fld {} class form_element tabindex 15" \
-optional \
-options { {{} {}} {S&igrave; S} {No N}}

element create $form_name f_cod_combustibile \
-label   "combustibile" \
-widget   select \
-datatype text \
-html    "$disabled_fld {} class form_element tabindex 16" \
-optional \
-options [iter_selbox_from_table coimcomb cod_combustibile descr_comb cod_combustibile]

element create $form_name f_cod_tpim  \
-label   "Tipologia" \
-widget   select \
-datatype text \
-html    "$disabled_fld {} class form_element tabindex 17" \
-optional \
-options [iter_selbox_from_table coimtpim cod_tpim descr_tpim cod_tpim]

element create $form_name f_cod_tpdu \
-label   "destinazione uso" \
-widget   select \
-datatype text \
-html    "$disabled_fld {} class form_element tabindex 18" \
-optional \
-options [iter_selbox_from_table coimtpdu cod_tpdu descr_tpdu cod_tpdu]

element create $form_name f_stato_aimp \
-label   "stato dell'impianto" \
-widget   select \
-datatype text \
-html    "$disabled_fld {} class form_element tabindex 19" \
-optional \
-options [iter_selbox_from_table_wherec coimimst cod_imst descr_imst cod_imst "where cod_imst = 'A'"]

element create $form_name f_cod_via   -widget hidden -datatype text -optional
element create $form_name f_cod_manu  -widget hidden -datatype text -optional
element create $form_name funzione    -widget hidden -datatype text -optional
element create $form_name caller      -widget hidden -datatype text -optional
element create $form_name nome_funz   -widget hidden -datatype text -optional
element create $form_name dummy       -widget hidden -datatype text -optional
element create $form_name submit      -widget submit -datatype text -label "$button_label" -html "class form_submit tabindex 17"
element create $form_name tipo_filtro      -widget hidden -datatype text -optional;#rom01


if {[form is_request $form_name]} {
  # valorizzo i campi di mappa con i parametri ricevuti.
  # serve quando la lista ritorna al filtro.
    if {![string equal $cod_manutentore ""]} {
	element set_properties $form_name f_cod_manu    -value $cod_manutentore
    }
    element set_properties $form_name f_cod_impianto_est -value $f_cod_impianto_est
    element set_properties $form_name f_resp_cogn        -value $f_resp_cogn
    element set_properties $form_name f_resp_nome        -value $f_resp_nome

    if {$flag_ente == "P"} {
	element set_properties $form_name f_comune       -value $f_comune
    } else {
	element set_properties $form_name f_quartiere    -value $f_quartiere
	element set_properties $form_name f_comune       -value $cod_comune
    }

    element set_properties $form_name f_desc_topo        -value $f_desc_topo
    element set_properties $form_name f_desc_via         -value $f_desc_via
    element set_properties $form_name f_cod_via          -value $f_cod_via

    element set_properties $form_name f_potenza_da       -value $f_potenza_da
    element set_properties $form_name f_potenza_a        -value $f_potenza_a

    element set_properties $form_name f_data_installaz_da -value [iter_edit_date $f_data_installaz_da]
    element set_properties $form_name f_data_installaz_a  -value [iter_edit_date $f_data_installaz_a]
    element set_properties $form_name f_flag_dichiarato   -value $f_flag_dichiarato
    element set_properties $form_name f_stato_conformita  -value $f_stato_conformita
    element set_properties $form_name f_cod_combustibile -value $f_cod_combustibile
    element set_properties $form_name f_cod_tpim          -value $f_cod_tpim 

    element set_properties $form_name f_cod_tpdu          -value $f_cod_tpdu
    element set_properties $form_name funzione            -value $funzione
    element set_properties $form_name caller              -value $caller
    element set_properties $form_name nome_funz           -value $nome_funz
    element set_properties $form_name f_civico_da         -value $f_civico_da
    element set_properties $form_name f_civico_a          -value $f_civico_a
    element set_properties $form_name f_mesi_scad         -value $f_mesi_scad
    element set_properties $form_name f_mesi_scad_manut   -value $f_mesi_scad_manut
    element set_properties $form_name tipo_filtro         -value $tipo_filtro;#rom01

}

if {[form is_valid $form_name]} {
    # form valido dal punto di vista del templating system
    set f_cod_impianto_est [element::get_value $form_name f_cod_impianto_est]
    set f_resp_cogn        [element::get_value $form_name f_resp_cogn]
    set f_resp_nome        [element::get_value $form_name f_resp_nome]

    set f_comune           [element::get_value $form_name f_comune]
    if {$flag_ente != "P"} {
	set f_quartiere    [element::get_value $form_name f_quartiere]
    }
    set f_desc_topo        [element::get_value $form_name f_desc_topo]
    set f_desc_via         [element::get_value $form_name f_desc_via]  

    set f_potenza_da       [element::get_value $form_name f_potenza_da]
    set f_potenza_a        [element::get_value $form_name f_potenza_a]
    set f_data_installaz_da [element::get_value $form_name f_data_installaz_da]
    set f_data_installaz_a [element::get_value $form_name f_data_installaz_a]
    set f_flag_dichiarato  [element::get_value $form_name f_flag_dichiarato]
    set f_stato_conformita [element::get_value $form_name f_stato_conformita]
    set f_cod_combustibile [element::get_value $form_name f_cod_combustibile]
    set f_cod_tpim         [element::get_value $form_name f_cod_tpim]
    set f_cod_tpdu         [element::get_value $form_name f_cod_tpdu]
    set f_stato_aimp       [element::get_value $form_name f_stato_aimp]
    set f_cod_manu         [element::get_value $form_name f_cod_manu]
    set f_civico_da        [element::get_value $form_name f_civico_da]
    set f_civico_a         [element::get_value $form_name f_civico_a]
    set f_cod_via          [element::get_value $form_name f_cod_via]
    set tipo_filtro        [element::get_value $form_name tipo_filtro];#rom01

    set error_num 0

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
	&&  [string equal $f_quartiere ""]
        } {
            set sw_filtro_ind "f"
	}
    }

    if {[string equal $f_cod_impianto_est ""]
    &&  [string equal $f_resp_cogn        ""]
    &&  [string equal $f_resp_nome        ""]
    &&  [string equal $f_cod_manu         ""]
    &&  $sw_filtro_ind == "f"
    } {
        if {$flag_ente == "P"} {
            set errore_indirizzo "comune"
	} else {
	    set errore_indirizzo "indirizzo"
	}
	element::set_error $form_name f_cod_impianto_est "Indicare almeno codice impianto o responsabile o $errore_indirizzo"
	incr error_num
    }

    if {![string equal $f_cod_impianto_est ""]
    && (![string equal $f_resp_cogn        ""]
    ||  ![string equal $f_resp_nome        ""]
    ||  $sw_filtro_ind == "t"
    || ![string equal $f_potenza_da        ""]
    || ![string equal $f_potenza_a         ""]
    || ![string equal $f_data_installaz_da ""]
    || ![string equal $f_data_installaz_a  ""]
    || ![string equal $f_flag_dichiarato   ""]
    || ![string equal $f_stato_conformita  ""]
    || ![string equal $f_cod_combustibile  ""]
    || ![string equal $f_cod_tpim          ""]
    || ![string equal $f_cod_tpdu          ""])
    } {
	element::set_error $form_name f_cod_impianto_est "Con la selezione per codice non &egrave; possibile indicare nessun altro criterio di selezione"
	incr error_num
    } else {
	if {[string equal $f_resp_cogn ""]
        && ![string equal $f_resp_nome ""]
	} {
	    element::set_error $form_name f_resp_cogn "Indicare anche il cognome"
	    incr error_num
	}
    }

    if {![string equal $f_mesi_scad ""]} {
	set f_mesi_scad [iter_check_num $f_mesi_scad 0]
	if {$f_mesi_scad == "Error"} {
	    element::set_error $form_name f_mesi_scad "deve essere numerico"
	    incr error_num
	}
    }

    if {![string equal $f_mesi_scad_manut ""]} {
	set f_mesi_scad_manut [iter_check_num $f_mesi_scad_manut 0]
	if {$f_mesi_scad_manut == "Error"} {
	    element::set_error $form_name f_mesi_scad_manut "deve essere numerico"
	    incr error_num
	}
    }

    if {$error_num > 0} {
        set sw_controlla_via "f"
    } else {
        set sw_controlla_via "t"
    }
    
    set check_potenza_da "f"
    if {![string equal $f_potenza_da ""]} {
	set f_potenza_da [iter_check_num $f_potenza_da 0]
	if {$f_potenza_da == "Error"} {
	    element::set_error $form_name f_potenza_da "Potenza di Inizio deve essere un numero intero"
	    incr error_num
	} else {
            set check_potenza_da "t"
        }
    }

    set check_potenza_a  "f"
    if {![string equal $f_potenza_a ""]} {
	set f_potenza_a [iter_check_num $f_potenza_a 0]
	if {$f_potenza_a == "Error"} {
	    element::set_error $form_name f_potenza_a "Potenza di Fine deve essere un numero intero"
	    incr error_num
	} else {
            set check_potenza_a  "t"
	}
    }

    if {$check_potenza_a  == "t"
    &&  $check_potenza_da == "t"
    &&  $f_potenza_da > $f_potenza_a
    } {
	element::set_error $form_name f_potenza_da "Potenza di inizio deve essere minore di Potenza di fine"
	incr error_num
    }

    set check_dat_ins_da "f"
    if {![string equal $f_data_installaz_da ""]} {
	set f_data_installaz_da [iter_check_date $f_data_installaz_da]
	if {$f_data_installaz_da == 0} {
	    element::set_error $form_name f_data_installaz_da "Inserire correttamente la data" 
	    incr error_num
	} else {
	    set check_dat_ins_da "t"
	}
    }

    set check_dat_ins_a "f"
    if {![string equal $f_data_installaz_a ""]} {
	set f_data_installaz_a [iter_check_date $f_data_installaz_a]
	if {$f_data_installaz_a == 0} {
	    element::set_error $form_name f_data_installaz_a "Inserire correttamente la data"
	    incr error_num
	} else {
	    set check_dat_ins_a "t"
	}
    }

    if {$check_dat_ins_a  == "t"
    &&  $check_dat_ins_da == "t"
    &&  $f_data_installaz_da > $f_data_installaz_a
    } {
	element::set_error $form_name f_data_installaz_da "Data Inizio deve essere minore di Data Fine"
	incr error_num
    }
    
  # si controlla la via solo se il primo test e' andato bene.
  # in questo modo si e' sicuri che f_comune e' stato valorizzato.
    if {$sw_controlla_via == "t"
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
         &&  [string equal $f_desc_via ""]
         &&  [string equal $f_cod_via ""])
    &&  (   ![string equal $f_civico_da ""]
         || ![string equal $f_civico_a ""])
    } {
	 element::set_error $form_name f_comune "La selezione per numero civico viene effettuato solo insieme alla selezione per via"
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

    if {$error_num > 0} {
        ad_return_template
        return
    }
    set link_list [export_url_vars f_civico_da f_civico_a f_cod_impianto_est f_resp_cogn f_resp_nome  f_comune f_quartiere f_cod_via f_desc_via f_desc_topo f_cod_manu f_potenza_da f_potenza_a f_data_installaz_da f_data_installaz_a f_flag_dichiarato f_stato_conformita f_cod_combustibile f_cod_tpim  f_cod_tpdu f_stato_aimp f_mesi_scad f_mesi_scad_manut caller funzione nome_funz_caller tipo_filtro]&nome_funz=[iter_get_nomefunz coimmaim-list]

    set return_url "coimmaim-list?$link_list"    
    
    ad_returnredirect $return_url
    ad_script_abort
}
 
ad_return_template
