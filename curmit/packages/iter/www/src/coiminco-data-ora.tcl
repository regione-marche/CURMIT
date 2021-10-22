ad_page_contract {
    Lista tabella "coiminco"

    @author                  Mortoni Nicola/Formizzi Paolo Adhoc
    @creation-date           19/08/2004

    @param search_word       parola da ricercare con una query
    @param rows_per_page     una delle dimensioni della tabella  
    @param caller            se diverso da index rappresenta il nome del form 
                             da cui e' partita la ricerca ed in questo caso
                             imposta solo azione "sel"
    @param nome_funz         identifica l'entrata di menu,
                             serve per le autorizzazioni
    @param nome_funz_caller  identifica l'entrata di menu,
                             serve per la navigation bar
    @param receiving_element nomi dei campi di form che riceveranno gli
                             argomenti restituiti dallo script di zoom,
                             separati da '|' ed impostarli come segue:

    @cvs-id coiminco-list.tcl 
} {
    {cod_inco ""}
    {cod_cinc ""}
    {funzione "U"}
    {nome_funz "incontro"}
    {nome_funz_caller ""}
    {caller     "index"}
    {dt_inizio_cinc ""}
    {dt_fine_cinc ""}
}  -properties {
    page_title:onevalue
    context_bar:onevalue
    list_head:onevalue
    form_name:onevalue
}

# Controlla lo user
if {![string is space $nome_funz]} {
    set lvl        1
    set id_utente [lindex [iter_check_login $lvl $nome_funz] 1]
} else {
  # se la lista viene chiamata da un cerca, allora nome_funz non viene passato
  # e bisogna reperire id_utente dai cookie
    #set id_utente [ad_get_cookie iter_login_[ns_conn location]]
    set id_utente [iter_get_id_utente]
    if {$id_utente  == ""} {
	set login [ad_conn package_url]
	iter_return_complaint "Per accedere a questo programma devi prima eseguire la procedura di <a href=$login>Login.</a>"
	return 0
    }
}

set current_date [iter_set_sysdate]

iter_get_coimtgen
set flag_viario $coimtgen(flag_viario)
set flag_ente   $coimtgen(flag_ente)
set sigla_prov  $coimtgen(sigla_prov)


# controllo il parametro di "propagazione" per la navigation bar
if {[string equal $nome_funz_caller ""]} {
    set nome_funz_caller $nome_funz
}

# Personalizzo la pagina

switch $nome_funz {
    "inco-asse" {set evento "assegnazione"
                 set funz "A"}
    "inco-stam" {set evento "stampa avviso"
                 set funz "V"}
    "inco-conf" {set evento "conferma"
                 set funz "C"}
    "inco-effe" {set evento "effettuazione"
                 set funz "E"}
    "inco-annu" {set evento "annullamento"
                 set funz "N"}
    "inco-cimp" {set evento "registr. rapp. di verifica"
                 set funz "V"}
    default     {set evento "gestione"
                 set funz "V"}
}

set page_title "Modifica data e ora per $evento"
if {$caller == "index"} {
    set context_bar [iter_context_bar -nome_funz $nome_funz_caller]
} else {
    set context_bar [iter_context_bar \
                    [list "javascript:window.close()" "Torna alla Gestione"] \
                    "$page_title"]
}


# Creazione della form di modifica
set form_name     "coiminco"
set onsubmit_cmd ""
set button_label "Salva"
form create $form_name \
-html    $onsubmit_cmd

element create $form_name data_verifica \
-label   "Data appuntamento" \
-widget   text \
-datatype text \
-html    "size 10 maxlength 10 {} {} class form_element" \
-optional

element create $form_name ora_verifica \
-label   "Ora appuntamento" \
-widget   text \
-datatype text \
-html    "size 05 maxlength 05  {} {} class form_element" \
-optional

#set html_clausoles  "onClick='document.Form.submit()'onSubmit='self.close()' class form_submit"

