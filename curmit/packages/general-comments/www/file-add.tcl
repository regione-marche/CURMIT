# /packages/general-comments/www/file-add.tcl

ad_page_contract {
    Creates a new file attachment
    
    @param parent_id The id of the comment to attach to
 
    @author Phong Nguyen (phong@arsdigita.com)
    @author Pascal Scheffers (pascal@scheffers.net)
    @creation-date 2000-10-12
    @cvs-id $Id: file-add.tcl,v 1.4.20.2 2013/09/06 17:37:19 gustafn Exp $
} {
    parent_id:notnull,integer
    {return_url {} }
} -properties {
    page_title:onevalue
    context:onevalue
    parent_id:onevalue
    target:onevalue
    title:onevalue
    file_name:onevalue
} -validate {
    allow_file_attachments {
        set allow_files_p [parameter::get -parameter AllowFileAttachmentsP -default {t}]
        if { $allow_files_p != "t" } {
            ad_complain "Attaching files to comments has been disabled."
        }
    }
}

# check to see if the user can add an attachment
permission::require_permission -object_id $parent_id -privilege write

# set variables for template
set attach_id [db_nextval acs_object_id_seq]
set page_title "[_ general-comments.lt_Add_a_file_attachment] #$parent_id"
set context [list [list "view-comment?comment_id=$parent_id" "[_ general-comments.Go_back_to_comment]"] "[_ general-comments.Add_file_attachment]"]
set target "file-add-2"
set title ""
set file_name ""

ad_return_template "file-ae"




