ad_page_contract {
    Page for users to register themselves on the site.

    @cvs-id $Id: user-new.tcl,v 1.3 2020/06/11 06:20:05 nsadmin Exp $
} {
    {email ""}
    {return_url [ad_pvt_home]}
    documento:trim,optional
    documento.tmpfile:tmpfile,optional
}

set email ""
set password ""
set db_name [db_get_database];#rom01

set registration_url [parameter::get -parameter RegistrationRedirectUrl]
if {![string eq "" $registration_url]} {
    ad_returnredirect $registration_url
}
