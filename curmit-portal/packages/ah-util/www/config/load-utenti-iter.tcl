ad_page_contract {

    Carica utenti iter e li associa alla loro unità organizzativa.
    ATTENZIONE: Si deve prima caricare a mano la struttura organizzativa adottando lo standard di
    denominazione 'ente-xxxxxxxx' e 'system-admin'.

    @author Claudio Pasolini
} {
}

set utenti [db_list_of_lists utenti "
    select id_utente
         , cognome
         , nome
         , password
         , id_settore || '-' || id_ruolo as group_name
         , e_mail
    from coimuten"]

set html ""

db_transaction {

    foreach utente $utenti {

	util_unlist $utente username last_name first_names password group_name email

	set user_id [db_nextval acs_object_id_seq]

	if {$email eq "."} {
	    set email "$username@noemail.it"
	}

        array set creation_info [auth::create_user \
                                     -user_id     $user_id \
                                     -username    $username \
                                     -email       $email \
                                     -first_names $first_names \
                                     -last_name   $last_name \
                                     -password    $password ]

	# Handle registration problems
	if {$creation_info(creation_status) ne "ok"} {
		append html "<br>Impossibile creare l'utente $username - $last_name $first_names : status=$creation_info(creation_status)"
		continue
	}

	set group_id [db_string get "select group_id from groups where group_name = :group_name" -default ""]

	if {$group_id ne ""} {
	    # creo relazione di membership
            relation_add -member_state approved membership_rel $group_id $user_id
	}

    }

}

ns_return 200 text/html "Caricamento terminato. <p>$html"
