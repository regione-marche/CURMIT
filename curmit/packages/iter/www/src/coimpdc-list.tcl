ad_page_contract {
    Lista tabella "coimaimp"

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

    @cvs-id coimcvie-list.tcl 
} { 
   {search_word          ""}
   {rows_per_page        ""}
   {caller               "index"}
   {nome_funz            ""}
   {nome_funz_caller     ""}
   {receiving_element    ""}
   {cod_impianto_est_new ""}
   {f_resp_cogn          ""} 
   {f_resp_nome          ""} 
   {f_comune             ""}
   {f_cod_via            ""}
   {f_desc_via           ""}
   {f_desc_topo          ""}
   {f_civico_da          ""}
   {f_civico_a           ""}
   {flag_tracciato       ""}
   {cod_as_resp          ""}
    destinazione:multiple,optional
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

iter_get_coimtgen
set flag_ente   $coimtgen(flag_ente)
set sigla_prov  $coimtgen(sigla_prov)
set flag_viario $coimtgen(flag_viario)

# controllo il parametro di "propagazione" per la navigation bar
if {[string is space $nome_funz_caller]} {
    set nome_funz_caller $nome_funz
}

switch $nome_funz_caller {
    tele {
	set page_title      "Inserimento allegato E4 - Bonifica impianti"
    }
    default {
	set page_title      "Inserimento allegati - Bonifica impianti"
    }
}
set context_bar [iter_context_bar -nome_funz $nome_funz_caller]
set mex_error ""

# preparo link per ritornare al filtro:
set link_filter [export_url_vars caller nome_funz receiving_element cod_impianto_est_new f_resp_cogn f_resp_nome f_comune f_cod_via f_desc_via f_desc_topo f_civico_da f_civico_a flag_tracciato cod_as_resp]

# imposto le variabili da usare nel frammento html di testata della lista.
set curr_prog       [file tail [ns_conn url]]
set form_di_ricerca [iter_search_form $curr_prog $search_word]
set col_di_ricerca  "Cognome resp."
set extra_par       [list rows_per_page     $rows_per_page \
                          receiving_element $receiving_element]
set link_righe      [iter_rows_per_page     $rows_per_page]

set link_isrt [export_ns_set_vars "url" "funzione nome_funz caller"]
set funzione "I"
set nome_funz "pdc"

set link_aggiungi "<a href=\"coimpdc-ins-gest?[export_url_vars funzione nome_funz f_comune f_resp_cogn f_resp_nome f_cod_via f_desc_via f_desc_topo]\">Aggiungi nuovo impianto"

if {$caller == "index"} {
    set link "\[export_url_vars last_cod_via nome_funz extra_par\]"
    set js_function ""
} else {
    set receiving_element [split $receiving_element |]
}

# sproteggo la chiave solo in inserimento e gli attributi in inserimento e mod.
set form_name    "coimpdc"
set readonly_key "readonly"
set readonly_fld "readonly"
set disabled_fld "disabled"
set onsubmit_cmd ""
set button_label "Continua"

form create $form_name \
-html    $onsubmit_cmd

element create $form_name nome_funz   -widget hidden -datatype text -optional
element create $form_name nome_funz_caller -widget hidden -datatype text -optional
element create $form_name search_word -widget hidden -datatype text -optional
#element create $form_name cod_comune  -widget hidden -datatype text -optional
element create $form_name caller      -widget hidden -datatype text -optional
element create $form_name extra_par   -widget hidden -datatype text -optional
element create $form_name submit      -widget submit -datatype text -label "$button_label" -html "class form_submit"
element create $form_name cod_impianto_est_new -widget hidden -datatype text -optional
element create $form_name f_resp_cogn  -widget hidden -datatype text -optional
element create $form_name f_resp_nome  -widget hidden -datatype text -optional
element create $form_name f_comune     -widget hidden -datatype text -optional
element create $form_name f_cod_via    -widget hidden -datatype text -optional
element create $form_name f_desc_via   -widget hidden -datatype text -optional
element create $form_name f_desc_topo  -widget hidden -datatype text -optional
element create $form_name flag_tracciato -widget hidden -datatype text -optional
element create $form_name cod_as_resp   -widget hidden -datatype text -optional
element create $form_name f_civico_da  -widget hidden -datatype text -optional
element create $form_name f_civico_a   -widget hidden -datatype text -optional

# creo i vari elementi per ogni riga ed una struttura multirow
# da utilizzare nell'adp
multirow create impianti link cod_impianto cod_impianto_est resp comune indir stato destinaz

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
	    default {set col_via "a.indirizzo" }
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

# imposto la query SQL
if {![string equal $search_word ""]} {
    set f_resp_nome ""
} else {
    if {![string equal $f_resp_cogn ""]} {
	set search_word $f_resp_cogn
    }
}

if {[string equal $search_word ""]} {
    set where_word ""
} else {
    set search_word_1 [iter_search_word $search_word]
    set where_word  " and b.cognome like upper(:search_word_1)"
}

if {[string equal $f_resp_nome ""]} {
    set where_nome ""
} else {
    set f_resp_nome_1 [iter_search_word $f_resp_nome]
    set where_nome  " and b.nome like upper(:f_resp_nome_1)"
}

if {![string equal $f_comune ""]
&&  [db_0or1row sel_comu ""] == 0} {
   iter_return_complaint "Comune non trovato"
}

# imposto la condizione SQL per il comune e la via
if {![string equal $f_comune ""]} {
    set where_comune "and a.cod_comune = :f_comune"
} else {
    set where_comune ""
}

set where_via ""
if {![string equal $f_cod_via ""]
&&  $flag_viario == "T"
} {
    set where_via "and a.cod_via = :f_cod_via"
} 

if {(![string equal $f_desc_via ""]
||   ![string equal $f_desc_topo ""])
&&  $flag_viario == "F"
} {
    set f_desc_via1  [iter_search_word $f_desc_via]
    set f_desc_topo1 [iter_search_word $f_desc_topo]
    set where_via "and a.indirizzo like upper(:f_desc_via1)
                   and a.toponimo  like upper(:f_desc_topo1)"
}

set col_numero  "to_number(a.numero,'99999999')"
# se richiesta selezione per civico
if {![string equal $f_civico_da ""]} {
    set where_civico_da "and $col_numero >= :f_civico_da"
} else {
    set where_civico_da ""
}
if {![string equal $f_civico_a ""]} {
    set where_civico_a "and $col_numero <= :f_civico_a"
} else {
    set where_civico_a ""
}

if {![string equal $cod_as_resp ""]} {
    if {$flag_viario == "T"} {
	set where_asresp " and a.cod_comune = (select cod_comune from coim_as_resp where cod_as_resp = :cod_as_resp)
                           and a.cod_via    = (select cod_via from coim_as_resp where cod_as_resp = :cod_as_resp)"
    } else {
	set where_asresp " and a.cod_comune = (select cod_comune from coim_as_resp where cod_as_resp = :cod_as_resp)
                           and a.indirizzo  = (select indirizzo from coim_as_resp where cod_as_resp = :cod_as_resp)
                           and a.toponimo   = (select toponimo from coim_as_resp where cod_as_resp = :cod_as_resp)"
    }
} else {
    set where_asresp ""
}

set cod_manutentore [iter_check_uten_manu $id_utente]
if {![string equal $cod_manutentore ""]} {
    append where_asresp "and (a.cod_manutentore = :cod_manutentore
                              or a.cod_installatore = :cod_manutentore)"
} else {
    if {[string range $id_utente 0 1] == "AM"} {
	set cod_amministratore $id_utente
	append where_asresp "and a.cod_amministratore = :cod_amministratore"
    } else {
	set cod_amministratore ""
    }
}
db_1row sel_cod_comb "select cod_combustibile from coimcomb where descr_comb = 'POMPA DI CALORE'"
if {$flag_viario == "T"} {
    set sql_query [db_map sel_aimp_vie]
} else {
    set sql_query [db_map sel_aimp_no_vie]
}

