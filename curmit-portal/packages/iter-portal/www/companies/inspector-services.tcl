ad_page_contract {
    Menu servizi di un ispettore.

    @cvs-id $Id: inspector-services.tcl
} {

    inspector_id
}

set company_id [auth::require_login]

if {![db_0or1row check_company "select 1 from iter_inspecting_companies where company_id = :company_id"]} {
    ad_returnredirect -message "Spiacente, ma questa pagina è riservata alle aziende di ispezione registrate." /
    ad_script_abort
}

if {![db_0or1row check_maint "select 1 from iter_inspectors where company_id = :company_id and inspector_id = :inspector_id"]} {
    ad_returnredirect -message "Spiacente, ma l'ispettore non è tra quelli registrati dall'azienda." /
    ad_script_abort
}

db_1row query "select name || ' ' || first_name as inspector_name, validated_p, approved_p from iter_inspectors where inspector_id = :inspector_id"


if { !$validated_p && !$approved_p} {
    set to_approve_p "t"
} else {
    set to_approve_p "f"
}

set page_title "Operazioni sugli ispettori registrati dall'azienda"
set context [list "Servizi"]
