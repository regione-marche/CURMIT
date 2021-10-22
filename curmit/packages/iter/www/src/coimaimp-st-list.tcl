ad_page_contract {
    Lista tabella "coimaimp"

    @author                  Giulio Laurenzi
    @creation-date           18/03/2004

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

    @cvs-id coimaimp-list.tcl 
} { 
    {search_word          ""}
    {caller               "index"}
    {nome_funz            ""}
    {nome_funz_caller     ""}
    {cod_impianto    ""}

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


# controllo il parametro di "propagazione" per la navigation bar
if {[string is space $nome_funz_caller]} {
    set nome_funz_caller $nome_funz
}

iter_get_coimtgen
set flag_viario       $coimtgen(flag_viario)
set valid_mod_h       $coimtgen(valid_mod_h)
set mesi_evidenza_mod $coimtgen(mesi_evidenza_mod)
set page_title      "Lista Storici di un Impianto"

set context_bar [iter_context_bar -nome_funz $nome_funz_caller]

# imposto le variabili da usare nel frammento html di testata della lista.
set curr_prog       [file tail [ns_conn url]]
set gest_prog       "coimaimp-st-gest"
set list_prog       "coimaimp-st-list"
set form_di_ricerca [iter_search_form $curr_prog $search_word]
set col_di_ricerca  "responsabile"

set link_gest     [export_ns_set_vars url]
set url_list_aimp        [list [ad_conn url]?[export_ns_set_vars url]]
set url_list_aimp        [export_url_vars url_list_aimp]

set link    "\[export_url_vars st_progressivo st_data_validita cod_impianto nome_funz nome_funz_caller \]"

set actions "
    <td nowrap><a href=\"$gest_prog?funzione=V&$link&$url_list_aimp\">Selez.</a></td>"

set stato_col {
   [set colorestato "white"
    set colorefont  "black"
    set vstato "non definito" 
    if {$stato == "At"} {
	set colorestato "green"
        set vstato "At" 
        set colorefont  "white"
    }
    if {$stato == "D"} {
        set colorestato "yellow"
        set vstato "D"
        set colorefont  "black"
    }

    if {$stato == "An"} {
        set colorestato "red"
        set vstato "An"
        set colorefont  "black"
    }

    if {$stato == "N"} {
        set colorestato "black"
        set vstato "N"
        set colorefont  "white"
    }

    if {$stato == "R"} {
        set colorestato "black"
        set vstato "R"
        set colorefont  "white"
    }
    return "<td nowrap align=center bgcolor=$colorestato><font color=$colorefont>$vstato</font></td>"]
}

set table_def [list \
		   [list action           "Azioni"              no_sort    $actions] \
		   [list cod_impianto_est "Codice"              no_sort         {l}] \
		   [list st_progressivo   "Progressivo"         no_sort         {l}] \
		   [list comune           "Comune"              no_sort         {l}] \
		   [list indir            "Indirizzo"           no_sort         {l}] \
		   [list potenza          "Pot."                no_sort         {r}] \
		   [list stato            "St"                  no_sort  $stato_col] \
		   [list st_utente        "Utente"              no_sort         {c}] \
		   [list st_data_valid    "Data valid."         no_sort         {c}] \
		   [list st_ora_validita  "Ora valid."          no_sort         {c}] \
		  ]

if {$flag_viario == "T"} {
    set sel_aimp [db_map sel_aimp_st_vie]
} else {
    set sel_aimp [db_map sel_aimp_st_no_vie]
}

set table_result [ad_table -Tmax_rows 99999 -Tmissing_text "Nessun dato corrisponde ai criteri impostati." -Textra_vars { st_progressivo nome_funz provincia comune localita indir via numero cod_ubicazione cognome nome ordine descrizione cod_impianto cod_impianto_est url_list_aimp swc_dichiarato nome_funz_caller} go $sel_aimp $table_def]


db_release_unused_handles
ad_return_template 
