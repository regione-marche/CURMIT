ad_page_contract {
    Cancella un amministratore regisdtrato

    @author Claudio Pasolini
    @cvs-id trustee-delete.tcl
} {
    trustee_id:integer
}

set office_id [iter::office_script_init]

if {![db_0or1row check_trustee "select approved_p from iter_trustees where office_id = :office_id and trustee_id = :trustee_id"]} {
    ad_returnredirect -message "Spiacente, ma il amministratore non è tra quelli registrati dallo Studio associato." /
    ad_script_abort
}

if {$approved_p} {
    ad_returnredirect -message "Spiacente, ma non è possibile cancellare un amministratore i cui dati sono già stati approvati." /
    ad_script_abort
}

db_transaction {

    db_dml query "delete from iter_trustees where trustee_id = :trustee_id"

} on_error {
    ah::transaction_error
}

ad_returnredirect trustees-list

ad_script_abort
