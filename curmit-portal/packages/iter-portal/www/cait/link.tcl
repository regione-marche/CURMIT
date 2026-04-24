ad_page_contract {
    Collega un manutentore ad un CAIT.

    @cvs-id $Id: link.tcl
} {
    maintainer_id
    cait_id
}

set user_id [auth::require_login]

if {$maintainer_id != $user_id} {
    ad_returnredirect -message "Il collegamento ad un CAIT è eseguibile solo dallo stesso manutentore." ../cait-list
    ad_script_abort
}

db_transaction {

    # aggiorno manutentore
    db_dml update "
        update iter_maintainers set
            cait_id = :cait_id
        where maintainer_id = :maintainer_id"

    # elimino logicamente l'utente OpenACS
    acs_user::change_state -user_id $maintainer_id -state deleted

    # cancello cookies
    ad_user_logout

} on_error {
    ah::transaction_error
}

ad_returnredirect -message "La tua registrazione come Manutentore è stata annullata e sei stato collegato al CAIT indicato." /

ad_script_abort
