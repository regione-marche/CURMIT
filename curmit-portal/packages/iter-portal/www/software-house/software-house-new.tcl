ad_page_contract {
    Page for users to register themselves on the site.

    @cvs-id $Id: software-house-new.tcl,v 1.1 2021/11/26 15:59:17 nsadmin Exp $
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
