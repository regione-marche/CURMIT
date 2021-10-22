ad_page_contract {
    Lista tabella "coimbsog"

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

    @cvs-id coimbsog-list.tcl 
    USER  DATA       MODIFICHE
    ===== ========== =========================================================================
    rom02 31/01/2019 Aggiunte query dml_cimp_resp e dml_dope_resp per aggiornare il responsabile
    rom02            sulle DFM e sui Rapporti di Ispezione

    rom01 27/11/2018 Aggiunte query dml_dimp_resp, dml_dimp_occu, dml_dimp_prop per aggiornare 
    rom01            il responsabile, l'occupante e il proprietario sulle dichiarazioni.

} { 
   {search_word       ""}
   {rows_per_page     ""}
   {caller            "index"}
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

set page_title  "Bonifica Soggetti"
set context_bar [iter_context_bar -nome_funz $nome_funz_caller]
set mex_error   ""

# preparo link per ritorna al filtro:
set link_list [export_url_vars caller nome_funz nome_funz_caller f_nome search_word]


# sproteggo la chiave solo in inserimento e gli attributi in inserimento e mod.
set form_name    "coimbsog"
set readonly_key "readonly"
set readonly_fld "readonly"
set disabled_fld "disabled"
set onsubmit_cmd ""
set button_label "Conferma"

form create $form_name \
-html    $onsubmit_cmd

element create $form_name nome_funz      -widget hidden -datatype text -optional
element create $form_name nome_funz_caller -widget hidden -datatype text -optional
element create $form_name search_word    -widget hidden -datatype text -optional
element create $form_name f_nome         -widget hidden -datatype text -optional
element create $form_name caller         -widget hidden -datatype text -optional
element create $form_name submit         -widget submit -datatype text -label "$button_label" -html "class form_submit"
element create $form_name destinazione   -widget hidden -datatype text -optional
element create $form_name compatta_list -widget hidden -datatype text -optional


# scarto dalla lista dei soggetti da bonificare il soggetto destinazione 
foreach cod_sogg_temp $compatta_list {
    if {$cod_sogg_temp ne $destinazione} {
	lappend compatta_list_temp $cod_sogg_temp
    }
}

if {[form is_request $form_name]} {
    element set_properties $form_name search_word      -value $search_word
    element set_properties $form_name f_nome           -value $f_nome
    element set_properties $form_name nome_funz        -value $nome_funz
    element set_properties $form_name nome_funz_caller -value $nome_funz_caller
    element set_properties $form_name destinazione     -value $destinazione
    element set_properties $form_name compatta_list    -value $compatta_list
    
    set sogg_da_compattare "<table border=1 cellpadding=1 cellspacing=0>
                           <tr>
                              <th>Nominativo</th>
                              <th>Indirizzo</th>
                              <th>Comune</th>
                              <th>Codice fiscale</th>
                           </tr>"

    foreach cod_sogg $compatta_list_temp {
	if {[db_0or1row sel_sogg ""] == 1} {
	    append sogg_da_compattare "<tr>
                                         <td>$nominativo</td>
                                         <td>$indirizzo</td>
                                         <td>$comune</td>
                                         <td>$cod_fiscale</td>
                                      </tr>"
	}
    }
    append sogg_da_compattare "</table>"
    set cod_sogg $destinazione 
    if {[db_0or1row  sel_sogg ""] == 0} {
	set descr_topo ""
	set descr_estesa ""
    }
    set sogg_destinazione "<table border=1 cellpadding=1 cellspacing=>
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

    set dml_upd_aimp_prop [db_map upd_aimp_prop] 
    set dml_upd_aimp_occu [db_map upd_aimp_occu] 
    set dml_upd_aimp_ammi [db_map upd_aimp_ammi] 
    set dml_upd_aimp_resp [db_map upd_aimp_resp] 
    set dml_upd_aimp_inte [db_map upd_aimp_inte]
    set dml_upd_aimp_rife [db_map upd_aimp_rife] 
    set dml_del_sogg [db_map del_sogg] 
    set dml_upd_dimp_resp [db_map upd_dimp_resp];#rom01
    set dml_upd_dimp_occu [db_map upd_dimp_occu];#rom01
    set dml_upd_dimp_prop [db_map upd_dimp_prop];#rom01
    set dml_upd_cimp_resp [db_map upd_cimp_resp];#rom02
    set dml_upd_dope_resp [db_map upd_dope_resp];#rom02

    with_catch error_msg {
	db_transaction {
	    foreach cod_sogg $compatta_list_temp {
		db_dml dml_aimp_prop $dml_upd_aimp_prop
		db_dml dml_aimp_occu $dml_upd_aimp_occu
		db_dml dml_aimp_ammi $dml_upd_aimp_ammi
		db_dml dml_aimp_resp $dml_upd_aimp_resp
		db_dml dml_aimp_inte $dml_upd_aimp_inte
		db_dml dml_aimp_rife $dml_upd_aimp_rife
		db_dml dml_dimp_resp $dml_upd_dimp_resp;#rom01
		db_dml dml_dimp_occu $dml_upd_dimp_occu;#rom01
                db_dml dml_dimp_prop $dml_upd_dimp_prop;#rom01
		db_dml dml_cimp_prop $dml_upd_cimp_resp;#rom02
		db_dml dml_dope_prop $dml_upd_dope_resp;#rom02
		db_dml dml_sogg $dml_del_sogg
	    }
	    

	    
	}
    } {
	iter_return_complaint "Spiacente, ma il DBMS ha restituito il
        seguente messaggio di errore <br><b>$error_msg</b><br>
        Contattare amministratore di sistema e comunicare il messaggio
        d'errore. Grazie."
    }


    set return_url   "coimbsog-list?[export_url_vars destinazione compatta_list nome_funz nome_funz_caller f_nome search_word]"    
    ad_returnredirect $return_url
    ad_script_abort
}

db_release_unused_handles
ad_return_template 
