ad_page_contract {
    Lista tabella "coimcimp"

    @author                  Paolo Formizzi Adhoc
    @creation-date           03/05/2004

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

    @cvs-id                  coimcimp-mod-fatt.tcl 
} { 
    {search_word         ""}
    {rows_per_page       ""}
    {caller         "index"}
    {nome_funz           ""}
    {nome_funz_caller    ""} 
    {receiving_element   ""}
    {id_utente           ""}
    {cod_cimp            ""}
    {last_cod_cimp       ""}
    {cod_impianto        ""}
    {url_aimp            ""}
    {url_list_aimp       ""}
    {f_cod_enve          ""}
    {f_cod_tecn          ""}
    {f_data_controllo_da ""}
    {f_data_controllo_a  ""}
    {f_anno_inst_da      ""}
    {f_anno_inst_a       ""}
    {f_cod_comb          ""}
    {f_cod_comune        ""}
    {f_cod_via           ""}
    {flag_cimp           ""}
    {f_descr_topo        ""}
    {f_descr_via         ""}
    {f_verb_n            ""}
    {flag_inco           ""}
    {cod_inco            ""}
    {extra_par           ""}
    {extra_par_inco      ""}
    {funzione           "V"}
}  -properties {
    page_title:onevalue
    context_bar:onevalue
    list_head:onevalue
    table_result:onevalue
}

# Controlla lo user
switch $funzione {
    "V" {set lvl 1}
    "M" {set lvl 3}
}

#set id_utente [lindex [iter_check_login $lvl $nome_funz] 1]
set link_list_script {[export_url_vars cod_impianto last_cod_cimp nome_funz_caller nome_funz flag_cimp flag_inco cod_inco extra_par_inco]&[iter_set_url_vars $extra_par]}
#set link_list_script {[export_url_vars cod_impianto last_cod_cimp nome_funz_caller nome_funz url_aimp url_list_aimp flag_cimp]&[iter_set_url_vars $extra_par]}
set link_list        [subst $link_list_script]

# controllo il parametro di "propagazione" per la navigation bar
if {[string is space $nome_funz_caller]} {
    set nome_funz_caller $nome_funz
}

if {$flag_cimp == "S"} {
    set link_tab [iter_links_form $cod_impianto $nome_funz_caller $url_list_aimp $url_aimp]
    set dett_tab [iter_tab_form $cod_impianto]
} else {
    set link_tab ""
    if {$flag_inco == "S"} {
	set dett_tab [iter_tab_form $cod_impianto]
    } else {
	set dett_tab ""
    }
}

if {$flag_inco == "S"} {
    # setto l'extra_par_inco per poterla passare al gest
    set link_inco [iter_link_inco $cod_inco $nome_funz_caller $url_list_aimp $url_aimp $nome_funz "" $extra_par_inco]
} else {
    set link_inco ""
}

set link_filt    [export_ns_set_vars url]
set page_title   "Modifica Dati Fattura"
set button_label "Conferma" 
set context_bar  [iter_context_bar -nome_funz $nome_funz]

# imposto le variabili da usare nel frammento html di testata della lista.
set curr_prog       [file tail [ns_conn url]]
set form_di_ricerca [iter_search_form $curr_prog $search_word]
if {$flag_cimp == "S" || $flag_inco == "S"} {
    set extra_par   [list rows_per_page       $rows_per_page \
			 receiving_element   $receiving_element]
} else {
    set extra_par   [list rows_per_page      $rows_per_page \
			 receiving_element   $receiving_element \
			 f_data_controllo_da $f_data_controllo_da \
			 f_data_controllo_a  $f_data_controllo_a \
			 f_anno_inst_da      $f_anno_inst_da \
			 f_anno_inst_a       $f_anno_inst_a \
			 f_cod_comb          $f_cod_comb \
			 f_cod_enve          $f_cod_enve \
			 f_cod_tecn          $f_cod_tecn \
			 f_cod_comune        $f_cod_comune \
			 f_cod_via           $f_cod_via \
			 f_descr_topo        $f_descr_topo \
			 f_descr_via         $f_descr_via \
			 f_verb_n            $f_verb_n \
			]
}

# sproteggo la chiave solo in inserimento e gli attributi in inserimento e mod.
set form_name    "coimcimp"
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

element create $form_name data_controllo_edit \
    -label   "Data Controllo" \
    -widget   text \
    -datatype text \
    -html    "size 10 maxlength 10 readonly {} class form_element" \
    -optional

element create $form_name data_verb_edit \
    -label   "Data verbale" \
    -widget   text \
    -datatype text \
    -html    "size 10 maxlength 10 readonly {} class form_element" \
    -optional

element create $form_name verb_n \
    -label   "Num.Verbale" \
    -widget   text \
    -datatype text \
    -html    "size 10 maxlength 10 readonly {} class form_element" \
    -optional

element create $form_name costo_verifica_edit \
    -label   "Costo ispezione" \
    -widget   text \
    -datatype text \
    -html    "size 10 maxlength 10 $readonly_fld {} class form_element" \
    -optional

element create $form_name num_fatt \
    -label   "Num.Fattura" \
    -widget   text \
    -datatype text \
    -html    "size 10 maxlength 10 $readonly_fld {} class form_element" \
    -optional

element create $form_name data_fatt_edit \
    -label   "Data Fattura" \
    -widget   text \
    -datatype text \
    -html    "size 10 maxlength 10 $readonly_fld {} class form_element" \
    -optional

