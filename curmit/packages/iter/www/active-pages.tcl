# /www/monitor.tcl

ad_page_contract {
    @author        Philip Greenspun <philg@mit.edu>
    @creation-date 
    @cvs-id        $Id: active-pages.tcl,v 1.2 2014/05/22 16:02:18 nsadmin Exp $
} {

}

ad_require_permission

set connections [ns_server active]

# let's build an ns_set just to figure out how many distinct elts; kind of a kludge
# but I don't see how it would be faster in raw Tcl

set scratch [ns_set new scratch]
foreach connection $connections {
    ns_set cput $scratch [lindex $connection 1] 1
}

set distinct [ns_set size $scratch]


set whole_page "
[ad_header "Life on the [ns_info server] server"]
<h2>Life on the [ns_info server] server</h2>
[ad_context_bar "Current page requests"]
<hr>

There are a total of [llength $connections] requests being served
right now (to $distinct distinct IP addresses).  Note that this number
seems to include only the larger requests.  Smaller requests, e.g.,
for .html files and in-line images, seem to come and go too fast for
this program to catch.

<p>

"

append whole_page "

<table>
<tr><th>conn #<th>client IP<th>state<th>method<th>url<th>n seconds<th>bytes</tr>
"

foreach connection $connections {
    append whole_page "<tr><td>[join $connection <td>]\n"
}

append whole_page "</table>
[ad_footer]
"

doc_return 200 text/html $whole_page
