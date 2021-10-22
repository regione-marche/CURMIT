ad_page_contract {
    Lista tabella "coimmail"

    @author                  Luca Romitti
    @creation-date           30/03/2018

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

    @cvs-id coimcomu-list.tcl 

    USER  DATA       MODIFICHE
    ===== ========== =======================================================================


} { 
    {search_word            ""}
    {rows_per_page          ""}
    {caller                 "index"}
    {nome_funz              ""}
    {receiving_element      ""}
    {id_mail                ""}
    {destinatario           ""}
    {last_id_mail           ""}
    {last_destinatario      ""}
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

set page_title      "Lista Mail inviate"


set context_bar [iter_context_bar -nome_funz $nome_funz]


# imposto le variabili da usare nel frammento html di testata della lista.
set curr_prog       [file tail [ns_conn url]]
set gest_prog       "coimmail-gest"
set form_di_ricerca [iter_search_form $curr_prog $search_word]
set col_di_ricerca  "Destinatario"
set extra_par       [list rows_per_page     $rows_per_page \
                          receiving_element $receiving_element]


set rows_per_page   [iter_set_rows_per_page $rows_per_page $id_utente]
set link_righe      [iter_rows_per_page     $rows_per_page]


set link_aggiungi ""
    set link    "\[export_url_vars nome_funz last_id_mail id_mail last_destinatario destinatario extra_par\]"
    set actions "
    <td nowrap><a href=\"$gest_prog?funzione=V&$link\">Selez.</a></td>"
    set js_function ""


# imposto la struttura della tabella
 
set table_def [list \
		   [list actions       "Azioni"        no_sort $actions] \
		   [list data_ins      "Data invio"    no_sort {l}] \
		   [list mittente      "Mittente"      no_sort {l}] \
		   [list destinatario  "Destinatario"  no_sort {l}] \
		   [list cc            "CC"            no_sort {l}] \
		   [list oggetto       "Oggetto"       no_sort {l}] \
		   [list path_allegato "Allegato"      no_sort {<td align=center><a href=\"$allegato\">$nome_file</a></td>}] \
]

# imposto la query SQL
if {[string equal $search_word ""]} {
    set where_word ""
} else {
    set search_word_1 [iter_search_word $search_word]
 #   ns_return 200 text/html "--$search_word_1--"; return
    set where_word  " and (a.destinatario) like (:search_word_1)"
}

# imposto la condizione per la prossima pagina
if {![string is space $last_id_mail]} {
    set where_last "  and   a.id_mail      <= :last_id_mail"
} else {
    set where_last ""
}

set sql_query [db_map sql_query]

set table_result [ad_table -Tmax_rows $rows_per_page -Tmissing_text "Nessun dato corrisponde ai criteri impostati." -Textra_vars {id_mail last_id_mail last_destinatario destinatario mittente nome_funz extra_par path_allegato} go $sql_query $table_def]

# preparo url escludendo last_id_mail/mittente che viene
# passato esplicitamente
# per poi preparare il link alla prima ed eventualmente alla prossima pagina
set url_vars [export_url_vars nome_funz search_word rows_per_page]
set link_altre_pagine "Vai alla <a href=\"$curr_prog?$url_vars\">prima pagina</a>"

# preparo link a pagina successiva
set ctr_rec [expr [regsub -all <tr $table_result <tr comodo] -1]
if {$ctr_rec == $rows_per_page} {
    set last_id_mail    $id_mail
    append url_vars "&[export_url_vars last_id_mail]"
    append link_altre_pagine " o alla <a href=\"$curr_prog?$url_vars\">pagina successiva</a>"
}

# creo testata della lista
set list_head [iter_list_head  $form_di_ricerca $col_di_ricerca \
		   $link_aggiungi $link_altre_pagine $link_righe "Righe per pagina"]

db_release_unused_handles
ad_return_template 

