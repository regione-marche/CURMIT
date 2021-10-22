ad_page_contract {
    Lista tabella "coimogge"

    @author                  Giulio Laurenzi
    @creation-date           17/05/2004

    @param search_word       parola da ricercare con una query
    @param rows_per_page     una delle dimensioni della tabella  
    @param caller            se diverso da index rappresenta il nome del form 
                             da cui e' partita la ricerca ed in questo caso
                             imposta solo azione "sel"
    @param nome_funz         identifica l'entrata di menu,
                             serve per le autorizzazioni
    @param nome_funz_caller  identifica l'entrata di menu,
                             serve per la navigation bar
    @param receiving_element nomi dei campi di form che riceveranno gli
                             argomenti restituiti dallo script di zoom,
                             separati da '|' ed impostarli come segue:

    @cvs-id coimogge-list.tcl 
} { 
   {search_word       ""}
   {rows_per_page     ""}
   {caller            "index"}
   {nome_funz         ""}
   {nome_funz_caller  ""} 
   {receiving_element ""}
   {last_scelta       ""}
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

# controllo il parametro di "propagazione" per la navigation bar
if {[string is space $nome_funz_caller]} {
    set nome_funz_caller $nome_funz
}

set page_title      "Lista Oggetti"

set context_bar [iter_context_bar -nome_funz $nome_funz_caller]

# imposto le variabili da usare nel frammento html di testata della lista.
set curr_prog       [file tail [ns_conn url]]
set gest_prog       "coimogge-gest"
set form_di_ricerca [iter_search_form $curr_prog $search_word]
set col_di_ricerca  "Nome funz."
set extra_par       [list rows_per_page     $rows_per_page \
                          receiving_element $receiving_element]
set link_aggiungi   "<a href=\"$gest_prog?funzione=I&[export_url_vars livello scelta_1 scelta_2 scelta_3 last_scelta caller nome_funz extra_par nome_funz_caller]\">Aggiungi</a>"
set rows_per_page   [iter_set_rows_per_page $rows_per_page $id_utente]
set link_righe      [iter_rows_per_page     $rows_per_page]

set link    "\[export_url_vars nome_funz livello scelta_1 scelta_2 scelta_3 scelta_4 nome_funz_caller last_scelta extra_par\]"
set actions "
<td nowrap><a href=\"$gest_prog?funzione=V&$link\">Selez.</a></td>"
set js_function ""

# imposto la struttura della tabella
set table_def [list \
        [list actions     "Azioni"      no_sort $actions] \
    	[list livello     "Livello"     no_sort {l}] \
	[list scelta_1    "Sc. 1"       no_sort {l}] \
	[list scelta_2    "Sc. 2"       no_sort {l}] \
	[list scelta_3    "Sc. 3"       no_sort {l}] \
	[list scelta_4    "Sc. 4"       no_sort {l}] \
	[list tipo        "Tipo"        no_sort {l}] \
	[list descrizione "Descrizione" no_sort {l}] \
	[list nome_funz_d "Nome funz."  no_sort {l}] \
]

# imposto la query SQL 
if {[string equal $search_word ""]} {
    set where_word ""
} else {
    set search_word_1 [iter_search_word $search_word]
    set where_word  " and upper(nome_funz) like upper(:search_word_1)"
}

# imposto la condizione per la prossima pagina
if {![string is space $last_scelta]} {
    set livello  [lindex $last_scelta 0]
    set scelta_1 [lindex $last_scelta 1]
    set scelta_2 [lindex $last_scelta 2]
    set scelta_3 [lindex $last_scelta 3]
    set scelta_4 [lindex $last_scelta 4]

    set where_last " and (  livello  > :livello 
                       or  (livello  = :livello 
                        and scelta_1 >= :scelta_1)
                       or  (livello  = :livello
                        and scelta_1 = :scelta_1
                        and scelta_2 >= :scelta_2)
                       or  (livello  = :livello
                        and scelta_1 = :scelta_1
                        and scelta_2 = :scelta_2
                        and scelta_3 >= :scelta_3)
                       or  (livello  = :livello
                        and scelta_1 = :scelta_1
                        and scelta_2 = :scelta_2
                        and scelta_3 = :scelta_3
                        and scelta_4 >= :scelta_4)
                    )"
} else {
    set where_last ""
}

set sel_ogge [db_map sel_ogge]

set table_result [ad_table -Tmax_rows $rows_per_page -Tmissing_text "Nessun dato corrisponde ai criteri impostati." -Textra_vars {livello scelta_1 scelta_2 scelta_3 scelta_4 last_scelta nome_funz nome_funz_caller extra_par} go $sel_ogge $table_def]

# preparo url escludendo last_scelta che viene passato esplicitamente
# per poi preparare il link alla prima ed eventualmente alla prossima pagina
set url_vars [export_ns_set_vars "url" last_scelta]
set link_altre_pagine "Vai alla <a href=\"$curr_prog?$url_vars\">prima pagina</a>"

# preparo link a pagina successiva
set ctr_rec [expr [regsub -all <tr $table_result <tr comodo] -1]
if {$ctr_rec == $rows_per_page} {
    set last_scelta [list $livello $scelta_1 $scelta_2 $scelta_3 $scelta_4]
    append url_vars "&[export_url_vars last_scelta]"
    append link_altre_pagine " o alla <a href=\"$curr_prog?$url_vars\">pagina successiva</a>"
}

# creo testata della lista
set list_head [iter_list_head  $form_di_ricerca $col_di_ricerca \
              $link_aggiungi $link_altre_pagine $link_righe "Righe per pagina"]

db_release_unused_handles
ad_return_template 
