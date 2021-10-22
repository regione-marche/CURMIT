ad_page_contract {
    Add/Edit/Delete  form per la tabella "coimbatc"
    @author          Adhoc
    @creation-date   11/08/2004

    @param funzione  M=edit D=delete V=view
    @param caller    caller della lista da restituire alla lista:
                     serve se lista e' uno zoom che permetti aggiungi.
    @param nome_funz identifica l'entrata di menu, server per le autorizzazioni
                     serve se lista e' uno zoom che permetti aggiungi.
    @param nome_funz_caller identifica l'entrata di menu, serve per la 
                     navigazione con navigation bar
    @param extra_par Variabili extra da restituire alla lista
    @cvs-id          coimbatc-gest.tcl
} {
    
   {cod_batc  ""}
   {last_key  ""}
   {funzione  "V"}
   {caller    "index"}
   {nome_funz ""}
   {nome_funz_caller ""}
   {extra_par ""}
} -properties {
    page_title:onevalue
    context_bar:onevalue
    form_name:onevalue
}

# Controlla lo user
switch $funzione {
    "V" {set lvl 1}
    "M" {set lvl 3}
    "D" {set lvl 4}
}
set id_utente [lindex [iter_check_login $lvl $nome_funz] 1]
set link_gest [export_url_vars cod_batc last_key nome_funz nome_funz_caller extra_par caller]
# imposta le class css della barra delle funzioni
iter_set_func_class $funzione

# controllo il parametro di "propagazione" per la navigation bar
if {[string is space $nome_funz_caller]} {
    set nome_funz_caller $nome_funz
}

# Personalizzo la pagina
set link_list_script {[export_url_vars last_key caller nome_funz_caller nome_funz]&[iter_set_url_vars $extra_par]}
set link_list        [subst $link_list_script]
set titolo           "Lavoro"
switch $funzione {
    M {set button_label "Conferma Modifica" 
       set page_title   "Modifica data/ora partenza"}
    D {set button_label "Conferma Cancellazione"
       set page_title   "Cancellazione $titolo"}
    V {set button_label "Torna alla lista"
       set page_title   "Visualizzazione $titolo"}
}

#if {$caller == "index"} {
    set context_bar  [iter_context_bar -nome_funz $nome_funz_caller]
#} else {
#    set context_bar  [iter_context_bar \
#                     [list "javascript:window.close()" "Torna alla Gestione"] \
#                     [list coimbatc-list?$link_list "Lista Lavori"] \
#                     "$page_title"]
#}

# sproteggo la chiave solo in inserimento e gli attributi in inserimento e mod.
set form_name    "coimbatc"
set readonly_key "readonly"
set readonly_fld "readonly"
set disabled_fld "disabled"
set onsubmit_cmd ""
switch $funzione {
   "M" {set readonly_fld \{\}
        set disabled_fld \{\}
       }
}

form create $form_name \
-html    $onsubmit_cmd

element create $form_name cod_batc \
-label   "Codice" \
-widget   text \
-datatype text \
-html    "size 10 maxlength 10 $readonly_key {} class form_element" \
-optional

element create $form_name nom \
-label   "Lavoro" \
-widget   text \
-datatype text \
-html    "size 30 maxlength 30 $readonly_key {} class form_element" \
-optional

element create $form_name flg_stat \
-label   "Stato" \
-widget   text \
-datatype text \
-html    "size 13 maxlength 13 $readonly_key {} class form_element" \
-optional

element create $form_name dat_prev \
-label   "Data partenza" \
-widget   text \
-datatype text \
-html    "size 10 maxlength 10 $readonly_fld {} class form_element" \
-optional

element create $form_name ora_prev \
-label   "Ora partenza" \
-widget   text \
-datatype text \
-html    "size 5 maxlength 5 $readonly_fld {} class form_element" \
-optional

element create $form_name cod_uten_sch \
-label   "Utente" \
-widget   text \
-datatype text \
-html    "size 10 maxlength 10 $readonly_key {} class form_element" \
-optional

element create $form_name funzione     -widget hidden -datatype text -optional
element create $form_name caller       -widget hidden -datatype text -optional
element create $form_name nome_funz    -widget hidden -datatype text -optional
element create $form_name nome_funz_caller -widget hidden -datatype text -optional
element create $form_name extra_par    -widget hidden -datatype text -optional
element create $form_name submit       -widget submit -datatype text -label "$button_label" -html "class form_submit"
element create $form_name last_key     -widget hidden -datatype text -optional
element create $form_name current_date -widget hidden -datatype text -optional
element create $form_name current_time -widget hidden -datatype text -optional

