ad_page_contract {

    @author                  Giulio Laurenzi
    @creation-date           30/08/2004

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

    @cvs-id                  coimstso-list.tcl
} { 
    {f_id_caus          ""}
    {f_importo          ""}
    {f_contatore        ""}
    {f_data_scadenza    ""}
    {f_cod_comune       ""}
    {id_stampa          ""}
    {conta_flag         ""}
    {funzione          "V"}
    {caller        "index"}
    {nome_funz          ""}
    {nome_funz_caller   ""}
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
    # se la lista viene chiamata da un cerca, nome_funz non viene passato
    # e bisogna reperire id_utente dai cookie
    #set id_utente [ad_get_cookie iter_login_[ns_conn location]]
    set id_utente [iter_get_id_utente]
}

set nome_funz_coimcitt [iter_get_nomefunz "coimcitt-gest"]

# controllo il parametro di "propagazione" per la navigation bar
if {[string is space $nome_funz_caller]} {
    set nome_funz_caller $nome_funz
}

set context_bar [iter_context_bar -nome_funz $nome_funz_caller]

# imposto le variabili da usare nel frammento html di testata della lista.
set curr_prog       [file tail [ns_conn url]]
set layout_prog     "coimstav-layout"

set form_di_ricerca ""
set col_di_ricerca  ""
set form_name       "coimstav"

set page_title      "Lista pagamenti"

set link_righe      ""
set link_aggiungi   ""
set link_filter     [export_ns_set_vars url]
set link_anteprima  "[export_ns_set_vars url]&flag_anteprima=T&[export_url_vars id_protocollo protocollo_dt]"
set extra_par        [list]

if {$conta_flag != "t"} {
    set link_conta      "<a href=\"$curr_prog?conta_flag=t&[export_ns_set_vars url]\">Conta</a>"
} else {
    set link_conta ""
}

set actions ""
set js_function ""

#set checked ""
set url_vars        [export_ns_set_vars "url" "flag_sel"]

# imposto la struttura della tabella

set link    "\[export_url_vars cod_cittadino\]"
set actions "
    <td nowrap><a target=citt href=\"coimcitt-gest?funzione=M&flag_mod=t&nome_funz_caller=$nome_funz_caller&nome_funz=$nome_funz_coimcitt&$link\">Mod sogg.</a></td>"

set table_def [list \
		   [list actions          "Azioni"           no_sort $actions] \
		   [list cod_impianto_est "Codice"           no_sort      {l}] \
		   [list indir            "Ubicazione imp."  no_sort      {l}] \
		   [list nom_resp         "Responsabile"     no_sort      {l}] \
		   [list indirizzo_resp   "Ind. Resp."       no_sort      {l}] \
		   [list numero_resp      "Num."             no_sort      {l}] \
		   [list cap_resp         "Cap"              no_sort      {l}] \
		   [list comune_resp      "Comune"           no_sort      {l}] \
		   [list provincia_resp   "Provincia"        no_sort      {l}] \
		  ]

# imposto la query SQL
iter_get_coimtgen
set flag_ente        $coimtgen(flag_ente)         
set sigla_prov       $coimtgen(sigla_prov)
set flag_viario      $coimtgen(flag_viario)
set gg_conferma_inco $coimtgen(gg_conferma_inco)
set flag_avvisi      $coimtgen(flag_avvisi)
set data_corrente [iter_set_sysdate]

if {$flag_ente == "C"} {
    set luogo $coimtgen(denom_comune)
} else {
    set cod_prov $coimtgen(cod_provincia)
    if {[db_0or1row get_desc_prov ""] == 0} {
	set luogo ""
    } else {
	set luogo $desc_prov
    }
}

if {![string equal $f_id_caus ""]} {
    set where_id_caus " and a.id_caus = :f_id_caus"
} else {
    set where_id_caus ""
}
if {![string equal $f_importo ""]} {
    set where_importo " and (coalesce(a.importo, 0) - coalesce(a.importo_pag, 0)) > :f_importo"
} else {
    set where_importo ""
}
if {![string equal $f_contatore ""]} {
    set where_contatore " and a.contatore = :f_contatore"
} else {
    set where_contatore ""
}
if {![string equal $f_data_scadenza ""]} {
    set where_scadenza " and a.data_scad > :f_data_scadenza"
} else {
    set where_scadenza ""
}
if {![string equal $f_cod_comune ""]} {
    set where_comune " and b.cod_comune = :f_cod_comune"
} else {
    set where_comune ""
}

if {$conta_flag == "t"} {
    set conta_inco 0
    if {$flag_viario == "T"} {
        db_0or1row sel_conta_movi_si_viae ""
    } else {
        db_0or1row sel_conta_movi_no_viae ""
    }
    set link_conta "N. impianti: <b>$conta_inco</b>"
}

if {$flag_viario == "T"} {
    set sql_query [db_map sel_movi_si_viae]
} else {
    set sql_query [db_map sel_movi_no_viae]
}
set table_result [ad_table  -Tmissing_text "Nessun dato corrisponde ai criteri impostati." -Textra_vars {} go $sql_query $table_def]

# preparo url escludendo last_cod_impianto che viene passato esplicitamente
# per poi preparare il link alla prima ed eventualmente alla prossima pagina
set url_vars [export_ns_set_vars "url" last_cod_impianto]
set link_altre_pagine ""

# creo testata della lista
set list_head [iter_list_head $form_di_ricerca   $col_di_ricerca \
		   $link_conta    $link_altre_pagine $link_righe ""]

db_release_unused_handles
ad_return_template 
