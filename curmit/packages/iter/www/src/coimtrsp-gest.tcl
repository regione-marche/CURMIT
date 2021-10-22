ad_page_contract {
    Add/Edit/Delete  form per la tabella "coimcitt"
    @author          Giulio Laurenzi
    @creation-date   26/02/2004

    @param funzione  I=insert M=edit D=delete V=view
    @param caller    caller della lista da restituire alla lista:
                     serve se lista e' uno zoom che permetti aggiungi.
    @param nome_funz identifica l'entrata di menu, server per le autorizzazioni
                     serve se lista e' uno zoom che permetti aggiungi.
    @param extra_par Variabili extra da restituire alla lista
    @cvs-id          coimtrsp-gest.tcl
} { 
   {cod_cittadino    ""}
   {last_concat_key  ""}
   {funzione        "V"}
   {caller      "index"}
   {nome_funz        ""}
   {nome_funz_caller ""}
   {extra_par        ""}
   {url_citt         ""}
   {flag_java        ""}
   {flag_mod         ""}
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
iter_get_coimtgen
set flag_ente     $coimtgen(flag_ente)
set denom_comune  $coimtgen(denom_comune)
set link_cap      $coimtgen(link_cap)
set id_utente     [lindex [iter_check_login $lvl $nome_funz] 1]
iter_set_func_class $funzione

# controllo il parametro di "propagazione" per la navigation bar
if {[string is space $nome_funz_caller]} {
    set nome_funz_caller $nome_funz
}

if {$funzione != "I"
&&  [string equal $url_citt ""]
} {
    set url_citt [list [ad_conn url]?[export_ns_set_vars url ]]
}

set link_gest [export_url_vars cod_cittadino flag_mod last_concat_key caller nome_funz extra_par url_citt]
set link_aimp "coimaimp-list?nome_funz=impianti&[export_url_vars nome_funz_caller cod_cittadino url_citt]"

# Personalizzo la pagina
set link_list_script {[export_url_vars last_concat_key caller nome_funz]&[iter_set_url_vars $extra_par]}
set link_list        [subst $link_list_script]
set titolo           "Terzo responsabile"
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
                             [list coimtrsp-list?$link_list "Lista Soggetti"] \
                             "$page_title"]
	}
    }
} else {
    set context_bar [iter_context_bar \
                    [list "javascript:window.close()" "Chiudi Finestra"] \
                    "$page_title"]
}

# sproteggo la chiave solo in inserimento e gli attributi in inserimento e mod.
set form_name    "coimtrsp"
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

element create $form_name cod_cittadino \
-label   "Codice" \
-widget   text \
-datatype text \
-html    "size 8 maxlength 8 $readonly_key {} class form_element" \
-optional

element create $form_name natura_giuridica \
-label   "Natura giuridica" \
-widget   select \
-datatype text \
-html    "size 1 maxlength 1 $disabled_fld {} class form_element" \
-optional \
-options {{{} {}} {Fisica F} {Giuridica G}}

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
-html    "size 20 maxlength 100 $readonly_fld {} class form_element" \
-optional

element create $form_name indirizzo \
-label   "Indirizzo" \
-widget   text \
-datatype text \
-html    "size 30 maxlength 40 $readonly_fld {} class form_element" \
-optional

element create $form_name numero \
-label   "Nr. civico" \
-widget   text \
-datatype text \
-html    "size 8 maxlength 8 $readonly_fld {} class form_element" \
-optional

element create $form_name cap \
-label   "C.A.P." \
-widget   text \
-datatype text \
-html    "size 5 maxlength 5 $readonly_fld {} class form_element" \
-optional

element create $form_name localita \
-label   "Localit&agrave;" \
-widget   text \
-datatype text \
-html    "size 20 maxlength 40 $readonly_fld {} class form_element" \
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
   set link_comune [iter_search  coimtrsp [ad_conn package_url]/tabgen/coimcomu-list [list dummy_1 dummy search_word comune dummy_2 provincia dummy_3 cap]]
} else {
    set link_comune ""
}

