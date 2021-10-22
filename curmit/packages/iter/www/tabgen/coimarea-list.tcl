ad_page_contract {
    Lista tabella "coimarea"

    @author                  Adhoc
    @creation-date           19/02/2004

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

    @cvs-id coimarea-list.tcl 
} { 
   {search_word       ""}
   {rows_per_page     ""}
   {caller            "index"}
   {nome_funz         ""}
   {nome_funz_caller  ""}
   {receiving_element ""}
   {last_cod_area ""}
   {cod_manutentore   ""}
   {cod_opve          ""}
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
    set id_utente [iter_get_id_utente]
}

# controllo il parametro di "propagazione" per la navigation bar
if {[string is space $nome_funz_caller]} {
    set nome_funz_caller $nome_funz
}

set page_title      "Lista Aree geografiche"

if {![string equal $cod_opve ""]
||  ![string equal $cod_manutentore ""]
} {
    set context_bar [iter_context_bar \
		    [list "javascript:window.close()" "Chiudi finestra"] \
		    "$page_title"]

} else {
    if {$caller == "index"} {
	set context_bar [iter_context_bar -nome_funz $nome_funz_caller]
    } else {
	set context_bar [iter_context_bar \
			[list "javascript:window.close()" "Torna alla Gestione"] \
			 "$page_title"]
    }
}


set url_list_area  [list [ad_conn url]?[export_ns_set_vars url]]
#set url_list_area  [export_url_vars url_list_area]

# imposto le variabili da usare nel frammento html di testata della lista.
set curr_prog       [file tail [ns_conn url]]
set gest_prog       "coimarea-gest"
set form_di_ricerca ""
set col_di_ricerca  ""
set extra_par       [list rows_per_page     $rows_per_page \
                          receiving_element $receiving_element]
if {![string equal $cod_opve ""]
||  ![string equal $cod_manutentore ""]
} {
    set link_aggiungi ""
} else {
    set link_aggiungi   "<a href=\"$gest_prog?funzione=I&[export_url_vars last_cod_area caller nome_funz nome_funz_caller url_list_area extra_par]\">Aggiungi</a>"
}
set rows_per_page   [iter_set_rows_per_page $rows_per_page $id_utente]
set link_righe      [iter_rows_per_page     $rows_per_page]


if {$caller == "index"} {
    set link    "\[export_url_vars cod_area last_cod_area nome_funz nome_funz_caller url_list_area extra_par\]"
    set actions "
    <td nowrap><a href=\"$gest_prog?funzione=V&$link\">Selez.</a></td>"
    set js_function ""
} else { 
    set actions [iter_select [list cod_area descrizione ]]
    set receiving_element [split $receiving_element |]
    set js_function [iter_selected $caller [list [lindex $receiving_element 0]  cod_area [lindex $receiving_element 1] descrizione ]]
}


# imposto la struttura della tabella
if {![string equal $cod_opve ""]
||  ![string equal $cod_manutentore ""]
} {
    set table_def [list \
		  [list descrizione "Descrizione" no_sort {l}] \
	       ]
} else {
    set table_def [list \
		  [list actions     "Azioni" no_sort $actions] \
		  [list descrizione "Descrizione" no_sort {l}] \
	       ]
}

# imposto la query SQL 

# imposto la condizione per la prossima pagina
if {![string is space $last_cod_area]} {
    set where_last " and a.descrizione >= :last_cod_area"
} else {
    set where_last ""
}

if {![string equal $cod_opve ""]} {
    set where_opve "and a.cod_area in (select b.cod_area
                                         from coimtcar b
                                        where b.cod_opve = :cod_opve)"
} else {
    set where_opve ""
}

if {![string equal $cod_manutentore ""]} {
    set where_manutentore "and a.cod_area in (select b.cod_area
                                                from coimmtar b
                                               where b.cod_manutentore = :cod_manutentore)"
} else {
    set where_manutentore ""
}

set sql_query [db_map sql_query]

set table_result [ad_table -Tmax_rows $rows_per_page -Tmissing_text "Nessun dato corrisponde ai criteri impostati." -Textra_vars {cod_area last_cod_area nome_funz nome_funz_caller url_list_area extra_par descrizione} go $sql_query $table_def]

# preparo url escludendo last_cod_area che viene passato esplicitamente
# per poi preparare il link alla prima ed eventualmente alla prossima pagina
set url_vars [export_ns_set_vars "url" last_cod_area]
set link_altre_pagine "Vai alla <a href=\"$curr_prog?$url_vars\">prima pagina</a>"

# preparo link a pagina successiva
set ctr_rec [expr [regsub -all <tr $table_result <tr comodo] -1]
if {$ctr_rec == $rows_per_page} {
    set last_cod_area $descrizione
    append url_vars "&[export_url_vars last_cod_area]"
    append link_altre_pagine " o alla <a href=\"$curr_prog?$url_vars\">pagina successiva</a>"
}

# creo testata della lista
set list_head [iter_list_head  $form_di_ricerca $col_di_ricerca \
              $link_aggiungi $link_altre_pagine $link_righe "Righe per pagina"]

db_release_unused_handles
ad_return_template 

