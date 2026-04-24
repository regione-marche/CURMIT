ad_page_contract {

    @author        Luca Bellini
    @creation-date

    @cvs-id .tcl

    USER  DATA       MODIFICHE
    ===== ========== ==========================================================================
    rom01 08/06/2021 Regione Marche ha richiesto la modifica di alcune parti della mail.
    rom01            Sandro ha detto che le modifiche devono essere fatte solo per Regione Marche.

    sim01 26/10/2016 Parametrizzato l'email di uscita e l'indirizzo del portale che compare nelle email

} {
    maintainer_id
    cait_id
}

#set filout [open /var/lib/aolserver/ucit/packages/iter-portal/www/temp/listing/send-mail-ma.txt w]
set filout [open [ah::package_root]/temp/listing/send-mail-ma.txt w]
if {![string equal $cait_id ""]} {
    ad_returnredirect "send-mail-ma-cait?maintainer_id=$maintainer_id"
    ad_script_abort
}

set email_from [parameter::get_from_package_key -package_key iter-portal -parameter email_from];#sim01
set email_indirizzo_portale [parameter::get_from_package_key -package_key iter-portal -parameter email_indirizzo_portale];#sim01
db_transaction {

    db_foreach query "select * from iter_maintainers where maintainer_id = :maintainer_id and cait_id is null and validated_p = 't'" {

	set mail_text "Spett.le $name,\n\nLa registrazione al portale del Catasto Unico degli Impianti Termici è stata completata con successo.\n\nGli utenti e le password assegnate agli operatori dichiarati sono le seguenti:\n\n"

	puts $filout "|$maintainer_id|$iter_code|$name|$email|"
#	db_dml query "update iter_maintainers set validated_p = 't' where maintainer_id = :maintainer_id"
	set ops [db_list_of_lists query "select operator_id, name, first_name, iter_no, password from iter_operators where maintainer_id = :maintainer_id order by operator_id"]
	set iter_no_num 0
	foreach op $ops {
	    set operator_id [lindex $op 0]
	    set name [lindex $op 1]
	    set first_name [lindex $op 2]
	    set iter_no [lindex $op 3]
	    set password [lindex $op 4]
	    #rom01set mail_text "$mail_text. $name $first_name : $iter_no - $password\n"
	    set mail_text "$mail_text. $name $first_name - codice utente (userid): $iter_no - password $password\n";#rom01
	}

	set db_name [db_get_database];#rom01

	if {[string match "*iter-portal-marche*" $db_name]} {#rom01 aggiunta if e contenuto
	    
	    append mail_text "\n\nCon questi utenti e queste password sarà possibile accedere al Menù Gestione Impianti per inserire i modelli  RCEE ed operare su tutte le funzionalità a cui si è abilitati.\n\nSarà cura dell'operatore stesso, dopo il primo accesso, cambiarsi la password.\n\nI passi operativi sono i seguenti:\n\n   1. Sul portale $email_indirizzo_portale accedere ai servizi come \"altro operatore\" ed inserire email e password nei campi \"Login Ditta Manutenzione...\"\n   2. Nella pagina \"Servizi per i manutentori...\" cliccare sul link \"Accedi al menù Gestione Impianti...\".\n   3. Selezionare l'ente su cui si vuole lavorare\n   4. Digitare codice utente (userid) e password\n   5. Dal menù Gestione impianti si può acquisire, inserire o ricercare un impianto, compilare, aggiornare e stampare il libretto, trasmettere a catasto la modulistica (RCEE, ecc.), ecc.\n\nIn alternativa, per accedere al menù Gestione impianti è possibile andare sul portale $email_indirizzo_portale , accedere ai servizi come \"altro operatore\" ed inserire nei campi \"Login Operatore...\" codice utente e password appena forniti, selezionando quindi l'ente su cui lavorare.\n\nIl manuale operativo per i manutentori si trova nel menù Gestione Impianti, sottomenù \"Impianti\", alla voce \"Manuali\".\n\nPer eventuali comunicazioni, non utlizzare il presente indirizzo email ma scrivere a energia@regione.marche.it"
	    
	} else {#rom01 Aggiunta else ma non il contenuto

	    set mail_text "$mail_text\n\nCon questi utenti e queste password sarà possibile accedere al programma I.Ter per inserire i Rapporti di Controllo di Efficienza Energetica (RCEE) ed operare su tutte le funzionalità a cui si è abilitati.\n\nSarà cura dell'operatore stesso, dopo il primo accesso, cambiarsi la password.\n\nI passi operativi sono i seguenti:\n\n   1.Andare sul portale $email_indirizzo_portale nei servizi riservati ai manutentori\n   2.Cliccare sul link 'Accesso ad I.Ter'.\n   3.Selezionare l'ente su cui si vuole lavorare\n   4.Digitare user e password\n   5.Registrare i modelli\n\nIl manuale operativo di I.Ter per i manutentori è in linea nella home page del sito nella sezione \"Documentazione\"."
	    
	}
	
	puts $filout "$mail_text"

	acs_mail_lite::send -from_addr $email_from -to_addr $email -subject "Registrazione completata" -body $mail_text;#sim01

#sim01	acs_mail_lite::send -from_addr "info@oasisoftware.it" -to_addr $email -subject "Registrazione completata" -body $mail_text
    }
}

close $filout

ad_returnredirect -message "Invio mail effettuato" "index"
ad_script_abort