element create $form_name funzione         -widget hidden -datatype text -optional
element create $form_name caller           -widget hidden -datatype text -optional
element create $form_name nome_funz        -widget hidden -datatype text -optional
element create $form_name nome_funz_caller -widget hidden -datatype text -optional
element create $form_name extra_par        -widget hidden -datatype text -optional
element create $form_name cod_impianto     -widget hidden -datatype text -optional
element create $form_name url_aimp         -widget hidden -datatype text -optional
element create $form_name url_list_aimp    -widget hidden -datatype text -optional
element create $form_name cod_cimp         -widget hidden -datatype text -optional
element create $form_name last_cod_cimp    -widget hidden -datatype text -optional
element create $form_name flag_cimp        -widget hidden -datatype text -optional
element create $form_name submit           -widget submit -datatype text -label "$button_label" -html "class form_submit"

if {[form is_request $form_name]} {

    element set_properties $form_name funzione         -value $funzione
    element set_properties $form_name caller           -value $caller
    element set_properties $form_name nome_funz        -value $nome_funz
    element set_properties $form_name nome_funz_caller -value $nome_funz_caller
    element set_properties $form_name extra_par        -value $extra_par
    element set_properties $form_name cod_impianto     -value $cod_impianto
    element set_properties $form_name last_cod_cimp    -value $last_cod_cimp
    element set_properties $form_name cod_cimp         -value $cod_cimp
    element set_properties $form_name url_aimp         -value $url_aimp
    element set_properties $form_name url_list_aimp    -value $url_list_aimp
    element set_properties $form_name flag_cimp        -value $flag_cimp

    # leggo riga
    if {![db_0or1row query "
        select a.cod_cimp
             , a.verb_n
             , iter_edit_data(a.data_controllo) as data_controllo_edit
             , iter_edit_data(a.data_verb)      as data_verb_edit
             , iter_edit_num(a.costo, 2)        as costo_verifica_edit
             , iter_edit_data(a.data_fatt)      as data_fatt_edit
             , a.numfatt                        as num_fatt
             , tipologia_costo
          from coimcimp a
         where a.cod_cimp = :cod_cimp"]} {
	iter_return_complaint "Record non trovato"
    }

    element set_properties $form_name data_controllo_edit  -value $data_controllo_edit
    element set_properties $form_name data_verb_edit       -value $data_verb_edit
    element set_properties $form_name verb_n               -value $verb_n
    element set_properties $form_name costo_verifica_edit  -value $costo_verifica_edit
    element set_properties $form_name num_fatt             -value $num_fatt
    element set_properties $form_name data_fatt_edit       -value $data_fatt_edit
}

if {[form is_valid $form_name]} {
    # form valido dal punto di vista del templating system
    set data_controllo_edit [element::get_value $form_name data_controllo_edit]
    set data_verb_edit      [element::get_value $form_name data_verb_edit]
    set verb_n              [element::get_value $form_name verb_n]
    set costo_verifica_edit [element::get_value $form_name costo_verifica_edit]
    set num_fatt            [element::get_value $form_name num_fatt]
    set data_fatt_edit      [element::get_value $form_name data_fatt_edit]
    set flag_cimp           [element::get_value $form_name flag_cimp]

    set error_num 0
    if {$funzione == "M"} {
	# controlli standard su numeri e date, per Ins ed Upd
	db_0or1row query "select tipologia_costo from coimcimp a where a.cod_cimp = :cod_cimp"

	# se tipologia_costo è Bollettino postale, num e data fattura sono obbligatori
	if {$tipologia_costo eq "BP"} {
	    if {$data_fatt_edit eq ""} {
                element::set_error $form_name data_fatt_edit "Campo obbligatorio"
                incr error_num
	    }
	    if {$num_fatt eq ""} {
                element::set_error $form_name num_fatt "Campo obbligatorio"
                incr error_num
	    }
	}

	if {$data_fatt_edit ne ""} {
	    set data_fatt [iter_check_date $data_fatt_edit]
	    if {$data_fatt eq "0" || $data_fatt eq "Error"} {
		element::set_error $form_name data_fatt_edit "Data errata"
		incr error_num
	    }
	} else {
	    set data_fatt ""
	}

        if {$costo_verifica_edit ne ""} {
            set costo_verifica [iter_check_num $costo_verifica_edit 2]
            if {$costo_verifica == "Error"} {
                element::set_error $form_name costo_verifica_edit "Deve essere numerico, max 2 dec"
                incr error_num
            } else {
                if {[iter_set_double $costo_verifica] >=  [expr pow(10,7)] || [iter_set_double $costo_verifica] <= -[expr pow(10,7)]} {
                    element::set_error $form_name costo_verifica_edit "Deve essere inferiore di 10.000.000"
                    incr error_num
		}
            }
        } else {
	    set costo_verifica "0"
	}
    }

    if {$error_num > 0} {
        ad_return_template
        return
    }

    if {$funzione == "M"} {
        with_catch error_msg {
            db_transaction {
                db_dml query "
           update coimcimp
              set costo        = :costo_verifica
                , numfatt      = :num_fatt
                , data_fatt    = :data_fatt
                , data_mod     = current_date
                , utente       = :id_utente
            where cod_cimp     = :cod_cimp
              and cod_impianto = :cod_impianto"
            }
        } {
            iter_return_complaint "Spiacente, ma il DBMS ha restituito il
            seguente messaggio di errore <br><b>$error_msg</b><br>
            Contattare amministratore di sistema e comunicare il messaggio
            d'errore. Grazie."
 	}
    }

    set return_url "coimcimp-list?$link_list"
ns_log notice "link|$return_url"
    ad_returnredirect $return_url
    ad_script_abort
}

ad_return_template
