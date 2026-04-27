ad_page_contract {

  @author Claudio Pasolini

} {
    group_id
    party_id
}

set user_id    [ad_conn user_id]

# l'utente ha diritti di admin sul package?
set admin_p [permission::permission_p \
		 -no_login \
		 -object_id [ad_conn package_id] \
		 -privilege admin]

if {!$admin_p} {
    ad_return_complaint 1 "Spiacente, ma questa funzione è riservata all'amministratore di ALTER"
    ad_script_abort
}

db_transaction {

    set rel_id [db_string query "select rel_id from acs_rels where object_id_one = :group_id and object_id_two = :party_id"]

    group::remove_member \
        -group_id $group_id \
        -user_id $party_id

    db_dml query "delete from party_approved_member_map where member_id = :party_id and tag = :rel_id"

} on_error {
    ah::transaction_error
}

ad_returnredirect "group-members-list?group_id=$group_id"
ad_script_abort



