ad_page_contract {
    Cancella un manutentore regisdtrato

    @author Claudio Pasolini
    @cvs-id operator-delete.tcl
} {
    maintainer_id:integer
}

set cait_id [auth::require_login]

if {![db_0or1row check_maint "select 1 from iter_cait where cait_id = :cait_id"]} {
    ad_returnredirect -message "Spiacente, ma questa pagina è riservata ai CAIT registrati." /
    ad_script_abort
}
if {![db_0or1row check_maint "select approved_p from iter_maintainers where cait_id = :cait_id and maintainer_id = :maintainer_id"]} {
    ad_returnredirect -message "Spiacente, ma il manutentore non è tra quelli registrati dal CAIT." /
    ad_script_abort
}
if {[string equal $approved_p "t"]} {
    ad_returnredirect -message "Spiacente, ma non è possibile cancellare un manutentore i cui dati sono già stati approvati." /
    ad_script_abort
}

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

ad_returnredirect maintainers-list

ad_script_abort
