ad_page_contract {
    Lista tabella "coimtari"

    @author                  Giulio Laurenzi
    @creation-date           19/05/2004

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

    @cvs-id coimtari-list.tcl 

    USER  DATA       MODIFICHE
    ===== ========== ==========================================================================
    sim02 29/06/2016 Aggiunte colonne flag_tariffa_impianti_vecchi, anni_fine_tariffa_base e
    sim02            tariffa_impianti_vecchi per gestire le tariffe della Regione Calabria
    
} { 
    {cod_listino ""}
    {descrizione ""}
    {search_word       ""}
    {rows_per_page     ""}
    {caller            "index"}
    {nome_funz         ""}
    {nome_funz_caller  ""} 
    {receiving_element ""}
    {tipo_costo ""}
    {cod_potenza ""}
    {last_tari ""}
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
    set id_utente [iter_get_id_utente]
}

# controllo il parametro di "propagazione" per la navigation bar
if {[string is space $nome_funz_caller]} {
    set nome_funz_caller $nome_funz
}

set page_title      "Lista Tariffe"

set context_bar [iter_context_bar -nome_funz $nome_funz_caller]

# imposto le variabili da usare nel frammento html di testata della lista.
set curr_prog       [file tail [ns_conn url]]
set gest_prog       "coimtari-gest"
set form_di_ricerca ""
set col_di_ricerca  ""
set extra_par       [list rows_per_page     $rows_per_page \
                          receiving_element $receiving_element]
set link_aggiungi   "<a href=\"$gest_prog?funzione=I&[export_url_vars tipo_costo cod_listino descrizione cod_potenza last_tari caller nome_funz extra_par nome_funz_caller]\">Aggiungi</a>"
set rows_per_page   [iter_set_rows_per_page $rows_per_page $id_utente]
set link_righe      [iter_rows_per_page     $rows_per_page]

set link    "\[export_url_vars tipo_costo cod_listino descrizione cod_potenza data_inizio last_tari nome_funz nome_funz_caller extra_par\]"
set actions "
<td nowrap><a href=\"$gest_prog?funzione=V&cod_listino=$cod_listino&descrizione=$descrizione&$link\">Selez.</a></td>"
set js_function ""

# imposto la struttura della tabella
# sim02: ho aggiunto le colonne flag_tariffa_impianti_vecchi, anni_fine_tariffa_base e
#        tariffa_impianti_vecchi
set table_def [list \
[list actions                      "Azioni"          no_sort $actions] \
[list tipo_costo_edit              "Tipo costo"      no_sort {l}] \
[list descr_potenza                "Fascia potenza"  no_sort {l}] \
[list data_inizio_edit             "Data inizio"     no_sort {c}] \
[list importo_edit                 "Tariffa base"    no_sort {r}] \
[list flag_tariffa_impianti_vecchi "Usare la 2&deg; tariffa<br>per impianti vecchi?" no_sort {c}] \
[list anni_fine_tariffa_base       "N&deg; anni oltre i quali<br>applicare la 2&deg; tariffa" no_sort {c}] \
[list tariffa_impianti_vecchi_edit "Tariffa per<br>impianti vecchi" no_sort {r}] \
]

# imposto la query SQL 

# imposto la condizione per la prossima pagina
if {![string is space $last_tari]} {
    set tipo_costo  [lindex $last_tari 0]
    set cod_potenza [lindex $last_tari 1]
    set data_inizio [lindex $last_tari 2]
    set where_last " and (    a.tipo_costo  > :tipo_costo 
                        or ( a.tipo_costo  = :tipo_costo 
                         and a.cod_potenza > :cod_potenza)
                        or ( a.tipo_costo  = :tipo_costo 
                         and a.cod_potenza = :cod_potenza
                         and a.data_inizio > :data_inizio)
                    )"
} else {
    set where_last ""
}

set sel_tari [db_map sel_tari]

set table_result [ad_table -Tmax_rows $rows_per_page -Tmissing_text "Nessun dato corrisponde ai criteri impostati." -Textra_vars {tipo_costo cod_potenza data_inizio last_tari nome_funz nome_funz_caller extra_par} go $sel_tari $table_def]

# preparo url escludendo last_tari che viene passato esplicitamente
# per poi preparare il link alla prima ed eventualmente alla prossima pagina
set url_vars [export_ns_set_vars "url" last_tari]
set link_altre_pagine "Vai alla <a href=\"$curr_prog?$url_vars\">prima pagina</a>"

# preparo link a pagina successiva
set ctr_rec [expr [regsub -all <tr $table_result <tr comodo] -1]
if {$ctr_rec == $rows_per_page} {
    set last_tari [list $tipo_costo $cod_potenza $data_inizio]
    append url_vars "&[export_url_vars last_tari]"
    append link_altre_pagine " o alla <a href=\"$curr_prog?$url_vars\">pagina successiva</a>"
}

# creo testata della lista
set list_head [iter_list_head  $form_di_ricerca $col_di_ricerca \
              $link_aggiungi $link_altre_pagine $link_righe "Righe per pagina"]

db_release_unused_handles
ad_return_template 

