ad_page_contract {
    Riceve il token da CohesionServlet.

    @author Nicola Mortoni
    @creation-date ottobre 2018

    @param token
} {
    {token ""}
}

ns_log Notice "login-cohesion-cittadino-2;token ricevuto:$token"

package require base64
set token_decodificato [::base64::decode $token]

ns_log Notice "login-cohesion-cittadino-2;token_decodificato:$token_decodificato"

#ns_return 200 text/plain "Ho ricevuto il token_decodificato:
#$token_decodificato"

# Devo solo recuperare il contenuto del tag codice_fiscale.
# Per semplicita' uso una regexp.

set codice_fiscale ""
set sw_trovato     [regexp {<codice_fiscale>(.*)</codice_fiscale>} $token_decodificato match codice_fiscale]

if {!$sw_trovato || [string is space $codice_fiscale]} {
    iter_return_complaint "Il token restituito dal Servizio di autenticazione Cohesion della Regione Marche non contiene il tag codice_fiscale."
    #la iter_return_complaint fa anche ad_script_abort
}


#ns_return 200 text/html "Il token restituito da Cohesion contiene il seguente codice fiscale: |$codice_fiscale|"
ns_log Notice "login-cohesion-cittadino-2;codice_fiscale:$codice_fiscale"

ad_set_client_property iter token_cohesion $token_decodificato

ad_returnredirect "/iter-portal/citizen-services"
ad_script_abort
