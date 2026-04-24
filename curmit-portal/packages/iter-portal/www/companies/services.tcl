ad_page_contract {
    Menu servizi delle aziende di ispezione

    @cvs-id $Id: services.tcl
} {

}

set company_id [auth::require_login]

if {![db_0or1row check_company "select 1 from iter_inspecting_companies where company_id = :company_id"]} {
    ad_returnredirect -message "Spiacente, ma questa pagina è riservata alle Aziende di Ispezione registrate." /
    ad_script_abort
}


set page_title "Servizi per le Aziende di Ispezione registrate"
set context [list "Servizi"]
