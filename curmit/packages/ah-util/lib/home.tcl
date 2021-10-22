# /pvt/home.tcl

ad_page_contract {
    user's workspace page
    @cvs-id $Id: home.tcl,v 1.1.1.1 2014/03/06 15:04:07 nsadmin Exp $
} -properties {
    system_name:onevalue
    context:onevalue
    full_name:onevalue
    email:onevalue
    url:onevalue
    screen_name:onevalue
    bio:onevalue
    portrait_state:onevalue
    portrait_publish_date:onevalue
    portrait_title:onevalue
    portrait_description:onevalue
    export_user_id:onevalue
    ad_url:onevalue
    member_link:onevalue
    pvt_home_url:onevalue
}

set user_id [auth::require_login -account_status closed]

acs_user::get -array user -include_bio -user_id $user_id

set account_status [ad_conn account_status]
set login_url [ad_get_login_url]
set subsite_url [ad_conn vhost_subsite_url]

set page_title [ad_pvt_home_name]

set pvt_home_url [ad_pvt_home]

set context [list $page_title]

set ad_url [ad_url]

set community_member_url [acs_community_member_url -user_id $user_id]

set system_name [ad_system_name]

set subsite_id [ad_conn subsite_id]
set user_info_template [parameter::get -parameter "UserInfoTemplate" -package_id $subsite_id]
