ad_page_contract {
    Permissions for the subsite itself.
    
    @author Lars Pind (lars@collaboraid.biz)
    @creation-date 2003-06-13
    @cvs-id $Id: permissions.tcl,v 1.2 2003/10/03 18:26:31 lars Exp $
} {
    object_id:integer
}

if { $object_id == [ad_conn package_id] } {
    set page_title "Permissions"
} else {
    forum::get -forum_id $object_id -array forum
    set page_title "$forum(name) Permissions"
}

set context [list $page_title]

