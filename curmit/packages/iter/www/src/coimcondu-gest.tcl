ad_page_contract {
    Add/Edit/Delete  form per la tabella "coimcondu"
    @author          Gacalin Lufi
    @creation-date   12/04/2018

    @param funzione  I=insert M=edit D=delete V=view

    @param caller    caller della lista da restituire alla lista:
    @                serve se lista e' uno zoom che permetti aggiungi.

    @param nome_funz identifica l'entrata di menu, server per le autorizzazioni
                     serve se lista e' uno zoom che permetti aggiungi.
    
    @param extra_par Variabili extra da restituire alla lista
    
    @cvs-id          coimcondu-gest.tcl
    
    USER  DATA       MODIFICHE
    ===== ========== =======================================================================
    
} { 
    {cod_conduttore   ""}
    {last_concat_key  ""}
    {funzione        "V"}
    {caller      "index"}
    {nome_funz        ""}
    {nome_funz_caller ""}
    {extra_par        ""}
    {url_condu        ""}
    {flag_java        ""}
    {flag_mod         ""}
    {cod_impianto     ""}
    
} -properties {
    page_title:onevalue
    context_bar:onevalue
    form_name:onevalue
}

# Controlla lo user
switch $funzione {
    "V" {set lvl 1}
    "I" {set lvl 2}
    "M" {set lvl 3}
    "D" {set lvl 4}
}

set current_date  [iter_set_sysdate]
iter_get_coimtgen
set flag_ente     $coimtgen(flag_ente)
set denom_comune  $coimtgen(denom_comune)
set link_cap      $coimtgen(link_cap)

if {![string is space $nome_funz]} {
    set id_utente [lindex [iter_check_login $lvl $nome_funz] 1]
} else {
    #set id_utente [ad_get_cookie iter_login_[ns_conn location]]
    set id_utente [iter_get_id_utente]
}

iter_set_func_class $funzione

# controllo il parametro di "propagazione" per la navigation bar
if {[string is space $nome_funz_caller]} {
    set nome_funz_caller $nome_funz
}

if {$funzione != "I"
    &&  [string equal $url_condu ""]
} {
    set url_condu [list [ad_conn url]?[export_ns_set_vars url ]]
}

set prime_2 [string range $cod_conduttore 0 1]

set link_gest [export_url_vars cod_conduttore cod_impianto flag_mod last_concat_key caller nome_funz extra_par url_condu]
set link_aimp "coimaimp-list?nome_funz=impianti&[export_url_vars nome_funz_caller cod_conduttore url_condu]"

# Personalizzo la pagina
set link_list_script {[export_url_vars last_concat_key caller nome_funz]&[iter_set_url_vars $extra_par]}
set link_list        [subst $link_list_script]
set titolo           "Conduttore"
switch $funzione {
    M {set button_label "Conferma Modifica" 
	set page_title   "Modifica $titolo"}
    D {set button_label "Conferma Cancellazione"
	set page_title   "Cancellazione $titolo"}
    I {set button_label "Conferma Inserimento"
	set page_title   "Inserimento $titolo"}
    V {set button_label "Torna alla lista"
	set page_title   "Visualizzazione $titolo"}
}

if {$flag_java != "t"} {
    if {$flag_mod == "t"} {
	set context_bar [iter_context_bar \
			     [list "javascript:window.close()" "Chiudi Finestra"] \
			     "$page_title"]
    } else {
	if {$caller == "index"} {
	    set context_bar  [iter_context_bar -nome_funz $nome_funz]
	} else {
	    set context_bar  [iter_context_bar \
				  [list "javascript:window.close()" "Torna alla Gestione"] \
				  [list coimcondu-list?$link_list "Lista Soggetti"] \
				  "$page_title"]
	}
    }
} else {
    set context_bar [iter_context_bar \
			 [list "javascript:window.close()" "Chiudi Finestra"] \
			 "$page_title"]
}

# sproteggo la chiave solo in inserimento e gli attributi in inserimento e mod.
set form_name    "coimcondu"
set readonly_key "readonly"
set readonly_fld "readonly"
set disabled_fld "disabled"
set readonly_man "readonly"
set disabled_man "disabled"
set onsubmit_cmd ""

switch $funzione {
    "I" {set readonly_key \{\}
        set readonly_fld \{\}
        set disabled_fld \{\}
	set readonly_man \{\}
	set disabled_man \{\}
    }
    "M" {
	set readonly_fld \{\}
	set disabled_fld \{\}
	set readonly_man \{\}
	set disabled_man \{\}
    }
}

