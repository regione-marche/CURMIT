ad_page_contract {  

    Admin page

    @author Serena Saccani

    @cvs-id index.tcl 
} {
}

set user_id [ad_conn user_id]
set package_id [ad_conn package_id]

# indica se l'utente ha privilegio admin sull'intero package
set admin_p [permission::permission_p -party_id $user_id -object_id $package_id -privilege admin]

set page_title "Tabelle e Archivi"
set context [list "$page_title"]

ad_return_template
