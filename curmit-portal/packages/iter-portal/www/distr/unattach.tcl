ad_page_contract {

  Removes an ttachment

  @author Claudio Pasolini

  @cvs-id unattach.tcl

} {
    object_id:integer
    attachment_id:integer
}

set user_id [auth::require_login]

if {$user_id != $object_id} {
    ad_returnredirect -message "Non puoi cancellare la fornitura di un altro distributore." [export_vars -base attachments {object_id}]
    ad_script_abort
}

set approved_p [db_string check "select approved_p from attachments where object_id = :object_id and item_id = :attachment_id"]
if {$approved_p} {
    ad_returnredirect -message "Fornitura già confermata: impossibile cancellare." [export_vars -base attachments {object_id}]
    ad_script_abort
}

db_transaction {

    attachments::unattach -object_id $object_id -attachment_id $attachment_id

    fs::delete_file -item_id $attachment_id
}

ad_returnredirect attachments?object_id=$object_id
