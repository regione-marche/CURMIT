ad_page_contract {
    Permissions for object_id.
    
    @author Lars Pind (lars@collaboraid.biz)
    @author Claudio Pasolini (cpasolini@oasisoftware.com)
    @creation-date 2003-06-13
    @cvs-id $Id: permissions.tcl,v 1.1.1.1 2014/03/06 15:04:07 nsadmin Exp $
} {
    object_id:optional
}

if {[info exists object_id]} {
    set page_title [db_string name "select coalesce((select description from mis_scripts where script_id = :object_id), acs_object__name(:object_id))"]
} else { 
    set object_id  [ad_conn subsite_id]
    set page_title [ad_conn instance_name] 
}

set page_title "Permessi su $page_title"

set context [list [list index "Programmi"] "$page_title"]

