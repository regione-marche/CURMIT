ad_page_contract {
    Riceve il token da CohesionServlet.

    @author Claudio 
    @creation-date 20/10/2018

    @param token
} {
    {token ""}
}

ns_log Notice "claudio-login-2;token ricevuto:$token"

package require base64
set token_decodificato [::base64::decode $token]

ns_log Notice "claudio-login-2;token_decodificato:$token_decodificato"

#ns_return 200 text/plain "Ho ricevuto il token_decodificato:
#$token_decodificato"

# Devo solo recuperare il contenuto del tag codice_fiscale.
# Per semplicita' uso una regexp.

set codice_fiscale ""
set sw_trovato     [regexp {<codice_fiscale>(.*)</codice_fiscale>} $token_decodificato match codice_fiscale]

if {!$sw_trovato || [string is space $codice_fiscale]} {
    ns_return 200 text/html "Il token restituito da Cohesion non contiene il tag codice_fiscale"
} else {
    ns_return 200 text/html "Il token restituito da Cohesion contiene il seguente codice fiscale: |$codice_fiscale|"
}

ad_script_abort
