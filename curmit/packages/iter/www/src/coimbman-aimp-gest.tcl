ad_page_contract {

    @author            Serena Saccani
    @creation-date     20.02.2013

    @cvs-id            coimbman-aimp-list.tcl 
} { 
    {search_word       ""}
    {rows_per_page     ""}
    {caller       "index"}
    {nome_funz         ""}
    {nome_funz_caller  ""}
    {f_nome            ""}
    {destinazione      ""}
    {compatta_list     ""}
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
    set id_utente [ad_get_cookie   iter_login_[ns_conn location]]
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

set page_title  "Bonifica manutentori con aggiornamento solo dell'impianto"
set context_bar [iter_context_bar -nome_funz $nome_funz_caller]
set mex_error ""

# preparo link per ritorna al filtro:
set link_list [export_url_vars caller nome_funz nome_funz_caller f_nome search_word]

# sproteggo la chiave solo in inserimento e gli attributi in inserimento e mod.
set form_name    "coimbman"
set readonly_key "readonly"
set readonly_fld "readonly"
set disabled_fld "disabled"
set onsubmit_cmd ""
set button_label "Conferma"

form create $form_name \
    -html    $onsubmit_cmd

element create $form_name nome_funz        -widget hidden -datatype text -optional
element create $form_name nome_funz_caller -widget hidden -datatype text -optional
element create $form_name search_word      -widget hidden -datatype text -optional
element create $form_name f_nome           -widget hidden -datatype text -optional
element create $form_name caller           -widget hidden -datatype text -optional
element create $form_name submit           -widget submit -datatype text -label "$button_label" -html "class form_submit"
element create $form_name destinazione     -widget hidden -datatype text -optional
element create $form_name compatta_list    -widget hidden -datatype text -optional

if {[form is_request $form_name]} {
    element set_properties $form_name search_word      -value $search_word
    element set_properties $form_name f_nome           -value $f_nome
    element set_properties $form_name nome_funz        -value $nome_funz
    element set_properties $form_name nome_funz_caller -value $nome_funz_caller
    element set_properties $form_name destinazione     -value $destinazione
    element set_properties $form_name compatta_list    -value $compatta_list
    
    set manu_da_compattare "<table border=1 cellpadding=1 cellspacing=0>
                           <tr>
                              <th>Nominativo</th>
                              <th>Indirizzo</th>
                              <th>Comune</th>
                              <th>Codice fiscale</th>
                           </tr>"
    
    foreach cod_manu $compatta_list {
	if {[db_0or1row sel_manu ""] == 1} {
	    append manu_da_compattare "<tr>
                                         <td>$nominativo</td>
                                         <td>$indirizzo</td>
                                         <td>$comune</td>
                                         <td>$cod_fiscale</td>
                                      </tr>"
	}
    }
    append manu_da_compattare "</table>"
    set cod_manu $destinazione 
    if {[db_0or1row  sel_manu ""] == 0} {
	set descr_topo ""
	set descr_estesa ""
    }
    set manu_destinazione "<table border=1 cellpadding=1 cellspacing=>
                          <tr>
                              <th>Nominativo</th>
                              <th>Indirizzo</th>
                              <th>Comune</th>
                              <th>Codice fiscale</th>
                          </tr>
                          <tr>
                             <td>$nominativo</td>
                             <td>$indirizzo</td>
                             <td>$comune</td>
                             <td>$cod_fiscale</td>
                          </tr>
                          </table>"
}

if {[form is_valid $form_name]} {

    set dml_upd_aimp [db_map upd_aimp]

    with_catch error_msg {
	db_transaction {
	    foreach cod_manu $compatta_list {
		db_dml dml_aimp $dml_upd_aimp
	    }
	}
    } {
	iter_return_complaint "Spiacente, ma il DBMS ha restituito il
        seguente messaggio di errore <br><b>$error_msg</b><br>
        Contattare amministratore di sistema e comunicare il messaggio
        d'errore. Grazie."
    }

    set return_url   "coimbman-aimp-list?[export_url_vars destinazione compatta_list nome_funz nome_funz_caller f_nome search_word]"    
    ad_returnredirect $return_url
    ad_script_abort
}

db_release_unused_handles
ad_return_template 
