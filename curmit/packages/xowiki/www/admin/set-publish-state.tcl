::xowiki::Package initialize -ad_doc {
  Changes the publication state of a content item

  @author Gustaf Neumann (gustaf.neumann@wu-wien.ac.at)
  @creation-date Nov 16, 2006
  @cvs-id $Id: set-publish-state.tcl,v 1.9 2012/09/13 16:05:33 victorg Exp $

  @param object_type 
  @param query
} -parameter {
  {-state:required}
  {-revision_id:required}
  {-return_url "."}
}

set item_id [db_string get_item_id \
    {select item_id from cr_revisions where revision_id = :revision_id}]

ns_cache flush xotcl_object_cache ::$item_id
ns_cache flush xotcl_object_cache ::$revision_id

::xo::db::sql::content_item set_live_revision \
            -revision_id $revision_id \
            -publish_status $state

if {$state ne "production"} {
  ::xowiki::notification::do_notifications -revision_id $revision_id
  ::xowiki::datasource $revision_id
} else {
  db_dml flush_syndication {delete from syndication where object_id = :revision_id}
}

ad_returnredirect $return_url
