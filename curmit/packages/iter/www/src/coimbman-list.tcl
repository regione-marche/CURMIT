ad_page_contract {
    Lista tabella "coimmanu"

    @author                  Giulio Laurenzi
    @creation-date           31/05/2005

    @param search_word       parola da ricercare con una query
    @param rows_per_page     una delle dimensioni della tabella  
    @param caller            se diverso da index rappresenta il nome del form 
                             da cui e' partita la ricerca ed in questo caso
                             imposta solo azione "sel"
    @param nome_funz         identifica l'entrata di menu,
                             serve per le autorizzazioni
    @param receiving_element nomi dei campi di form che riceveranno gli
                             argomenti restituiti dallo script di zoom,
                             separati da '|' ed impostarli come segue:

    @cvs-id coimmanu-list.tcl 

    USER  DATA       MODIFICHE
    ===== ========== ============================================================================================
    rom02 16/07/2020 Per la regione Basilicata non va usata la lunghezza a 8 caratteri per rendere non 
    rom02            bonificabili i manutentori.

    rom01 12/01/2021 Le particolarita' della Provincia di Salerno ora sono sostituite dalla condizione
    rom01            su tutta la Regione Campania.

    sim03 28/10/2020 Aggiunto controllo sulla lunghezza del codice manutentore per le Marche perche'
    sim03            su Pesaro sono presenti alcuni manutentori vecchi che iniziavano con MA6 tipo MA600.

    sim02 23/01/2020 Per Salerno consideriamo come non bonificabili i manutentori che iniziano con MA2.
    sim02            Non utilizziamo solo la lunghezza perchè alcuni dei vecchi manutentori sono già lunghi 8 caratteri.

    sim01 22/08/2019 Per la regine marche consideriamo come non bonificabili i manutentori che iniziano con MA6.
    sim01            Non utilizziamo la lunghezza perchè già alcuni enti usavano iter ed hanno quindi la codifica
    sim01            dei manutentori a 8 caratteri

} {
   {f_cognome       ""}
   {f_nome          ""}
   {search_word       ""}
   {rows_per_page     ""}
   {caller            "index"}
   {nome_funz         ""}
   {nome_funz_caller  ""}
   {receiving_element ""}
    destinazione:multiple,optional
}  -properties {
    page_title:onevalue
    context_bar:onevalue
    list_head:onevalue
    table_result:onevalue
}

# Controlla lo user
if {![string is space $nome_funz]} {
    set lvl        1
    set id_utente [lindex [iter_check_login $lvl $nome_funz] 1]
} else {
  # se la lista viene chiamata da un cerca, allora nome_funz non viene passato
  # e bisogna reperire id_utente dai cookie
    set id_utente [ad_get_cookie iter_login_[ns_conn location]]
    set id_utente [iter_get_id_utente]
    if {$id_utente  == ""} {
	set login [ad_conn package_url]
        iter_return_complaint "Per accedere a questo programma devi prima eseguire la procedura di <a href=$login>Login.</a>"
        return 0
    }
}

# controllo il parametro di "propagazione" per la navigation bar
if {[string is space $nome_funz_caller]} {
    set nome_funz_caller $nome_funz
}

iter_get_coimtgen
set flag_portale        $coimtgen(flag_portale)

# preparo link per ritorna al filtro:
set link_filter [export_url_vars caller nome_funz nome_funz_caller f_cognome f_nome receiving_element]
set page_title  "Lista Manutentori"
set curr_prog "coimbman-list"
set context_bar [iter_context_bar -nome_funz $nome_funz_caller]

# imposto le variabili da usare nel frammento html di testata della lista.
set form_di_ricerca [iter_search_form $curr_prog $search_word]
set col_di_ricerca  "Cognome"


# sproteggo la chiave solo in inserimento e gli attributi in inserimento e mod.
set form_name    "coimbman"
set readonly_key "readonly"
set readonly_fld "readonly"
set disabled_fld "disabled"
set onsubmit_cmd ""
set button_label "Continua"
set msg_errore   ""

form create $form_name \
-html    $onsubmit_cmd

element create $form_name nome_funz   -widget hidden -datatype text -optional
element create $form_name nome_funz_caller -widget hidden -datatype text -optional
element create $form_name search_word -widget hidden -datatype text -optional
element create $form_name f_nome      -widget hidden -datatype text -optional
element create $form_name caller      -widget hidden -datatype text -optional
element create $form_name submit      -widget submit -datatype text -label "$button_label" -html "class form_submit"

