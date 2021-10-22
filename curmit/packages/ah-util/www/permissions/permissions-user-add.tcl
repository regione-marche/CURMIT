ad_page_contract {
    Redirect page for adding users to the permissions list.
    
    @author Lars Pind (lars@collaboraid.biz)
    @creation-date 2003-06-13
    @cvs-id $Id: permissions-user-add.tcl,v 1.1.1.1 2014/03/06 15:04:07 nsadmin Exp $
} {
    object_id:optional
}

if {[info exists object_id]} {
    set page_title [db_string name "select acs_object__name(:object_id)"]
} else { 
    set object_id  [ad_conn subsite_id]
    set page_title [ad_conn instance_name] 
}

set page_title "Aggiungi Permessi a $page_title"

set context [list [list "permissions" "Permessi"] $page_title]

