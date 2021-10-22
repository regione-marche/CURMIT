ad_page_contract {
    Add/Edit/Delete  form per la tabella "coimenve"
    @author          Paolo Formizzi Adhoc
    @creation-date   29/04/2004

    @param funzione  I=insert M=edit D=delete V=view
    @param caller    caller della lista da restituire alla lista:
                     serve se lista e' uno zoom che permetti aggiungi.
    @param nome_funz identifica l'entrata di menu, server per le autorizzazioni
                     serve se lista e' uno zoom che permetti aggiungi.
    @param extra_par Variabili extra da restituire alla lista
    @cvs-id          coimenve-gest.tcl
} {
    
   {cod_enve      ""}
   {last_cod_enve ""}
   {funzione     "V"}
   {caller   "index"}
   {nome_funz     ""}
   {extra_par     ""}
   {nome_funz_caller ""}
   {url_enve      ""}
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

iter_get_coimtgen
set link_cap      $coimtgen(link_cap)

# preparo la url che serve agli opve per tornare agli enve
if {$funzione != "I"
&&  [string equal $url_enve ""]
} {
    set url_enve [list [ad_conn url]?[export_ns_set_vars url]]
}
set link_gest [export_url_vars cod_enve last_cod_enve nome_funz extra_par url_enve]
set link_opve [export_url_vars cod_enve nome_funz_caller]&nome_funz=[iter_get_nomefunz coimopve-list]&[export_url_vars url_enve]

iter_set_func_class $funzione

# Personalizzo la pagina
set link_list_script {[export_url_vars last_cod_enve caller nome_funz]&[iter_set_url_vars $extra_par]}
set link_list        [subst $link_list_script]
set titolo           "Ente Verificatore"
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

set context_bar  [iter_context_bar -nome_funz $nome_funz]

# controllo il parametro di "propagazione" per la navigation bar
if {[string is space $nome_funz_caller]} {
    set nome_funz_caller $nome_funz
}


# sproteggo la chiave solo in inserimento e gli attributi in inserimento e mod.
set form_name    "coimenve"
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

element create $form_name cod_enve \
-label   "Progr. Distributore" \
-widget   text \
-datatype text \
-html    "size 8 maxlength 8 $readonly_key {} class form_element" \
-optional

element create $form_name ragione_01 \
-label   "Rag.soc.1" \
-widget   text \
-datatype text \
-html    "size 30 maxlength 40 $readonly_fld {} class form_element" \
-optional

element create $form_name ragione_02 \
-label   "Rag.soc.2" \
-widget   text \
-datatype text \
-html    "size 30 maxlength 40 $readonly_fld {} class form_element" \
-optional

element create $form_name indirizzo \
-label   "Indirizzo" \
-widget   text \
-datatype text \
-html    "size 30 maxlength 40 $readonly_fld {} class form_element" \
-optional

element create $form_name numero \
-label   "Numero" \
-widget   text \
-datatype text \
-html    "size 8 maxlength 8 $readonly_fld {} class form_element" \
-optional

element create $form_name cap \
-label   "C.A.P" \
-widget   text \
-datatype text \
-html    "size 5 maxlength 5 $readonly_fld {} class form_element" \
-optional

element create $form_name localita \
-label   "Localita" \
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

element create $form_name cod_piva \
-label   "Partita IVA" \
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

element create $form_name note \
-label   "Note" \
-widget   textarea \
-datatype text \
-html    "cols 50 rows 2 $readonly_fld {} class form_element" \
-optional

element create $form_name tracciato \
-label   "Tracciato record" \
-widget   textarea \
-datatype text \
-html    "cols 50 rows 2 $readonly_fld {} class form_element" \
-optional

if {$funzione == "I"
||  $funzione == "M"
} {
   set cerca_com [iter_search coimenve [ad_conn package_url]/tabgen/coimcomu-list [list dummy_1 cod_comune search_word comune dummy_2 provincia dummy_3 cap]]
} else {
    set cerca_com ""
}

element create $form_name url_enve   -widget hidden -datatype text -optional
element create $form_name funzione   -widget hidden -datatype text -optional
element create $form_name caller     -widget hidden -datatype text -optional
element create $form_name nome_funz  -widget hidden -datatype text -optional
element create $form_name extra_par  -widget hidden -datatype text -optional
element create $form_name submit     -widget submit -datatype text -label "$button_label" -html "class form_submit"
element create $form_name last_cod_enve -widget hidden -datatype text -optional
element create $form_name cod_comune -widget hidden -datatype text -optional

if {[form is_request $form_name]} {
    element set_properties $form_name url_enve      -value $url_enve
    element set_properties $form_name funzione      -value $funzione
    element set_properties $form_name caller        -value $caller
    element set_properties $form_name nome_funz     -value $nome_funz
    element set_properties $form_name extra_par     -value $extra_par
    element set_properties $form_name last_cod_enve -value $last_cod_enve

    if {$funzione == "I"} {
        
    } else {
      # leggo riga
        if {[db_0or1row sel_enve ""] == 0} {
            iter_return_complaint "Record non trovato"
	}

        element set_properties $form_name cod_enve    -value $cod_enve
        element set_properties $form_name ragione_01  -value $ragione_01
        element set_properties $form_name ragione_02  -value $ragione_02
        element set_properties $form_name indirizzo   -value $indirizzo
        element set_properties $form_name numero      -value $numero
        element set_properties $form_name cap         -value $cap
        element set_properties $form_name localita    -value $localita
        element set_properties $form_name comune      -value $comune
        element set_properties $form_name provincia   -value $provincia
        element set_properties $form_name cod_fiscale -value $cod_fiscale
        element set_properties $form_name cod_piva    -value $cod_piva
        element set_properties $form_name telefono    -value $telefono
        element set_properties $form_name cellulare   -value $cellulare
        element set_properties $form_name fax         -value $fax
        element set_properties $form_name email       -value $email
        element set_properties $form_name note        -value $note
        element set_properties $form_name tracciato   -value $tracciato

    }

}

if {[form is_valid $form_name]} {
  # form valido dal punto di vista del templating system
    set cod_enve    [string trim [element::get_value $form_name cod_enve]]
    set ragione_01  [string trim [element::get_value $form_name ragione_01]]
    set ragione_02  [string trim [element::get_value $form_name ragione_02]]
    set indirizzo   [string trim [element::get_value $form_name indirizzo]]
    set numero      [string trim [element::get_value $form_name numero]]
    set cap         [string trim [element::get_value $form_name cap]]
    set localita    [string trim [element::get_value $form_name localita]]
    set comune      [string trim [element::get_value $form_name comune]]
    set provincia   [string trim [element::get_value $form_name provincia]]
    set cod_fiscale [string trim [element::get_value $form_name cod_fiscale]]
    set cod_piva    [string trim [element::get_value $form_name cod_piva]]
    set telefono    [string trim [element::get_value $form_name telefono]]
    set cellulare   [string trim [element::get_value $form_name cellulare]]
    set fax         [string trim [element::get_value $form_name fax]]
    set email       [string trim [element::get_value $form_name email]]
    set note        [string trim [element::get_value $form_name note]]
    set tracciato   [string trim [element::get_value $form_name tracciato]]
  # data corrente
    set current_date [iter_set_sysdate]

  # controlli standard su numeri e date, per Ins ed Upd
    set error_num 0
    if {$funzione == "I"
    ||  $funzione == "M"
    } {

        if {[string equal $ragione_01 ""]} {
            element::set_error $form_name ragione_01 "Inserire Cognome/Rag.soc"
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

        if {![string equal $cap ""]
        &&  ![string is integer $cap]
	} {
	    element::set_error $form_name cap "Il C.A.P. deve essere un valore numerico"
	    incr error_num
	}  
    }

    if {$funzione == "D"} {
	set sw_err          "f"
	set elenco_opve_err ""
	db_foreach sel_opve "" {
	    db_1row sel_inco_count ""
	    if {$conta_inco > 0} {
		if {$sw_err == "f"} {
		    set sw_err "t"
		} else {
		    append elenco_opve_err ", "
		}
		append elenco_opve_err $cod_opve
	    }
	}

	if {$sw_err == "t"} {
	    element::set_error $form_name cod_enve "Impossibile cancellare l'ente, i seguenti operatori hanno degli incontri collegati: $elenco_opve_err"
            incr error_num
	}
    }
  
    if {$error_num > 0} {
        ad_return_template
        return
    }

    switch $funzione {
        I {
	    db_1row sel_enve_s ""
	    set dml_sql  [db_map ins_enve]
	    set cod_opve $cod_enve
            append cod_opve "000"
	    set dml_opve [db_map ins_opve]
	}
        M {
	    set dml_sql [db_map upd_enve]
	}
        D {
	    set dml_sql  [db_map del_enve]
	    set dml_opve [db_map del_opve]
	}
    }

  # Lancio la query di manipolazione dati contenute in dml_sql
    if {[info exists dml_sql]} {
        with_catch error_msg {
            db_transaction {
                db_dml dml_coimenve $dml_sql
		if {[info exists dml_opve]} {
		    db_dml dml_coimopve $dml_opve
		}
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
        set last_cod_enve $cod_enve
    }
    set link_list      [subst $link_list_script]
    set link_gest      [export_url_vars cod_enve last_cod_enve nome_funz extra_par caller url_enve]
    switch $funzione {
        M {set return_url   "coimenve-gest?funzione=V&$link_gest"}
        D {set return_url   "coimenve-list?$link_list"}
        I {set return_url   "coimenve-gest?funzione=V&$link_gest"}
        V {set return_url   "coimenve-list?$link_list"}
    }

    ad_returnredirect $return_url
    ad_script_abort
}

ad_return_template
