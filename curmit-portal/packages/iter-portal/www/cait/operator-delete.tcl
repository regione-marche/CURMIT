ad_page_contract {
    Deletes an operator

    @author Claudio Pasolini
    @cvs-id operator-delete.tcl
} {
    maintainer_id
    operator_id:integer
}

set cait_id [auth::require_login]

if {![db_0or1row check_maint "select 1 from iter_cait where cait_id = :cait_id"]} {
    ad_returnredirect -message "Spiacente, ma questa pagina è riservata ai CAIT registrati." /
    ad_script_abort
}
if {![db_0or1row check_maint "select approved_p, validated_p from iter_maintainers where cait_id = :cait_id and maintainer_id = :maintainer_id"]} {
    ad_returnredirect -message "Spiacente, ma il manutentore non è tra quelli registrati dal CAIT." /
    ad_script_abort
}
if {[string equal $approved_p "t"]} {
    ad_returnredirect -message "Funzione non disponibile per questo manutentore." /
    ad_script_abort
}

db_transaction {

    db_dml query "delete from iter_operators where operator_id = :operator_id and maintainer_id = :maintainer_id"
    
} on_error {
    ah::transaction_error
}

ad_returnredirect "operators-list?maintainer_id=$maintainer_id"

ad_script_abort
