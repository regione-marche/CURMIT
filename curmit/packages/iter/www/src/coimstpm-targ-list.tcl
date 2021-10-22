ad_page_contract {
    Lista tabella ""

    @author                  Valentina Catte Adhoc
    @creation-date           23/04/2004

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

    @cvs-id coimstpm-targ-list.tcl
} { 
    {funzione          ""}
    {caller       "index"}
    {nome_funz         ""}
    {nome_funz_caller  ""}
    {f_comune          ""}
    {f_quartiere       ""}
    {f_cod_via         ""}
    {f_desc_via        ""}
    {f_desc_topo       ""}
    {f_civico_da       ""}
    {f_civico_a        ""}
    {f_manu_cogn       ""}
    {f_manu_nome       ""}
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
    # se la lista viene chiamata da un cerca, nome_funz non viene passato
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
iter_get_coimtgen

set page_title "Stampa Etichette Bollini"

set context_bar [iter_context_bar -nome_funz $nome_funz_caller]

set form_di_ricerca ""

set form_name              "coimstpm-targ-list"
set value_caller           [ad_quotehtml $caller]
set value_nome_funz        [ad_quotehtml $nome_funz]
set value_nome_funz_caller [ad_quotehtml $nome_funz_caller]

set actions     ""
set js_function ""

# imposto la struttura della tabella
set table_def [list \
	      [list action            "Conf."              no_sort {<td align=center><input type=checkbox name=conferma value="$cod_impianto"></td>}] \
	      [list cod_impianto_est  "Codice Impianto"    no_sort      {l}] \
	      [list f_indirizzo       "Indirizzo"          no_sort      {l}] \
	      [list nome_manu         "Manutentore"        no_sort      {l}] \
	      [list flag_stampato     "Targa Stampata"     no_sort      {l}] \
		  ]

# Imposto le clausole where per la query
# Comune
if {$f_comune eq ""} {
    set where_comune ""
} else {
    set where_comune "and a.cod_comune = :f_comune"
}
# Via
if {$coimtgen(flag_viario) eq "T"} {
    if {$f_cod_via eq ""} {
	set where_cod_via ""
    } else {
	set where_cod_via "and a.cod_via = :f_cod_via"
    }
} else {
    if {($f_desc_topo eq "") || ($f_desc_via eq "")} {
	set where_topo ""
	set where_via ""
    } else {
	if {($f_desc_topo ne "") && ($f_desc_via ne "")} {
	    set where_topo "and a.toponimo = :f_desc_topo"
	    set where_via "and a.indirizzo = :f_desc_via"
	} else {
	    set where_topo ""
	    set where_via ""
	}
    }
}

# Manutentore
if {$f_cod_manu eq ""} {
    set where_manu ""
} else {
    set where_manu "and a.cod_manutentore = :f_cod_manu"
}

# imposto la query SQL
if {$coimtgen(flag_viario) eq "T"} {
    set sel_aimp "sel_aimp_si_viae"
} else {
    set sel_aimp "sel_aimp_no_viae"
}

set sql_query [db_map $sel_aimp]
#ns_return 200 text/html $sql_query; return
set table_result [ad_table -Tmissing_text "Nessun dato corrisponde ai criteri impostati." -Textra_vars {} go $sql_query $table_def]

# dato che non c'e' la paginazione, e' sufficiente ctr_rec per capire
# quanti impianti sono stati estratti
set ctr_rec      [expr [regsub -all <tr $table_result <tr comodo] -1]
if {$ctr_rec <= 0} {
    set ctr_rec 0
    set link_sel "<br>"
} else {
    set link_sel {
    <input type="checkbox" name="checkall_input" onclick="javascript:checkall();">
    Seleziona/Deseleziona tutti
    }
}

set ctr_rec_edit [iter_edit_num $ctr_rec 0]
set rec_estratti "Nr. : <b>$ctr_rec_edit</b>"

set col_di_ricerca ""
# preparo url escludendo last_cod_impianto che viene passato esplicitamente
# per poi preparare il link alla prima ed eventualmente alla prossima pagina
# non serve per questo programma
# set url_vars [export_ns_set_vars "url" last_cod_impianto]
# set link_altre_pagine "Vai alla <a href=\"$curr_prog?$url_vars\">prima pagina</a>"
set link_altre_pagine ""


db_release_unused_handles
ad_return_template 
