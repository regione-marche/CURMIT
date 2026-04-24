ad_page_contract {
    Deletes an operator

    @author Claudio Pasolini
    @cvs-id operator-delete.tcl
} {
    operator_id:integer
}

set maintainer_id [iter::script_init -validated_par "f"]

if {[string equal $maintainer_id "0"]} {
    ad_returnredirect services
    ad_script_abort
}

db_1row query "select approved_p from iter_maintainers where maintainer_id = :maintainer_id"
if {[string equal $approved_p "t"]} {
    ad_returnredirect -message "Spiacente, operazione non consentita." / 
    ad_script_abort
}

db_transaction {

    db_dml query "delete from iter_operators where operator_id = :operator_id and maintainer_id = :maintainer_id"
    
} on_error {
    ah::transaction_error
}

ad_returnredirect "operators_list"

ad_script_abort
