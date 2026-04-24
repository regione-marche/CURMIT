ad_page_contract {
    Menu servizi dei manutentori.

    @cvs-id $Id: services.tcl,v 1.1.1.1 2008/11/10 09:06:42 alter Exp $
} {

    maintainer_id
}

set cait_id [auth::require_login]

if {![db_0or1row check_maint "select 1 from iter_cait where cait_id = :cait_id"]} {
    ad_returnredirect -message "Spiacente, ma questa pagina è riservata ai CAIT registrati." /
    ad_script_abort
}
if {![db_0or1row check_maint "select 1 from iter_maintainers where cait_id = :cait_id and maintainer_id = :maintainer_id"]} {
    ad_returnredirect -message "Spiacente, ma il manutentore non è tra quelli registrati dal CAIT." /
    ad_script_abort
}

db_1row query "select name as maintainer_name, validated_p, approved_p from iter_maintainers where maintainer_id = :maintainer_id"

set num_msg [iter::check_reg -maintainer_id $maintainer_id]
if {[string equal $num_msg ""] && ![string equal $validated_p "t"] && ![string equal $approved_p "t"]} {
    set to_approve_p "t"
} else {
    set to_approve_p "f"
}
if {[string equal $validated_p "t"] || [string equal $approved_p "f"]} {
    set to_modify_p "t"
} else {
    set to_modify_p "f"
}

set reg_msg [iter::get_reg_msg -validated_p $validated_p -approved_p $approved_p -num_msg $num_msg]

set page_title "Operazioni sui Manutentori registrati dal CAIT"
set context [list "Servizi"]
