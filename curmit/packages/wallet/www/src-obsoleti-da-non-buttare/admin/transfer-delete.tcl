ad_page_contract {
    Cancella logicamente un bonifico, impostandone lo stato a 'D'.

    @author Claudio Pasolini
    @cvs-id transfer-delete.tcl
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
	ad_returnredirect -message "Possono essere annullati solo i bonifici in stato 'L' o 'P'." "transfers-list?$url_vars"
	ad_script_abort
    }
}

db_transaction {

    db_dml change_status "
        update wal_transfers set 
            status = 'D' 
        where transfer_id in ([join $transfer_id ,])"
    
}

ad_returnredirect -message "I bonifici indicati sono stati annullati." "transfers-list?$url_vars"

ad_script_abort
