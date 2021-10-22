ad_page_contract {
    Lista tabella "coimcvie"

    @author                  Giulio Laurenzi
    @creation-date           27/05/2005

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

    @cvs-id coimcvie-list.tcl 
} { 
   {search_word       ""}
   {rows_per_page     ""}
   {caller            "index"}
   {nome_funz         ""}
   {nome_funz_caller  ""}
   {receiving_element ""}
   {cod_comune        ""}
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
    #set id_utente [ad_get_cookie   iter_login_[ns_conn location]]
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

set page_title      "Bonifica Viario"
set context_bar [iter_context_bar -nome_funz $nome_funz_caller]
set msg_errore ""

# preparo link per ritorna al filtro:
set link_filter [export_url_vars caller nome_funz receiving_element]

# imposto le variabili da usare nel frammento html di testata della lista.
set curr_prog       [file tail [ns_conn url]]
set form_di_ricerca [iter_search_form $curr_prog $search_word]
set col_di_ricerca  "Descrizione"
set extra_par       [list rows_per_page     $rows_per_page \
                          receiving_element $receiving_element]
set link_righe      [iter_rows_per_page     $rows_per_page]

if {$caller == "index"} {
    set link "\[export_url_vars cod_via cod_comune last_cod_via nome_funz extra_par\]"
    set js_function ""
} else {
    set receiving_element [split $receiving_element |]
}

# sproteggo la chiave solo in inserimento e gli attributi in inserimento e mod.
set form_name    "coimcvie"
set readonly_key "readonly"
set readonly_fld "readonly"
set disabled_fld "disabled"
set onsubmit_cmd ""
set button_label "Continua"

form create $form_name \
-html    $onsubmit_cmd

element create $form_name nome_funz        -widget hidden -datatype text -optional
element create $form_name nome_funz_caller -widget hidden -datatype text -optional
element create $form_name search_word      -widget hidden -datatype text -optional
element create $form_name cod_comune       -widget hidden -datatype text -optional
element create $form_name caller           -widget hidden -datatype text -optional
element create $form_name extra_par        -widget hidden -datatype text -optional
element create $form_name submit           -widget submit -datatype text -label "$button_label" -html "class form_submit"

# creo i vari elementi per ogni riga ed una struttura multirow
# da utilizzare nell'adp
multirow create vie cod_via descr_topo descrizione descr_estesa denom_comune destinaz

# imposto la query SQL 
if {[string equal $search_word ""]} {
    set where_word ""
} else {
    set search_word_1 [iter_search_word $search_word]
    set where_word  " and descrizione like upper(:search_word_1)"
}

if {[db_0or1row sel_comu ""] == 0} {
   iter_return_complaint "Comune non trovato"
}

set sql_query    [db_map sel_viae]
set cod_via_list [list]
db_foreach cmp $sql_query {
    
    element create $form_name compatta.$cod_via \
	-label   "Cod. Via da compattare" \
	-widget   checkbox \
	-datatype text \
	-html    "class form_element" \
	-optional \
	-options [list [list Si $cod_via]]

    set destinaz "<input type=radio name=destinazione value=$cod_via>"

    multirow append vie $cod_via $descr_topo $descrizione $descr_estesa $denom_comune $destinaz

    lappend cod_via_list $cod_via
}
    element set_properties $form_name caller       -value $caller
    element set_properties $form_name extra_par    -value $extra_par
    element set_properties $form_name nome_funz    -value $nome_funz
    element set_properties $form_name nome_funz_caller -value $nome_funz_caller
    element set_properties $form_name search_word  -value $search_word
    element set_properties $form_name cod_comune   -value $cod_comune

# creo testata della lista
set list_head [iter_list_head  $form_di_ricerca $col_di_ricerca "" "" "" ""]


if {[form is_request $form_name]} {

}

if {[form is_valid $form_name]} {
    set error_num 0
    set compatta_list ""
    if {![info exists destinazione]} {
	append msg_errore "<font color=red><b>Selezionare la via di destinazione</b></font><br>"
	incr error_num
    } else {

	set flag_dest "f"
	set ctr_vie_da_compattare 0
	foreach cod_via $cod_via_list {
	    set compatta [element::get_value $form_name compatta.$cod_via]
	    if {![string equal $compatta ""]} {
		db_1row sel_multi "select count(*) as conta_multi from coim_multiubic where cod_via = :compatta"
		if {$conta_multi > 0} {
		    append msg_errore "<font color=red><b>Non &egrave; possibile bonificare la via $compatta in quanto associata a impianti come ubicazione aggiuntiva</b></font><br>"
		    incr error_num
		}
		if {$compatta != $destinazione} {
		    incr ctr_vie_da_compattare
		    lappend compatta_list $compatta
		} else {
		    set flag_dest "t"
		}
	    }
	}

	if {$flag_dest == "f"} {
	    db_1row sel_multi "select count(*) as conta_multi from coim_multiubic where cod_via = :destinazione"
	    if {$conta_multi > 0} {
		append msg_errore "<font color=red><b>Non &egrave; possibile bonificare la via $destinazione in quanto associata a impianti come ubicazione aggiuntiva</b></font><br>"
		incr error_num
	    }
	}

	if {$ctr_vie_da_compattare == 0} {
	    append msg_errore "<font color=red><b>Selezionare la via da bonificare</b></font><br>"
	    incr error_num
	}
    }

    if {$error_num > 0} {
        ad_return_template
        return
    }
    set return_url   "coimcvie-gest?[export_url_vars destinazione compatta_list nome_funz nome_funz_caller cod_comune search_word]"    
    ad_returnredirect $return_url
    ad_script_abort
}

db_release_unused_handles
ad_return_template 
