ad_page_contract {
    Page for users to register themselves on the site.

    @cvs-id $Id: new.tcl
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
