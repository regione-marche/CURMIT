ad_page_contract {
    Add/Edit/Delete                                   
    @author          Gabriele Lo Vaglio   
    @creation-date   22/06/2017

    @param funzione  I=insert M=edit D=delete V=view
    @param caller    caller della lista da restituire alla lista:
                     serve se lista e' uno zoom che permetti aggiungi.
    @param nome_funz identifica l'entrata di menu, server per le autorizzazioni
                     serve se lista e' uno zoom che permetti aggiungi.
    @param extra_par Variabili extra da restituire alla lista
    @cvs-id          recharge-cait-gest.tcl


    USER  DATA       MODIFICHE
    ===== ========== =======================================================================
} {
    
   {funzione  "I"}
   {caller    "index"}
   {nome_funz ""}
   {nome_funz_caller ""}
   {extra_par ""}
   {url_manu      ""}
   {f_maintainer_id  ""}
   {f_name ""}
   {f_wallet_id ""}
   body_id:optional
   {from_date      ""}
   {to_date        ""}
   {from_date_ansi ""}
   {to_date_ansi   ""}
   {f_status       ""}
   {f_description  ""}
}

set user_id    [auth::require_login]
set package_id [ad_conn package_id]


# controllo il parametro di "propagazione" per la navigation bar
if {[string is space $nome_funz_caller]} {
    set nome_funz_caller $nome_funz
}


set link_gest [export_url_vars nome_funz nome_funz_caller caller f_maintainer_id f_name f_wallet_id body_id from_date to_date f_status f_description]
              
set return_url "recharge-cait?$link_gest"

set button_label "Conferma Inserimento"
set page_title   "Ricarica CAIT"
set context [list  "$page_title"]

# sproteggo la chiave solo in inserimento e gli attributi in inserimento e mod.
set form_name    "recharge-cait"
set readonly_key "readonly"
set readonly_fld "readonly"
set disabled_fld "disabled"
set onsubmit_cmd ""

form create $form_name \
-html    $onsubmit_cmd

# anche se è presente un solo cait al momento mostro una tendina che potrà essere utile in futuro
set l_of_l_cait [db_list_of_lists query "select name, cait_id from iter_cait order by name"]

element create $form_name cait_name \
    -label   "Cait" \
    -widget   select \
    -datatype text \
    -options $l_of_l_cait\
    -optional

element create $form_name amount \
    -label "Importo" \
    -widget text \
    -datatype text \
    -html    "size 10 maxlength 10 class form_element" \
    -optional

element create $form_name payment_date \
    -label "Data versamento" \
    -widget text \
    -datatype text \
    -html    "size 10 maxlength 10 class form_element" \
    -optional

element create $form_name description \
    -label   "Estremi del Versamento" \
    -widget   textarea \
    -datatype text \
    -html    "cols 70 rows 3 class form_element" \
    -optional



element create $form_name funzione  -widget hidden -datatype text -optional
element create $form_name caller    -widget hidden -datatype text -optional
element create $form_name nome_funz -widget hidden -datatype text -optional
element create $form_name extra_par -widget hidden -datatype text -optional
element create $form_name submit    -widget submit -datatype text -label "$button_label" -html "class form_submit"
element create $form_name cait_id   -widget hidden -datatype text -optional

if {[form is_request $form_name]} {

    element set_properties $form_name funzione  -value $funzione
    element set_properties $form_name caller    -value $caller
    element set_properties $form_name nome_funz -value $nome_funz
    element set_properties $form_name extra_par -value $extra_par

}

if {[form is_valid $form_name]} {
  # form valido dal punto di vista del templating system

    set cait_name        [element::get_value $form_name cait_name]
    set amount           [string trim [element::get_value $form_name amount]]
    set description      [string trim [element::get_value $form_name description]]
    set payment_date     [string trim [element::get_value $form_name payment_date]]

    set cait_id $cait_name

    # controlli standard su numeri e date, per Ins ed Upd
    set error_num 0

    if {$cait_id eq ""} {
	
	element::set_error $form_name cait_name "Cait non trovato"
	incr error_num
	
    }

    if {[string equal $amount ""]} {
	element::set_error $form_name amount "Inserire l'importo"
	incr error_num
    } else {
        set amount [iter_check_num $amount 2]
        if {$amount == "Error"} {
            element::set_error $form_name amount "Deve essere numerico, max 2 decimali"
            incr error_num
	}
	if {$amount ==0} {
            element::set_error $form_name amount "Inserire l'importo"
            incr error_num
        }
    }
    if {[string equal $payment_date ""]} {
            element::set_error $form_name payment_date "Inserire data ricarica"
            incr error_num
    } else {
	set payment_date [iter_check_date $payment_date]
	if {$payment_date == 0} {
                element::set_error $form_name payment_date "Data ricarica deve essere una data"
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

    set link_description [export_vars {description}]    

    set url "lotto/itermove-recharge-cait?cait_id=$cait_id&tran_type_id=1&payment_type=1&payment_date=$payment_date&reference=$reference&$link_description&amount=$amount"
    ns_log notice "simone url=$url"
    set data [iter_httpget_wallet $url]

    array set result $data
    
    set risultato $result(page)
    
    if {$risultato == "OK"} {
	set transaz_eff "T"
    } else {
	element::set_error $form_name cait_name "ATTENZIONE transazione non avvenuta correttamente"
	ad_return_template
	return
    }

ad_returnredirect $return_url
ad_script_abort
}

ad_return_template
