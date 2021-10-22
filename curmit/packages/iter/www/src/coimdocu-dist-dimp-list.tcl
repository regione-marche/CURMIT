ad_page_contract {
    Lista Modelli H per creazione distinta

    @author                  Nicola Mortoni
    @creation-date           06/07/2006

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

# valorizzo cod_manutentore se l'utente è un manutentore
set cod_manutentore [iter_check_uten_manu $id_utente]

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
if {[string equal $cod_manutentore ""]} {
    # dalla tabella utenti se l'utente non e' un manutentore
    # in questa query si usa nella where :id_utente
    if {[db_0or1row sel_uten ""] == 0} {
	iter_return_complaint "Codice utente non valido." 
	return
    }
    set uten_cognome_nome "da <b>$uten_cognome $uten_nome</b>"
} else {
    # dalla tabella manutentori se l'utente e' un manutentore
    if {[db_0or1row sel_manu ""] == 0} {
	iter_return_complaint "Manutentore non trovato." 
	return
    }
    set uten_cognome_nome "dal manutentore <b>$manu_cognome $manu_nome</b>"
}

# imposto le variabili da usare nel frammento html di testata della lista.
# set curr_prog     [file tail [ns_conn url]]
set form_di_ricerca ""
set col_di_ricerca  ""
# set rows_per_page [iter_set_rows_per_page $rows_per_page $id_utente]
set rows_per_page   0
# set link_righe    [iter_rows_per_page     $rows_per_page]
set link_righe      ""
set js_function     ""
ns_log notice "sandro controllo storno $id_utente"
# imposto la struttura della tabella
set table_def [list \
        [list data_controllo_edit "Data&nbsp;controllo" no_sort {c}] \
        [list cod_impianto_est    "Cod.Imp."            no_sort {l}] \
        [list data_ins_edit       "Data ins."           no_sort {c}] \
        [list resp                "Responsabile"        no_sort {l}] \
        [list comune              "Comune"              no_sort {l}] \
        [list indir               "Indirizzo"           no_sort {l}] \
        [list riferimento_pag     "Rif./N. bollino"     no_sort {l}] \
        [list costo               "Costo"               no_sort {l}] \
        [list descr_potenza       "Fascia potenza"      no_sort {l}]
]

# imposto la query SQL 

# imposto la condizione per l'utente
if {[string equal $cod_manutentore ""]} {
    # inseriti dall'utente se l'utente non e' un manutentore
    set utente        $id_utente
    set where_utente  "where (a.utente = :utente or a.utente_ins = :utente)"
} else {
    # inseriti da tutti gli utenti della stessa ditta di manutenzione
    # se l'utente fa parte di una ditta di manutenzione
    set    utente     [string range $id_utente 0 end-2]
    append utente     "__"
    set where_utente  "where (a.utente like :utente or a.utente_ins like :utente)"
}

# non c'e' la condizione per la prossima pagina perche' estraggo
# sempre tutti i record da stampare

# scrivo due query diverse a seconda se c'e' o meno il viario
iter_get_coimtgen
if {$coimtgen(flag_viario) == "T"} {
    set nome_col_toponimo  "e.descr_topo"
    set nome_col_via       "e.descrizione"
    if {[iter_get_parameter database] == "postgres"} {
	set from_coimviae  "left outer join coimviae e"
	set where_coimviae "             on e.cod_comune    = b.cod_comune
                                        and e.cod_via       = b.cod_via"
    } else {
	set from_coimviae  "              , coimviae e"
	set where_coimviae "            and e.cod_comune (+)= b.cod_comune
                                        and e.cod_via    (+)= b.cod_via"
    }
} else {
    set nome_col_toponimo  "b.toponimo"
    set nome_col_via       "b.indirizzo"
    set from_coimviae      ""
    set where_coimviae     ""
}

set sel_dimp [db_map sel_dimp]
set table_result [ad_table -Tmax_rows $rows_per_page -Tmissing_text "Nessun dato corrisponde ai criteri impostati." go $sel_dimp $table_def]

# conto il numero di record estratti
set ctr_rec [regsub -all <tr $table_result <tr comodo]
if {$ctr_rec != 0} {
    set ctr_rec [expr $ctr_rec -1]
}
# set dett_num_rec "Modelli selezionati: <b>$ctr_rec</b>"
set dett_num_rec "<b>$ctr_rec</b> Modelli  inseriti <b>$uten_cognome_nome</b>"


set link_altre_pagine ""

# creo testata della lista
set list_head [iter_list_head $form_di_ricerca $col_di_ricerca \
              $dett_num_rec $link_altre_pagine $link_righe ""]

db_release_unused_handles
ad_return_template 
