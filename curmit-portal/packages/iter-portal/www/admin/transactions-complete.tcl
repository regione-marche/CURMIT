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
    ===== ========== ==============================================================================================
    gab02 10/04/2018 Ricevo il parametro f_ente_portafoglio per l'eventuale gestione del multiportafoglio

    gab01 09/11/2016 Per il portale delle provincia di Reggio Calabria devo poter inserire il num_ordine o il cro.
    gab01            Per gli altri enti i dati della reversale o il cro.

} {
    
   {funzione  "I"}
   {caller    "index"}
   {nome_funz ""}
   {nome_funz_caller ""}
   {extra_par ""}
   {url_manu      ""}
   tran_id
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
   {f_ente_portafoglio ""}
}

set user_id    [auth::require_login]
set package_id [ad_conn package_id]

set extra_par [export_url_vars nome_funz nome_funz_caller caller f_maintainer_id f_name f_wallet_id body_id from_date to_date f_status f_description f_ente_portafoglio];#gab02 aggiunto f_ente_portafoglio

set database [db_get_database];#gab01
#set database "iter-portal-prrc"
       
# controllo il parametro di "propagazione" per la navigation bar
if {[string is space $nome_funz_caller]} {
    set nome_funz_caller $nome_funz
}


db_1row q "select * 
             from wal_transactions 
            where tran_id=:tran_id"

set button_label "Completa Accredito"
set page_title   "Completa movimento"
set context [list  "$page_title"]

# sproteggo la chiave solo in inserimento e gli attributi in inserimento e mod.
set form_name    "transactions"
set readonly_key "readonly"
set readonly_fld "readonly"
set disabled_fld "disabled"
set onsubmit_cmd ""

form create $form_name \
-html    $onsubmit_cmd

element create $form_name num_reversale \
    -label   "Numero reversale" \
    -widget   text \
    -datatype text \
    -html    "size 10 maxlength 10 class form_element" \
    -optional

element create $form_name anno_reversale \
    -label    "Anno reversale" \
    -widget   text \
    -datatype text \
    -html    "size 10 maxlength 10 class form_element" \
    -optional

#gab01 aggiunto num_ordine
element create $form_name num_ordine \
    -label    "Num. Ordine" \
    -widget   text \
    -datatype text \
    -html     "size 10 maxlength 10 class form_element" \
    -optional


element create $form_name tran_id          -widget hidden -datatype text -optional

element create $form_name funzione  -widget hidden -datatype text -optional
element create $form_name caller    -widget hidden -datatype text -optional
element create $form_name nome_funz -widget hidden -datatype text -optional
element create $form_name extra_par -widget hidden -datatype text -optional
element create $form_name submit    -widget submit -datatype text -label "$button_label" -html "class form_submit"

if {[form is_request $form_name]} {

    element set_properties $form_name tran_id   -value $tran_id
    element set_properties $form_name funzione  -value $funzione
    element set_properties $form_name caller    -value $caller
    element set_properties $form_name nome_funz -value $nome_funz
    element set_properties $form_name extra_par -value $extra_par
    element set_properties $form_name num_reversale  -value $num_reversale
    element set_properties $form_name anno_reversale -value $anno_reversale
    element set_properties $form_name num_ordine -value $num_ordine;#gab01

}

if {[form is_valid $form_name]} {
  # form valido dal punto di vista del templating system
    set tran_id          [element::get_value $form_name tran_id]
    set num_reversale    [element::get_value $form_name num_reversale]
    set anno_reversale   [element::get_value $form_name anno_reversale]
    set num_ordine       [element::get_value $form_name num_ordine];#gab01
    set extra_par        [element::get_value $form_name extra_par]

    # controlli standard su numeri e date, per Ins ed Upd
    set error_num 0

    if {$anno_reversale ne ""} {
	set anno_reversale [iter_check_num $anno_reversale 0]
	if {$anno_reversale == "Error"} {
	    element::set_error $form_name anno_reversale "Deve essere numerico"
	    incr error_num
	}
    }

    if {$num_reversale ne "" && $anno_reversale eq ""} {
	element::set_error $form_name anno_reversale "Oltre al numero reversale è necessario inserire l'anno"
	incr error_num
    }

    if {$anno_reversale ne "" && $num_reversale eq ""} {
	element::set_error $form_name num_reversale "Oltre all'anno reversale è necessario inserire il numero"
	incr error_num
    }

    if {$error_num > 0} {
        ad_return_template
        return
    }

    #aggiorno lo stato e salvo i dati

    db_dml q "update wal_transactions
                 set num_reversale  = :num_reversale
                   , anno_reversale = :anno_reversale
                   , num_ordine     = :num_ordine --gab01
               where tran_id        = :tran_id"

    set return_url "transactions?$extra_par"

    ad_returnredirect $return_url
    ad_script_abort
}

ad_return_template
