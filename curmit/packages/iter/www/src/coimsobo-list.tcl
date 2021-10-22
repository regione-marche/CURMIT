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

    @cvs-id coimestr-list.tcl
} { 
    {cod_inco          ""}
    {funzione          ""}
    {caller       "index"}
    {nome_funz         ""}
    {nome_funz_caller  ""}
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

set page_title "Lista solleciti bollini"

set context_bar [iter_context_bar -nome_funz $nome_funz_caller]

# imposto le variabili da usare nel frammento html di testata della lista.
set curr_prog       [file tail [ns_conn url]]
set gest_prog       "coimsobo-layout"
set list_prog       "coimsobo-list"
set form_di_ricerca ""

set link_righe      ""
set link_aggiungi   ""
set link_filter     ""

#set extra_par       [list   manutentore       $nome_manu \
#                            nr_bollini        $nr_bollini \
#                            data_scadenza     $data_scadenza \
#                            data_stampa       $data_stampa]

set form_name              "coimsobo"
set value_caller           [ad_quotehtml $caller]
set value_nome_funz        [ad_quotehtml $nome_funz]
set value_nome_funz_caller [ad_quotehtml $nome_funz_caller]

set actions     ""
set js_function ""

# imposto la struttura della tabella
set table_def [list \
              [list action           "Conf."          no_sort {<td align=center><input type=checkbox name=conferma value="$cod_bollini"></td>}] \
	      [list nome_manu        "Manutentore"    no_sort      {l}] \
	      [list nr_bollini       "Numero bollini" no_sort      {l}] \
	      [list data_scadenza    "Data scadenza"  no_sort      {l}] \
	      [list data_stampa      "Data stampa"    no_sort      {l}] \
		  ]

# imposto la query SQL
set sql_query [db_map sel_boll]

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
set rec_estratti "Nr. solleciti: <b>$ctr_rec_edit</b>"

set col_di_ricerca ""
# preparo url escludendo last_cod_impianto che viene passato esplicitamente
# per poi preparare il link alla prima ed eventualmente alla prossima pagina
# non serve per questo programma
# set url_vars [export_ns_set_vars "url" last_cod_impianto]
# set link_altre_pagine "Vai alla <a href=\"$curr_prog?$url_vars\">prima pagina</a>"
set link_altre_pagine ""

# creo testata della lista
set list_head [iter_list_head $form_di_ricerca   $col_di_ricerca \
	       $rec_estratti  $link_altre_pagine $link_righe ""]

db_release_unused_handles
ad_return_template 
