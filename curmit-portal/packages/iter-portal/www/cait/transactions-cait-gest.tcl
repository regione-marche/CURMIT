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
    gab01 26/10/2016 Cambiata la tendina del manutentore in uno zoom

    sim01 12/10/2016 Corretto il link ritorna e il redirect

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

if {![db_0or1row check_maint "select 1 from iter_cait where cait_id = :user_id"]} {
    ad_returnredirect -message "Spiacente, ma questa pagina è riservata ai CAIT registrati." /
    ad_script_abort
}

# controllo il parametro di "propagazione" per la navigation bar
if {[string is space $nome_funz_caller]} {
    set nome_funz_caller $nome_funz
}

set saldo_cait [db_string query "
    select coalesce(
             sum(
               case 
                 when t.sign = '+' then amount
                 else amount * -1
               end), 0.00)
    from wal_recharge_cait m, wal_transaction_types t
    where m.tran_type_id = t.tran_type_id
      and m.cait_id=:user_id"] 

set saldo_cait_pretty [ah::edit_num $saldo_cait]

set link_gest [export_url_vars nome_funz nome_funz_caller caller f_maintainer_id f_name f_wallet_id body_id from_date to_date f_status f_description];#sim01
              
set return_url "transactions-cait?$link_gest";#sim01

set button_label "Conferma Inserimento"
set page_title   "Inserimento movimento"
set context [list  "$page_title"]

# sproteggo la chiave solo in inserimento e gli attributi in inserimento e mod.
set form_name    "transactions"
set readonly_key "readonly"
set readonly_fld "readonly"
set disabled_fld "disabled"
set onsubmit_cmd ""

form create $form_name \
-html    $onsubmit_cmd

#gab01 la tendina diventa uno zoom
#set l_of_l_manu [db_list_of_lists query "select name, iter_code from iter_maintainers order by name"]
#set l_of_l_manu [linsert $l_of_l_manu 0 [list "" ""]]


#gab01
#element create $form_name cognome_manu \
#    -label   "Manutentore" \
#    -widget   select \
#    -datatype text \
#    -options $l_of_l_manu\
#    -optional

#gab01
element create $form_name cognome_manu \
    -label   "Manutentore" \
    -widget   text \
    -datatype text \
    -html    "size 35 maxlength 200 class form_element" \
    -optional


#gab01
set cerca_manu [iter_search $form_name [ad_conn package_url]/cait/maintainers-list [list search_name cognome_manu ]]

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

    set cognome_manu     [element::get_value $form_name cognome_manu]
    set cod_manutentore  [element::get_value $form_name cod_manutentore] ;#gab01
    set amount           [string trim [element::get_value $form_name amount]]
    set description      [string trim [element::get_value $form_name description]]
    set cod_portafoglio  [string trim [element::get_value $form_name cod_portafoglio]]
    set payment_date     [string trim [element::get_value $form_name payment_date]]
    #set cod_manutentore  ""

    #gab01 il cod_manutentore lo ricevo dallo zoom
    #set cod_manutentore $cognome_manu

    # controlli standard su numeri e date, per Ins ed Upd
    set error_num 0

    #sim if {![db_0or1row query "select iter_code as cod_manutentore
    #sim                          from iter_maintainers
    #sim                         where name = upper(:cognome_manu)"]} {  ;#sim }
    if {$cod_manutentore eq ""} {
	
	element::set_error $form_name cognome_manu "Soggetto non trovato"
	incr error_num
	
    } else {
    
	if {![db_0or1row q "select wallet_id 
                              from wal_holders
                             where 'MA' || lpad(cast(holder_id as varchar(10)),6,0) =:cod_manutentore
                               and wallet_id is not null"]} {
	    element::set_error $form_name cognome_manu "Nessun portafoglio associato al manutentore $cod_manutentore"
	    incr error_num
	}
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

    #qui controllo che i soldi a disposizione del cait permettano la ricarica al manutentore
    
    if {$saldo_cait < $amount} {
	element::set_error $form_name description "Il saldo del CAIT è insufficente per eseguire l'operazione"
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

    set url "lotto/itermove-cait?iter_code=$cod_manutentore&body_id=&tran_type_id=1&payment_type=1&payment_date=$payment_date&reference=$reference&$link_description&amount=$amount&cait_id=$user_id"

    set data [iter_httpget_wallet $url]

    array set result $data
    
    set risultato [string range $result(page) 0 [expr [string first " " $result(page)] - 1]]
    if {$risultato == "OK"} {
	set transaz_eff "T"
    } else {
	element::set_error $form_name cognome_manu "ATTENZIONE transazione non avvenuta correttamente"
	ad_return_template
	return
    }

ad_returnredirect $return_url
ad_script_abort
}

ad_return_template
