ad_page_contract {
    Ripristina un bonifico, riportandone lo stato a 'P'.

    @author Claudio Pasolini
    @cvs-id transfer-reset.tcl
} {
    {transfer_id:multiple ""}
}

ad_script_abort

ah::key_selected_p -key $transfer_id

set url_vars [ad_get_client_property -default "" wallet admin/transfers-list]

foreach transfer $transfer_id {
    # controllo che lo status sia valido 
    set status [db_string check "select status from wal_transfers where transfer_id = :transfer"]
    if {$status ne "D"} {
	ad_returnredirect -message "Possono essere ripristinati solo i bonifici in stato 'D'." "transfers-list?$url_vars"
	ad_script_abort
    }
}

db_transaction {

    db_dml change_status "
        update wal_transfers set 
            status = 'P' 
        where transfer_id in ([join $transfer_id ,])"
    
}

ad_returnredirect -message "I bonifici indicati sono stati ripristinati." "transfers-list?$url_vars"

ad_script_abort
