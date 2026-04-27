ad_page_contract {

    Google Map view, version 3.

    @author Claudio Pasolini
    @cvs-id one-position.tcl
} {
}

set user_id    [ad_conn user_id]

set page_title "Mappa"
set context [list $page_title]

db_1row get "select name, address from maps_positions where position_id = 0"
ns_log notice "\ndebug $name - $address"
set return_url /




