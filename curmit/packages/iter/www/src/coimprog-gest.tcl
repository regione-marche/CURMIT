ad_page_contract {
    Add/Edit/Delete  form per la tabella "coimprog"
    @author          Katia Coazzoli
    @creation-date   06/04/2004

    @param funzione  I=insert M=edit D=delete V=view
    @param caller    caller della lista da restituire alla lista:
                     serve se lista e' uno zoom che permetti aggiungi.
    @param nome_funz identifica l'entrata di menu, server per le autorizzazioni
                     serve se lista e' uno zoom che permetti aggiungi.
    @param extra_par Variabili extra da restituire alla lista
    @cvs-id          coimprog-gest.tcl
} {
    
   {cod_progettista ""}
   {last_cognome ""}
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

# controllo il parametro di "propagazione" per la navigation bar
if {[string is space $nome_funz_caller]} {
    set nome_funz_caller $nome_funz
}

set link_gest [export_url_vars cod_progettista last_cognome nome_funz nome_funz_caller extra_par caller]
iter_set_func_class $funzione

# Personalizzo la pagina

iter_get_coimtgen
set link_cap      $coimtgen(link_cap)

set link_list_script {[export_url_vars last_cognome caller nome_funz nome_funz_caller]&[iter_set_url_vars $extra_par]}
set link_list        [subst $link_list_script]
set titolo           "Progettista"
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
    set context_bar  [iter_context_bar -nome_funz $nome_funz_caller]
} else {
    set context_bar  [iter_context_bar \
                     [list "javascript:window.close()" "Torna alla Gestione"] \
                     [list coimprog-list?$link_list "Lista Progettista"] \
                     "$page_title"]
}



set url_prog        [list [ad_conn url]?[export_ns_set_vars url]]
set url_prog        [export_url_vars url_prog]

# sproteggo la chiave solo in inserimento e gli attributi in inserimento e mod.
set form_name    "coimprog"
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

element create $form_name cod_progettista \
-label   "Codice" \
-widget   text \
-datatype text \
-html    "size 8 maxlength 8 $readonly_key {} class form_element" \
-optional

element create $form_name cognome \
-label   "Cognome" \
-widget   text \
-datatype text \
-html    "size 30 maxlength 40 $readonly_fld {} class form_element" \
-optional

element create $form_name nome \
-label   "Nome" \
-widget   text \
-datatype text \
-html    "size 20 maxlength 40 $readonly_fld {} class form_element" \
-optional

element create $form_name indirizzo \
-label   "Indirizzo" \
-widget   text \
-datatype text \
-html    "size 30 maxlength 40 $readonly_fld {} class form_element" \
-optional

element create $form_name localita \
-label   "Localita" \
-widget   text \
-datatype text \
-html    "size 20 maxlength 40 $readonly_fld {} class form_element" \
-optional

element create $form_name provincia \
-label   "Provincia" \
-widget   text \
-datatype text \
-html    "size 4 maxlength 4 $readonly_fld {} class form_element" \
-optional

element create $form_name cap \
-label   "C.A.P." \
-widget   text \
-datatype text \
-html    "size 5 maxlength 5 $readonly_fld {} class form_element" \
-optional

element create $form_name comune \
-label   "Comune" \
-widget   text \
-datatype text \
-html    "size 30 maxlength 40 $readonly_fld {} class form_element" \
-optional

if {$funzione == "I"
||  $funzione == "M"
} {
    set link_comune [iter_search  coimprog [ad_conn package_url]/tabgen/coimcomu-list [list dummy_1 cod_comune search_word comune dummy_2 provincia dummy_3 cap]]
} else {
    set link_comune ""
}

element create $form_name cod_fiscale \
-label   "Cod. Fiscale" \
-widget   text \
-datatype text \
-html    "size 16 maxlength 16 $readonly_fld {} class form_element" \
-optional

element create $form_name cod_piva \
-label   "P. IVA" \
-widget   text \
-datatype text \
-html    "size 15 maxlength 11 $readonly_fld {} class form_element" \
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
-html    "size 15 maxlength 15 $readonly_fld {} class form_element" \
-optional

