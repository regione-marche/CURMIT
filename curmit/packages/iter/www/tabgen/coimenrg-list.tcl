ad_page_contract {
    Lista tabella "coimenrg"

    @author                  Tania Masullo Adhoc
    @creation-date           11/08/2005

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

    @cvs-id coimenrg-list.tcl 
} { 
   {search_word       ""}
   {rows_per_page     ""}
   {caller       "index"}
   {nome_funz         ""}
   {nome_funz_caller  ""} 
   {receiving_element ""}
   {url_list_rgen     ""}
   {url_rgen          ""}
   {cod_enre          ""}
   {funzione          ""}
    cod_rgen
   {last_enre         ""}
   {curr_enre         ""}
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
    set id_utente [iter_get_id_utente]
}

# controllo il parametro di "propagazione" per la navigation bar
if {[string is space $nome_funz_caller]} {
    set nome_funz_caller $nome_funz
}

set link_tab [iter_links_rgen $cod_rgen $nome_funz_caller $url_list_rgen $url_rgen]
set dett_tab [iter_tab_rgen $cod_rgen]


set page_title      "Lista Relazione Raggruppamento Enti / Enti Responsabili"

#if {$caller == "index"} {
    set context_bar [iter_context_bar -nome_funz $nome_funz_caller]
#} else {
#    set context_bar [iter_context_bar \
#                    [list "javascript:window.close()" "Torna alla Gestione"] \
#                    "$page_title"]
#}

# imposto le variabili da usare nel frammento html di testata della lista.
set curr_prog       [file tail [ns_conn url]]
set gest_prog       "coimenrg-gest"
set form_di_ricerca [iter_search_form $curr_prog $search_word]
set col_di_ricerca  "Ente Responsabile"
set extra_par       [list rows_per_page     $rows_per_page \
                          receiving_element $receiving_element]
set link_aggiungi   "<a href=\"$gest_prog?funzione=I&[export_url_vars cod_rgen caller nome_funz extra_par nome_funz_caller url_list_rgen url_rgen]\">Aggiungi</a>"
set rows_per_page   [iter_set_rows_per_page $rows_per_page $id_utente]
set link_righe      [iter_rows_per_page     $rows_per_page]


if {$funzione != "M"
 && $funzione != "D"} {
    set curr_enre  $last_enre
}

set link    "\[export_url_vars cod_rgen cod_enre last_enre curr_enre nome_funz nome_funz_caller url_list_rgen url_rgen extra_par\]"
set actions "
    <td nowrap><a href=\"$curr_prog?funzione=D&$link\">Canc.</a></td>"
set enre_canc $cod_enre
set js_function ""

# imposto la struttura della tabella
set table_def [list \
              [list actions                "Azioni"                 no_sort $actions] \
	      [list denominazione          "Ente Responsabile"      no_sort {l}] \
]

# imposto la query SQL 
if {[string equal $search_word ""]} {
    set where_word ""
} else {
    set search_word_1 [iter_search_word $search_word]
    set where_word  " and upper(b.denominazione) like upper(:search_word_1)"
}

switch $funzione {
	"M" {# imposto la condizione per la pagina corrente
	    if {![string is space $curr_enre]} {
		set denominazione   [lindex $curr_enre 0]
		set cod_enre        [lindex $curr_enre 1]
		set where_last "and ((upper(b.denominazione) = upper(:denominazione)  and
                                     a.cod_enre       >= :cod_enre) or
                               upper(b.denominazione) > upper(:denominazione))"
	    } else {
		set where_last ""
	    }
	}
    default {# imposto la condizione per la prossima pagina
	if {![string is space           $last_enre]} {
	    set denominazione   [lindex $last_enre 0]
	    set cod_enre        [lindex $last_enre 1]
	    set where_last " and ((upper(b.denominazione)  = upper(:denominazione) and
                                   a.cod_enre       >= :cod_enre) or
                             upper(b.denominazione) > upper(:denominazione))"
	} else {
	    set where_last ""
	}
    }
}

set sel_enrg [db_map sel_enrg]

set table_result [ad_table -Tmax_rows $rows_per_page -Tmissing_text "Nessun dato corrisponde ai criteri impostati." -Textra_vars {cod_rgen cod_enre last_enre curr_enre nome_funz denominazione nome_funz_caller url_list_rgen url_rgen extra_par} go $sel_enrg $table_def]

# preparo url escludendo last_enre che viene passato esplicitamente
# per poi preparare il link alla prima ed eventualmente alla prossima pagina
set url_vars [export_ns_set_vars "url" "last_enre funzione"]
set link_altre_pagine "Vai alla <a href=\"$curr_prog?$url_vars&funzione=V\">prima pagina</a>"

# preparo link a pagina successiva
set ctr_rec [expr [regsub -all <tr $table_result <tr comodo] -1]
if {$ctr_rec == $rows_per_page} {
    set last_enre [list  $denominazione $cod_enre]
    append url_vars "&[export_url_vars last_enre]"
    append link_altre_pagine " o alla <a href=\"$curr_prog?$url_vars\">pagina successiva</a>"
}

# creo testata della lista
set list_head [iter_list_head  $form_di_ricerca $col_di_ricerca \
              $link_aggiungi $link_altre_pagine $link_righe "Righe per pagina"]

if {$funzione == "D"} {
    set dml_sql [db_map del_enrg]
    # Lancio la query di manipolazione dati contenute in dml_sql
    if {[info exists dml_sql]} {
        with_catch error_msg {
            db_transaction {
                db_dml dml_coimenrg $dml_sql
            }
        } {
            iter_return_complaint "Spiacente, ma il DBMS ha restituito il
            seguente messaggio di errore <br><b>$error_msg</b><br>
            Contattare amministratore di sistema e comunicare il messaggio
            d'errore. Grazie."
	}
    }

    set link    "\[export_url_vars cod_rgen cod_enre last_enre curr_enre  nome_funz nome_funz_caller extra_par url_list_rgen url_rgen\]"

    ad_returnredirect $curr_prog?funzione=M&[export_url_vars cod_rgen cod_enre last_enre curr_enre nome_funz nome_funz_caller extra_par url_list_rgen url_rgen]
    ad_script_abort
}

db_release_unused_handles
ad_return_template 

