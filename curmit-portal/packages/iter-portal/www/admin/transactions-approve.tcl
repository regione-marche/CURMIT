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
    ===== ========== =============================================================================================
    but01 09/02/2024  aggiunto approve_user_id per vedere l'ultimo utente chi ha fatto l'accredito.

    gab02 10/04/2018 Ricevo il parametro f_ente_portafoglio per l'eventuale gestione del
    gab02            multiportafoglio

    sim02 04/10/2017 Allungato la combo del Numero Ordine

    gab01 09/11/2016 Per il portale delle provincia di Reggio Calabria devo poter inserire il num_ordine o il cro. 
    gab01            Per gli altri enti i dati della reversale o il cro.                 

    sim01 20/10/2016 Allungato la combo del CRO
    
} {
    
   {funzione  "I"}
   {caller    "index"}
   {nome_funz ""}
   {nome_funz_caller ""}
   {extra_par ""}
   {url_manu      ""}
   tran_id
   {accredita_p "t"}
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

if {$accredita_p eq "f"} {

     db_dml q "update wal_transactions
                 set status         = 'K'
               where tran_id        = :tran_id"
     
     set return_url "transactions?$extra_par";#gab02 return_url non era settato quindi andava in errore
     ad_returnredirect $return_url
     ad_script_abort

    
} 

db_1row q "select * from wal_transactions where tran_id=:tran_id"

set button_label "Conferma Accredito"
set page_title   "Accredito movimento"
set context [list  "$page_title"]

# sproteggo la chiave solo in inserimento e gli attributi in inserimento e mod.
set form_name    "transactions"
set readonly_key "readonly"
set readonly_fld "readonly"
set disabled_fld "disabled"
set onsubmit_cmd ""

form create $form_name \
-html    $onsubmit_cmd

set l_of_l_manu [db_list_of_lists query "select name, iter_code from iter_maintainers order by name"]
set l_of_l_manu [linsert $l_of_l_manu 0 [list "" ""]]

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

#sim01 passato da 10 a 40 caratteri
element create $form_name cro \
    -label    "CRO" \
    -widget   text \
    -datatype text \
    -html     "size 40 maxlength 40 class form_element" \
    -optional

#gab01 aggiunto num_ordine
#sim02 allungato da 10 a 40
element create $form_name num_ordine \
    -label    "Num. Ordine" \
    -widget   text \
    -datatype text \
    -html     "size 40 maxlength 40 class form_element" \
    -optional


element create $form_name tran_id          -widget hidden -datatype text -optional

element create $form_name funzione  -widget hidden -datatype text -optional
element create $form_name caller    -widget hidden -datatype text -optional
element create $form_name nome_funz -widget hidden -datatype text -optional
element create $form_name extra_par -widget hidden -datatype text -optional
element create $form_name submit    -widget submit -datatype text -label "$button_label" -html "class form_submit"

if {[form is_request $form_name]} {

    element set_properties $form_name cro       -value $cro
    element set_properties $form_name tran_id   -value $tran_id
    element set_properties $form_name funzione  -value $funzione
    element set_properties $form_name caller    -value $caller
    element set_properties $form_name nome_funz -value $nome_funz
    element set_properties $form_name extra_par -value $extra_par

}

if {[form is_valid $form_name]} {
  # form valido dal punto di vista del templating system

    set tran_id          [element::get_value $form_name tran_id]
    set num_reversale    [element::get_value $form_name num_reversale]
    set anno_reversale   [element::get_value $form_name anno_reversale]
    set cro              [element::get_value $form_name cro]
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
    
    if {$database eq "iter-portal-prrc"} {;#gab01 aggiunta if e suo contenuto
	set errormsg "Inserire il CRO oppure il numero ordine"
        set varerror "num_ordine"       
    } else {;#gab01 
	set errormsg "Inserire i dati della reversale o il CRO"
        set varerror "num_reversale"
    }

    if {$num_reversale eq "" && $anno_reversale eq "" && $cro eq "" && $num_ordine eq ""} {
	element::set_error $form_name $varerror $errormsg
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
                   , cro            = :cro
                   , num_ordine     = :num_ordine --gab01
                   , status         = 'A'
                   , currency_date  = current_date
                   , approve_user_id = :user_id --but01
               where tran_id        = :tran_id"

    set return_url "transactions?$extra_par"

    ad_returnredirect $return_url
    ad_script_abort
}

ad_return_template
