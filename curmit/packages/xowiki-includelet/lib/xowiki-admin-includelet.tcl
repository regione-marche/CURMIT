ad_page_contract { The display logic for the xowiki admin portlet
    
    @author Michael Totschnig
    @author Gustaf Neumann
    @cvs_id $Id: xowiki-admin-includelet.tcl,v 1.1.1.1 2008/08/02 12:48:57 donb Exp $
}

set base_url [site_node::get_url_from_object_id -object_id $package_id]
::xowiki::Package initialize -package_id $package_id
  
if {![info exists referer] && [exists_and_not_null return_url]} {
  set referer $return_url
}
  
if {![info exists referer]} {
  set referer [ad_conn url]
}

set pageset_id [layout::page::get_column_value \
                   -page_id [layout::element::get_column_value \
                                -element_id $element_id \
                                -column page_id] \
                   -column pageset_id]
  
db_multirow content select_content {
    select m.element_id, m.title as pretty_name, lep.value as name 
    from layout_elements m, layout_element_parameters lep
    where m.package_id = :package_id
      and lep.element_id = m.element_id and lep.key = 'page_name'
} {}
  
# don't ask to insert same page twice
template::multirow foreach content {set used_page_id($name) 1}

set options ""
db_foreach instance_select \
    [::xowiki::Page instance_select_query \
         -folder_id [::$package_id folder_id] \
         -with_subtypes true \
         -from_clause ", xowiki_page P" \
         -where_clause "P.page_id = bt.revision_id" \
         -orderby "ci.name" \
        ] {
          if {[regexp {^::[0-9]} $name]} continue
          if {[info exists used_page_id($name)]} continue
          append options "<option value=\"$name\">$name</option>"
        }


if {$options ne ""} {
  set form [subst {
    <form name="new_xowiki_element" method="post" action="${base_url}xowiki-includelet/admin/layout-element-add">
    <input type="hidden" name="pageset_id" value="$pageset_id">
    <input type="hidden" name="package_id" value="$package_id">
    <input type="hidden" name="referer" value="$referer">
    #xowiki-portlet.new_xowiki_admin_portlet# <select name="page_name" id="new_xowiki_element_page_id">
    $options
    </select>
    <input type="submit" name="formbutton:ok" value="       OK       " id="new_xowiki_element_formbutton:ok" />
    </form>
  }]
} else {
  set form "All pages already used"
}
