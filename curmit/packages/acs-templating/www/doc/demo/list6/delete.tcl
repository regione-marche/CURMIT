# packages/notes/www/delete.tcl

ad_page_contract {

  @author rhs@mit.edu
  @creation-date 2000-10-23
  @cvs-id $Id: delete.tcl,v 1.2.12.1 2013/09/06 16:01:47 gustafn Exp $
} {
  template_demo_note_id:integer,notnull,multiple
}

foreach template_demo_note_id $template_demo_note_id {
    permission::require_permission -object_id $template_demo_note_id -privilege delete

    package_exec_plsql -var_list [list [list template_demo_note_id $template_demo_note_id]] template_demo_note del
}

ad_returnredirect "./"
