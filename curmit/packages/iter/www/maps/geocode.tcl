ad_page_contract {
    Esegue il geocoding di una posizione.

    @author Claudio Pasolini
    @cvs-id $Id: geocode.tcl
} {
    cod_impianto
    name
    address
}

# tento di trovare le coordinate tramite l'indirizzo
set response [maps::create_or_replace_position \
		  -position_id    $cod_impianto \
		  -name           $name \
		  -address        $address \
		 ]

util_unlist $response position_id status

if {$status eq "OK"} {
    ad_returnredirect -html -message "L'indirizzo è stato georeferenziato. Se vuoi puoi visualizzare la <a href=\"one-position?cod_impianto=$cod_impianto\">mappa</a>" list
} else {
    ad_returnredirect -message "Impossibile visualizzare la mappa. Si è verificato l'errore: $status" [export_vars -base /iter/src/coimaimp-gest {cod_impianto}]
}

ad_script_abort



