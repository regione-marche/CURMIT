ad_page_contract {
    Lista tabella "coimrife"

    @author                  Katia Coazzoli Adhoc
    @creation-date           13/04/2004

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

    @cvs-id coimrifs-list.tcl 

    USER  DATA       MODIFICHE
    ===== ========== ==========================================================================
    san01 04/09/2015 Aggiunto link alla stampa (serve per la provincia di Pesaro e Urbino)

} { 
   {search_word         ""}
   {rows_per_page       ""}
   {caller         "index"}
   {nome_funz           ""}
   {nome_funz_caller    ""} 
   {receiving_element   ""}
   {funzione            ""}
    cod_impianto
   {last_data_fin_valid ""}
   {curr_data_fin_valid ""}
   {url_list_aimp       ""}
   {url_aimp            ""}
   {data_fin_valid      ""}
   {ruolo               ""}
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

set link_tab [iter_links_form $cod_impianto $nome_funz_caller $url_list_aimp $url_aimp]
set dett_tab [iter_tab_form $cod_impianto]

set page_title      "Lista Storico soggetti interessati"

set context_bar [iter_context_bar -nome_funz $nome_funz_caller]

# imposto le variabili da usare nel frammento html di testata della lista.
set curr_prog       [file tail [ns_conn url]]
set gest_prog       "coimrifs-gest"
set form_di_ricerca ""
set col_di_ricerca  ""
set link_aggiungi   ""
set extra_par       [list rows_per_page     $rows_per_page \
                          receiving_element $receiving_element]

set rows_per_page   [iter_set_rows_per_page $rows_per_page $id_utente]
set link_righe      [iter_rows_per_page     $rows_per_page]

if {$funzione != "M"
 && $funzione != "D"} {
    set curr_data_fin_valid  $last_data_fin_valid
}

set link    "\[export_url_vars url_list_aimp url_aimp cod_impianto data_fin_valid last_data_fin_valid curr_data_fin_valid ruolo nome_funz nome_funz_caller extra_par \]"
# san01: aggiunto link alla stampa
set actions "
    <td nowrap>
        <a href=\"$gest_prog?funzione=D&$link\">Canc.</a>
      | <a href=\"coimrifs-layout?funzione=S&$link\">Stampa</a>
    </td>"

set data_canc $data_fin_valid
set ruolo_canc $ruolo

set js_function ""

# imposto la struttura della tabella
set table_def [list \
     [list actions                 "Azioni"           no_sort $actions] \
     [list data_fin_valid_edit     "Fine valid."           no_sort {c}] \
     [list des_ruolo               "Ruolo"                 no_sort {l}] \
     [list cognome                 "Cognome"               no_sort {l}] \
     [list nome                    "Nome"                  no_sort {l}] \
     [list cod_fiscale             "Cod.Fisc. / P.Iva"     no_sort {l}] \
]

# imposto la query SQL 

switch $funzione {
     "M" {# imposto la condizione per la pagina corrente
          if {![string is space $curr_data_fin_valid]} {
              set data_fin_valid   [lindex $curr_data_fin_valid 0]
	      set ruolo            [lindex $curr_data_fin_valid 1]
	      set where_last " and ((data_fin_valid  = :data_fin_valid and
                                     upper(ruolo)   >= upper(:ruolo))    or
                                     data_fin_valid <  :data_fin_valid)"
	  } else {
	      set where_last ""
	  }
     }
  default {# imposto la condizione per la prossima pagina
           if {![string is space $last_data_fin_valid]} {
	       set data_fin_valid   [lindex $last_data_fin_valid 0]
	       set ruolo            [lindex $last_data_fin_valid 1]
	       set where_last " and ((data_fin_valid  = :data_fin_valid and
                                      upper(ruolo)   >= upper(:ruolo))    or
                                      data_fin_valid <  :data_fin_valid)"
	   } else {
	       set where_last ""
	   }
  }
}

set sel_sogg [db_map sel_sogg_s]


set table_result [ad_table -Tmax_rows $rows_per_page -Tmissing_text "Nessun dato corrisponde ai criteri impostati." -Textra_vars {cod_impianto data_fin_valid last_data_fin_valid curr_data_fin_valid ruolo nome_funz nome_funz_caller url_list_aimp url_aimp extra_par} go $sel_sogg $table_def]

# preparo url escludendo last_data_fin_valid che viene passato esplicitamente
# per poi preparare il link alla prima ed eventualmente alla prossima pagina
set url_vars [export_ns_set_vars "url" "last_data_fin_valid funzione"]
set link_altre_pagine "Vai alla <a href=\"$curr_prog?$url_vars&funzione=V\">prima pagina</a>"

# preparo link a pagina successiva
set ctr_rec [expr [regsub -all <tr $table_result <tr comodo] -1]
if {$ctr_rec == $rows_per_page} {
    set last_data_fin_valid [list $data_fin_valid $ruolo]
    append url_vars "&[export_url_vars last_data_fin_valid]"
    append link_altre_pagine " o alla <a href=\"$curr_prog?$url_vars\">pagina successiva</a>"
}

# creo testata della lista
set list_head [iter_list_head  $form_di_ricerca $col_di_ricerca \
              $link_aggiungi $link_altre_pagine $link_righe "Righe per pagina"]
 
db_release_unused_handles
ad_return_template 
