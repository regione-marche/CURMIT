# expects:
# object_id
# return_url
# privs:optional, defaults to 'read', 'write', 'admin'
# user_add_url: URL to the page for adding users

set user_id [ad_conn user_id]
set admin_p [ad_permission_p $object_id admin]

if { ![exists_and_not_null return_url] } {
    set return_url [ad_return_url]
}

if { ![exists_and_not_null privs] } {
    set privs { read exec admin }
}

db_1row object_info {}

set elements [list]
lappend elements grantee_name { 
    label "[_ acs-subsite.Name]"
    link_url_col name_url
    display_template {
        <if @permissions.any_perm_p_@ true>
          @permissions.grantee_name@
        </if>
        <else>
          <span style="color: gray">@permissions.grantee_name@</span>
        </else>
    }
}

foreach priv $privs { 
    lappend select_clauses "sum(ptab.${priv}_p) as ${priv}_p"
    lappend select_clauses "(case when sum(ptab.${priv}_p) > 0 then 'checked' else '' end) as ${priv}_checked"
    lappend from_all_clauses "(case when privilege='${priv}' then 2 else 0 end) as ${priv}_p"
    lappend from_direct_clauses "(case when privilege='${priv}' then -1 else 0 end) as ${priv}_p"
    lappend from_dummy_clauses "0 as ${priv}_p"

    lappend elements ${priv}_p \
        [list \
             html { align center } \
             label [string totitle [string map {_ { }} [_ acs-subsite.$priv]]] \
             display_template "
               <if @permissions.${priv}_p@ ge 2>
                 <img src=\"/shared/images/checkboxchecked\" style=\"border:0\" height=\"13\" width=\"13\" alt=\"X\" title=\"Questo permesso è erditato. Per rimuoverlo clicca il bottone 'Non ereditare permessi da ...'.\">
               </if>
               <else>
                 <input type=\"checkbox\" name=\"perm\" value=\"@permissions.grantee_id@,${priv}\" @permissions.${priv}_checked@>
               </else>
             " \
            ]
}

set perm_url "/ah-util/permissions/"

if { ![exists_and_not_null user_add_url] } {
    set user_add_url "${perm_url}perm-user-add"
}
set user_add_url [export_vars -base $user_add_url { object_id expanded {return_url "[ad_return_url]"}}]

set actions [list \
                 "Assegna permesso ad altri utenti" $user_add_url "Assegna permesso ad uno o più utenti esistenti" \
		]

if { $context_id ne "" } {
    set inherit_p [permission::inherit_p -object_id $object_id]

    if { $inherit_p } {
        lappend actions "[_ acs-subsite.lt_Do_not_inherit_from_p]" [export_vars -base "${perm_url}toggle-inherit" {object_id {return_url [ad_return_url]}}] "[_ acs-subsite.lt_Stop_inheriting_permi]"
    } else {
        lappend actions "[_ acs-subsite.lt_Inherit_from_parent_o]" [export_vars -base "${perm_url}toggle-inherit" {object_id {return_url [ad_return_url]}}] "[_ acs-subsite.lt_Inherit_permissions_f]"
    }
}


template::list::create \
    -name permissions \
    -multirow permissions \
    -actions $actions \
    -elements $elements


set perm_form_export_vars [export_vars -form {object_id privs return_url}]

set perm_modify_url "${perm_url}perm-modify"

set application_group_id [application_group::group_id_from_package_id -package_id [ad_conn subsite_id]]

# PERMISSION: yes = 2, no = 0
# DIRECT:     yes = 1, no = -1

# 3 = permission + direct
# 2 = permission, no direct
# 1 = no permission, but direct (can't happen)
# 0 = no permission


# 2 = has permission, not direct => inherited
# 1 = has permission, it's direct => direct
# -1 = no permission 

# NOTE:
# We do not include site-wide admins in the list

db_multirow -extend { name_url } permissions permissions {} {
    if { $object_type eq "user" && $grantee_id != 0 } {
        set name_url [acs_community_member_url -user_id $grantee_id]
    }
}