element create $form_name provincia \
-label   "Provincia" \
-widget   text \
-datatype text \
-html    "size 4 maxlength 4 $readonly_fld {} class form_element" \
-optional

element create $form_name cod_fiscale \
-label   "Cod. Fiscale" \
-widget   text \
-datatype text \
-html    "size 16 maxlength 16 $readonly_fld {} class form_element" \
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

element create $form_name data_nas \
-label   "Data di nascita" \
-widget   text \
-datatype text \
-html    "size 10 maxlength 10 $readonly_fld {} class form_element" \
-optional

element create $form_name comune_nas \
-label   "Comune di nascita" \
-widget   text \
-datatype text \
-html    "size 30 maxlength 40 $readonly_fld {} class form_element" \
-optional

if {$funzione == "I"
||  $funzione == "M"
} {
    set link_comune_nas [iter_search coimtrsp [ad_conn package_url]/tabgen/coimcomu-list [list dummy_1 dummy search_word comune_nas dummy_2 dummy dummy_3 dummy]]
} else {
    set link_comune_nas ""
}

element create $form_name note \
-label   "Note" \
-widget   textarea \
-datatype text \
-html    "cols 50 rows 2 $readonly_fld {} class form_element" \
-optional

element create $form_name flag_mod  -widget hidden -datatype text -optional
element create $form_name url_citt  -widget hidden -datatype text -optional
element create $form_name dummy     -widget hidden -datatype text -optional
element create $form_name funzione  -widget hidden -datatype text -optional
element create $form_name caller    -widget hidden -datatype text -optional
element create $form_name nome_funz -widget hidden -datatype text -optional
element create $form_name extra_par -widget hidden -datatype text -optional
element create $form_name last_concat_key -widget hidden -datatype text -optional
element create $form_name cod_piva  -widget hidden -datatype text -optional
element create $form_name submit    -widget submit -datatype text -label "$button_label" -html "class form_submit"

element set_properties $form_name flag_mod         -value $flag_mod     
if {[form is_request $form_name]} {
    element set_properties $form_name url_citt  -value $url_citt
    element set_properties $form_name funzione  -value $funzione
    element set_properties $form_name caller    -value $caller
    element set_properties $form_name nome_funz -value $nome_funz
    element set_properties $form_name extra_par -value $extra_par
    element set_properties $form_name last_concat_key -value $last_concat_key
    element set_properties $form_name cod_piva  -value ""

    if {$funzione == "I"} {
        if {$flag_ente == "C"} {
	    element set_properties $form_name comune     -value $denom_comune
	}
    } else {
      # leggo riga
        if {[db_0or1row sel_citt ""] == 0} {
            iter_return_complaint "Record non trovato"
	}

        element set_properties $form_name cod_cittadino    -value $cod_cittadino
        element set_properties $form_name natura_giuridica -value $natura_giuridica
        element set_properties $form_name cognome          -value $cognome
        element set_properties $form_name nome             -value $nome
        element set_properties $form_name indirizzo        -value $indirizzo
        element set_properties $form_name numero           -value $numero
        element set_properties $form_name cap              -value $cap
        element set_properties $form_name localita         -value $localita
        element set_properties $form_name comune           -value $comune
        element set_properties $form_name provincia        -value $provincia
        element set_properties $form_name cod_fiscale      -value $cod_fiscale
        element set_properties $form_name cod_piva         -value $cod_piva
        element set_properties $form_name telefono         -value $telefono
        element set_properties $form_name cellulare        -value $cellulare
        element set_properties $form_name fax              -value $fax
        element set_properties $form_name email            -value $email
        element set_properties $form_name data_nas         -value $data_nas
        element set_properties $form_name comune_nas       -value $comune_nas
        element set_properties $form_name note             -value $note
    }
}

