ad_page_contract {
    go to a URL

    @author Ben Adida (ben@openforce.net)
    @creation-date 01 April 2002
    @cvs-id $Id: url-goto.tcl,v 1.6.8.1 2013/09/06 16:01:49 gustafn Exp $
} {
    url_id:notnull
} 

# Check for read permission on this url
permission::require_permission -object_id $url_id -privilege read

# Check the URL
set url [db_string select_url {} -default {}]

if {![empty_string_p $url]} {
    ad_returnredirect $url
} else {
    return -code error [_ file-storage.no_such_URL]
}