# creo i vari elementi per ogni riga ed una struttura multirow
# da utilizzare nell'adp
multirow create manutentori cod_manutentore cod_manu nominativo indirizzo comune cod_fiscale destinaz

if {![string equal $search_word ""]} {
    set f_nome ""
} else {
    if {![string equal $f_cognome ""]} {
	set search_word $f_cognome
    }
}

if {[string equal $search_word ""]} {
    set where_word ""
} else {
    set search_word_1 [iter_search_word $search_word]
    set where_word  " and cognome like upper(:search_word_1)"
}

if {[string equal $f_nome ""]} {
    set where_nome ""
} else {
    set f_nome_1    [iter_search_word $f_nome]
    set where_nome  " and nome like upper(:f_nome_1)"
}

set sql_query [db_map sql_query]
set cod_manu_list [list]

db_foreach manu $sql_query {
    
    set lung_man [string length $cod_manutentore]

    if {$coimtgen(regione) eq "MARCHE"} {#sim01
	#sim03 aggiunto condizione su $lung_man per Pesaro che aveva manutentori vecchi che iniziavano con MA6 tipo MA600
	if {[string match "*MA6*" $cod_manutentore] && $lung_man == 8} {
	    set disabled_fld "disabled"
	} else {
	    set disabled_fld \{\}
	}

    } elseif {$coimtgen(regione) eq "CAMPANIA"} {#sim02

	if {[string match "*MA2*" $cod_manutentore] && $lung_man == 8} {
	    set disabled_fld "disabled"
	} else {
	    set disabled_fld \{\}
	}
    } elseif {$coimtgen(regione) eq "BASILICATA"} {#rom02 aggiunta elseif e contenuto
	set disabled_fld \{\}
    
	
    } else {

	if {$lung_man == 8 && $flag_portale == "T"} {
	    set disabled_fld "disabled"
	} else {
	    set disabled_fld \{\}
	}
    }
    regsub -all " " $cod_manutentore "_" cod_manutentore_compatta;#sim

#    ns_log notice "simone $cod_manutentore_compatta"

    element create $form_name compatta.$cod_manutentore_compatta \
	-label   "Cod. da compattare" \
	-widget   checkbox \
	-datatype text \
	-html    "$disabled_fld {} class form_element" \
	-optional \
	-options [list [list Si $cod_manutentore]]

    set destinaz "<input type=radio name=destinazione value=$cod_manutentore>"

    multirow append manutentori $cod_manutentore_compatta $cod_manutentore $nominativo $indirizzo $comune $cod_fiscale $destinaz

    lappend cod_manu_list $cod_manutentore
}
    element set_properties $form_name caller       -value $caller
    element set_properties $form_name nome_funz    -value $nome_funz
    element set_properties $form_name nome_funz_caller -value $nome_funz_caller
    element set_properties $form_name search_word  -value $search_word
    element set_properties $form_name f_nome       -value $f_nome

# creo testata della lista
set list_head [iter_list_head $form_di_ricerca $col_di_ricerca "" "" "" ""]

if {[form is_request $form_name]} {

}

if {[form is_valid $form_name]} {
    set f_nome  [element::get_value $form_name f_nome]

    set error_num 0
    set compatta_list ""
    if {![info exists destinazione]} {
	append msg_errore "<font color=red><b>Selezionare il manutentore destinazione</b></font><br>"
	incr error_num
    }

    set ctr_manu_da_compattare 0
    foreach cod_manutentore $cod_manu_list {
	regsub -all " " $cod_manutentore "_" cod_manutentore_compatta;#sim
	set compatta [element::get_value $form_name compatta.$cod_manutentore_compatta]
	ns_log notice "simone2 $compatta"
	if {![string equal $compatta ""]} {
	    if {$compatta != $destinazione} {
		incr ctr_manu_da_compattare
		lappend compatta_list $compatta
	    }
	}
    }

    if {$ctr_manu_da_compattare == 0} {
	append msg_errore "<font color=red><b>Selezionare il manutentore da bonificare</b></font><br>"
	incr error_num
    }

    if {$error_num > 0} {
        ad_return_template
        return
    }
    set return_url   "coimbman-gest?[export_url_vars destinazione compatta_list nome_funz nome_funz_caller f_nome search_word]"    
    ad_returnredirect $return_url
    ad_script_abort
}

db_release_unused_handles
ad_return_template 
