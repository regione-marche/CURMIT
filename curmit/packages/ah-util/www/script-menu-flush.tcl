ad_page_contract {

    Cancella la cache a seguito di modifiche alle tabelle.

    @author Claudio Pasolini
    @cvs-id script-menu-flush.tcl

} {
}

if {![acs_user::site_wide_admin_p]} {
    ad_return_complaint 1 "<li>Spiacente, ma questa funzione è riservata agli amministratori del sistema."
    ad_script_abort
}

ns_cache_flush dynamic_menu_cache

ad_returnredirect -message "La cache é stata cancellata." scripts-menu-list
ad_script_abort

