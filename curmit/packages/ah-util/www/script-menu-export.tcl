ad_page_contract {

    Esporta le tabelle mis_script_menu e mis_script_menu_translations sul file system.

    @author Claudio Pasolini
    @cvs-id script-menu-export.tcl

} {
}

if {![acs_user::site_wide_admin_p]} {
    ad_return_complaint 1 "<li>Spiacente, ma questa funzione è riservata agli amministratori del sistema."
    ad_script_abort
}

file delete [acs_package_root_dir ah-util]/sql/postgresql/mis_script_menu.txt

db_dml copy "copy mis_script_menu              to '/tmp/mis_script_menu.txt'"

file copy -force /tmp/mis_script_menu.txt [acs_package_root_dir ah-util]/sql/postgresql/mis_script_menu.txt

ad_returnredirect -message "Il menu è stato copiato." scripts-menu-list
ad_script_abort

