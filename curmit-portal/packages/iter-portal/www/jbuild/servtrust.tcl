ad_page_contract {
    Menu servizi dei manutentori.

    @cvs-id $Id: servtrust.tcl,v 1.1.1.1 2008/11/10 09:06:42 alter Exp $
} {

}

set trustee_id [auth::require_login]

if {![db_0or1row check_maint "select validated_p, approved_p from iter_trustees where trustee_id = :trustee_id"]} {
    ad_returnredirect -message "Spiacente, ma questa pagina è riservata agli Amministratori di Condominio registrati." /
    ad_script_abort
}

if {![string equal $validated_p "t"] && ![string equal $approved_p "t"]} {
    set to_approve_p "t"
} else {
    set to_approve_p "f"
}


set page_title "Servizi per gli Amministratori di Condominio registrati"
set context [list "Servizi"]
