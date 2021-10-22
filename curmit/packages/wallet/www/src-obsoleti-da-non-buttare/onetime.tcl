ad_script_abort

# popolo la colonna wallet_id di iter_maintainers da wal_holders
set holders [db_list_of_lists holders "select holder_id, wallet_id from wal_holders"]

if {[db_get_database] eq "wallet-dev"} {
    set curit_dbn "curit-dev"
} elseif {[db_get_database] eq "wallet-sta"} {
    set curit_dbn "curit-sta"
} else {
    set curit_dbn "curit"
}

db_transaction {

    foreach holder $holders {
	util_unlist $holder maintainer_id wallet_id

	db_dml -dbn $curit_dbn upd "update iter_maintainers set wallet_id = :wallet_id where maintainer_id = :maintainer_id"
    }
}
ns_return 200 text/html OK
