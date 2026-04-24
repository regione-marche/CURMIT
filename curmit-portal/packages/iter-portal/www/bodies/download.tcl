ad_page_contract {

  Scarica fornitura.

  @author Claudio Pasolini

} {
    distributor_id
    supply_id
}

set user_id [auth::require_login]

set group_id [iter::user_group -user_id $user_id]

if {$group_id eq ""} {
    ad_returnredirect -message "Spiacente, ma questa pagina è riservata agli Enti." /
    ad_script_abort
}

set fname [ns_tmpnam]
set fd [open $fname w]

db_foreach query "
    select *
    from iter_distributors_supplies
    where distributor_id = :distributor_id
      and supply_id      = :supply_id
" {
    puts $fd "$user_name|$topo_type|$topo_name|$number|$zip_code|$city|$istat|$phone|$user_fuel|$return_point|$consumption|$um_code|$contract|$volume|$fiscal_code|$iva_code"
}

close $fd

# schedulo la cancellazione del file
ns_schedule_proc -once -thread 60 "ns_unlink -nocomplain $fname"

ns_returnfile 200 text/plain $fname
