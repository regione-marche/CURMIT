# /www/admin/monitoring/analyze/index.tcl

ad_page_contract {
    A simple index page to the table analysis module


    @author kschmidt@arsdigita.com
    @creation-date Wed Jun 28 15:09:18 2000

    @cvs-id $Id: index.tcl,v 1.1.1.1 2001/04/20 20:51:11 donb Exp $
} {
    
}

doc_return 200 text/html "
[ad_header "Table Analysis module"]
<h2>Table Analysis Module</h2>
[ad_context_bar Analyze]<hr>
<br><blockquote>
<h2>Purpose</h2>
<p>This module automates table analysis.  The pages linked to from here are simply for management.  The work is done by a procedure in the tcl directory, ad_monitoring_analyze_tables, which automatically analyzes all the tables of a period of days specified by the parameter NumDaysToEstAllRows in the monitoring section.  NumDaysToEstAllRows defaults to 7.  The parameter AutoAnalyzeP simply turns this system on or off.  </p>
<br>
<ul>
<li><a href=\"table-analyze-info\">Table Analysis Informaion</a>
<li><a href=\"load-table-names\">Sync tables with those in database</a>
</ul>
</blockquote>
[ad_footer]
"
