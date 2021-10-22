ad_page_contract {g
    Add/Edit/Delete         Form per la ricerca di impianti di cui stampare l'etichetta
    @author                 Gianni Prosperi Adhoc
    @creation-date          20/03/2007
    
    @param funzione         I=insert E=edit D=delete V=view
    @param caller           caller della lista da restituire alla lista:
    serve se lista e' uno zoom che permetti aggiungi.
    @param nome_funz        identifica l'entrata di menu, server per le autorizzazioni
    serve se lista e' uno zoom che permetti aggiungi.
    @param nome_funz_caller identifica l'entrata di menu, serve per la 
    navigazione con navigation bar
    @param extra_par        Variabili extra da restituire alla lista
    @cvs-id                 coimstpm-targ-filter.tcl
} {
    {funzione         ""}
    {caller           "index"}
    {nome_funz        ""}
    {nome_funz_caller ""}
    {f_cod_via        ""}
    {f_comune         ""}
    {f_quartiere      ""}
    {f_desc_via       ""}
    {f_desc_topo      ""}

    {f_manu_cogn      ""}
    {f_manu_nome      ""}
} -properties {
    page_title:onevalue
    context_bar:onevalue
    form_name:onevalue
}


set lvl 1
# Controlla lo user
set id_utente [lindex [iter_check_login $lvl $nome_funz] 1]

# imposta le class css della barra delle funzioni
iter_set_func_class $funzione

# controllo il parametro di "propagazione" per la navigation bar
if {[string is space $nome_funz_caller]} {
    set nome_funz_caller $nome_funz
}

# controllo se l'utente è un manutentore
set cod_manutentore [iter_check_uten_manu $id_utente]

iter_get_coimtgen
set flag_ente $coimtgen(flag_ente)
set flag_viario $coimtgen(flag_viario)
set cod_comune $coimtgen(cod_comu)

# Personalizzo la pagina
set titolo           "Stampa Targatura Impianto - Ricerca Impianto"
set page_title       "Stampa Targatura Impianto - Ricerca Impianto"
set button_label     "Cerca"

set context_bar  [iter_context_bar -nome_funz $nome_funz_caller]

# sproteggo la chiave solo in inserimento e gli attributi in inserimento e mod.
set form_name    "coimstpm_targ_filter"
set readonly_key \{\}
set readonly_fld \{\}
set disabled_fld \{\}
set onsubmit_cmd ""

form create $form_name \
    -html    $onsubmit_cmd

if {$flag_ente == "P"} {
    element create $form_name f_comune \
	-label   "Comune" \
	-widget   select \
    -datatype text \
	-html    "$readonly_fld {} class form_element tabindex 4" \
	-optional \
	-options [iter_selbox_from_comu]
} else {
    element create $form_name f_comune -widget hidden -datatype text -optional
    element create $form_name f_quartiere \
	-label   "Quartiere" \
	-widget   select \
	-datatype text \
	-html    "$readonly_fld {} class form_element tabindex 4" \
	-optional \
	-options [iter_selbox_from_table coimcqua cod_qua descrizione]
}

element create $form_name f_desc_topo \
    -label   "topos" \
    -widget   select \
    -datatype text \
    -html    "$readonly_fld {} class form_element tabindex 5" \
    -optional \
-options [iter_selbox_from_table coimtopo descr_topo descr_topo]

element create $form_name f_desc_via \
    -label   "Via" \
    -widget   text \
-datatype text \
    -html    "size 20 maxlength 40 $readonly_fld {} class form_element tabindex 6" \
    -optional


if {$flag_viario == "T"} {
    set cerca_viae [iter_search $form_name [ad_conn package_url]/tabgen/coimviae-filter [list dummy f_cod_via dummy f_desc_via dummy f_desc_topo cod_comune f_comune dummy dummy]]
    regsub {<a href} $cerca_viae {<a tabindex=7 href} cerca_viae
} else {
    set cerca_viae ""
}

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

if {[string equal $cod_manutentore ""]} {
    set sw_manu "f"
    set readonly_fld2 \{\}
    set cerca_manu [iter_search $form_name coimmanu-list [list dummy f_cod_manu dummy f_manu_cogn dummy f_manu_nome]]
} else {
    set sw_manu "t"
    set readonly_fld2 "readonly"
    set cerca_manu ""
}

element create $form_name f_manu_cogn \
    -label   "Cognome" \
    -widget   text \
    -datatype text \
    -html    "size 20 maxlength 200 $readonly_fld2 {} class form_element" \
    -optional

