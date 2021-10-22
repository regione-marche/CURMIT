ad_page_contract {
    Add/Edit/Delete  form per la tabella "coimcaus"

    @author           Serena Saccani
    @creation-date    18.06.2012

    @cvs-id           coimcaus-gest.tcl
} {
    {id_caus          ""}
    {last_descrizione ""}
    {funzione        "V"}
    {caller      "index"}
    {nome_funz        ""}
    {extra_par        ""}
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

set id_utente [lindex [iter_check_login $lvl $nome_funz] 1]
set link_gest [export_url_vars id_caus last_descrizione nome_funz extra_par caller]

# imposta le class css della barra delle funzioni
iter_set_func_class $funzione

# Personalizzo la pagina
set link_list_script {[export_url_vars last_descrizione caller nome_funz]&[iter_set_url_vars $extra_par]}
set link_list        [subst $link_list_script]
set titolo           "Tipo pagamento"
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

if {$caller == "index"} {
    set context_bar  [iter_context_bar -nome_funz $nome_funz]
} else {
    set context_bar  [iter_context_bar \
			  [list "javascript:window.close()" "Torna alla Gestione"] \
			  [list coimcaus-list?$link_list "Lista Tipi pagamento"] \
			  "$page_title"]
}

# sproteggo la chiave solo in inserimento e gli attributi in inserimento e mod.
set form_name    "coimcaus"
set readonly_key "readonly"
set readonly_fld "readonly"
set disabled_fld "disabled"
set onsubmit_cmd ""
switch $funzione {
    "I" {set readonly_key \{\}
        set readonly_fld \{\}
        set disabled_fld \{\}
    }
    "M" {set readonly_fld \{\}
        set disabled_fld \{\}
    }
}

form create $form_name \
    -html    $onsubmit_cmd

if {$id_caus == "1" || $id_caus == "2" || $id_caus == "3" || $id_caus == "4" || $id_caus == "5" || $id_caus == "6"} {
    element create $form_name id_caus \
	-label   "Cod.interno" \
	-widget   text \
	-datatype text \
	-html    "size 8 maxlength 8 readonly {} class form_element" \
	-optional
    element create $form_name descrizione \
	-label   "Descrizione" \
	-widget   text \
	-datatype text \
	-html    "size 30 maxlength 30 readonly {} class form_element" \
	-optional
    element create $form_name codice \
	-label   "Codice" \
	-widget   text \
	-datatype text \
	-html    "size 2 maxlength 2 readonly {} class form_element" \
	-optional
} else {
    element create $form_name id_caus \
	-label   "Cod.interno" \
	-widget   text \
	-datatype text \
	-html    "size 8 maxlength 8 $readonly_key {} class form_element" \
	-optional
    element create $form_name descrizione \
	-label   "Descrizione" \
	-widget   text \
	-datatype text \
	-html    "size 30 maxlength 30 $readonly_fld {} class form_element" \
	-optional
    element create $form_name codice \
	-label   "Codice" \
	-widget   text \
	-datatype text \
	-html    "size 2 maxlength 2 $readonly_fld {} class form_element" \
	-optional
}

element create $form_name funzione         -widget hidden -datatype text -optional
element create $form_name caller           -widget hidden -datatype text -optional
element create $form_name nome_funz        -widget hidden -datatype text -optional
element create $form_name extra_par        -widget hidden -datatype text -optional
element create $form_name submit           -widget submit -datatype text -label "$button_label" -html "class form_submit"
element create $form_name last_descrizione -widget hidden -datatype text -optional

if {[form is_request $form_name]} {

    element set_properties $form_name funzione         -value $funzione
    element set_properties $form_name caller           -value $caller
    element set_properties $form_name nome_funz        -value $nome_funz
    element set_properties $form_name extra_par        -value $extra_par
    element set_properties $form_name last_descrizione -value $last_descrizione
    
    if {$funzione == "I"} {
	set id_caus [db_string query "select coalesce(max(id_caus), 0) + 1 from coimcaus"]
        element set_properties $form_name id_caus      -value $id_caus
    } else {
	# leggo riga
        if {[db_0or1row query "
             select descrizione
                  , codice
               from coimcaus
              where id_caus = :id_caus"] == 0} {
            iter_return_complaint "Record non trovato"
	}
        element set_properties $form_name id_caus     -value $id_caus
        element set_properties $form_name descrizione -value $descrizione
        element set_properties $form_name codice      -value $codice
    }
}

if {[form is_valid $form_name]} {
    # form valido dal punto di vista del templating system

    set id_caus      [element::get_value $form_name id_caus]
    set descrizione  [element::get_value $form_name descrizione]
    set codice       [element::get_value $form_name codice]

    # controlli standard su numeri e date, per Ins ed Upd
    set error_num 0
    if {$funzione eq "I" || $funzione eq "M"} {

	if {$funzione eq "I"} {
	    set where_cod ""
	} else {
	    set where_cod " and id_caus <> :id_caus"
	}

        if {$codice ne ""} {
	    if {[db_0or1row query "select count(*) as conta from coimcaus where codice = :codice $where_cod"] == 0} {
		set conta 0
	    }
	    if {$conta > 0} {
		element::set_error $form_name codice "Codice gi&agrave; presente"
		incr error_num
	    }
	}
	
        if {[string equal $descrizione ""]} {
            element::set_error $form_name descrizione "Inserire Descrizione"
            incr error_num
        }
    }

#    if {$funzione == "D" && [db_0or1row sel_dimp_check ""]} {
#        element::set_error $form_name codice "Il record che stai tentando di cancellare &egrave; collegato a degli impianti"
#        incr error_num
#    }

    if {$error_num > 0} {
        ad_return_template
        return
    }

    with_catch error_msg {
	db_transaction {
	    switch $funzione {
		I {
		    db_dml query "
                    insert into coimcaus
                         ( id_caus
                         , descrizione
                         , codice )
                    values 
                         (:id_caus
                         ,upper(:descrizione)
                         ,:codice )"
		}
		M {
		    db_dml query "
                    update coimcaus
                       set descrizione = upper(:descrizione)
                         , codice = :codice
                     where id_caus = :id_caus"
		}
		D {
		    db_dml query "
                     delete
                       from coimcaus
                      where id_caus = :id_caus"
		}
	    }
	}
    } {
	iter_return_complaint "Spiacente, ma il DBMS ha restituito il
            seguente messaggio di errore <br><b>$error_msg</b><br>
            Contattare amministratore di sistema e comunicare il messaggio
            d'errore. Grazie."
    }
    
    # dopo l'inserimento posiziono la lista sul record inserito
    if {$funzione eq "I"} {
        set last_descrizione $descrizione
    }
    set link_list [subst $link_list_script]
    set link_gest [export_url_vars id_caus last_descrizione nome_funz extra_par caller]
    switch $funzione {
        M {set return_url "coimcaus-gest?funzione=V&$link_gest"}
        D {set return_url "coimcaus-list?$link_list"}
        I {set return_url "coimcaus-gest?funzione=V&$link_gest"}
        V {set return_url "coimcaus-list?$link_list"}
    }

    ad_returnredirect $return_url
    ad_script_abort
}

ad_return_template
