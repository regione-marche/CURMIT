# packages/notes/www/delete.tcl

ad_page_contract {

  @author rhs@mit.edu
  @creation-date 2000-10-23
  @cvs-id $Id: delete.tcl,v 1.1.12.1 2013/09/06 16:01:47 gustafn Exp $
} {
  template_demo_note_id:integer,notnull,multiple
}

# Here, we delete all the notes being fed to us, which is all 
# the notes that were checked on the index page. This page doesn't
# know/care about the fact they are the checked notes, all it knows
# is there are a bunch of template_demo_note_id values coming in 
# through the url. So, this list is sorta becoming a form too :)
#
# so this loop runs thru all passed-in values of template_demo_note_id
# and for each, deletes that note.

foreach template_demo_note_id $template_demo_note_id {
    permission::require_permission -object_id $template_demo_note_id -privilege delete

    package_exec_plsql \
        -var_list \
            [list \
                [list \
                    template_demo_note_id \
                    $template_demo_note_id \
                ] \
            ] \
        template_demo_note \
        del
}

ad_returnredirect "./"
