ad_page_contract {
    Deletes a tool

    @author Claudio Pasolini
    @cvs-id tool-delete.tcl
} {
    type
    tool_id:integer
}

set inspector_id [auth::require_login]

if {![db_0or1row check_inspector "select name as inspector_name, validated_p, approved_p from iter_inspectors where inspector_id = :inspector_id"]} {
    ad_returnredirect -message "Spiacente, ma questa pagina è riservata agli Ispettori registrati." /
    ad_script_abort
}

db_transaction {

    db_dml query "delete from iter_inspectors_tools where tool_id = :tool_id"
    
} on_error {
    ah::transaction_error
}

ad_returnredirect "tools-list?inspector_id=$inspector_id&type=$type"

ad_script_abort