if {[form is_request $form_name]} {

    element set_properties $form_name funzione         -value $funzione
    element set_properties $form_name caller           -value $caller
    element set_properties $form_name nome_funz        -value $nome_funz
    element set_properties $form_name nome_funz_caller -value $nome_funz_caller
    element set_properties $form_name extra_par        -value $extra_par
    element set_properties $form_name last_key         -value $last_key

    set current_date [iter_set_sysdate]
    set current_time [iter_set_systime]
    element set_properties $form_name current_date -value $current_date
    element set_properties $form_name current_time -value $current_time

    # leggo riga
    if {[db_0or1row sel_batc {}] == 0} {
	iter_return_complaint "Record non trovato"
    }

    element set_properties $form_name cod_batc     -value $cod_batc
    element set_properties $form_name nom          -value $nom
    element set_properties $form_name dat_prev     -value $dat_prev
    element set_properties $form_name ora_prev     -value $ora_prev
    element set_properties $form_name cod_uten_sch -value $cod_uten_sch

    if {$flg_stat != "A"} {
	element::set_error $form_name dat_prev "Il lavoro, nel frattempo, &egrave; partito: consultare la coda lavori o i lavori terminati."
	ad_return_template
	return
    }
}

if {[form is_valid $form_name]} {
  # form valido dal punto di vista del templating system

    set cod_batc     [element::get_value $form_name cod_batc]
    set nom          [element::get_value $form_name nom]
    set flg_stat     [element::get_value $form_name flg_stat]
    set dat_prev     [element::get_value $form_name dat_prev]
    set ora_prev     [element::get_value $form_name ora_prev]
    set cod_uten_sch [element::get_value $form_name cod_uten_sch]
    set current_date [element::get_value $form_name current_date]
    set current_time [element::get_value $form_name current_time]

  # controlli standard su numeri e date, per Ins ed Upd
    set error_num 0
    if {[db_0or1row sel_batc_stat ""] == 1
    &&  $flg_stat != "A"
    } {
	element::set_error $form_name dat_prev "Il lavoro, nel frattempo, &egrave; partito: consultare la coda lavori o i lavori terminati."
	ad_return_template
	return
    }

    if {$funzione == "M"} {
	set data_prev_ok "f"
	if {[string equal $dat_prev ""]} {
	    element::set_error $form_name dat_prev "Inserire data partenza"
	    incr error_num
	} else {
	    set dat_prev [iter_check_date $dat_prev]
	    if {$dat_prev == 0} {
		element::set_error $form_name dat_prev "Data partenza non corretta"
		incr error_num
	    } else {
		if {$dat_prev < $current_date} {
		    element::set_error $form_name dat_prev "Data partenza deve essere presente o futura"
		    incr error_num
		} else {
		    set data_prev_ok "t"
		}
	    }
	}

	if {[string equal $ora_prev ""]} {
	    element::set_error $form_name ora_prev "Inserire ora partenza"
	    incr error_num
	} else {
	    set ora_prev [iter_check_time $ora_prev]
	    if {$ora_prev == 0} {
		element::set_error $form_name ora_prev "Ora partenza non corretta"
		incr error_num
	    } else {
		if {$data_prev_ok == "t"
		&&  $dat_prev == $current_date
		&&  $ora_prev  < $current_time
		} {
		    element::set_error $form_name ora_prev "Ora partenza deve essere presente o futura"
		    incr error_num
		} else {
		    set ora_prev "$ora_prev:00"
		}
	    }
	}
    }

    if {$error_num > 0} {
        ad_return_template
        return
    }

    switch $funzione {
        M {set dml_sql [db_map upd_batc]}
        D {set dml_sql [db_map del_batc]}
    }

  # Lancio la query di manipolazione dati contenute in dml_sql
    if {[info exists dml_sql]} {
        with_catch error_msg {
            db_transaction {
                db_dml dml_coimbatc $dml_sql
            }
        } {
            iter_return_complaint "Spiacente, ma il DBMS ha restituito il
            seguente messaggio di errore <br><b>$error_msg</b><br>
            Contattare amministratore di sistema e comunicare il messaggio
            d'errore. Grazie."
 	}
    }

  # dopo l'inserimento posiziono la lista sul record inserito
    if {$funzione == "I"} {
        set last_key $cod_batc
    }
    set link_list      [subst $link_list_script]
    set link_gest      [export_url_vars cod_batc last_key nome_funz nome_funz_caller extra_par caller]
    switch $funzione {
        M {set return_url   "coimbatc-gest?funzione=V&$link_gest"}
        D {set return_url   "coimbatc-list?$link_list"}
        V {set return_url   "coimbatc-list?$link_list"}
    }

    ad_returnredirect $return_url
    ad_script_abort
}

ad_return_template
