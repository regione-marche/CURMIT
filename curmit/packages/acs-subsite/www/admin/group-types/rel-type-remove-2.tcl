# /packages/mbryzek-subsite/www/admin/group-types/rel-type-remove-2.tcl

ad_page_contract {

    Removes the specified relation from the list of allowable ones

    @author mbryzek@arsdigita.com
    @creation-date Sun Dec 10 16:45:32 2000
    @cvs-id $Id: rel-type-remove-2.tcl,v 1.2.10.4 2013/09/09 16:44:20 gustafn Exp $

} {
    group_rel_type_id:naturalnum,notnull
    { return_url "" }
    { operation:trim "No, I want to cancel my request" }
}

if { $return_url eq "" } {
    # Pull out the group_type now as we may delete the row later
    db_1row select_group_type {
	select g.group_type
	from group_type_rels g 
	where g.group_rel_type_id = :group_rel_type_id
    }
    set return_url one?[export_vars {group_type}]
}

if {$operation eq "Yes, I really want to remove this relationship type"} {
    db_transaction {
	db_dml remove_relation {
	    delete from group_type_rels where group_rel_type_id = :group_rel_type_id
	}
    }
}


ad_returnredirect $return_url
