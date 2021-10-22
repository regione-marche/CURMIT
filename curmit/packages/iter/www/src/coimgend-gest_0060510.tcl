ad_page_contract {
    Add/Edit/Delete  form per la tabella "coimgend"
    @author          Katia Coazzoli Adhoc
    @creation-date   02/04/2004

    @param funzione  I=insert M=edit D=delete V=view
    @param caller    caller della lista da restituire alla lista:
                     serve se lista e' uno zoom che permetti aggiungi.
    @param nome_funz identifica l'entrata di menu, server per le autorizzazioni
                     serve se lista e' uno zoom che permetti aggiungi.
    @param nome_funz_caller identifica l'entrata di menu, serve per la 
                     navigazione con navigation bar
    @param extra_par Variabili extra da restituire alla lista
    @cvs-id          coimgend-gest.tcl
} {
    
   {cod_impianto     ""}
   {gen_prog         ""}
   {last_gen_prog    ""}
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
set link_gest [export_url_vars cod_impianto gen_prog last_gen_prog nome_funz nome_funz_caller url_list_aimp url_aimp extra_par caller]
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
set link_list_script {[export_url_vars cod_impianto last_gen_prog caller nome_funz_caller nome_funz url_list_aimp url_aimp]&[iter_set_url_vars $extra_par]}
set link_list        [subst $link_list_script]

set current_date      [iter_set_sysdate]

set titolo              "Generatore"
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
set form_name    "coimgend"
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

element create $form_name gen_prog_est \
-label   "numero" \
-widget   text \
-datatype text \
-html    "size 8 maxlength 8 $readonly_fld {} class form_element" \
-optional

element create $form_name descrizione \
-label   "descrizione" \
-widget   text \
-datatype text \
-html    "size 56 maxlength 100 $readonly_fld {} class form_element" \
-optional

element create $form_name matricola \
-label   "matricola" \
-widget   text \
-datatype text \
-html    "size 20 maxlength 35 $readonly_fld {} class form_element" \
-optional

element create $form_name modello \
-label   "modello" \
-widget   text \
-datatype text \
-html    "size 18 maxlength 40 $readonly_fld {} class form_element" \
-optional

element create $form_name cod_cost \
-label   "costruttore" \
-widget   select \
-datatype text \
-html    "$disabled_fld {} class form_element" \
-optional \
-options [iter_selbox_from_table coimcost cod_cost descr_cost] 

element create $form_name tipo_foco \
-label   "tipo focolare" \
-widget   select \
-datatype text \
-html    "$disabled_fld {} class form_element" \
-optional \
-options {{{} {}} {Aperto A} {Chiuso C}}

element create $form_name mod_funz \
-label   "funzionamento" \
-widget   select \
-datatype text \
-html    "$disabled_fld {} class form_element" \
-optional \
-options [iter_selbox_from_table coimfuge cod_fuge descr_fuge cod_fuge] 

element create $form_name cod_utgi \
-label   "cod_utgi" \
-widget   select \
-datatype text \
-html    "$disabled_fld {} class form_element" \
-optional \
-options [iter_selbox_from_table_obblig coimutgi cod_utgi descr_utgi cod_utgi] 

element create $form_name tipo_bruciatore \
-label   "tipo bruciatore" \
-widget   select \
-datatype text \
-html    "$disabled_fld {} class form_element" \
-optional \
-options {{{} {}} {Atmosferico A} {Pressurizzato P} {Premiscelato M}}

element create $form_name tiraggio \
-label   "tipo tiraggio" \
-widget   select \
-datatype text \
-html    "$disabled_fld {} class form_element" \
-optional \
-options {{{} {}} {Forzato F} {Naturale N}}

element create $form_name matricola_bruc\
-label   "matricola_bruc" \
-widget   text \
-datatype text \
-html    "size 20 maxlength 35 $readonly_fld {} class form_element" \
-optional

element create $form_name modello_bruc\
-label   "modello_bruc" \
-widget   text \
-datatype text \
-html    "size 18 maxlength 40 $readonly_fld {} class form_element" \
-optional

element create $form_name cod_cost_bruc \
-label   "costruttore_bruc" \
-widget   select \
-datatype text \
-html    "$disabled_fld {} class form_element" \
-optional \
-options [iter_selbox_from_table coimcost cod_cost descr_cost] \

element create $form_name locale \
-label   "tipo locale" \
-widget   select \
-datatype text \
-html    "$disabled_fld {} class form_element" \
-optional \
-options {{{} {}} {Tecnico T} {Esterno E} {Interno I}}

element create $form_name cod_emissione \
-label   "cod_emissione combust." \
-widget   select \
-datatype text \
-html    "$disabled_fld {} class form_element" \
-optional \
-options [iter_selbox_from_table_obblig coimtpem cod_emissione descr_emissione cod_emissione] 

element create $form_name cod_combustibile \
-label   "combustibile" \
-widget   select \
-datatype text \
-html    "$disabled_fld {} class form_element" \
-optional \
-options [iter_selbox_from_table coimcomb cod_combustibile descr_comb] \

element create $form_name data_installaz \
-label   "data installaz" \
-widget   text \
-datatype text \
-html    "size 10 maxlength 10 $readonly_fld {} class form_element" \
-optional

element create $form_name data_rottamaz \
-label   "data rottamaz" \
-widget   text \
-datatype text \
-html    "size 10 maxlength 10 $readonly_fld {} class form_element" \
-optional

element create $form_name pot_focolare_lib \
-label   "potenza focolare libretto" \
-widget   text \
-datatype text \
-html    "size 8 maxlength 8 $readonly_fld {} class form_element" \
-optional

element create $form_name pot_utile_lib \
-label   "potenza utile libretto" \
-widget   text \
-datatype text \
-html    "size 8 maxlength 8 $readonly_fld {} class form_element" \
-optional

element create $form_name pot_focolare_nom \
-label   "potenza focolare nomin" \
-widget   text \
-datatype text \
-html    "size 8 maxlength 8 $readonly_fld {} class form_element" \
-optional

element create $form_name pot_utile_nom \
-label   "potenza utile nomin" \
-widget   text \
-datatype text \
-html    "size 8 maxlength 8 $readonly_fld {} class form_element" \
-optional

element create $form_name flag_attivo \
-label   "flag attivo" \
-widget   select \
-datatype text \
-html    "$disabled_fld {} class form_element" \
-optional \
-options {{Si S} {No N}}

element create $form_name note \
-label   "note" \
-widget   textarea \
-datatype text \
-html    "cols 90 rows 2 $readonly_fld {} class form_element" \
-optional

element create $form_name data_costruz_gen \
-label   "data costruzione generatore" \
-widget   text \
-datatype text \
-html    "size 10 maxlength 10 $readonly_fld {} class form_element" \
-optional

element create $form_name data_costruz_bruc \
-label   "data costruzione bruciatore" \
-widget   text \
-datatype text \
-html    "size 10 maxlength 10 $readonly_fld {} class form_element" \
-optional

element create $form_name data_installaz_bruc \
-label   "data installaz bruciatore" \
-widget   text \
-datatype text \
-html    "size 10 maxlength 10 $readonly_fld {} class form_element" \
-optional

element create $form_name data_rottamaz_bruc \
-label   "data rottamazione bruciatore" \
-widget   text \
-datatype text \
-html    "size 10 maxlength 10 $readonly_fld {} class form_element" \
-optional

element create $form_name marc_effic_energ \
-label   "marcatura efficenza energetica" \
-widget   text \
-datatype text \
-html    "size 4 maxlength 4 $readonly_fld {} class form_element" \
-optional

element create $form_name campo_funzion_max \
-label   "Campo di funzionamento" \
-widget   text \
-datatype text \
-html    "size 10 maxlength 10 $readonly_fld {} class form_element" \
-optional

element create $form_name campo_funzion_min \
-label   "Campo di funzionamento" \
-widget   text \
-datatype text \
-html    "size 10 maxlength 10 $readonly_fld {} class form_element" \
-optional

element create $form_name dpr_660_96 \
-label   "Classificazione DPR 660/96" \
-widget   select \
-datatype text \
-html    "$disabled_fld {} class form_element" \
-optional \
-options {{{} {}} {Standard S} {{A bassa temperatura} B} {{A gas a condensazione} G}}


element create $form_name funzione      -widget hidden -datatype text -optional
element create $form_name caller        -widget hidden -datatype text -optional
element create $form_name nome_funz     -widget hidden -datatype text -optional
element create $form_name nome_funz_caller -widget hidden -datatype text -optional
element create $form_name extra_par     -widget hidden -datatype text -optional
element create $form_name cod_impianto  -widget hidden -datatype text -optional
element create $form_name gen_prog      -widget hidden -datatype text -optional
element create $form_name url_list_aimp -widget hidden -datatype text -optional
element create $form_name url_aimp      -widget hidden -datatype text -optional
element create $form_name submit        -widget submit -datatype text -label "$button_label" -html "class form_submit"
element create $form_name last_gen_prog -widget hidden -datatype text -optional

if {[form is_request $form_name]} {

    element set_properties $form_name funzione      -value $funzione
    element set_properties $form_name caller        -value $caller
    element set_properties $form_name nome_funz     -value $nome_funz
    element set_properties $form_name nome_funz_caller -value $nome_funz_caller
    element set_properties $form_name extra_par     -value $extra_par
    element set_properties $form_name cod_impianto  -value $cod_impianto
    element set_properties $form_name gen_prog      -value $gen_prog
    element set_properties $form_name url_list_aimp -value $url_list_aimp
    element set_properties $form_name url_aimp      -value $url_aimp
    element set_properties $form_name last_gen_prog -value $last_gen_prog

    if {$funzione == "I"} {
      # propongo il numero del nuovo generatore con il max + 1
        db_1row sel_gend_next_prog_est ""
        element set_properties $form_name gen_prog_est -value $next_prog_est
        
    } else {
      # leggo riga
        if {[db_0or1row sel_gend {}] == 0} {
            iter_return_complaint "Record non trovato"
	}

        element set_properties $form_name gen_prog_est        -value $gen_prog_est
        element set_properties $form_name descrizione         -value $descrizione
        element set_properties $form_name matricola           -value $matricola
        element set_properties $form_name modello             -value $modello
        element set_properties $form_name cod_cost            -value $cod_cost
        element set_properties $form_name tipo_foco           -value $tipo_foco
        element set_properties $form_name mod_funz            -value $mod_funz
        element set_properties $form_name cod_utgi            -value $cod_utgi
        element set_properties $form_name tipo_bruciatore     -value $tipo_bruciatore
        element set_properties $form_name tiraggio            -value $tiraggio
        element set_properties $form_name matricola_bruc      -value $matricola_bruc
        element set_properties $form_name modello_bruc        -value $modello_bruc
        element set_properties $form_name cod_cost_bruc       -value $cod_cost_bruc
        element set_properties $form_name locale              -value $locale
        element set_properties $form_name cod_emissione       -value $cod_emissione
        element set_properties $form_name cod_combustibile    -value $cod_combustibile
        element set_properties $form_name data_installaz      -value $data_installaz
        element set_properties $form_name data_rottamaz       -value $data_rottamaz
        element set_properties $form_name pot_focolare_lib    -value $pot_focolare_lib
        element set_properties $form_name pot_utile_lib       -value $pot_utile_lib
        element set_properties $form_name pot_focolare_nom    -value $pot_focolare_nom
        element set_properties $form_name pot_utile_nom       -value $pot_utile_nom
        element set_properties $form_name flag_attivo         -value $flag_attivo
        element set_properties $form_name note                -value $note
	element set_properties $form_name data_costruz_gen    -value $data_costruz_gen
        element set_properties $form_name data_costruz_bruc   -value $data_costruz_bruc
        element set_properties $form_name data_installaz_bruc -value $data_installaz_bruc
        element set_properties $form_name data_rottamaz_bruc  -value $data_rottamaz_bruc
        element set_properties $form_name marc_effic_energ    -value $marc_effic_energ
        element set_properties $form_name campo_funzion_max   -value $campo_funzion_max
        element set_properties $form_name campo_funzion_min   -value $campo_funzion_min
        element set_properties $form_name dpr_660_96          -value $dpr_660_96
    }
}

if {[form is_valid $form_name]} {
  # form valido dal punto di vista del templating system

    set cod_impianto         [element::get_value $form_name cod_impianto]
    set gen_prog             [element::get_value $form_name gen_prog]
    set gen_prog_est         [element::get_value $form_name gen_prog_est]
    set descrizione          [element::get_value $form_name descrizione]
    set matricola            [element::get_value $form_name matricola]
    set modello              [element::get_value $form_name modello]
    set cod_cost             [element::get_value $form_name cod_cost]
    set tipo_foco            [element::get_value $form_name tipo_foco]
    set mod_funz             [element::get_value $form_name mod_funz]
    set cod_utgi             [element::get_value $form_name cod_utgi]
    set tipo_bruciatore      [element::get_value $form_name tipo_bruciatore]
    set tiraggio             [element::get_value $form_name tiraggio]
    set matricola_bruc       [element::get_value $form_name matricola_bruc]
    set modello_bruc         [element::get_value $form_name modello_bruc]
    set cod_cost_bruc        [element::get_value $form_name cod_cost_bruc]
    set locale               [element::get_value $form_name locale]
    set cod_emissione        [element::get_value $form_name cod_emissione]
    set cod_combustibile     [element::get_value $form_name cod_combustibile]
    set data_installaz       [element::get_value $form_name data_installaz]
    set data_rottamaz        [element::get_value $form_name data_rottamaz]
    set pot_focolare_lib     [element::get_value $form_name pot_focolare_lib]
    set pot_utile_lib        [element::get_value $form_name pot_utile_lib]
    set pot_focolare_nom     [element::get_value $form_name pot_focolare_nom]
    set pot_utile_nom        [element::get_value $form_name pot_utile_nom]
    set flag_attivo          [element::get_value $form_name flag_attivo]
    set note                 [element::get_value $form_name note]
    set data_costruz_gen     [element::get_value $form_name data_costruz_gen]
    set data_costruz_bruc    [element::get_value $form_name data_costruz_bruc]
    set data_installaz_bruc  [element::get_value $form_name data_installaz_bruc]
    set data_rottamaz_bruc   [element::get_value $form_name data_rottamaz_bruc]
    set marc_effic_energ     [element::get_value $form_name marc_effic_energ]
    set campo_funzion_max    [element::get_value $form_name campo_funzion_max]
    set campo_funzion_min    [element::get_value $form_name campo_funzion_min]
    set dpr_660_96           [element::get_value $form_name dpr_660_96]

  # controlli standard su numeri e date, per Ins ed Upd
    set error_num 0
    if {$funzione == "I"
    ||  $funzione == "M"
    } {
        if {[string equal $gen_prog_est ""]} {
	    element::set_error $form_name gen_prog_est "Inserire numero generatore"
	    incr error_num
	} else {
            set gen_prog_est [iter_check_num $gen_prog_est 0]
            if {$gen_prog_est == "Error"} {
                element::set_error $form_name gen_prog_est "Deve essere un numero intero"
                incr error_num
            } else {
                if {[iter_set_double $gen_prog_est] >=  [expr pow(10,8)]
                ||  [iter_set_double $gen_prog_est] <= -[expr pow(10,8)]} {
                    element::set_error $form_name gen_prog_est "Deve essere inferiore di 100.000.000"
                    incr error_num
                } else {
		    if {$funzione == "I"} {
			set where_gen_prog ""
		    } else {
			set where_gen_prog "and gen_prog <> :gen_prog"
		    }
		    if {[db_0or1row sel_gend_check {}] == 1} {
			element::set_error $form_name gen_prog_est "Esiste un altro generatore con questo numero."
			incr error_num
		    }
		}
            }
        }

        if {![string equal $data_installaz ""]} {
            set data_installaz [iter_check_date $data_installaz]
            if {$data_installaz == 0} {
                element::set_error $form_name data_installaz "Data installazione deve essere una data"
                incr error_num
            } else {
		if {$data_installaz > $current_date} {
		    element::set_error $form_name data_installaz  "Data deve essere anteriore alla data odierna"
		    incr error_num
		}
	    }
        }

        if {![string equal $data_rottamaz ""]} {
            set data_rottamaz [iter_check_date $data_rottamaz]
            if {$data_rottamaz == 0} {
                element::set_error $form_name data_rottamaz "data rottamazione deve essere una data"
                incr error_num
            } else {
		if {$data_rottamaz > $current_date} {
		    element::set_error $form_name data_rottamaz  "Data deve essere anteriore alla data odierna"
		    incr error_num
		}
	    }
        }

        if {![string equal $data_installaz ""]
         && ![string equal $data_rottamaz ""]} {
            if {$data_rottamaz < $data_installaz} {
                element::set_error $form_name data_rottamaz "Data rottamazione deve essere > di data installazione"
                incr error_num
	    }
	}

        if {[string equal $flag_attivo "S"]
        && ![string equal $data_rottamaz ""]} {
	    element::set_error $form_name data_rottamaz "Non rottamabile se &egrave; attivo"
            incr error_num
	}

        if {![string equal $pot_focolare_lib ""]} {
            set pot_focolare_lib [iter_check_num $pot_focolare_lib 2]
            if {$pot_focolare_lib == "Error"} {
                element::set_error $form_name pot_focolare_lib "Deve essere numerico, max 2 dec"
                incr error_num
            } else {
                if {[iter_set_double $pot_focolare_lib] >=  [expr pow(10,4)]
                ||  [iter_set_double $pot_focolare_lib] <= -[expr pow(10,4)]} {
                    element::set_error $form_name pot_focolare_lib "Deve essere inferiore di 10.000"
                    incr error_num
                }
            }
        }

        if {![string equal $pot_utile_lib ""]} {
            set pot_utile_lib [iter_check_num $pot_utile_lib 2]
            if {$pot_utile_lib == "Error"} {
                element::set_error $form_name pot_utile_lib "Deve essere numerico, max 2 dec"
                incr error_num
            } else {
                if {[iter_set_double $pot_utile_lib] >=  [expr pow(10,4)]
                ||  [iter_set_double $pot_utile_lib] <= -[expr pow(10,4)]} {
                    element::set_error $form_name pot_utile_lib "Deve essere inferiore di 10.000"
                    incr error_num
                }
            }
        }

        if {![string equal $pot_focolare_nom ""]} {
            set pot_focolare_nom [iter_check_num $pot_focolare_nom 2]
            if {$pot_focolare_nom == "Error"} {
                element::set_error $form_name pot_focolare_nom "Deve essere numerico, max 2 dec"
                incr error_num
            } else {
		if {$pot_focolare_nom < "0.01"} {
		    element::set_error $form_name pot_focolare_nom "Deve essere > 0,00"
		    incr error_num	
		}
                if {[iter_set_double $pot_focolare_nom] >=  [expr pow(10,4)]
		    ||  [iter_set_double $pot_focolare_nom] <= -[expr pow(10,4)]} {
                    element::set_error $form_name pot_focolare_nom "Deve essere inferiore di 10.000"
                    incr error_num
                }
            }
        } else {
	    element::set_error $form_name pot_focolare_nom "Inserire"
	    incr error_num
	}

        if {![string equal $pot_utile_nom ""]} {
            set pot_utile_nom [iter_check_num $pot_utile_nom 2]
            if {$pot_utile_nom == "Error"} {
                element::set_error $form_name pot_utile_nom "Deve essere numerico, max 2 dec"
                incr error_num
            } else {
                if {[iter_set_double $pot_utile_nom] >=  [expr pow(10,4)]
                ||  [iter_set_double $pot_utile_nom] <= -[expr pow(10,4)]} {
                    element::set_error $form_name pot_utile_nom "Deve essere inferiore di 10.000"
                    incr error_num
                }
            }
        }

        if {![string equal $data_costruz_gen ""]} {
            set data_costruz_gen [iter_check_date $data_costruz_gen]
            if {$data_costruz_gen == 0} {
                element::set_error $form_name data_costruz_gen "Inserrire correttamente"
                incr error_num
            } else {
		if {$data_costruz_gen > $current_date} {
		    element::set_error $form_name data_costruz_gen "Data deve essere anteriore alla data odierna"
		    incr error_num
		}
	    }
        }

        if {![string equal $data_costruz_bruc ""]} {
            set data_costruz_bruc [iter_check_date $data_costruz_bruc]
            if {$data_costruz_bruc == 0} {
                element::set_error $form_name data_costruz_bruc "Inserrire correttamente"
                incr error_num
            } else {
		if {$data_costruz_bruc > $current_date} {
		    element::set_error $form_name data_costruz_bruc  "Data deve essere anteriore alla data odierna"
		    incr error_num
		}
	    }
        }

        if {![string equal $data_installaz_bruc ""]} {
            set data_installaz_bruc [iter_check_date $data_installaz_bruc]
            if {$data_installaz_bruc == 0} {
                element::set_error $form_name data_installaz_bruc "Inserrire correttamente"
                incr error_num
            } else {
		if {$data_installaz_bruc > $current_date} {
		    element::set_error $form_name data_installaz_bruc  "Data deve essere anteriore alla data odierna"
		    incr error_num
		}
	    }
        }

	if {![string equal $data_costruz_bruc ""]
         && ![string equal $data_installaz_bruc ""]} {
	    if {$data_costruz_bruc > $data_installaz_bruc} {
		element::set_error $form_name data_costruz_bruc  "Data deve essere anteriore alla data di installazione"
		incr error_num
	    }
	}

	if {![string equal $data_costruz_gen ""]
         && ![string equal $data_installaz ""]} {
	    if {$data_costruz_gen > $data_installaz} {
		element::set_error $form_name data_costruz_gen  "Data deve essere anteriore alla data di installazione"
		incr error_num
	    }
	}

        if {![string equal $data_rottamaz_bruc ""]} {
            set data_rottamaz_bruc [iter_check_date $data_rottamaz_bruc]
            if {$data_rottamaz_bruc == 0} {
                element::set_error $form_name data_rottamaz_bruc "Inserrire correttamente"
                incr error_num
            } else {
		if {$data_rottamaz_bruc > $current_date} {
		    element::set_error $form_name data_rottamaz_bruc  "Data deve essere anteriore alla data odierna"
		    incr error_num
		}
	    }
        }

	if {![string equal $campo_funzion_max ""]
	  && [string equal $campo_funzion_min ""]} {
	    element::set_error $form_name campo_funzion_min "Inserire anche il valore minimo"
	    incr error_num
	}

	if {![string equal $campo_funzion_min ""]
	  && [string equal $campo_funzion_max ""]} {
	    element::set_error $form_name campo_funzion_max "Inserire anche il valore massimo"
	    incr error_num
	}

        if {![string equal $campo_funzion_max ""]} {
            set campo_funzion_max [iter_check_num $campo_funzion_max 2]
            if {$campo_funzion_max == "Error"} {
                element::set_error $form_name campo_funzion_max "Deve essere numerico, max 2 dec"
                incr error_num
            } else {
                if {[iter_set_double $campo_funzion_max] >=  [expr pow(10,7)]
                ||  [iter_set_double $campo_funzion_max] <= -[expr pow(10,7)]} {
                    element::set_error $form_name campo_funzion_max "Deve essere inferiore di 10.000.000"
                    incr error_num
                }
            }
        }

        if {![string equal $campo_funzion_min ""]} {
            set campo_funzion_min [iter_check_num $campo_funzion_min 2]
            if {$campo_funzion_min == "Error"} {
                element::set_error $form_name campo_funzion_min "Deve essere numerico, max 2 dec"
                incr error_num
            } else {
                if {[iter_set_double $campo_funzion_min] >=  [expr pow(10,7)]
                ||  [iter_set_double $campo_funzion_min] <= -[expr pow(10,7)]} {
                    element::set_error $form_name campo_funzion_min "Deve essere inferiore di 10.000.000"
                    incr error_num
                }
            }
        }

	if {![string equal $campo_funzion_min ""]
	 && ![string equal $campo_funzion_max ""]
	 && $campo_funzion_min > $campo_funzion_max} {
            element::set_error $form_name campo_funzion_min "Il val. min deve essere < del val. max"
	    incr error_num
        }

	if {![string equal $data_installaz_bruc ""]
         && ![string equal $data_rottamaz_bruc ""]} {
            if {$data_rottamaz_bruc < $data_installaz_bruc} {
                element::set_error $form_name data_rottamaz_bruc "Data rottamazione bruc deve. essere > di data installazione bruc."
                incr error_num
	    }
	}

    }

     if {$funzione == "D"} {
	db_0or1row sel_cimp_check ""
	if {$conta_cimp > 0} {
	    # controllo la presenza di rapporti verifica con questo generatore
	    element::set_error $form_name gen_prog_est "Il generatore che stai tentando di eliminare &egrave; presente in uno o pi&ugrave; rapporti di ispezione"
	    incr error_num       
	}

	db_0or1row sel_dimp_check " select count(*) as conta_dimp
                                   from coimdimp
                                   where cod_impianto = :cod_impianto
                                  and gen_prog     = :gen_prog
        "
	if {$conta_dimp > 0} {
	    # controllo la presenza di modelli h con questo generatore
	    element::set_error $form_name gen_prog_est "Il generatore che stai tentando di eliminare &egrave; presente in una o pi&ugrave; dichiarazioni"
	    incr error_num       
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
		I {
		    # valorizzo il progressivo interno del nuovo generatore
		    # col max + 1.
		    db_1row sel_gend_next_prog ""
		    set gen_prog $next_prog
		    db_dml ins_gend ""
		}
		M {
		    db_dml upd_gend ""
		}
		D {
		    db_dml del_gend ""
		}
	    }
	    if {$funzione != "V"} {
		# aggiorno l'impianto valorizzando il numero di generatori
		# le potenze e la fascia con la somma dei valori
		# corrispondenti di tutti i generatori attivi
		if {[db_0or1row sel_gend_count ""] == 0} {
		    set count_gend           ""
		    set tot_pot_focolare_nom ""
		    set tot_pot_utile_nom    ""
		}

		# aggiorno il numero generatori
		db_dml upd_aimp ""
		
		# aggiorno la potenza focolare dell'impianto
		if {![string equal $tot_pot_focolare_nom ""]} {
		    if {[db_0or1row sel_pote_cod ""] == 1} {
			db_dml upd_aimp_potenza ""
		    }
		}
		
		# aggiorno la potenza utile dell'impianto
		if {![string equal $tot_pot_utile_nom ""]} {
		    db_dml upd_aimp_potenza_utile ""
		}
	    }
	}
    } {
	iter_return_complaint "Spiacente, ma il DBMS ha restituito il
        seguente messaggio di errore <br><b>$error_msg</b><br>
        Contattare amministratore di sistema e comunicare il messaggio
        d'errore. Grazie."
    }

  # dopo l'inserimento posiziono la lista sul record inserito
    if {$funzione == "I"} {
        set last_gen_prog $gen_prog_est
    }
    set link_list      [subst $link_list_script]
    set link_gest      [export_url_vars cod_impianto gen_prog last_gen_prog nome_funz nome_funz_caller url_list_aimp url_aimp extra_par caller]
    switch $funzione {
        M {set return_url   "coimgend-gest?funzione=V&$link_gest"}
        D {set return_url   "coimgend-list?$link_list"}
        I {set return_url   "coimgend-gest?funzione=V&$link_gest"}
        V {set return_url   "coimgend-list?$link_list"}
    }

    ad_returnredirect $return_url
    ad_script_abort
}

ad_return_template
