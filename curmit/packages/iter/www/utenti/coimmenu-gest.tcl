ad_page_contract {
    Add/Edit/Delete  form per la tabella "coimmenu"
    @author          Adhoc
    @creation-date   18/05/2004

    @param funzione  I=insert M=edit D=delete V=view

    @param caller    caller della lista da restituire alla lista:
    @                serve se lista e' uno zoom che permetti aggiungi.

    @param nome_funz identifica l'entrata di menu, server per le autorizzazioni
    @                serve se lista e' uno zoom che permetti aggiungi.

    @param nome_funz_caller identifica l'entrata di menu, serve per la 
                     navigazione con navigation bar

    @param extra_par Variabili extra da restituire alla lista

    @cvs-id          coimmenu-gest.tcl

    USER  DATA       MODIFICHE
    ===== ========== =======================================================================
    nic01 21/05/2014 Aggiunto flush della cache in modo da rinfrescare il menù dinamico
    nic01            dopo aver inserito, modificato o cancellato un menù.
    nic01            Aggiungo anche il link "cancella cache del menù dinamico" in modo da
    nic01            permettere di farlo manualmente se si fanno insert o update a mano:
    nic01            aggiungo la funzione "C" di "Cancella cache del menù dinamico".
} {
    
   {nome_menu ""}
   {last_nome_menu ""}
   {funzione  "V"}
   {caller    "index"}
   {nome_funz ""}
   {nome_funz_caller ""}
   {extra_par ""}
   {messaggio ""}
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
    "C" {set lvl 3}
}

set id_utente [lindex [iter_check_login $lvl $nome_funz] 1]
set link_gest [export_url_vars nome_menu last_nome_menu nome_funz nome_funz_caller extra_par caller]

if {$funzione eq "C"} {#nic01
    ns_cache_flush dynamic_menu_cache;#nic01

    set messaggio     "Cache cancellata";#nic01
    set url_messaggio [export_url_vars messaggio];#nic01
    ad_returnredirect "coimmenu-gest?funzione=V&$url_messaggio&$link_gest";#nic01
    ad_script_abort;#nic01
};#nic01

# imposta le class css della barra delle funzioni
iter_set_func_class $funzione

# controllo il parametro di "propagazione" per la navigation bar
if {[string is space $nome_funz_caller]} {
    set nome_funz_caller $nome_funz
}


# Personalizzo la pagina
# TODO: controllare impostazione della context_bar adattando come necessario
set link_list_script {[export_url_vars last_nome_menu caller nome_funz_caller nome_funz]&[iter_set_url_vars $extra_par]}
set link_list        [subst $link_list_script]
set titolo           "Men&ugrave;"
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

multirow create multiple_indici indice

db_foreach sel_ogge "" {
   # creo una lista guida contente gli indici
    set     indice      "$livell.$scelt_1.$scelt_2.$scelt_3.$scelt_4"
    lappend list_indici  $indice
    if {$indice != "2.18.11.0.0"
    &&  $indice != "2.18.12.0.0"
    } {
	multirow append multiple_indici $indice	
    }

  # memorizzo in un array i dati che mi possono servire piu' avanti
    switch $livell {
        "1" {set spazi  ""
	     set spazi2 ""
	}
        "2" {set spazi  "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
	     set spazi2 "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
	}
        "3" {set spazi  "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
	     set spazi2 "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp"
	}
        "4" {set spazi "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
	    set spazi2 "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
	}
    }
    
    if {$tip == "menu"} {
	set descr "<b>$descr</b>"
    }
    set spazzi($indice)            $spazi2
    set descrizione($indice)      "$spazi $descr"
    set tipo($indice)             $tip
    set lev($indice)              $liv
    set seq($indice)              $seque
    set livello($indice)          $livell
    set scelta_1($indice)         $scelt_1
    set scelta_2($indice)         $scelt_2
    set scelta_3($indice)         $scelt_3
    set scelta_4($indice)         $scelt_4
    if {[exists_and_not_null nom_menu]} {
	set checked($indice) "checked"
    } else {
	set checked($indice) "{}"
    }
} if_no_rows {
    iter_return_complaint "Tabella oggetti non popolata"
}

# sproteggo la chiave solo in inserimento e gli attributi in inserimento e mod.
set form_name    "coimmenu"
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

element create $form_name nome_menu \
-label   "nome_menu" \
-widget   text \
-datatype text \
-html    "size 20 maxlength 20 $readonly_key {} class form_element" \
-optional

foreach indice $list_indici {

    if {$indice != "1.18.0.0.0"} {
        element create $form_name check.$indice \
        -label   "check" \
        -widget   checkbox \
        -datatype text \
        -html "$disabled_fld {} class form_element value T $checked($indice) {}" \
        -optional
    } else {
	element create $form_name check.$indice  -widget hidden -datatype text -optional
    }

    if {$tipo($indice) != "menu"} {
	element create $form_name lev.$indice \
        -label   "lev" \
        -widget   text \
        -datatype text \
        -html    "size 2 maxlength 1 $readonly_fld {} class form_element" \
        -optional
    } else {
	 element create $form_name lev.$indice -widget hidden -datatype text -optional
    }

    if {[string range $indice 2 3] != 18} {
        element create $form_name seq.$indice \
        -label   "seq" \
        -widget   text \
        -datatype text \
        -html    "size 2 maxlength 2 $readonly_fld {} class form_element" \
        -optional
    } else {
	element create $form_name seq.$indice -widget hidden -datatype text -optional
    }
}

