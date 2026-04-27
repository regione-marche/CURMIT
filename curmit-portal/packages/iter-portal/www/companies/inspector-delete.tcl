ad_page_contract {
    Cancella un ispettore

    @author Claudio Pasolini
    @cvs-id inspector-delete.tcl
} {
    inspector_id:integer
}

set company_id [auth::require_login]

if {![db_0or1row check_company "select 1 from iter_inspecting_companies where company_id = :company_id"]} {
    ad_returnredirect -message "Spiacente, ma questa pagina è riservata alle aziende di ispezione registrate." /
    ad_script_abort
}

if {![db_0or1row check_maint "select approved_p from iter_inspectors where company_id = :company_id and inspector_id = :inspector_id"]} {
    ad_returnredirect -message "Spiacente, ma l'ispettore non è tra quelli registrati dall'azienda." /
    ad_script_abort
}

if {$approved_p} {
    ad_returnredirect -message "Spiacente, ma non è possibile cancellare un ispettore i cui dati sono già stati approvati." /
    ad_script_abort
}

db_transaction {

    db_dml query "delete from iter_inspectors where inspector_id = :inspector_id"

} on_error {
    ah::transaction_error
}

ad_returnredirect inspectors-list

ad_script_abort
