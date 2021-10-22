ad_page_contract {
    Lista tabella "coimmovi"

    @author                  Luca Romitti
    @creation-date           04/04/2018

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

    @cvs-id coimmov-fatt-list.tcl 

    USER   DATA       MODIFICHE
    ====== ========== =======================================================================
    rom01  08/06/2018 Aggiunto campo data_fattura su richiesta di Sandro.

} {
    {search_word       ""}
    {rows_per_page     ""}
    {caller       "index"}
    {nome_funz         ""}
    {nome_funz_caller  ""} 
    {receiving_element ""}
    {last_cod_movi     ""}
    {f_data_pag_da     ""}
    {f_data_pag_a      ""}
    {f_importo_da      ""}
    {f_importo_a       ""}
    {f_data_scad_da    ""}
    {f_data_scad_a     ""}
    {f_id_caus         ""}
    {f_tipo_pag        ""}
    {calcola_flag      ""}
    {flag_filter       ""}
    {f_data_compet_da  ""}
    {f_data_compet_a   ""}
    {f_data_incasso_da  ""}
    {f_data_incasso_a   ""}
    {data_fattura       ""}
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

set page_title  "Lista Pagamenti"
set context_bar [iter_context_bar -nome_funz $nome_funz_caller]

# imposto le variabili da usare nel frammento html di testata della lista.
set curr_prog       [file tail [ns_conn url]]
set gest_prog       "coimmov-fatt-gest"
set form_di_ricerca [iter_search_form $curr_prog $search_word]
set col_di_ricerca  "Cognome Responsabile"

set where_id_caus "and a.id_caus = :f_id_caus"

#san01 aggiunto f_data_incasso_da e f_data_incasso_a
set extra_par       [list rows_per_page     $rows_per_page \
			 f_data_pag_da     $f_data_pag_da \
			 f_data_pag_a      $f_data_pag_a  \
			 f_importo_da      $f_importo_da  \
			 f_importo_a       $f_importo_a   \
			 f_data_scad_da    $f_data_scad_da \
			 f_data_scad_a     $f_data_scad_a \
			 f_id_caus         $f_id_caus   \
			 f_tipo_pag        $f_tipo_pag    \
			 calcola_flag      $calcola_flag  \
			 f_data_compet_da  $f_data_compet_da \
			 f_data_compet_a   $f_data_compet_a \
                         f_data_incasso_da  $f_data_incasso_da \
			 f_data_incasso_a   $f_data_incasso_a \
			 receiving_element $receiving_element ]

set form_name              "coimmovi"
set value_caller           [ad_quotehtml $caller]
set value_nome_funz        [ad_quotehtml $nome_funz]
set value_nome_funz_caller [ad_quotehtml $nome_funz_caller]
set value_extra_par        [ad_quotehtml $extra_par]
set value_data_fattura     [ad_quotehtml $data_fattura];#rom01
 

if {$calcola_flag != "t"} {
    set link_calcola    "<a href=\"coimmov-fatt-list?[export_url_vars last_cod_movi caller nome_funz extra_par nome_funz_caller f_data_pag_da f_data_pag_a f_importo_da f_importo_a f_data_scad_da f_data_scad_a f_id_caus f_tipo_pag]&calcola_flag=t\">Totali</a>"
} else {
    set link_calcola ""
}


set link_filter     [export_url_vars nome_funz nome_funz_caller]
set link_aggiungi   ""
set rows_per_page   [iter_set_rows_per_page $rows_per_page $id_utente]
set link_righe      [iter_rows_per_page     $rows_per_page]

set link    "\[export_url_vars cod_movi nome_funz nome_funz_caller extra_par flag_filter\]"
set actions "
    <td nowrap><a href=\"$gest_prog?funzione=V&$link\">Selez.</a></td>"
set js_function ""

# imposto la struttura della tabella
set table_def [list \
		   [list action           "Sel."          no_sort {<td align=center><input type=checkbox name=conferma value="$cod_movi"></td>}] \
		   [list actions          "Azioni"            no_sort $actions] \
		   [list cod_impianto_est "Cod.Imp."          no_sort      {r}] \
		   [list nominativo_resp  "Responsabile"      no_sort      {l}] \
		   [list desc_movi        "Causale pagamento" no_sort      {l}] \
		   [list desc_pag         "Tipo pagamento"    no_sort      {l}] \
		   [list data_scad_edit   "Data scadenza"     no_sort      {c}] \
		   [list data_compet_edit "Data competenza"   no_sort      {c}] \
		   [list importo_edit     "Importo"           no_sort      {r}] \
		   [list data_pag_edit    "Pagato"            no_sort      {c}] \
		  ]

# imposto la query SQL 
#####################à
if {[string equal $search_word ""]} {
    set where_word ""
} else {
    set search_word_1 [iter_search_word $search_word]
    set where_word  " and c.cognome like upper(:search_word_1)"
}

# imposto la condizione per la prossima pagina
if {![string is space $last_cod_movi]} {
    set last_cognome [lindex $last_cod_movi 0]
    set last_nome    [lindex $last_cod_movi 1]
    if {[string equal $last_nome ""]} {
	set nome_last "is null"
    } else {
	set nome_last ">= :last_nome"
    }
    set where_last " and (         c.cognome > :last_cognome
                           or (    c.cognome = :last_cognome
                               and c.nome   $nome_last)
                         )"
} else {
    set where_last ""
}

