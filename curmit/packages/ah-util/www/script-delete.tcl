ad_page_contract {
    Deletes a script object.

    @author Claudio Pasolini
    @cvs-id script-delete.tcl
 
    @param item_id The id to delete
} {
    item_id:integer
    {return_url "permissions"}
}

if {![acs_user::site_wide_admin_p]} {
    ad_return_complaint 1 "<li>Spiacente, ma questa funzione è riservata agli amministratori del sistema."
    ad_script_abort
}

db_transaction {
    mis::script::delete -item_id $item_id
} on_error {
    ah::transaction_error
}

ad_returnredirect -message "Lo script è stato cancellato" $return_url


ad_script_abort
