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

    @cvs-id coimcimp-ins-list.tcl 
} { 
   {search_word          ""}
   {rows_per_page        ""}
   {caller               "index"}
   {nome_funz            ""}
   {nome_funz_caller     ""}
   {receiving_element    ""}
   {cod_impianto         ""}
   {cod_inco             ""}
   {stato                ""}
   {esito                ""}
   {url_list_aimp        ""}
   {url_aimp             ""}
   {extra_par_inco       ""}
   {f_resp_cogn          ""} 
   {f_resp_nome          ""} 
   {f_comune             ""}
   {f_cod_via            ""}
   {f_desc_via           ""}
   {f_desc_topo          ""}
   {flag_cerca           "t"}
   {bottone              ""}
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

set cod_tecn   [iter_check_uten_opve $id_utente]

set page_title      "Inserimento rapp. di ispezione - Bonifica impianti"
set context_bar [iter_context_bar -nome_funz $nome_funz_caller]
set mex_error ""

set link_inco [iter_link_inco $cod_inco $nome_funz_caller $url_list_aimp $url_aimp "incontro" "" $extra_par_inco] 

set dett_tab [iter_tab_form $cod_impianto]

iter_get_coimtgen
set flag_viario  $coimtgen(flag_viario)

if {$flag_viario == "T"} {
    set cerca_viae [iter_search coimdimpins [ad_conn package_url]/tabgen/coimviae-filter [list dummy f_cod_via dummy f_desc_via dummy f_desc_topo cod_comune f_comune dummy dummy]]
} else {
    set cerca_viae ""
}

# stabilisco l'ordinamento ed uso una inner join al posto di una outer join
# sulle tabelle dove uso un filtro (Ottimizzazione solo per postgres)
set citt_join_pos "left outer join"
set citt_join_ora "(+)"


# acquisico i parametri per il filtro 
if {$flag_cerca == "t"} {
    set flag_cerca "f"

    if {[db_0or1row sel_aimp_dati ""] == 0} {
	set f_resp_cogn ""
	set f_resp_nome ""
	set f_comune    ""
	set f_cod_via   ""
	set f_desc_via  ""
	set f_desc_topo ""
    } else {
	# desc_via1 e desc_topo1 sono derivati dal viario
	# desc_via2 e desc_topo2 sono derivati dall'impianto
	if {[string equal $desc_via1 ""]
        &&  [string equal $desc_via2 ""]
	} {
	    set f_desc_via ""
	}
	if {[string equal $desc_topo1 ""]
	&&  [string equal $desc_topo2 ""]
	} {
	    set f_desc_topo ""
	}
	if {$flag_viario == "T"} {
	    set f_desc_via $desc_via1
	    set f_desc_topo $desc_topo1
	} else {
	    set f_desc_via $desc_via2
	    set f_desc_topo $desc_topo2
	}
    }
}

# preparo link per ritorna al filtro:
set link_filter [export_url_vars caller nome_funz receiving_element cod_impianto_est_new f_resp_cogn f_resp_nome f_comune f_cod_via f_desc_via f_desc_topo]

set col_di_ricerca  "Cognome resp."
set extra_par       [list rows_per_page     $rows_per_page \
                          receiving_element $receiving_element]
set link_righe      [iter_rows_per_page     $rows_per_page]

set link_isrt [export_ns_set_vars "url" "funzione nome_funz caller"]

set link_aggiungi ""

if {$caller == "index"} {
    set link "\[export_url_vars last_cod_via nome_funz extra_par\]"
    set js_function ""
} else {
    set receiving_element [split $receiving_element |]
}


# sproteggo la chiave solo in inserimento e gli attributi in inserimento e mod.
set form_name    "coimdimpins"
set readonly_key "readonly"
set readonly_fld "readonly"
set disabled_fld "disabled"
set onsubmit_cmd ""
set button_label "Continua"

form create $form_name \
-html    $onsubmit_cmd

element create $form_name f_resp_cogn \
-label   "Responsabile" \
-widget   text \
-datatype text \
-html    "size=20 maxlength=100 class form_element" \
-optional 

element create $form_name f_resp_nome \
-label   "Responsabile" \
-widget   text \
-datatype text \
-html    "size=14 maxlength=100 class form_element" \
-optional 

element create $form_name f_desc_via \
-label   "Responsabile" \
-widget   text \
-datatype text \
-html    "size=25 maxlength=40 class form_element" \
-optional 

element create $form_name f_desc_topo \
-label   "Responsabile" \
-widget   text \
-datatype text \
-html    "size=5 maxlength=10 class form_element" \
-optional 


element create $form_name nome_funz   -widget hidden -datatype text -optional
element create $form_name nome_funz_caller -widget hidden -datatype text -optional
element create $form_name search_word -widget hidden -datatype text -optional
element create $form_name flag_cerca  -widget hidden -datatype text -optional
element create $form_name dummy       -widget hidden -datatype text -optional
element create $form_name caller      -widget hidden -datatype text -optional
element create $form_name extra_par   -widget hidden -datatype text -optional
element create $form_name submit      -widget submit -datatype text -label "$button_label" -html "class form_submit"

element create $form_name f_comune     -widget hidden -datatype text -optional
element create $form_name f_cod_via    -widget hidden -datatype text -optional

element create $form_name receiving_element -widget hidden -datatype text -optional
element create $form_name cod_impianto -widget hidden -datatype text -optional
element create $form_name cod_inco     -widget hidden -datatype text -optional
element create $form_name stato        -widget hidden -datatype text -optional
element create $form_name esito        -widget hidden -datatype text -optional
element create $form_name url_list_aimp -widget hidden -datatype text -optional
element create $form_name url_aimp     -widget hidden -datatype text -optional
element create $form_name extra_par_inco -widget hidden -datatype text -optional

# creo i vari elementi per ogni riga ed una struttura multirow
# da utilizzare nell'adp
multirow create impianti link cod_impianto cod_impianto_est resp comune indir stato destinaz


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

if {![string equal $f_resp_cogn ""]} {
    set search_word $f_resp_cogn
}


if {[string equal $search_word ""]} {
    set where_word ""
} else {
    set where_word  " and b.cognome = upper(:search_word)"
}


if {[string equal $f_resp_nome ""]} {
    set where_nome ""
} else {
    set f_resp_nome_1 [iter_search_word $f_resp_nome]
    set where_nome  " and b.nome like upper(:f_resp_nome_1)"
}


# imposto la condizione SQL per il comune e la via
if {![string equal $f_comune ""]} {
    set where_comune "and a.cod_comune = :f_comune"
} else {
    set where_comune ""
}

if {$f_desc_via == ""
&&  $f_desc_topo == ""
} {
    set f_cod_via ""
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


    if {[string equal $cod_tecn ""]} {
	set nome_funz_det "impianti"  
    } else {
	set nome_funz_det "impianti-ver"  
    }

    set destinaz "<input type=radio name=destinazione value=$cod_impianto>"
    set link "<a href=coimaimp-sche?nome_funz=$nome_funz_det&cod_impianto=$cod_impianto&flag_no_links=T target=dett_$cod_impianto >Dettaglio</a>"
    multirow append impianti $link $cod_impianto $cod_impianto_est $resp $comune $indir $stato $destinaz

    lappend cod_impianti_list $cod_impianto
}

    element set_properties $form_name caller       -value $caller
    element set_properties $form_name extra_par    -value $extra_par
    element set_properties $form_name nome_funz    -value $nome_funz
    element set_properties $form_name nome_funz_caller -value $nome_funz_caller
    element set_properties $form_name search_word  -value $search_word

    element set_properties $form_name receiving_element -value $receiving_element
    element set_properties $form_name cod_impianto  -value $cod_impianto
    element set_properties $form_name cod_inco      -value $cod_inco   
    element set_properties $form_name esito         -value $esito
    element set_properties $form_name stato         -value $stato       
    element set_properties $form_name url_list_aimp -value $url_list_aimp
    element set_properties $form_name url_aimp      -value $url_aimp   
    element set_properties $form_name extra_par_inco -value $extra_par_inco
    element set_properties $form_name flag_cerca    -value $flag_cerca
# creo testata della lista
set list_head [iter_list_head  "" $col_di_ricerca $link_aggiungi "" "" ""]


if {[form is_request $form_name]} {
    element set_properties $form_name f_resp_cogn   -value $f_resp_cogn
    element set_properties $form_name f_resp_nome   -value $f_resp_nome
    element set_properties $form_name f_comune      -value $f_comune 
    element set_properties $form_name f_cod_via     -value $f_cod_via
    element set_properties $form_name f_desc_via    -value $f_desc_via
    element set_properties $form_name f_desc_topo   -value $f_desc_topo

}

if {[form is_valid $form_name]} {
    set f_comune    [element::get_value $form_name f_comune]
    set f_resp_cogn [element::get_value $form_name f_resp_cogn]
    set f_resp_nome [element::get_value $form_name f_resp_nome]
    set f_cod_via   [element::get_value $form_name f_cod_via]
    set f_desc_via  [element::get_value $form_name f_desc_via]
    set f_desc_topo [element::get_value $form_name f_desc_topo]
    set cod_impianto_partenza $cod_impianto


    if {![string equal $bottone ""]} {
    # si controlla la via solo se il primo test e' andato bene.
    # in questo modo si e' sicuri che f_comune e' stato valorizzato.
	set error_num 0
	if {$flag_viario      == "T" } {
	    if {[string equal $f_desc_via  ""]
	    &&  [string equal $f_desc_topo ""]
	    } {
		set f_cod_via ""
	    } else {
		# controllo codice via
		set chk_out_rc      0
		set chk_out_msg     ""
		set chk_out_cod_via ""
		set ctr_viae        0
		if {[string equal $f_desc_topo ""]} {
		    set eq_descr_topo  "is null"
		} else {
		    set eq_descr_topo  "= upper(:f_desc_topo)"
		}
		if {[string equal $f_desc_via ""]} {
		    set eq_descrizione "is null"
		} else {
		    set eq_descrizione "= upper(:f_desc_via)"
		}
		db_foreach sel_viae "" {
		    incr ctr_viae
		    if {$cod_via == $f_cod_via} {
			set chk_out_cod_via $cod_via
			set chk_out_rc       1
		    }
		}
		switch $ctr_viae {
		    0 { set chk_out_msg "Via non trovata"}
		    1 { set chk_out_cod_via $cod_via
			set chk_out_rc       1 }
		    default {
			if {$chk_out_rc == 0} {
			    set chk_out_msg "Trovate pi&ugrave; vie: usa il link cerca"
			    
			}
		    }
		}
		set f_cod_via $chk_out_cod_via
		if {$chk_out_rc == 0} {
		    element::set_error $form_name f_desc_via $chk_out_msg
		    incr error_num
		}
	    }
	} else {
	    set f_cod_via ""
	}
	
	if {$error_num > 0} {
	    ad_return_template
	    return
	}
	
	set return_url   "coimcimp-ins-list?[export_url_vars destinazione compatta_list nome_funz nome_funz_caller f_comune f_resp_cogn f_resp_nome f_cod_via f_desc_via f_desc_topo search_word cod_impianto cod_inco stato estio url_list_aimp url_aimp extra_par_inco]&flag_cerca=F"    
	ad_returnredirect $return_url
	ad_script_abort    
    }
    #######

    set error_num 0
    set compatta_list ""
    if {![info exists destinazione]} {
	append mex_error "<font color=red><b>Inserire l'impianto di destinazione</b></font><br>"
	incr error_num
    } else {

	set flag_orig_dest "f"
	set flag_orig_da_def "f"
	set flag_orig_attiv "f"
	set flag_presenza_impianto_partenza "0"

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
		if {$compatta == $cod_impianto_partenza} {
		    incr flag_presenza_impianto_partenza 
		}
	    }
	}

	if {$flag_presenza_impianto_partenza == 0} {
	    append mex_error "<font color=red><b>Selezionare come impianto di destinazione l'impianto su cui &egrave; presente l'incontro</b></font><br>"
	    incr error_num
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
	    append mex_error "<font color=red><b>In qeusto caso l'impianto di destinazione pu&ograve; essere solo un impianto con stato \"Attivo\"</b></font><br>"
	    incr error_num
	}
    }

    if {$error_num > 0} {
	ad_return_template
	return
    }
#    ns_return 200 text/html $compatta_list; return
    set return_url   "coimcimp-ins-gest?[export_url_vars destinazione compatta_list nome_funz nome_funz_caller f_comune f_resp_cogn f_resp_nome f_cod_via f_desc_via f_desc_topo search_word cod_impianto cod_inco stato estio url_list_aimp url_aimp extra_par_inco]"    
    ad_returnredirect $return_url
    ad_script_abort
}

db_release_unused_handles
ad_return_template 
