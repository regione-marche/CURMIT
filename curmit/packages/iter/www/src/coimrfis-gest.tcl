ad_page_contract {
    Add/Edit/Delete  form per la tabella "coimrfis"
    @author          Adhoc
    @creation-date   27/10/2005

    @param funzione  I=insert M=edit D=delete V=view
    @param caller    caller della lista da restituire alla lista:
                     serve se lista e' uno zoom che permetti aggiungi.
    @param nome_funz identifica l'entrata di menu, server per le autorizzazioni
                     serve se lista e' uno zoom che permetti aggiungi.
    @param nome_funz_caller identifica l'entrata di menu, serve per la 
                     navigazione con navigation bar
    @param extra_par Variabili extra da restituire alla lista
    @cvs-id          coimrfis-gest.tcl
} {
   {url_dimp ""}
   {url_boll ""}
   {cod_responsabile ""}
   {cod_sogg ""}   
   {tipo_sogg ""}
   {cod_rfis ""}
   {last_cod_rfis ""}
   {last_data_rfis ""}
   {cod_bollini ""} 
   {funzione  "V"}
   {caller    "index"}
   {nome_funz ""}
   {nome_funz_caller ""}
   {extra_par ""}
   {cod_impianto ""}
   {riferimento_pag ""}
} -properties {
    page_title:onevalue
    context_bar:onevalue
    form_name:onevalue
}

# Controlla lo user
# TODO: controllare il livello richiesto,
# Se il programma e' 'delicato', mettere livello 5 (amministratore).
switch $funzione {
    "V" {set lvl 1}
    "I" {set lvl 2}
    "M" {set lvl 3}
    "D" {set lvl 4}
}

set id_utente [lindex [iter_check_login $lvl $nome_funz] 1]

set ritorna_gest ""
if {$extra_par != ""} {
    set ritorna_gest [lindex $extra_par 1]
} else {
    if {$url_boll != ""} {
	set ritorna_gest $url_boll
    }
    if {$url_dimp != ""} {
	set ritorna_gest $url_dimp
    }
}
#ns_return 200 text/html "-$url_dimp-<br>-$url_boll-<br>-$ritorna_boll-"; return
set link_gest [export_url_vars cod_sogg tipo_sogg cod_rfis last_cod_rfis last_data_rfis nome_funz nome_funz_caller extra_par caller]


# imposta le class css della barra delle funzioni
iter_set_func_class $funzione

# controllo il parametro di "propagazione" per la navigation bar
if {[string is space $nome_funz_caller]} {
    set nome_funz_caller $nome_funz
}

# Personalizzo la pagina
# TODO: controllare impostazione della context_bar adattando come necessario
set link_list_script {[export_url_vars cod_sogg last_cod_rfis last_data_rfis cod_rfis tipo_sogg caller nome_funz_caller nome_funz]&[iter_set_url_vars $extra_par]}
set link_list        [subst $link_list_script]
if {$url_boll != ""
    || $url_dimp != ""} {
    if {$url_boll != ""} {     
	set extra_par       [list url_boll        $url_boll]
    }
    if {$url_dimp != ""} {     
	set extra_par       [list url_dimp        $url_dimp]
    }
}

set titolo           "ricevuta fiscale"
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

# TODO: se la lista che richiama questo programma e' un pgm di zoom
#       attivare la seguente if

set context_bar  [iter_context_bar -nome_funz $nome_funz_caller]

set form_name    "coimrfis"
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

element create $form_name data_rfis \
-label   "data_rfis" \
-widget   text \
-datatype text \
-html    "size 10 maxlength 10 $readonly_fld {} class form_element" \
-optional

element create $form_name num_rfis \
-label   "num_rfis" \
-widget   text \
-datatype text \
-html    "size 10 maxlength 10 $readonly_fld {} class form_element" \
-optional

element create $form_name cognome \
-label   "cognome" \
-widget   text \
-datatype text \
-html    "size 30 maxlength 40 $readonly_fld {} class form_element" \
-optional

element create $form_name nome \
-label   "nome" \
-widget   text \
-datatype text \
-html    "size 30 maxlength 40 $readonly_fld {} class form_element" \
-optional

element create $form_name imponibile \
-label   "imponibile" \
-widget   text \
-datatype text \
-html    "size 10 maxlength 10 $readonly_fld {} class form_element" \
-optional

