ad_page_contract {
    Approve a maintainer

    @author Claudio Pasolini
    @cvs-id approve.tcl
} {
}

set trustee_id [auth::require_login]

if {![db_0or1row check_maint "select approved_p from iter_trustees where trustee_id = :trustee_id"]} {
    ad_returnredirect -message "Spiacente, ma questa pagina è riservata agli Amministratori di Condominio registrati." /
    ad_script_abort
}
if {[string equal $approved_p "t"]} {
    ad_returnredirect "servtrust"
}

db_transaction {

    db_dml query "update iter_trustees set approved_p = 't' where trustee_id = :trustee_id"
    
} on_error {
    ah::transaction_error
}

ad_returnredirect "servtrust"

ad_script_abort
