ad_page_contract {
    Lista tabella "coim_multiubic"

    @author                  tina
    @creation-date           02/04/2004

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

    @cvs-id coim_multiubic-list.tcl 
} { 
   {search_word       ""}
   {rows_per_page     ""}
   {caller       "index"}
   {nome_funz         ""}
   {nome_funz_caller  ""} 
   {receiving_element ""}
    cod_impianto
   {last_cod_ubic     ""}
   {url_list_aimp     ""}
   {url_aimp          ""}
}  -properties {
    page_title:onevalue
    context_bar:onevalue
    list_head:onevalue
    table_result:onevalue
}

# Controlla lo user

if {![string is space $nome_funz]} {
    set lvl        1
    #set id_utente [lindex [iter_check_login $lvl $nome_funz] 1]
    #set id_utente [ad_get_cookie iter_login_[ns_conn location]]
    set id_utente [iter_get_id_utente]
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


set page_title      "Lista altre ubicazioni"


#if {$caller == "index"} {
    set context_bar [iter_context_bar -nome_funz $nome_funz_caller]
#} else {
#    set context_bar [iter_context_bar \
#                    [list "javascript:window.close()" "Torna alla Gestione"] \
#                    "$page_title"]
#}

#proc per la navigazione 
set link_tab [iter_links_form $cod_impianto $nome_funz_caller $url_list_aimp $url_aimp]
set dett_tab [iter_tab_form $cod_impianto]


# imposto le variabili da usare nel frammento html di testata della lista.
set curr_prog       [file tail [ns_conn url]]
set gest_prog       "coim_multiubic-gest"
set form_di_ricerca ""
set col_di_ricerca  ""
set extra_par       [list rows_per_page     $rows_per_page \
                          receiving_element $receiving_element]
set link_aggiungi   "<a href=\"$gest_prog?funzione=I&[export_url_vars cod_impianto last_cod_ubic caller nome_funz url_list_aimp  url_aimp extra_par nome_funz_caller]\">Aggiungi</a>"
set rows_per_page   [iter_set_rows_per_page $rows_per_page $id_utente]
set link_righe      [iter_rows_per_page     $rows_per_page]


#if {$caller == "index"} {

    set link    "\[export_url_vars cod_impianto cod_ubicazione last_cod_ubic nome_funz nome_funz_caller url_list_aimp url_aimp extra_par\]"
    set actions "
    <td nowrap><a href=\"$gest_prog?funzione=V&$link\">Selez.</a></td>"
    set js_function ""
#} else { 
#    set actions [iter_select [list column_name .... ]]
#    set receiving_element [split $receiving_element |]
#    set js_function [iter_selected $caller [list [lindex $receiving_element 0]  column_name1 [lindex $receiving_element 1]  column_name2 .... .... ]]
#}


# imposto la struttura della tabella
set table_def [list \
        [list actions             "Azioni"         no_sort $actions] \
    	[list comune              "Comune"         no_sort {c}] \
	[list indirizzo           "Indirizzo"      no_sort {c}] \
	[list civico              "Civico"         no_sort {c}] \
	[list localita            "Localita"       no_sort {c}] \
]


# imposto la query SQL 

# imposto la condizione per la prossima pagina
if {![string is space $last_cod_ubic]} {
    set where_last " and cod_ubicazione >= :last_cod_ubic"
} else {
    set where_last ""
}


iter_get_coimtgen
set flag_viario $coimtgen(flag_viario)

if {$flag_viario == "T"} {
    set sel_multiubic [db_map sel_multiubic_si_vie]
} else {
    set sel_multiubic [db_map sel_multiubic_no_vie]
}

set table_result [ad_table -Tmax_rows $rows_per_page -Tmissing_text "Nessun dato corrisponde ai criteri impostati." -Textra_vars {cod_impianto cod_ubicazione last_cod_ubic nome_funz nome_funz_caller url_list_aimp url_aimp extra_par} go $sel_multiubic $table_def]

# preparo url escludendo last_cod_ubic che viene passato esplicitamente
# per poi preparare il link alla prima ed eventualmente alla prossima pagina
set url_vars [export_ns_set_vars "url" last_cod_ubic]
set link_altre_pagine "Vai alla <a href=\"$curr_prog?$url_vars\">prima pagina</a>"

# preparo link a pagina successiva
set ctr_rec [expr [regsub -all <tr $table_result <tr comodo] -1]
if {$ctr_rec == $rows_per_page} {
    set last_cod_ubic $cod_ubicazione
    append url_vars "&[export_url_vars last_cod_ubic]"
    append link_altre_pagine " o alla <a href=\"$curr_prog?$url_vars\">pagina successiva</a>"
}

# creo testata della lista
set list_head [iter_list_head  $form_di_ricerca $col_di_ricerca \
              $link_aggiungi $link_altre_pagine $link_righe "Righe per pagina"]

db_release_unused_handles
ad_return_template 
