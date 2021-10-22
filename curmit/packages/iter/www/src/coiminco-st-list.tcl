ad_page_contract {
    Lista tabella "coiminco"

    @author                  adhoc
    @creation-date           19/08/2004

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

    @cvs-id coiminco-list.tcl 
} {
    {search_word       ""}
    {rows_per_page     ""}
    {caller       "index"}
    {nome_funz         ""}
    {nome_funz_caller  ""} 
    {receiving_element ""}
    {last_cod_inco     ""}

   {extra_par        ""}
   {extra_par_inco   ""}
    {cod_inco          ""}
    {cod_impianto      ""}
    {num_rec           ""}
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
    if {$id_utente  == ""} {
	set login [ad_conn package_url]
	iter_return_complaint "Per accedere a questo programma devi prima eseguire la procedura di <a href=$login>Login.</a>"
	return 0
    }
}

set desc_enve [db_map descrizione_enve_opve]
set title_enve "Ente Verif"
# controllo se l'utente è il responsabile dell'ente verificatore

set link_tab ""
set dett_tab ""

iter_get_coimtgen
set flag_viario $coimtgen(flag_viario)
set flag_ente   $coimtgen(flag_ente)
set sigla_prov  $coimtgen(sigla_prov)


# controllo il parametro di "propagazione" per la navigation bar
if {[string equal $nome_funz_caller ""]} {
    set nome_funz_caller $nome_funz
}

if {![string equal $extra_par_inco ""]} {
    set extra_par $extra_par_inco
}

# Personalizzo la pagina

set page_title "Lista storico incontro"
set context_bar [iter_context_bar -nome_funz $nome_funz_caller]

# imposto le variabili da usare nel frammento html di testata della lista.
set curr_prog       [file tail [ns_conn url]]
set gest_prog       "coiminco-st-gest"
set list_prog       "coiminco-st-list"
# escludo num_rec dalla form di ricerca per rieffettuare il conteggio
set form_di_ricerca [iter_search_form $curr_prog $search_word num_rec]
set col_di_ricerca  "Cognome"

set rows_per_page   [iter_set_rows_per_page $rows_per_page $id_utente]
set link_righe      [iter_rows_per_page     $rows_per_page]

set link_list_script {[export_url_vars last_cod_inco caller nome_funz_caller nome_funz cod_impianto]&[iter_set_url_vars $extra_par]}
set link_list         [subst $link_list_script]
set link    "\[export_url_vars cod_inco last_cod_inco st_progressivo nome_funz nome_funz_caller extra_par\]"
set actions "
    <td nowrap><a href=\"$gest_prog?$link\">Selez.</a></td>"
set js_function ""

# imposto la struttura della tabella
set table_def [list \
		   [list actions          "Azioni"       no_sort $actions] \
		   [list cod_inco         "Cod.App."     no_sort      {r}] \
		   [list cod_impianto_est "Cod.Imp."     no_sort      {l}] \
		   [list resp             "Responsabile" no_sort      {l}] \
		   [list comune           "Comune"       no_sort      {l}] \
		   [list indirizzo_ext    "Indirizzo"    no_sort      {l}] \
		   [list desc_stato       "Stato"        no_sort      {l}] \
		   [list tipo_app         "Tipo"         no_sort      {l}] \
		   [list st_utente        "Utente"       no_sort      {l}] \
		   [list st_data_validita "Data valid."  no_sort      {l}] \
		   [list st_ora_validita  "Ora valid."  no_sort      {l}] \
		  ]

# imposto la condizione SQL per cod_inco
set where_cond "
    and a.cod_inco = :cod_inco"


# imposto il filtro per tecnico ed ente verificatore
set pos_join_coimopve "left outer join coimopve"
set pos_join_coimenve "left outer join coimenve"
set ora_join_coimopve "(+)"
set ora_join_coimenve "(+)"

# filtro per parola di ricerca
set pos_join_coimcitt "left outer join coimcitt"
set ora_join_coimcitt "(+)"
if {![string equal $search_word ""]} {
    set search_word_1 [iter_search_word $search_word]
    set pos_join_coimcitt "     inner join coimcitt"
    set ora_join_coimcitt ""
    append where_cond  "
    and b.cognome like upper(:search_word_1)"
}

# posizionatore per pagina successiva
set where_last ""
if {$last_cod_inco != ""} {
    set cod_inco      [lindex $last_cod_inco 1]
    set where_last_si_vie "and a.cod_inco > :cod_inco"

    set where_last_no_vie "and a.cod_inco > :cod_inco"

} else {
    set where_last_si_vie ""
    set where_last_no_vie ""
}

if {[string equal $num_rec ""]} {
    set num_rec [db_string sel_inco_count ""]
}
set dett_num_rec "Appuntamenti selezionati: $num_rec"

if {$flag_viario == "T"} {
    set sel_inco [db_map sel_inco_si_vie]
} else {
    set sel_inco [db_map sel_inco_no_vie]
}
set table_result [ad_table -Tmax_rows $rows_per_page -Tmissing_text "Nessun dato corrisponde ai criteri impostati." -Textra_vars {last_cod_inco cod_inco cognome nome indirizzo nome_funz nome_funz_caller extra_par cod_impianto url_aimp url_list_aimp} go $sel_inco $table_def]

# preparo url escludendo last_cod_inco che viene passato esplicitamente
# per poi preparare il link alla prima ed eventualmente alla prossima pagina
set url_vars [export_ns_set_vars "url" "last_cod_inco num_rec"]&[export_url_vars num_rec]
set link_altre_pagine "Vai alla <a href=\"$curr_prog?$url_vars\">prima pagina</a>"

# preparo link a pagina successiva
set ctr_rec [expr [regsub -all <tr $table_result <tr comodo] -1]
if {$ctr_rec == $rows_per_page} {
    set last_cod_inco [list $indirizzo $cod_inco]
    append url_vars          "&[export_url_vars last_cod_inco]"
    append link_altre_pagine " o alla <a href=\"$curr_prog?$url_vars\">pagina successiva</a>"
}

# creo testata della lista
set list_head [iter_list_head $form_di_ricerca   $col_di_ricerca \
              $dett_num_rec   $link_altre_pagine $link_righe "Righe per pagina"]
db_release_unused_handles
ad_return_template 
