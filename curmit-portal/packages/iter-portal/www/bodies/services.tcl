ad_page_contract {
    Menu servizi delle aziende di ispezione

    @cvs-id $Id: services.tcl
} {

}

set user_id [auth::require_login]

set group_id [iter::user_group -user_id $user_id]

if {$group_id eq ""} {
    ad_returnredirect -message "Spiacente, ma questa pagina è riservata agli Enti." /
    ad_script_abort
}

set group_name [db_string query "select group_name from groups where group_id=:group_id"]

set page_title "Servizi per $group_name"
set context [list "Servizi"]
