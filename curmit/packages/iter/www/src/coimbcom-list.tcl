ad_page_contract {
    Lista tabella "coimcomb"

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

    @cvs-id coimcomb-list.tcl 
} {
   {f_combustibile    ""}
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
    #set id_utente [ad_get_cookie iter_login_[ns_conn location]]
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

# preparo link per ritorna al filtro:
set link_filter [export_url_vars caller nome_funz nome_funz_caller f_combustibile receiving_element]
set page_title  "Lista Combustibili"
set curr_prog "coimbcom-list"
set context_bar [iter_context_bar -nome_funz $nome_funz_caller]

# imposto le variabili da usare nel frammento html di testata della lista.
set form_di_ricerca [iter_search_form $curr_prog $search_word]
set col_di_ricerca  "Combustibile"


# sproteggo la chiave solo in inserimento e gli attributi in inserimento e mod.
set form_name    "coimbcom"
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
element create $form_name caller      -widget hidden -datatype text -optional
element create $form_name submit      -widget submit -datatype text -label "$button_label" -html "class form_submit"

# creo i vari elementi per ogni riga ed una struttura multirow
# da utilizzare nell'adp
multirow create combustibili cod_comb descr_comb destinaz

if {[string equal $search_word ""]} {
    if {![string equal $f_combustibile ""]} {
	set search_word $f_combustibile
    }
}

if {[string equal $search_word ""]} {
    set where_word ""
} else {
    set search_word_1 [iter_search_word $search_word]
    set where_word  " and upper(descr_comb) like upper(:search_word_1)"
}

set sql_query [db_map sql_query]
set cod_comb_list [list]

db_foreach comb $sql_query {
    
    element create $form_name compatta.$cod_comb \
	-label   "Cod. da compattare" \
	-widget   checkbox \
	-datatype text \
	-html    "class form_element" \
	-optional \
	-options [list [list Si $cod_comb]]

    set destinaz "<input type=radio name=destinazione value=$cod_comb>"

    multirow append combustibili $cod_comb $descr_comb $destinaz

    lappend cod_comb_list $cod_comb
}
    element set_properties $form_name caller       -value $caller
    element set_properties $form_name nome_funz    -value $nome_funz
    element set_properties $form_name nome_funz_caller -value $nome_funz_caller
    element set_properties $form_name search_word  -value $search_word

# creo testata della lista
set list_head [iter_list_head $form_di_ricerca $col_di_ricerca "" "" "" ""]

if {[form is_request $form_name]} {

}

if {[form is_valid $form_name]} {

    set error_num 0
    set compatta_list ""
    if {![info exists destinazione]} {
	append msg_errore "<font color=red><b>Selezionare il combustibile destinazione</b></font><br>"
	incr error_num
    }

    set ctr_comb_da_compattare 0
    foreach cod_comb $cod_comb_list {
	set compatta [element::get_value $form_name compatta.$cod_comb]
	if {![string equal $compatta ""]} {
	    if {$compatta != $destinazione} {
		incr ctr_comb_da_compattare
		lappend compatta_list $compatta
	    }
	}
    }

    if {$ctr_comb_da_compattare == 0} {
	append msg_errore "<font color=red><b>Selezionare il combustibile da bonificare</b></font><br>"
	incr error_num
    }

    if {$error_num > 0} {
        ad_return_template
        return
    }
    set return_url   "coimbcom-gest?[export_url_vars destinazione compatta_list nome_funz nome_funz_caller search_word]"    
    ad_returnredirect $return_url
    ad_script_abort
}

db_release_unused_handles
ad_return_template 
