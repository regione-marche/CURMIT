ad_page_contract {

  @author Claudio Pasolini

} {
    maintainer_id
    maintainer_installations_id
}

set user_id    [ad_conn user_id]


db_transaction {
    db_dml q {delete from iter_maintainer_installations 
                    where maintainer_id = :maintainer_id 
	              and maintainer_installations_id = :maintainer_installations_id}
    #rom01 aggiorno l'editing_date del manutentore perchè il batch li veda come modificati.
    db_dml upd {update iter_maintainers
                   set editing_date = current_date
	where maintainer_id = :maintainer_id}


} on_error {
    ah::transaction_error
}

ad_returnredirect "maintainer-installations-list?maintainer_id=$maintainer_id"
ad_script_abort



