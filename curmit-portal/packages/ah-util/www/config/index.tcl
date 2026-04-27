# /packages/room-reservation/www/admin/index.tcl

ad_page_contract {

    Administrator index page

    @cvs-id $Id: index.tcl,v 1.1.1.1 2009/08/05 16:41:46 nsadmin Exp $

} {

} -properties {
    title:onevalue
}


set user_id    [ad_conn user_id]

# l'utente ha diritti di admin sul package?
set admin_p [permission::permission_p \
		 -no_login \
		 -object_id [ad_conn package_id] \
		 -privilege admin]

if {!$admin_p} {
    ad_return_complaint 1 "Spiacente, ma questa funzione è riservata all'amministratore di ALTER"
    ad_script_abort
}

set title "Amministrazione Iter"

ad_return_template