set cod_impianti_list [list]
db_foreach cmp $sql_query {
    
    element create $form_name compatta.$cod_impianto \
	-label   "Cod. impianto da compattare" \
	-widget   checkbox \
	-datatype text \
	-html    "class form_element" \
	-optional \
	-options [list [list Si $cod_impianto]]
    
    if {$n_generatori == 1} {
        set dati_gen "<br>Modello: $modello<br>Matricola: $matricola<br>Costruttore: $descr_cost"
    } else {
        set dati_gen ""
    }

    set destinaz "<input type=radio name=destinazione value=$cod_impianto>"
    set link "<a href=coimaimp-sche?nome_funz=impianti&cod_impianto=$cod_impianto&flag_no_links=T target=dett_$cod_impianto onmouseover=\"Tip ('Potenza utile: $potenza_utile<br>N. generatori: $n_generatori $dati_gen', FADEOUT, 300, FADEIN, 300, OPACITY, 80, SHADOW, true, TITLE, '<div style=white-space:nowrap;padding-right:1ex;>Dati impianto</div>')\">Dettaglio</a>"
    multirow append impianti $link $cod_impianto $cod_impianto_est $resp $comune $indir $stato $destinaz

    lappend cod_impianti_list $cod_impianto
}

element set_properties $form_name caller       -value $caller
element set_properties $form_name extra_par    -value $extra_par
element set_properties $form_name nome_funz    -value $nome_funz
element set_properties $form_name nome_funz_caller -value $nome_funz_caller
element set_properties $form_name search_word  -value $search_word
element set_properties $form_name cod_impianto_est_new -value $cod_impianto_est_new 
element set_properties $form_name f_resp_cogn   -value $f_resp_cogn
element set_properties $form_name f_resp_nome   -value $f_resp_nome
element set_properties $form_name f_comune      -value $f_comune 
element set_properties $form_name f_cod_via     -value $f_cod_via
element set_properties $form_name f_desc_via    -value $f_desc_via
element set_properties $form_name f_desc_topo   -value $f_desc_topo
element set_properties $form_name flag_tracciato -value $flag_tracciato
element set_properties $form_name cod_as_resp    -value $cod_as_resp