element create $form_name perc_iva \
-label   "perc_iva" \
-widget   text \
-datatype text \
-html    "size 6 maxlength 6 $readonly_fld {} class form_element" \
-optional

element create $form_name flag_pag \
-label   "flag_pag" \
-widget   select \
-datatype text \
-html    "size 1 maxlength 1 $readonly_fld {} class form_element" \
-optional \
-options {{{} {}} {Si S} {No N}}

element create $form_name matr_da \
-label   "matr_da" \
-widget   text \
-datatype text \
-html    "size 10 maxlength 20 $readonly_fld {} class form_element" \
-optional

element create $form_name matr_a \
-label   "matr_a" \
-widget   text \
-datatype text \
-html    "size 10 maxlength 20 $readonly_fld {} class form_element" \
-optional

element create $form_name n_bollini \
-label   "n_bollini" \
-widget   text \
-datatype text \
-html    "size 10 maxlength 10 $readonly_fld {} class form_element" \
-optional

element create $form_name nota \
-label   "nota" \
-widget   textarea \
-datatype text \
-html    "cols 40 rows 5 $readonly_fld {} class form_element" \
-optional

element create $form_name mod_pag \
-label   "mod_pag" \
-widget   text \
-datatype text \
-html    "size 20 maxlength 200 $readonly_fld {} class form_element" \
-optional

element create $form_name funzione  -widget hidden -datatype text -optional
element create $form_name caller    -widget hidden -datatype text -optional
element create $form_name nome_funz -widget hidden -datatype text -optional
element create $form_name nome_funz_caller -widget hidden -datatype text -optional
element create $form_name extra_par -widget hidden -datatype text -optional
element create $form_name submit    -widget submit -datatype text -label "$button_label" -html "class form_submit"
element create $form_name last_cod_rfis -widget hidden -datatype text -optional
element create $form_name last_data_rfis -widget hidden -datatype text -optional
element create $form_name cod_rfis  -widget hidden -datatype text -optional
element create $form_name tipo_sogg -widget hidden -datatype text -optional
element create $form_name cod_sogg  -widget hidden -datatype text -optional

set cerca_sogg ""

if {$funzione == "I"
||  $funzione == "M"
} {  
    switch $tipo_sogg {
	"M" { set cerca_sogg [iter_search $form_name coimmanu-list [list dummy cod_sogg dummy cognome dummy nome]] 
	}
	"C" { set cerca_sogg [iter_search $form_name coimcitt-list [list dummy cod_sogg dummy cognome dummy nome]] 
	}
    }
} 


