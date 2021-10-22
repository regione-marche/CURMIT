ad_page_contract {
    Lista tabella "coimtpin"

    @author                  Romitti Luca
    @creation-date           05/04/2019

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

    @cvs-id coimtpin-list.tcl 
} { 
    {caller       "index"}
    {nome_funz         ""}
    {nome_funz_caller  ""} 
    {receiving_element ""}
    {cod_manutentore   ""}
    {fstato            ""}
    {url_manu          ""}
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

# controllo il parametro di "propagazione" per la navigation bar
if {[string is space $nome_funz_caller]} {
    set nome_funz_caller $nome_funz
}

set page_title      "Lista tipoligie Impianto su cui l'Impresa opera"

if {$caller == "index"} {
    set context_bar [iter_context_bar -nome_funz $nome_funz_caller]
} else {
    set context_bar [iter_context_bar \
                    [list "javascript:window.close()" "Ritorna"] \
                    "$page_title"]
}


# imposto le variabili da usare nel frammento html di testata della lista.
set curr_prog       [file tail [ns_conn url]]
set gest_prog       "coimtpin-gest"
set link_aggiungi   "<a href=\"$gest_prog?funzione=I&[export_url_vars cod_manutentore caller nome_funz  nome_funz_caller url_manu]\">Aggiungi</a>"

set cancella_tipologia "<td align=center>&nbsp;<a href=\"coimtpin-del?\[export_url_vars cod_coimtpin cod_manutentore nome_funz nome_funz_caller url_manu caller]\"onClick=\"javascript:return(confirm('Sei sicuro di voler procedere?'))\">Canc.</a></td>"
# imposto la struttura della tabella
set table_def [list \
		   [list cod_coimtpin       "Cod."               no_sort      {c}]\
		   [list tipologia_impianto "Tipologia Impianto" no_sort      {l}] \
		   [list cancella_tipologia "Azioni"             no_sort      $cancella_tipologia]
]

# imposto la query SQL 
set sel_tpin [db_map sel_tpin]

set table_result [ad_table -Tmax_rows 10 -Tmissing_text "Nessun dato corrisponde ai criteri impostati." -Textra_vars {cod_manutentore nome_funz nome_funz_caller  url_manu descrizione cod_coimtpin} go $sel_tpin $table_def]


db_release_unused_handles
ad_return_template 
