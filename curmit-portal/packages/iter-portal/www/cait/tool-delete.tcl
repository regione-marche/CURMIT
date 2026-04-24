ad_page_contract {
    Deletes a tool

    @author Claudio Pasolini
    @cvs-id tool-delete.tcl
} {
    maintainer_id
    type
    tool_id:integer
}

set cait_id [auth::require_login]

if {![db_0or1row check_maint "select 1 from iter_cait where cait_id = :cait_id"]} {
    ad_returnredirect -message "Spiacente, ma questa pagina è riservata ai CAIT registrati." /
    ad_script_abort
}
if {![db_0or1row check_maint "select approved_p, validated_p, name as maintainer_name from iter_maintainers where cait_id = :cait_id and maintainer_id = :maintainer_id"]} {
    ad_returnredirect -message "Spiacente, ma il manutentore non è tra quelli registrati dal CAIT." /
    ad_script_abort
}
if {[string equal $approved_p "t"]} {
    ad_returnredirect -message "Funzione non disponibile per questo manutentore." /
    ad_script_abort
}


db_transaction {

    db_dml query "delete from iter_tools where tool_id = :tool_id and maintainer_id = :maintainer_id"
    
} on_error {
    ah::transaction_error
}

ad_returnredirect "tools-list?maintainer_id=$maintainer_id&type=$type"

ad_script_abort