if {[form is_request $form_name]} {

    element set_properties $form_name funzione         -value $funzione
    element set_properties $form_name caller           -value $caller
    element set_properties $form_name nome_funz        -value $nome_funz
    element set_properties $form_name nome_funz_caller -value $nome_funz_caller
    element set_properties $form_name extra_par        -value $extra_par
    element set_properties $form_name last_cod_rfis    -value $last_cod_rfis
    element set_properties $form_name last_data_rfis   -value $last_data_rfis
    element set_properties $form_name cod_rfis         -value $cod_rfis
    element set_properties $form_name tipo_sogg        -value $tipo_sogg

    if {$funzione == "I"} {
      # TODO: settare eventuali default!!
	db_1row sel_date "select to_char(current_date, 'dd/mm/yyyy') as current_date"
        element set_properties $form_name data_rfis      -value $current_date	
	element set_properties $form_name perc_iva       -value "22"

	if { $tipo_sogg == "C"} {
 	    element set_properties $form_name imponibile -value "8"
	    element set_properties $form_name flag_pag   -value "S"
	    element set_properties $form_name n_bollini  -value "1"
	}

	if {[db_0or1row sel_boll {}] == 1} {
	    element set_properties $form_name tipo_sogg    -value "M"
	    element set_properties $form_name cod_sogg     -value $cod_manutentore
	    element set_properties $form_name cognome      -value $cognome_manu
	    element set_properties $form_name nome         -value $nome_manu
	    set calc_imp [expr $costo_unitario * $nr_bollini]
#	    set calc_imp [expr $calc_imp * 100 / 122]
            set calc_imp [iter_edit_num $calc_imp 2]
	    element set_properties $form_name imponibile   -value $calc_imp
	    element set_properties $form_name flag_pag     -value $pagati
	    element set_properties $form_name matr_da      -value $matricola_da
	    element set_properties $form_name matr_a       -value $matricola_a
	    element set_properties $form_name n_bollini    -value $nr_bollini
	}

     	if {[db_0or1row sel_dimp {}] == 1} {
	    element set_properties $form_name tipo_sogg    -value "C"
	    element set_properties $form_name cod_sogg     -value $cod_responsabile
	    element set_properties $form_name cognome      -value $cognome_citt
	    element set_properties $form_name nome         -value $nome_citt
 	    element set_properties $form_name imponibile   -value "8"
	    element set_properties $form_name flag_pag     -value "S"
	    element set_properties $form_name n_bollini    -value "1"
	    if {[db_0or1row sel_aimp_est {}] == 1} {
		element set_properties $form_name matr_da        -value $cod_impianto_est
		element set_properties $form_name matr_a         -value $cod_impianto_est
	    }
	}

    } else {

      # leggo riga
        if {[db_0or1row sel_rfis {}] == 0} {
            iter_return_complaint "Record non trovato"
	}
    
        element set_properties $form_name data_rfis  -value $data_rfis
        element set_properties $form_name num_rfis   -value $num_rfis
	element set_properties $form_name tipo_sogg  -value $tipo_sogg

	if {$tipo_sogg == "M"} {
	    element set_properties $form_name cognome    -value $cognome_manu
	    element set_properties $form_name nome       -value $nome_manu
	} else {
	    element set_properties $form_name cognome    -value $cognome_citt
	    element set_properties $form_name nome       -value $nome_citt
	}
        element set_properties $form_name imponibile -value $imponibile
        element set_properties $form_name perc_iva   -value $perc_iva
        element set_properties $form_name flag_pag   -value $flag_pag
        element set_properties $form_name matr_da    -value $matr_da
        element set_properties $form_name matr_a     -value $matr_a
        element set_properties $form_name n_bollini  -value $n_bollini
        element set_properties $form_name mod_pag    -value $mod_pag
        element set_properties $form_name nota       -value $nota
        element set_properties $form_name cod_sogg   -value $cod_sogg
    }
}

if {$funzione != "I"} {
    set link_stampa "nome_funz=[iter_get_nomefunz coimrfis-layout]&[export_url_vars cod_rfis cod_sogg tipo_sogg]"
}

