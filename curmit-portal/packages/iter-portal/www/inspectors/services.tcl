ad_page_contract {
    Menu servizi degli Ispettori

    @cvs-id $Id: services.tcl
} {

}

set inspector_id [auth::require_login]

if {![db_0or1row check_inspector "select validated_p, approved_p from iter_inspectors where inspector_id = :inspector_id"]} {
    ad_returnredirect -message "Spiacente, ma questa pagina è riservata agli Ispettori registrati." /
    ad_script_abort
}

if {$validated_p && $approved_p} {
    set to_approve_p "f"
} else {
    set to_approve_p "t"
}

set page_title "Servizi per gli Ispettori registrati"
set context [list "Servizi"]
