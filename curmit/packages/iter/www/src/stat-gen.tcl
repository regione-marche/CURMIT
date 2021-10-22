ad_page_contract {

    @author        Daniele Zanotto
    @creation-date

    @cvs-id .tcl
} {
    {cod_batc_1        ""}
    {cod_batc_2        ""}
    {f_data1           ""}
    {f_data2           ""}
    {caller       "index"}
    {funzione         "I"}
    {nome_funz         ""}
    {nome_funz_caller  ""}
    {receiving_element ""}
} -properties {
    page_title:onevalue
    context_bar:onevalue
    form_name:onevalue
}

#Controlla lo user
if {![string is space $nome_funz]} {
    set lvl        1
    set id_utente [lindex [iter_check_login $lvl $nome_funz] 1]
} else {
    # se il filtro viene chiamato da un cerca, allora nome_funz non viene passato
    # e bisogna reperire id_utente dai cookie
    #set id_utente [ad_get_cookie iter_login_[ns_conn location]]
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
set nom  "Esportazione Statistiche"
set link_head [iter_links_batc $nome_funz $nome_funz_caller $nom]

# Personalizzo la pagina
set titolo       "Stampa statistiche"
switch $funzione {
    I {set button_label "Conferma lancio"
	set page_title   "Lancio $titolo "}
    V {set button_label "Torna al menu"
	set page_title   "$titolo lanciato"}
}

if {$caller == "index"} {
    set context_bar [iter_context_bar -nome_funz $nome_funz_caller]
}
#set context_bar [iter_context_bar \
    #                    [list "javascript:window.close()" "Torna alla Gestione"] \
    #                    "$page_title"]

# sproteggo la chiave solo in inserimento e gli attributi in inserimento e mod.
set form_name    "stat-gen"
set readonly_key "readonly"
set readonly_fld "readonly"
set disabled_fld "disabled"
set onsubmit_cmd ""

set readonly_fld \{\}
set disabled_fld \{\}
form create $form_name \
    -html    $onsubmit_cmd


element create $form_name f_data1 \
    -label   "data inizio" \
    -widget   text \
    -datatype text \
    -html    "size 10 maxlength 10 $readonly_fld {} class form_element" \
    -optional \

element create $form_name f_data2 \
    -label   "data fine" \
    -widget   text \
    -datatype text \
    -html    "size 10 maxlength 10 $readonly_fld {} class form_element" \
    -optional \

element create $form_name funzione    -widget hidden -datatype text -optional
element create $form_name caller      -widget hidden -datatype text -optional
element create $form_name nome_funz   -widget hidden -datatype text -optional
element create $form_name nome_funz_caller  -widget hidden -datatype text -optional
element create $form_name receiving_element -widget hidden -datatype text -optional
element create $form_name submit      -widget submit -datatype text -label "$button_label" -html "class form_submit"
element create $form_name dummy             -widget hidden -datatype text -optional

if {[form is_request $form_name]} {
    
    if {$funzione == "I"} {
	set current_date [iter_set_sysdate]
	set current_time [iter_set_systime]
	set dat_prev $current_date
	set ora_prev $current_time
	element set_properties $form_name f_data1        -value [iter_edit_date $f_data1]
	element set_properties $form_name f_data2        -value [iter_edit_date $f_data2]
	element set_properties $form_name funzione          -value $funzione
	element set_properties $form_name caller            -value $caller
	element set_properties $form_name nome_funz         -value $nome_funz
	element set_properties $form_name nome_funz_caller  -value $nome_funz_caller
	element set_properties $form_name receiving_element -value $receiving_element
    } else {
	# leggo riga
        if {[db_0or1row sel_batc_1 {}] == 0 && [db_0or1row sel_batc_2 {}] == 0} {
            iter_return_complaint "Record non trovato"
        }
    }
}

if {[form is_valid $form_name]} {
    # form valido dal punto di vista del templating system
    set f_data1_it	[string trim [element::get_value $form_name f_data1]]
    set f_data2_it  [string trim [element::get_value $form_name f_data2]]
    set f_data1		[string trim [element::get_value $form_name f_data1]]
    set f_data2		[string trim [element::get_value $form_name f_data2]]
    
    set error_num 0
    
    set flag_data1_ok "f"
    if {![string equal $f_data1 ""]} {
	set f_data1 [iter_check_date $f_data1]
	if {$f_data1 == 0} {
	    element::set_error $form_name f_data1 "Inserire correttamente la data"
	    incr error_num
	} else {
	    set flag_data1_ok "t"
	}
    } else {
	element::set_error $form_name f_data1 "Inserire la data"
	incr error_num	
    }
    
    set flag_data2_ok "f"
    if {![string equal $f_data2 ""]} {
	set f_data2 [iter_check_date $f_data2]
	if {$f_data2 == 0} {
	    element::set_error $form_name f_data2 "Inserire correttamente la data"
	    incr error_num
	} else {
	    set flag_data2_ok "t"
	}
    } else {
	element::set_error $form_name f_data2 "Inserire la data"
	incr error_num	
    }

    if {$flag_data1_ok
	&&  $flag_data2_ok
	&&  $f_data1 > $f_data2
    } {
	element::set_error $form_name f_data2 "La data iniziale dell'intervallo deve essere inferiore a quella finale"
	incr error_num
	
    }
    
    if {$error_num > 0} {
        ad_return_template
        return
    }
    
    if {$funzione == "I"} {
	#creazione batc per esportazione statistiche impianti
	set current_date [iter_set_sysdate]
	set current_time [iter_set_systime]
	set dat_prev $current_date
	set ora_prev $current_time
	db_1row sel_batc_next_1 ""
	set flg_stat     "A"
	set cod_uten_sch $id_utente
	set nom_prog_1     "iter-stat-gen-imp"
	set par          ""
	lappend par       f_data1_it
	lappend par      $f_data1_it
	lappend par       f_data2_it
	lappend par      $f_data2_it
	lappend par       f_data1
	lappend par      $f_data1
	lappend par       f_data2
	lappend par      $f_data2
	set note          ""
	set dml_sql_1     [db_map ins_batc_1]
	# Lancio la query di manipolazione dati contenute in dml_sql
	if {[info exists dml_sql_1]} {
	    with_catch error_msg {
		db_transaction {
		    db_dml dml_coimbatc $dml_sql_1
		}
	    } {
		iter_return_complaint "Spiacente, ma il DBMS ha restituito il
	            seguente messaggio di errore <br><b>$error_msg</b><br>
	            Contattare amministratore di sistema e comunicare il messaggio
	            d'errore. Grazie."
	    }
	}
	#creazione batc per esportazione statistiche dichiarazioni per utenti UPA,CLAAI,CNA,ASSO
	db_1row sel_batc_next_2 ""
	set nom_prog_2	"iter-stat-gen-dich"
	set dml_sql_2   [db_map ins_batc_2]
	if {[info exists dml_sql_2]} {
	    with_catch error_msg {
		db_transaction {
		    db_dml dml_coimbatc $dml_sql_2
		}
	    } {
		iter_return_complaint "Spiacente, ma il DBMS ha restituito il
		        seguente messaggio di errore <br><b>$error_msg</b><br>
		        Contattare amministratore di sistema e comunicare il messaggio
		        d'errore. Grazie."
	    }
	}
    }  

    set link_gest [export_url_vars cod_batc_1 cod_batc_2 nome_funz nome_funz_caller caller]
    switch $funzione {
        I {set return_url   "stat-gen?funzione=V&$link_gest"}
        V {set return_url   ""}
    }
    ad_returnredirect $return_url
    ad_script_abort
}

ad_return_template