# creo testata della lista
set list_head [iter_list_head  $form_di_ricerca $col_di_ricerca $link_aggiungi "" "" ""]

if {[form is_request $form_name]} {

}

if {[form is_valid $form_name]} {
	
	#set cod_impianto_est_new $cod_impianto_est
	
    set flag_tracciato        [element::get_value $form_name flag_tracciato]
    set error_num 0
    set compatta_list ""
    if {![info exists destinazione]} {
	append mex_error "<font color=red><b>Inserire l'impianto di destinazione</b></font><br>"
	incr error_num
    } else {
	set flag_orig_dest "f"
	set flag_orig_da_def "f"
	set flag_orig_attiv "f"

	foreach cod_impianto $cod_impianti_list {
	    set compatta [element::get_value $form_name compatta.$cod_impianto]
	    
		if {![string equal $compatta ""]} {
		set codice_impianto $compatta
		if {[db_0or1row sel_aimp_stato ""] == 0} {
		    set stato_aimp ""
		}
		switch $stato_aimp {
		    "A" {set flag_orig_attiv "t" }
		    "D" {set flag_orig_da_def "t"}
		}
			
		if {$compatta == $destinazione} {
		    set flag_orig_dest "t"
		    if {$stato_aimp != "A"} {
			lappend compatta_list $compatta
				
		    }
		} else {
		    lappend compatta_list $compatta
		}

	    }
	}

	if {[string range $id_utente 0 1] == "AM"} {
	    set cod_amministratore $id_utente
	} else {
	    set cod_amministratore ""
	}
	set cod_manutentore [iter_check_uten_manu $id_utente]
	if {![string equal $cod_manutentore ""]
            || ![string equal $cod_amministratore ""]} {
	    if {![string equal $compatta_list ""]} {
		append mex_error "<font color=red><b>Utente non abilitato a bonifica (selezionare solo al destinazione)</b></font><br>"
		incr error_num	
	    }
	}

	set codice_impianto $destinazione
	if {[db_0or1row sel_aimp_stato ""] ==0} {
	    set stato_aimp ""
	}
	
	if {$flag_orig_dest == "f"} {
	    if {$stato_aimp != "A"} {
		lappend compatta_list $destinazione
	    }
	}
	
	if {$flag_orig_da_def == "t"
	    &&  $flag_orig_attiv == "t"
	    &&  $stato_aimp != "A"
	} {
	    append mex_error "<font color=red><b>In questo caso l'impianto di destinazione pu&ograve; essere solo un impianto con stato \"Attivo\"</b></font><br>"
	    incr error_num
	}
    }

    if {$error_num > 0} {
        ad_return_template
        return
    }

	
    set return_url   "coimpdc-gest?[export_url_vars flag_tracciato destinazione compatta_list nome_funz nome_funz_caller f_comune cod_impianto_est_new f_resp_cogn f_resp_nome f_cod_via f_desc_via f_desc_topo search_word]"

    ad_returnredirect $return_url
    ad_script_abort
}

db_release_unused_handles
ad_return_template 
