ad_page_contract {
    Lista tabella "coimgend" per selezione e richiamo inserimento R.V.

    @author                  Nicola Mortoni Adhoc
    @creation-date           07/02/2005

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
    @param extra_par         parametri extra da restituire a coimcimp-list
    @param last_cod_cimp     ultima chiave di coimcimp-list
    @param cod_impianto      impianti di cui bisogna visualizzare i generatori
    @param extra_par_inco    Parametri da restituire alla gestione appuntamenti.
    @param cod_inco         Codice appuntamento (tabella coiminco).

    @cvs-id coimgend-list.tcl 
} { 
   {search_word       ""}
   {rows_per_page     ""}
   {caller       "index"}
   {nome_funz         ""}
   {nome_funz_caller  ""} 
   {receiving_element ""}
   {extra_par         ""}
    cod_impianto
   {last_gen_prog     ""}
   {url_list_aimp     ""}
   {url_aimp          ""}
   {extra_par_inco   ""}
   {flag_tracciato   ""}
   {tabella         ""}
    {cod_dimp   ""}
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

set page_title      "Selezione Generatori"

set context_bar [iter_context_bar -nome_funz $nome_funz_caller]
# imposto la proc per i link e per il dettaglio impianto
#if {$flag_cimp == "S"} {
#    set link_tab [iter_links_form $cod_impianto $nome_funz_caller $url_list_aimp $url_aimp]
#} else {
    set link_tab ""
#}

# se il programma e' stato richiamato dalla gestione appuntamenti,
# preparo l'html di testata degli appuntamenti da usare nell'adp.
#if {$flag_inco == "S"} {
#    set link_inc [iter_link_inco $cod_inco $nome_funz_caller $url_list_aimp $url_aimp $nome_funz "" $extra_par_inco]
#} else {
    set link_inc ""
#}

# preparo l'html con i dati identificativi dell'impianto.
set dett_tab [iter_tab_form $cod_impianto]

# imposto le variabili da usare nel frammento html di testata della lista.
set curr_prog       [file tail [ns_conn url]]
set gest_prog       "coimdimp-gest"
set form_di_ricerca ""
set col_di_ricerca  ""
set link_aggiungi   ""

set rows_per_page   [iter_set_rows_per_page $rows_per_page $id_utente]
set link_righe      [iter_rows_per_page     $rows_per_page]


set link    "\[export_url_vars flag_tracciato cod_impianto gen_prog nome_funz nome_funz_caller extra_par caller url_aimp url_list_aimp  extra_par_inco cod_dimp tabella cod_dimp\]"
ns_log notice "Gacalin coimdimp-gend-list [export_url_vars flag_tracciato cod_impianto gen_prog nome_funz nome_funz_caller extra_par caller url_aimp url_list_aimp  extra_par_inco cod_dimp tabella cod_dimp]"
set actions "
    <td nowrap><a href=\"$gest_prog?funzione=I&tabella=$tabella&cod_dimp=$cod_dimp&$link\">Selez.</a></td>"
set js_function ""


# imposto la struttura della tabella
set table_def [list \
        [list actions             "Azioni"         no_sort $actions] \
    	[list gen_prog_est        "Num"            no_sort {r}] \
	[list descrizione         "Descrizione"    no_sort {l}] \
	[list matricola           "Matricola"      no_sort {l}] \
	[list modello             "Modello"        no_sort {l}] \
	[list descr_cost          "Costruttore"    no_sort {l}] \
	[list descr_comb          "Combustibile"   no_sort {l}] \
	[list data_installaz_edit "Data install"   no_sort {c}] \
	[list flag_attivo         "Attivo"         no_sort {c}] \
]

# imposto la query SQL 

# imposto la condizione per la prossima pagina
if {![string is space $last_gen_prog]} {
    set where_last " and gen_prog_est >= :last_gen_prog"
} else {
    set where_last ""
}

set sel_gend [db_map sel_gend]
set table_result [ad_table -Tmax_rows $rows_per_page -Tmissing_text "Nessun dato corrisponde ai criteri impostati." -Textra_vars {cod_impianto flag_tracciato gen_prog gen_prog_est last_gen_prog nome_funz nome_funz_caller extra_par last_cod_cimp url_list_aimp url_aimp extra_par extra_par_inco cod_inco flag_inco} go $sel_gend $table_def]


# preparo url escludendo last_gen_prog che viene passato esplicitamente
# per poi preparare il link alla prima ed eventualmente alla prossima pagina
set url_vars [export_ns_set_vars "url" last_gen_prog]
set link_altre_pagine "Vai alla <a href=\"$curr_prog?$url_vars\">prima pagina</a>"

# preparo link a pagina successiva
set ctr_rec [expr [regsub -all <tr $table_result <tr comodo] -1]
if {$ctr_rec == $rows_per_page} {
    set last_gen_prog $gen_prog_est
    append url_vars "&[export_url_vars last_gen_prog]"
    append link_altre_pagine " o alla <a href=\"$curr_prog?$url_vars\">pagina successiva</a>"
}

# creo testata della lista
set list_head [iter_list_head  $form_di_ricerca $col_di_ricerca \
              $link_aggiungi $link_altre_pagine $link_righe "Righe per pagina"]

db_release_unused_handles
ad_return_template 
