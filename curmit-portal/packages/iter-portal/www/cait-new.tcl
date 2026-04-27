ad_page_contract {
    Page for users to register themselves on the site.

    @cvs-id $Id: cait-new.tcl,v 1.1 2019/08/27 08:14:53 nsadmin Exp $
} {
    {email ""}
    {return_url [ad_pvt_home]}
}

set email ""
set password ""

set registration_url [parameter::get -parameter RegistrationRedirectUrl]
if {![string eq "" $registration_url]} {
    ad_returnredirect $registration_url
}
