ad_page_contract {
    Lista tabella "coimfile_pagamenti_postali"

    @author                  Nicola Mortoni
    @creation-date           16/10/2014

    @param search_word       parola da ricercare con una query
    @param rows_per_page     una delle dimensioni della tabella  

    @param caller            se diverso da index rappresenta il nome del form da cui e' partita
    @                        la ricerca ed in questo caso imposta solo azione "sel"

    @param nome_funz         identifica l'entrata di menu, serve per le autorizzazioni
    @param nome_funz_caller  identifica l'entrata di menu, serve per la navigation bar

    @param receiving_element nomi dei campi di form che riceveranno gli argomenti restituiti
    @                        dallo script di zoom, separati da '|'.

    @cvs-id coimfile-pagamenti-postali-list.tcl 
} {
    {search_word             ""}
    {rows_per_page           ""}
    {caller             "index"}
    {nome_funz               ""}
    {nome_funz_caller        ""} 
    {receiving_element       ""}
    {last_cod_file           ""}

    {f_data_caricamento_da   ""}
    {f_data_caricamento_a    ""}
    {f_nome_file             ""}

    {flag_totali            ""}

}  -properties {
    page_title:onevalue
    context_bar:onevalue
    list_head:onevalue
    table_result:onevalue
}

# Controlla lo user
#if {![string is space $nome_funz]} {
    set lvl        1
    set id_utente [lindex [iter_check_login $lvl $nome_funz] 1]
#} else {
    # se la lista viene chiamata da un cerca, allora nome_funz non viene passato
    # e bisogna reperire id_utente dai cookie
#   Per ora, non contemplo questo caso.
#    set id_utente [iter_get_id_utente]
#    if {$id_utente  == ""} {
#	set login [ad_conn package_url]
#	iter_return_complaint "Per accedere a questo programma devi prima eseguire la procedura di <a href=$login>Login.</a>"
#	return 0
#    }
#}

# controllo il parametro di "propagazione" per la navigation bar
if {[string is space $nome_funz_caller]} {
    set nome_funz_caller $nome_funz
}

set page_title  "Lista File ricevuti dalle poste contenenti i pagamenti"
set context_bar [iter_context_bar -nome_funz $nome_funz_caller]

# imposto le variabili da usare nel frammento html di testata della lista.
set curr_prog       [file tail [ns_conn url]]
set gest_prog       "coimfile_pagamenti_postali-gest"
set form_di_ricerca [iter_search_form $curr_prog $search_word]
set col_di_ricerca  "Nome File"
set extra_par       [list search_word           $search_word \
			  rows_per_page         $rows_per_page \
			  f_data_caricamento_da $f_data_caricamento_da \
			  f_data_caricamento_a  $f_data_caricamento_a \
                          f_nome_file           $f_nome_file \
			  flag_totali           $flag_totali \
		          receiving_element     $receiving_element
		    ]

if {$flag_totali != "t"} {
    set link_totali    "<a href=\"$curr_prog?flag_totali=t&[export_ns_set_vars url flag_totali]\">Totali</a>"
} else {
    set link_totali ""
}

set link_filter     [export_ns_set_vars url]
set link_aggiungi   "<a href=\"coimfile-pagamenti-postali-gest?[export_url_vars caller nome_funz last_cod_file extra_par]\">Carica file ricevuto dalle poste contenente i pagamenti</a>"
set rows_per_page   [iter_set_rows_per_page $rows_per_page $id_utente]
set link_righe      [iter_rows_per_page     $rows_per_page]

set view_file_caricamento "<td nowrap><a target=\"Vedi file\" href=\"coimfile-pagamenti-postali-view?[export_url_vars nome_funz]&oid=\$file_caricamento\">Vedi file</a></td>"
set view_file_caricati    "<td nowrap><a target=\"Vedi file\" href=\"coimfile-pagamenti-postali-view?[export_url_vars nome_funz]&oid=\$file_caricati\">Vedi file</a></td>"
set view_file_scartati    "<td nowrap><a target=\"Vedi file\" href=\"coimfile-pagamenti-postali-view?[export_url_vars nome_funz]&oid=\$file_scartati\">Vedi file</a></td>"
set js_function ""