form create $form_name \
    -html    $onsubmit_cmd

element create $form_name cognome \
    -label   "Cognome" \
    -widget   text \
    -datatype text \
    -html    "size 30 maxlength 100 $readonly_fld {} class form_element" \
    -optional

element create $form_name nome \
    -label   "Nome" \
    -widget   text \
    -datatype text \
    -html    "size 20 maxlength 100 $readonly_man {} class form_element" \
    -optional

element create $form_name cod_fiscale \
    -label   "Cod. Fiscale" \
    -widget   text \
    -datatype text \
    -html    "size 16 maxlength 16 $readonly_fld {} class form_element" \
    -optional

element create $form_name data_patentino \
    -label   "Data Patentino" \
    -widget   text \
    -datatype text \
    -html    "size 10 maxlength 10 $readonly_man {} class form_element" \
    -optional

element create $form_name ente_rilascio_patentino \
    -label   "Ente Rilascio Patentino" \
    -widget   text \
    -datatype text \
    -html    "size 50 maxlength 250 $readonly_man {} class form_element" \
    -optional

element create $form_name indirizzo \
    -label   "Indirizzo" \
    -widget   text \
    -datatype text \
    -html    "size 30 maxlength 40 $readonly_man {} class form_element" \
    -optional

element create $form_name cap \
    -label   "C.A.P." \
    -widget   text \
    -datatype text \
    -html    "size 5 maxlength 5 $readonly_man {} class form_element" \
    -optional

element create $form_name comune \
    -label   "Comune" \
    -widget   text \
    -datatype text \
    -html    "size 30 maxlength 40 $readonly_man {} class form_element" \
    -optional

if {$funzione == "I"
    ||  $funzione == "M"
} {
    set link_comune [iter_search  coimcondu [ad_conn package_url]/tabgen/coimcomu-list [list dummy_1 dummy search_word comune dummy_2 provincia dummy_3 cap]]
} else {
    set link_comune ""
}

element create $form_name provincia \
    -label   "Provincia" \
    -widget   text \
    -datatype text \
    -html    "size 4 maxlength 4 $readonly_man {} class form_element" \
    -optional

element create $form_name telefono \
    -label   "Telefono" \
    -widget   text \
    -datatype text \
    -html    "size 16 maxlength 15 $readonly_fld {} class form_element" \
    -optional

element create $form_name cellulare \
    -label   "Cellulare" \
    -widget   text \
    -datatype text \
    -html    "size 16 maxlength 15 $readonly_fld {} class form_element" \
    -optional

element create $form_name fax \
    -label   "Fax" \
    -widget   text \
    -datatype text \
    -html    "size 16 maxlength 15 $readonly_fld {} class form_element" \
    -optional

element create $form_name email \
    -label   "E-mail" \
    -widget   text \
    -datatype text \
    -html    "size 30 maxlength 35 $readonly_fld {} class form_element" \
    -optional

element create $form_name pec \
    -label   "Pec" \
    -widget   text \
    -datatype text \
    -html    "size 30 maxlength 35 $readonly_fld {} class form_element" \
    -optional


element create $form_name cod_conduttore    -widget hidden -datatype text -optional
element create $form_name flag_mod         -widget hidden -datatype text -optional
element create $form_name url_condu         -widget hidden -datatype text -optional
element create $form_name dummy            -widget hidden -datatype text -optional
element create $form_name funzione         -widget hidden -datatype text -optional
element create $form_name caller           -widget hidden -datatype text -optional
element create $form_name nome_funz        -widget hidden -datatype text -optional
element create $form_name extra_par        -widget hidden -datatype text -optional
element create $form_name last_concat_key  -widget hidden -datatype text -optional
element create $form_name cod_impianto     -widget hidden -datatype text -optional
element create $form_name cod_fiscale_orig -widget hidden -datatype text -optional
element create $form_name submit           -widget submit -datatype text -label "$button_label" -html "class form_submit"

element set_properties $form_name flag_mod            -value $flag_mod     

