ad_page_contract {
    Lista tabella "coimopdi"

    @author                  Giulio Laurenzi
    @creation-date           23/09/2005

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

    @cvs-id coimopdi-list.tcl 
} { 
   {search_word       ""}
   {rows_per_page     ""}
   {caller            "index"}
   {nome_funz         ""}
   {nome_funz_caller  ""} 
   {receiving_element ""}
    cod_opve
   {cod_enve          ""}
   {last_prog_disp    ""}
   {url_enve          ""}
}  -properties {
    page_title:onevalue
    context_bar:onevalue
    list_head:onevalue
    table_result:onevalue
}

db_1row sel_tgen "select flag_asse_data from coimtgen"

if {$flag_asse_data == "N"} {
 iter_return_complaint "Funzione non abilitata, contattare il responsabile del sistema. Funziona attivata solo per coloro che utilizzano l'agenda"
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

if {[db_0or1row sel_opve_nome ""]==0} {
    set nome_enve ""
    set nome_opve ""
}

# controllo il parametro di "propagazione" per la navigation bar
if {[string is space $nome_funz_caller]} {
    set nome_funz_caller $nome_funz
}

set page_title      "Lista disponibilit&agrave; giornaliera"

set context_bar [iter_context_bar -nome_funz $nome_funz_caller]


# imposto le variabili da usare nel frammento html di testata della lista.
set curr_prog       [file tail [ns_conn url]]
set gest_prog       "coimopdi-gest"
set form_di_ricerca ""
set col_di_ricerca  ""
set extra_par       [list rows_per_page     $rows_per_page \
                          receiving_element $receiving_element]
set link_aggiungi   "<a href=\"$gest_prog?funzione=I&[export_url_vars cod_opve last_prog_disp caller nome_funz extra_par nome_funz_caller url_enve cod_enve]\">Aggiungi</a>"
set url_opve "coimopve-gest?funzione=V&[export_url_vars cod_opve last_prog_disp caller extra_par nome_funz_caller url_enve cod_enve]&nome_funz=[iter_get_nomefunz coimopve-gest]"
 
set rows_per_page   [iter_set_rows_per_page $rows_per_page $id_utente]
set link_righe      [iter_rows_per_page     $rows_per_page]

set link    "[export_url_vars cod_enve]&\[export_url_vars cod_opve prog_disp last_prog_disp nome_funz nome_funz_caller extra_par url_enve \]"

set actions "
<td nowrap><a href=\"$gest_prog?funzione=V&$link\">Selez.</a></td>"
set js_function ""




# imposto la struttura della tabella
set table_def [list \
        [list actions    "Azioni"     no_sort $actions] \
        [list prog_disp  "Disp. n."   no_sort {r}] \
	[list ora_da     "ora_da"     no_sort {l}] \
	[list ora_a      "ora_a"      no_sort {l}] \
]

# imposto la query SQL 

# imposto la condizione per la prossima pagina
if {![string is space $last_prog_disp]} {
    set where_last " and prog_disp >= :last_prog_disp"
} else {
    set where_last ""
}

set sel_opdi [db_map sel_opdi]

set table_result [ad_table -Tmax_rows $rows_per_page -Tmissing_text "Nessun dato corrisponde ai criteri impostati." -Textra_vars {cod_opve prog_disp last_prog_disp nome_funz nome_funz_caller extra_par url_enve} go $sel_opdi $table_def]

# preparo url escludendo last_prog_disp che viene passato esplicitamente
# per poi preparare il link alla prima ed eventualmente alla prossima pagina
set url_vars [export_ns_set_vars "url" last_prog_disp]
set link_altre_pagine "Vai alla <a href=\"$curr_prog?$url_vars\">prima pagina</a>"

# preparo link a pagina successiva
set ctr_rec [expr [regsub -all <tr $table_result <tr comodo] -1]
if {$ctr_rec == $rows_per_page} {
    set last_prog_disp $prog_disp
    append url_vars "&[export_url_vars last_prog_disp]"
    append link_altre_pagine " o alla <a href=\"$curr_prog?$url_vars\">pagina successiva</a>"
}

# creo testata della lista
set list_head [iter_list_head  $form_di_ricerca $col_di_ricerca \
              $link_aggiungi $link_altre_pagine $link_righe "Righe per pagina"]

db_release_unused_handles
ad_return_template 
