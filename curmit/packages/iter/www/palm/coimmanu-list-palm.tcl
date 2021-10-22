ad_page_contract {
    Lista tabella "coimmanu"

    @author                  Giulio Laurenzi
    @creation-date           27/02/2004

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
} { 
   {search_word       ""}
   {rows_per_page     ""}
   {caller            "index"}
   {nome_funz         ""}
   {receiving_element ""}
   {last_cognome      ""}
   {nome_funz_caller  ""}
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
}

set cod_manutentore [iter_check_uten_manu $id_utente]

# controllo il parametro di "propagazione" per la navigation bar
if {[string is space $nome_funz_caller]} {
    set nome_funz_caller $nome_funz
}

set page_title      "Lista Manutentori"

if {$caller == "index"} {
    set context_bar [iter_context_bar -nome_funz $nome_funz_caller]
} else {
    set context_bar [iter_context_bar \
                    [list "javascript:window.close()" "Torna alla Gestione"] \
                    "$page_title"]
}

# imposto le variabili da usare nel frammento html di testata della lista.
set curr_prog       [file tail [ns_conn url]]
set gest_prog       "coimmanu-gest"
set form_di_ricerca [iter_search_form_palm $curr_prog $search_word]
set col_di_ricerca  "Cognome"
set extra_par       [list rows_per_page     $rows_per_page \
                          receiving_element $receiving_element]
set rows_per_page   [iter_set_rows_per_page $rows_per_page $id_utente]
set link_righe      [iter_rows_per_page     $rows_per_page]

if {$caller == "index"} {
    set link_aggiungi   "<a href=\"$gest_prog?funzione=I&[export_url_vars last_cognome caller nome_funz nome_funz_caller extra_par]\">Aggiungi</a>"
    set link    "\[export_url_vars cod_manutentore last_cognome nome_funz extra_par\]"
    set actions "
    <td nowrap><a href=\"$gest_prog?funzione=V&$link\">Selez.</a></td>"

    set js_function ""
} else { 
    set link_aggiungi ""
    set actions [iter_select [list cod_manutentore cognome nome]]
    set receiving_element [split $receiving_element |]
    set js_function [iter_selected $caller [list [lindex $receiving_element 0]  cod_manutentore [lindex $receiving_element 1]  cognome [lindex $receiving_element 2]  nome]]
}

# imposto la struttura della tabella
set table_def [list \
        [list actions         "Az."     no_sort $actions] \
    	[list cognome         "Cognome"    no_sort {l}] \
	[list nome            "Nome"       no_sort {l}] \
	[list indirizzo       "Indirizzo"  no_sort {l}] \
]

# imposto la query SQL 
if {[string equal $search_word ""]} {
    set where_word ""
} else {
    set search_word_1 [iter_search_word $search_word]
    set where_word  " and upper(cognome) like upper(:search_word_1)"
}

# imposto la condizione per la prossima pagina
if {![string is space $last_cognome]} {
    set cognome         [lindex $last_cognome 0]
    set cod_manutentore [lindex $last_cognome 1]
    set where_last " and ((upper(cognome)   = upper(:cognome)  and
                           cod_manutentore >= :cod_manutentore) or
                           upper(cognome)  >  upper(:cognome))"
} else {
    set where_last ""
}   

if {![string is space $cod_manutentore]} {
    set where_manu "and cod_manutentore = :cod_manutentore"
} else {
    set where_manu ""
}

set sql_query [db_map sel_manu]

set table_result [ad_table -Tmax_rows $rows_per_page -Tmissing_text "Nessun dato corrisponde ai criteri impostati." -Textra_vars {cod_manutentore last_cognome nome_funz nome_funz_caller cognome nome extra_par} go $sql_query $table_def]

# preparo url escludendo last_cognome che viene passato esplicitamente
# per poi preparare il link alla prima ed eventualmente alla prossima pagina
set url_vars [export_ns_set_vars "url" last_cognome]
set link_altre_pagine "Vai alla<br><a href=\"$curr_prog?$url_vars\">prima pagina</a>"

# preparo link a pagina successiva
set ctr_rec [expr [regsub -all <tr $table_result <tr comodo] -1]
if {$ctr_rec == $rows_per_page} {
    set last_cognome [list  $cognome $cod_manutentore]
    append url_vars "&[export_url_vars last_cognome]"
    append link_altre_pagine "<br>o alla<br><a href=\"$curr_prog?$url_vars\">pagina successiva</a>"
}

# creo testata della lista
set list_head [iter_list_head  $form_di_ricerca $col_di_ricerca \
              $link_aggiungi $link_altre_pagine $link_righe "Righe per pagina"]

db_release_unused_handles
ad_return_template 
