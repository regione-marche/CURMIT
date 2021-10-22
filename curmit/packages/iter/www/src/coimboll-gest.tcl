ad_page_contract {
    Add/Edit/Delete  form per la tabella "coimboll"

    @author          Katia Coazzoli Adhoc
    @creation-date   08/03/2004

    @param funzione  I=insert M=edit D=delete V=view
    @param caller    caller della lista da restituire alla lista:
    @param           serve se lista e' uno zoom che permetti aggiungi.
    @param nome_funz identifica l'entrata di menu, server per le autorizzazioni
    @param           serve se lista e' uno zoom che permetti aggiungi.
    @param extra_par Variabili extra da restituire alla lista

    @cvs-id          coimboll-gest.tcl

    USER  DATA       MODIFICHE
    ===== ========== =======================================================================
    san01 25/11/2015 Corretta anomalia che capitava se chiamato dall'anagrafica manutentore.

    nic01 19/02/2014 Su indicazioni di Sandro e Luca, aggiungo la richiesta di conferma.
} {
   {cod_bollini      ""}
   {last_order       ""}
   {funzione         "V"}
   {caller           "index"}
   {nome_funz        ""}
   {nome_funz_caller ""}
   {extra_par        ""}
   {cod_manutentore  ""}
   {flag_attivo      ""}
   {f_manu_cogn          ""}
   {f_manu_nome          ""}
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
set link_gest [export_url_vars cod_bollini last_order nome_funz nome_funz_caller extra_par caller flag_attivo]
# imposta le class css della barra delle funzioni
iter_set_func_class $funzione
set current_date      [iter_set_sysdate]

# controllo il parametro di "propagazione" per la navigation bar
if {[string is space $nome_funz_caller]} {
    set nome_funz_caller $nome_funz
}

iter_get_coimtgen
set flag_ente  $coimtgen(flag_ente)
set sigla_prov $coimtgen(sigla_prov)
set cod_comu   $coimtgen(cod_comu)


# Personalizzo la pagina
# estraggo nome/cognome del manutentore
if {[db_0or1row sel_manu_1 ""] == 0} {
    set cognome  ""
    set nome "" 
} else {#san01
    set f_manu_cogn $cognome;#san01
    set f_manu_nome $nome;#san01
}
 
set link_list_script {[export_url_vars cod_manutentore flag_attivo last_order caller nome_funz nome_funz_caller]&[iter_set_url_vars $extra_par]}
set link_list        [subst $link_list_script]

if {$nome_funz == "boll-ins"} {
    if {$funzione != "I"} {
	set link_ritorna "coimboll-gest?funzione=I&[export_url_vars nome_funz]"
    } else {
	set link_ritorna ""
    }
} else {
    set link_ritorna "coimboll-list?$link_list"
}

set url_boll        [list [ad_conn url]?[export_ns_set_vars url]]
set url_boll        [export_url_vars url_boll]

if {$funzione != "I"} {
    set link_prnt    "nome_funz=[iter_get_nomefunz coimboll-layout]&[export_url_vars cod_bollini]"
    set link_rfis    "nome_funz=[iter_get_nomefunz coimrfis-gest]&url_boll=$url_boll&[export_url_vars cod_bollini]&funzione=I"
    set link_fatt    "nome_funz=[iter_get_nomefunz coimfatt-gest]&$url_boll&[export_url_vars cod_bollini]&funzione=I"
    set link_boap    "[export_url_vars cod_bollini nome_funz]&$url_boll"
}


if {$nome_funz_caller == $nome_funz} {
    set titolo           "Bollini"
} else {
    set titolo           "Bollini di $cognome $nome"
}

switch $funzione {
    M {set button_label "Conferma Modifica" 
       set page_title   "Modifica $titolo"}
    D {set button_label "Conferma Cancellazione"
       set page_title   "Cancellazione $titolo"}
    I {set button_label "Conferma Inserimento"
       set page_title   "Rilascio $titolo"}
    V {set button_label "Torna alla lista"
       set page_title   "Visualizzazione $titolo"}
}


if {$caller == "index"} {
    set context_bar  [iter_context_bar -nome_funz $nome_funz_caller]
} else {
    set context_bar  [iter_context_bar \
                     [list "javascript:window.close()" "Torna alla Gestione"] \
                     [list coimboll-list?$link_list "Lista Bollini $cognome $nome"] \
                     "$page_title"]
}

# sproteggo la chiave solo in inserimento e gli attributi in inserimento e mod.
set form_name    "coimboll"
set readonly_key "readonly"
set readonly_fld "readonly"
set disabled_fld "disabled"
set onsubmit_cmd ""
switch $funzione {
   "I" {
       set readonly_key \{\}
       set readonly_fld \{\}
       set disabled_fld \{\}
       set onsubmit_cmd "onSubmit {javascript:return(confirm('Confermi l\\'inserimento?'))}";#nic01
   }
   "M" {
       set readonly_fld \{\}
       set disabled_fld \{\}
       set onsubmit_cmd "onSubmit {javascript:return(confirm('Confermi la modifica?'))}";#nic01
   }
}

form create $form_name \
-html    $onsubmit_cmd

element create $form_name data_consegna \
-label   "data consegna" \
-widget   text \
-datatype text \
-html    "size 10 maxlength 10 $readonly_fld {} class form_element" \
-optional

element create $form_name nr_bollini \
-label   "nr bollini" \
-widget   text \
-datatype text \
-html    "size 10 maxlength 10 $readonly_fld {} class form_element" \
-optional

element create $form_name nr_bollini_resi \
-label   "nr bollini resi" \
-widget   text \
-datatype text \
-html    "size 10 maxlength 10 $readonly_fld {} class form_element" \
-optional

element create $form_name matricola_da \
-label   "matricola da" \
-widget   text \
-datatype text \
-html    "size 10 maxlength 10 $readonly_fld {} class form_element" \
-optional

element create $form_name matricola_a \
-label   "matricola a" \
-widget   text \
-datatype text \
-html    "size 10 maxlength 10 $readonly_fld {} class form_element" \
-optional

element create $form_name pagati \
-label   "pagati" \
-widget   select \
-datatype text \
-html    "size 1 maxlength 1 $disabled_fld {} class form_element" \
-optional \
-options  {{{} {}} {S&igrave; S} {No N}}

element create $form_name costo_unitario \
-label   "costo unitario" \
-widget   text \
-datatype text \
-html    "size 8 maxlength 8 $readonly_fld {} class form_element" \
-optional

element create $form_name note \
-label   "note" \
-widget   textarea \
-datatype text \
-html    "cols 50 rows 4 $readonly_fld {} class form_element" \
-optional

element create $form_name data_scadenza \
-label   "data scadenza" \
-widget   text \
-datatype text \
-html    "size 10 maxlenght 10 $readonly_fld {} class form_element" \
-optional

element create $form_name imp_pagato \
-label   "importo pagato" \
-widget   text \
-datatype text \
-html    "size 13 maxlength 13 $readonly_fld {} class form_element" \
-optional

element create $form_name data_pag \
-label   "data pag" \
-widget   text \
-datatype text \
-html    "size 10 maxlenght 10 $readonly_fld {} class form_element" \
-optional

element create $form_name f_manu_cogn \
-label   "Cognome" \
-widget   text \
-datatype text \
-html    "size 20 maxlength 100 $readonly_fld {} class form_element tabindex 10" \
-optional
    
element create $form_name f_manu_nome \
-label   "Nome" \
-widget   text \
-datatype text \
-html    "size 20 maxlength 100 $readonly_fld {} class form_element tabindex 11"\
-optional

if {$funzione == "I"
|| $funzione == "M"} {
    set cerca_manu [iter_search $form_name coimmanu-list [list dummy cod_manutentore f_cognome f_manu_cogn f_nome f_manu_nome nome_funz_caller nome_funz_caller ]]
} else {
    set cerca_manu ""
}
    
element create $form_name cod_tpbo \
-label   "Tipo bollino" \
-widget   select \
-datatype text \
-html    "$disabled_fld {} class form_element" \
-optional \
-options [iter_selbox_from_table coimtpbo cod_tpbo descr_tpbo]

if {$coimtgen(ente) eq "CRIMINI"} {#Sandro 18/07/2014
    set coimtbpl_order_by "descrizione desc";#Sandro 18/07/2014
} else {#Sandro 18/07/2014
    set coimtbpl_order_by "descrizione"
};#Sandro 18/07/2014

element create $form_name cod_tpbl \
-label   "Tipo bollino" \
-widget   select \
-datatype text \
-html    "$disabled_fld {} class form_element" \
-optional \
-options [iter_selbox_from_table coimtpbl cod_tipo_bol descrizione $coimtbpl_order_by]

element create $form_name imp_sconto \
-label   "importo sconto" \
-widget   text \
-datatype text \
-html    "size 10 $readonly_fld {} class form_element" \
-optional

element create $form_name mod_pag \
-label   "Mod.Pagamento" \
-widget   select \
-datatype text \
-html    "$disabled_fld {} class form_element" \
-optional \
-options [list [list "" ""] [list Bonifico B] [list Bollettino P] [list Altro A]]

element create $form_name funzione    -widget hidden -datatype text -optional
element create $form_name cod_bollini -widget hidden -datatype text -optional
element create $form_name caller      -widget hidden -datatype text -optional
element create $form_name nome_funz   -widget hidden -datatype text -optional
element create $form_name nome_funz_caller -widget hidden -datatype text -optional
element create $form_name flag_attivo -widget hidden -datatype text -optional
element create $form_name extra_par   -widget hidden -datatype text -optional
element create $form_name dummy		   -widget hidden -datatype text -optional
element create $form_name submit           -widget submit -datatype text -label "$button_label" -html "class form_submit"
element create $form_name last_order -widget hidden -datatype text -optional
element create $form_name cod_manutentore   -widget hidden -datatype text -optional

set link_fattura "Stampa fattura"

if {[form is_request $form_name]} {

    element set_properties $form_name funzione         -value $funzione
    element set_properties $form_name caller           -value $caller
    element set_properties $form_name nome_funz        -value $nome_funz
    element set_properties $form_name nome_funz_caller -value $nome_funz_caller
    element set_properties $form_name extra_par        -value $extra_par
    element set_properties $form_name last_order       -value $last_order
    element set_properties $form_name cod_manutentore  -value $cod_manutentore
    element set_properties $form_name f_manu_cogn        -value $f_manu_cogn
    element set_properties $form_name f_manu_nome        -value $f_manu_nome

    # solo se l'utente e' un manutentore valorizzo il relativo campo.
    if {![string equal $cod_manutentore ""]} {
	element set_properties $form_name cod_manutentore    -value $cod_manutentore
	if {[db_0or1row get_nome_manu ""] == 0} {
	    set f_manu_cogn ""
	    set f_manu_nome ""
	}
    }
    
    if {$funzione == "I"} {
        set current_date [iter_set_sysdate]
        set tipo_costo    1
	set cod_potenza  [db_string sel_pote_cod_min_35 ""]

        if {[db_0or1row sel_tari {}] == 1} {
            element set_properties $form_name costo_unitario   -value $importo
	}
	
	set data_consegna [iter_edit_date $current_date]
	element set_properties $form_name data_consegna -value $data_consegna
    } else {
      # leggo riga

        if {[db_0or1row sel_boll {}] == 0} {
            iter_return_complaint "Record non trovato"
	}

        element set_properties $form_name cod_bollini       -value $cod_bollini
        element set_properties $form_name data_consegna     -value $data_consegna
        element set_properties $form_name nr_bollini        -value $nr_bollini
        element set_properties $form_name nr_bollini_resi   -value $nr_bollini_resi
        element set_properties $form_name matricola_da      -value $matricola_da
        element set_properties $form_name matricola_a       -value $matricola_a
        element set_properties $form_name pagati            -value $pagati
        element set_properties $form_name costo_unitario    -value $costo_unitario
        element set_properties $form_name note              -value $note
        element set_properties $form_name data_scadenza     -value $data_scadenza
        element set_properties $form_name cod_tpbo          -value $cod_tpbo
        element set_properties $form_name cod_tpbl          -value $cod_tpbl
        element set_properties $form_name imp_pagato        -value $imp_pagato
	element set_properties $form_name imp_sconto        -value $imp_sconto
	element set_properties $form_name flag_attivo       -value $flag_attivo
	element set_properties $form_name f_manu_cogn       -value $f_manu_cogn
	element set_properties $form_name f_manu_nome       -value $f_manu_nome
	element set_properties $form_name cod_manutentore   -value $cod_manutentore
        element set_properties $form_name mod_pag           -value $mod_pag
        element set_properties $form_name data_pag          -value $data_pag
		
    }
}

if {[form is_valid $form_name]} {
  # form valido dal punto di vista del templating system

    set cod_bollini        [element::get_value $form_name cod_bollini]
    set data_consegna      [element::get_value $form_name data_consegna]
    set nr_bollini         [element::get_value $form_name nr_bollini]
    set nr_bollini_resi    [element::get_value $form_name nr_bollini_resi]
    set matricola_da       [element::get_value $form_name matricola_da]
    set matricola_a        [element::get_value $form_name matricola_a]
    set pagati             [element::get_value $form_name pagati]
    set costo_unitario     [element::get_value $form_name costo_unitario]
    set note               [element::get_value $form_name note]
    set data_scadenza      [element::get_value $form_name data_scadenza]
    set cod_manutentore    [string trim [element::get_value $form_name cod_manutentore]]
    set cod_tpbo           [element::get_value $form_name cod_tpbo]
    set cod_tpbl           [element::get_value $form_name cod_tpbl]
    set imp_pagato         [element::get_value $form_name imp_pagato]
    set imp_sconto         [element::get_value $form_name imp_sconto]
    set f_manu_cogn        [string trim [element::get_value $form_name f_manu_cogn]]
    set f_manu_nome        [string trim [element::get_value $form_name f_manu_nome]]
    set mod_pag            [string trim [element::get_value $form_name mod_pag]]
    set data_pag           [string trim [element::get_value $form_name data_pag]]

  # controlli standard su numeri e date, per Ins ed Upd
    set error_num 0
    if {$funzione == "I"
    ||  $funzione == "M"
    } {
	
	#data consegna obbligatoria 
        if {[string equal $data_consegna ""]} {
            element::set_error $form_name data_consegna "Inserire data consegna"
            incr error_num
	}
        
        if {![string equal $data_consegna ""]} {
            set data_consegna [iter_check_date $data_consegna]
            if {$data_consegna == 0} {
                element::set_error $form_name data_consegna "Data non corretta"
                incr error_num
            } else {
		if {$data_consegna > $current_date} {
		    element::set_error $form_name data_consegna "Data deve essere anteriore alla data odierna"
		    incr error_num
		}
	    }
        }
	
	# Per il Comune di Rimini, si obbliga l'inserimento del tipo bollino
	if {$coimtgen(ente) eq "CRIMINI"} {
	    if {[string equal $cod_tpbl ""]} {
		element::set_error $form_name cod_tpbl "Inserire il tipo bollino"
		incr error_num
	    }
	}
	
	# data scadenza
        if {![string equal $data_scadenza ""]} {
            set data_scadenza [iter_check_date $data_scadenza]
            if {$data_scadenza == 0} {
                element::set_error $form_name data_scadenza "Data non corretta"
                incr error_num
            }
	}
	
	# data pag
        if {![string equal $data_pag ""]} {
            set data_pag [iter_check_date $data_pag]
            if {$data_pag == 0} {
                element::set_error $form_name data_pag "Data non corretta"
                incr error_num
            }
	}

	if {[string equal $f_manu_cogn ""]
	    &&  [string equal $f_manu_nome ""]
	} {
	    element::set_error $form_name f_manu_cogn "Inserire manutentore"
	    incr error_num
	}
	if {[string equal $f_manu_cogn ""]
	    && ![string equal $f_manu_nome ""]
	} {
	    element::set_error $form_name f_manu_cogn "Indicare anche il cognome"
	    incr error_num
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
	    
	    db_foreach sel_manu "" {
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
	
	if {[string equal $f_manu_cogn ""]
	    &&  [string equal $f_manu_nome ""]
	} {
	    set cod_manutentore ""
	} else {
	    set chk_inp_cod_manu $cod_manutentore
	    set chk_inp_cognome  $f_manu_cogn
	    set chk_inp_nome     $f_manu_nome
	    eval $check_cod_manu
	    set f_cod_manu  $chk_out_cod_manu
	    if {$chk_out_rc == 0} {
		element::set_error $form_name f_manu_cogn $chk_out_msg
		incr error_num
	    }
	}
	
	#controllo valorizzazioni matricola_da / matricola_a
	
	set sw_matricola_da_ok "t"	
        if {[string equal $matricola_da ""]} {
	    element::set_error $form_name matricola_da "Inserire matricola di inizio"
	    incr error_num
	    set sw_matricola_da_ok "f"
        } else {
          # se sono provincia di mantova obbligo a inserire un prefisso nella 
          # matricola, legato al tipo bollino selezionato C = comune; 
          # P = provincia
	    if  {$coimtgen(ente) eq "PMN"} {
		if {$cod_tpbo == "PR"
		&&  [string range $matricola_da 0 0] != "P"
		} {
		    element::set_error $form_name matricola_da "Il prefisso non &egrave; congruo con il tipo bollino, la matricola dovrebbe iniziare per P"
		    incr error_num		    
		    set sw_matricola_da_ok "f"
		}
		if {$cod_tpbo == "CM"
		&&  [string range $matricola_da 0 0] != "C"
		} {
		    element::set_error $form_name matricola_da "Il prefisso non &egrave; congruo con il tipo bollino, la matricola dovrebbe iniziare per C"
		    incr error_num		    
		    set sw_matricola_da_ok "f"
		}
	    }
	    set val_matricola_da [iter_get_val_stringa $matricola_da]
	    if {$val_matricola_da == ""} {
		set val_matricola_da 0
	    }
	}

	set sw_matricola_a_ok "t"
        if {[string equal $matricola_a ""]} {
	    element::set_error $form_name matricola_a "Inserire matricola di fine"
	    incr error_num
	    set sw_matricola_a_ok "f"
	} else {
          # se sono provincia di mantova obbligo a inserire un prefisso nella 
          # matricola, legato al tipo bollino selezionato C = comune; 
          # P = provincia
	    if  {$coimtgen(ente) eq "PMN"} {
		if {$cod_tpbo == "PR"
		&&  [string range $matricola_a 0 0] != "P"
		} {
		    element::set_error $form_name matricola_a "Il prefisso non &egrave; congruo con il tipo bollino, la matricola deve iniziare per P"
		    incr error_num
		    set sw_matricola_a_ok "f"
		}
		if {$cod_tpbo == "CM"
		&&  [string range $matricola_a 0 0] != "C"
		} {
		    element::set_error $form_name matricola_a "Il prefisso non &egrave; congruo con il tipo bollino, la matricola deve iniziare per C"
		    incr error_num
		    set sw_matricola_a_ok "f"
		}
	    }

	    set val_matricola_a [iter_get_val_stringa $matricola_a]
	    if {$val_matricola_a == ""} {
		set val_matricola_a 0
	    }
	}
        
        set sw_nr_bollini_ok "t"
        if {[string equal $nr_bollini ""]} {
            element::set_error $form_name nr_bollini "Inserire Nr bollini"
            incr error_num
            set sw_nr_bollini_ok "f"
        } else {
            set nr_bollini [iter_check_num $nr_bollini 0]
            if {$nr_bollini == "Error"} {
                element::set_error $form_name nr_bollini "Deve essere un numero intero"
                incr error_num
                set sw_nr_bollini_ok "f"
            } else {
                if {[iter_set_double $nr_bollini] >=  [expr pow(10,8)]
                ||  [iter_set_double $nr_bollini] <= -[expr pow(10,8)]} {
                    element::set_error $form_name nr_bollini "Deve essere inferiore di 100.000.000"
                    incr error_num
		    set sw_nr_bollini_ok "f"
                } else {
		    if {$sw_matricola_da_ok == "t"
		    &&  $sw_matricola_a_ok  == "t"
		    } {
			set nr_bol_da_matricola [expr $val_matricola_a - $val_matricola_da]
			set nr_bol_da_matricola [expr $nr_bol_da_matricola + 1]
			if {$nr_bol_da_matricola != $nr_bollini} {
			    element::set_error $form_name nr_bollini "Numero bollini errato in rapporto alle matricole inserite"
			    incr error_num
			    set sw_nr_bollini_ok "f"
			}
		    }
		}
            }
        }

	# se le matricole sono corrette ed il numero di bollini corrisponde
	# controllo che non vi siano dei blocchetti gia' rilasciati
	# nell'intervallo di matricole indicate.
	# per fare questo controllo (una between tra varchar) devo accertarmi
	# che le matricole di inizio e di fine abbiano la stessa lunghezza
	# altrimenti potrebbero mettermi 1 999 al posto di 0001 e 0999.

	# controllo non voluto da COMUNEPD/PRO/PLI
	if {   (   $flag_ente == "P"
                && (   $sigla_prov == "RO"
                    || $sigla_prov == "LI")
            || (   $flag_ente == "C"
                && $cod_comu == "8761")
	       )
	} {

	    if {$sw_matricola_da_ok == "t"
	    &&  $sw_matricola_a_ok  == "t"
	    &&  $sw_nr_bollini_ok   == "t"
	    } {
		if {[string length $matricola_da]
	        !=  [string length $matricola_a]
		} {
		    element::set_error $form_name matricola_da "Le due matricole devono avere la stessa lunghezza"
		    incr error_num
		    set sw_matricola_da_ok "f"
		    set sw_matricola_a_ok  "f"
		} else {
		    if  {$flag_ente !=  "P"
		    &&   $sigla_prov != "LI"} {
			if {$funzione == "I"} {
			    set and_cod_bollini ""
			} else {
			    set and_cod_bollini "and cod_bollini <> :cod_bollini"
			}
			set ctr_boll_sovrapposti [db_string sel_boll_count ""]
			if {$ctr_boll_sovrapposti > 0} {
			    # nel messaggio di errore indico anche l'ultima matricola
			    # rilasciata
			    if {![string equal $cod_tpbo ""]} {
				set where_cod_tpbo "where cod_tpbo = :cod_tpbo"
			    } else {
				set where_cod_tpbo "where cod_tpbo is null"
			    }
			    set max_matricola_a  [db_string sel_boll_max ""]
			    element::set_error $form_name matricola_da "Sono presenti bollini gi&agrave; rilasciati nell'intervallo di matricole inserito. L'ultima matricola rilasciata &egrave; $max_matricola_a"
			    incr error_num
			    set sw_matricola_da_ok "f"
			    set sw_matricola_a_ok  "f"
			}
		    }
		}
	    }
	}

	if {$coimtgen(ente) eq "CRIMINI"} {
	    if {$funzione == "I"} {
		set and_cod_bollini ""
	    } else {
		set and_cod_bollini "and cod_bollini <> :cod_bollini"
	    }
	    set ctr_boll_sovrapposti [db_string sel_boll_count ""]
	    if {$ctr_boll_sovrapposti > 0} {
		# nel messaggio di errore indico anche l'ultima matricola
		# rilasciata
		if {![string equal $cod_tpbo ""]} {
		    set where_cod_tpbo "where cod_tpbo = :cod_tpbo"
		} else {
		    set where_cod_tpbo "where cod_tpbo is null"
		}
		set max_matricola_a  [db_string sel_boll_max ""]
		element::set_error $form_name matricola_da "Sono presenti bollini gi&agrave; rilasciati nell'intervallo di matricole inserito. L'ultima matricola rilasciata &egrave; $max_matricola_a"
		incr error_num
		set sw_matricola_da_ok "f"
		set sw_matricola_a_ok  "f"
	    }
	}

	if {![string equal $nr_bollini_resi ""]} {
            set nr_bollini_resi [iter_check_num $nr_bollini_resi 0]
            if {$nr_bollini_resi == "Error"} {
                element::set_error $form_name nr_bollini_resi "Deve essere un numero intero"
                incr error_num
            } else {
                if {[iter_set_double $nr_bollini_resi] >=  [expr pow(10,8)]
                ||  [iter_set_double $nr_bollini_resi] <= -[expr pow(10,8)]} {
                    element::set_error $form_name nr_bollini_resi "Deve essere inferiore di 100.000.000"
                    incr error_num
                } else {
		    if {$sw_nr_bollini_ok == "t"
		    &&  $nr_bollini_resi   > $nr_bollini
		    } {
			element::set_error $form_name nr_bollini_resi "Deve essere < di nr bollini"
			incr error_num
		    }
		}
            }
        }

        set sw_costo_unitario_ok "t"
        if {![string equal $costo_unitario ""]} {
            set costo_unitario [iter_check_num $costo_unitario 2]
            if {$costo_unitario == "Error"} {
                element::set_error $form_name costo_unitario "costo unitario deve essere numerico e pu&ograve; avere al massimo 2 decimali"
                incr error_num
                set sw_costo_unitario_ok "f"
            } else {
                if {[iter_set_double $costo_unitario] >=  [expr pow(10,4)]
                ||  [iter_set_double $costo_unitario] <= -[expr pow(10,4)]} {
                    element::set_error $form_name costo_unitario "costo unitario deve essere inferiore di 10.000"
                    incr error_num
                    set sw_costo_unitario_ok "f"
                }
            }
        }    


	if {$coimtgen(ente) eq "CRIMINI"} {
	    if {$funzione == "I"
	    && ![string equal $costo_unitario ""] && $sw_costo_unitario_ok eq "t"
	    &&  [string equal $sw_nr_bollini_ok "t"]
	    } {
		set imp_pagato [expr $costo_unitario * $nr_bollini]
		set imp_pagato [iter_edit_num $imp_pagato 2]
	    }
        }

        if {![string equal $imp_pagato ""]} {
            set imp_pagato [iter_check_num $imp_pagato 2]
            if {$imp_pagato == "Error"} {
                element::set_error $form_name imp_pagato "Importo pagato deve essere numerico e pu&ograve; avere al massimo 2 decimali"
                incr error_num
            } else {
                if {[iter_set_double $imp_pagato] >=  [expr pow(10,8)]
	        ||  [iter_set_double $imp_pagato] <= -[expr pow(10,8)]} {
                    element::set_error $form_name imp_pagato "Importo pagato deve essere inferiore di 100.000.000"
                    incr error_num
                }
            }
        }
	
        if {![string equal $imp_sconto ""]} {
            set imp_sconto [iter_check_num $imp_sconto 2]
            if {$imp_sconto == "Error"} {
                element::set_error $form_name imp_sconto "Lo sconto deve essere numerico e pu&ograve; avere al massimo 2 dec\
imali"
                incr error_num
            } else {
                if {[iter_set_double $imp_sconto] >=  [expr pow(10,8)]
		    ||  [iter_set_double $imp_sconto] <= -[expr pow(10,8)]} {
                    element::set_error $form_name imp_sconto "Lo sconto deve essere inferiore di 100.000.000"
                    incr error_num
                } else {
                    if {[string equal $note ""]} {
                        set note "Sconto per autocertificazioni inserite"
                    }
                }
            }
        }

	if {$funzione == "I"} {
	    if {[string equal $cod_manutentore ""]} {
		element::set_error $form_name f_manu_cogn "Inserire il manutentore"
		incr error_num
	    }
	}
    }

    if {$funzione == "I"} {
         set wheremod ""
    } else {
         set wheremod "and cod_bollini<> :cod_bollini"
    }


    db_0or1row sel_dimp ""
    if {$funzione == "D"} {

	if { $conta_dimp > 0 } {
	    element::set_error $form_name note "Il riferimento bollino &egrave; presente su delle dichiarazioni"
	    incr error_num
	} else {
	    if {$pagati == "S"} {
		element::set_error $form_name note "Il bollino &egrave; gi&agrave; stato pagato"
		incr error_num
	    } else {
		if {![string equal $imp_pagato ""]} {
		    element::set_error $form_name note "Il bollino &egrave; gi&agrave; stato pagato"
		    incr error_num
		}
	    }
	}
    }

    if {$error_num > 0} {
        ad_return_template
        return
    }

    switch $funzione {
        I {db_1row sel_dual_boll ""
           set dml_sql [db_map ins_boll]}
        M {set dml_sql [db_map upd_boll]}
        D {set dml_sql [db_map del_boll]}
    }

  # Lancio la query di manipolazione dati contenute in dml_sql
    if {[info exists dml_sql]} {
        with_catch error_msg {
            db_transaction {
                db_dml dml_coimboll $dml_sql
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
        set last_order [list  $data_consegna $cod_bollini]
    }

    if {$nome_funz == "boll-ins"} {
	set link_ritorna "coimboll-gest?funzione=I&[export_url_vars nome_funz]"
    } else {
	set link_list    [subst $link_list_script]
	set link_ritorna "coimboll-list?$link_list"
    }

    set link_gest      [export_url_vars cod_bollini last_order nome_funz extra_par caller nome_funz_caller cod_manutentore flag_attivo]


    switch $funzione {
        M {set return_url   "coimboll-gest?funzione=V&$link_gest"}
        D {set return_url   $link_ritorna}
        I {set return_url   "coimboll-gest?funzione=V&$link_gest"}
        V {set return_url   $link_ritorna}
    }

    ad_returnredirect $return_url
    ad_script_abort
}

ad_return_template
