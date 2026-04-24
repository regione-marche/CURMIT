ad_page_contract {
    Deletes a tool

    @author Claudio Pasolini
    @cvs-id tool-delete.tcl

    USER  DATA       MODIFICHE
    ===== ========== ============================================================================
    gac01 22/08/2018 Quando cancello uno strumento faccio la foreach per portare la cancellazione 
    gac01            su ogni istanza della regione.
    gac01            IMPORTANTE: per i test ho fatto una cablatura che bisognerà togliere.

} {
    type
    tool_id:integer
    maintainer_id
}

set instances [db_list get_instances "select instance_name from iter_instances"];#gac01
#set instances "itercman-dev" ;#IMPORTANTE: da togliere perchè serve solo per i test


db_transaction {

    db_dml query "delete from iter_tools where tool_id = :tool_id"

    foreach instance $instances {#gac01 aggiunta foreach e suo contenuto

	ns_log notice "\ntool-delete function delete ... processing instance=$instance"
	
	db_dml -dbn $instance query "delete from coimstru_manu where cod_strumento = :tool_id"
    };#gac01

} on_error {
    ah::transaction_error
}

ad_returnredirect "tools-list?maintainer_id=$maintainer_id&type=$type"

ad_script_abort