element create $form_name fax \
-label   "Fax" \
-widget   text \
-datatype text \
-html    "size 15 maxlength 15 $readonly_fld {} class form_element" \
-optional

element create $form_name email \
-label   "E-mail" \
-widget   text \
-datatype text \
-html    "size 30 maxlength 35 $readonly_fld {} class form_element" \
-optional

element create $form_name reg_imprese \
-label   "Reg. Imprese" \
-widget   text \
-datatype text \
-html    "size 15 maxlength 15 $readonly_fld {} class form_element" \
-optional

element create $form_name localita_reg \
-label   "localit&agrave;  reg imp." \
-widget   text \
-datatype text \
-html    "size 30 maxlength 40 $readonly_fld {} class form_element" \
-optional

element create $form_name rea \
-label   "Rea" \
-widget   text \
-datatype text \
-html    "size 15 maxlength 15 $readonly_fld {} class form_element" \
-optional

element create $form_name localita_rea \
-label   "Localit&agrave; Rea" \
-widget   text \
-datatype text \
-html    "size 30 maxlength 40 $readonly_fld {} class form_element" \
-optional

element create $form_name capit_sociale \
-label   "Capitale sociale" \
-widget   text \
-datatype text \
-html    "size 14 maxlength 14 $readonly_fld {} class form_element" \
-optional

element create $form_name note \
-label   "Note" \
-widget   textarea \
-datatype text \
-html    "cols 50 rows 2 $readonly_fld {} class form_element" \
-optional

element create $form_name cod_comune -widget hidden -datatype text -optional
element create $form_name funzione  -widget hidden -datatype text -optional
element create $form_name caller    -widget hidden -datatype text -optional
element create $form_name nome_funz -widget hidden -datatype text -optional
element create $form_name extra_par -widget hidden -datatype text -optional
element create $form_name submit    -widget submit -datatype text -label "$button_label" -html "class form_submit"
element create $form_name last_cognome -widget hidden -datatype text -optional

if {[form is_request $form_name]} {

    element set_properties $form_name funzione  -value $funzione
    element set_properties $form_name caller    -value $caller
    element set_properties $form_name nome_funz -value $nome_funz
    element set_properties $form_name extra_par -value $extra_par
    element set_properties $form_name last_cognome -value $last_cognome

    if {$funzione == "I"} {
      # TODO: settare eventuali default!!
        
    } else {
      # leggo riga
        if {[db_0or1row sel_prog ""] == 0
        } {
            iter_return_complaint "Record non trovato"
	}

        element set_properties $form_name cod_progettista -value $cod_progettista
        element set_properties $form_name cognome        -value $cognome
        element set_properties $form_name nome           -value $nome
        element set_properties $form_name indirizzo      -value $indirizzo
        element set_properties $form_name localita       -value $localita
        element set_properties $form_name provincia      -value $provincia
        element set_properties $form_name cap            -value $cap
        element set_properties $form_name comune         -value $comune
        element set_properties $form_name cod_fiscale    -value $cod_fiscale
        element set_properties $form_name cod_piva       -value $cod_piva
        element set_properties $form_name telefono       -value $telefono
        element set_properties $form_name cellulare      -value $cellulare
        element set_properties $form_name fax            -value $fax
        element set_properties $form_name email          -value $email
        element set_properties $form_name reg_imprese    -value $reg_imprese
        element set_properties $form_name localita_reg   -value $localita_reg
        element set_properties $form_name rea            -value $rea
        element set_properties $form_name localita_rea   -value $localita_rea
        element set_properties $form_name capit_sociale  -value $capit_sociale
        element set_properties $form_name note           -value $note

    }
}

