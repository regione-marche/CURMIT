ad_page_contract {
    Deletes a tool

    @author Claudio Pasolini
    @cvs-id tool-delete.tcl
} {
    type
    tool_id:integer
}

set maintainer_id [iter::script_init -validated_par "f"]
if {[string equal $maintainer_id "0"]} {
    ad_returnredirect services
}

db_transaction {

    db_dml query "delete from iter_tools where tool_id = :tool_id"
    
} on_error {
    ah::transaction_error
}

ad_returnredirect "tools-list?maintainer_id=$maintainer_id&type=$type"

ad_script_abort
