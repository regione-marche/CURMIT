ad_page_contract {

    Carica una tantum le forniture valide sulla tabella iter_distributors_supplies.

} {
}

# creo un array che associa al comune l'ente responsabile
db_foreach query "
    select upper(denominazione) as comune, body_id
    from iter_comuni" {
	set ente($comune) $body_id
    }

# apro un file temporaneo che utilizzerÅÚ
# per caricare la tabella iter_distributors_supplies con una singola operazione di 'copy'
set fname [ns_tmpnam]
set fd [open $fname w]

# creo lista delle forniture valide da caricare
set supplies [db_list_of_lists query "
    select a.object_id, a.item_id, to_char(o.creation_date, 'YYYY-MM-DD')
    from attachments a, acs_objects o
    where a.item_id    = o.object_id
      and a.approved_p = 't'
      and not exists (select 1 from iter_distributors_supplies 
                      where distributor_id = a.object_id
                        and supply_id      = a.item_id)"]

foreach supply $supplies {

    util_unlist $supply distributor_id supply_id supply_date

    
    # leggo il contenuto della fornitura
    set content [cr_write_content -string -item_id $supply_id]

    foreach line [split $content \n] {

	if {$line eq ""} {
	    continue
	}

	# estraggo tutti i campi
	set columns [split $line |]

	util_unlist $columns user_name topo_type topo_name number zip_code city istat phone user_fuel return_point consumption um_code  contract volume fiscal_code iva_code 

	if {$user_name eq "ragione sociale"} {
	    # scarto intestazione
	    continue
	}

	# trimmo i campi codificati
	set topo_type [string trimright $topo_type]
	set user_fuel [string trimright $user_fuel]
	set contract  [string trimright $contract]
	set city      [string trimright $city]
	set city      [string toupper   $city]

	# ottengo ente responsabile
	if {[info exists ente($city)]} {
	    set body_id $ente($city)
	} else {

	    ####################### ATTENZIONE #######################
	    # la tabella iter_comuni non ÅË ancora popolata e quindi
	    # per provare forzo il codice 9725 della prov. di Mantova
	    # e commento le righe seguenti
	    set body_id 9725
	    #set error_p 1
	    #append error_descr "Errore! Nome Comune non presente nell'anagrafica dei Comuni.<br>"
	    #set body_id ""
	    ####################### ATTENZIONE ####################### 
	}


        # scrivo file temporaneo
        puts $fd "$distributor_id|$supply_id|$supply_date|$body_id|$user_name|$topo_type|$topo_name|$number|$zip_code|$city|$istat|$phone|$user_fuel|$return_point|$consumption|$um_code|$contract|$volume|$fiscal_code|$iva_code"

    }
}

# chiudo file temporaneo
close $fd

db_transaction {

    db_dml copy "
         copy iter_distributors_supplies 
             from '$fname' 
             delimiter as '|'
             null      as ''"

}

# elimino file temporaneo
ns_unlink $fname