if {[form is_request $form_name]} {
    element set_properties $form_name url_condu       -value $url_condu
    element set_properties $form_name funzione        -value $funzione
    element set_properties $form_name caller          -value $caller
    element set_properties $form_name nome_funz       -value $nome_funz
    element set_properties $form_name extra_par       -value $extra_par
    element set_properties $form_name last_concat_key -value $last_concat_key
    element set_properties $form_name cod_impianto    -value $cod_impianto
    
    
    if {$funzione == "I"} {
        if {$flag_ente == "C"} {
	    element set_properties $form_name comune     -value $denom_comune
	}
    } else {
	# leggo riga
        if {[db_0or1row sel_condu ""] == 0} {
            iter_return_complaint "Record non trovato"
	}
	
        element set_properties $form_name cod_conduttore          -value $cod_conduttore
        element set_properties $form_name cognome                 -value $cognome
        element set_properties $form_name nome                    -value $nome
        element set_properties $form_name cod_fiscale             -value $cod_fiscale
        element set_properties $form_name cod_fiscale_orig        -value $cod_fiscale
        element set_properties $form_name data_patentino          -value $data_patentino
        element set_properties $form_name ente_rilascio_patentino -value $ente_rilascio_patentino
        element set_properties $form_name indirizzo               -value $indirizzo
      
        element set_properties $form_name cap                     -value $cap
        element set_properties $form_name comune                  -value $comune
        element set_properties $form_name provincia               -value $provincia
        element set_properties $form_name telefono                -value $telefono
        element set_properties $form_name cellulare               -value $cellulare
        element set_properties $form_name fax                     -value $fax
        element set_properties $form_name email                   -value $email
        element set_properties $form_name cod_impianto            -value $cod_impianto
        element set_properties $form_name pec                     -value $pec
    }
}

