ad_page_contract {
    Add/Edit/Delete  form per la tabella "coimtari"
    @author          Giulio Laurenzi
    @creation-date   19/05/2004

    @param funzione  I=insert M=edit D=delete V=view

    @param caller    caller della lista da restituire alla lista:
    @                serve se lista e' uno zoom che permetti aggiungi.

    @param nome_funz identifica l'entrata di menu, server per le autorizzazioni
    @                serve se lista e' uno zoom che permetti aggiungi.

    @param nome_funz_caller identifica l'entrata di menu, serve per la 
    @                navigazione con navigation bar

    @param extra_par Variabili extra da restituire alla lista

    @cvs-id          coimtari-gest.tcl

    USER  DATA       MODIFICHE
    ===== ========== ==========================================================================
    rom01 12/02/2018 Aggiunto la tipologia costo "Dichiarazione cg"

    sim03 06/04/2017 Aggiunto la tipologia costo "Dichiarazioni te"

    sim02 27/06/2016 Aggiunte colonne flag_tariffa_impianti_vecchi, anni_fine_tariffa_base e
    sim02            tariffa_impianti_vecchi per gestire le tariffe della Regione Calabria

    sim01 20/05/2016 Aggiunto la tipologia costo "Dichiarazioni fr"

} {
    {cod_listino ""}
    {descrizione ""}
    {tipo_costo ""}
    {cod_potenza ""}
    {data_inizio ""}
    {last_tari ""}
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
    "I" {set lvl 2}
    "M" {set lvl 3}
    "D" {set lvl 4}
}
set id_utente [lindex [iter_check_login $lvl $nome_funz] 1]
set link_gest [export_url_vars tipo_costo cod_listino descrizione cod_potenza data_inizio last_tari nome_funz nome_funz_caller extra_par caller]
# imposta le class css della barra delle funzioni
iter_set_func_class $funzione

# controllo il parametro di "propagazione" per la navigation bar
if {[string is space $nome_funz_caller]} {
    set nome_funz_caller $nome_funz
}


# Personalizzo la pagina
# TODO: controllare impostazione della context_bar adattando come necessario
set link_list_script {[export_url_vars tipo_costo cod_listino descrizione cod_potenza last_tari caller nome_funz_caller nome_funz]&[iter_set_url_vars $extra_par]}
set link_list        [subst $link_list_script]
set titolo           "Tariffa"
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
set form_name    "coimtari"
set readonly_key "readonly"
set readonly_fld "readonly"
set disabled_fld "disabled"
set disabled_key "disabled"
set onsubmit_cmd ""
switch $funzione {
   "I" {set readonly_key \{\}
        set readonly_fld \{\}
        set disabled_fld \{\}
        set disabled_key \{\}
       }
   "M" {set readonly_fld \{\}
        set disabled_fld \{\}
       }
}

form create $form_name \
-html    $onsubmit_cmd

#sim01 aggiunto Dichiarazioni fr
#sim03 aggiunto Dichiarazione te
#rom01 aggiunto Dichiarazione cg
if {$funzione == "I"} {
    element create $form_name tipo_costo \
	-label   "Tipo costo" \
	-widget   select \
	-datatype text \
	-html    "$disabled_key {} class form_element" \
	-optional \
	-options { {{} {}} {Dichiarazione {1}} {Ispezione {2}} {{Verifica generatore aggiuntivo} 3} {{Sanzioni per inadempienze tecniche} 4} {{Mancata ispezione} 5} {{Tariffa ispettore} 6} {{Contributo Regionale} 7} {{Dichiarazione fr} 8} {{Dichiarazione te} 9} {{Dichiarazione cg} 10}}
    
    element create $form_name cod_potenza \
	-label   "Fascia potenza" \
	-widget   select \
	-datatype text \
	-html    "$disabled_key {} class form_element" \
	-optional \
	-options [iter_selbox_from_table_obblig coimpote cod_potenza descr_potenza cod_potenza]
} else {
    element create $form_name tipo_costo_dett \
	-label   "Tipo costo" \
	-widget   text \
	-datatype text \
	-html    "size 40 readonly {} class form_element" \
	-optional 

    element create $form_name tipo_costo -widget hidden -datatype text -optional

    element create $form_name cod_potenza_dett \
	-label   "Fascia potenza" \
	-widget   text \
	-datatype text \
	-html    "size 40 readonly {} class form_element" \
	-optional 

    element create $form_name cod_potenza -widget hidden -datatype text -optional
}

element create $form_name data_inizio \
    -label   "Data inizio validit&agrave;" \
    -widget   text \
    -datatype text \
    -html    "size 10 maxlength 10 $readonly_key {} class form_element" \
    -optional

