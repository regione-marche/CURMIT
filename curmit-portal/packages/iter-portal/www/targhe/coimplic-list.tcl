ad_page_contract {
    Lista tabella "coimboll"

    @author                  Simone Pesci        
    @creation-date           06/09/2016

    @param search_word       parola da ricercare con una query
    @param rows_per_page     una delle dimensioni della tabella  

    @param caller            se diverso da index rappresenta il nome del form 
    @                        da cui e' partita la ricerca ed in questo caso
    @                        imposta solo azione "sel"

    @param nome_funz         identifica l'entrata di menu,
    @                        serve per le autorizzazioni

    @param receiving_element nomi dei campi di form che riceveranno gli
    @                        argomenti restituiti dallo script di zoom,
    @                        separati da '|' ed impostarli come segue:

    @cvs-id coimplic-list.tcl 

    USER   DATA       MODIFICHE
    ====== ========== ================================================================================================
    gab01  23/12/2016 Aggiunto alla lista il cod_prenotazione, ordinata la lista per data consegna in modo decrescente
    gab01             Se la lista viene chiamata dal programma coimtarg-rila, mostro solo la lista filtrata per il 
    gab01             codice della prenotazione appena evasa.   
} { 
    {ordtarg_id        ""}
    {is_admin_p        ""}
    {search_word       ""}
    {rows_per_page     ""}
    {caller       "index"}
    {nome_funz         ""}
    {receiving_element ""}
    {last_order        ""}
    {nome_funz_caller  ""}

    {url_manu          ""}
    {cod_manutentore   ""}
    {f_cod_manu        ""}
    {f_data_ril_da     ""}
    {f_data_ril_a      ""}
    {totali_flag       ""}
    {cod_prenotazione  ""}
}  -properties {
    page_title:onevalue
    context_bar:onevalue
    list_head:onevalue
    table_result:onevalue
}

# Controlla lo user
set user_id [auth::require_login]

# l'utente ha diritti di admin sul package?
set admin_p [permission::permission_p \
                 -no_login \
                 -object_id [ad_conn package_id] \
                 -privilege admin
	    ]

# controllo il parametro di "propagazione" per la navigation bar
if {[string is space $nome_funz_caller]} {
    set nome_funz_caller $nome_funz
}

# cod_manutentore viene passato solo da coimmanu-gest
# solo in questo caso va fatto vedere nel titolo e
# passato al programma di inserimento
# negli altri casi va valorizzato con null perche' viene 'erroneamente'
# valorizzato dal programma di gestione durante la gestione della form
if {$nome_funz_caller == $nome_funz} {
    set cod_manutentore ""
}

if {![string equal $cod_manutentore ""]} {
    if {![db_0or1row query "
        select name as manutentore, is_active_p, validated_p, approved_p
          from iter_maintainers
         where iter_code = :cod_manutentore"]} {
	iter_return_complaint "Manutentore non trovato"
    } else {
	set where_manu "and b.iter_code = :cod_manutentore"
	# ------------------------------------------------- 
	# A COSA CORRISPONDE IL FLAG_ATTIVO DI COIMMANU ???
	# ------------------------------------------------- 
	if {$flag_attivo eq "N"} {
	    set flag_manu  "N"
	} else {
	    set flag_manu  "S"
	}
    }
} else {
    set manutentore ""
    set where_manu  ""
    set flag_manu   ""
}

if {![string equal $cod_prenotazione ""]} { ;#gab01
    set where_prenotazione "and o.cod_prenotazione = :cod_prenotazione"   
} else {
    set where_prenotazione ""
}


set page_title "Lista Targhe $manutentore"

if {$caller eq "index"} {
    set context_bar [iter_context_bar \
			 [list / "Home"] \
			 [list /iter-portal "Portale dei Manutentori verso ITER"] \
			 "$page_title"]
} else {
    set context_bar [iter_context_bar \
			 [list "javascript:window.close()" "Torna alla Gestione"] \
			 "$page_title"]
}

# imposto le variabili da usare nel frammento html di testata della lista.
set curr_prog       [file tail [ns_conn url]]
#set gest_prog       "coimtarg-gest"
set form_di_ricerca ""
set col_di_ricerca  ""
set extra_par       [list rows_per_page     $rows_per_page \
			 receiving_element $receiving_element \
			 url_manu          $url_manu \
			 f_cod_manu        $f_cod_manu \
			 f_data_ril_da     $f_data_ril_a \
			 totali_flag       $totali_flag]

if {$totali_flag ne "t"} {
    set link_totali "<a href=\"coimplic-list?[export_url_vars last_order caller nome_funz extra_par nome_funz_caller f_cod_manu f_data_ril_da f_data_ril_a]&totali_flag=t\">Totali</a>"
} else {
    set link_totali ""
}

if {$flag_manu eq "S"} {
    set link_aggiungi "<a href=\"$gest_prog?funzione=I&[export_url_vars cod_manutentore last_order caller nome_funz nome_funz_caller extra_par ]\">Aggiungi</a>"
} else {
    set link_aggiungi ""
}

set rows_per_page   [iter_set_rows_per_page $rows_per_page $user_id]
set link_righe      [iter_rows_per_page     $rows_per_page]

set actions "<td nowrap><a href=\"coimtarg-layout?\[export_url_vars ordtarg_id]\">Stampa</a></td>"
    
if {$caller eq "index"} {
    set link    "\[export_url_vars cod_manutentore last_order nome_funz extra_par nome_funz_caller ordtarg_id is_admin_p\]"
    #set actions "<td nowrap><a href=\"$gest_prog?funzione=V&$link\">Selez.</a></td>"
    set js_function ""
} else {
    #set actions [iter_select [list column_name .... ]]
    set receiving_element [split $receiving_element |]
    set js_function [iter_selected $caller [list [lindex $receiving_element 0]  cod_bollini [lindex $receiving_element 1]]]
}

set link_filter [export_url_vars nome_funz nome_funz_caller]

# imposto la struttura della tabella
#gab01 aggiunto cod_prenotazione
set table_def [list \
		   [list actions              "Azioni"             no_sort $actions] \
		   [list manutentore          "Manutentore"        no_sort {l}] \
                   [list cod_prenotazione     "Prenotazione"       no_sort {c}] \
		   [list data_consegna_edit   "Dt.Consegna"        no_sort {c}] \
		   [list num_targhe           "N.Targhe"           no_sort {r}] \
		  ]

# imposto la query SQL 
if {![string equal $f_cod_manu ""]} {
    set where_f_manu     "and b.iter_code = :f_cod_manu"
    set where_manu_count "and iter_code = :f_cod_manu"
} else {
    set where_f_manu     ""
    set where_manu_count ""
}

if {![string equal $f_data_ril_da ""]} {
    set where_data_da       "and a.data_consegna >= :f_data_ril_da"
    set where_data_da_count "and data_consegna >= :f_data_ril_da"
} else {
    set where_data_da       ""
    set where_data_da_count ""
}

if {![string equal $f_data_ril_a ""]} {
    set where_data_a       "and a.data_consegna <= :f_data_ril_a"
    set where_data_a_count "and data_consegna <= :f_data_ril_a"
} else {
    set where_data_a       ""
    set where_data_a_count ""
}

# imposto la condizione per la prossima pagina
if {![string is space $last_order]} {
    set data_consegna [lindex $last_order 0]
    set where_last " and ((data_consegna  =  :data_consegna and
                           ordtarg_id     >= :ordtarg_id)
                      or   data_consegna  >  :data_consegna)"
} else {
    set where_last ""
}

