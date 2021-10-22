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
    {f_cod_manu        ""}
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
set link_docu_dist_layout [export_url_vars caller nome_funz_caller nome_funz extra_par]&f_cod_manu=$f_cod_manu

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
if {![string equal $f_cod_manu ""]} {
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
} else {
    set table_def [list \
		       [list cod_manutentore   "Cod. manutentore" no_sort {l}] \
		       [list nominativo_manu   "Nominativo"       no_sort {l}] \
		       [list n_modelli         "N. modelli"       no_sort {l}] \
		  ]
}
# imposto la query SQL 


# non c'e' la condizione per la prossima pagina perche' estraggo
# sempre tutti i record da stampare

# scrivo due query diverse a seconda se c'e' o meno il viario
iter_get_coimtgen
if {$coimtgen(flag_viario) == "T"} {
    set nome_col_toponimo  "e.descr_topo"
    set nome_col_via       "e.descrizione"
} else {
    set nome_col_toponimo  "b.toponimo"
    set nome_col_via       "b.indirizzo"
    set from_coimviae      ""
    set where_coimviae     ""
}

if {![string equal $f_cod_manu ""]} {
    set sel_list [db_map sel_dimp]
} else {
    set sel_list [db_map sel_dimp_manu]
}
set table_result [ad_table -Tmax_rows $rows_per_page -Tmissing_text "Nessun dato corrisponde ai criteri impostati." go $sel_list $table_def]

# conto il numero di record estratti
set ctr_rec [regsub -all <tr $table_result <tr comodo]
if {$ctr_rec != 0} {
    set ctr_rec [expr $ctr_rec -1]
}


if {![string equal $f_cod_manu ""]} {
    db_1row sel_manu ""
    set dett_num_rec "<tr><td align=center>In questa pagina vengono elencate tutte le dichiarazioni inserite da <b>$manu_cognome $manu_nome</b> che non sono ancora state riportate in una distinta</td></tr>"
    set dett_rec "Dichiarazioni selezionate"
} else {
    set dett_num_rec "<tr><td align=center>In questa pagina vengono elencati i manutentori per cui verrà creata la distinta</td></tr>"
    set dett_rec "Manutentori selezionati"
}

set link_altre_pagine ""

# creo testata della lista
set list_head [iter_list_head $form_di_ricerca $col_di_ricerca \
              $dett_num_rec $link_altre_pagine $link_righe ""]

db_release_unused_handles
ad_return_template 