element create $form_name importo \
    -label   "Importo" \
    -widget   text \
    -datatype text \
    -html    "size 12 maxlength 12 $readonly_fld {} class form_element" \
    -optional

element create $form_name flag_tariffa_impianti_vecchi \
    -label   "Si prevede una 2° tariffa per impianti vecchi?" \
    -widget   select \
    -datatype text \
    -html    "$readonly_fld {} class form_element" \
    -optional \
    -options {{"No" "f"} {"Si" "t"}}

element create $form_name anni_fine_tariffa_base \
    -label   "N° anni oltre i quali applicare 2° tariffa" \
    -widget   text \
    -datatype text \
    -html    "size 2 maxlength 2 $readonly_fld {} class form_element" \
    -optional

element create $form_name tariffa_impianti_vecchi \
    -label   "Importo tariffa per impianti vecchi" \
    -widget   text \
    -datatype text \
    -html    "size 12 maxlength 12 $readonly_fld {} class form_element" \
    -optional

element create $form_name funzione    -widget hidden -datatype text -optional
element create $form_name caller      -widget hidden -datatype text -optional
element create $form_name nome_funz   -widget hidden -datatype text -optional
element create $form_name extra_par   -widget hidden -datatype text -optional
element create $form_name submit      -widget submit -datatype text -label "$button_label" -html "class form_submit"
element create $form_name last_tari   -widget hidden -datatype text -optional
element create $form_name cod_listino -widget hidden -datatype text -optional
element create $form_name descrizione -widget hidden -datatype text -optional

if {[form is_request $form_name]} {

    element set_properties $form_name funzione    -value $funzione
    element set_properties $form_name caller      -value $caller
    element set_properties $form_name nome_funz   -value $nome_funz
    element set_properties $form_name extra_par   -value $extra_par
    element set_properties $form_name last_tari   -value $last_tari
    element set_properties $form_name cod_listino -value $cod_listino
    element set_properties $form_name descrizione -value $descrizione

    if {$funzione == "I"} {
        
    } else {
      # leggo riga
        if {[db_0or1row sel_tari {}] == 0} {
            iter_return_complaint "Record non trovato"
	}

        element set_properties $form_name tipo_costo       -value $tipo_costo
	element set_properties $form_name tipo_costo_dett  -value $tipo_costo_dett
	element set_properties $form_name cod_potenza_dett -value $cod_potenza_dett
        element set_properties $form_name cod_potenza      -value $cod_potenza
        element set_properties $form_name data_inizio      -value $data_inizio
        element set_properties $form_name importo          -value $importo
        element set_properties $form_name flag_tariffa_impianti_vecchi -value $flag_tariffa_impianti_vecchi;#sim02
	element set_properties $form_name anni_fine_tariffa_base       -value $anni_fine_tariffa_base;#sim02
        element set_properties $form_name tariffa_impianti_vecchi      -value $tariffa_impianti_vecchi;#sim02

    }
}

