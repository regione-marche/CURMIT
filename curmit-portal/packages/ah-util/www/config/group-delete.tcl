ad_page_contract {

    @author Claudio Pasolini

} {
    group_id:integer,notnull
}

set user_id    [ad_conn user_id]

# l'utente ha diritti di admin sul package?
set admin_p [permission::permission_p \
		 -no_login \
		 -object_id [ad_conn package_id] \
		 -privilege admin]

if {!$admin_p} {
    ad_return_complaint 1 "Spiacente, ma questa funzione è riservata all'amministratore di ALTER"
    ad_script_abort
}

db_1row select_counts "
    select (select count(*) from group_element_map where group_id = :group_id) as elements,
           (select count(*) from rel_segments where group_id = :group_id) as segments,
           (select count(*) 
              from rel_constraints cons, rel_segments segs
             where segs.segment_id in (cons.rel_segment,cons.required_rel_segment)
               and segs.group_id = :group_id) as constraints
      from dual"


if {$elements > 0 || $segments > 0 || $constraints > 0} {
    ad_return_complaint 1 "Spiacente, ma l'Unità organizzativa è legata ad altri elementi: operazione non consentita."
    ad_script_abort
}

db_transaction {
    set group_type [group::delete $group_id]
}

ad_returnredirect -message "L'Unità Organizzativa è stata cancellata" "groups-list" 
ad_script_abort
