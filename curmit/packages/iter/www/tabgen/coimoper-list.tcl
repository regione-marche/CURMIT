ad_page_contract {
    Lista tabella "coimoper"

    @author                  Gacalin Lufi
    @creation-date           19/07/2018

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

    @cvs-id coimoper-list.tcl 
} { 
   {search_word       ""}
   {rows_per_page     ""}
   {caller            "index"}
   {nome_funz         ""}
   {receiving_element ""}
   {last_descr_oper   ""}
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

set page_title      "Lista Operazioni selezionabili"

if {$caller == "index"} {
    set context_bar [iter_context_bar -nome_funz $nome_funz]
} else {
    set context_bar [iter_context_bar \
                    [list "javascript:window.close()" "Torna alla Gestione"] \
                    "$page_title"]
}

# imposto le variabili da usare nel frammento html di testata della lista.
set curr_prog       [file tail [ns_conn url]]
set gest_prog       "coimoper-gest"
set form_di_ricerca ""
set col_di_ricerca  ""
set extra_par       [list rows_per_page     $rows_per_page \
                          receiving_element $receiving_element]
set link_aggiungi   "<a href=\"$gest_prog?funzione=I&[export_url_vars caller nome_funz extra_par]\">Aggiungi</a>"
set rows_per_page   [iter_set_rows_per_page $rows_per_page $id_utente]
set link_righe      [iter_rows_per_page     $rows_per_page]

if {$caller == "index"} {
    set link    "\[export_url_vars cod_operazione nome_funz extra_par\]"
    set actions "
    <td nowrap><a href=\"$gest_prog?funzione=V&$link\">Selez.</a></td>"
    set js_function ""
} else { 
    set actions [iter_select [list cod_operazione descr_operazione ]]
    set receiving_element [split $receiving_element |]
    set js_function [iter_selected $caller [list [lindex $receiving_element 0]  cod_operazione [lindex $receiving_element 1]  descr_operazione ]
}


# imposto la struttura della tabella
set table_def [list \
		   [list actions           "Azioni"          no_sort $actions] \
		   [list cod_operazione    "Cod."            no_sort {l}] \
		   [list descr_operazione  "Descrizione"     no_sort {l}] \
		  ]

set sel_oper [db_map sel_oper]

set table_result [ad_table -Tmax_rows $rows_per_page -Tmissing_text "Nessun dato corrisponde ai criteri impostati." -Textra_vars {cod_operazione descr_operazione nome_funz extra_par} go $sel_oper $table_def]

# per poi preparare il link alla prima ed eventualmente alla prossima pagina
set url_vars [export_ns_set_vars "url"]
set link_altre_pagine "Vai alla <a href=\"$curr_prog?$url_vars\">prima pagina</a>"

# preparo link a pagina successiva
set ctr_rec [expr [regsub -all <tr $table_result <tr comodo] -1]
if {$ctr_rec == $rows_per_page} {
    set last_descr_operazione [list $descr_operazione $cod_operazione]
    append url_vars "&[export_url_vars]"
    append link_altre_pagine " o alla <a href=\"$curr_prog?$url_vars\">pagina successiva</a>"
}

# creo testata della lista
set list_head [iter_list_head  $form_di_ricerca $col_di_ricerca \
              $link_aggiungi $link_altre_pagine $link_righe "Righe per pagina"]

db_release_unused_handles
ad_return_template 