if {[form is_valid $form_name]} {

    # form valido dal punto di vista del templating system

    set tipo_costo   [element::get_value $form_name tipo_costo]
    set cod_potenza  [element::get_value $form_name cod_potenza]
    set data_inizio  [element::get_value $form_name data_inizio]
    set importo      [element::get_value $form_name importo]
    set flag_tariffa_impianti_vecchi [element::get_value $form_name flag_tariffa_impianti_vecchi];#sim02
    set anni_fine_tariffa_base       [element::get_value $form_name anni_fine_tariffa_base];#sim02
    set tariffa_impianti_vecchi      [element::get_value $form_name tariffa_impianti_vecchi];#sim02

    # controlli standard su numeri e date, per Ins ed Upd
    set error_num 0
    if {$funzione == "I"
    ||  $funzione == "M"
    } {

        if {[string equal $tipo_costo ""]} {
            element::set_error $form_name tipo_costo "Inserire Tipo costo"
            incr error_num
        } 

        if {[string equal $cod_potenza ""]} {
            element::set_error $form_name cod_potenza "Inserire Fascia potenza"
            incr error_num
        }

        if {[string equal $data_inizio ""]} {
            element::set_error $form_name data_inizio "Inserire Data inizio validit&agrave;"
            incr error_num
        } else {
            set data_inizio [iter_check_date $data_inizio]
            if {$data_inizio == 0} {
                element::set_error $form_name data_inizio "Data inizio validit&agrave; deve essere una data"
                incr error_num
            }
        }

        if {[string equal $importo ""]} {
            element::set_error $form_name importo "Inserire Importo"
            incr error_num
        } else {
            set importo [iter_check_num $importo 2]
            if {$importo == "Error"} {
                element::set_error $form_name importo "Importo deve essere numerico e pu&ograve; avere al massimo 2 decimali"
                incr error_num
            } else {
                if {[iter_set_double $importo] >=  [expr pow(10,7)]
                ||  [iter_set_double $importo] <= -[expr pow(10,7)]} {
                    element::set_error $form_name importo "Importo deve essere inferiore di 10.000.000"
                    incr error_num
                }
            }
        }

	if {$flag_tariffa_impianti_vecchi eq "t" && $anni_fine_tariffa_base eq ""} {#sim02: aggiunta if e suo contenuto
	    element::set_error $form_name anni_fine_tariffa_base "Inserire N&deg; anni oltre i quali applicare la 2&deg; tariffa"
	    incr error_num
	}

	if {$flag_tariffa_impianti_vecchi eq "t" && $tariffa_impianti_vecchi eq ""} {#sim02: aggiunta if e suo contenuto
            element::set_error $form_name tariffa_impianti_vecchi "Inserire importo tariffa per impianti vecchi"
	    incr error_num
	}

	if {$flag_tariffa_impianti_vecchi eq "f" && $anni_fine_tariffa_base ne ""} {#sim02: aggiunta if e suo contenuto
	    element::set_error $form_name anni_fine_tariffa_base "Per valorizzare questo dato &egrave; necessario impostare \"Si prevede una 2&deg; tariffa per impianti vecchi?\" a SI"
	    incr error_num
	}

	if {$flag_tariffa_impianti_vecchi eq "f" && $tariffa_impianti_vecchi ne ""} {#sim02: aggiunta if e suo contenuto
            element::set_error $form_name tariffa_impianti_vecchi "Per valorizzare questo dato &egrave; necessario impostare \"Si prevede una 2&deg; tariffa per impianti vecchi?\" a SI"
	    incr error_num
	}

	if {$anni_fine_tariffa_base ne ""} {#sim02: aggiunta if e suo contenuto
	    set anni_fine_tariffa_base [iter_check_num $anni_fine_tariffa_base 0]
	    if {$anni_fine_tariffa_base  == "Error"} {
                element::set_error $form_name anni_fine_tariffa_base "Inserire un valore numerico"
		incr error_num
	    }
	}
            
	if {$tariffa_impianti_vecchi ne ""} {#sim02: aggiunta if e suo contenuto
	    set tariffa_impianti_vecchi [iter_check_num $tariffa_impianti_vecchi 2]
            if {$tariffa_impianti_vecchi == "Error"} {
                element::set_error $form_name tariffa_impianti_vecchi "Deve essere numerico e pu&ograve; avere al massimo 2 decimali"
                incr error_num
	    } else {
		if {[iter_set_double $tariffa_impianti_vecchi] >=  [expr pow(10,7)]
		||  [iter_set_double $tariffa_impianti_vecchi] <= -[expr pow(10,7)]
		} {
                    element::set_error $form_name tariffa_impianti_vecchi "Deve essere inferiore di 10.000.000"
                    incr error_num
		}
	    }
	}
    }

    if {$funzione == "I"
    &&  $error_num == 0
    &&  [db_0or1row sel_tari_check {}] == 1
    } {
      # controllo univocita'/protezione da double_click
        element::set_error $form_name data_inizio "Il record che stai tentando di inserire &egrave; gi&agrave; esistente nel Data Base."
        incr error_num
    }

    if {$error_num > 0} {
        ad_return_template
        return
    }

    if {$funzione == "D"} {
	set data_inizio [iter_check_date $data_inizio]
    }

    switch $funzione {
        I {set dml_sql [db_map ins_tari]}
        M {set dml_sql [db_map upd_tari]}
        D {set dml_sql [db_map del_tari]}
    }

  # Lancio la query di manipolazione dati contenute in dml_sql
    if {[info exists dml_sql]} {
        with_catch error_msg {
            db_transaction {
                db_dml dml_coimtari $dml_sql
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
        set last_tari [list $tipo_costo $cod_potenza $data_inizio]
    }
    set link_list      [subst $link_list_script]
    set link_gest      [export_url_vars tipo_costo cod_listino descrizione cod_potenza data_inizio last_tari nome_funz nome_funz_caller extra_par caller]
    switch $funzione {
        M {set return_url   "coimtari-gest?funzione=V&$link_gest"}
        D {set return_url   "coimtari-list?$link_list"}
        I {set return_url   "coimtari-gest?funzione=V&$link_gest"}
        V {set return_url   "coimtari-list?$link_list"}
    }

    ad_returnredirect $return_url
    ad_script_abort
}

ad_return_template
