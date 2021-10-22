ad_page_contract {
    Remove member(s).
    
    @author Lars Pind (lars@collaboraid.biz)
    @creation-date 2003-06-02
    @cvs-id $Id: member-remove.tcl,v 1.2 2014/03/25 14:58:40 nsadmin Exp $
} {
    user_id:integer,multiple
}

set package_id [apm_package_id_from_key layout-managed-subsite]
set group_id [application_group::group_id_from_package_id -package_id $package_id]

permission::require_permission -object_id $group_id -privilege "admin"

foreach id $user_id {
    group::remove_member \
        -group_id $group_id \
        -user_id $user_id
}

ad_returnredirect .
