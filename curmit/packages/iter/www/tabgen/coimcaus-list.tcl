ad_page_contract {
    Lista tabella "coimcaus"

    @author                  Serena Saccani
    @creation-date           18.06.2012

    @cvs-id coimcaus-list.tcl 
} { 
    {search_word         ""}
    {rows_per_page       ""}
    {caller         "index"}
    {nome_funz           ""}
    {receiving_element   ""}
    {last_descrizione    ""}
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

set page_title "Lista causali di Pagamento"

if {$caller == "index"} {
    set context_bar [iter_context_bar -nome_funz $nome_funz]
} else {
    set context_bar [iter_context_bar \
			 [list "javascript:window.close()" "Torna alla Gestione"] \
			 "$page_title"]
}

# imposto le variabili da usare nel frammento html di testata della lista.
set curr_prog       [file tail [ns_conn url]]
set gest_prog       "coimcaus-gest"
set form_di_ricerca ""
set col_di_ricerca  ""
set extra_par       [list rows_per_page     $rows_per_page \
			 receiving_element $receiving_element]
set link_aggiungi   "<a href=\"$gest_prog?funzione=I&[export_url_vars last_descrizione caller nome_funz extra_par]\">Aggiungi</a>"
set rows_per_page   [iter_set_rows_per_page $rows_per_page $id_utente]
set link_righe      [iter_rows_per_page     $rows_per_page]

if {$caller == "index"} {
    set link    "\[export_url_vars id_caus last_descrizione nome_funz extra_par\]"
    set actions "
    <td nowrap><a href=\"$gest_prog?funzione=V&$link\">Selez.</a></td>"
    set js_function ""
} else { 
    set actions [iter_select [list id_caus descrizione ]]
    set receiving_element [split $receiving_element |]
    set js_function [iter_selected $caller [list [lindex $receiving_element 0]  id_caus [lindex $receiving_element 1]  descrizione ]]
}

# imposto la struttura della tabella
set table_def [list \
		   [list actions        "Azioni"        no_sort $actions] \
		   [list id_caus     "Cod."          no_sort {l}] \
		   [list descrizione    "Descrizione"   no_sort {l}] \
		   [list codice         "Codice"        no_sort {c}] \
		  ]

# imposto la query SQL 

# imposto la condizione per la prossima pagina
if {![string is space $last_descrizione]} {
    set descrizione [lindex $last_descrizione 0]
    set id_caus   [lindex $last_descrizione 1]
    set where_last " and ((upper(descrizione) = upper(:descrizione)  and
                           id_caus  >= :id_caus) 
                      or   upper(descrizione) > upper(:descrizione))"
} else {
    set where_last ""
}

set sel_causali "
select id_caus
     , descrizione
     , codice
  from coimcaus
 where 1 = 1
 $where_last
 order by descrizione"

set table_result [ad_table -Tmax_rows $rows_per_page -Tmissing_text "Nessun dato corrisponde ai criteri impostati." -Textra_vars {id_caus descrizione last_descrizione nome_funz extra_par} go $sel_causali $table_def]

# preparo url escludendo last_descrizione che viene passato esplicitamente
# per poi preparare il link alla prima ed eventualmente alla prossima pagina
set url_vars [export_ns_set_vars "url" last_descrizione]
set link_altre_pagine "Vai alla <a href=\"$curr_prog?$url_vars\">prima pagina</a>"

# preparo link a pagina successiva
set ctr_rec [expr [regsub -all <tr $table_result <tr comodo] -1]
if {$ctr_rec == $rows_per_page} {
    set last_descrizione [list $descrizione $id_caus]
    append url_vars "&[export_url_vars last_descrizione]"
    append link_altre_pagine " o alla <a href=\"$curr_prog?$url_vars\">pagina successiva</a>"
}

# creo testata della lista
set list_head [iter_list_head  $form_di_ricerca $col_di_ricerca \
		   $link_aggiungi $link_altre_pagine $link_righe "Righe per pagina"]

db_release_unused_handles
ad_return_template 

