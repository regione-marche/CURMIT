# /admin/monitoring/configuration/index.tcl

ad_page_contract { 
    Displays some basic information about this installation of AOLServer:
    IP Address, System Name, and System Owner.

    @cvs-id $Id: index.tcl,v 1.2 2002/08/19 23:10:29 vinodk Exp $
} {
}

doc_return 200 text/html "[ad_header "[ad_system_name] Configuration"]

<h2>[ad_system_name] Configuration</h2>

[ad_context_bar "Configuration"]

<hr>
<ul>
<li>IP Address: [ns_conn peeraddr]
<li>System Name: [ad_system_name]
<li>System Owner: <a href=mailto:[ad_system_owner]>[ad_system_name]</a>
</ul>

[ad_admin_footer]
"
