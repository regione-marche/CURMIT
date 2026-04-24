ad_page_contract {

  @author Claudio Pasolini

} {
    group_id
    map_id
}

db_transaction {

    db_dml unmap "delete from iter_bodies_inspectors_map where map_id = :map_id"    

} on_error {
    ah::transaction_error
}

ad_returnredirect "group-inspectors-list?group_id=$group_id"
ad_script_abort