element create $form_name funzione         -widget hidden -datatype text -optional
element create $form_name caller           -widget hidden -datatype text -optional
element create $form_name nome_funz        -widget hidden -datatype text -optional
element create $form_name nome_funz_caller -widget hidden -datatype text -optional
element create $form_name cod_inco         -widget hidden -datatype text -optional
element create $form_name dt_inizio_cinc   -widget hidden -datatype text -optional
element create $form_name dt_fine_cinc     -widget hidden -datatype text -optional
element create $form_name cod_comune       -widget hidden -datatype text -optional
element create $form_name submit           -widget submit -datatype text -label "$button_label" -html "class form_submit onClick document.Form.submit()"
if {[form is_request $form_name]} {
    element set_properties $form_name funzione      -value $funzione
    element set_properties $form_name caller        -value $caller
    element set_properties $form_name nome_funz     -value $nome_funz
    element set_properties $form_name nome_funz_caller -value $nome_funz_caller


    # leggo riga
    if {[db_0or1row sel_inco ""] == 0} {
	iter_return_complaint "Appuntamento non trovato"
    } else {
	element set_properties $form_name cod_inco -value $cod_inco
	element set_properties $form_name data_verifica -value $data_verifica
	element set_properties $form_name ora_verifica -value $ora_verifica
	# Selezione della campagna di appartenenza
	db_0or1row sel_cinc ""
	element set_properties $form_name dt_inizio_cinc -value $dt_inizio_cinc
	element set_properties $form_name dt_fine_cinc -value $dt_fine_cinc
	element set_properties $form_name cod_comune   -value $cod_comune
    }

}
if {[form is_valid $form_name]} {

  # form valido dal punto di vista del templating system
    set cod_inco          [element::get_value $form_name cod_inco]
    set data_verifica     [element::get_value $form_name data_verifica]
    set ora_verifica      [element::get_value $form_name ora_verifica]
    set dt_inizio_cinc    [element::get_value $form_name dt_inizio_cinc]
    set dt_fine_cinc      [element::get_value $form_name dt_fine_cinc]


    # Controlli su data e ora
    set error_num 0
    if {$data_verifica eq ""} {
	if {$ora_verifica ne ""} {
	    element::set_error $form_name data_verifica "Inserire la data"
	    incr error_num
	}
    } else {
	set data_verifica [iter_check_date $data_verifica]
	if {$data_verifica == 0} {
	    element::set_error $form_name data_verifica "Data non corretta"
	    incr error_num
	} else {
	    if {$data_verifica < $dt_inizio_cinc
		||  $data_verifica > $dt_fine_cinc
	    } {
		element::set_error $form_name data_verifica "Data non compresa nella campagna"
		incr error_num
	    }
	}
    }
    if {![string equal $ora_verifica ""]} {
	set ora_verifica [iter_check_time $ora_verifica]
	if {$ora_verifica == 0} {
	    element::set_error $form_name ora_verifica "Ora non corretta, deve essere hh:mm"
	    incr error_num
	}
    }
    if {$error_num > 0} {
        ad_return_template
        return
    }

    set dml_sql [db_map upd_inco]
  # Lancio la query di manipolazione dati contenuta in dml_sql
    if {[info exists dml_sql]} {
        with_catch error_msg {
            db_transaction {
                db_dml dml_coiminco $dml_sql

		# eseguo prima la creazione della disponibilità rispetto
                # all'eliminazione perche' potrei essere in riassegnazione
                # con lo stesso verificatore/data/ora di conseguenza la  
                # disponibilita' sarebbe gia' assente.
		if {[info exists dml_del_disp]} {
		    db_dml dml_inco_del_disp $dml_del_disp
		}
            }
        } {
            iter_return_complaint "Spiacente, ma il DBMS ha restituito il
            seguente messaggio di errore <br><b>$error_msg</b><br>
            Contattare amministratore di sistema e comunicare il messaggio
            d'errore. Grazie."
 	}
    }


}
ad_return_template 
