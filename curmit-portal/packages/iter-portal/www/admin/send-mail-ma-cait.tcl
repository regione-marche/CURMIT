ad_page_contract {

    @author        Luca Bellini
    @creation-date

    @cvs-id .tcl

    USER  DATA       MODIFICHE
    ===== ========== ==========================================================================
    gab01 20/09/2017 Parametrizzato l'email di uscita e l'indirizzo del portale che compare nelle email
    
} {
    maintainer_id
}

#set filout [open /var/lib/aolserver/curit/packages/iter-portal/www/temp/listing/send-mail-ma-cait.txt w]
set filout [open [ah::package_root]/temp/listing/send-mail-ma-cait.txt w] ;#gab01

set email_from [parameter::get_from_package_key -package_key iter-portal -parameter email_from];#gab01

db_foreach query "select m.name, c.email as cait_email, c.name as cait_name from iter_maintainers m, iter_cait c where m.maintainer_id = :maintainer_id and m.validated_p = 't' and c.cait_id = m.cait_id" {
    
    set mail_text "Spett.le $cait_name,\n\nLa registrazione al portale del Catasto Unico degli Impianti Termici del manutentore $name è stata completata con successo.\n\nGli utenti e le password assegnate agli operatori dichiarati sono le seguenti:\n\n"
    
    
    puts $filout "|$maintainer_id|$name|$cait_name|$cait_email|"
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
    puts $filout "$mail_text"
    
    acs_mail_lite::send -from_addr $email_from -to_addr $cait_email -subject "Registrazione di $name completata" -body $mail_text;#gab01
    
    #gab01 acs_mail_lite::send -from_addr "info@curit.it" -to_addr $cait_email -subject "Registrazione di $name completata" -body $mail_text
}

close $filout

ad_returnredirect "index"
ad_script_abort
