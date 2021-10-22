ad_page_contract {
    Lista tabella "coimbman"

    @author                  Giulio Laurenzi
    @creation-date           01/06/2005

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

    @cvs-id coimbman-list.tcl 
} { 
   {search_word       ""}
   {rows_per_page     ""}
   {caller            "index"}
   {nome_funz         ""}
   {nome_funz_caller  ""}
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
    #set id_utente [ad_get_cookie   iter_login_[ns_conn location]]
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

set page_title      "Bonifica combustibili"
set context_bar [iter_context_bar -nome_funz $nome_funz_caller]
set mex_error ""

# preparo link per ritorna al filtro:
set link_list [export_url_vars caller nome_funz nome_funz_caller search_word]


# sproteggo la chiave solo in inserimento e gli attributi in inserimento e mod.
set form_name    "coimbman"
set readonly_key "readonly"
set readonly_fld "readonly"
set disabled_fld "disabled"
set onsubmit_cmd ""
set button_label "Conferma"

form create $form_name \
-html    $onsubmit_cmd

element create $form_name nome_funz    -widget hidden -datatype text -optional
element create $form_name nome_funz_caller -widget hidden -datatype text -optional
element create $form_name search_word  -widget hidden -datatype text -optional
element create $form_name caller       -widget hidden -datatype text -optional
element create $form_name submit       -widget submit -datatype text -label "$button_label" -html "class form_submit"
element create $form_name destinazione  -widget hidden -datatype text -optional
element create $form_name compatta_list -widget hidden -datatype text -optional

if {[form is_request $form_name]} {
    element set_properties $form_name search_word   -value $search_word
    element set_properties $form_name nome_funz     -value $nome_funz
    element set_properties $form_name nome_funz_caller -value $nome_funz_caller
    element set_properties $form_name destinazione  -value $destinazione
    element set_properties $form_name compatta_list -value $compatta_list
    
    set comb_da_compattare "<table border=1 cellpadding=1 cellspacing=0>
                           <tr>
                              <th>Nome combustibile</th>
                           </tr>
                           
"
    foreach cod_comb $compatta_list {
	if {[db_0or1row sel_comb ""] == 1} {
	    append comb_da_compattare "<tr>
                                         <td>$descr_comb</td>
                                      </tr>"
	}
    }
    append comb_da_compattare "</table>"
    set cod_comb $destinazione 
    if {[db_0or1row  sel_comb ""] == 0} {
	set descr_comb ""
    }
    set comb_destinazione "<table border=1 cellpadding=1 cellspacing=>
                          <tr>
                              <th>Nome combustibile</th>
                          </tr>
                          <tr>
                             <td>$descr_comb</td>
                          </tr>
                          </table>"
}

if {[form is_valid $form_name]} {

    set dml_upd_gend      [db_map upd_gend]
    set dml_upd_aimp      [db_map upd_aimp]
    set dml_upd_cimp      [db_map upd_cimp]
    set dml_del_comb      [db_map del_comb] 

    with_catch error_msg {
	db_transaction {
	    foreach cod_comb $compatta_list {
		db_dml dml_gend $dml_upd_gend
		db_dml dml_aimp $dml_upd_aimp
		db_dml dml_cimp $dml_upd_cimp
		db_dml dml_comb $dml_del_comb
	    }
	    

	    
	}
    } {
	iter_return_complaint "Spiacente, ma il DBMS ha restituito il
        seguente messaggio di errore <br><b>$error_msg</b><br>
        Contattare amministratore di sistema e comunicare il messaggio
        d'errore. Grazie."
    }


    set return_url   "coimbcom-list?[export_url_vars destinazione compatta_list nome_funz nome_funz_caller search_word]"    
    ad_returnredirect $return_url
    ad_script_abort
}

db_release_unused_handles
ad_return_template 
