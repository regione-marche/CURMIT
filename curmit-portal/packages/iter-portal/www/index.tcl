ad_page_contract {
    Menu servizi dei manutentori.

    @cvs-id $Id: index.tcl,v 1.3 2014/12/17 16:51:49 nsadmin Exp $
} {

}

set user_id [auth::require_login]

if {[db_0or1row check_maint "select 1 from iter_maintainers where maintainer_id = :user_id"]} {
    # ad_returnredirect "/services"
    ad_returnredirect "/iter-portal/services"
    ad_script_abort
}

if {[db_0or1row check_maint "select 1 from iter_cait where cait_id = :user_id"]} {
    # ad_returnredirect /servcait
    ad_returnredirect /iter-portal/cait/servcait
    ad_script_abort
}

if {[db_0or1row check_maint "select 1 from iter_trustees where trustee_id = :user_id"]} {
    # ad_returnredirect /servtrust
    ad_returnredirect /iter-portal/jbuild/servtrust
    ad_script_abort
}

if {[db_0or1row check_maint "select 1 from iter_offices where office_id = :user_id"]} {
    ad_returnredirect /offices
    ad_script_abort
}

if {[db_0or1row check_maint "select 1 from iter_distributors where distributor_id = :user_id"]} {
    # ad_returnredirect /distributors
    ad_returnredirect /iter-portal/distr/services
    ad_script_abort
}

if {[db_0or1row check_maint "select 1 from iter_inspecting_companies where company_id = :user_id"]} {
    #ad_returnredirect /companies
    ad_returnredirect /iter-portal/companies/services
    ad_script_abort
}

if {[db_0or1row check_maint "select 1 from iter_inspectors where inspector_id = :user_id"]} {
    # ad_returnredirect /inspectors
    ad_returnredirect /iter-portal/inspectors/services
    ad_script_abort
}
ns_log notice "\ndebugging iter-portal/index"
if {[acs_user::site_wide_admin_p -user_id $user_id]} {
    ad_returnredirect /iter-portal/admin
} else {
    ad_returnredirect -message "Spiacente, ma non sei registrato per usare questo portale." /
}

ad_script_abort




