ad_page_contract {
    Cancella un amministratore regisdtrato

    @author Claudio Pasolini
    @cvs-id trustee-delete.tcl
} {
    trustee_id:integer
}

ns_return 200 text/html "Funzione temporaneamente disabilitata"
return
set user_id [auth::require_login]

set package_id [ad_conn package_id]

db_transaction {

    db_dml query "delete from iter_trustees where trustee_id = :trustee_id"

    db_dml query "delete from iter_parties where party_id = :party_id"

} on_error {
    ah::transaction_error
}

# la cancellazione dell'utente non è garantita
if [catch { dotlrn::remove_user_completely -user_id $user_id } errMsg ] {
    set error_msg $errMsg
    ad_return_template user-nuke-error
}	

ad_returnredirect index

ad_script_abort
