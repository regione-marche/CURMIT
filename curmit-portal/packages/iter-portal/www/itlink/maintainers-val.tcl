ad_page_contract {

    @author        Luca Bellini
    @creation-date

    @cvs-id .tcl
} {
}

set filout [open /var/lib/aolserver/itercmmi/packages/iter/www/una-tantum/manut-val.txt w]
set filout_op [open /var/lib/aolserver/itercmmi/packages/iter/www/una-tantum/op-val.txt w]
set filout_rleg [open /var/lib/aolserver/itercmmi/packages/iter/www/una-tantum/rleg-val.txt w]

set validating_date [db_string query "select to_char(current_date, 'YYYY-MM-DD')"]

db_transaction {

    db_1row query "select max(substr(iter_code, 3, 6)) as iter_code_num from iter_maintainers"
    set iter_code_num [string trimleft $iter_code_num "0"]
    if {[string equal $iter_code_num ""]} {
	set iter_code_num 0
    }
	
    db_foreach query "select * from iter_maintainers where op_number <= (select count(*) from iter_operators o where o.maintainer_id = iter_maintainers.maintainer_id) and de_number <= (select count(*) from iter_tools d where d.maintainer_id = iter_maintainers.maintainer_id and d.type = '1') and an_number <= (select count(*) from iter_tools a where a.maintainer_id = iter_maintainers.maintainer_id and a.type = '0') and creation_date > '2008-01-14' and (creation_date between '2008-01-16' and '2008-01-20' or approved_p = 't') and validating_date is null  and iter_code is null order by creation_date, maintainer_id" {

	incr iter_code_num
	set iter_code [db_string query "select lpad(:iter_code_num, 6, '0')"]
	set iter_code "MA$iter_code"
	puts $filout "$iter_code|$name|$address1|$address2|$province|$zipcode|$city|$fiscal_code|$iva_code|$phone|$mobile|$fax|$email|$registration_no|$where_registered|$rea_no|$where_rea|$capital|$role|"

	db_dml query "update iter_maintainers set validating_date = current_date, iter_code = :iter_code where maintainer_id = :maintainer_id"
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
	set ops [db_list_of_lists query "select operator_id, name, first_name, no, fiscal_code, phone, mobile, address, notes from iter_operators where maintainer_id = :maintainer_id order by operator_id"]
	set iter_no_num 0
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
	    set password [randomRange 99999999]
	    incr iter_no_num
	    set iter_no [db_string query "select lpad(:iter_no_num, 2, '0')"]
	    set iter_no "$iter_code$iter_no"
	    puts $filout_op "$iter_no|$name|$first_name|$no|$fiscal_code|$phone|$mobile|$address|$notes|$password|"
	    db_dml query "update iter_operators set iter_no = :iter_no, password = :password where operator_id = :operator_id"
	}
    }
}

close $filout
close $filout_op
close $filout_rleg


set filout [open /var/lib/aolserver/curit/packages/iter-portal/www/temp/listing/lancia-al.txt w]
[iter_httpget_load -file_out $filout]

close $filout


set filout [open /var/lib/aolserver/curit/packages/iter-portal/www/temp/listing/send-mail.txt w]

db_transaction {

	
    db_foreach query "select * from iter_maintainers where validating_date is not null and validated_p = 'f' and cait_id is null and iter_code > 'MA001200' order by iter_code" {

	set mail_text "Spett.le $name,\n\nLa registrazione al portale del Catasto Unico degli Impianti Termici è stata completata con successo.\n\nGli utenti e le password assegnate agli operatori dichiarati sono le seguenti:\n\n"


	puts $filout "|$maintainer_id|$iter_code|$name|$email|"
	db_dml query "update iter_maintainers set validated_p = 't' where maintainer_id = :maintainer_id"
	set ops [db_list_of_lists query "select operator_id, name, first_name, iter_no, password from iter_operators where maintainer_id = :maintainer_id order by operator_id"]
	set iter_no_num 0
	foreach op $ops {
	    set operator_id [lindex $op 0]
	    set name [lindex $op 1]
	    set first_name [lindex $op 2]
	    set iter_no [lindex $op 3]
	    set password [lindex $op 4]
	    set mail_text "$mail_text. $name $first_name : $iter_no - $password\n"
	}
	set mail_text "$mail_text\n\nCon questi utenti e queste password sarà possibile accedere al programma I.Ter per inserire i modellli F e G ed operare su tutte le funzionalità a cui si è abilitati.\n\nSarà cura dell'operatore stesso, dopo il primo accesso, cambiarsi la password.\n\nI passi operativi sono i seguenti:\n\n   1.Andare sul portale areaoperativa.curit.it nei servizi riservati ai manutentori\n   2.Cliccare sul link 'Accesso ad I.Ter'.\n   3.Selezionare l'ente su cui si vuole lavorare\n   4.Digitare user e password\n   5.Registrare i modelli\n\nIl manuale operativo di I.Ter per i manutentori è in linea nella home page del sito nella sezione \"Documentazione\"."
	puts $filout "$mail_text"

	acs_mail_lite::send -from_addr "info@curit.it" -to_addr $email -subject "Registrazione completata" -body $mail_text
    }
}

close $filout

ns_return 200 text/html " finito upd-approved"
return