if {$totali_flag eq "t"} {
    # estraggo il numero dei record estratti
    db_1row query "
   select count(c.*) as conta_records
     from coimplic a
left outer join iter_maintainers b
    on b.maintainer_id = a.maintainer_id
        , coimtarg c
    where 1 = 1
      and c.plico_id = a.plico_id
    $where_manu_count
    $where_data_da_count
    $where_data_a_count
    $where_prenotazione"
    
 
    set link_totali "
    <table>
      <tr>
        <td align=left>Targhe selezionate:</td>
        <td align=right><b>$conta_records</b></td>
      </tr>
      <tr>
    </table>"
}

set sql_query "
select a.ordtarg_id
     , iter_edit_data(a.data_consegna)     as data_consegna_edit
     , coalesce(b.name, ' ')               as manutentore
     , iter_edit_num(count(b.*), 0)        as num_targhe
     , a.data_consegna
     , b.iter_code                         as cod_manutentore
     , o.cod_prenotazione --gab01
  from coimplic a
  left outer join iter_maintainers b 
    on b.maintainer_id = a.maintainer_id
  left outer join iter_ordtarg o       --gab01
    on a.ordtarg_id = o.ordtarg_id     --gab01
     , coimtarg c
 where 1=1
   and c.plico_id = a.plico_id
 $where_manu
 $where_f_manu
 $where_data_da
 $where_data_a
 $where_last
 $where_prenotazione --gab01
 group by a.ordtarg_id
     , iter_edit_data(a.data_consegna)                           
     , coalesce(b.name, ' ')
     , a.data_consegna
     , b.iter_code
     , o.cod_prenotazione --gab01 
order by a.data_consegna desc --gab01
       , a.ordtarg_id"

set table_result [ad_table -Tmax_rows $rows_per_page -Tmissing_text "Nessun dato corrisponde ai criteri impostati." -Textra_vars {cod_bollini last_order nome_funz nome_funz_caller extra_par cod_manutentore data_consegna} go $sql_query $table_def]

# preparo url escludendo last_order che viene passato esplicitamente
# per poi preparare il link alla prima ed eventualmente alla prossima pagina
set url_vars [export_ns_set_vars "url" last_order]
set link_altre_pagine "Vai alla <a href=\"$curr_prog?$url_vars\">prima pagina</a>"

# preparo link a pagina successiva
set ctr_rec [expr [regsub -all <tr $table_result <tr comodo] -1]
if {$ctr_rec == $rows_per_page} {
    # assegna l'order by per la lista
    set last_order [list  $data_consegna $ordtarg_id]
    append url_vars "&[export_url_vars  last_order]"
    append link_altre_pagine " o alla <a href=\"$curr_prog?$url_vars\">pagina successiva</a>"
}

if {$flag_manu eq "S"} {
    # creo testata della lista
    set list_head [iter_list_head  $form_di_ricerca $col_di_ricerca \
		       $link_aggiungi $link_altre_pagine $link_righe "Righe per pagina"]
} else {
    # creo testata della lista
    set list_head [iter_list_head  $form_di_ricerca $col_di_ricerca \
		       $link_totali $link_altre_pagine $link_righe "Righe per pagina"]
}

db_release_unused_handles
ad_return_template 
