ad_page_contract {
    Lista tabella "coimgage"

    @author                  Giulio Laurenzi
    @creation-date           07/07/2004

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

    @cvs-id coimgage-list-palm.tcl 
} { 
   {search_word          ""}
   {rows_per_page        ""}
   {caller          "index"}
   {nome_funz            ""}
   {nome_funz_caller     ""} 
   {receiving_element    ""}
   {last_key             ""}
   {data_prevista        ""}
   {data_prevista_old    ""}
   {submit_meno_uno:allhtml ""}
   {submit_piu_uno:allhtml  ""}

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

}

set current_date [iter_set_sysdate]

# controllo il parametro di "propagazione" per la navigation bar
if {[string is space $nome_funz_caller]} {
    set nome_funz_caller $nome_funz
}

iter_get_coimtgen
set flag_ente       $coimtgen(flag_ente)
set flag_viario     $coimtgen(flag_viario)

set cod_manutentore [iter_check_uten_manu $id_utente]
set page_title      "Lista Agenda Manutentore"
set context_bar     [iter_context_bar -nome_funz $nome_funz_caller]

# imposto le variabili da usare nel frammento html di testata della lista.
set curr_prog       [file tail [ns_conn url]]
set gest_prog       "coimgage-gest-palm"
set form_di_ricerca [iter_search_form_palm  $curr_prog $search_word]
set col_di_ricerca  "Cod."
set extra_par       [list search_word       $search_word \
                          rows_per_page     $rows_per_page \
                          receiving_element $receiving_element \
                          data_prevista     $data_prevista \
                          data_prevista_old $data_prevista_old \
                          submit_meno_uno   $submit_meno_uno \
                          submit_piu_uno    $submit_piu_uno]

# al posto di aggiungi creo una form per gestire il parametro data_prevista
# prima di costruire la form devo valorizzare data_prevista e data_prevista_old
# se data_prevista e' vuota, significa che il programma e' stato richiamato
# da menu' e la valorizzo con la data corrente.

set errore ""
if {[string is space $data_prevista]} {
    set data_prevista      $current_date
    set data_prevista_edit [iter_edit_date $data_prevista]
    set data_prevista_old  $data_prevista
} else {
    # se invece e' valorizzata significa che il programma e' stato richiamato
    # premendo il bottone <-- o -->

    # controllo che la data_prevista digitata sia corretta
    set error_num 0

    set data_prevista_edit $data_prevista
    set data_prevista      [iter_check_date $data_prevista]
    if {$data_prevista == 0} {
	set errore "<br><span class=\"errori\">Deve essere una data in formato gg/mm/aaaa</span>"
	incr error_num
    }

    if {$error_num > 0} {
	# in caso di errore rieseguo la query precedente con data_prevista_old
	set data_prevista $data_prevista_old
    } else {
	# se l'utente ha cambiato data_prevista allora estraggo
	# i controlli con la data_prevista digitata
	# altrimenti verifico se ha schiacciato il tasto <-- o -->
	# e sottraggo o aggiungo un giorno alla data_prevista
	if {$data_prevista == $data_prevista_old} {
	    if {![string is space $submit_meno_uno]} {
		set operatore "-"
	    } else {
		set operatore "+"
	    }
	    set data_prevista      [db_string sel_dual_calc_date ""]
	}
	set data_prevista_edit [iter_edit_date $data_prevista]
	set data_prevista_old  $data_prevista
    }
}

# preparo tutti gli altri campi hidden da utilizzare per richiamare la lista
set form_vars          [iter_export_ns_set_vars "form" [list data_prevista data_prevista_old submit_meno_uno submit_piu_uno]]

set link_aggiungi "
<form method=post action=\"$curr_prog\">
  $form_vars
  <input type=hidden name=data_prevista_old value=\"[ad_quotehtml $data_prevista_old]\">
  <input type=text   name=data_prevista size=10 maxlength=10 value=\"[ad_quotehtml $data_prevista_edit]\" class=form_element><br>
  <input type=submit name=submit_meno_uno value=\"<--\" class=form_submit>&nbsp;
  <input type=submit name=submit_piu_uno  value=\"-->\" class=form_submit>
  $errore
</form>"

