ad_page_contract {
    Lista tabella "coimmode"

    @author                  Nicola Mortoni (clonato da coimopma-list)
    @creation-date           19/03/2014

    @param search_word       parola da ricercare con una query
    @param rows_per_page     una delle dimensioni della tabella

    @param caller            se diverso da index rappresenta il nome del form da cui è partita
    @                        la ricerca ed in questo caso imposta solo azione "sel"

    @param nome_funz         identifica l'entrata di menu, serve per le autorizzazioni
    @param nome_funz_caller  identifica l'entrata di menu, serve per la navigation bar

    @param receiving_element nomi dei campi di form che riceveranno gli argomenti restituiti
    @                        dallo script di zoom, separati da '|' ed impostarli come segue:
                             
    @cvs-id coimmode-list.tcl 

    USER  DATA       MODIFICHE
    ===== ========== =======================================================================
    nic01 27/07/2015 Il Comune di Rimini ha chiesto che l'ordinamento non sia piu' per 
    nic01            descrizione + codice ma per descrizione + flag_attivo + codice.
    nic01            Prima vuole gli attivi 'S', poi i non attivi 'N' e poi gli altri.
    nic01            Ho condiviso con Sandro di scambiare anche le colonne nella table html.
} { 
    {search_word       ""}
    {rows_per_page     ""}
    {caller       "index"}
    {nome_funz         ""}
    {nome_funz_caller  ""} 
    {receiving_element ""}
    {last_key_order_by ""}

    {cod_cost          ""}
    {url_cost          ""}
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
    if {$id_utente == ""} {
	set login [ad_conn package_url]
	iter_return_complaint "Per accedere a questo programma devi prima eseguire la procedura di <a href=$login>Login.</a>"
	return 0
    }
}

# controllo il parametro di "propagazione" per la navigation bar
if {[string is space $nome_funz_caller]} {
    set nome_funz_caller $nome_funz
}

if {![db_0or1row query "select descr_cost
                          from coimcost
                         where cod_cost = :cod_cost"]
} {
    if {$caller != "index"} {
	iter_return_complaint "Costruttore non trovato, <a href=\"javascript:window.close()\">Ritorna</a>"
    } else {
	iter_return_complaint "Costruttore non trovato"
    }
}

set page_title      "Lista modelli del costruttore $descr_cost"

if {$caller == "index"} {
    set context_bar [iter_context_bar -nome_funz $nome_funz_caller]
} else {
    set context_bar [iter_context_bar \
                    [list "javascript:window.close()" "Ritorna"] \
                    "$page_title"]
}

# imposto le variabili da usare nel frammento html di testata della lista.
set curr_prog       [file tail [ns_conn url]]
set gest_prog       "coimmode-gest"
set form_di_ricerca [iter_search_form $curr_prog $search_word]
set col_di_ricerca  "Descrizione"
set extra_par       [list rows_per_page     $rows_per_page \
                          receiving_element $receiving_element \
			  search_word       $search_word]
set link_aggiungi   "<a href=\"$gest_prog?funzione=I&[export_url_vars cod_cost last_key_order_by caller nome_funz extra_par nome_funz_caller url_cost]\">Aggiungi</a>"
set rows_per_page   [iter_set_rows_per_page $rows_per_page $id_utente]
set link_righe      [iter_rows_per_page     $rows_per_page]

if {$caller == "index"} {
    set link    "\[export_url_vars extra_par cod_cost cod_mode last_key_order_by nome_funz nome_funz_caller url_cost\]"
    set actions "
    <td nowrap><a href=\"$gest_prog?funzione=V&$link\">Selez.</a></td>"
    set js_function ""
} else { 
    set actions [iter_select [list cod_mode descr_mode]]
    set receiving_element [split $receiving_element |]
    set js_function [iter_selected $caller [list [lindex $receiving_element 0] cod_mode [lindex $receiving_element 1] descr_mode]]
}

# imposto la struttura della tabella
# nic01: Prima c'era cod_mode, descr_mode e flag_attivo; ora flag_attivo, descr_mode e cod_mode
set table_def [list \
        [list actions     "Azioni"      no_sort $actions] \
	[list flag_attivo "Attivo"      no_sort      {c}] \
	[list descr_mode  "Descrizione" no_sort      {l}] \
    	[list cod_mode    "Cod."        no_sort      {r}] \
	[list note        "Note"        no_sort      {l}] \
]

# imposto la query SQL 
if {[string equal $search_word ""]} {
    set where_word ""
} else {
    set search_word_1 [iter_search_word $search_word]
    set where_word  " and upper(descr_mode) like upper(:search_word_1)"
}

# imposto la condizione per la prossima pagina
set function_flag_attivo "case when flag_attivo in ('S','N') then
                               flag_attivo
                          else
                               'A' -- devo pulire caratteri sporchi
                          end"

if {![string is space $last_key_order_by]} {
    #nic01 set descr_mode     [lindex $last_key_order_by 0]
    #nic01 set cod_mode       [lindex $last_key_order_by 1]

    set flag_attivo_sistemato [lindex $last_key_order_by 0];#nic01
    set descr_mode            [lindex $last_key_order_by 1];#nic01
    set cod_mode              [lindex $last_key_order_by 2];#nic01

    set where_last "  and (
                              (    $function_flag_attivo  = :flag_attivo_sistemato    -- nic01
                               and descr_mode             = :descr_mode 
                               and cod_mode              >= :cod_mode
                              )
                           or (    $function_flag_attivo  = :flag_attivo_sistemato    -- nic01
                               and descr_mode             > :descr_mode
                              )
                                -- metto < perche' flag_attivo e' ordinato descending -- nic01
                           or      $function_flag_attivo  < :flag_attivo_sistemato    -- nic01

                          )
                   "
} else {
    set where_last ""
}

