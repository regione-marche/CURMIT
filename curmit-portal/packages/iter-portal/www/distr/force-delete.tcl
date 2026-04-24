ad_page_contract {

  Removes an attachment, even if approved

  @author Claudio Pasolini

  @cvs-id force-delete.tcl

} {
    object_id:integer
    attachment_id:integer
}

set user_id [auth::require_login]


db_transaction {

    attachments::unattach -object_id $object_id -attachment_id $attachment_id

    fs::delete_file -item_id $attachment_id
}

ad_returnredirect attachments?object_id=$object_id
