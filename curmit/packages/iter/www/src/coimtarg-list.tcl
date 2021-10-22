ad_page_contract {
    Lista tabella "coimmanu"

    @author                  Gacalin Lufi
    @creation-date           24/11/2019

    @param search_word       parola da ricercare con una query
    @param rows_per_page     una delle dimensioni della tabella  
    @param caller            se diverso da index rappresenta il nome del form 
                             da cui e' partita la ricerca ed in questo caso
                             imposta solo azione "sel"
    @param nome_funz         identifica l'entrata di menu,
                             serve per le autorizzazioni
    @param receiving_element nomi dei campi di form che riceveranno gli
                             argomenti restituiti dallo script di zoom,
                             separati da '|' ed impostarli come segue:

    @cvs-id coimtarg-list.tcl 

    USER  DATA       MODIFICHE
    ===== ========== =======================================================================

} {

   {f_targa ""}
   {targa   ""}
   {flag_filter       ""} 
   {search_word       ""}
   {rows_per_page     ""}
   {caller            "index"}
   {nome_funz         ""}
   {receiving_element ""}
   {last_targa        ""}
   {nome_funz_caller  ""}
   {conta_flag        ""}
   {flag_valor_cod    ""}
}  -properties {
    page_title:onevalue
    context_bar:onevalue
    list_head:onevalue
    table_result:onevalue
}

set javascript_sel "";#gac01

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

# reperisco i dati generali
iter_get_coimtgen

# controllo il parametro di "propagazione" per la navigation bar
if {[string is space $nome_funz_caller]} {
    set nome_funz_caller $nome_funz
}

set page_title      "Lista targhe"


if {$caller == "index"} {
    set context_bar [iter_context_bar -nome_funz $nome_funz_caller]
} else {
    set context_bar [iter_context_bar \
                    [list "javascript:window.close()" "Torna alla Gestione"] \
                    "$page_title"]
}

# imposto le variabili da usare nel frammento html di testata della lista.
set curr_prog       [file tail [ns_conn url]]
set form_di_ricerca [iter_search_form $curr_prog $search_word]
set col_di_ricerca  "Targa"

set extra_par       [list rows_per_page     $rows_per_page \
                          receiving_element $receiving_element \
			  f_targa $f_targa \
                    ]
set rows_per_page   [iter_set_rows_per_page $rows_per_page $id_utente]
set link_righe      [iter_rows_per_page     $rows_per_page]

if {$conta_flag != "t"} {
    set link_conta      "<a href=\"$curr_prog?conta_flag=t&[export_ns_set_vars url]\">Conta</a>"
} else {
    set link_conta ""
}

regsub -all "'" $targa "!" targa

set link    "\[export_url_vars targa last_targa nome_funz extra_par\]"
set actions "<td nowrap><a href=\"coimtarg-list?flag_valor_cod=t&$link&caller=$caller\">Selez.</a></td>"
set js_function ""



set actions [iter_select [list targa]]
set receiving_element [split $receiving_element |]
set js_function [iter_selected $caller [list [lindex $receiving_element 0] targa]]
if {[string equal $flag_valor_cod ""]
} {
    # imposto la struttura della tabella
    set table_def [list \
		       [list actions         "Azioni"             no_sort $actions] \
		       [list targa "Codice Catasto/Targa"         no_sort {l}] \
		      ]
    
    # imposto la query SQL 
    if {![string equal $f_targa ""]} {
	set search_word $f_targa
    }
    
    if {[string equal $search_word ""]} {
	set where_word ""
    } else {
	set search_word_1 [iter_search_word $search_word]
	set where_word  " and upper(targa) like upper(:search_word_1)"
    }
    
    # imposto la condizione per la prossima pagina
    if {![string is space $last_targa]} {
	set targa $last_targa
	set where_last "and targa >= :targa"
    } else {
	set where_last ""
    }
    
    set sql_query [db_map sel_targa]
    
    if {$conta_flag == "t"} {
	# estraggo il numero dei record estratti
	db_1row sel_conta_targa ""
	set link_conta "Targhe selezionate: <b>$conta_num</b>"
    }
    
    set table_result [ad_table -Tmax_rows $rows_per_page -Tmissing_text "Nessun dato corrisponde ai criteri impostati." -Textra_vars {targa nome_funz nome_funz_caller conta_num extra_par} go $sql_query $table_def]
    
    # preparo url escludendo last_cognome che viene passato esplicitamente
    # per poi preparare il link alla prima ed eventualmente alla prossima pagina
    set url_vars [export_ns_set_vars "url" last_targa]
    set link_altre_pagine "Vai alla <a href=\"$curr_prog?$url_vars\">prima pagina</a>"
    
    # preparo link a pagina successiva
    set ctr_rec [expr [regsub -all <tr $table_result <tr comodo] -1]
    if {$ctr_rec == $rows_per_page} {
	set last_targa $targa
	append url_vars "&[export_url_vars last_targa]"
	append link_altre_pagine " o alla <a href=\"$curr_prog?$url_vars\">pagina successiva</a>"
    }
    
    # creo testata della lista
    set list_head [iter_list_head  $form_di_ricerca $col_di_ricerca \
		       "<br>$link_conta" $link_altre_pagine $link_righe "Righe per pagina"]
    
    set link_gest [export_url_vars f_targa nome_funz nome_funz_caller]
}

db_release_unused_handles
ad_return_template 
