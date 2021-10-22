ad_page_contract {

    Ripristina le tabelle mis_script_menu e mis_script_menu_translations cancellandole e ricaricandole.

    @author Claudio Pasolini
    @cvs-id script-menu-refresh.tcl

} {
    {confirm_p "0"}
}

if {![acs_user::site_wide_admin_p]} {
    ad_return_complaint 1 "<li>Spiacente, ma questa funzione è riservata agli amministratori del sistema."
    ad_script_abort
}

set page_title "Importazione Menu"
set context [list [list scripts-menu-list {Lista Menu}] $page_title]

if {$confirm_p} {

    db_transaction {
	db_dml delete "delete from mis_script_menu"
	
	db_dml copy "copy mis_script_menu from              '[acs_package_root_dir ah-util]/sql/postgresql/mis_script_menu.txt'"
    }

    ad_returnredirect -message "Il menu è stato importato." scripts-menu-list
    ad_script_abort

}

