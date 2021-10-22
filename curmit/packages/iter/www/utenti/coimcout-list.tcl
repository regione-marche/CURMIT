ad_page_contract {
    Lista tabella "coimuten" per assegnazione comuni

    @author                  Nicola Mortoni (clonato da coimuten-list)
    @creation-date           12/11/2013

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

    @cvs-id coimcout-list.tcl 
} { 
   {search_word       ""}
   {rows_per_page     ""}
   {caller            "index"}
   {nome_funz         ""}
   {nome_funz_caller  ""} 
   {receiving_element ""}
   {last_utente ""}
}  -properties {
    page_title:onevalue
    context_bar:onevalue
    list_head:onevalue
    table_result:onevalue
}

# TODO: Aggiungere il/i parametro/i necessari a filtrare la query

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

set page_title      "Lista Utenti per associazione Comuni"

set context_bar [iter_context_bar -nome_funz $nome_funz_caller]

# Richiamo la procedura iter_get_coimtgen per verificare se sono o meno in un ente regionale
iter_get_coimtgen
# identifico settore e ruolo a cui appartiene l'utente
db_1row select_profilo_utente "select id_settore
                                    , id_ruolo
                                 from coimuten
                                where id_utente = :id_utente"

# imposto le variabili da usare nel frammento html di testata della lista.
set curr_prog       [file tail [ns_conn url]]
set gest_prog       "coimcout-comu-list"
set form_di_ricerca [iter_search_form $curr_prog $search_word]
set col_di_ricerca  "Cognome"
set extra_par       [list rows_per_page     $rows_per_page \
                          search_word       $search_word \
                          receiving_element $receiving_element]
set link_aggiungi   ""
set rows_per_page   [iter_set_rows_per_page $rows_per_page $id_utente]
set link_righe      [iter_rows_per_page     $rows_per_page]

set link    "\[export_url_vars cod_utente last_utente nome_funz nome_funz_caller extra_par\]"
set actions "
<td nowrap><a href=\"$gest_prog?funzione=V&$link\">Selez.</a></td>"
set js_function ""

# imposto la struttura della tabella
set table_def [list \
        [list actions      "Azioni"   no_sort $actions] \
    	[list cognome      "Cognome"  no_sort {l}] \
	[list nome         "Nome"     no_sort {l}] \
	[list id_settore   "Settore"  no_sort {l}] \
	[list id_ruolo     "Ruolo"    no_sort {l}] \
	[list livello      "Livello"  no_sort {r}] \
]

# imposto la query SQL 

if {[string equal $search_word ""]} {
    set where_word ""
} else {
    set search_word_1 [iter_search_word $search_word]
    set where_word  " and upper(cognome) like upper(:search_word_1)"
}

# Se l'utente non appartiene alla regione, non estraggo gli utenti regionali
set flag_regione ""
if {($coimtgen(flag_ente) ne "R") && ($id_settore ne "system")} {
    set flag_regione " and id_settore != 'regione' and id_settore != 'system'"
}
if {($coimtgen(flag_ente) eq "R") && ($id_settore ne "system")} {
    set flag_regione " and id_settore != 'system'"
}

# imposto la condizione per la prossima pagina
if {![string is space $last_utente]} {
    set cognome    [lindex $last_utente 0]
    set nome       [lindex $last_utente 1]
    set cod_utente [lindex $last_utente 2]
    set where_last " and ( cognome >= :cognome
                      or  (cognome = :cognome
                       and nome    >= :nome)
                      or  (cognome = :cognome
                       and nome    = :nome
                       and id_utente >= :cod_utente)
                     )"
} else {
    set where_last ""
}

set sel_uten "select id_utente as cod_utente
                   , cognome
                   , nome
                   , id_settore
                   , id_ruolo
                   , livello
                from coimuten
               where 1 = 1
                 and id_ruolo <> 'manutentore'
                 $flag_regione
                 $where_last
                 $where_word
            order by cognome
                   , nome
                   , id_utente"

set table_result [ad_table -Tmax_rows $rows_per_page -Tmissing_text "Nessun dato corrisponde ai criteri impostati." -Textra_vars {cod_utente last_utente nome_funz nome_funz_caller extra_par cognome nome} go $sel_uten $table_def]

# preparo url escludendo last_utente che viene passato esplicitamente
# per poi preparare il link alla prima ed eventualmente alla prossima pagina
set url_vars [export_ns_set_vars "url" last_utente]
set link_altre_pagine "Vai alla <a href=\"$curr_prog?$url_vars\">prima pagina</a>"

# preparo link a pagina successiva
set ctr_rec [expr [regsub -all <tr $table_result <tr comodo] -1]
if {$ctr_rec == $rows_per_page} {
    set last_utente [list $cognome $nome $cod_utente]
    append url_vars "&[export_url_vars last_utente]"
    append link_altre_pagine " o alla <a href=\"$curr_prog?$url_vars\">pagina successiva</a>"
}

# creo testata della lista
set list_head [iter_list_head  $form_di_ricerca $col_di_ricerca \
              $link_aggiungi $link_altre_pagine $link_righe "Righe per pagina"]

db_release_unused_handles
ad_return_template 
