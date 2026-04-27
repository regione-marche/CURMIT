ad_page_contract {

    @author        Luca Bellini
    @creation-date

    @cvs-id .tcl
} {
}

set filout [open /var/lib/aolserver/itercmmi/packages/iter/www/una-tantum/trust-val.txt w]

set validating_date [db_string query "select to_char(current_date, 'YYYY-MM-DD')"]

db_transaction {

    db_1row query "select max(substr(iter_code, 3, 6)) as iter_code_num from iter_trustees"
    set iter_code_num [string trimleft $iter_code_num "0"]
    if {[string equal $iter_code_num ""]} {
	set iter_code_num 0
    }
    set ctr 0
    db_foreach query "select * from iter_trustees where approved_p = 't' and validating_date is null  order by creation_date, trustee_id" {

	incr ctr
	incr iter_code_num
	set iter_code [db_string query "select lpad(:iter_code_num, 6, '0')"]
	set iter_code "AM$iter_code"
	set password [randomRange 99999999]
	if {[string equal $jtype "0"]} {
	    set natura "G"
	} else {
	    set natura "F"
	}
	puts $filout "$iter_code|$name|$first_name|$address1|$city|$address2|$province|$zipcode|$fiscal_code|$iva_code|$phone|$mobile|$fax|$email|$natura|$password|"

	db_dml query "update iter_trustees set validating_date = current_date, iter_code = :iter_code, password = :password where trustee_id = :trustee_id"
    }
}

close $filout

if {$ctr == 0} {
    puts $filout "no amm"
    ns_return 200 text/html " finito upd-apptrust"
    return
}

set filout [open /var/lib/aolserver/curit/packages/iter-portal/www/temp/listing/lancia-alt.txt w]
set page "iter/una-tantum/load-trust"

[iter_httpget_page_status -page $page -file_out $filout]


close $filout


set filout [open /var/lib/aolserver/curit/packages/iter-portal/www/temp/listing/send-mail-trust.txt w]

db_transaction {

	
    db_foreach query "select * from iter_trustees where validating_date is not null and validated_p = 'f' order by iter_code" {

	set mail_text "Spett.le $name $first_name,\n\nLa registrazione al portale del Catasto Unico degli Impianti Termici è stata completata con successo.\n\nL'utente assegnato è $iter_code e la password è $password.\n\n"


	puts $filout "|$trustee_id|$iter_code|$name|$email|"
	db_dml query "update iter_trustees set validated_p = 't' where trustee_id = :trustee_id"
	set mail_text "$mail_text\n\nCon questo utente e questa password sarà possibile accedere al programma I.Ter per inserire i modellli F e G ed operare su tutte le funzionalità a cui si è abilitati.\n\nSarà Vs. cura, dopo il primo accesso, cambiare la password.\n\nI passi operativi sono i seguenti:\n\n   1.Andare sul portale areaoperativa.curit.it nei servizi riservati agli Amministratori di Condominio\n   2.Cliccare sul link 'Accesso ad I.Ter'.\n   3.Selezionare l'ente su cui si vuole lavorare\n   4.Digitare user e password\n   5.Registrare i modelli\n\nPer gli Amministratori di Condominio, il manuale operativo di I.Ter da utilizzare è quello dei manutentori ed è in linea nella home page del sito nella sezione \"Documentazione\"."
	puts $filout "$mail_text"

	acs_mail_lite::send -from_addr "info@curit.it" -to_addr $email -subject "Registrazione completata" -body $mail_text
    }
}

close $filout

ns_return 200 text/html " finito send-mail-trust"
return
