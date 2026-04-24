ad_page_contract {

    @author        Luca Bellini
    @creation-date

    @cvs-id .tcl
} {
    {from_date ""}
    {to_date ""}
}

set filout [open /var/lib/aolserver/itercmmi/packages/iter/www/una-tantum/manut-val-upd.txt w]
set filout_op [open /var/lib/aolserver/itercmmi/packages/iter/www/una-tantum/op-val-upd.txt w]
set filout_rleg [open /var/lib/aolserver/itercmmi/packages/iter/www/una-tantum/rleg-val-upd.txt w]

set current_date [db_string query "select to_char(current_date, 'YYYY-MM-DD')"]
if {[string equal $from_date ""]} {
    set from_date [db_string query "select date(:current_date::date - '1 days'::reltime)"]
}
if {[string equal $to_date ""]} {
    set to_date [db_string query "select date(:current_date::date - '1 days'::reltime)"]
}

db_transaction {

    db_foreach query "select * from iter_maintainers where validated_p = 't' and validating_date < editing_date and editing_date between :from_date and :to_date order by iter_code" {

	puts $filout "$iter_code|$name|$address1|$address2|$province|$zipcode|$city|$fiscal_code|$iva_code|$phone|$mobile|$fax|$email|$registration_no|$where_registered|$rea_no|$where_rea|$capital|$role|"

	db_1row query "select p.name as rep_name, 
               p.first_name as rep_first_name, 
               p.address1 as rep_address1, 
               p.city as rep_city, 
               p.address2 as rep_address2, 
               p.province as rep_province, 
               p.zipcode as rep_zipcode, 
               p.fiscal_code as rep_fiscal_code
                       from iter_parties p
                      where p.party_id = :representative_id"
	puts $filout_rleg "$iter_code|$rep_name|$rep_first_name|$rep_address1|$rep_city|$rep_address2|$rep_province|$rep_zipcode|$rep_fiscal_code|"
	set ops [db_list_of_lists query "select operator_id, name, first_name, no, fiscal_code, phone, mobile, address, notes, iter_no, password, is_active_p from iter_operators where maintainer_id = :maintainer_id and iter_no is not null order by iter_no"]
	foreach op $ops {
	    set operator_id [lindex $op 0]
	    set name [lindex $op 1]
	    set first_name [lindex $op 2]
	    set no [lindex $op 3]
	    set fiscal_code [lindex $op 4]
	    set phone [lindex $op 5]
	    set mobile [lindex $op 6]
	    set address [lindex $op 7]
	    set notes [lindex $op 8]
	    set iter_no [lindex $op 9]
	    set password [lindex $op 10]
	    set is_active_p [lindex $op 11]
	    puts $filout_op "$iter_no|$name|$first_name|$no|$fiscal_code|$phone|$mobile|$address|$notes|$password|$is_active_p|"
	}
	set iter_no_num [string trimleft [string range $iter_no 8 9] "0"]
	set ops [db_list_of_lists query "select operator_id, name, first_name, no, fiscal_code, phone, mobile, address, notes, iter_no, password, is_active_p from iter_operators where maintainer_id = :maintainer_id and iter_no is null order by operator_id"]
	foreach op $ops {
	    set operator_id [lindex $op 0]
	    set name [lindex $op 1]
	    set first_name [lindex $op 2]
	    set no [lindex $op 3]
	    set fiscal_code [lindex $op 4]
	    set phone [lindex $op 5]
	    set mobile [lindex $op 6]
	    set address [lindex $op 7]
	    set notes [lindex $op 8]
	    set iter_no [lindex $op 9]
	    set password [lindex $op 10]
	    set is_active_p [lindex $op 11]
	    set password [randomRange 99999999]
	    incr iter_no_num
	    set iter_no [db_string query "select lpad(:iter_no_num, 2, '0')"]
	    set iter_no "$iter_code$iter_no"
	    puts $filout_op "$iter_no|$name|$first_name|$no|$fiscal_code|$phone|$mobile|$address|$notes|$password|$is_active_p|"
	    db_dml query "update iter_operators set iter_no = :iter_no, password = :password where operator_id = :operator_id"
	}
    }
}

close $filout
close $filout_op
close $filout_rleg

set filout [open /var/lib/aolserver/curit/packages/iter-portal/www/temp/listing/lanciu-al.txt w]

[iter_httpget_upd -file_out $filout]

close $filout
ns_return 200 text/html " finito upd-approved-upd"
return
