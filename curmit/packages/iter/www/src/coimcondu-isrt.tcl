ad_page_contract {
    Add/Edit/Delete  form per la tabella "coimcondu"
    @author          Gacalin Lufi
    @creation-date   12/04/2018

    @param funzione  I=insert M=edit D=delete V=view
    @param caller    caller della lista da restituire alla lista:
                     serve se lista e' uno zoom che permetti aggiungi.
    @param nome_funz identifica l'entrata di menu, server per le autorizzazioni
                     serve se lista e' uno zoom che permetti aggiungi.
    @param extra_par Variabili extra da restituire alla lista
    @cvs-id          coimcondu-gest.tcl

    USER  DATA       MODIFICHE
    ===== ========== =======================================================================

} { 

   {funzione        "I"}
   {caller           ""}
   {cognome          ""}
   {nome             ""}
   {nome_funz        ""}
   {indirizzo        ""}
   {cap              ""}
   {provincia        ""}
   {cod_comune       ""}
   {cod_conduttore    ""}
   {receiving_element ""}
   {flag_java        ""}
   {nome_funz_caller ""}

} -properties {
    page_title:onevalue
    context_bar:onevalue
    form_name:onevalue
}

# Controlla lo user
switch $funzione {
    "V" {set lvl 1}
    "I" {set lvl 2}
}

iter_get_coimtgen
set flag_ente     $coimtgen(flag_ente)
set denom_comune  $coimtgen(denom_comune)

set id_utente     [lindex [iter_check_login $lvl $nome_funz] 1]
iter_set_func_class $funzione

# controllo il parametro di "propagazione" per la navigation bar
if {[string is space $nome_funz_caller]} {
    set nome_funz_caller $nome_funz
}

# Personalizzo la pagina
set link_gest [export_url_vars extra_par caller nome_funz receiving_element]
set link_list_script {[export_url_vars  caller nome_funz]}
set link_list        [subst $link_list_script]
set titolo           "Conduttore"

set js_function ""
switch $funzione {
    I {set button_label "Conferma Inserimento"
       set page_title   "Inserimento $titolo"}
    V {set button_label "Torna alla lista"
       set page_title   "Visualizzazione $titolo"


	##### SCRIPT PER IL RITORNO #######
	set receiving_element [split $receiving_element |]
#	set js_function [iter_selected_2 $caller [list [lindex $receiving_element 0] $cognome [lindex $receiving_element 1] $nome [lindex $receiving_element 2] $nome_funz [lindex $receiving_element 3] $descr_via [lindex $receiving_element 4] $descr_topo [lindex $receiving_element 5] $numero [lindex $receiving_element 6] $cap [lindex $receiving_element 7] $provincia [lindex $receiving_element 8] $cod_comune [lindex $receiving_element 9] $cod_conduttore]]

	set js_function [iter_selected_2 $caller [list [lindex $receiving_element 0] $cognome [lindex $receiving_element 1] $nome [lindex $receiving_element 2] $cod_conduttore] ]


       ##################################
    }
}

set context_bar [iter_context_bar \
                [list "window.close()" "Chiudi Finestra"] \
                "$page_title"]


# sproteggo la chiave solo in inserimento e gli attributi in inserimento e mod.
set form_name    "coimcondu"
set readonly_key "readonly"
set readonly_fld "readonly"
set disabled_fld "disabled"
set onsubmit_cmd ""

set readonly_key \{\}
set readonly_fld \{\}
set disabled_fld \{\}

    set readonly_occ \{\}

form create $form_name \
    -html    $onsubmit_cmd

element create $form_name cognome \
    -label   "Cognome" \
    -widget   text \
    -datatype text \
    -html    "size 30 maxlength 100 $readonly_fld {} class form_element" 

element create $form_name nome \
    -label   "Nome" \
    -widget   text \
    -datatype text \
    -html    "size 20 maxlength 100 $readonly_fld {} class form_element" 
    
element create $form_name cod_fiscale \
    -label   "Cod. Fiscale" \
    -widget   text \
    -datatype text \
    -html    "size 16 maxlength 16 $readonly_fld {} class form_element" 

element create $form_name data_patentino \
    -label   "Data Patentino" \
    -widget   text \
    -datatype text \
    -html    "size 10 maxlength 10 $readonly_fld {} class form_element" 
    
element create $form_name ente_rilascio_patentino \
    -label   "Ente rilascio patentino" \
    -widget   text \
    -datatype text \
    -html    "size 100 maxlength 250 $readonly_fld {} class form_element" 

element create $form_name indirizzo \
    -label   "Indirizzo" \
    -widget   text \
    -datatype text \
    -html    "size 30 maxlength 100 $readonly_occ {} class form_element" 

element create $form_name cap \
    -label   "C.A.P." \
    -widget   text \
    -datatype text \
    -html    "size 5 maxlength 5 $readonly_occ {} class form_element" 