if {[form is_valid $form_name]} {
  # form valido dal punto di vista del templating system

    set cod_progettista [string trim [element::get_value $form_name cod_progettista]]
    set cognome         [string trim [element::get_value $form_name cognome]]
    set nome            [string trim [element::get_value $form_name nome]]
    set indirizzo       [string trim [element::get_value $form_name indirizzo]]
    set localita        [string trim [element::get_value $form_name localita]]
    set provincia       [string trim [element::get_value $form_name provincia]]
    set cap             [string trim [element::get_value $form_name cap]]
    set comune          [string trim [element::get_value $form_name comune]]
    set cod_fiscale     [string trim [element::get_value $form_name cod_fiscale]]
    set cod_piva        [string trim [element::get_value $form_name cod_piva]]
    set telefono        [string trim [element::get_value $form_name telefono]]
    set cellulare       [string trim [element::get_value $form_name cellulare]]
    set fax             [string trim [element::get_value $form_name fax]]
    set email           [string trim [element::get_value $form_name email]]
    set reg_imprese     [string trim [element::get_value $form_name reg_imprese]]
    set localita_reg    [string trim [element::get_value $form_name localita_reg]]
    set rea             [string trim [element::get_value $form_name rea]]
    set localita_rea    [string trim [element::get_value $form_name localita_rea]]
    set capit_sociale   [string trim [element::get_value $form_name capit_sociale]]
    set note            [string trim [element::get_value $form_name note]]

  # data corrente
    db_1row sel_dual_date ""

  # controlli standard su numeri e date, per Ins ed Upd
    set error_num 0
    if {$funzione == "I"
    ||  $funzione == "M"
    } {
	if {[string equal $cognome ""]} {
	    element::set_error $form_name cognome "Inserire il Cognome/Ragione sociale"
	    incr error_num
	}

        if {[string equal $indirizzo ""]} {
	    element::set_error $form_name indirizzo "Inserire Indirizzo"
	    incr error_num
	}

        if {[string equal $comune ""]} {
	    element::set_error $form_name comune "Inserire Comune"
	    incr error_num
	}

        if {![string equal $capit_sociale ""]} {
            set capit_sociale [iter_check_num $capit_sociale 2]
            if {$capit_sociale == "Error"} {
                element::set_error $form_name capit_sociale "Capitale sociale deve essere numerico e pu&ograve; avere al massimo 2 decimali"
                incr error_num
            } else {
                if {[iter_set_double $capit_sociale] >=  [expr pow(10,9)]
                ||  [iter_set_double $capit_sociale] <= -[expr pow(10,9)]} {
                    element::set_error $form_name capit_sociale "Capitale sociale deve essere inferiore di 1.000.000.000"
                    incr error_num
                }
            }
        }
	if {![string equal $cap ""]
	&&  ![string is integer $cap]
	} {
	    element::set_error $form_name cap "Il C.A.P. deve essere un valore numerico"
	    incr error_num
	}
    }

    db_1row sel_aimp ""
    if {$funzione == "D"
     &&	$conta_aimp > 0} {
	element::set_error $form_name cod_progettista "Il progettista &egrave; collegato a degli impianti"
	incr error_num
    }

    if {$error_num > 0} {
        ad_return_template
        return
    }

    switch $funzione {
        I {db_1row sel_prog_s ""
           set dml_sql [db_map ins_prog]}
        M {set dml_sql [db_map upd_prog]}
        D {set dml_sql [db_map del_prog]}
    }

  # Lancio la query di manipolazione dati contenute in dml_sql
    if {[info exists dml_sql]} {
        with_catch error_msg {
            db_transaction {
                db_dml dml_coimprog $dml_sql
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
        set last_cognome [list $cognome $cod_progettista]
    }
    set link_list      [subst $link_list_script]
    set link_gest      [export_url_vars cod_progettista last_cognome nome_funz nome_funz_caller extra_par caller]
    switch $funzione {
        M {set return_url   "coimprog-gest?funzione=V&$link_gest"}
        D {set return_url   "coimprog-list?$link_list"}
        I {set return_url   "coimprog-gest?funzione=V&$link_gest"}
        V {set return_url   "coimprog-list?$link_list"}
    }

    ad_returnredirect $return_url
    ad_script_abort
}

ad_return_template
