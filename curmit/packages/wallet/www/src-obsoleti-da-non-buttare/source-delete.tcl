ad_page_contract {
    Cancella Provenienza

    @author Serena Saccani
    @cvs-id source-delete.tcl
} {
    source_id:integer
}

ah::script_init -script_name wallet/source-delete

db_transaction {
    db_dml query "delete from wal_sources where source_id = :source_id"
    
} on_error {
    ad_return_complaint 1 "
    Non &egrave; possibile cancellare la Provenienza,
    probabilmente in quanto referenziata da altre tabelle.
    <p>L'errore restituito da PostgreSQL &egrave;:
    <code>$errmsg </code>"
    ad_script_abort
}

# retrieve eventual url vars setting
set url_vars [ad_get_client_property -default "" wallet sources-list]
ad_returnredirect "sources-list?$url_vars"


ad_script_abort
