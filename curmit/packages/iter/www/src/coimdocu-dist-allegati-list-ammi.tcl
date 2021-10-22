ad_page_contract {
    Lista Modelli H per creazione distinta

    @author                  daniele zanotto
    @creation-date           15/12/08

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

    @cvs-id coimdocu-dist-dimp-list.tcl 
} { 
   {search_word       ""}
   {rows_per_page     ""}
   {caller            "index"}
   {nome_funz         ""}
   {nome_funz_caller  ""} 
   {receiving_element ""}

   {last_cod_documento ""}
   {extra_par          ""}
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

set page_title      "Lista allegati per creazione distinta"
set context_bar     [iter_context_bar -nome_funz $nome_funz_caller]

# preparo link per ritorno alla lista distinte:
set link_docu_dist_list   [export_url_vars last_cod_documento caller nome_funz_caller nome_funz]&[iter_set_url_vars $extra_par]

# preparo link per conferma creazione distinta
# volutamente perdo last_cod_documento in modo da vedere la distinta inserita
set link_docu_dist_layout [export_url_vars caller nome_funz_caller nome_funz extra_par]

# estraggo uten_cognome_nome per specificare nella pagina quali modelli H
# sono stati selezionati
#if {[string range $id_utente 0 1] == "AM"} {
    # dalla tabella utenti se l'utente non e' un manutentore
    # in questa query si usa nella where :id_utente
if {[db_0or1row sel_uten ""] == 0} {
    iter_return_complaint "Codice utente non valido." 
    return
}
set uten_cognome_nome "<b>$uten_cognome $uten_nome</b>"
#}

# imposto le variabili da usare nel frammento html di testata della lista.
# set curr_prog     [file tail [ns_conn url]]
set form_di_ricerca ""
set col_di_ricerca  ""
# set rows_per_page [iter_set_rows_per_page $rows_per_page $id_utente]
set rows_per_page   0
# set link_righe    [iter_rows_per_page     $rows_per_page]
set link_righe      ""
set js_function     ""

# imposto la struttura della tabella
set table_def [list \
        [list flag_tracciato	"Tipo Allegato"     no_sort {c}] \
        [list cod_impianto_est  "Cod.Imp."          no_sort {l}] \
        [list data_ins_edit		"Data ins."         no_sort {c}] \
        [list responsabile      "Propriet&agrave;"  no_sort {l}] \
        [list comune            "Comune"            no_sort {l}] \
        [list indirizzo         "Indirizzo"         no_sort {l}] \
		[list potenza         	"Potenza"       	no_sort {l}]]

# imposto la query SQL 
#ns_return 200 text/html "$id_utente;$cod_manutentore";return
# imposto la condizione per l'utente

set utente        $id_utente
set where_utente  "and a.utente = :utente"

#ns_return 200 text/html "$utente;$id_utente";return
set count_L [db_string sel_count_L ""]

# non c'e' la condizione per la prossima pagina perche' estraggo
# sempre tutti i record da stampare

# scrivo due query diverse a seconda se c'e' o meno il viario
iter_get_coimtgen
if {$coimtgen(flag_viario) == "T"} {
    set nome_col_toponimo  "e.descr_topo"
    set nome_col_via       "e.descrizione"
    if {[iter_get_parameter database] == "postgres"} {
		set from_coimviae  "left outer join coimviae e on e.cod_comune = a.cod_comune and e.cod_via = a.cod_via"
    } else {
		set from_coimviae  "  , coimviae e"
		set where_coimviae "  and e.cod_comune (+)= a.cod_comune and e.cod_via (+)= a.cod_via"
    }
} else {
    set nome_col_toponimo  "a.toponimo"
    set nome_col_via       "a.indirizzo"
    set from_coimviae      ""
    set where_coimviae     ""
}

set sel_allegati 	[db_map sel_allegati]
set table_result 	[ad_table -Tmax_rows $rows_per_page -Tmissing_text "Nessun dato corrisponde ai criteri impostati." go $sel_allegati $table_def]

set link_altre_pagine ""

# creo testata della lista
set list_head [iter_list_head $form_di_ricerca $col_di_ricerca \
              "" $link_altre_pagine $link_righe ""]

db_release_unused_handles
ad_return_template 
