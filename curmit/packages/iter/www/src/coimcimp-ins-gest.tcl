ad_page_contract {
    Lista tabella "coimaimp"

    @author                  Giulio Laurenzi
    @creation-date           29/08/2005

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

    @cvs-id coimcimp-ins-gest.tcl 

    USER  DATA       MODIFICHE
    ===== ========== ==========================================================================
    sim03 22/05/2017 Personaliz. per Comune di Jesi: ricodificare gli impianti come da Legge
    sim03            Reg. Marche CMJE.
    sim03            Per Comune di Senigalli: CMSE

    gab02 12/04/2017 Personaliz. per Provincia di Ancona: ricodificare gli impianti come da Legge
    gab02            Reg. Marche PRAN.

    gab01 08/02/2017 Personaliz. per Comune di Ancona: ricodificare gli impianti come da Legge
    gab01            Reg. Marche CMAN.

    sim02 28/09/2016 Taranto ha il codice impianto composto dalle ultime 3 cifre del codice
    sim02            istat + un progressivo.
    sim02            Ho standardizzato come negli altri programmi il calcolo del
    sim02            cod_impianto_est_new che su questo programma non era stato aggiornato.

    nic01 04/02/2016 Gestito coimtgen.lun_num_cod_impianto_est per regione MARCHE

    sim01 28/09/2015 Da ottobre 2015 gli enti della regione marche devono costruire il codice
    sim01            impianto con una sigla imposta dalla regione (es: CMPS) + un progressivo
    sim01            di 6 cifre.

} { 
    {caller          "index"}
    {nome_funz            ""}
    {nome_funz_caller     ""}
    {search_word          ""}

    {f_resp_cogn          ""} 
    {f_resp_nome          ""} 

    {f_comune             ""}
    {f_cod_via            ""}

    {f_desc_via           ""}
    {f_desc_topo          ""}
    {destinazione         ""}
    {compatta_list        ""}

    {receiving_element    ""}
    {cod_impianto         ""}
    {cod_inco             ""}
    {stato                ""}
    {esito                ""}
    {url_list_aimp        ""}
    {url_aimp             ""}
    {extra_par_inco       ""}

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

set link_inco [iter_link_inco $cod_inco $nome_funz_caller $url_list_aimp $url_aimp $nome_funz "" $extra_par_inco]
set dett_tab [iter_tab_form $cod_impianto]


# acquisisco i parametri generali
iter_get_coimtgen
set flag_ente           $coimtgen(flag_ente)
set sigla_prov          $coimtgen(sigla_prov)
set flag_viario         $coimtgen(flag_viario)
set flag_codifica_reg   $coimtgen(flag_codifica_reg)
set lun_num_cod_imp_est $coimtgen(lun_num_cod_imp_est);#nic01

set page_title  "Inserimento Autocertificazione - Bonifica Impianti"
set context_bar [iter_context_bar -nome_funz $nome_funz_caller]
set mex_error ""

# preparo link per ritorna al filtro:
set link_list [export_url_vars caller nome_funz nome_funz_caller cod_comune search_word f_resp_cogn f_resp_nome f_comune f_cod_via f_desc_via f_desc_topo receiving_element cod_impianto cod_inco stato esito url_list_aimp url_aimp extra_par_inco]


# sproteggo la chiave solo in inserimento e gli attributi in inserimento e mod.
set form_name    "coimdimpins"
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
element create $form_name f_resp_cogn  -widget hidden -datatype text -optional
element create $form_name f_resp_nome  -widget hidden -datatype text -optional
element create $form_name f_comune     -widget hidden -datatype text -optional
element create $form_name f_cod_via    -widget hidden -datatype text -optional
element create $form_name f_desc_via   -widget hidden -datatype text -optional
element create $form_name f_desc_topo  -widget hidden -datatype text -optional

element create $form_name receiving_element -widget hidden -datatype text -optional
element create $form_name cod_impianto -widget hidden -datatype text -optional
element create $form_name cod_inco     -widget hidden -datatype text -optional
element create $form_name stato        -widget hidden -datatype text -optional
element create $form_name esito        -widget hidden -datatype text -optional
element create $form_name url_list_aimp -widget hidden -datatype text -optional
element create $form_name url_aimp     -widget hidden -datatype text -optional
element create $form_name extra_par_inco -widget hidden -datatype text -optional
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
    element set_properties $form_name f_resp_cogn   -value $f_resp_cogn
    element set_properties $form_name f_resp_nome   -value $f_resp_nome
    element set_properties $form_name f_comune      -value $f_comune 
    element set_properties $form_name f_cod_via     -value $f_cod_via
    element set_properties $form_name f_desc_via    -value $f_desc_via
    element set_properties $form_name f_desc_topo   -value $f_desc_topo
    element set_properties $form_name receiving_element -value $receiving_element
    element set_properties $form_name cod_impianto  -value $cod_impianto
    element set_properties $form_name cod_inco      -value $cod_inco   
    element set_properties $form_name esito         -value $esito
    element set_properties $form_name stato         -value $stato       
    element set_properties $form_name url_list_aimp -value $url_list_aimp
    element set_properties $form_name url_aimp      -value $url_aimp   
    element set_properties $form_name extra_par_inco -value $extra_par_inco

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

    #    if {![string equal $cod_impianto_est_new ""]} {
    #	set codice_tab1 "<th>Codice</th>"
    #	set codice_tab2 "<td>$cod_impianto_est_new</td>"
    #    } else {
    set codice_tab1 ""
    set codice_tab2 ""
    #    }

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
    if {[db_0or1row sel_aimp_stato ""] == 0} {
	set stato_aimp_destinazione ""
    }

    set dml_ins_cimp  [db_map ins_cimp]
    set dml_ins_coma  [db_map ins_coma]
    set dml_ins_dimp  [db_map ins_dimp]
    set dml_ins_docu  [db_map ins_docu]
    set dml_upd_gage  [db_map upd_gage]
    set dml_ins_gend  [db_map ins_gend]
    set dml_upd_inco  [db_map upd_inco]
    set dml_upd_inco2 [db_map upd_inco2]
    set dml_ins_inco  [db_map ins_inco]
    set dml_ins_movi  [db_map ins_movi]
    set dml_ins_prvv  [db_map ins_prvv]
    set dml_ins_rife  [db_map ins_rife]
    set dml_ins_stub  [db_map ins_stub]
    set dml_ins_todo  [db_map ins_todo] 

    set dml_upd_aimp  [db_map upd_aimp] 
    set dml_ins_aimp  [db_map ins_aimp] 
    set dml_ins_anom  [db_map ins_anom]

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

   	db_transaction {
	    if {[info exists dml_comu]} {
		db_dml dml_coimcomu $dml_comu
	    }

	    if {$stato_aimp_destinazione != "A"} {
		
		if {$flag_codifica_reg == "T"} {
                    #gab02 aggiunto alle condizioni la provincia di Ancona
                    #gab01 aggiunto alle condizioni il comune di Ancona
		    if {$coimtgen(ente) eq "CPESARO" || $coimtgen(ente) eq "PPU" || $coimtgen(ente) eq "CFANO" || $coimtgen(ente) eq "CANCONA" || $coimtgen(ente) eq "PAN" || $coimtgen(ente) eq "CJESI" || $coimtgen(ente) eq "CSENIGALLIA"} {#sim01: aggiunta if ed il suo contenuto
			if {$coimtgen(ente) eq "CPESARO"} {
			    set sigla_est "CMPS"
			} elseif {$coimtgen(ente) eq "CFANO"} {
			    set sigla_est "CMFA"
			}  elseif {$coimtgen(ente) eq "CANCONA"} {;#gab01
                            set sigla_est "CMAN"
                        } elseif {$coimtgen(ente) eq "PAN"} {;#gab02
                            set sigla_est "PRAN"
			} elseif {$coimtgen(ente) eq "CJESI"} {;#sim03
                            set sigla_est "CMJE"
                        } elseif {$coimtgen(ente) eq "CSENIGALLIA"} {;#sim03
                            set sigla_est "CMSE"
                        } else {
			    set sigla_est "PRPU"
			}
			
			set progressivo_est [db_string sel "select nextval('coimaimp_est_s')"]
			
			# devo fare l'lpad con una seconda query altrimenti mi va in errore
			#nic01 set progressivo_est [db_string sel "select lpad(:progressivo_est,6,'0')"]
			set progressivo_est [db_string sel "select lpad(:progressivo_est,:lun_num_cod_imp_est,'0')"];#nic01
			
			set cod_impianto_est_new "$sigla_est$progressivo_est"

		    } else {#sim01
			# caso standard

			db_1row sel_dati_codifica ""

			if {$coimtgen(ente) eq "PMS"} {#sim02: Riportato modifiche fatte per Massa in data 03/12/2015 per gli altri programmi dove e' presente la codifica dell'impianto 
			    set progressivo [db_string query "select lpad(:progressivo, 5, '0')"]
			    set cod_istat  "[string range $cod_istat 5 6]/"
			} elseif {$coimtgen(ente) eq "PTA"} {#sim02: aggiunta if e suo contenuto
			    set progressivo [db_string query "select lpad(:progressivo, 7, '0')"]
			    set fine_istat  [string length $cod_istat]
			    set iniz_ist    [expr $fine_istat -3]
			    set cod_istat  "[string range $cod_istat $iniz_ist $fine_istat]"
			} else {
			    #sim02: la sel_dati_comu andava in errore sul lpad di progressivo.Quindi faccio lpad dopo la query
			    set progressivo [db_string query "select lpad(:progressivo, 7, '0')"];#sim02
			}

			if {![string equal $potenza "0.00"]} {
			    if {$potenza < 35} {
				set tipologia "IN"
			    } else {
				set tipologia "CT"
			    }
			    #sim02 set cod_impianto_est_new "$cod_istat$tipologia$progressivo"
			    set cod_impianto_est_new "$cod_istat$progressivo";#sim02
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
				
				#sim02 set cod_impianto_est_new "$cod_istat$tipologia$progressivo"
				set cod_impianto_est_new "$cod_istat$progressivo";#sim02
				set dml_comu [db_map upd_prog_comu]
			    } else {
				set cod_impianto_est_new ""
			    }
			}
		    };#sim01
		} else {
		    db_1row get_cod_impianto_est ""
		}

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
	    if {$stato_aimp_destinazione == "A"} {
		if {[db_0or1row sel_inco_check ""] == 1} {
		    db_dml dml_inco2 $dml_upd_inco2
		}
	    }

	    db_1row sel_dual_cod_inco ""
	    db_dml dml_ins_inco $dml_ins_inco


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

	}
    } {
	iter_return_complaint "Spiacente, ma il DBMS ha restituito il
        seguente messaggio di errore <br><b>$error_msg</b><br>
        Contattare amministratore di sistema e comunicare il messaggio
        d'errore. Grazie."
    }
    set cod_impianto_old $cod_impianto
    set cod_impianto $cod_impianto_new
    set link_cod [export_url_vars cod_impianto cod_impianto_old]
    set link_gest [export_ns_set_vars url "nome_funz cod_impianto cod_inco"]
    #    if {$flag_cod_inco_new == "t"} {
    set cod_inco $cod_inco_new
    #    }
    set return_url "coimcimp-gest?funzione=I&$link_gest&nome_funz=cimp&flag_bonifica=T&flag_inco=S&$link_cod&[export_url_vars cod_inco]"    

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
