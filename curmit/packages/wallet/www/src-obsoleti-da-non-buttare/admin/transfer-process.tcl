ad_page_contract {
    Elabora un bonifico in stato 'L' o 'P'.

    @author Claudio Pasolini
    @cvs-id transfer-process.tcl
} {
    {transfer_id:multiple ""}
}

ad_script_abort

ah::key_selected_p -key $transfer_id

set url_vars [ad_get_client_property -default "" wallet admin/transfers-list]

foreach transfer $transfer_id {
    # controllo che lo status sia valido 
    set status [db_string check "select status from wal_transfers where transfer_id = :transfer"]
    if {$status eq "L" || $status eq "P"} {
    } else {
	ad_returnredirect -message "Possono essere elaborati solo i bonifici in stato 'L' o 'P'." "transfers-list?$url_vars"
	ad_script_abort
    }
}

db_transaction {

    wal::transfers_process -transfer_ids $transfer_id
    
}

ad_returnredirect -message "I bonifici indicati sono stati elaborati." "transfers-list?$url_vars"

ad_script_abort
