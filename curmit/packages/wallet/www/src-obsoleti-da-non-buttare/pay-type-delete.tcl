ad_page_contract {
    Cancella Tipo Pagamento

    @author Serena Saccani
    @cvs-id pay-type-delete.tcl
} {
    pay_type_id:integer
}

ah::script_init -script_name wallet/pay-type-delete

db_transaction {
    db_dml query "delete from wal_payment_types where pay_type_id = :pay_type_id"
    
} on_error {
    ad_return_complaint 1 "
    Non &egrave; possibile cancellare il Tipo Pagamento,
    probabilmente in quanto referenziata da altre tabelle.
    <p>L'errore restituito da PostgreSQL &egrave;:
    <code>$errmsg </code>"
    ad_script_abort
}

# retrieve eventual url vars setting
set url_vars [ad_get_client_property -default "" wallet pay-types-list]
ad_returnredirect "pay-types-list?$url_vars"

ad_script_abort
