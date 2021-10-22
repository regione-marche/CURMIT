ad_page_contract {
    Deletes a bank

    @author Claudio Pasolini
    @cvs-id script-menu-delete.tcl
} {
    script_id:integer
}


db_transaction {

    db_dml query "delete from mis_script_menu where script_id = :script_id"
    
} on_error {
    ad_return_complaint 1 "
    Non &egrave; possibile cancellare il menu
    <p>L'errore restituito da PostgreSQL &egrave;:
    <code>$errmsg </code>"
    ad_script_abort
}

# retrieve eventual url vars setting
set url_vars [ad_get_client_property -default "" ah-util scripts-menu-list]
ad_returnredirect "scripts-menu-list?$url_vars"


ad_script_abort