element create $form_name funzione  -widget hidden -datatype text -optional
element create $form_name caller    -widget hidden -datatype text -optional
element create $form_name nome_funz -widget hidden -datatype text -optional
element create $form_name extra_par -widget hidden -datatype text -optional
element create $form_name submit    -widget submit -datatype text -label "$button_label" -html "class form_submit"
element create $form_name last_nome_menu -widget hidden -datatype text -optional

if {[form is_request $form_name]} {

    element set_properties $form_name funzione  -value $funzione
    element set_properties $form_name caller    -value $caller
    element set_properties $form_name nome_funz -value $nome_funz
    element set_properties $form_name extra_par -value $extra_par
    element set_properties $form_name last_nome_menu -value $last_nome_menu

    if {$funzione == "I"} {
        
    } else {
      # leggo riga

	element set_properties $form_name nome_menu -value $nome_menu
        foreach indice $list_indici {
	    element set_properties $form_name lev.$indice -value $lev($indice)
	    element set_properties $form_name seq.$indice -value $seq($indice)
	}
    }
}

if {[form is_valid $form_name]} {
  # form valido dal punto di vista del templating system
    set nome_menu [element::get_value $form_name nome_menu]
    set error_num 0
    if {$funzione == "I"
    ||  $funzione == "M"
    } {
        if {[string equal $nome_menu ""]} {
            element::set_error $form_name nome_menu "Inserire il Nome men&ugrave;"
            incr error_num
        }
    }

    foreach indice $list_indici {
	set lev($indice)      [element::get_value $form_name lev.$indice]
	set seq($indice)      [element::get_value $form_name seq.$indice]
	set check($indice)    [element::get_value $form_name check.$indice]
	if {$indice == "2.18.11.0.0"
	||  $indice == "2.18.12.0.0"
	} {
	    set check($indice) "T"
            set lev($indice) 4
	}
	# controlli standard su numeri e date, per Ins ed Upd

	if {$funzione == "I"
	||  $funzione == "M"
        } {

	    if {![string equal $lev($indice) ""]} {
		set lev($indice) [iter_check_num $lev($indice) 0]
		if {$lev($indice) == "Error"} {
		    element::set_error $form_name lev.$indice "Deve essere un numero intero"
		    incr error_num
		} else {
		    if {[iter_set_double $lev($indice)] >=  [expr pow(10,2)]
		    ||  [iter_set_double $lev($indice)] <= -[expr pow(10,2)]} {
			element::set_error $form_name lev.$indice "Deve essere inferiore di 10"
			incr error_num
		    }
		}
	    }
	    
	    if {![string equal $seq($indice) ""]} {
		set seq($indice) [iter_check_num $seq($indice) 0]
		if {$seq($indice) == "Error"} {
		    element::set_error $form_name seq.$indice "Deve essere un numero intero"
		    incr error_num
		} else {
		    if {[iter_set_double $seq($indice)] >=  [expr pow(10,2)]
		    ||  [iter_set_double $seq($indice)] <= -[expr pow(10,2)]} {
			element::set_error $form_name seq.$indice "Deve essere inferiore di 100"
			incr error_num
		    }
		}
	    }
	}
    }

    if {$funzione == "I"
    &&  $error_num == 0
    &&  [db_0or1row sel_menu_check {}] == 1
    } {
      # controllo univocita'/protezione da double_click
        element::set_error $form_name nome_menu "Il record che stai tentando di inserire &egrave; gi&agrave; esistente nel Data Base."
        incr error_num
    }

    if {$error_num > 0} {
        ad_return_template
        return
    }

    set dml_ins [db_map ins_menu]
    set dml_del [db_map del_menu]
    

  # Lancio la query di manipolazione dati contenute in dml_sql
    if {[info exists dml_ins]
    &&  [info exists dml_del]
    } {
        with_catch error_msg {
            db_transaction {
		if {$funzione == "D"
                ||  $funzione == "M"
		} {
		    db_dml dml_coimmenu $dml_del
		}
		if {$funzione == "I"
                ||  $funzione == "M"
		} {
		    foreach indice $list_indici {
			if {$check($indice) == "T"} {
			    set ind [split $indice "."]
			    set livel     [lindex $ind 0]
			    set scelta1   [lindex $ind 1]
			    set scelta2   [lindex $ind 2]
			    set scelta3   [lindex $ind 3]
			    set scelta4   [lindex $ind 4]
			    set lvl       $lev($indice)
			    set seque     $seq($indice)

			    db_dml dml_coimmenu $dml_ins
			}
		    }
		}

            }

	    ns_cache_flush dynamic_menu_cache;#nic01

        } {
            iter_return_complaint "Spiacente, ma il DBMS ha restituito il
            seguente messaggio di errore <br><b>$error_msg</b><br>
            Contattare amministratore di sistema e comunicare il messaggio
            d'errore. Grazie."
 	}
    }

  # dopo l'inserimento posiziono la lista sul record inserito
    if {$funzione == "I"} {
        set last_nome_menu $nome_menu
    }
    set link_list      [subst $link_list_script]
    set link_gest      [export_url_vars nome_menu last_nome_menu nome_funz nome_funz_caller extra_par caller]
    switch $funzione {
        M {set return_url   "coimmenu-gest?funzione=V&$link_gest"}
        D {set return_url   "coimmenu-list?$link_list"}
        I {set return_url   "coimmenu-gest?funzione=V&$link_gest"}
        V {set return_url   "coimmenu-list?$link_list"}
    }

    ad_returnredirect $return_url
    ad_script_abort
}

ad_return_template
