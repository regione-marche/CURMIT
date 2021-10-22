# creo la struttura organizzativa

# trovo il subsite della intranet
array set arr [site_node::get_from_url -url /]
set context_id $arr(package_id)

# ottengo il gruppo a cui appartengono, con relazione di
# composizione, tutti gli altri gruppi 
set subsite_group_id [application_group::group_id_from_package_id -package_id $context_id]

set iter_package_id [apm_package_id_from_key iter]

# utenti attuali
set users [db_list_of_lists utenti "
    select id_utente
         , cognome
         , nome
         , id_settore
         , id_ruolo
         , password
         , lower(id_utente) || '@dummy.it' -- ignoro l'eventuale email in quanto potrebbe confliggere con quella di user già esistenti
    from coimuten
    order by id_settore, id_ruolo, cognome
"]

# individuo i ruoli, che andrò a definire come gruppi
set groups [db_list ruoli "select distinct id_ruolo from coimuten"] 

db_transaction {

    # aggiungo gruppi
    foreach group_name $groups {

        set group_id [group::new \
			  -group_name $group_name \
			  -context_id $context_id \
			  "application_group" \
			 ]

        # assegno ai gruppi appena creati il permesso 'read' sul package 'iter'
	permission::grant -party_id $group_id -object_id $iter_package_id -privilege read

	# creo relazione di composizione con lo applicationgroup del subsite
	relation_add  composition_rel $subsite_group_id $group_id

	# memorizzo group_id
	set group($group_name) $group_id

    }

    # aggiungo gli utenti e li associo ai rispettivi gruppi
    foreach user $users {

	util_unlist $user id_utente cognome nome id_settore id_ruolo password email

	ns_log notice "\ncreo utente $id_utente - $email"

	array set auth_status_array [auth::create_user \
					 -username    $id_utente \
					 -email       $email \
					 -first_names $nome \
					 -last_name   $cognome \
					 -password    $password]

	# if anything goes wrong here, stop the whole process
	if {$auth_status_array(creation_status) ne "ok"} {
	    ad_return_error "Insert Failed" "We were unable to create a user record for ($user).<br>
                             creation_status=$auth_status_array(creation_status)<br>
                             element_messages=$auth_status_array(element_messages)"
	    ad_script_abort
	}

	set user_id $auth_status_array(user_id)
	append success_text "Created user $user_id for ($user)<br\>"

        # se l'utente appartiene al ruolo admin lo rendo tale
	if {$id_ruolo eq "admin"} {
	    permission::grant -object_id [acs_magic_object "security_context_root"] -party_id $user_id -privilege "admin"
	}

	# Add user to subsite as a member
	group::add_member \
	    -group_id $subsite_group_id \
	    -user_id  $user_id

	# creo relazione di membership 
        relation_add -member_state approved membership_rel $group($id_ruolo) $user_id
	
    }

}

ns_return 200 text/html $success_text
