ad_page_contract {

    Duplica un menu.

    @author Claudio Pasolini
    @cvs-id script-menu-clone.tcl

} {
    script_id:integer
}

if {![acs_user::site_wide_admin_p]} {
    ad_return_complaint 1 "<li>Spiacente, ma questa funzione è riservata agli amministratori del sistema."
    ad_script_abort
}

set next_id [db_string next "select coalesce(max(script_id), 0) + 1 from mis_script_menu"]

db_transaction {
    
    db_dml query "
        insert into mis_script_menu (
	    script_id
           ,script_name
           ,package_seq
           ,submenu_seq
           ,seq
           ,par
           ,is_arrow_p
           ,is_admin_p
           ,condition
           ,package
           ,submenu
           ,title
        ) select
	    $next_id
           ,script_name
           ,package_seq
           ,submenu_seq
           ,seq
           ,par
           ,is_arrow_p
           ,is_admin_p
           ,condition
           ,package
           ,submenu
           ,title
          from mis_script_menu
          where script_id = :script_id"


} on_error {
    ah::transaction_error
}

ad_returnredirect -message "Il menu è stato clonato." "script-menu-add-edit?script_id=$next_id"
ad_script_abort

