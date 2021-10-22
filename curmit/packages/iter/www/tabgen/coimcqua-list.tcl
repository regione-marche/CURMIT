ad_page_contract {
    Lista tabella "coimcqua"

    @author                  Giulio Laurenzi
    @creation-date           13/01/2004

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

    @cvs-id coimcqua-list.tcl 
} { 
   {search_word       ""}
   {rows_per_page     ""}
   {caller            "index"}
   {nome_funz         ""}
   {receiving_element ""}
   {last_cod_qua      ""}
   {last_cod_comune   ""}
   {cod_qua           ""}
   {cod_comune        ""}
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
    set id_utente [iter_get_id_utente]
}

set page_title      "Lista Quartieri"

set context_bar [iter_context_bar -nome_funz $nome_funz]

# imposto le variabili da usare nel frammento html di testata della lista.
set curr_prog       [file tail [ns_conn url]]
set gest_prog       "coimcqua-gest"
set form_di_ricerca [iter_search_form $curr_prog $search_word]
set col_di_ricerca  "Descrizione"
set extra_par       [list rows_per_page     $rows_per_page \
                          receiving_element $receiving_element]
set link_aggiungi   "<a href=\"$gest_prog?funzione=I&[export_url_vars cod_qua cod_comune last_cod_qua last_cod_comune caller nome_funz extra_par]\">Aggiungi</a>"
set rows_per_page   [iter_set_rows_per_page $rows_per_page $id_utente]
set link_righe      [iter_rows_per_page     $rows_per_page]


set link    "\[export_url_vars cod_qua cod_comune last_cod_qua last_cod_comune nome_funz extra_par\]"
set actions "
<td nowrap><a href=\"$gest_prog?funzione=V&$link\">Selez.</a></td>"
set js_function ""

# imposto la struttura della tabella
set table_def [list \
        [list actions       "Azioni" no_sort $actions] \
    	[list cod_qua       "Codice"      no_sort {l}] \
	[list descrizione   "Descrizione" no_sort {l}] \
        [list denominazione "Comune"      no_sort {l}] \
]

# imposto la query SQL 
if {[string equal $search_word ""]} {
    set where_word ""
} else {
    set search_word_1 [iter_search_word $search_word]
    set where_word  " and upper(descrizione) like upper(:search_word_1)"
}

# imposto la condizione per la prossima pagina
if {![string is space $last_cod_qua]
&&  ![string is space $last_cod_comune]} {
    set where_last "and  ((a.cod_comune  = :last_cod_comune
                    and    a.cod_qua    >= :last_cod_qua)
                     or    a.cod_comune >  :last_cod_comune)"
} else {
    set where_last ""
}

set sql_query [db_map sel_cqua]

set table_result [ad_table -Tmax_rows $rows_per_page -Tmissing_text "Nessun dato corrisponde ai criteri impostati." -Textra_vars {cod_qua cod_comune last_cod_qua last_cod_comune nome_funz extra_par} go $sql_query $table_def]

# preparo url escludendo last_cod_qua/comune che viene passato esplicitamente
# per poi preparare il link alla prima ed eventualmente alla prossima pagina
set url_vars [export_ns_set_vars "url" "last_cod_qua last_cod_comune"]
set link_altre_pagine "Vai alla <a href=\"$curr_prog?$url_vars\">prima pagina</a>"

# preparo link a pagina successiva
set ctr_rec [expr [regsub -all <tr $table_result <tr comodo] -1]
if {$ctr_rec == $rows_per_page} {
    set last_cod_qua    $cod_qua
    set last_cod_comune $cod_comune 
    append url_vars "&[export_url_vars last_cod_qua last_cod_comune]"
    append link_altre_pagine " o alla <a href=\"$curr_prog?$url_vars\">pagina successiva</a>"
}

# creo testata della lista
set list_head [iter_list_head  $form_di_ricerca $col_di_ricerca \
              $link_aggiungi $link_altre_pagine $link_righe "Righe per pagina"]

db_release_unused_handles
ad_return_template 

