# /packages/mbryzek-subsite/www/admin/index.tcl

ad_page_contract {
    @author Bryan Quinn (bquinn@arsdigita.com)
    @author Michael Bryzek (mbryzek@arsdigita.com)

    @creation-date August 15, 2000
    @cvs-id $Id: index.tcl,v 1.1.1.1 2008/11/26 11:10:23 donb Exp $
} {
} -properties {
    context:onevalue
    subsite_name:onevalue
    acs_admin_url:onevalue
    instance_name:onevalue
    acs_automated_testing_url:onevalue
    acs_lang_admin_url:onevalue
}

array set this_node [site_node::get -url [ad_conn url]]
set title "$this_node(instance_name) Administration"

set acs_admin_url [apm_package_url_from_key "acs-admin"]
array set acs_admin_node [site_node::get -url $acs_admin_url]
set acs_admin_name $acs_admin_node(instance_name)
set sw_admin_p [permission::permission_p -party_id [ad_conn user_id] -object_id $acs_admin_node(object_id) -privilege admin]
set convert_subsite_p [expr { [llength [apm_package_descendents [ad_conn package_key]]] > 0 }]
