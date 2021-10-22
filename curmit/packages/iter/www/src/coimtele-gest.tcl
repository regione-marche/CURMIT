ad_page_contract {
    Bonifica allegati E3 (teleriscaldamento - vecchia normativa)

    @author                  Giulio Laurenzi
    @creation-date           23/08/2005

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

    @cvs-id coimtele-gest.tcl 

    #Simone: in data 12/01/2015 deciso con Sandro e Nicola di non effettuare più la bonifica
    #sugli Allegati E3.
    #Il programma non viene più utilizzato: da menu' viene chiamato coimtele-ins-gest.
} { 
    {caller          "index"}
    {nome_funz            ""}
    {nome_funz_caller     ""}
    {search_word          ""}
    {cod_impianto_est_new ""}
    
    {f_resp_cogn          ""} 
    {f_resp_nome          ""} 
    
    {f_comune             ""}
    {f_cod_via            ""}
    
    {f_desc_via           ""}
    {f_desc_topo          ""}
    {destinazione         ""}
    {compatta_list        ""}
    {flag_tracciato       ""}
    {cod_as_resp         ""}
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

# acquisisco i parametri generali
iter_get_coimtgen
set flag_ente   $coimtgen(flag_ente)
set sigla_prov  $coimtgen(sigla_prov)
set flag_viario $coimtgen(flag_viario)
set flag_codifica_reg  $coimtgen(flag_codifica_reg)

set page_title  "Inserimento Autocertificazione - Bonifica Impianti"
set context_bar [iter_context_bar -nome_funz $nome_funz_caller]
set mex_error ""

# preparo link per ritorna al filtro:
set link_list [export_url_vars caller nome_funz nome_funz_caller cod_comune search_word cod_impianto_est_new f_resp_cogn f_resp_nome f_comune f_cod_via f_desc_via f_desc_topo flag_tracciato cod_as_resp]


# sproteggo la chiave solo in inserimento e gli attributi in inserimento e mod.
set form_name    "coimtele"
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
element create $form_name cod_impianto_est_new -widget hidden -datatype text -optional
element create $form_name f_resp_cogn  -widget hidden -datatype text -optional
element create $form_name f_resp_nome  -widget hidden -datatype text -optional
element create $form_name f_comune     -widget hidden -datatype text -optional
element create $form_name f_cod_via    -widget hidden -datatype text -optional
element create $form_name f_desc_via   -widget hidden -datatype text -optional
element create $form_name f_desc_topo  -widget hidden -datatype text -optional
element create $form_name flag_tracciato -widget hidden -datatype text -optional
element create $form_name cod_as_resp   -widget hidden -datatype text -optional
element set_properties $form_name flag_tracciato -value $flag_tracciato
element set_properties $form_name cod_as_resp -value $cod_as_resp
# stabilisco l'ordinamento ed uso una inner join al posto di una outer join
# sulle tabelle dove uso un filtro (Ottimizzazione solo per postgres)
set citt_join_pos "left outer join"
set citt_join_ora "(+)"

if {![string equal $f_resp_cogn ""]
    ||  ![string equal $f_resp_nome ""]
    || (   [string equal $f_cod_via   ""]
	   && [string equal $f_desc_topo ""]
	   && [string equal $f_desc_via  ""])
} {
    set ordine        "nome"
    set citt_join_pos "inner join"
    set citt_join_ora ""
} else {
    set ordine "via"
}

if {[db_0or1row sel_aimp_stato_cod_est ""] == 0} {
    set stato_aimp_destinazione ""
    set cod_impianto_est_destinazione ""
}

if {$flag_ente == "P"
    &&  $sigla_prov == "LI"
    &&  $stato_aimp_destinazione != "A"
    &&  [db_0or1row sel_aimp_check_cod_est ""] == 1
} {
    set error_msg "<font color=red><b>Il nuovo codice impianto $cod_impianto_est_new &egrave; gi&agrave; presente sul data base</b></font>"
} else {
    set error_msg ""
}

# imposto l'ordinamento della query e la condizione per la prossima pagina
set col_numero  "to_number(a.numero,'99999999')"
switch $ordine {
    "via" {
	switch $flag_viario {
	    "T" {set col_via "d.descrizione"}
	    "F" {set col_via "a.indirizzo" }
	}

        set ordinamento "order by $col_via
                                , $col_numero
                                , a.cod_impianto_est"
    }

    "nome"   {
	set ordinamento "order by b.cognome, b.nome, a.cod_impianto_est"
    }
    default {
	set ordinamento ""
    }
}

set form_request {

    element set_properties $form_name search_word   -value $search_word
    element set_properties $form_name nome_funz     -value $nome_funz
    element set_properties $form_name nome_funz_caller -value $nome_funz_caller
    element set_properties $form_name destinazione  -value $destinazione
    element set_properties $form_name compatta_list -value $compatta_list
    element set_properties $form_name cod_impianto_est_new -value $cod_impianto_est_new    
    element set_properties $form_name f_resp_cogn   -value $f_resp_cogn
    element set_properties $form_name f_resp_nome   -value $f_resp_nome
    element set_properties $form_name f_comune      -value $f_comune 
    element set_properties $form_name f_cod_via     -value $f_cod_via
    element set_properties $form_name f_desc_via    -value $f_desc_via
    element set_properties $form_name f_desc_topo   -value $f_desc_topo


    set aimp_da_compattare "<table border=1 cellpadding=1 cellspacing=0>
                           <tr>
                              <th>Responsabile</th>
                              <th>Comune</th>
                              <th>Indirizzo</th>
                           </tr>
                           "
    if {$flag_viario == "T"} {
	set sql_impianto sel_aimp_vie
    } else {
	set sql_impianto sel_aimp_no_vie
    }

    foreach cod_impianto $compatta_list {
	if {[db_0or1row $sql_impianto ""] == 1} {
	    append aimp_da_compattare "<tr>
                                         <td>$resp</td>
                                         <td>$comune</td>
                                         <td>$indir</td>
                                      </tr>"
	}
    }
    append aimp_da_compattare "</table>"
    set cod_impianto $destinazione 
    if {[db_0or1row  $sql_impianto ""] == 0} {
	#	set descr_topo ""
	#	set descr_estesa ""
    }
    if {![string equal $cod_impianto_est_new ""]} {
	set codice_tab1 "<th>Codice</th>"
	set codice_tab2 "<td>$cod_impianto_est_new</td>"
    } else {
	set codice_tab1 ""
	set codice_tab2 ""
    }

    set aimp_destinazione "<table border=1 cellpadding=1 cellspacing=>
                          <tr>
                              $codice_tab1
                              <th>Responsabile</th>
                              <th>Comune</th>
                              <th>Indirizzo</th>
                          </tr>
                          <tr>
                              $codice_tab2
                              <td>$resp</td>
                              <td>$comune</td>
                              <td>$indir</td>
                          </tr>
                          </table>"
}

set form_valid {
    set flag_tracciato        [element::get_value $form_name flag_tracciato]
    set cod_as_resp           [element::get_value $form_name cod_as_resp]
    # estraggo il nuovo codice
    if {$flag_codifica_reg == "T"} {
	db_1row sel_dati_codifica ""
	if {![string equal $potenza "0.00"]} {
	    if {$potenza < 35} {
		set tipologia "IN"
	    } else {
		set tipologia "CT"
	    }
	    set cod_impianto_est_new "$cod_istat$tipologia$progressivo"
	    set dml_comu [db_map upd_prog_comu]
	} else {
	    if {![string equal $cod_potenza "0"]
		&& ![string equal $cod_potenza ""]} { 
		switch $cod_potenza {
		    "B"  {set tipologia "IN"}
		    "A"  {set tipologia "CT"}
		    "MA" {set tipologia "CT"}
		    "MB" {set tipologia "CT"}
		}
		
		set cod_impianto_est_new "$cod_istat$tipologia$progressivo"
		set dml_comu [db_map upd_prog_comu]
	    } else {
		set cod_impianto_est_new ""
	    }
	}
    } else {
	db_1row get_cod_impianto_est ""
    }

    set dml_ins_cimp [db_map ins_cimp]
    set dml_ins_coma [db_map ins_coma]
    set dml_ins_dimp [db_map ins_dimp]
    set dml_ins_docu [db_map ins_docu]
    set dml_upd_gage [db_map upd_gage]
    set dml_ins_gend [db_map ins_gend]
    set dml_upd_inco [db_map upd_inco]
    set dml_ins_inco [db_map ins_inco]
    set dml_ins_movi [db_map ins_movi]
    set dml_ins_prvv [db_map ins_prvv]
    set dml_ins_rife [db_map ins_rife]
    set dml_ins_stub [db_map ins_stub]
    set dml_ins_todo [db_map ins_todo]
    set dml_upd_inco2 [db_map upd_inco2]

    set dml_upd_aimp [db_map upd_aimp] 
    set dml_ins_aimp [db_map ins_aimp] 
    set dml_ins_anom [db_map ins_anom]

    foreach cod_impianto $compatta_list {
	set list_dimp($cod_impianto) [list]
	set list_cimp($cod_impianto) [list]
	db_foreach sel_dimp_cod "" {
	    lappend list_dimp($cod_impianto) $cod_dimp
	}
	db_foreach sel_cimp_cod "" {
	    lappend list_cimp($cod_impianto) $cod_cimp
	}
    }


    with_catch error_msg {
	set flag_tracciato        [element::get_value $form_name flag_tracciato]
	set cod_as_resp           [element::get_value $form_name cod_as_resp]
   	db_transaction {

	    if {[info exists dml_comu]} {
		db_dml dml_coimcomu $dml_comu
	    }
	    if {$stato_aimp_destinazione != "A"} {
		db_1row sel_aimp_cod ""
		db_dml dml_ins_aimp $dml_ins_aimp
		db_dml dml_gend     $dml_ins_gend
		db_dml dml_rife     $dml_ins_rife
		db_dml dml_stub     $dml_ins_stub
		db_dml dml_movi     $dml_ins_movi
		db_dml dml_gage     $dml_upd_gage
		db_dml dml_prvv     $dml_ins_prvv
	    } else {
		set cod_impianto_new $destinazione
	    }


	    if {$stato_aimp_destinazione != "A"} {
		db_dml dml_ins_inco $dml_ins_inco
	    }

	    foreach cod_impianto $compatta_list {
		db_dml dml_aimp $dml_upd_aimp
		db_dml dml_coma $dml_ins_coma	
		db_dml dml_docu $dml_ins_docu
		db_dml dml_inco $dml_upd_inco
		db_dml dml_todo $dml_ins_todo
		foreach cod_cimp $list_cimp($cod_impianto) {
		    db_1row sel_cimp_cod_new ""
		    db_dml dml_cimp $dml_ins_cimp
		    set cod_cimp_dimp_new $cod_cimp_new
		    set cod_cimp_dimp $cod_cimp
		    db_dml dml_anom $dml_ins_anom
		}

                foreach cod_dimp $list_dimp($cod_impianto) {
		    db_1row sel_dimp_cod_new ""
		    db_dml dml_dimp $dml_ins_dimp
		    set cod_cimp_dimp_new $cod_dimp_new
		    set cod_cimp_dimp $cod_dimp
		    db_dml dml_anom $dml_ins_anom
		}
	    }
	    if {![string equal $cod_as_resp ""]} {
		db_dml upd_coim_as_resp "update coim_as_resp set cod_impianto = :cod_impianto_new where cod_as_resp = :cod_as_resp"
		db_1row sel_cod_rapp "select cod_legale_rapp from coim_as_resp where cod_as_resp = :cod_as_resp"
		if {$flag_tracciato == "LMANU"} {
		    db_dml upd_coim_aimp "update coimaimp set cod_responsabile = :cod_legale_rapp, cod_amministratore = :cod_legale_rapp, flag_resp = 'A' where cod_impianto = :cod_impianto_new"
		} else {
		    db_dml upd_coim_aimp "update coimaimp set cod_responsabile = :cod_legale_rapp, flag_resp = 'T' where cod_impianto = :cod_impianto_new"
		}
	    }
	}
    } {
	iter_return_complaint "Spiacente, ma il DBMS ha restituito il
        seguente messaggio di errore <br><b>$error_msg</b><br>
        Contattare amministratore di sistema e comunicare il messaggio
        d'errore. Grazie."
    }

    set return_url   "coimtele-ins-gest?funzione=I&[export_url_vars flag_tracciato cod_as_resp nome_funz_caller search_word cod_impianto_est_new f_resp_cogn f_resp_nome]&nome_funz=[iter_get_nomefunz coimtele-ins-gest]&flag_no_link=T&cod_impianto=$cod_impianto_new"

    ad_returnredirect $return_url
    ad_script_abort
}

if {[string equal $compatta_list ""]} {
    eval $form_valid
} else {
    if {[form is_request $form_name]} {    
	eval $form_request            
    }
    if {[form is_valid $form_name]} {
	eval $form_valid
    }
}

db_release_unused_handles
ad_return_template 
