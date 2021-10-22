ad_page_contract {

    Add an xowiki portlet with the given page name.  This is intended to be included
    by the layout manager's execute include helper.

    @author Don Baccus (dhogaza@pacifier.com)
    @creation-date 2008-07-31
    @cvs-id $Id: xowiki-element-add.tcl,v 1.1.1.1 2008/08/02 12:48:57 donb Exp $
} {
    pageset_id:integer,notnull
    package_id:integer,notnull
    page_name:notnull
}
    
layout::element::new \
    -pageset_id $pageset_id \
    -package_id:required \
    -includelet_name xowiki-includelet \
    -title $page_name \
    -parameters [list page_name $page_name]

