ad_page_contract {
    Let's the user change his/her password.  Asks
    for old password, new password, and confirmation.
    
    @cvs-id $Id: password-update.tcl,v 1.22.8.1 2013/08/27 12:20:38 gustafn Exp $

    USER  DATA       MODIFICHE
    ===== ========== =======================================================================
    but01 10/10/2024 Aggiunto controlli sulla complessità delle password

    
} {
    {user_id {[ad_conn untrusted_user_id]}}
    {return_url ""}
    {old_password ""}
    {message ""}
}
# This is a bit confusing, but old_password is what we get passed in here,
# whereas password_old is the form element.


# Redirect to HTTPS if so configured
if { [security::RestrictLoginToSSLP] } {
    security::require_secure_conn
}

if { $old_password ne "" } {
    # If old_password is set, this is a user who has had his password recovered,
    # so they won't be authenticated yet.
} elseif {[db_0or1row q "select 1
                           from users
                          where user_id = :user_id
                            and username like 'MA%'"]} {#rom01 Aggiunta elseif e contenuto
    # Se trovo lo username che inizia con MA allora vuol dire che il programma
    # è richiamato dal portale e non devo chiedere l'autenticazione al portale.

} else {
    set level [ad_decode [security::RestrictLoginToSSLP] 1 "secure" "ok"]

    # If the user is changing passwords for another user, they need to be account ok
    set account_status [ad_decode $user_id [ad_conn untrusted_user_id] "closed" "ok"]

    auth::require_login \
        -level $level \
        -account_status $account_status
}


if { ![auth::password::can_change_p -user_id $user_id] } {
    ad_return_error "Not supported" "Changing password is not supported."
}

set admin_p [permission::permission_p -object_id $user_id -privilege admin]

if { !$admin_p } {
    permission::require_permission -party_id $user_id -object_id $user_id -privilege write
}



set page_title [_ acs-subsite.Update_Password]
set context [list [list [ad_pvt_home] [ad_pvt_home_name]] $page_title]

set system_name [ad_system_name]
set site_link [ad_site_home_link]

set login_operatore_codice_fiscale [parameter::get_from_package_key -package_key iter-portal -parameter login_operatore_codice_fiscale -default "0"];#rom01

acs_user::get -user_id $user_id -array user

ad_form -name update -edit_buttons [list [list [_ acs-kernel.common_update] "ok"]] -form {
        {user_id:integer(hidden)}
        {return_url:text(hidden),optional}
        {old_password:text(hidden),optional}
        {message:text(hidden),optional}
    }

if { ([info exists old_password] && $old_password ne "") } {
    set focus "update.password_1"
} else {
    ad_form -extend -name update -form {
        {password_old:text(password)
            {label {[_ acs-subsite.Current_Password]}}
        }
    }
    set focus "update.password_old"
}

ad_form -extend -name update -form {
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
        { Passwords don't match }
    }
} -on_submit {
    
    if { ([info exists old_password] && $old_password ne "") } {
        set password_old $old_password
    }

#but01 inizio controllo conformita' password

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
	    form set_error update password_1 "Impossibile aggiornare la password. Il valore specificato per la nuova password non soddisfa i requisiti di lunghezza (10 caratteri)<br>o complessità (deve soddisfare almeno 3 dei seguenti requisiti: contenere una lettera maiuscola, una lettera minuscola, un numero, un segno di interpunzione o simbolo)."
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
                                                   where u2.user_id = :user_id )
                                               or u.user_id= :user_id"]
    } else {
	set ls_user $user_id
    }

    set error_num 0
    foreach user_id_upd $ls_user {#rom01 Aggiunta foreach ma non il contenuto


	array set result [auth::password::change \
                          -user_id $user_id_upd \
                          -old_password $password_old \
                          -new_password $password_1]
    
	switch $result(password_status) {
	    ok {
		# Continue
	    }
	    old_password_bad {
		if { (![info exists old_password] || $old_password eq "") } {
		    form set_error update password_old $result(password_message)
		} else {
		    # This hack causes the form to reload as if submitted, but with the old password showing
		    ad_returnredirect [export_vars -base [ad_conn url] -entire_form -exclude { old_password } -override { { password_old $old_password } }]
		    ad_script_abort
		}
		incr error_num
		break
	    }
	    default {
		form set_error update password_1 $result(password_message)
		break
		incr error_num
	    }
	}

	set instances [db_list get_instances "select instance_name from iter_instances"]

	if {[db_0or1row q "select username as id_utente
                             from users
                            where user_id     = :user_id_upd
                              and username like 'MA%'"] && $error_num == 0} {
	    db_transaction {
		foreach instance $instances {
		    ns_log notice "**** password-reset update password per l'utente $id_utente sull'istanza $instance ****"
		    db_1row -dbn $instance q "
                        select salt
                          from coimuten
                         where id_utente = :id_utente"

		    set new_pass_iter [ns_md string -digest "sha256" $password_1$salt]
		    db_dml -dbn $instance up_p "
                        update coimuten
                           set password         = :new_pass_iter
                             , data             = current_date
                             , is_first_login_p = 'f'
                         where id_utente        = :id_utente"
		}
	    }
	}
    };#rom01

    if {$error_num > 0} {
	break
    }
	
    # If old_password was supplied, handle authentication and log the user in
    if { ([info exists old_password] && $old_password ne "") } {
        
        # We use full-scale auth::authenticate here, in order to be sure we also get account-status checked
        # Hm. What if there's a problem with timing, so the password update doesn't take effect immediately?
        array set auth_info [auth::authenticate \
                -return_url $return_url \
                -authority_id $user(authority_id) \
                -username $user(username) \
                -password $password_1]
        
        # Handle authentication problems
        switch $auth_info(auth_status) {
            ok {
                # Continue below
            }
            default {
                # we shouldn't get bad password here ...
                form set_error update password_1 $auth_info(auth_message)
                break
            }
        }
        
        if { ([info exists auth_info(account_url)] && $auth_info(account_url) ne "") } {
            ad_returnredirect $auth_info(account_url)
            ad_script_abort
        }

        # Handle account status
        switch $auth_info(account_status) {
            ok {
                # Continue below
            }
            default {
                # Display the message on a separate page
                ad_returnredirect [export_vars -base "[subsite::get_element -element url]register/account-closed" { { message $auth_info(account_message) } }]
                ad_script_abort
            }
        }
    }

    # If the account was closed, it might be open now
    if {[ad_conn account_status] eq "closed"} {
        auth::verify_account_status
    }
    
} -after_submit {
    if { $return_url eq "" } {
        #sim set return_url [ad_pvt_home]
	set return_url "/..";#sim
    }

    set message [_ acs-subsite.confirmation_password_changed]

    ad_returnredirect -message $message -- $return_url
    ad_script_abort
}
