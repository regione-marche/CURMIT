ad_page_contract {
    Add/Edit/Delete  form per la tabella "coimrelt"
    @author          Giulio Laurenzi
    @creation-date   16/03/2005

    @param funzione  I=insert M=edit D=delete V=view
    @param caller    caller della lista da restituire alla lista:
                     serve se lista e' uno zoom che permetti aggiungi.
    @param nome_funz identifica l'entrata di menu, server per le autorizzazioni
                     serve se lista e' uno zoom che permetti aggiungi.
    @param nome_funz_caller identifica l'entrata di menu, serve per la 
                     navigazione con navigation bar
    @param extra_par Variabili extra da restituire alla lista
    @cvs-id          coimrelt-gest-gest.tcl
} {
    
   {funzione        "V"}
   {caller      "index"}
   {nome_funz        ""}
   {nome_funz_caller ""}
   {extra_par        ""}
   {cod_relg         ""}
   {cod_relt         ""}
   {last_sezione     ""}
   {last_id_clsnc    ""}
   {last_id_stclsnc  ""}
   {last_obj_refer   ""}
   {last_id_pot      ""}
   {last_id_per      ""}
   {last_id_comb     ""}
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
set link_gest [export_url_vars cod_relg cod_relt last_sezione last_id_clsnc last_id_stclsnc last_obj_refer last_id_pot last_id_per last_id_comb nome_funz nome_funz_caller extra_par caller]
# imposta le class css della barra delle funzioni
iter_set_func_class $funzione

# controllo il parametro di "propagazione" per la navigation bar
if {[string is space $nome_funz_caller]} {
    set nome_funz_caller $nome_funz
}

# Personalizzo la pagina
set link_list_script {[export_url_vars cod_relg last_sezione last_id_clsnc last_id_stclsnc last_obj_refer last_id_pot last_id_per last_id_comb caller nome_funz_caller nome_funz]&[iter_set_url_vars $extra_par]}
set link_list        [subst $link_list_script]
set titolo           "Scheda tecnica"
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

# imposto le liste per la decodifica dei codici

set     lista_clsnc   [list ""   ""]
lappend lista_clsnc   [list "8a" [list 1 1]]
lappend lista_clsnc   [list "8b" [list 1 2]]
lappend lista_clsnc   [list "8c" [list 1 3]]
lappend lista_clsnc   [list "8d" [list 1 4]]

# per le classi A, C, D reperisco le non conformita' dalla
# rispettiva tabella:
db_foreach sel_tano "" {
    
    set pre_cod_nc [string range    $cod_tano   0 0]
    set suf_cod_nc [string range    $cod_tano   1 end]
    set suf_cod_nc [string trimleft $suf_cod_nc 0]
    set id_clsnc   ""
    set id_stclsnc ""
    switch $pre_cod_nc {
	"A" {
	    if {[string is integer $suf_cod_nc]} {
		if {$suf_cod_nc >= 1
		&&  $suf_cod_nc <= 18
		} {
		    # qui finiscono le A1,... A18.
		    set id_clsnc   2
		    set id_stclsnc $suf_cod_nc

		} else {
		    # volutamente le A19, 20 ... della provincia di
		    # mantova le catalogo come D1, ..., D5.
		    # ma le visualizzo come A19, 20...
		    set id_clsnc   4
		    set id_stclsnc [expr $suf_cod_nc - 18]
		}
	    } else {
		# se suf_cod_nc non e' numerico, e' un caso
		# non contemplato
		set id_clsnc   4
		set id_stclsnc 99
		set cod_tano  "D99"
	    }
	}
	"C" {
	    # stesso ragionamento delle a per le c > 14.
	    if {[string is integer $suf_cod_nc]} {
		if {$suf_cod_nc >= 1
		&&  $suf_cod_nc <= 14
		} {
		    # qui finiscono le C1,... C14.
		    set id_clsnc   3
		    set id_stclsnc $suf_cod_nc
		} else {
		    # volutamente le C15, 16 ... della provincia di
		    # mantova le catalogo come D15, D16, ....
		    set id_clsnc   4
		    set id_stclsnc $suf_cod_nc
		}
	    } else {
		# se suf_cod_nc non e' numerico, e' un caso
		# non contemplato: altri
		set id_clsnc   4
		set id_stclsnc 99
		set cod_tano  "D99"
	    }
	}
	default {
	    # caso non contemplato: altri
	    set id_clsnc   4
	    set id_stclsnc 99
	    set cod_tano  "D99"
	}
    }

    # popola la lista non conformita
    lappend lista_clsnc [list $cod_tano [list $id_clsnc $id_stclsnc]]

};#fine db_foreach sulla coimtano

lappend lista_clsnc [list "Totale verificati"   [list 5 1]]
# la 5, 2 non e' modificabile perche' c'e' solo la sezione C e non V.
# lappend lista_clsnc [list "Totale autodichiarati" "52"]
lappend lista_clsnc [list "Totale non conformi" [list 5 3]]
lappend lista_clsnc [list "Totale conformi"     [list 5 4]]

set     lista_obj_refer [list ""           ""]
lappend lista_obj_refer [list "Impianti"   "I"]
lappend lista_obj_refer [list "Generatori" "G"]

set     lista_id_comb [list ""             ""]
lappend lista_id_comb [list "Gas naturale" "1"]
lappend lista_id_comb [list "Gpl"          "2"]
lappend lista_id_comb [list "Gasolio"      "3"]
lappend lista_id_comb [list "Altro"        "5"]

set     lista_id_pot  [list ""                  ""]
lappend lista_id_pot  [list "inferiore a 35 kW" "1"]
lappend lista_id_pot  [list "da 35 a 116 kW"    "2"]
lappend lista_id_pot  [list "da 116 a 350 kW"   "3"]
lappend lista_id_pot  [list "oltre 350 kW"      "4"]

set     lista_id_per  [list ""                  ""]
lappend lista_id_per  [list "prima del 1990"    "1"]
lappend lista_id_per  [list "dal 1990 al 2000"  "2"]
lappend lista_id_per  [list "oltre il 2000"     "3"]


# sproteggo la chiave solo in inserimento e gli attributi in inserimento e mod.
set form_name    "coimrelt_gest"
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

element create $form_name des_sezione \
-label   "sezione" \
-widget   text \
-datatype text \
-html    "size 15 readonly {} class form_element" \
-optional

element create $form_name sezione -widget hidden -datatype text -optional

if {$funzione != "I"} {
    element create $form_name des_clsnc \
    -label   "descrizione" \
    -widget   text \
    -datatype text \
    -html    "size 20 readonly {} class form_element" \
    -optional

    element create $form_name id_clsnc -widget hidden -datatype text -optional

    element create $form_name des_obj_refer \
    -label   "obj_refer" \
    -widget   text \
    -datatype text \
    -html    "size 10 readonly {} class form_element" \
    -optional

    element create $form_name obj_refer -widget hidden -datatype text -optional

    element create $form_name des_pot \
    -label   "id_pot" \
    -widget   text \
    -datatype text \
    -html    "size 35 readonly {} class form_element" \
    -optional

    element create $form_name id_pot -widget hidden -datatype text -optional

    element create $form_name des_per \
    -label   "id_per" \
    -widget   text \
    -datatype text \
    -html    "size 20 readonly {} class form_element" \
    -optional

    element create $form_name id_per -widget hidden -datatype text -optional

    element create $form_name des_comb \
    -label   "id_comb" \
    -widget   text \
    -datatype text \
    -html    "size 15 readonly {} class form_element" \
    -optional

    element create $form_name id_comb -widget hidden -datatype text -optional

} else {
    element create $form_name id_clsnc \
    -label   "descrizione" \
    -widget   select \
    -datatype text \
    -html    "$disabled_fld {} class form_element" \
    -optional \
    -options $lista_clsnc

    element create $form_name obj_refer \
    -label   "obj_refer" \
    -widget   select \
    -datatype text \
    -html    "$disabled_fld {} class form_element" \
    -optional \
    -options $lista_obj_refer

    element create $form_name id_pot \
    -label   "id_pot" \
    -widget   select \
    -datatype text \
    -html    "$disabled_fld {} class form_element" \
    -optional \
    -options $lista_id_pot

    element create $form_name id_per \
    -label   "id_per" \
    -widget   select \
    -datatype text \
    -html    "$disabled_fld {} class form_element" \
    -optional \
    -options $lista_id_per

    element create $form_name id_comb \
    -label   "id_comb" \
    -widget   select \
    -datatype text \
    -html    "$disabled_fld {} class form_element" \
    -optional \
    -options $lista_id_comb
}

element create $form_name n \
-label   "n" \
-widget   text \
-datatype text \
-html    "size 7 maxlength 7 $readonly_fld {} class form_element" \
-optional

element create $form_name cod_relg   -widget hidden -datatype text -optional
element create $form_name cod_relt   -widget hidden -datatype text -optional
element create $form_name funzione   -widget hidden -datatype text -optional
element create $form_name caller     -widget hidden -datatype text -optional
element create $form_name nome_funz  -widget hidden -datatype text -optional
element create $form_name nome_funz_caller -widget hidden -datatype text -optional
element create $form_name extra_par -widget hidden -datatype text -optional
element create $form_name submit    -widget submit -datatype text -label "$button_label" -html "class form_submit"

element create $form_name last_sezione  -widget hidden -datatype text -optional
element create $form_name last_id_clsnc -widget hidden -datatype text -optional
element create $form_name last_id_stclsnc -widget hidden -datatype text -optional
element create $form_name last_obj_refer  -widget hidden -datatype text -optional
element create $form_name last_id_pot   -widget hidden -datatype text -optional
element create $form_name last_id_per   -widget hidden -datatype text -optional
element create $form_name last_id_comb  -widget hidden -datatype text -optional

if {[form is_request $form_name]} {
    element set_properties $form_name cod_relg         -value $cod_relg
    element set_properties $form_name cod_relt         -value $cod_relt
    element set_properties $form_name funzione         -value $funzione
    element set_properties $form_name caller           -value $caller
    element set_properties $form_name nome_funz        -value $nome_funz
    element set_properties $form_name nome_funz_caller -value $nome_funz_caller
    element set_properties $form_name extra_par        -value $extra_par
    element set_properties $form_name last_sezione     -value $last_sezione
    element set_properties $form_name last_id_clsnc    -value $last_id_clsnc
    element set_properties $form_name last_id_stclsnc  -value $last_id_stclsnc
    element set_properties $form_name last_obj_refer   -value $last_obj_refer
    element set_properties $form_name last_id_pot      -value $last_id_pot
    element set_properties $form_name last_id_per      -value $last_id_per
    element set_properties $form_name last_id_comb     -value $last_id_comb

    if {$funzione == "I"} {
        element set_properties $form_name sezione      -value "V"
        element set_properties $form_name des_sezione  -value "Verifiche" 
       
    } else {
      # leggo riga

        if {[db_0or1row sel_relt {}] == 0} {
            iter_return_complaint "Record non trovato"
	}

	if {$sezione == "V"} {
	    element set_properties $form_name des_sezione -value "Verifiche"
	} else {
	    iter_return_complaint "Le consuntivazioni sono sempre ottenute conteggiando i record della sezione Verifiche. Quindi solo questi ultimi si possono gestire."
	}

        element set_properties $form_name cod_relt   -value $cod_relt
        element set_properties $form_name sezione    -value $sezione
        element set_properties $form_name id_clsnc   -value [list $id_clsnc $id_stclsnc]
        element set_properties $form_name obj_refer  -value $obj_refer
        element set_properties $form_name id_pot     -value $id_pot
        element set_properties $form_name id_per     -value $id_per
        element set_properties $form_name id_comb    -value $id_comb
        element set_properties $form_name n          -value $n

	# decodifico i codici
	foreach elemento $lista_clsnc {
	    set clsnc_ls   [lindex $elemento 1]
	    if {$clsnc_ls == [list $id_clsnc $id_stclsnc]} {
		element set_properties $form_name des_clsnc   -value [lindex $elemento 0]
		break
	    }
	}

	foreach elemento $lista_obj_refer {
	    set obj_refer_ls [lindex $elemento 1]
	    if {$obj_refer_ls == $obj_refer} {
		element set_properties $form_name des_obj_refer -value [lindex $elemento 0]
		break
	    }
	}

	foreach elemento $lista_id_pot {
	    set id_pot_ls [lindex $elemento 1]
	    if {$id_pot_ls == $id_pot} {
		element set_properties $form_name des_pot     -value [lindex $elemento 0]
		break
	    }
	}

	foreach elemento $lista_id_per {
	    set id_per_ls [lindex $elemento 1]
	    if {$id_per_ls == $id_per} {
		element set_properties $form_name des_per     -value [lindex $elemento 0]
		break
	    }
	}

	foreach elemento $lista_id_comb {
	    set id_comb_ls [lindex $elemento 1]
	    if {$id_comb_ls == $id_comb} {
		element set_properties $form_name des_comb    -value [lindex $elemento 0]
	    }
	}
    }
}

if {[form is_valid $form_name]} {

  # form valido dal punto di vista del templating system

    set cod_relg   [element::get_value $form_name cod_relg]
    set cod_relt   [element::get_value $form_name cod_relt]
    set sezione    [element::get_value $form_name sezione]
    set id_clsnc   [element::get_value $form_name id_clsnc]
    set obj_refer  [element::get_value $form_name obj_refer]
    set id_pot     [element::get_value $form_name id_pot]
    set id_per     [element::get_value $form_name id_per]
    set id_comb    [element::get_value $form_name id_comb]
    set n          [element::get_value $form_name n]

    set id_clsnc_input $id_clsnc
    set id_clsnc       [lindex $id_clsnc_input 0]
    set id_stclsnc     [lindex $id_clsnc_input 1]

  # controlli standard su numeri e date, per Ins ed Upd
    set error_num 0
    if {$funzione == "I"} {

        if {[string equal $id_clsnc ""]} {
            element::set_error $form_name id_clsnc "Inserire la descrizione"
            incr error_num
        }

        if {[string equal $obj_refer ""]} {
            element::set_error $form_name obj_refer "Inserire l'oggetto"
            incr error_num
        }

        if {[string equal $id_pot ""]} {
            element::set_error $form_name id_pot "Inserire la potenza"
            incr error_num
        }

        if {[string equal $id_per ""]} {
            element::set_error $form_name id_per "Inserire il periodo"
            incr error_num
        }

        if {[string equal $id_comb ""]} {
            element::set_error $form_name id_comb "Inserire il combustibile"
            incr error_num
        }
    }

    if {$funzione == "I"
    ||  $funzione == "M"
    } {
        if {[string equal $n ""]} {
	    element::set_error $form_name n "Inserire numero"
	    incr error_num
	} else {
            set n [iter_check_num $n 0]
            if {$n == "Error"} {
                element::set_error $form_name n "Il numero deve essere un numero intero"
                incr error_num
            } else {
                if {[iter_set_double $n] >=  [expr pow(10,6)]
                ||  [iter_set_double $n] <= -[expr pow(10,6)]} {
                    element::set_error $form_name n "Il numero deve essere inferiore di 1.000.000"
                    incr error_num
                }
            }
        }
    }

    if {$funzione  == "I"
    &&  $error_num == 0
    &&  [db_0or1row sel_relt_check {}] == 1
    } {
      # controllo univocita'/protezione da double_click
        element::set_error $form_name des_sezione "Il record che stai tentando di inserire &egrave; gi&agrave; esistente nel Data Base."
        incr error_num
    }

    if {$error_num > 0} {
        ad_return_template
        return
    }

    switch $funzione {
        I {set dml_sql [db_map ins_relt]}
        M {set dml_sql [db_map upd_relt]}
        D {set dml_sql [db_map del_relt]}
    }

  # Lancio la query di manipolazione dati contenute in dml_sql
    if {[info exists dml_sql]} {
        with_catch error_msg {
            db_transaction {
		if {$funzione == "I"} {
		    # in inserimento reperisco cod_relt
		    set cod_relt [db_string sel_relt_cod ""]

		    # e posiziono subito la lista sul record inserito
		    set last_sezione    $sezione
		    set last_id_clsnc   $id_clsnc
		    set last_id_stclsnc $id_stclsnc
		    set last_obj_refer  $obj_refer
		    set last_id_pot     $id_pot
		    set last_id_per     $id_per
		    set last_id_comb    $id_comb

		    set link_list      [subst $link_list_script]
		    set link_gest      [export_url_vars cod_relt cod_relg sezione last_sezione last_id_clsnc last_id_stclsnc last_obj_refer last_id_pot last_id_per last_id_comb nome_funz nome_funz_caller extra_par caller]
		}

		# lancio la query di manipolazione dati
		db_dml dml_coimrelt $dml_sql

		# dopo ogni operazione sul record di dettaglio
		# ricalcolo il record della sezione consuntivazione
		# non lo ricreo solo se il totale e' zero e la classe <> 5.

		set n [db_string sel_relt_sum ""]

		set sezione  "C"
		set id_pot    9
		set id_per    9
		set id_comb   9
		db_dml del_relt_cons ""

		if {$id_clsnc == 5
		||  $n > 0
		} {
		    # reperisco cod_relt e valorizzo i campi chiave di cons.
		    set cod_relt [db_string sel_relt_cod ""]
		    db_dml ins_relt ""
		}
            }
        } {
            iter_return_complaint "Spiacente, ma il DBMS ha restituito il
            seguente messaggio di errore <br><b>$error_msg</b><br>
            Contattare amministratore di sistema e comunicare il messaggio
            d'errore. Grazie."
 	}
    }

    switch $funzione {
        M {set return_url   "coimrelt-gest?funzione=V&$link_gest"}
        D {set return_url   "coimrelt-list?$link_list"}
        I {set return_url   "coimrelt-gest?funzione=V&$link_gest"}
        V {set return_url   "coimrelt-list?$link_list"}
    }

    ad_returnredirect $return_url
    ad_script_abort
}

ad_return_template
