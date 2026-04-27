ad_page_contract {
    Approve an inspector

    @author Claudio Pasolini
    @cvs-id approve.tcl
} {
    inspector_id
}

set company_id [auth::require_login]

if {![db_0or1row check_company "select 1 from iter_inspecting_companies where company_id = :company_id"]} {
    ad_returnredirect -message "Spiacente, ma questa pagina è riservata alle aziende di ispezione registrate." /
    ad_script_abort
}

if {![db_0or1row check_inspector "select approved_p, validated_p from iter_inspectors where company_id = :company_id and inspector_id = :inspector_id"]} {
    ad_returnredirect -message "Spiacente, ma l'ispettore non è tra quelli registrati dall'azienda." /
    ad_script_abort
}

if {$approved_p} {
    ad_returnredirect -message "Funzione non disponibile per questo manutentore, in quanto già approvato." /
    ad_script_abort
}

db_transaction {

    db_dml query "update iter_inspectors set approved_p = 't' where inspector_id = :inspector_id"
    
} on_error {
    ah::transaction_error
}

ad_returnredirect "inspector-services?inspector_id=$inspector_id"

ad_script_abort
