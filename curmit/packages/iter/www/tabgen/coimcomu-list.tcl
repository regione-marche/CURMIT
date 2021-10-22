ad_page_contract {
    Lista tabella "coimcomu"

    @author                  Adhoc
    @creation-date           20/02/2004

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
    sim01 25/10/2016 Gestito nuovo flag flag_viario_manutentore

} { 
   {search_word            ""}
   {rows_per_page          ""}
   {caller            "index"}
   {nome_funz              ""}
   {receiving_element      ""}
   {last_cod_comune        ""}
   {last_denominazione     ""}
   {denominazione          ""}
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

set page_title      "Lista Comuni"


if {$caller == "index"} {
    set context_bar [iter_context_bar -nome_funz $nome_funz]
} else {
    set context_bar [iter_context_bar \
                    [list "javascript:window.close()" "Torna alla Gestione"] \
                    "$page_title"]
}

# imposto le variabili da usare nel frammento html di testata della lista.
set curr_prog       [file tail [ns_conn url]]
set gest_prog       "coimcomu-gest"
set form_di_ricerca [iter_search_form $curr_prog $search_word]
set col_di_ricerca  "Denominazione"
set extra_par       [list rows_per_page     $rows_per_page \
                          receiving_element $receiving_element]


set rows_per_page   [iter_set_rows_per_page $rows_per_page $id_utente]
set link_righe      [iter_rows_per_page     $rows_per_page]


if {$caller == "index"} {
    set link_aggiungi   "<a href=\"$gest_prog?funzione=I&[export_url_vars last_cod_comune last_denominazione caller nome_funz extra_par]\">Aggiungi</a>"
    set link    "\[export_url_vars cod_comune last_cod_comune last_denominazione nome_funz extra_par\]"
    set actions "
    <td nowrap><a href=\"$gest_prog?funzione=V&$link\">Selez.</a></td>"
    set js_function ""
} else { 
    set link_aggiungi ""
    set actions [iter_select [list cod_comune denominazione sigla cap]]
    set receiving_element [split $receiving_element |]
    set js_function [iter_selected $caller [list [lindex $receiving_element 0]  cod_comune [lindex $receiving_element 1] denominazione  [lindex $receiving_element 2] sigla [lindex $receiving_element 3] cap ]]
}


# imposto la struttura della tabella
#sim01 aggiunto flag_viario_manutentore
set table_def [list \
        [list actions       "Azioni"   no_sort $actions] \
        [list cod_istat     "Cod. ISTAT"    no_sort {l}] \
        [list denominazione "Denominazione" no_sort {l}] \
	[list sigla         "Sigla"         no_sort {c}] \
	[list cap           "C.A.P"         no_sort {l}] \
	[list id_belfiore   "Cod.Belfiore"  no_sort {l}] \
        [list flag_val      "Valido"        no_sort {c}] \
		   [list flag_viario_manutentore "Viario man." no_sort {c}] \
]

# imposto la query SQL
if {[string equal $search_word ""]} {
    set where_word ""
} else {
    set search_word_1 [iter_search_word $search_word]
 #   ns_return 200 text/html "--$search_word_1--"; return
    set where_word  " and upper(a.denominazione) like upper(:search_word_1)"
}

# imposto la condizione per la prossima pagina
if {![string is space $last_cod_comune]
&&  ![string is space $last_denominazione]} {
    set where_last " and ((a.denominazione =  :last_denominazione
                     and   a.cod_comune    >= :last_cod_comune)
                      or   a.denominazione >  :last_denominazione)"
} else {
    set where_last ""
}

set sql_query [db_map sql_query]

set table_result [ad_table -Tmax_rows $rows_per_page -Tmissing_text "Nessun dato corrisponde ai criteri impostati." -Textra_vars {cod_comune last_cod_comune last_denominazione denominazione nome_funz extra_par} go $sql_query $table_def]

# preparo url escludendo last_cod_comune/denominazione che viene
# passato esplicitamente
# per poi preparare il link alla prima ed eventualmente alla prossima pagina
set url_vars [export_ns_set_vars "url" "last_cod_comune last_denominazione"]
set link_altre_pagine "Vai alla <a href=\"$curr_prog?$url_vars\">prima pagina</a>"

# preparo link a pagina successiva
set ctr_rec [expr [regsub -all <tr $table_result <tr comodo] -1]
if {$ctr_rec == $rows_per_page} {
    set last_cod_comune    $cod_comune
    set last_denominazione $denominazione
    append url_vars "&[export_url_vars last_cod_comune last_denominazione]"
    append link_altre_pagine " o alla <a href=\"$curr_prog?$url_vars\">pagina successiva</a>"
}

# creo testata della lista
set list_head [iter_list_head  $form_di_ricerca $col_di_ricerca \
              $link_aggiungi $link_altre_pagine $link_righe "Righe per pagina"]

db_release_unused_handles
ad_return_template 

