ad_page_contract {
    Lista tabella "coimcout" (Comuni associati ad un utente)

    @author                  Nicola Mortoni (clonato da coimuten-list)
    @creation-date           12/11/2013

    @param caller            se diverso da index rappresenta il nome del form 
                             da cui e' partita la ricerca ed in questo caso
                             imposta solo azione "sel"
    @param nome_funz         identifica l'entrata di menu,
                             serve per le autorizzazioni
    @param nome_funz_caller  identifica l'entrata di menu,
                             serve per la navigation bar
    @param extra_par         Variabili extra da restituire alla lista chiamante
    @param receiving_element nomi dei campi di form che riceveranno gli
                             argomenti restituiti dallo script di zoom,
                             separati da '|' ed impostarli come segue:

    @cvs-id coimcout-comu-list.tcl 
} { 
   {cod_utente        ""}
   {last_utente       ""}
    
   {caller            "index"}
   {nome_funz         ""}
   {nome_funz_caller  ""} 
   {receiving_element ""}
   {extra_par         ""}
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

set page_title  "Lista Comuni associati all'Utente $cod_utente"

set context_bar [iter_context_bar -nome_funz $nome_funz_caller]

set link_list_script {[export_url_vars last_utente caller nome_funz_caller nome_funz]&[iter_set_url_vars $extra_par]}
set link_list        [subst $link_list_script]

# imposto le variabili da usare nel frammento html di testata della lista.
set curr_prog       [file tail [ns_conn url]]
set gest_prog       "coimcout-gest"
set form_di_ricerca ""
set col_di_ricerca  ""
set extra_par       [list receiving_element $receiving_element]
set url_cout_comu_list [list [ad_conn url]?[export_ns_set_vars url]]
set link_aggiungi   "<a href=\"$gest_prog?funzione=I&[export_url_vars cod_utente caller nome_funz extra_par nome_funz_caller url_cout_comu_list]\">Aggiungi</a>"

set rows_per_page   ""
set link_righe      ""

set link    "\[export_url_vars cod_utente cod_comune nome_funz nome_funz_caller extra_par url_cout_comu_list\]"
set actions "
<td nowrap><a href=\"$gest_prog?funzione=D&$link\">Cancella</a></td>"
set js_function ""

# imposto la struttura della tabella
set table_def [list \
        [list actions       "Azioni" no_sort $actions] \
    	[list denominazione "Comune" no_sort {l}] \
]

# imposto la query SQL 
set sel_cout "
      select b.denominazione
           , b.cod_comune
        from coimcout a
           , coimcomu b
       where a.id_utente  = :cod_utente
         and b.cod_comune = a.cod_comune
    order by upper(b.denominazione)
           , b.cod_comune
"

set table_result [ad_table -Tmax_rows 99999 -Tmissing_text "Nessun dato corrisponde ai criteri impostati." -Textra_vars {cod_utente last_utente nome_funz nome_funz_caller extra_par url_cout_comu_list} go $sel_cout $table_def]

set link_altre_pagine ""

# creo testata della lista
set list_head [iter_list_head  $form_di_ricerca $col_di_ricerca \
              $link_aggiungi $link_altre_pagine $link_righe "Righe per pagina"]

db_release_unused_handles
ad_return_template 
