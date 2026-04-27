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
    sim00 08/05/2018 Programma clonato da transactions-gest.tcl che oltre a caricare il movimento
    sim00            sul portafoglio del portale, si connette con MPAY per permettere il pagamento
    sim00            tramite PAGOPa.
} {
   
   {f_ente_portafoglio ""}
   {funzione  "I"}
   {caller    "index"}
   {nome_funz ""}
   {nome_funz_caller ""}
   {extra_par ""}
   {url_manu      ""}
}

set user_id    [auth::require_login]
set package_id [ad_conn package_id]

set maintainer_id [iter::script_init]
if {[string equal $maintainer_id "0"]} {
    ad_returnredirect services
}

set sw_multi_portafoglio [parameter::get_from_package_key -package_key wallet -parameter sw_multi_portafoglio -default 0];#gab01

if {$sw_multi_portafoglio} {;#gab01 aggiunta if, else e contenuto
    
    set where_controlli_multiportafoglio   "and instance_name = :f_ente_portafoglio"

    if {![db_0or1row q "select g.group_name as nome_ente_portafoglio
                          from groups g
                             , iter_instances i
                         where g.group_id = i.instance_id
                           and i.instance_name = :f_ente_portafoglio"]} {

        ad_returnredirect -message "ATTENZIONE! E' necessario selezionare un ente portafoglio" "ec-filter?maintainer_id=$maintainer_id"
        ad_script_abort

    }

    set mess_err_multiportafoglio "per l'ente: $nome_ente_portafoglio"
} else {
    set where_controlli_multiportafoglio   ""
    set nome_ente_portafoglio              ""
    set mess_err_multiportafoglio          ""
}

# controllo il parametro di "propagazione" per la navigation bar
if {[string is space $nome_funz_caller]} {
    set nome_funz_caller $nome_funz
}

set button_label "Avvia MPay"
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

set l_of_l_manu [db_list_of_lists query "select name
                                              , iter_code 
                                           from iter_maintainers 
                                          where maintainer_id = :maintainer_id"]

set payment_date [db_string q "select to_char(current_date,'DD/MM/YYYY')"];#sim02

element create $form_name cognome_manu \
    -label   "Manutentore" \
    -widget   select \
    -datatype text \
    -html     "display {}" \
    -options  $l_of_l_manu \
    -optional

element create $form_name amount \
    -label "Importo" \
    -widget text \
    -datatype text \
    -html    "size 10 maxlength 10 class form_element" \
    -optional

#sim02 aggiunto value e cambiato widget da text a inform
element create $form_name payment_date \
    -label "Data versamento" \
    -widget inform \
    -datatype text \
    -html    "size 10 maxlength 10 class form_element" \
    -value $payment_date \
    -optional

element create $form_name saldo_manu       -widget hidden -datatype text -optional
element create $form_name cod_portafoglio  -widget hidden -datatype text -optional

element create $form_name funzione  -widget hidden -datatype text -optional
element create $form_name caller    -widget hidden -datatype text -optional
element create $form_name nome_funz -widget hidden -datatype text -optional
element create $form_name extra_par -widget hidden -datatype text -optional
element create $form_name submit    -widget submit -datatype text -label "$button_label" -html "class form_submit"
element create $form_name cod_manutentore  -widget hidden -datatype text -optional
element create $form_name f_ente_portafoglio  -widget hidden -datatype text -optional

if {[form is_request $form_name]} {

    element set_properties $form_name funzione  -value $funzione
    element set_properties $form_name caller    -value $caller
    element set_properties $form_name nome_funz -value $nome_funz
    element set_properties $form_name extra_par -value $extra_par
    element set_properties $form_name f_ente_portafoglio  -value $f_ente_portafoglio

}

if {[form is_valid $form_name]} {
  # form valido dal punto di vista del templating system

    set cognome_manu           [element::get_value $form_name cognome_manu]
    set amount                 [string trim [element::get_value $form_name amount]]
    #set description           [string trim [element::get_value $form_name description]]
    set cod_portafoglio        [string trim [element::get_value $form_name cod_portafoglio]]
    set payment_date           [string trim [element::get_value $form_name payment_date]]
    set f_ente_portafoglio     [element::get_value $form_name f_ente_portafoglio];#gab01

    set cod_manutentore $cognome_manu

    # controlli standard su numeri e date, per Ins ed Upd
    set error_num 0

    if {$cod_manutentore eq ""} {
	
	element::set_error $form_name cognome_manu "Soggetto non trovato"
	incr error_num
	
    } else {
    
	if {![db_0or1row q "select wallet_id 
                              from wal_holders
                             where 'MA' || lpad(cast(holder_id as varchar(10)),6,0) =:cod_manutentore
                               $where_controlli_multiportafoglio --gab01
                               and wallet_id is not null"]} {
	    element::set_error $form_name cognome_manu "Nessun portafoglio associato al manutentore $cod_manutentore $mess_err_multiportafoglio"
	    incr error_num
	}
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

    if {[db_0or1row q "select 1 
                         from wal_transactions
                        where 'MA' || lpad(cast(holder_id as varchar(10)),6,0) = :cod_manutentore
                          and status = 'L'
                          $where_controlli_multiportafoglio --gab01
                        limit 1"]} {

	element::set_error $form_name cognome_manu "Esiste già un versamento in lavorazione per questo manutentore $mess_err_multiportafoglio"
#	incr error_num

    }

    if {[db_0or1row q "select 1 
                         from mpay_paymentrequest 
                        where maintainer_id = :maintainer_id 
                          and data_invio_richiesta > (current_timestamp - interval '20 second') limit 1"]} {

	element::set_error $form_name cognome_manu "Attenzione: è già stato premuto il pulsante Avvia Mpay. Per procedere attendi 20 secondi e poi clicca nuovamente"
	incr error_num
	
    }

    if {$error_num > 0} {
        ad_return_template
        return
    }

    set payment_date [db_string q "select :payment_date::date"]  

    set reference ""
    set oggi [db_string sel_date "select current_date"]

    set description "Ricarica portafoglio"
    set link_description [export_vars {description}]    

    set end_point    "http://payertest.regione.marche.it/mpay/cart/extS2SRID.do" ;#server di test
    set redirect_url "http://payertest.regione.marche.it/mpay/cart/extCart.do"   ;#server di test 
    set portaleid                     "PortaleMARBOL"
    set funzione                      "PAGAMENTO"

    # Leggo dinamicamente il parametro del kernel SystemURL che viene impostato da
    # /admin/site-map Kernel
    # Dovrebbe contenere, ad esempio https://portal.marche.iter-web.it
    set SystemURL                     [parameter::get_from_package_key -package_key acs-kernel -parameter SystemURL -default ""]


#    set SystemURL_notifica  "http://curmitmarbol.regionemarche.intra"
    
#    set SystemURL_notifica "http://10.101.11.106:8011/"

#    set SystemURL_notifica $SystemURL
    set urldiritorno                  "$SystemURL/wallet/MPAY/verifica_pagamento"
    set urldinotifica                 "$SystemURL/wallet/MPAY/notifica_pagamento"


    set urldinotifica "http://portale-curmit.regione.marche.it/wallet/MPAY/notifica_pagamento"
    set urldiritorno  "https://portale-curmit.regione.marche.it/wallet/MPAY/verifica_pagamento"

    set urldinotifica "http://portale-curmit-test.regione.marche.it/wallet/MPAY/notifica_pagamento";#solo per test
    set urldiritorno  "https://portale-curmit-test.regione.marche.it/wallet/MPAY/verifica_pagamento";#solo per test

    
    set urlback                       "$SystemURL/iter-portal/ec?maintainer_id=$maintainer_id&f_ente_portafoglio=$f_ente_portafoglio"
    set commitnotifica                "S"
    

    db_1row q "select codiceutente
                    , codiceente
                    , tipoufficio
                    , codiceufficio
                    , tipologiaservizio
                    , datispecifici
                 from mpay_enti_destinatari
                where instance_name = :f_ente_portafoglio"

    db_1row q "select codiceutente      as codiceutente_reg
                    , codiceente        as codiceente_reg
                    , tipoufficio       as tipoufficio_reg
                    , codiceufficio     as codiceufficio_reg
                    , tipologiaservizio as tipologiaservizio_reg
                    , perc_regione
                    , datispecifici     as datispecifici_reg
                 from mpay_enti_destinatari
                where flag_regione = true"

    set tag_datispecifici     ""
    set tag_datispecifici_reg ""
    
    if {$datispecifici ne ""} {
	set tag_datispecifici "<DatiSpecifici>$datispecifici</DatiSpecifici>"
    } 

    if {$datispecifici_reg ne ""} {
	set tag_datispecifici_reg "<DatiSpecifici>$datispecifici_reg</DatiSpecifici>"
    } 

    #per ora come test uso la Sede della Regione Marche
    set valuta                        "EUR"
    
    db_1row get_numerooperazione "select nextval('mpay_paymentrequest_s') as numerooperazione"
    set numerodocumento               $numerooperazione
    set numerodocumento_reg           $numerooperazione

    db_1row a "select email as emailutente
                    , coalesce(fiscal_code,iva_code) as identificativoutente 
                 from iter_maintainers
                where maintainer_id=:user_id"


    set emailutente "sferrari@oasisoftware.it";#SOLO PER TEST

    set importo_tot [db_string a "select :amount::numeric(18,2)"]

    set importo_reg [expr $importo_tot * $perc_regione / 100.00]

    set importo     [expr $importo_tot - $importo_reg]

    set importo_reg [db_string a "select :importo_reg::numeric(18,2)"]
    set importo     [db_string a "select :importo::numeric(18,2)"]

    set importo_tot [regsub -all "\\." $importo_tot ""]
    set importo_reg [regsub -all "\\." $importo_reg ""]
    set importo     [regsub -all "\\." $importo ""]

    set oggi [iter_set_sysdate]
    set annodocumento [string range $oggi 0 3]

    set annodocumento_reg $annodocumento

    set code        [template::adp_compile -file [ah::service_root]/packages/wallet/www/MPAY/paymentrequest.xml]
    set xml_request [template::adp_eval code]
    
    
    set xml_request [regsub -all \r $xml_request ""]
    set xml_request [regsub -all \n $xml_request ""]
    
    set caller "$numerooperazione-MPAY_transactions-gest" 
    
    set buffer [MPAY_crea_buffer $xml_request]

    db_dml q "insert into mpay_paymentrequest
                  ( portaleid               
                  , funzione                
                  , urldiritorno
                  , urldinotifica
                  , urlback
                  , commitnotifica
                  , emailutente
                  , identificativoutente
                  , codiceutente
                  , codiceente
                  , tipoufficio
                  , codiceufficio
                  , tipologiaservizio
                  , numerooperazione
                  , numerodocumento
                  , annodocumento
                  , valuta
                  , importo
                  , datispecifici
                  , codiceutente_reg
                  , codiceente_reg
                  , tipoufficio_reg
                  , codiceufficio_reg
                  , tipologiaservizio_reg
                  , numerodocumento_reg
                  , annodocumento_reg
                  , importo_reg
                  , datispecifici_reg
                  , id_utente           
                  , data_invio_richiesta
                  , bufferdati_richiesta
                  , buffer_richiesta
                  , stato
                  , maintainer_id
                  , ente_portafoglio
                  )
                  values (:portaleid               
                  , :funzione                
                  , :urldiritorno
                  , :urldinotifica
                  , :urlback
                  , :commitnotifica
                  , :emailutente
                  , :identificativoutente
                  , :codiceutente
                  , :codiceente
                  , :tipoufficio
                  , :codiceufficio
                  , :tipologiaservizio
                  , :numerooperazione
                  , :numerodocumento
                  , :annodocumento
                  , :valuta
                  , :importo
                  , :datispecifici
                  , :codiceutente_reg
                  , :codiceente_reg
                  , :tipoufficio_reg
                  , :codiceufficio_reg
                  , :tipologiaservizio_reg
                  , :numerodocumento_reg
                  , :annodocumento_reg
                  , :importo_reg
                  , :datispecifici_reg
                  , :user_id           
                  , current_timestamp
                  , :xml_request
                  , :buffer
                  , 'INSERITO'
                  , :maintainer_id
                  , :f_ente_portafoglio
                 
)"
   
    set path_file_response [MPAY_call_ws $buffer $end_point $caller $xml_request]
    
    if {![file exists $path_file_response]} {
	ns_log Notice "invoke;call_payment_request;Non e' stata ottenuta una risposta dal web service $end_point, richiamato con xml di input: $xml_request, trace: $trace"
	
	ns_return 200 text/html "invoke;call_payment_request;Non e' stata ottenuta una risposta dal web service $end_point, richiamato con xml di input: $xml_request, trace: $trace"
	
    } else {
	
	# leggo la risposta
	set file_id      [open $path_file_response r]
	fconfigure       $file_id -encoding utf-8
	set xml_response [read $file_id]
	close            $file_id
	
	db_dml q "update mpay_paymentrequest
                     set data_ricezione_pid = current_timestamp
                       , responce_pid       = :xml_response
                       , stato              = 'RICHIESTO'
                   where numerooperazione   = :numerooperazione"

	if {$xml_response ne "error"} {
	    
	    set buffer_response [MPAY_crea_buffer $xml_response]
	    
	    set url_redirect "$redirect_url?buffer=$buffer_response"
#	    ns_returnredirect $url_redirect

	    exec rm $path_file_response
	    exec rm [acs_root_dir]/packages/wallet/www/MPAY/log/$caller-input.xml
	    exec rm [acs_root_dir]/packages/wallet/www/MPAY/log/$caller-paymentrequest.xml
	    exec rm [acs_root_dir]/packages/wallet/www/MPAY/log/$caller-trace.txt
	    ad_returnredirect -allow_complete_url $url_redirect
	    
	} else {
	    
	    ns_log Notice "invoke;call_payment_request;step15;xml_response:$xml_response"
	    
	    ns_return 200 text/xml $xml_response
	    
	}
	
    }
    

     
 #   set return_url "ec?maintainer_id=$maintainer_id&f_ente_portafoglio=$f_ente_portafoglio"

#ad_returnredirect $return_url
#ad_script_abort
}
ad_return_template
