# /packages/mbryzek-subsite/www/admin/rel-types/roles/delete.tcl

ad_page_contract {

    Deletes a role if there are no relationship types that use it

    @author mbryzek@arsdigita.com
    @creation-date Mon Dec 11 11:30:53 2000
    @cvs-id $Id: delete.tcl,v 1.2.26.4 2013/09/09 16:44:23 gustafn Exp $

} {
    role:notnull
    { return_url "" }
} -properties {
    context:onevalue
    pretty_name:onevalue
    export_vars:onevalue
}

set context [list [list "../" "Relationship types"] [list "" "Roles"] [list one?[export_vars role] "One role"] "Delete role"]

set export_vars [export_vars -form {role return_url}]

set pretty_name [db_string select_role_pretty_name {
    select r.pretty_name from acs_rel_roles r where r.role = :role
}]

ad_return_template
