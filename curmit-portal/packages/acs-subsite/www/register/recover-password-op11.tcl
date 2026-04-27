ad_page_contract {
    Recover forgotten password.

    @author Simon Carstensen
    @creation-date 2003-08-29
    @cvs-id $Id: recover-password.tcl,v 1.12.6.1 2013/08/27 12:20:38 gustafn Exp $
} {
    {authority_id:integer ""}
    {username ""}
    {email_operator ""}
    {user_id   ""}
}

set page_title [_ acs-subsite.Reset_Password]
set context [list $page_title]

# display error if the subsite doesn't allow recovery of passwords
set subsite_id [subsite::get_element -element object_id]
ns_log notice "simone 1"
set email $email_operator;#but01



# Display form to collect username and authority
set authority_options [auth::authority::get_authority_options]

if { (![info exists authority_id] || $authority_id eq "") } {
    set authority_id [lindex [lindex $authority_options 0] 1]
}
ns_log notice "simone 3"
ad_form -name recover -edit_buttons [list [list [_ acs-kernel.common_continue] ok]] -form { {dummy:text(hidden),optional} }
    
set submission_p 0

ad_form -extend -name recover -on_request {}


# We handle form submission here, because otherwise we can't handle both the case where we use the form
# and the case where we don't in one go


if { [form is_valid recover] || (![form is_submission recover] && (([info exists username] && $username ne "") || ([info exists email] && $email ne ""))) } {


    array set recover_info [auth::password::recover_password \
                                -authority_id $authority_id \
                                -username $username \
                                -email $email
			   ]
    
    set login_url [ad_get_login_url -authority_id $authority_id -username $username]
}
ns_log notice "simone6 auth::password::recover_password \
                                -authority_id $authority_id \
                                -username $username \
                                -email $email"
set system_owner [ad_system_owner]

ns_log notice "simone 7 system_owner=$system_owner  recover_info=$recover_info(password_message) $recover_info(password_status)"
