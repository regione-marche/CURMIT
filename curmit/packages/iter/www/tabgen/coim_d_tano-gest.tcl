ad_page_contract {
    Add/Edit/Delete  form per la tabella "coim_d_tano"
    @author          Giulio Laurenzi
    @creation-date   10/11/2004

    @param funzione  I=insert M=edit D=delete V=view
    @param caller    caller della lista da restituire alla lista:
                     serve se lista e' uno zoom che permetti aggiungi.
    @param nome_funz identifica l'entrata di menu, server per le autorizzazioni
                     serve se lista e' uno zoom che permetti aggiungi.
    @param nome_funz_caller identifica l'entrata di menu, serve per la 
                     navigazione con navigation bar
    @param extra_par Variabili extra da restituire alla lista
    @cvs-id          coim_d_tano-gest.tcl
} {
    
   {cod_tano ""}
   {last_cod_tano ""}
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
# TODO: controllare il livello richiesto,
# Se il programma e' 'delicato', mettere livello 5 (amministratore).

switch $funzione {
    "V" {set lvl 1}
    "I" {set lvl 2}
    "M" {set lvl 3}
    "D" {set lvl 4}
}
set id_utente [lindex [iter_check_login $lvl $nome_funz] 1]
set link_gest [export_url_vars cod_tano last_cod_tano nome_funz nome_funz_caller extra_par caller]
# imposta le class css della barra delle funzioni
iter_set_func_class $funzione

# controllo il parametro di "propagazione" per la navigation bar
if {[string is space $nome_funz_caller]} {
    set nome_funz_caller $nome_funz
}


iter_get_coimtgen
set flag_ente        $coimtgen(flag_ente)
set sigla_prov       $coimtgen(sigla_prov)
set flag_enti_compet $coimtgen(flag_enti_compet)

# Personalizzo la pagina
# TODO: controllare impostazione della context_bar adattando come necessario
set link_list_script {[export_url_vars last_cod_tano caller nome_funz_caller nome_funz]&[iter_set_url_vars $extra_par]}
set link_list        [subst $link_list_script]
set titolo           "Tipo anomalia da dichiarazione"
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

set context_bar  [iter_context_bar -nome_funz $nome_funz_caller]

# sproteggo la chiave solo in inserimento e gli attributi in inserimento e mod.
set form_name    "coim_d_tano"
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

element create $form_name cod_tano \
-label   "cod_tano" \
-widget   text \
-datatype text \
-html    "size 8 maxlength 8 $readonly_key {} class form_element" \
-optional

element create $form_name descr_tano \
-label   "descr_tano" \
-widget   textarea \
-datatype text \
-html    "cols 50 rows 4 $readonly_fld {} class form_element" \
-optional

element create $form_name descr_breve \
-label   "descr_breve" \
-widget   text \
-datatype text \
-html    "size 80 maxlength 80 $readonly_fld {} class form_element" \
-optional

element create $form_name norma \
-label   "norma" \
-widget   text \
-datatype text \
-html    "size 60 maxlength 100 $readonly_fld {} class form_element" \
-optional

element create $form_name flag_stp_esito \
-label   "generazione esiti" \
-widget   select \
-datatype text \
-html    "$disabled_fld {} class form_element" \
-optional \
-options {{S&igrave; T} {No F}}

element create $form_name flag_report \
-label   "Conteggio nelle statistiche" \
-widget   select \
-datatype text \
-html    "$disabled_fld {} class form_element" \
-optional \
-options {{S&igrave; T} {No F}}

element create $form_name gg_adattamento \
-label   "descr_breve" \
-widget   text \
-datatype text \
-html    "size 3 maxlength 3 $readonly_fld {} class form_element" \
-optional


element create $form_name flag_scatenante \
-label   "flag_scatenante" \
-widget   select \
-datatype text \
-html    "$disabled_fld {} class form_element" \
-optional \
-options {{No F} {S&igrave; T}}

element create $form_name flag_modello \
-label   "flag_modello" \
-widget   select \
-datatype text \
-html    "$disabled_fld {} class form_element" \
-optional \
-options {{{} {}} {Dichiarazione S} {{Rapporto di verifica} R}}

element create $form_name data_fine_valid \
-label   "data" \
-widget   text \
-datatype text \
-html    "size 10 maxlength 10 $readonly_fld {} class form_element" \
-optional

element create $form_name clas_funz \
-label   "Classe" \
-widget   select \
-datatype text \
-html    "class form_element" \
-optional \
-options [iter_selbox_from_table coim_d_clas clas_funz descrizione]


element create $form_name funzione  -widget hidden -datatype text -optional
element create $form_name caller    -widget hidden -datatype text -optional
element create $form_name nome_funz -widget hidden -datatype text -optional
element create $form_name nome_funz_caller -widget hidden -datatype text -optional
element create $form_name extra_par -widget hidden -datatype text -optional
element create $form_name submit    -widget submit -datatype text -label "$button_label" -html "class form_submit"
element create $form_name last_cod_tano -widget hidden -datatype text -optional

if {[form is_request $form_name]} {

    element set_properties $form_name funzione         -value $funzione
    element set_properties $form_name caller           -value $caller
    element set_properties $form_name nome_funz        -value $nome_funz
    element set_properties $form_name nome_funz_caller -value $nome_funz_caller
    element set_properties $form_name extra_par        -value $extra_par
    element set_properties $form_name last_cod_tano    -value $last_cod_tano

    if {$funzione == "I"} {
      # TODO: settare eventuali default!!
        
    } else {
      # leggo riga
        if {[db_0or1row sel_d_tano {}] == 0} {
            iter_return_complaint "Record non trovato"
	}

        element set_properties $form_name cod_tano        -value $cod_tano
        element set_properties $form_name descr_tano      -value $descr_tano
        element set_properties $form_name descr_breve     -value $descr_breve
        element set_properties $form_name flag_scatenante -value $flag_scatenante
        element set_properties $form_name norma           -value $norma
        element set_properties $form_name flag_stp_esito  -value $flag_stp_esito  
        element set_properties $form_name gg_adattamento  -value $gg_adattamento
	element set_properties $form_name flag_report     -value $flag_report
	element set_properties $form_name flag_modello    -value $flag_modello
	element set_properties $form_name data_fine_valid -value $data_fine_valid
        element set_properties $form_name clas_funz       -value $clas_funz

    }
}

if {[form is_valid $form_name]} {
  # form valido dal punto di vista del templating system

    set cod_tano        [element::get_value $form_name cod_tano]
    set descr_tano      [element::get_value $form_name descr_tano]
    set descr_breve     [element::get_value $form_name descr_breve]
    set flag_scatenante [element::get_value $form_name flag_scatenante]
    set norma           [element::get_value $form_name norma]
    set flag_stp_esito  [element::get_value $form_name flag_stp_esito]
    set gg_adattamento  [element::get_value $form_name gg_adattamento]
    set flag_report     [element::get_value $form_name flag_report]
    set flag_modello    [element::get_value $form_name flag_modello]
    set data_fine_valid [element::get_value $form_name data_fine_valid]
    set clas_funz       [element::get_value $form_name clas_funz]

  # controlli standard su numeri e date, per Ins ed Upd
    set error_num 0
    if {$funzione == "I"
    ||  $funzione == "M"
    } {

        if {[string equal $cod_tano ""]} {
            element::set_error $form_name cod_tano "Inserire codice"
            incr error_num
	#} else {
	#    if {[string length $cod_tano] != 3
	#    &&  (    $flag_ente  != "P"
        #         &&  $sigla_prov != "LI")
	#    } {
	#	element::set_error $form_name cod_tano "Codice deve essere di 3 caratteri"
	#	incr error_num
	#    }
	}

        if {[string equal $descr_breve ""]} {
            element::set_error $form_name descr_breve "Inserire descrizione breve"
            incr error_num
        }

        if {[string equal $descr_tano ""]} {
            element::set_error $form_name descr_tano "Inserire descrizione"
            incr error_num
        }

        if {![string equal $gg_adattamento ""]} {
	    set gg_adeguamento [iter_check_num $gg_adattamento]
	    if {$gg_adattamento == "Error"} {
		element::set_error $form_name gg_adattamento "Inserire correttamente"
		incr error_num
	    } else {
		if {$gg_adattamento >= 1000} {
		    element::set_error $form_name gg_adattamento "Deve essere inferiore a 1000"
		    incr error_num		    
		}
	    }
        }

        if {![string equal $data_fine_valid ""]} {
            set data_fine_valid [iter_check_date $data_fine_valid]
            if {$data_fine_valid == 0} {
                element::set_error $form_name data_fine_valid "Data fine validit&agrave; deve essere una data"
                incr error_num
            }
        }

        if {[string equal $clas_funz ""]} {
            element::set_error $form_name clas_funz "Inserire la classe di funzionamento"
            incr error_num
        } else {
            if {[db_0or1row sel_d_clas {}] == 0} {
                # controllo esistenza classe di funzionamento
                element::set_error $form_name clas_funz "Classe di funzionamento inesistente sul data base"
                incr error_num
            }

        }

    }

    if {$funzione == "I"
    &&  $error_num == 0
    &&  [db_0or1row sel_d_tano_check {}] == 1
    } {
      # controllo univocita'/protezione da double_click
        element::set_error $form_name cod_tano "Il record che stai tentando di inserire &egrave; gi&agrave; esistente nel Data Base."
        incr error_num
    }
    db_1row sel_d_anom_count ""
    if {$funzione == "D"
    &&  $conta_anom > 0
    } {
	element::set_error $form_name cod_tano "Impossibile eliminare il record: sono presenti anomalie di questo tipo collegate "
        incr error_num
    }

    if {$error_num > 0} {
        ad_return_template
        return
    }

    switch $funzione {
        I {set dml_sql [db_map ins_d_tano]}
        M {set dml_sql [db_map upd_d_tano]}
        D {set dml_sql [db_map del_d_tano]}
    }

  # Lancio la query di manipolazione dati contenute in dml_sql
    if {[info exists dml_sql]} {
        with_catch error_msg {
            db_transaction {
                db_dml dml_coim_d_tano $dml_sql
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
        set last_cod_tano $cod_tano
    }
    set link_list      [subst $link_list_script]
    set link_gest      [export_url_vars cod_tano last_cod_tano nome_funz nome_funz_caller extra_par caller]
    switch $funzione {
        M {set return_url   "coim_d_tano-gest?funzione=V&$link_gest"}
        D {set return_url   "coim_d_tano-list?$link_list"}
        I {set return_url   "coim_d_tano-gest?funzione=V&$link_gest"}
        V {set return_url   "coim_d_tano-list?$link_list"}
    }

    ad_returnredirect $return_url
    ad_script_abort
}

ad_return_template
