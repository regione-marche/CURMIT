# /packages/mbryzek-subsite/www/admin/rel-segments/constraints-redirect.tcl

ad_page_contract {

    Optionally redirects user to enter constraints

    @author mbryzek@arsdigita.com
    @creation-date Thu Jan  4 11:20:37 2001
    @cvs-id $Id: constraints-redirect.tcl,v 1.2.10.4 2013/09/09 16:44:22 gustafn Exp $

} {
    segment_id:naturalnum,notnull
    { operation "" }
    { return_url "" }
}

set operation [string trim [string tolower $operation]]

if {$operation eq "yes"} {
    ad_returnredirect "constraints/new?rel_segment=$segment_id&[export_vars return_url]"
} else {
    if { $return_url eq "" } {
	set return_url "one?[export_vars segment_id]"
    }
    ad_returnredirect $return_url
}