if {[form is_valid $form_name]} {
  # form valido dal punto di vista del templating system

    set cod_cittadino    [string trim [element::get_value $form_name cod_cittadino]]
    set natura_giuridica [string trim [element::get_value $form_name natura_giuridica]]
    set cognome          [string trim [element::get_value $form_name cognome]]
    set nome             [string trim [element::get_value $form_name nome]]
    set indirizzo        [string trim [element::get_value $form_name indirizzo]]
    set numero           [string trim [element::get_value $form_name numero]]
    set cap              [string trim [element::get_value $form_name cap]]
    set localita         [string trim [element::get_value $form_name localita]]
    set comune           [string trim [element::get_value $form_name comune]]
    set provincia        [string trim [element::get_value $form_name provincia]]
    set cod_fiscale      [string trim [element::get_value $form_name cod_fiscale]]
    set cod_piva         [string trim [element::get_value $form_name cod_piva]]
    set telefono         [string trim [element::get_value $form_name telefono]]
    set cellulare        [string trim [element::get_value $form_name cellulare]]
    set fax              [string trim [element::get_value $form_name fax]]
    set email            [string trim [element::get_value $form_name email]]
    set data_nas         [string trim [element::get_value $form_name data_nas]]
    set comune_nas       [string trim [element::get_value $form_name comune_nas]]
    set note             [string trim [element::get_value $form_name note]]
    set flag_mod         [string trim [element::get_value $form_name flag_mod]]

  # controlli standard su numeri e date, per Ins ed Upd
    set error_num 0
    if {$funzione == "I"
    ||  $funzione == "M"
    } {

	if {[string equal $cognome ""]} {
	    element::set_error $form_name cognome "Inserire cognome/rag sociale"
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

        if {![string equal $data_nas ""]} {
            set data_nas [iter_check_date $data_nas]
            if {$data_nas == 0} {
                element::set_error $form_name data_nas "Data di nascita deve essere una data"
                incr error_num
            }
        }
        if {![string equal $cap ""]
        &&  ![string is integer $cap]
	} {
	    element::set_error $form_name cap "Il C.A.P. deve essere un valore numerico"
	    incr error_num
	}        
    }

    if {$funzione == "I"
    &&  $error_num == 0
    &&  [db_0or1row sel_citt_chk ""] == 1
    } {
      # controllo univocita'/protezione da double_click
        element::set_error $form_name cod_cittadino "Il record che stai tentando di inserire &egrave; gi&agrave; esistente nel Data Base."
        incr error_num
    }

    if {$funzione == "D"} {
	db_1row sel_aimp_count ""
	if {$conta_aimp > 0} {
	    element::set_error $form_name cod_cittadino "Impossibile cancellare il soggetto: ha degli impianti collegati"
            incr error_num
	}
    }

    if {$error_num > 0} {
        ad_return_template
        return
    }

    switch $funzione {
        I { db_1row sel_cod ""
	    set dml_sql [db_map ins_citt]
        }
        M { set dml_sql [db_map mod_citt] }
        D  {set dml_sql [db_map del_citt] }
    }

  # Lancio la query di manipolazione dati contenute in dml_sql
    if {[info exists dml_sql]} {
        with_catch error_msg {
            db_transaction {
                db_dml dml_coimcitt $dml_sql
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
  #     per ora evito di fare il posizionamento perche' a causa del filtro
  #     non troverei nulla
  #     set last_concat_key  [list $cognome $nome $cod_cittadino]
    }
    set link_list      [subst $link_list_script]
    set link_gest      [export_url_vars cod_cittadino flag_mod last_concat_key nome_funz caller extra_par url_citt]
    switch $funzione {
        M {set return_url   "coimtrsp-gest?funzione=V&$link_gest"}
        D {set return_url   "coimtrsp-list?$link_list"}
        I {set return_url   "coimtrsp-gest?funzione=V&$link_gest"}
        V {set return_url   "coimtrsp-list?$link_list"}
    }

    ad_returnredirect $return_url
    ad_script_abort
}

ad_return_template
