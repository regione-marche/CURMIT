ad_page_contract {
    Add/Edit/Delete                                   
    @author          Simone Pesci   
    @creation-date   14/03/2016

    @param funzione  I=insert M=edit D=delete V=view
    @param caller    caller della lista da restituire alla lista:
                     serve se lista e' uno zoom che permetti aggiungi.
    @param nome_funz identifica l'entrata di menu, server per le autorizzazioni
                     serve se lista e' uno zoom che permetti aggiungi.
    @param extra_par Variabili extra da restituire alla lista
    @cvs-id          coimmanu-gest.tcl


    USER  DATA       MODIFICHE
    ===== ========== =======================================================================


} {
    
   {funzione  "I"}
   {caller    "index"}
   {nome_funz ""}
   {nome_funz_caller ""}
   {extra_par ""}
   {url_manu      ""}
} -properties {
    page_title:onevalue
    context_bar:onevalue
    form_name:onevalue
}

set lvl 1
set id_utente [lindex [iter_check_login $lvl $nome_funz] 1]
set current_date      [iter_set_sysdate]

# controllo il parametro di "propagazione" per la navigation bar
if {[string is space $nome_funz_caller]} {
    set nome_funz_caller $nome_funz
}

iter_get_coimtgen
set link_cap      $coimtgen(link_cap)
set flag_ente     $coimtgen(flag_ente)
set sigla_prov    $coimtgen(sigla_prov)
set flag_portafoglio $coimtgen(flag_portafoglio)

# Personalizzo la pagina
set link_list_script {[export_url_vars caller nome_funz nome_funz_caller]&[iter_set_url_vars $extra_par]}
set link_list        [subst $link_list_script]

set button_label "Conferma Inserimento"
set page_title   "Inserimento movimento"

if {$caller == "index"} {
    set context_bar  [iter_context_bar -nome_funz $nome_funz_caller]
} else {
    set context_bar  [iter_context_bar \
                     [list "javascript:window.close()" "Torna alla Gestione"] \
                     [list transactions?$link_list "Lista Movimenti"] \
                     "$page_title"]
}

# sproteggo la chiave solo in inserimento e gli attributi in inserimento e mod.
set form_name    "transactions"
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

#set cerca_manu [iter_search $form_name [ad_conn package_url]/src/coimmanu-list [list dummy cod_manutentore f_cognome cognome_manu dummy nome_manu dummy saldo_manu dummy cod_portafoglio]]

set cod_portafoglio "test"
set cerca_manu [iter_search $form_name [ad_conn package_url]/src/coimmanu-list [list dummy cod_manutentore f_cognome cognome_manu dummy nome_manu dummy saldo_manu dummy cod_portafoglio]]


form create $form_name \
-html    $onsubmit_cmd

element create $form_name cognome_manu \
    -label   "Cognome manutentore" \
    -widget   text \
    -datatype text \
    -html    "size 25 maxlength 100 $readonly_fld {} class form_element" \
    -optional

element create $form_name nome_manu \
    -label   "Nome manutentore" \
    -widget   text \
    -datatype text \
    -html    "size 25 maxlength 100 $readonly_fld {} class form_element" \
    -optional

element create $form_name amount \
    -label "Importo" \
    -widget text \
    -datatype text \
    -html    "size 10 maxlength 10 $readonly_fld {} class form_element" \
    -optional

element create $form_name payment_date \
    -label "Data versamento" \
    -widget text \
    -datatype text \
    -html    "size 10 maxlength 10 $readonly_fld {} class form_element" \
    -optional

element create $form_name description \
    -label   "Estremi del Versamento" \
    -widget   textarea \
    -datatype text \
    -html    "cols 70 rows 3 $readonly_fld {} class form_element" \
    -optional

element create $form_name saldo_manu       -widget hidden -datatype text -optional
element create $form_name cod_portafoglio  -widget hidden -datatype text -optional

element create $form_name funzione  -widget hidden -datatype text -optional
element create $form_name caller    -widget hidden -datatype text -optional
element create $form_name nome_funz -widget hidden -datatype text -optional
element create $form_name extra_par -widget hidden -datatype text -optional
element create $form_name submit    -widget submit -datatype text -label "$button_label" -html "class form_submit"
element create $form_name cod_manutentore  -widget hidden -datatype text -optional

if {[form is_request $form_name]} {

    element set_properties $form_name funzione  -value $funzione
    element set_properties $form_name caller    -value $caller
    element set_properties $form_name nome_funz -value $nome_funz
    element set_properties $form_name extra_par -value $extra_par

}

if {[form is_valid $form_name]} {
  # form valido dal punto di vista del templating system

    set cognome_manu     [string trim [element::get_value $form_name cognome_manu]]
    regsub -all "!" $cognome_manu "'" cognome_manu
    set nome_manu        [string trim [element::get_value $form_name nome_manu]]
    set amount           [string trim [element::get_value $form_name amount]]
    set description      [string trim [element::get_value $form_name description]]
    set cod_portafoglio  [string trim [element::get_value $form_name cod_portafoglio]]
    set payment_date     [string trim [element::get_value $form_name payment_date]]
    set cod_manutentore  [string trim [element::get_value $form_name cod_manutentore]]

    # controlli standard su numeri e date, per Ins ed Upd
    set error_num 0
    
    if {![db_0or1row q "select wallet_id 
                         from coimmanu
                        where cod_manutentore=:cod_manutentore
                          and wallet_id is not null"]} {
	element::set_error $form_name cognome_manu "Nessun portafoglio associato al manutentore"
	incr error_num
    }

    if {[string equal $amount ""]} {
	element::set_error $form_name amount "Inserire l'importo"
	incr error_num
    } else {
        set amount [iter_check_num $amount 2]
        if {$amount == "Error"} {
            element::set_error $form_name amount "Deve essere numerico, max 2 dec"
            incr error_num
	}
    }
    if {[string equal $payment_date ""]} {
            element::set_error $form_name payment_date "Inserire data versamento"
            incr error_num
    } else {
	set payment_date [iter_check_date $payment_date]
	if {$payment_date == 0} {
                element::set_error $form_name payment_date "Data versamento deve essere una data"
                incr error_num
	}
    }

    if {[string equal $description ""]} {
	element::set_error $form_name description "Inserire estremi del versamento"
	incr error_num
    }


    if {$error_num > 0} {
        ad_return_template
        return
    }

    set payment_date [db_string q "select :payment_date::date"]  

    set reference ""
    set oggi [db_string sel_date "select current_date"]
    set url "lotto/itermove?iter_code=$cod_manutentore&body_id=&tran_type_id=1&payment_type=1&payment_date=$payment_date&reference=$reference&description=$description&amount=$amount"

    set data [iter_httpget_wallet $url]
    array set result $data
    
    set risultato [string range $result(page) 0 [expr [string first " " $result(page)] - 1]]
    if {$risultato == "OK"} {
	set transaz_eff "T"
    } else {
	ns_log Notice "transactions-gest;result(page):$result(page)"
	element::set_error $form_name cognome_manu "ATTENZIONE transazione non avvenuta correttamente"
	ad_return_template
	return
    }
       
set return_url "transactions?nome_funz=transactions"

ad_returnredirect $return_url
ad_script_abort
}

ad_return_template
