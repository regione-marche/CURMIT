ad_page_contract {
    Cancella Tipo Movimento

    @author Serena Saccani
    @cvs-id tran-type-delete.tcl
} {
    tran_type_id:integer
}

ah::script_init -script_name wallet/tran-type-delete

db_transaction {
    db_dml query "delete from wal_transaction_types where tran_type_id = :tran_type_id"
    
} on_error {
    ad_return_complaint 1 "
    Non &egrave; possibile cancellare il Tipo Movimento,
    probabilmente in quanto referenziata da altre tabelle.
    <p>L'errore restituito da PostgreSQL &egrave;:
    <code>$errmsg </code>"
    ad_script_abort
}

# retrieve eventual url vars setting
set url_vars [ad_get_client_property -default "" wallet tran-types-list]
ad_returnredirect "tran-types-list?$url_vars"

ad_script_abort