if {[form is_valid $form_name]} {
    # form valido dal punto di vista del templating system
    
    set cod_conduttore          [string trim [element::get_value $form_name cod_conduttore]]
    set cognome                 [string trim [element::get_value $form_name cognome]]
    set nome                    [string trim [element::get_value $form_name nome]]
    set cod_fiscale             [string trim [element::get_value $form_name cod_fiscale]]
    set cod_fiscale_orig        [string trim [element::get_value $form_name cod_fiscale_orig]]
    set data_patentino          [string trim [element::get_value $form_name data_patentino]]
    set ente_rilascio_patentino [string trim [element::get_value $form_name ente_rilascio_patentino]]
    set indirizzo               [string trim [element::get_value $form_name indirizzo]]
    
    set cap                     [string trim [element::get_value $form_name cap]]
    set comune                  [string trim [element::get_value $form_name comune]]
    set provincia               [string trim [element::get_value $form_name provincia]]
    set telefono                [string trim [element::get_value $form_name telefono]]
    set cellulare               [string trim [element::get_value $form_name cellulare]]
    set fax                     [string trim [element::get_value $form_name fax]]
    set email                   [string trim [element::get_value $form_name email]]
    set cod_impianto            [string trim [element::get_value $form_name cod_impianto]]
    set pec                     [string trim [element::get_value $form_name pec]]
    set flag_mod                [string trim [element::get_value $form_name flag_mod]]

  # controlli standard su numeri e date, per Ins ed Upd
    set error_num 0
    if {$funzione == "I"
    ||  $funzione == "M"
    } {
		
	if {[string equal $cognome ""]} {
	    element::set_error $form_name cognome "Inserire cognome"
	    incr error_num
	}
	if {[string equal $nome ""]} {
            element::set_error $form_name nome "Inserire nome"
            incr error_num
        }
	
	if {[string equal $cod_fiscale ""]} {
	    element::set_error $form_name cod_fiscale "Inserire Codice Fiscale"
            incr error_num
        }

	if {[string equal $cod_fiscale "XXXXXXXXXXXXXXXX"]} {
	    element::set_error $form_name cod_fiscale "Inserire codice fiscale corretto"
	    incr error_num
	}
	
	if {[string equal $cod_fiscale ""]} {
	    db_1row query "select id_ruolo from coimuten where id_utente =:id_utente" 
	    if {$id_ruolo != "admin"} {
		element::set_error $form_name cod_fiscale "Inserire codice fiscale o partita iva"
		incr error_num
	    }
	} else {
	    set lcf [string length $cod_fiscale]
	    if {$lcf != 16 && $lcf != 11} {
		element::set_error $form_name cod_fiscale "Lunghezza errata"
		incr error_num
	    } elseif {$lcf == 16 && [iter::verifyfc -xcodfis $cod_fiscale] == 0} {
		element::set_error $form_name cod_fiscale "Codice fiscale errato"
		incr error_num
	    } elseif {$lcf == 11 && [iter::verifyvc -xcodfis $cod_fiscale] == 0} {
		element::set_error $form_name cod_fiscale "Codice fiscale errato"
		incr error_num
	    }
	}
		
	if {[string equal $data_patentino ""]} {
	    element::set_error $form_name data_patentino "Inserire Data Patentino"
	    incr error_num
	}

	if {![string equal $data_patentino ""]} {
            set data_patentino [iter_check_date $data_patentino]
            if {$data_patentino == 0} {
                element::set_error $form_name data_patentino "Data Patentino deve essere una data"
                incr error_num
            }
        }

	if {[string equal $ente_rilascio_patentino ""]} {
            element::set_error $form_name ente_rilascio_patentino "Inserire Ente che ha rilasciato il patentino"
            incr error_num
        }
	
        if {[string equal $indirizzo ""]} {
	    element::set_error $form_name indirizzo "Inserire Indirizzo"
	    incr error_num
	}

        if {[string equal $comune ""]} {
	    element::set_error $form_name comune "Inserire comune"
	    incr error_num
	}

	if {[string equal $provincia ""]} {
            element::set_error $form_name provincia "Inserire provincia"
            incr error_num
        }

	if {[string equal $cap ""]
        &&  ![string is integer $cap]
	} {
            element::set_error $form_name cap "Inserire C.A.P"
            incr error_num
        }

	if {[string equal $telefono ""] && [string equal $cellulare ""] && [string equal $fax ""] && [string equal $email ""] && [string equal $pec  ""]} {
            element::set_error $form_name telefono "Inserire almeno un recapito"
	    element::set_error $form_name cellulare "Inserire almeno un recapito"
	    element::set_error $form_name fax "Inserire almeno un recapito"
	    element::set_error $form_name email "Inserire almeno un recapito"
            element::set_error $form_name pec "Inserire almeno un recapito"
	    incr error_num
	}


	if {$error_num       == 0
	&&  $cod_fiscale     ne ""
        && ($funzione eq "I" || ($funzione eq "M" && $cod_fiscale ne $cod_fiscale_orig))
	} {
	    if {$funzione eq "I"} {
		set and_cod_conduttore      ""
		set inserimento_o_modifica "l'inserimento"
	    } else {
		set and_cod_conduttore           "and cod_conduttore <> :cod_conduttore"
		set inserimento_o_modifica "la modifica"
	    }
	    
	    if {[db_0or1row query "
                select 1
                  from coimcondu
                 where cod_fiscale = upper(:cod_fiscale)
                  $and_cod_conduttore
                 limit 1"]
	    } {
		element::set_error $form_name cod_fiscale "
                Attenzione, esiste un altro soggetto con lo stesso codice fiscale. 
            <br>Confermi $inserimento_o_modifica?"

		incr error_num
	    }
	}
    }

    if {$funzione == "I"
	&&  $error_num == 0
	&&  [db_0or1row sel_condu_chk ""] == 1
    } {
	# controllo univocita'/protezione da double_click
        element::set_error $form_name cognome "Il record che stai tentando di inserire &egrave; gi&agrave; esistente nel Data Base."
        incr error_num
    }
    
    
    if {$error_num > 0} {
        ad_return_template
        return
    }

    switch $funzione {
        I { db_1row sel_cod ""
           set dml_sql [db_map ins_condu]
        }
        M { set dml_sql [db_map mod_condu] }
        D { set dml_sql [db_map del_condu] }
    }

    # Lancio la query di manipolazione dati contenute in dml_sql
    if {[info exists dml_sql]} {

        with_catch error_msg {
            db_transaction {

                db_dml dml_coimcondu $dml_sql
            }
        } {
            iter_return_complaint "Spiacente, ma il DBMS ha restituito il
            seguente messaggio di errore <br><b>$error_msg</b><br>
            Contattare amministratore di sistema e comunicare il messaggio
            d'errore. Grazie."
 	}
    }

    set link_list      [subst $link_list_script]
    set link_gest      [export_url_vars cod_conduttore flag_mod cod_impianto last_concat_key nome_funz caller extra_par url_condu]
    switch $funzione {
        M {set return_url   "coimcondu-list?funzione=V&$link_list"}
        D {set return_url   "coimcondu-list?$link_list"}
        I {set return_url   "coimcondu-gest?funzione=V&$link_gest"}
        V {set return_url   "coimcondu-list?$link_list"}
    }

    ad_returnredirect $return_url
    ad_script_abort
}

ad_return_template
