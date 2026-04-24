ad_page_contract {
    Recover forgotten password.

    @author Luca Romitti
    @creation-date 2024-10-14
    @cvs-id $Id: recover-password.tcl,v 1.12.6.1 2013/08/27 12:20:38 gustafn Exp $
} {
    {authority_id:integer ""}
    {email ""}
    {username ""}
    {user_id   ""}
}

set page_title [_ acs-subsite.Reset_Password]
set context [list $page_title]

# display error if the subsite doesn't allow recovery of passwords
set subsite_id [subsite::get_element -element object_id]
ns_log notice "simone 1"

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


#    array set recover_info [auth::password::recover_password \
#                                -authority_id $authority_id \
#                                -username $username \
#                                -email $email
#			   ]

    set result(password_status) "ok"
    set result(password_message) [_ acs-subsite.Request_Change_Password_token_email]
    
    db_1row get_usr_id_and_password_hash {SELECT user_id, password as password_hash FROM users WHERE username = :username}
    
    #set email [party::email -party_id $user_id]
    # TODO: This email message text should go in the recipient user language, english or every language supported
    set subject "[ad_system_name]: [_ acs-subsite.change_password_email_subject] $username"
    set body "[_ acs-subsite.change_password_email_body_0]\n\n[export_vars -base "[ad_url]/user/password-reset" {user_id password_hash}]\n\n[_ acs-subsite.change_password_email_body_1]"
    
    acs_mail_lite::send  -send_immediately  -to_addr $email  -from_addr [ad_outgoing_sender]  -subject $subject  -body $body
    
    #return [array get result]
    array set recover_info [array get result]
    
    set login_url [ad_get_login_url -authority_id $authority_id -username $username]

    
}
ns_log notice "simone6 auth::password::recover_password \
                                -authority_id $authority_id \
                                -username $username \
                                -email $email \
"
set system_owner [ad_system_owner]

ns_log notice "simone 7 system_owner=$system_owner  recover_info=$recover_info(password_message) $recover_info(password_status)"
