ad_page_contract {

    @author rhs@mit.edu
    @creation-date 2000-08-20
    @cvs-id $Id: grant.tcl,v 1.1.1.1 2014/03/06 15:04:07 nsadmin Exp $
} {
    object_id:integer,notnull
    privileges:multiple,optional
    {application_url ""}
    {return_url ""}
}

ad_require_permission $object_id admin

# The object name is used in various localized messages below
set name [acs_object_name $object_id]

set title [_ acs-subsite.lt_Grant_Permission_on_n]

set context [list [list "/ah-util/scripts-list" "Lista script"] [list one?[export_url_vars object_id] "[_ acs-subsite.Permissions_for_name]"] [_ acs-subsite.Grant]]

set level 1
lappend select_list [list "[string repeat "&nbsp;&nbsp;&nbsp;" $level] exec" exec]
lappend select_list [list "[string repeat "&nbsp;&nbsp;&nbsp;" $level] read" read]
lappend select_list [list "[string repeat "&nbsp;&nbsp;&nbsp;" $level] write" write]

ad_form -name grant -export {return_url} -form {
    {object_id:text(hidden)
        {value $object_id}
    }
}

element create grant application_url \
    -widget hidden \
    -value $application_url \
    -optional

element create grant party_id \
    -widget party_search \
    -datatype party_search \
    -optional

if { ![info exists privileges] } {
    set privileges [list]
}

# limit the size of the select widget to a number that should fit on a
# 1024x768 screen
if { [llength $select_list] > 23 } {
    set size 23
} else {
    set size [llength $select_list]
}

element create grant privilege \
    -widget select \
    -datatype text \
    -optional \
    -html [list size $size] \
    -options $select_list \
    -value $privileges



if { [form is_valid grant] } {
    # A valid submission - grant accordingly.

    form get_values grant
    set privileges [element get_values grant privilege]

    # grant all selected privs
    foreach privilege $privileges {
        # Lars: For some reason, selecting no privileges returns in a list 
        # containing one element, which is the empty string
        if { ![empty_string_p $privilege] } {
            permission::grant -party_id $party_id -object_id $object_id -privilege $privilege
        }
    }
    
    if {[exists_and_not_null return_url]} {
        ad_returnredirect "$return_url"
    } else {
        ad_returnredirect "one?[export_vars [list object_id application_url]]"
    }

    ad_script_abort
}