if {[form is_valid $form_name]} {
  # form valido dal punto di vista del templating system

    set data_rfis  [element::get_value $form_name data_rfis]
    set num_rfis   [element::get_value $form_name num_rfis]
    set cognome    [element::get_value $form_name cognome]
    set nome       [element::get_value $form_name nome]
    set imponibile [element::get_value $form_name imponibile]
    set perc_iva   [element::get_value $form_name perc_iva]
    set flag_pag   [element::get_value $form_name flag_pag]
    set matr_da    [element::get_value $form_name matr_da]
    set matr_a     [element::get_value $form_name matr_a]
    set n_bollini  [element::get_value $form_name n_bollini]
    set mod_pag    [element::get_value $form_name mod_pag]
    set nota       [element::get_value $form_name nota]
    set cod_sogg   [element::get_value $form_name cod_sogg]
 
  # controlli standard su numeri e date, per Ins ed Upd

    set error_num 0
    if {$funzione == "I"
    ||  $funzione == "M"
    } {

        if {[string equal $data_rfis ""]} {
            element::set_error $form_name data_rfis "Inserire data rfisura"
            incr error_num
        } else {
            set data_rfis [iter_check_date $data_rfis]
            if {$data_rfis == 0} {
                element::set_error $form_name data_rfis "La data rfisura deve essere una data"
                incr error_num
            }
        }

        if {[string equal $num_rfis ""]} {
            element::set_error $form_name num_rfis "Inserire numero rfisura"
            incr error_num
        }

        if {[string equal $imponibile ""]} {
            element::set_error $form_name imponibile "Inserire imponibile"
            incr error_num
	} else {
            set imponibile [iter_check_num $imponibile 2]
            if {$imponibile == "Error"} {
                element::set_error $form_name imponibile "L'imponibile deve essere numerico e pu&ograve; avere al massimo 2 decimali"
                incr error_num
            } else {
                if {[iter_set_double $imponibile] >=  [expr pow(10,6)]
                ||  [iter_set_double $imponibile] <= -[expr pow(10,6)]} {
                    element::set_error $form_name imponibile "L'imponibile deve essere inferiore di 1.000.000"
                    incr error_num
                }
            }
        }

        if {[string equal $perc_iva ""]} {
            element::set_error $form_name perc_iva "Inserire percentuale iva"
            incr error_num
	} else {
            set perc_iva [iter_check_num $perc_iva 2]
            if {$perc_iva == "Error"} {
                element::set_error $form_name perc_iva "La percentuale iva deve essere numerico e pu&ograve; avere al massimo 2 decimali"
                incr error_num
            } else {
                if {[iter_set_double $perc_iva] >=  [expr pow(10,2)]
                ||  [iter_set_double $perc_iva] <= -[expr pow(10,2)]} {
                    element::set_error $form_name perc_iva "La percentuale iva deve essere inferiore di 100"
                    incr error_num
                }
            }
        }

#########
	#routine generica per controllo codice manutentore
	set check_cod_sogg {
	    set chk_out_rc       0
	    set chk_out_msg      ""
	    set chk_out_cod_sogg ""
	    set ctr_sogg         0
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
	    switch $tipo_sogg {
		"M" { db_foreach sel_sogg_manu "" {
		          incr ctr_sogg
		          if {$cod_sogg_db == $chk_inp_cod_sogg} {
		              set chk_out_cod_sogg $cod_sogg_db
		              set chk_out_rc       1
		          }
	              }
		}
		"C" { db_foreach sel_sogg_citt "" {
		          incr ctr_sogg
		          if {$cod_sogg_db == $chk_inp_cod_sogg} {
		              set chk_out_cod_sogg $cod_sogg_db
		              set chk_out_rc       1
		          }
	              }
		}
	    }

	    switch $ctr_sogg {
		0 { set chk_out_msg "Soggetto non trovato"}
		1 { set chk_out_cod_sogg $cod_sogg_db
		    set chk_out_rc       1 }
		default {
		    if {$chk_out_rc == 0} {
			set chk_out_msg "Trovati pi&ugrave; soggetti: usa il link cerca"
		    }
		}
	    }
	}
    
	if {[string equal $cognome ""]
	&&  [string equal $nome ""]
	} {
	    set cod_sogg ""
	} else {
	    set chk_inp_cod_sogg $cod_sogg
	    set chk_inp_cognome  $cognome
	    set chk_inp_nome     $nome
	    eval $check_cod_sogg
	    set cod_sogg  $chk_out_cod_sogg
	    if {$chk_out_rc == 0} {
		element::set_error $form_name cognome $chk_out_msg
		incr error_num
	    }
	}
	

#########

	if {$funzione == "M"} {
	    set where_mod " and cod_rfis <> :cod_rfis"
	} else {
	    set where_mod ""
	}
	if {[db_0or1row sel_num_check ""] == 1} {
	    element::set_error $form_name num_rfis "Il numero rfisura &egrave gi&agrave presente nell'anno inserito"
	    incr error_num
	}
    }

    if {$funzione == "I"
    &&  $error_num == 0
    &&  [db_0or1row sel_rfis_check {}] == 1
    } {
      # controllo univocita'/protezione da double_click
        element::set_error $form_name cod_rfis "Il record che stai tentando di inserire &egrave; gi&agrave; esistente nel Data Base."
        incr error_num
    }

     if {$error_num > 0} {
        ad_return_template
        return
     }

    switch $funzione {
        I { db_1row sel_cod_rfis ""
           set dml_sql [db_map ins_rfis]}
        M {set dml_sql [db_map upd_rfis]}
        D {set dml_sql [db_map del_rfis]}
    }

  # Lancio la query di manipolazione dati contenute in dml_sql
    if {[info exists dml_sql]} {
        with_catch error_msg {
            db_transaction {
                db_dml dml_coimrfis $dml_sql
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
        set last_cod_rfis $cod_rfis
	set last_data_rfis $data_rfis
    }

    set link_list      [subst $link_list_script]
    set link_gest      [export_url_vars cod_rfis cod_sogg tipo_sogg last_cod_rfis last_data_rfis nome_funz nome_funz_caller extra_par caller]

	switch $funzione {
	    M {set return_url   "coimrfis-gest?funzione=V&$link_gest"}
	    D {set return_url   "coimrfis-list?$link_list"}
	    I {set return_url   "coimrfis-gest?funzione=V&$link_gest"}
	    V {set return_url   "coimrfis-list?$link_list"}
	}

    ad_returnredirect $return_url
    ad_script_abort

}

ad_return_template