set sql_query "
  select cod_mode
       , descr_mode
       , case
         when flag_attivo = 'S' then 'S&igrave'
         when flag_attivo = 'N' then 'No'
         else ''
         end                   as flag_attivo
       , substr(note,1,35)     as note
       , $function_flag_attivo as flag_attivo_sistemato -- nic01
    from coimmode
   where cod_cost = :cod_cost
  $where_last
  $where_word
--nic01 order by descr_mode
--nic01        , cod_mode
order by $function_flag_attivo desc -- nic01 -- prima gli 'S', poi gli 'N' e poi il resto
       , descr_mode            asc  -- nic01
       , cod_mode              asc  -- nic01
"

#nic01: ho aggiunto flag_attivo_sistemato alle extra_vars
set table_result [ad_table -Tmax_rows $rows_per_page -Tmissing_text "Nessun dato corrisponde ai criteri impostati." -Textra_vars {cod_cost flag_attivo_sistemato descr_mode cod_mode last_key_order_by nome_funz nome_funz_caller extra_par url_cost} go $sql_query $table_def]

# preparo url escludendo last_key_order_by che viene passato esplicitamente
# per poi preparare il link alla prima ed eventualmente alla prossima pagina
set url_vars [export_ns_set_vars "url" last_key_order_by]
set link_altre_pagine "Vai alla <a href=\"$curr_prog?$url_vars\">prima pagina</a>"

# preparo link a pagina successiva
set ctr_rec [expr [regsub -all <tr $table_result <tr comodo] -1]
if {$ctr_rec == $rows_per_page} {
    #nic01 set last_key_order_by [list $descr_mode $cod_mode]
    set last_key_order_by        [list $flag_attivo_sistemato $descr_mode $cod_mode]
    append url_vars "&[export_url_vars last_key_order_by]"
    append link_altre_pagine " o alla <a href=\"$curr_prog?$url_vars\">pagina successiva</a>"
}

# creo testata della lista
set list_head [iter_list_head  $form_di_ricerca $col_di_ricerca \
              $link_aggiungi $link_altre_pagine $link_righe "Righe per pagina"]

db_release_unused_handles
ad_return_template 

