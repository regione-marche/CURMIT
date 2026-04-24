ad_page_contract {

    @author        Claudio Pasolini
    @creation-date

    @cvs-id send-mail-trustee.tcl
} {
    trustee_id
    office_id
}


if {$office_id ne ""} {
    iter::notify_trustee_with_office -trustee_id $trustee_id -office_id $office_id
} else {
    iter::notify_trustee -trustee_id $trustee_id
}

ad_returnredirect -message "La mail è stata inviata." "index"

ad_script_abort
