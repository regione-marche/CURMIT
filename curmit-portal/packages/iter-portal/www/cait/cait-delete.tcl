ad_page_contract {
    Cancella un manutentore regisdtrato

    @author Claudio Pasolini
    @cvs-id operator-delete.tcl
} {
    cait_id:integer
}

ns_return 200 text/html "Funzione temporaneamente disabilitata"
return

set package_id [ad_conn package_id]

db_transaction {

    db_dml query "delete from iter_cait where cait_id = :cait_id"

} on_error {
    ah::transaction_error
}

# la cancellazione dell'utente non è garantita
if [catch { dotlrn::remove_user_completely -user_id $cait_id } errMsg ] {
    set error_msg $errMsg
    ad_return_template user-nuke-error
}	

ad_returnredirect index

ad_script_abort
