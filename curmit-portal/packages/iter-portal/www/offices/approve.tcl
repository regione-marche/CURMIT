ad_page_contract {
    Approva un amministratore di condominio.

    @author Claudio Pasolini
    @cvs-id approve.tcl
} {
    trustee_id
}

set office_id [iter::office_script_init]

if {![db_0or1row check_trustee "
    select approved_p, validated_p from iter_trustees where office_id = :office_id and trustee_id = :trustee_id"]} {
    ad_returnredirect -message "Spiacente, ma il manutentore non è tra quelli registrati dallo Studio." /
    ad_script_abort
}

if {$approved_p} {
    ad_returnredirect -message "Funzione non disponibile per questo amministratore." /
    ad_script_abort
}

db_transaction {

    db_dml query "update iter_trustees set approved_p = 't' where trustee_id = :trustee_id"
    
} on_error {
    ah::transaction_error
}

ad_returnredirect "trustees-services?trustee_id=$trustee_id"

ad_script_abort