element create $form_name comune \
    -label   "Comune" \
    -widget   text \
    -datatype text \
    -html    "size 30 maxlength 40 $readonly_occ {} class form_element" 

set link_comune ""

element create $form_name provincia \
    -label   "Provincia" \
    -widget   text \
    -datatype text \
    -html    "size 4 maxlength 4 $readonly_occ {} class form_element" 

element create $form_name telefono \
    -label   "Telefono" \
    -widget   text \
    -datatype text \
    -html    "size 16 maxlength 16 $readonly_fld {} class form_element" \
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

element create $form_name dummy     -widget hidden -datatype text -optional
element create $form_name funzione  -widget hidden -datatype text -optional
element create $form_name caller    -widget hidden -datatype text -optional
element create $form_name nome_funz -widget hidden -datatype text -optional
element create $form_name cod_comune -widget hidden -datatype text -optional
element create $form_name receiving_element -widget hidden -datatype text -optional
element create $form_name submit    -widget submit -datatype text -label "$button_label" -html "class form_submit"


if {[form is_request $form_name]} {
    element set_properties $form_name funzione  -value $funzione
    element set_properties $form_name caller    -value $caller
    element set_properties $form_name nome_funz -value $nome_funz
    element set_properties $form_name receiving_element -value $receiving_element

    if {![string equal cod_comune ""]
    &&  [db_0or1row sel_comu_desc ""] == 0
    } {
	set comu_denom ""
    }

    if {[string equal $coimtgen(flag_ente) "C"]} {
	#se l'ente è un comune assegno alcuni default con i dati di ambiente
	set cod_comune $coimtgen(cod_comu)
	set comu_denom $coimtgen(denom_comune)
    }

    element set_properties $form_name comune           -value $comu_denom
    element set_properties $form_name cognome          -value $cognome
    element set_properties $form_name nome             -value $nome
    element set_properties $form_name cod_comune       -value $cod_comune
    element set_properties $form_name indirizzo        -value $indirizzo
    element set_properties $form_name cap              -value $cap
    element set_properties $form_name provincia        -value $provincia

}

if {[form is_valid $form_name]} {
  # form valido dal punto di vista del templating system

    set cognome                 [string trim [element::get_value $form_name cognome]]
    set nome                    [string trim [element::get_value $form_name nome]]
    set cod_fiscale             [string trim [element::get_value $form_name cod_fiscale]]
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
    set pec                     [string trim [element::get_value $form_name pec]]    
    set cod_comune              [string trim [element::get_value $form_name cod_comune]]

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

	if {[regexp {[^A-Za-z0-9]+} $cod_fiscale] > 0 } {
	    element::set_error $form_name cod_fiscale "L'identificatore fiscale contiena caratteri non validi"
	    incr error_num
	}
	
	if {[string equal $cod_fiscale ""]} {
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
                element::set_error $form_name data_patentino "Data del patentino deve essere una data"
                incr error_num
            }
        }

	if {[string equal $ente_rilascio_patentino ""]} {
	    element::set_error $form_name ente_rilascio_patentino "Inseririre l'ente che ha rilasciato il patentino"
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
	
        if {![string equal $cap ""]
        &&  ![string is integer $cap]
	} {
	    element::set_error $form_name cap "Il C.A.P. deve essere un valore numerico"
	    incr error_num
	}        

	if {[string equal $telefono ""] && [string equal $cellulare ""] && [string equal $fax ""] && [string equal $email ""] && [string equal $pec ""]} {
            element::set_error $form_name telefono "Inserire almeno un recapito"
	    element::set_error $form_name cellulare "Inserire almeno un recapito"
	    element::set_error $form_name fax "Inserire almeno un recapito"
	    element::set_error $form_name email "Inserire almeno un recapito"
            element::set_error $form_name pec "Inserire almeno un recapito"
	    incr error_num
	}

    }
    
    if {$error_num > 0} {
        ad_return_template
        return
    }

    db_1row sel_cod ""
    set dml_sql [db_map ins_condu]


  # Lancio la query di manipolazione dati contenute in dml_sql
    if {[info exists dml_sql]} {
        with_catch error_msg {
            db_transaction {
                db_dml dml_coimcondu $dml_sql
		if {[info exists dml_sql_manu]} {
		    db_dml dml_coimmanu $dml_sql_manu
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
    set link_list      [subst $link_list_script]

    set link_gest      [export_url_vars nome_funz nome_funz_caller caller receiving_element cognome nome indirizzo cap provincia cod_comune cod_conduttore]

    switch $funzione {
        I {set return_url   "coimcondu-isrt?funzione=V&$link_gest"}
    }

    ad_returnredirect $return_url
    ad_script_abort
}
ad_return_template
