ad_page_contract {

  @author Claudio Pasolini

} {
    group_id
    party_id
}

set user_id    [ad_conn user_id]


db_transaction {

    group::remove_member \
        -group_id $group_id \
        -user_id $party_id

} on_error {
    ah::transaction_error
}

ad_returnredirect "group-members-list?group_id=$group_id"
ad_script_abort



