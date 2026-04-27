ad_page_contract {
    Cancella una delega

    @author Riccardo Vesentini
    @cvs-id operator-delete.tcl
} {
    delegation_id:integer
}

set user_id [auth::require_login]

set package_id [ad_conn package_id]

db_transaction {

    db_dml query "delete from iter_maintainer_delegations where delegation_id = :delegation_id"

} on_error {
    ah::transaction_error
}

# la cancellazione dell'utente non è garantita
if [catch { dotlrn::remove_user_completely -user_id $user_id } errMsg ] {
    set error_msg $errMsg
    ad_return_template user-nuke-error
}	

ad_returnredirect maintainer-delegations-list

ad_script_abort
