ad_page_contract {
    Approve a maintainer

    @author Claudio Pasolini
    @cvs-id approve.tcl
} {
}

set maintainer_id [iter::script_init -approved_par "f"]
if {[string equal $maintainer_id "0"]} {
    ad_returnredirect services
}

db_1row query "select validated_p, approved_p from iter_maintainers where maintainer_id = :maintainer_id"
if {[string equal $approved_p "t"]} {
    ad_returnredirect "services"
    ad_script_abort
}

db_transaction {

    db_dml query "update iter_maintainers set approved_p = 't' where maintainer_id = :maintainer_id"
    
} on_error {
    ah::transaction_error
}

ad_returnredirect "services"

ad_script_abort
