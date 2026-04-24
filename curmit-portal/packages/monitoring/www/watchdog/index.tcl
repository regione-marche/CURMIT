# /admin/monitoring/watchdog/index.tcl

ad_page_contract {
    @cvs-id $Id: index.tcl,v 1.3 2002/09/10 22:23:08 jeffd Exp $
} {
    kbytes:integer,optional
    num_minutes:integer,optional
}

if { [info exists num_minutes] && ![empty_string_p $num_minutes] } {
    set kbytes ""
    set bytes ""
} else {
    set num_minutes ""
    if { ![info exists kbytes] || [empty_string_p $kbytes] } {
    set kbytes 200
    }
    set bytes [expr $kbytes * 1000]
}

doc_return 200 text/html "[ad_header "WatchDog"]

<h2>WatchDog</h2>

[ad_context_bar "WatchDog"]

<hr>

<FORM ACTION=index>    
Errors from the last <INPUT NAME=kbytes SIZE=4 value=\"$kbytes\"> Kbytes of error log. 
<INPUT TYPE=SUBMIT VALUE=\"Search again\">
</FORM>

<FORM ACTION=index>
Errors from the last <INPUT NAME=num_minutes SIZE=4 value=\"$num_minutes\"> minutes of error log. <INPUT TYPE=SUBMIT VALUE=\"Search again\">
</FORM>

<PRE>
[ns_quotehtml [wd_errors -external_parser_p 1 -num_minutes "$num_minutes" -num_bytes "$bytes"]]
</PRE>

[ad_admin_footer]
"