# imposto la struttura della tabella
set table_def [list \
		   [list data_caricamento_edit "Data caric."          no_sort {c}] \
		   [list cod_file              "Cod. file"            no_sort {r}] \
		   [list nome_file             "Nome file"            no_sort {l}] \
		   [list cog_nom_utente        "Utente"               no_sort {l}] \
		   [list record_caricati_edit  "N. record caricati"   no_sort {r}] \
		   [list importo_caricati_edit "Imp. record caricati" no_sort {r}] \
		   [list record_scartati_edit  "N. record scartati"   no_sort {r}] \
		   [list importo_scartati_edit "Imp. record scartati" no_sort {r}] \
		   [list view_file_caricamento "File input"           no_sort $view_file_caricamento] \
		   [list view_file_caricati    "File caricati"        no_sort $view_file_caricati] \
		   [list view_file_scartati    "File scartati"        no_sort $view_file_scartati] \
		  ]

# imposto la query SQL 
if { [string equal $search_word ""]
&&  ![string equal $f_nome_file ""]
} {
    set search_word $f_nome_file
}

if {[string equal $search_word ""]} {
    set where_word ""
} else {
    set search_word_1 [iter_search_word $search_word]
    set where_word  "and a.nome_file like upper(:search_word_1)"
}

# imposto filtro per le date
if {![string equal $f_data_caricamento_da ""] || ![string equal $f_data_caricamento_a ""]} {
    if {[string equal $f_data_caricamento_da ""]} {
	set f_data_caricamento_da "18000101"
    }
    if {[string equal $f_data_caricamento_a  ""]} {
	set f_data_caricamento_a  "21001231"
    }
    set where_data_caricamento    "and a.data_caricamento between :f_data_caricamento_da
                                                              and :f_data_caricamento_a"
} else {
    set where_data_caricamento ""
}

# imposto la condizione per la prossima pagina
if {![string is space $last_cod_file]} {
    set last_data_caricamento [lindex $last_cod_file 0]
    set last_cod_file         [lindex $last_cod_file 1]
    # l'ordinamento e' descending e quindi uso < al posto di >
    set where_last "and (   (    a.data_caricamento  = :last_data_caricamento
                             and a.cod_file         <= :last_cod_file)
                         or      a.data_caricamento <  :last_data_caricamento
                        )"
} else {
    set where_last ""
}

if {$flag_totali == "t"} {
    # estraggo il numero dei record estratti
    db_1row sel_file_pagamenti_postali_sum ""
    set link_totali "
    <table>
      <tr>
         <td>File selezionati:   </td><td align=right><b>$num_file_pagamenti_postali</b></td>
         <td colspan=2>&nbsp;</td>
      </tr>
      <tr>
         <td>Tot. rec. caricati: </td><td align=right><b>$tot_record_caricati</b></td>
         <td>Tot. imp. caricato: </td><td align=right><b>$tot_importo_caricati</b></td>
      </tr>
      <tr>
         <td>Tot. rec. scartati: </td><td align=right><b>$tot_record_scartati</b></td>
         <td>Tot. imp. scartato: </td><td align=right><b>$tot_importo_scartati</b></td>
      </tr>
    </table>"
}

set sel_file_pagamenti_postali [db_map sel_file_pagamenti_postali]
set table_result [ad_table -Tmax_rows $rows_per_page -Tmissing_text "Nessun dato corrisponde ai criteri impostati." -Textra_vars {cod_file last_cod_file nome_funz nome_funz_caller extra_par data_caricamento} go $sel_file_pagamenti_postali $table_def]

# preparo url escludendo last_cod_file che viene passato esplicitamente
# per poi preparare il link alla prima ed eventualmente alla prossima pagina
set url_vars          [export_ns_set_vars "url" last_cod_file]
set link_altre_pagine "Vai alla <a href=\"$curr_prog?$url_vars\">prima pagina</a>"

# preparo link a pagina successiva
set ctr_rec [expr [regsub -all <tr $table_result <tr comodo] -1]
if {$ctr_rec == $rows_per_page} {
    set last_cod_file        [list $data_caricamento $cod_file]
    append url_vars          "&[export_url_vars last_cod_file]"
    append link_altre_pagine " o alla <a href=\"$curr_prog?$url_vars\">pagina successiva</a>"
}

# creo testata della lista
set list_head [iter_list_head \
		   $form_di_ricerca                 $col_di_ricerca \
		   "$link_aggiungi<br>$link_totali" $link_altre_pagine \
		   $link_righe                      "Righe per pagina"]

db_release_unused_handles
ad_return_template 
