ad_page_contract {
    Pagina di accesso agli enti della Regione Lombardia.
    
    @author Nicola Mortoni, Gianni Prosperi
    @date   26/10/2006

    @cvs_id aggiornamento-db-filter.tcl
} {
    {nome_funz             ""}
    {nome_funz_caller      ""}
    {caller           "index"}
    {sql_istruction}
}

set logo_url [iter_set_logo_dir_url]

set sql_istruction [string trimright $sql_istruction]


set titolo     "Aggiornamento tabelle dei database regionali - Selezione database"
set page_title $titolo
set main_directory [ad_conn package_url]
set context_bar [iter_context_bar [list ${main_directory}main "Home"] "$titolo"]
#set url_nome_funz [export_url_vars nome_funz]

if {$nome_funz_caller eq ""} {
    set nome_funz_caller $nome_funz
}
set value_caller           [ad_quotehtml $caller]
set value_nome_funz        [ad_quotehtml $nome_funz]
set value_nome_funz_caller [ad_quotehtml $nome_funz_caller]


set form_name "aggiornamento_db_list"
set button_label "Vai"
set onsubmit_cmd ""
set readonly_fld \{\}

form create $form_name \
-html    $onsubmit_cmd

# imposto la struttura della tabella
set table_def [list \
		   [list action            "Conf."              no_sort {<td align=center><input type=checkbox name="nome_database" value="$nome_database"></td>}] \
		   [list denominazione_ente  "Denominazione Ente" no_sort      {l}] \
		   ]

set sel_database_enti "sel_database_enti"
set sql_query [db_map $sel_database_enti]

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

ad_return_template
