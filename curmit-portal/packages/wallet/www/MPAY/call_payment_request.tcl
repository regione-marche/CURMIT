ad_page_contract {  
 
    Web Service che invia la richiesta a MPAY. 

    Il programma NON dispone di UI e deve essere chiamato via httpget dal 
    cliente del servizio. 

    Il programma serve per mandare la richiesta di pagamento a MPAY 

    @author Simone Pesci

    @cvs-id call_payment_request.tcl 

    @param 

} {
 
}

set end_point    "http://payertest.regione.marche.it/mpay/cart/extS2SRID.do" ;#server di test


set redirect_url "http://payertest.regione.marche.it/mpay/cart/extCart.do"   ;#server di test

#futuro_server_di_prog  set end_point   "http://mpay.regione.marche.it/cart/extS2SRID.do"



#per il momento cablo i valori del xml. Più avanti li gestirò correttamente
set portaleid                     "PortaleMARBOL"
set funzione                      "PAGAMENTO"
set urldiritorno                  "https://portal-marche.iter-web.it/wallet/MPAY/verifica_pagamento"
set urldinotifica                 "https://portal-marche.iter-web.it/wallet/MPAY/notifica_pagamento"
set urlback                       "https://portal-marche.iter-web.it/wallet/MPAY/back.tcl"
set commitnotifica                "S"
set codiceutente                  "000RM"
#per ora come test uso la Sede della Regione Marche
set codiceente                    "12784"  ;#da capire come valorizzare
#rom01set tipoufficio                   "C"  ;#da capire come valorizzare
set tipoufficio                   "R"  ;#rom01
#rom01set codiceufficio                 "1"  ;#da capire come valorizzare
set codiceufficio                 ""  ;#rom01
set tipologiaservizio             "BOL"
set valuta                        "EUR"
set identificativo                "IC1"
set causale                       "RICARICA PORTAFOGLIO"

set emailutente                   "spesci@oasisoftware.it" ;#diventerà una variabile
set identificativoutente          "PPRPRN65R25A944" ;#diventerà una variabile
set numerooperazione              [randomRange 99999999] ;#diventerà una variabile




set numerodocumento               $numerooperazione
set annodocumento                 "2018" ;#diventerà una variabile
set importo                       "10000" ;#diventerà una variabile. Il valore è espresso in centesimi
set valore                        "10000" ;#diventerà una variabile. Il valore è espresso in centesimi
#set codiceenteportaleesterno_reg  "12784" ;#dovrà essere fornito dalla regione. Come prima ipotesi prendiamo il codice della regione Marche
#set descrenteportaleesterno_reg   "Regione Marche";#dovrà essere fornito dalla regione. Come prima ipotesi prendiamo il codice della regione
#set valore_reg                    "1000" ;#diventerà una variabile. Il valore è espresso in centesimi
#set codiceenteportaleesterno_ente "12138";#dovrà essere fornito dalla regione. Come prima ipotesi prendiamo il codice del comune di Ancona
#set descrenteportaleesterno_ente  "Comune di Ancona";#dovrà essere fornito dalla regione. Come prima ipotesi prendiamo il codice del comune di Ancona
#set valore_ente                   "9000" ;#diventerà una variabile. Il valore è espresso in centesimi

set code        [template::adp_compile -file [ah::service_root]/packages/wallet/www/MPAY/paymentrequest.xml]
set xml_request [template::adp_eval code]


set xml_request [regsub -all \r $xml_request ""]
set xml_request [regsub -all \n $xml_request ""]

set caller "test-invoke-call_payment_request" 

set buffer [MPAY_crea_buffer $xml_request]

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

    if {$xml_response ne "error"} {

	set buffer_response [MPAY_crea_buffer $xml_response]
	
	set url_redirect "$redirect_url?buffer=$buffer_response"

	ad_returnredirect -allow_complete_url $url_redirect
	
    } else {

	ns_log Notice "invoke;call_payment_request;step15;xml_response:$xml_response"

	ns_return 200 text/xml $xml_response
    
    }

}


return
