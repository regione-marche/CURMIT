ad_page_contract {
    Add/Edit/Delete  form per la tabella "coimnove"
    @author          Valentina Catte
    @creation-date   02/04/2004

    @param funzione  I=insert M=edit D=delete V=view
    @param caller    caller della lista da restituire alla lista:
                     serve se lista e' uno zoom che permetti aggiungi.
    @param nome_funz identifica l'entrata di menu, server per le autorizzazioni
                     serve se lista e' uno zoom che permetti aggiungi.
    @param nome_funz_caller identifica l'entrata di menu, serve per la 
                     navigazione con navigation bar
    @param extra_par Variabili extra da restituire alla lista
    @cvs-id          coimnove-gest.tcl
} {
    
   {cod_impianto     ""}
   {cod_nove         ""}
   {funzione        "V"}
   {caller      "index"}
   {nome_funz        ""}
   {nome_funz_caller ""}
   {extra_par        ""}
   {url_list_aimp    ""}
   {url_aimp    ""}
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
set link_gest [export_url_vars cod_impianto cod_nove nome_funz nome_funz_caller url_list_aimp url_aimp extra_par caller]
# imposta le class css della barra delle funzioni
iter_set_func_class $funzione

# controllo il parametro di "propagazione" per la navigation bar
if {[string is space $nome_funz_caller]} {
    set nome_funz_caller $nome_funz
}

#proc per la navigazione 
set link_tab [iter_links_form $cod_impianto $nome_funz_caller $url_list_aimp $url_aimp]
set dett_tab [iter_tab_form $cod_impianto]

# Personalizzo la pagina
set link_list_script {[export_url_vars cod_impianto cod_nove caller nome_funz_caller nome_funz url_list_aimp url_aimp]&[iter_set_url_vars $extra_par]}
set link_list        [subst $link_list_script]

set current_date      [iter_set_sysdate]

iter_get_coimtgen
set flag_viario $coimtgen(flag_viario)

db_1row sel_data_inst ""

set titolo              "Allegato IX"
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
set form_name    "coimnove"
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

element create $form_name cognome_manu \
-label   "Cognome manutentore" \
-widget   text \
-datatype text \
-html    "size 40 maxlength 40 $readonly_fld {} class form_element" \
-optional

element create $form_name nome_manu \
-label   "Nome manutentore" \
-widget   text \
-datatype text \
-html    "size 20 maxlength 40 $readonly_fld {} class form_element" \
-optional

if {$funzione == "I"
    ||  $funzione == "M"
} {
    set cerca_manu [iter_search $form_name coimmanu-list [list dummy cod_manutentore dummy cognome_manu dummy nome_manu] ]
    set cerca_citt [iter_search $form_name coimcitt-filter [list dummy cod_manutentore f_cognome cognome_manu  f_nome nome_manu ]]

} else {
    set cerca_manu ""
    set cerca_citt ""
}

element create $form_name data_consegna \
-label   "data_consegna" \
-widget   text \
-datatype text \
-html    "size 10 maxlength 10 $readonly_fld {} class form_element" \
-optional

element create $form_name luogo_consegna \
-label   "luogo_consegna" \
-widget   text \
-datatype text \
-html    "size 40 maxlength 100 $readonly_fld {} class form_element" \
-optional

element create $form_name flag_art_109 \
-label   "check" \
-widget   checkbox \
-datatype text \
-html "$disabled_fld {} class form_element" \
-optional \
-options  {{Si t}}

element create $form_name flag_art_11 \
-label   "check" \
-widget   checkbox \
-datatype text \
-html "$disabled_fld {} class form_element" \
-optional \
-options  {{Si t}}

element create $form_name flag_installatore \
-label   "check" \
-widget   checkbox \
-datatype text \
-html "$disabled_fld {} class form_element" \
-optional \
-options  {{Si t}}

element create $form_name flag_manutentore \
-label   "check" \
-widget   checkbox \
-datatype text \
-html "$disabled_fld {} class form_element" \
-optional \
-options  {{Si t}}

element create $form_name pot_termica_mw \
-label   "potenza" \
-widget   text \
-datatype text \
-html    "size 8 maxlength 12 $readonly_fld {} class form_element" \
-optional

element create $form_name combustibili \
-label   "combustibili" \
-widget   textarea \
-datatype text \
-html    "cols 50 rows 1  $readonly_fld {} class form_element" \
-optional

element create $form_name n_focolari \
-label   "n_focolari" \
-widget   text \
-datatype text \
-html    "size 2 maxlength 2 $readonly_fld {} class form_element" \
-optional

element create $form_name pot_focolari_mw \
-label   "pot_focolari_mw" \
-widget   textarea \
-datatype text \
-html    "cols 50 rows 1  $readonly_fld {} class form_element" \
-optional

element create $form_name n_bruciatori  \
-label   "n_bruciatori " \
-widget   text \
-datatype text \
-html    "size 2 maxlength 2 $readonly_fld {} class form_element" \
-optional

element create $form_name pot_tipi_bruc \
-label   "pot_tipi_bruc" \
-widget   textarea \
-datatype text \
-html    "cols 50 rows 1  $readonly_fld {} class form_element" \
-optional

element create $form_name apparecchi_acc \
-label   "apparecchi_acc" \
-widget   textarea \
-datatype text \
-html    "cols 50 rows 1  $readonly_fld {} class form_element" \
-optional

element create $form_name n_canali_fumo \
-label   "n_canali_fumo" \
-widget   text \
-datatype text \
-html    "size 2 maxlength 2 $readonly_fld {} class form_element" \
-optional

element create $form_name sez_min_canali \
-label   "sez_min_canali" \
-widget   text \
-datatype text \
-html    "size 8 maxlength 12 $readonly_fld {} class form_element" \
-optional

element create $form_name svil_totale \
-label   "svil_totale" \
-widget   text \
-datatype text \
-html    "size 8 maxlength 12 $readonly_fld {} class form_element" \
-optional

element create $form_name aperture_ispez \
-label   "aperture_ispez" \
-widget   textarea \
-datatype text \
-html    "cols 50 rows 1  $readonly_fld {} class form_element" \
-optional

element create $form_name n_camini \
-label   "n_camini" \
-widget   text \
-datatype text \
-html    "size 2 maxlength 2 $readonly_fld {} class form_element" \
-optional

element create $form_name sez_min_camini \
-label   "sez_min_camini" \
-widget   text \
-datatype text \
-html    "size 8 maxlength 12 $readonly_fld {} class form_element" \
-optional

element create $form_name altezze_bocche \
-label   "altezze_bocche" \
-widget   textarea \
-datatype text \
-html    "cols 50 rows 1  $readonly_fld {} class form_element" \
-optional

element create $form_name durata_impianto \
-label   "durata_impianto" \
-widget   textarea \
-datatype text \
-html    "cols 50 rows 1  $readonly_fld {} class form_element" \
-optional

element create $form_name manut_ordinarie \
-label   "manut_ordinarie" \
-widget   textarea \
-datatype text \
-html    "cols 50 rows 5  $readonly_fld {} class form_element" \
-optional

element create $form_name manut_straord \
-label   "manut_straord" \
-widget   textarea \
-datatype text \
-html    "cols 50 rows 5  $readonly_fld {} class form_element" \
-optional

element create $form_name varie \
-label   "varie" \
-widget   textarea \
-datatype text \
-html    "cols 50 rows 3  $readonly_fld {} class form_element" \
-optional

element create $form_name flag_consegnato \
-label   "flag_consegnato" \
-widget   select \
-datatype text \
-html    "size 1 maxlength 1 $disabled_fld {} class form_element" \
-optional \
-options {{{} {}} {S&igrave; S} {No N}}

element create $form_name firma \
-label   "firma" \
-widget   text \
-datatype text \
-html    "size 40 maxlength 100 $readonly_fld {} class form_element" \
-optional

element create $form_name data_rilascio \
-label   "data_rilascio" \
-widget   text \
-datatype text \
-html    "size 10 maxlength 10 $readonly_fld {} class form_element" \
-optional

element create $form_name cod_nove \
-label   "cod_nove" \
-widget   text \
-datatype text \
-html    "size 8 maxlength 8 $readonly_key {} class form_element" \
-optional

element create $form_name cod_impianto     -widget hidden -datatype text -optional
element create $form_name cod_manutentore  -widget hidden -datatype text -optional
element create $form_name funzione         -widget hidden -datatype text -optional
element create $form_name caller           -widget hidden -datatype text -optional
element create $form_name nome_funz        -widget hidden -datatype text -optional
element create $form_name nome_funz_caller -widget hidden -datatype text -optional
element create $form_name extra_par        -widget hidden -datatype text -optional
element create $form_name url_list_aimp    -widget hidden -datatype text -optional
element create $form_name url_aimp         -widget hidden -datatype text -optional
element create $form_name submit           -widget submit -datatype text -label "$button_label" -html "class form_submit"

if {[form is_request $form_name]} {

    element set_properties $form_name funzione         -value $funzione
    element set_properties $form_name caller           -value $caller
    element set_properties $form_name nome_funz        -value $nome_funz
    element set_properties $form_name nome_funz_caller -value $nome_funz_caller
    element set_properties $form_name extra_par        -value $extra_par
    element set_properties $form_name url_list_aimp    -value $url_list_aimp
    element set_properties $form_name url_aimp         -value $url_aimp
    element set_properties $form_name cod_impianto     -value $cod_impianto

    if {$funzione == "I"} {

	db_1row sel_next_nove ""
	element set_properties $form_name cod_nove          -value $cod_nove
        element set_properties $form_name flag_consegnato   -value "S"
	if {[db_0or1row sel_manu ""] > 0} {
	    element set_properties $form_name cognome_manu     -value $cognome_manu
	    element set_properties $form_name nome_manu        -value $nome_manu
	    element set_properties $form_name cod_manutentore  -value $cod_manutentore
	}        

    } else {
      # leggo riga

        if {[db_0or1row sel_nove {}] == 0} {
            iter_return_complaint "Record non trovato"
	}

	if {![string equal $cod_manutentore ""]} {
	    if {[string range $cod_manutentore 0 1] == "MA"} {
		db_0or1row sel_dati_manu ""
	    } else {
		db_0or1row sel_dati_citt ""
	    }
	} else {
	    set cognome_manu ""
	    set nome_manu ""
	}

	element set_properties $form_name cognome_manu     -value $cognome_manu
	element set_properties $form_name nome_manu        -value $nome_manu
	element set_properties $form_name cod_manutentore  -value $cod_manutentore

	element set_properties $form_name cod_nove          -value $cod_nove
        element set_properties $form_name data_consegna     -value $data_consegna
        element set_properties $form_name luogo_consegna    -value $luogo_consegna
        element set_properties $form_name flag_art_109      -value $flag_art_109
        element set_properties $form_name flag_art_11       -value $flag_art_11
        element set_properties $form_name flag_installatore -value $flag_installatore
        element set_properties $form_name flag_manutentore  -value $flag_manutentore
        element set_properties $form_name pot_termica_mw    -value $pot_termica_mw
        element set_properties $form_name combustibili      -value $combustibili
        element set_properties $form_name n_focolari        -value $n_focolari
        element set_properties $form_name pot_focolari_mw   -value $pot_focolari_mw
        element set_properties $form_name n_bruciatori      -value $n_bruciatori
        element set_properties $form_name pot_tipi_bruc     -value $pot_tipi_bruc
        element set_properties $form_name apparecchi_acc    -value $apparecchi_acc
        element set_properties $form_name n_canali_fumo     -value $n_canali_fumo
        element set_properties $form_name sez_min_canali    -value $sez_min_canali
        element set_properties $form_name svil_totale       -value $svil_totale
        element set_properties $form_name aperture_ispez    -value $aperture_ispez
        element set_properties $form_name n_camini          -value $n_camini
        element set_properties $form_name sez_min_camini    -value $sez_min_camini
        element set_properties $form_name altezze_bocche    -value $altezze_bocche
        element set_properties $form_name durata_impianto   -value $durata_impianto
        element set_properties $form_name manut_ordinarie   -value $manut_ordinarie
        element set_properties $form_name manut_straord     -value $manut_straord
        element set_properties $form_name varie             -value $varie
        element set_properties $form_name flag_consegnato   -value $flag_consegnato
        element set_properties $form_name firma             -value $firma
        element set_properties $form_name data_rilascio     -value $data_rilascio

	if {![string equal $pot_termica_mw ""]} {
	    set pot_no_edit [iter_check_num $pot_termica_mw 4]
	    set pot_termica_kw [expr $pot_no_edit * 1000]
	    set pot_termica_kw [iter_edit_num $pot_termica_kw 2]
	} else {
	    set pot_termica_kw ""
	}
    }
}

if {[form is_valid $form_name]} {
  # form valido dal punto di vista del templating system

    set cod_impianto         [element::get_value $form_name cod_impianto]
    set cod_nove             [element::get_value $form_name cod_nove]
    set cod_manutentore      [element::get_value $form_name cod_manutentore]
    set cognome_manu         [element::get_value $form_name cognome_manu]
    set nome_manu            [element::get_value $form_name nome_manu]
    set data_consegna        [element::get_value $form_name data_consegna]
    set luogo_consegna       [element::get_value $form_name luogo_consegna]
    set flag_art_109         [element::get_value $form_name flag_art_109]
    set flag_art_11          [element::get_value $form_name flag_art_11]
    set flag_installatore    [element::get_value $form_name flag_installatore]
    set flag_manutentore     [element::get_value $form_name flag_manutentore]
    set pot_termica_mw       [element::get_value $form_name pot_termica_mw]
    set combustibili         [element::get_value $form_name combustibili]
    set n_focolari           [element::get_value $form_name n_focolari]
    set pot_focolari_mw      [element::get_value $form_name pot_focolari_mw]
    set n_bruciatori         [element::get_value $form_name n_bruciatori]
    set pot_tipi_bruc        [element::get_value $form_name pot_tipi_bruc]
    set apparecchi_acc       [element::get_value $form_name apparecchi_acc]
    set n_canali_fumo        [element::get_value $form_name n_canali_fumo]
    set sez_min_canali       [element::get_value $form_name sez_min_canali]
    set svil_totale          [element::get_value $form_name svil_totale]
    set aperture_ispez       [element::get_value $form_name aperture_ispez]
    set n_camini             [element::get_value $form_name n_camini]
    set sez_min_camini       [element::get_value $form_name sez_min_camini]
    set altezze_bocche       [element::get_value $form_name altezze_bocche]
    set durata_impianto      [element::get_value $form_name durata_impianto]
    set manut_ordinarie      [element::get_value $form_name manut_ordinarie]
    set manut_straord        [element::get_value $form_name manut_straord]
    set varie                [element::get_value $form_name varie]
    set flag_consegnato      [element::get_value $form_name flag_consegnato]
    set firma                [element::get_value $form_name firma]
    set data_rilascio        [element::get_value $form_name data_rilascio]

  # controlli standard su numeri e date, per Ins ed Upd
    set error_num 0
    if {$funzione == "I"
    ||  $funzione == "M"
    } {
        if {![string equal $data_consegna ""]} {
            set data_consegna [iter_check_date $data_consegna]
            if {$data_consegna == 0} {
                element::set_error $form_name data_consegna "Data consegna deve essere una data"
                incr error_num
            } else {
		if {$data_consegna > $current_date} {
		    element::set_error $form_name data_consegna  "Data deve essere anteriore alla data odierna"
		    incr error_num
		}
	    }
        }

        if {![string equal $data_rilascio ""]} {
            set data_rilascio [iter_check_date $data_rilascio]
            if {$data_rilascio == 0} {
                element::set_error $form_name data_rilascio "Data rilascio deve essere una data"
                incr error_num
            } else {
		if {$data_rilascio > $current_date} {
		    element::set_error $form_name data_rilascio  "Data deve essere anteriore alla data odierna"
		    incr error_num
		}
	    }
        }

        if {![string equal $pot_termica_mw ""]} {
            set pot_termica_mw [iter_check_num $pot_termica_mw 4]
            if {$pot_termica_mw == "Error"} {
                element::set_error $form_name pot_termica_mw "Deve essere numerico, max 4 dec"
                incr error_num
            } else {
                if {[iter_set_double $pot_termica_mw] >=  [expr pow(10,4)]
                ||  [iter_set_double $pot_termica_mw] <= -[expr pow(10,4)]} {
                    element::set_error $form_name pot_termica_mw "Deve essere inferiore di 10.000"
                    incr error_num
                }
            }
        } else {
	    if {$flag_consegnato != "S"} {
                element::set_error $form_name pot_termica_mw "Inserire"
                incr error_num
	    }
	}

        if {![string equal $sez_min_canali ""]} {
            set sez_min_canali [iter_check_num $sez_min_canali 2]
            if {$sez_min_canali == "Error"} {
                element::set_error $form_name sez_min_canali "Deve essere numerico, max 2 dec"
                incr error_num
            } else {
                if {[iter_set_double $sez_min_canali] >=  [expr pow(10,4)]
                ||  [iter_set_double $sez_min_canali] <= -[expr pow(10,4)]} {
                    element::set_error $form_name sez_min_canali "Deve essere inferiore di 10.000"
                    incr error_num
                }
            }
        }

        if {![string equal $svil_totale ""]} {
            set svil_totale [iter_check_num $svil_totale 2]
            if {$svil_totale == "Error"} {
                element::set_error $form_name svil_totale "Deve essere numerico, max 2 dec"
                incr error_num
            } else {
                if {[iter_set_double $svil_totale] >=  [expr pow(10,4)]
                ||  [iter_set_double $svil_totale] <= -[expr pow(10,4)]} {
                    element::set_error $form_name svil_totale "Deve essere inferiore di 10.000"
                    incr error_num
                }
            }
        }

        if {![string equal $sez_min_camini ""]} {
            set sez_min_camini [iter_check_num $sez_min_camini 2]
            if {$sez_min_camini == "Error"} {
                element::set_error $form_name sez_min_camini "Deve essere numerico, max 2 dec"
                incr error_num
            } else {
                if {[iter_set_double $sez_min_camini] >=  [expr pow(10,4)]
                ||  [iter_set_double $sez_min_camini] <= -[expr pow(10,4)]} {
                    element::set_error $form_name sez_min_camini "Deve essere inferiore di 10.000"
                    incr error_num
                }
            }
        }

        if {![string equal $n_focolari ""]} {
            set n_focolari [iter_check_num $n_focolari 0]
            if {$n_focolari == "Error"} {
                element::set_error $form_name n_focolari "deve essere numerico"
                incr error_num
	    }
	}

        if {![string equal $n_bruciatori ""]} {
            set n_bruciatori [iter_check_num $n_bruciatori 0]
            if {$n_bruciatori == "Error"} {
                element::set_error $form_name n_bruciatori "deve essere numerico"
                incr error_num
	    }
	}

        if {![string equal $n_canali_fumo ""]} {
            set n_canali_fumo [iter_check_num $n_canali_fumo 0]
            if {$n_canali_fumo == "Error"} {
                element::set_error $form_name n_canali_fumo "deve essere numerico"
                incr error_num
	    }
	}

        if {![string equal $n_camini ""]} {
            set n_camini [iter_check_num $n_camini 0]
            if {$n_camini == "Error"} {
                element::set_error $form_name n_camini "deve essere numerico"
                incr error_num
	    }
	}

        if {[string equal $cod_nove ""]} {
	    element::set_error $form_name cod_nove "Inserire"
	    incr error_num
	} else {
	    if {$funzione == "I"} {
		if {[db_0or1row sel_cod_check ""] == 1} {
		    element::set_error $form_name cod_nove "Codice gi&agrave; esistente"
		    incr error_num
		}
	    }
	}

	#routine generica per controllo codice manutentore
	set check_cod_manu {
	    set chk_out_rc       0
	    set chk_out_msg      ""
	    set chk_out_cod_manu ""
	    set ctr_manu         0
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
	    db_foreach sel_manu_cont "" {
		incr ctr_manu
		if {$cod_manu_db == $chk_inp_cod_manu} {
		    set chk_out_cod_manu $cod_manu_db
		    set chk_out_rc       1
		}
	    }
	    switch $ctr_manu {
		0 { set chk_out_msg "Soggetto non trovato"}
		1 { set chk_out_cod_manu $cod_manu_db
		    set chk_out_rc       1 }
		default {
		    if {$chk_out_rc == 0} {
			set chk_out_msg "Trovati pi&ugrave; soggetti: usa il link cerca"
		    }
		}
	    }
	}

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
                if {$cod_manutentore == $chk_inp_cod_citt} {
		    set chk_out_cod_citt $cod_manutentore
                    set chk_out_rc       1
		}
	    }
            switch $ctr_citt {
 		0 { set chk_out_msg "Soggetto non trovato"}
	 	1 { set chk_out_cod_citt $cod_manutentore
		    set chk_out_rc       1 }
	  default {
                    if {$chk_out_rc == 0} {
			set chk_out_msg "Trovati pi&ugrave; soggetti: usa il link cerca"
		    }
 		}
	    }
 	}

        if {[string equal $cognome_manu ""]
	&&  [string equal $nome_manu    ""]
	} {
	    if {$flag_consegnato != "S"} {
		element::set_error $form_name cognome_manu "Inserire manutentore"
		incr error_num
	    } else {
		set cod_manutentore ""
	    }
	} else {
	    if {[string range $cod_manutentore 0 1] == "MA"} {
		set chk_inp_cod_manu $cod_manutentore
		set chk_inp_cognome  $cognome_manu
		set chk_inp_nome     $nome_manu
		eval $check_cod_manu
		set cod_manutentore  $chk_out_cod_manu
		if {$chk_out_rc == 0} {
		    element::set_error $form_name cognome_manu $chk_out_msg
		    incr error_num
		}
	    } else {
		set chk_inp_cod_citt $cod_manutentore
		set chk_inp_cognome  $cognome_manu
		set chk_inp_nome     $nome_manu
		eval $check_cod_citt
		set cod_manutentore  $chk_out_cod_citt
		if {$chk_out_rc == 0} {
		    element::set_error $form_name cognome_manu $chk_out_msg
		    incr error_num
		}
	    }
	}
    }

    if {$error_num > 0} {
        ad_return_template
        return
    }


  # Lancio la query di manipolazione dati contenuta in dml_sql
    with_catch error_msg {
	db_transaction {
	    switch $funzione {
		I {db_dml ins_nove ""}
		M {db_dml upd_nove ""}
		D {db_dml del_nove ""}
	    }
	}
    } {
	iter_return_complaint "Spiacente, ma il DBMS ha restituito il
        seguente messaggio di errore <br><b>$error_msg</b><br>
        Contattare amministratore di sistema e comunicare il messaggio
        d'errore. Grazie."
    }

    set link_list      [subst $link_list_script]
    set link_gest      [export_url_vars cod_impianto cod_nove nome_funz nome_funz_caller url_list_aimp url_aimp extra_par caller]
    switch $funzione {
        M {set return_url   "coimnove-gest?funzione=V&$link_gest"}
        D {set return_url   "coimdimp-list?$link_list"}
        I {set return_url   "coimnove-gest?funzione=V&$link_gest"}
        V {set return_url   "coimdimp-list?$link_list"}
    }

    ad_returnredirect $return_url
    ad_script_abort
}

ad_return_template
