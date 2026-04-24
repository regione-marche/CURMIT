ad_page_contract {
    Approve an inspector

    @author Claudio Pasolini
    @cvs-id approve.tcl
} {
}

set inspector_id [auth::require_login]

if {![db_0or1row check_inspector "select approved_p from iter_inspectors where inspector_id = :inspector_id"]} {
    ad_returnredirect -message "Spiacente, ma questa pagina è riservata agli Ispettori registrati." /
    ad_script_abort
}

if {$approved_p} {
    ad_returnredirect "services"
}

db_transaction {

    db_dml approve "update iter_inspectors set approved_p = 't' where inspector_id = :inspector_id"
    
} on_error {
    ah::transaction_error
}

ad_returnredirect -message "I tuoi dati sono stati confermati" services

ad_script_abort
