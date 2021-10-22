ad_page_contract {
    Add/Edit/Delete  form per la tabella "coimgage"
    @author          Giulio Laurenzi
    @creation-date   08/07/2004

    @param funzione  I=insert M=edit D=delete V=view
    @param caller    caller della lista da restituire alla lista:
                     serve se lista e' uno zoom che permetti aggiungi.
    @param nome_funz identifica l'entrata di menu, server per le autorizzazioni
                     serve se lista e' uno zoom che permetti aggiungi.
    @param nome_funz_caller identifica l'entrata di menu, serve per la 
                     navigazione con navigation bar
    @param extra_par Variabili extra da restituire alla lista
    @cvs-id          coimgage-gest.tcl
} {
    
   {cod_impianto     ""}
   {funzione        "V"}
   {caller      "index"}
   {nome_funz        ""}
   {nome_funz_caller ""}
   {url_aimp         ""}
   {url_list_aimp    ""}
   {extra_par        ""}
} -properties {
    page_title:onevalue
    context_bar:onevalue
    form_name:onevalue
}

set lvl 3
set id_utente [lindex [iter_check_login $lvl $nome_funz] 1]
set link_gest [export_url_vars cod_impianto nome_funz_caller url_aimp url_list_aimp extra_par caller]
# imposta le class css della barra delle funzioni
iter_set_func_class $funzione

# controllo il parametro di "propagazione" per la navigation bar
if {[string is space $nome_funz_caller]} {
    set nome_funz_caller $nome_funz
}

set link_tab [iter_links_form $cod_impianto $nome_funz_caller $url_list_aimp $url_aimp]

set dett_tab [iter_tab_form $cod_impianto]

set cod_manutentore [iter_check_uten_manu $id_utente]
if {[string is space $cod_manutentore]} {
    iter_return_complaint "L'utente corrente non &egrave; una ditta manutentrice"
}

# Personalizzo la pagina
set link_list_script {[export_url_vars last_cod_impianto last_data_prevista caller nome_funz_caller nome_funz]&[iter_set_url_vars $extra_par]}
set link_list    [subst $link_list_script]
set titolo       "Controllo in Agenda Manutentore"
set button_label "Conferma inserimento"
set page_title   "Inserimento $titolo"
set context_bar  [iter_context_bar -nome_funz $nome_funz_caller]

# sproteggo la chiave solo in inserimento e gli attributi in inserimento e mod.
set form_name    "coimgage"
set readonly_key \{\}
set readonly_fld \{\}
set disabled_fld \{\}
set onsubmit_cmd ""
     
form create $form_name \
-html    $onsubmit_cmd

element create $form_name data_prevista \
-label   "Data prevista" \
-widget   text \
-datatype text \
-html    "size 10 maxlength 10 $readonly_fld {} class form_element" \
-optional

element create $form_name note \
-label   "Note" \
-widget   textarea \
-datatype text \
-html    "cols 50 rows 4 $readonly_fld {} class form_element" \
-optional

element create $form_name cod_impianto -widget hidden -datatype text -optional
element create $form_name caller    -widget hidden -datatype text -optional
element create $form_name nome_funz -widget hidden -datatype text -optional
element create $form_name extra_par -widget hidden -datatype text -optional
element create $form_name submit    -widget submit -datatype text -label "$button_label" -html "class form_submit"
element create $form_name url_aimp  -widget hidden -datatype text -optional
element create $form_name url_list_aimp -widget hidden -datatype text -optional

set current_date [iter_set_sysdate]
# Serve per le query, in modo da non usare la sysdate di oracle
# che ha anche il time. Il campo data_ins e' chiave!

# gage_num viene visualizzato sulla mappa
set gage_num [db_string sel_gage_num ""]
set error_in_form_is_request "f"

if {[form is_request $form_name]} {

    element set_properties $form_name cod_impianto  -value $cod_impianto
    element set_properties $form_name caller        -value $caller
    element set_properties $form_name nome_funz     -value $nome_funz
    element set_properties $form_name extra_par     -value $extra_par
    element set_properties $form_name url_aimp      -value $url_aimp
    element set_properties $form_name url_list_aimp -value $url_list_aimp

    # faccio i primi controlli gia' in fase di request
    set error_num 0

    if {[db_string sel_gage_test_aimp ""] >= 1} {
	element::set_error $form_name data_prevista "In agenda esiste gi&agrave; un controllo da eseguire riguardante questo impianto"
	incr error_num
    } else {
	if {[db_string sel_gage_test_unique ""] >= 1} {
	    element::set_error $form_name data_prevista "In agenda esiste gi&agrave; un controllo inserito oggi riguardante questo impianto"
	    incr error_num
	}
    }

    if {$error_num > 0} {
	set error_in_form_is_request "t"
        ad_return_template
        return
    }
}

if {[form is_valid $form_name]} {

    set cod_impianto    [element::get_value $form_name cod_impianto]
    set data_prevista   [element::get_value $form_name data_prevista]
    set note            [element::get_value $form_name note]

  # controlli standard su numeri e date, per Ins ed Upd
    set error_num 0

    if {[string equal $data_prevista ""]} {
	element::set_error $form_name data_prevista "Inserire Data prevista"
	incr error_num
    } else {
	set data_prevista [iter_check_date $data_prevista]
	if {$data_prevista == 0} {
	    element::set_error $form_name data_prevista "Data prevista deve essere una data"
	    incr error_num
	}
    }

    if {$error_num > 0} {
        ad_return_template
        return
    }

  # preparo la query di inserimento
    set stato           "1"
    set data_esecuzione ""
    set dml_sql         [db_map ins_gage]

  # Lancio la query di manipolazione dati contenute in dml_sql
    if {[info exists dml_sql]} {
        with_catch error_msg {
            db_transaction {
                db_dml dml_coimgage $dml_sql
            }
        } {
            iter_return_complaint "Spiacente, ma il DBMS ha restituito il
            seguente messaggio di errore <br><b>$error_msg</b><br>
            Contattare amministratore di sistema e comunicare il messaggio
            d'errore. Grazie."
 	}
    }

  # dopo l'inserimento vado alla visualizzazione impianto
    set link_gest  [export_url_vars cod_impianto nome_funz_caller url_aimp url_list_aimp extra_par caller]
    set return_url "coimaimp-gest?funzione=V&nome_funz=impianti&$link_gest"

    ad_returnredirect $return_url
    ad_script_abort
}

ad_return_template