element create $form_name f_manu_nome \
    -label   "Nome" \
    -widget   text \
    -datatype text \
    -html    "size 20 maxlength 200 $readonly_fld2 {} class form_element"\
    -optional



element create $form_name funzione         -widget hidden -datatype text -optional
element create $form_name caller           -widget hidden -datatype text -optional
element create $form_name f_cod_via        -widget hidden -datatype text -optional
element create $form_name f_cod_manu       -widget hidden -datatype text -optional
element create $form_name nome_funz        -widget hidden -datatype text -optional
element create $form_name nome_funz_caller -widget hidden -datatype text -optional
element create $form_name dummy            -widget hidden -datatype text -optional
element create $form_name submit           -widget submit -datatype text -label "$button_label" -html "class form_submit"



if {[form is_request $form_name]} {
    # solo se l'utente e' un manutentore valorizzo il relativo campo.
    if {![string equal $cod_manutentore ""]} {
	element set_properties $form_name f_cod_manu    -value $cod_manutentore
	if {[db_0or1row get_nome_manu ""] == 0} {
	    set f_manu_cogn ""
	    set f_manu_nome ""
	}
    }

    if {$flag_ente == "P"} {
	element set_properties $form_name f_comune       -value $f_comune
    } else {
	element set_properties $form_name f_quartiere    -value $f_quartiere
	element set_properties $form_name f_comune       -value $cod_comune
    }

    element set_properties $form_name funzione         -value $funzione
    element set_properties $form_name caller           -value $caller
    element set_properties $form_name nome_funz        -value $nome_funz
    element set_properties $form_name nome_funz_caller -value $nome_funz_caller
    element set_properties $form_name f_cod_via        -value $f_cod_via 

    element set_properties $form_name f_manu_nome      -value $f_manu_nome
    element set_properties $form_name f_manu_cogn      -value $f_manu_cogn
}
    
if {[form is_valid $form_name]} {
    # form valido dal punto di vista del templating system
    if {$flag_ente eq "P"} {
	set f_comune       [string trim [element::get_value $form_name f_comune]]
    } else {
	set f_comune       [string trim [element::get_value $form_name f_comune]]
	set f_quartiere    [string trim [element::get_value $form_name f_quartiere]]
    }

    set f_cod_via          [string trim [element::get_value $form_name f_cod_via]]
    set f_desc_topo        [string trim [element::get_value $form_name f_desc_topo]]
    set f_desc_via         [string trim [element::get_value $form_name f_desc_via]]
    set f_civico_da        [string trim [element::get_value $form_name f_civico_da]]
    set f_civico_a         [string trim [element::get_value $form_name f_civico_a]]
    set f_cod_manu         [string trim [element::get_value $form_name f_cod_manu]]
    set f_manu_cogn        [string trim [element::get_value $form_name f_manu_cogn]]
    set f_manu_nome        [string trim [element::get_value $form_name f_manu_nome]]
    
    # controlli standard su numeri e date
    set error_num 0
    
    set sw_filtro_ind "t"
    # per capire se si e' cercato di fare un filtro per indirizzo,
    # per la Provincia e' sufficiente sapere se e' indicato il comune
    # per il Comune    e' necessario sapere se e' indicato il quartiere o la via
    
    if {$flag_ente eq "P"} {
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
    
    if {[string equal $f_manu_cogn ""]
        && ![string equal $f_manu_nome ""]
    } {
	element::set_error $form_name f_manu_cogn "Indicare anche il cognome"
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
	set chk_inp_cod_manu $f_cod_manu
	set chk_inp_cognome  $f_manu_cogn
	set chk_inp_nome     $f_manu_nome
	eval $check_cod_manu
	set f_cod_manu  $chk_out_cod_manu
	if {$chk_out_rc == 0} {
	    element::set_error $form_name f_manu_cogn $chk_out_msg
	    incr error_num
	}
    }
    

    if {$error_num > 0} {
        ad_return_template
        return
    }



set link_list [export_url_vars f_comune f_quartiere f_cod_via f_desc_via f_desc_topo f_civico_da f_civico_a f_manu_cogn f_manu_nome f_cod_manu caller funzione nome_funz_caller]&nome_funz=stpm-targa-layout

set return_url "coimstpm-targ-list?$link_list"    

ad_returnredirect $return_url
ad_script_abort
}

ad_return_template
