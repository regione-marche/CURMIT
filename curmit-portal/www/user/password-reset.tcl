ad_page_contract {
    Let's the user reset his/her password.

    @cvs-id $Id: password-reset.tcl,v 1.2 2007/01/10 21:22:11 gustafn Exp $

    USER  DATA       MODIFICHE
    ===== ========== =======================================================================
    rom02 11/04/2025 Se la procedura di reset viene richiamata da un utente amministratore
    rom02            allora il campo is_first_login_p viene messo a 't' cosi da obbligare
    rom02            gli operatori a cambiare la password dopo il primo login.

    rom01 11/12/2024 Se è attivo il parametro login_operatore_codice_fiscale allora il reset della
    rom01            password va fatto su tutte le utenze associate dal medesimo codice fiscale.

    but01 10/10/2024 Aggiunto controlli sulla complessità delle password
    
} {
    {user_id {[ad_conn untrusted_user_id]}}
    {return_url ""}
    {password_hash ""}
    {message ""}
    {caller_admin ""}
}

# Redirect to HTTPS if so configured
if { [security::RestrictLoginToSSLP] } {
    security::require_secure_conn
}

if { ![auth::password::can_change_p -user_id $user_id] } {
    ad_return_error "Not supported" "Changing password is not supported."
}

set admin_p [permission::permission_p -object_id $user_id -privilege admin]

if { !$admin_p } {
    permission::require_permission -party_id $user_id -object_id $user_id -privilege write
}


set page_title [_ acs-subsite.Reset_Password]
set context [list [list [ad_pvt_home] [ad_pvt_home_name]] $page_title]

set system_name [ad_system_name]
set site_link [ad_site_home_link]

set login_operatore_codice_fiscale [parameter::get_from_package_key -package_key iter-portal -parameter login_operatore_codice_fiscale -default "0"];#rom01

acs_user::get -user_id $user_id -array user

ad_form -name reset -edit_buttons [list [list [_ acs-kernel.common_update] "ok"]] -form {
    {user_id:integer(hidden)}
    {return_url:text(hidden),optional}
    {password_hash:text(hidden),optional}
    {message:text(hidden),optional}
    {caller_admin:text(hidden),optional}
}

ad_form -extend -name reset -form {
    {password_1:text(password)
        {label {[_ acs-subsite.New_Password]}}
        {html {size 20}}
    }
    {password_2:text(password)
        {label {[_ acs-subsite.Confirm]}}
        {html {size 20}}
    }
} -on_request {

} -validate {
    {password_1
        { [string equal $password_1 $password_2] }
        { Le password non corrispondono }
    }
} -on_submit {
   
    set password_hash_local [db_string get_password_hash "select password from users where user_id = :user_id"]

    if {$password_hash_local eq $password_hash} {#but01 modificato il contenuto del if  inizio controllo conformita' password

	set num_err_psw 0;#but01
	
	if {[string length $password_1] <10} {#but01
	    incr num_err_psw
	}
	set num_elementi_complessita 0
	
	if {![db_0or1row q "select 1 where :password_1 = lower(:password_1)"]} {#but01
	    #contiene almeno una lettera maiuscola
	    incr num_elementi_complessita
	}
	if {![db_0or1row q "select 1 where :password_1 = upper(:password_1)"]} {#but01
	    #contiene almeno una lettera minuscola
	    incr num_elementi_complessita
	}
	
	set numeric_in_string [regexp -all {[0-9]} $password_1];#but01
	
	if {$numeric_in_string >0} {#but01
	    #contiene almeno un carattere numerico
	    incr num_elementi_complessita
	}
	
	#ricavo quanti caratteri non sono speciali. Il carattere spazio viene considerato come carattere speciale
	set standard_char_in_string [regexp -all {[a-zA-Z0-9àèéìòù]} $password_1];#but01
	
	set special_char_in_string [expr [string length $password_1] - $standard_char_in_string];#but01
	
	if {$special_char_in_string > 0} {#but01
	    #contiene almeno un carattere speciale
	    incr num_elementi_complessita
	}
	if {$num_elementi_complessita <3} {#but01
	    #se non ho almeno tre dei requisiti di complessità vado a bloccare il cambio psw
	    incr num_err_psw
	}
	
	if {$num_err_psw > 0} {#but01
	    form set_error reset password_2 "Impossibile aggiornare la password.<br>Il valore specificato per la nuova password non soddisfa i requisiti di lunghezza (10 caratteri)<br>o complessità (deve soddisfare almeno 3 dei seguenti requisiti: contenere una lettera maiuscola, una lettera minuscola, un numero, un segno di interpunzione o simbolo)."
	    break
	};#fine but01
 	

	if {$login_operatore_codice_fiscale} {#rom01 Aggiunte if, else e il loro contenuto
	    
	    set ls_user [db_list get_uten "select u.user_id
                                             from users u
                                             left join iter_operators o1 on u.username = o1.iter_no
                                            where o1.fiscal_code = (
                                                  select o2.fiscal_code
                                                    from iter_operators o2
                                                    join users u2 on u2.username = o2.iter_no
                                                   where u2.user_id = :user_id)
                                               or u.user_id = :user_id"]
	} else {
	    set ls_user $user_id
	}

	foreach user_id_upd $ls_user {#rom01 Aggiunta foreach ma non il contenuto
	    array set result [auth::password::change \
				  -user_id $user_id_upd \
				  -old_password "" \
				  -new_password $password_1]

	    switch $result(password_status) {
		ok {
		    # Continue
		}
		default {
		    form set_error reset password_1 $result(password_message)
		    break
		}
	    }

	    set instances [db_list get_instances "select instance_name from iter_instances"]

	    if {[db_0or1row q "select username as id_utente
                         from users
                         where user_id = :user_id_upd
                           and username like 'MA%'"]} {

		db_transaction {
		    foreach instance $instances {

			ns_log notice "**** password-reset update password per l'utente $id_utente sull'istanza $instance ****"
			db_1row -dbn $instance q "
                        select salt
                          from coimuten
                         where id_utente = :id_utente"
			
			set new_pass_iter [ns_md string -digest "sha256" $password_1$salt]

			set upd_is_first_login "f";#rom02
			if {$caller_admin eq "t"} {#rom02 Aggiunta if e suo contenuto
			    set upd_is_first_login "t"
			}

			db_dml -dbn $instance up_p "
                        update coimuten
                           set password         = :new_pass_iter
                             , data             = current_date
                             , is_first_login_p = :upd_is_first_login --rom02 'f'
                         where id_utente        = :id_utente"
		    }
		}
	    }
	};#rom01
	
    } else {
        form set_error reset password_1 "Invalid hash"
	break
    }
    
} -after_submit {
    if { $return_url eq "" } {
        set return_url [ad_pvt_home]
        set pvt_home_name [ad_pvt_home_name]
        set continue_label [_ acs-subsite.Continue_to_your_account]
    } else {
        set continue_label [_ acs-subsite.Continue]
    }

    set message [_ acs-subsite.confirmation_password_changed]
    set continue_url $return_url

    ad_return_template /packages/acs-subsite/www/register/display-message
    
}