set rows_per_page   [iter_set_rows_per_page $rows_per_page $id_utente]
set link_righe      [iter_rows_per_page     $rows_per_page]

set link    "\[export_url_vars cod_opma cod_impianto data_ins last_key nome_funz nome_funz_caller extra_par\]"
set actions "
<td nowrap><a href=\"$gest_prog?funzione=V&$link\">Sel.</a></td>"
set js_function ""

if {$flag_ente == "C"} {
    set indir_td {<td>$indir</td>}
} else {
    set indir_td {<td>$comune $indir</td>}
}

# imposto la struttura della tabella
set table_def [list \
		   [list actions   "Az."          no_sort $actions] \
		   [list indir     "Indirizzo"    no_sort $indir_td] \
		   [list resp      "Resp."        no_sort {l}] \
		   [list stato_ed  "Stato"        no_sort {l}] \
		  ]

switch $flag_viario {
    "T" {set col_via "d.descrizione"}
    "F" {set col_via "b.indirizzo" }
}
set col_numero  "to_number(b.numero,'99999999')"

set ordinamento "order by c.denominazione
                        , $col_via
                        , $col_numero
                        , b.cod_impianto_est"

if {![string equal $last_key ""]} {
    set comune           [lindex $last_key 0]
    set via              [lindex $last_key 1]
    set numero           [lindex $last_key 2]
    set cod_impianto_est [lindex $last_key 3]

    if {[string equal $comune ""]} {
	set eq_comune    "is null"
	set or_comune    ""
    } else {
	set eq_comune    "= :comune"
	set or_comune    "or c.denominazione > :comune
                          or c.denominazione is null"
    }

    if {[string equal $via ""]} {
	set eq_via       "is null"
	set or_via       ""
    } else {
	set eq_via       "= :via"
	set or_via       "or (    c.denominazione $eq_comune
                              and (   $col_via     > :via
                                   or $col_via     is null))"
    }

    if {[string equal $numero ""]} {
	set eq_numero    "is null"
	set or_numero    ""
    } else {
	set eq_numero    "= :numero"
	set or_numero    "or (    c.denominazione $eq_comune
                              and $col_via        $eq_via
                              and (   $col_numero  > :numero
                                   or $col_numero  is null))"
    }

    set where_last "and (
                             (    c.denominazione $eq_comune
                              and $col_via        $eq_via
                              and $col_numero     $eq_numero
                              and b.cod_impianto_est > :cod_impianto_est)
                         $or_numero
                         $or_via
                         $or_comune
                        )"
} else {
    set where_last ""
}

if {[string equal $search_word ""]} {
    set where_word  ""
} else {
    set search_word_1 [iter_search_word $search_word]
    set where_word  " and upper(cod_impianto_est) like upper(:search_word_1)"
}

switch $flag_viario {
    "T" {set sel_gage "sel_gage_si_vie" }
    "F" {set sel_gage "sel_gage_no_vie" }
}

set sel_gage     [db_map $sel_gage]
set table_result [ad_table -Tmax_rows $rows_per_page -Tmissing_text "Nessun dato corrisponde ai criteri impostati." -Textra_vars {cod_opma cod_impianto data_ins last_key nome_funz nome_funz_caller extra_par data_prevista comune via numero cod_impianto_est} go $sel_gage $table_def]

# preparo url escludendo last_gage che viene passato esplicitamente
# per poi preparare il link alla prima ed eventualmente alla prossima pagina
set url_vars [export_ns_set_vars "url" "last_key"]
set link_altre_pagine "Vai alla<br><a href=\"$curr_prog?$url_vars\">prima pagina</a>"

# preparo link a pagina successiva
set ctr_rec [expr [regsub -all <tr $table_result <tr comodo] -1]
if {$ctr_rec == $rows_per_page} {
    set     last_key $comune
    lappend last_key $via
    lappend last_key $numero
    lappend last_key $cod_impianto_est

    append url_vars "&[export_url_vars last_key]"
    append link_altre_pagine "<br>o alla<br><a href=\"$curr_prog?$url_vars\">pagina successiva</a>"
}

# creo testata della lista
set list_head [iter_list_head  $form_di_ricerca $col_di_ricerca \
              $link_aggiungi $link_altre_pagine $link_righe "Righe per pag."]

db_release_unused_handles
ad_return_template 
