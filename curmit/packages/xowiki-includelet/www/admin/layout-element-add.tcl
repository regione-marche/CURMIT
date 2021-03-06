ad_page_contract {
  Add an element to a given pageset

  @author Gustaf Neumann (gustaf.neumann@wu-wien.ac.at)
  @author Don Baccus
  @creation-date 2008-07-31
  @cvs-id $Id: layout-element-add.tcl,v 1.1.1.1 2008/08/02 12:48:57 donb Exp $

  @param object_type show objects of this class and its subclasses

} {
  pageset_id:integer,notnull
  package_id:integer,notnull
  page_name:notnull
  referer:notnull
}

set xowiki_package_id $package_id
::xowiki::Package initialize -package_id $xowiki_package_id

#set page_id [$package_id resolve_request -path $page_name method]
set page_id [$package_id  get_page_from_name -assume_folder true -name $page_name]

if {$page_id eq ""} {
    #
    # If a page with the given name does not exist, return an error.
    #
    ad_return_error \
        [_ xowiki.portlet_page_does_not_exist_error_short] \
        [_ xowiki.portlet_page_does_not_exist_error_long $page_name]
} else {
    #
    # The page exists, get the title of the page...
    #
    set page_title [$page_id title]

    db_transaction {
        layout::element::new \
            -page_id 1 \
            -package_id $xowiki_package_id \
            -includelet_name xowiki_includelet \
            -title $page_title \
            -parameters [list page_name $page_name] \
            -initialize
    }
    ad_returnredirect $referer
  }
}
ad_script_abort

