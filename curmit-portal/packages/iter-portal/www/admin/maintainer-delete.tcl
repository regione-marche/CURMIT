ad_page_contract {
    Cancella un manutentore regisdtrato

    @author Claudio Pasolini
    @cvs-id operator-delete.tcl
} {
    maintainer_id:integer
}

ns_return 200 text/html "Funzione temporaneamente disabilitata"
return
set user_id [auth::require_login]

set package_id [ad_conn package_id]

set party_id [db_string query "select representative_id from iter_maintainers where maintainer_id = :maintainer_id"]

db_transaction {

    db_dml query "delete from iter_operators where maintainer_id = :maintainer_id"

    db_dml query "delete from iter_tools where maintainer_id = :maintainer_id"

    db_dml query "delete from iter_maintainers where maintainer_id = :maintainer_id"

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
