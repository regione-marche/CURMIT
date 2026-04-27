ad_page_contract {
    Menu servizi degli amministratori.

    @cvs-id $Id: trustees-services.tcl
} {

    trustee_id
}

set office_id [iter::office_script_init]

if {![db_0or1row check_trustee "
    select name as trustee_name, validated_p, approved_p from iter_trustees where office_id = :office_id and trustee_id = :trustee_id"]} {
    ad_returnredirect -message "Spiacente, ma l'amministratore non è tra quelli registrati dallo Studio." /
    ad_script_abort
}


if { $validated_p eq "f" && $approved_p eq "f"} {
    set to_approve_p "t"
} else {
    set to_approve_p "f"
}

if {$validated_p || $approved_p eq "f"} {
    set to_modify_p "t"
} else {
    set to_modify_p "f"
}

set reg_msg [iter::get_reg_msg -validated_p $validated_p -approved_p $approved_p -num_msg ""]

set page_title "Operazioni sugli Amministratori registrati dallo Studio"
set context [list "Servizi"]
