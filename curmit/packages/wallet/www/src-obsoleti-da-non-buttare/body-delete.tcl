ad_page_contract {
    Cancella un Ente

    @author Serena Saccani
    @cvs-id body-delete.tcl
} {
    body_id:integer
}

ah::script_init -script_name wallet/body-delete

db_transaction {
    db_dml query "delete from wal_bodies where body_id = :body_id"
    
} on_error {
    ad_return_complaint 1 "
    Non &egrave; possibile cancellare l'Ente,
    probabilmente in quanto referenziata da altre tabelle.
    <p>L'errore restituito da PostgreSQL &egrave;:
    <code>$errmsg </code>"
    ad_script_abort
}

# retrieve eventual url vars setting
set url_vars [ad_get_client_property -default "" wallet bodies-list]
ad_returnredirect "bodies-list?$url_vars"

ad_script_abort
