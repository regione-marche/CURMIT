# /www/register/logout.tcl

ad_page_contract {
    Logs a user out

    @cvs-id $Id: logout.tcl,v 1.4 2007/01/10 21:22:09 gustafn Exp $

} {
    {return_url ""}
}

if { $return_url eq "" } {
    if { [permission::permission_p -object_id [subsite::get_element -element package_id] -party_id 0 -privilege read] } {
        set return_url [subsite::get_element -element url]
    } else {
        set return_url /
    }
}

# Claudio: se l'utente appartiene al gruppo 'Iter' ritorno alla pagina di registrazione
set group_id [db_string q "select group_id from groups where group_name='Iter'"]
if {[group::member_p -group_id $group_id -cascade ]} {
    set return_url /register
}

ad_user_logout 
db_release_unused_handles

ad_returnredirect $return_url