# imposto filtro per data pagamento
if {![string equal $f_data_pag_da ""]
    ||  ![string equal $f_data_pag_a ""]
} {
    if {[string equal $f_data_pag_da ""]} {
	set f_data_pag_da "18000101"
    }
    if {[string equal $f_data_pag_a ""]} {
	set f_data_pag_a "99991231"
    }
    set where_data_pag "and a.data_pag between :f_data_pag_da and :f_data_pag_a"
} else {
    set where_data_pag ""
}


if {![string equal $f_data_compet_da ""]
    ||  ![string equal $f_data_compet_a ""]
} {
    if {[string equal $f_data_compet_da ""]} {
	set f_data_compet_da "18000101"
    }
    if {[string equal $f_data_compet_a ""]} {
	set f_data_compet_a "99991231"
    }
    set where_data_compet "and a.data_compet between :f_data_compet_da and :f_data_compet_a"
} else {
    set where_data_compet ""
}

if {![string equal $f_data_incasso_da ""]
    ||  ![string equal $f_data_incasso_a ""]
} {#san01 if else e loro contenuto
    if {[string equal $f_data_incasso_da ""]} {
	set f_data_compet_da "18000101"
    }
    if {[string equal $f_data_incasso_a ""]} {
	set f_data_incasso_a "99991231"
    }
    set where_data_incasso "and a.data_incasso between :f_data_incasso_da and :f_data_incasso_a"
} else {
    set where_data_incasso ""
}


if {![string equal $f_data_scad_da ""]
    ||  ![string equal $f_data_scad_a ""]
} {
    if {[string equal $f_data_scad_da ""]} {
	set f_data_scad_da "18000101"
    }
    if {[string equal $f_data_scad_a ""]} {
	set f_data_scad_a "99991231"
    }
    set where_data_scad "and a.data_scad between :f_data_scad_da and :f_data_scad_a"
} else {
    set where_data_scad ""
}


if {![string equal $f_importo_da ""]
    ||  ![string equal $f_importo_a ""]
} {
    if {[string equal $f_importo_da ""]} {
	set f_importo_da "0"
    }
    if {[string equal $f_importo_a ""]} {
	set f_importo_a "9999999999"
    }
    set where_importo "and a.importo between :f_importo_da and :f_importo_a"
} else {
    set where_importo ""
}

if {![string equal $f_tipo_pag ""]} {
    set where_tipo_pag "and a.tipo_pag = :f_tipo_pag"
} else {
    set where_tipo_pag ""
}

if {$calcola_flag == "t"} {
    # estraggo il numero dei record estratti
    db_1row sel_calcola_movi ""
    set link_calcola "Movimenti selezionati: <b>$conta_movi</b><br>
                      Importo totale: <b>$tot_imp_movi</b>"
}

set sel_movi [db_map sel_movi]

set table_result [ad_table -Tmax_rows $rows_per_page -Tmissing_text "Nessun dato corrisponde ai criteri impostati." -Textra_vars {cod_movi last_cod_movi nome_funz nome_funz_caller extra_par flag_filter cognome nome} go $sel_movi $table_def]

# preparo url escludendo last_cod_movi che viene passato esplicitamente
# per poi preparare il link alla prima ed eventualmente alla prossima pagina
set url_vars [export_ns_set_vars "url" last_cod_movi]
#$url_vars
set link_altre_pagine "Vai alla <a href=\"$curr_prog?$url_vars\">prima pagina</a>"

# preparo link a pagina successiva
set ctr_rec [expr [regsub -all <tr $table_result <tr comodo] -1]
if {$ctr_rec == $rows_per_page} {
    set last_cod_movi [list $cognome $nome]
    append url_vars "&[export_url_vars last_cod_movi]"
    append link_altre_pagine " o alla <a href=\"$curr_prog?$url_vars\">pagina successiva</a>"
  
} 
if {$ctr_rec > 0} {
  set link_sel {
	<input type="checkbox" name="checkall_input"  onclick="javascript:checkall();">
	Seleziona/Deseleziona tutti
    }
} else { 
    set link_sel "<br>"
}



# creo testata della lista
set list_head [iter_list_head  $form_di_ricerca $col_di_ricerca \
		   $link_calcola $link_altre_pagine $link_righe "Righe per pagina"]

db_release_unused_handles
ad_return_template 
