ad_page_contract {
    Lista tabella "coimviae"

    @author                  Giulio Laurenzi
    @creation-date           13/01/2004

    @param search_word       parola da ricercare con una query
    @param rows_per_page     una delle dimensioni della tabella  

    @param caller            se diverso da index rappresenta il nome del form 
    @                        da cui e' partita la ricerca ed in questo caso
    @                        imposta solo azione "sel"

    @param nome_funz         identifica l'entrata di menu,
    @                        serve per le autorizzazioni

    @param receiving_element nomi dei campi di form che riceveranno gli
    @                        argomenti restituiti dallo script di zoom,
    @                        separati da '|' ed impostarli come segue:

    @cvs-id coimviae-list.tcl 

    USER  DATA       MODIFICHE
    ===== ========== =======================================================================
    sim01 25/10/2016 Aggiunto gestione della visulizzazione del link aggiungi ai manutentori
    sim01            in base al flag flag_viario_manutentore della coimcomu 

    gab01 02/05/2016 Aggiunta colonna cod_zona.

} { 
    {search_word       ""}
    {rows_per_page     ""}
    {caller            "index"}
    {nome_funz         ""}
    {receiving_element ""}
    {last_cod_via      ""}
    {cod_comune        ""}
    {soloatt           ""}
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

set cod_manu [iter_check_uten_manu $id_utente];#sim01

iter_get_coimtgen

set page_title      "Lista Viario"
if {$caller == "index"} {
    set context_bar [iter_context_bar -nome_funz $nome_funz]
} else {
    set context_bar [iter_context_bar \
			 [list "javascript:window.close()" "Torna alla Gestione"] \
			 "$page_title"]
}

# preparo link per ritorna al filtro:
set link_filter [export_url_vars caller nome_funz receiving_element]

# imposto le variabili da usare nel frammento html di testata della lista.
set curr_prog       [file tail [ns_conn url]]
set gest_prog       "coimviae-gest"
set form_di_ricerca [iter_search_form $curr_prog $search_word]
set col_di_ricerca  "Descrizione"
set extra_par       [list rows_per_page     $rows_per_page \
			 receiving_element $receiving_element]
set rows_per_page   [iter_set_rows_per_page $rows_per_page $id_utente]
set link_righe      [iter_rows_per_page     $rows_per_page]


set cod_manu [iter_check_uten_manu $id_utente];#sim01

db_0or1row q "select flag_viario_manutentore
                from coimcomu
               where cod_comune = :cod_comune";#sim01

if {$caller == "index"} {

    if {$cod_manu eq "" || $flag_viario_manutentore eq "T"} {#sim01

	set link_aggiungi "<a href=\"$gest_prog?funzione=I&[export_url_vars last_cod_via cod_comune caller nome_funz extra_par]\">Aggiungi</a>"
	
    } else {#sim01 else suo contenuto
	set link_aggiungi ""
    }

    set link "\[export_url_vars cod_via cod_comune last_cod_via nome_funz extra_par\]"
    set actions "
    <td nowrap><a href=\"$gest_prog?funzione=V&$link\">Selez.</a></td>"
    set js_function ""
    
} else {
    set link_aggiungi "" 
    set actions [iter_select [list cod_via descrizione descr_topo cod_comune cap]]
    set receiving_element [split $receiving_element |]
    set js_function [iter_selected $caller [list [lindex $receiving_element 0]  cod_via [lindex $receiving_element 1] descrizione [lindex $receiving_element 2] descr_topo [lindex $receiving_element 3] cod_comune [lindex $receiving_element 4] cap [lindex $receiving_element 5] soloatt]]
}

# imposto la struttura della tabella
set table_def [list \
		   [list actions      "Azioni"           no_sort $actions] \
		   [list cod_via      "Codice"           no_sort      {l}] \
		   [list descr_topo   "Toponimo"         no_sort      {l}] \
		   [list descrizione  "Descrizione"      no_sort      {l}] \
		   [list descr_estesa "Descr. Estesa"    no_sort      {l}] \
		   [list denom_comune "Comune"           no_sort      {l}] \
		   [list cap          "CAP"              no_sort      {l}] \
		   [list cod_zona     "Zone geografiche" no_sort      {l}] \
		   [list da_numero    "Da Numero"        no_sort      {l}] \
		   [list a_numero     "A Numero"         no_sort      {l}] \
		  ]

# imposto la query SQL 
if {[string equal $search_word ""]} {
    set where_word ""
} else {
    #    set search_word_1 [iter_search_word $search_word]
    regsub -all {\*} $search_word {} search_word_1
    set search_word_1 "%$search_word_1%"
    set where_word  " and a.descrizione like upper(:search_word_1)"
}

# imposto la condizione per la prossima pagina
if {![string is space $last_cod_via]} {
    set descrizione    [lindex $last_cod_via 0]
    set cod_via        [lindex $last_cod_via 1]
    set where_last " and ( (trim(a.descrizione) = trim(upper(:descrizione))
                          and  a.cod_via       >= :cod_via)  
                         or trim(a.descrizione) > trim(upper(:descrizione)) )" 
} else {
    set where_last ""
}

if {[db_0or1row sel_comu ""] == 0} {
    iter_return_complaint "Comune non trovato"
}

set where_disattiva ""

if {$caller == "coimaimpins" || $caller == "coimubic" || $soloatt == "s" } {
    set where_disattiva " and a.disattiva is null"
}

set sql_query    [db_map sel_viae]

set table_result [ad_table -Tmax_rows $rows_per_page -Tmissing_text "Nessun dato corrisponde ai criteri impostati." -Textra_vars {cod_via cod_comune denom_comune descrizione descr_topo cap cod_zona da_numero a_numero descr_qua last_cod_via nome_funz extra_par} go $sql_query $table_def]

# preparo url escludendo last_cod_via che viene passato esplicitamente
# per poi preparare il link alla prima ed eventualmente alla prossima pagina
set url_vars [export_ns_set_vars "url" last_cod_via]
set link_altre_pagine "Vai alla <a href=\"$curr_prog?$url_vars\">prima pagina</a>"

# preparo link a pagina successiva
set ctr_rec [expr [regsub -all <tr $table_result <tr comodo] -1]
if {$ctr_rec == $rows_per_page} {
    set last_cod_via [list $descrizione $cod_via]
    append url_vars "&[export_url_vars last_cod_via]"
    append link_altre_pagine " o alla <a href=\"$curr_prog?$url_vars\">pagina successiva</a>"
}

# creo testata della lista
set list_head [iter_list_head  $form_di_ricerca $col_di_ricerca \
		   $link_aggiungi $link_altre_pagine $link_righe "Righe per pagina"]

db_release_unused_handles
ad_return_template 

