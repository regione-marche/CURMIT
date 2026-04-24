ad_page_contract {
    Scollega un manutentore e lo registra come utente OpenACS

    @cvs-id $Id: unlink.tcl
} {
    maintainer_id
    {caller ""}
}

set cait_id [auth::require_login]

# controlla se il manutentore è validato
db_1row maint "select * from iter_maintainers where maintainer_id = :maintainer_id"

if {!$validated_p} {
    ad_returnredirect -message "Il manutentore non è scollegabile, in quanto non ancora validato." maintainers-list
    ad_script_abort
}

if {[ad_system_name] eq "curit-dev"} {
    set db_name "wallet-dev"
} else {
    set db_name "wallet"
}

#
# In certi casi il manutentore potrebbe avere aderito al Cait dopo essersi registrato come manutentore.
# In questo caso esiste già l'utente OpenACS in stato 'deleted' ed 'è quindi sufficiente ripristinarlo
# ed eliminare il riferimento al cait dalla sua anagrafica.
#
if {[db_0or1row check_user "select 1 from parties where party_id = :maintainer_id"]} {
    # ripristino lo stato dell'utente ad 'approved'
    if {[catch {
	acs_user::change_state -user_id $maintainer_id -state approved
    } errmsg]} {
	ad_return_error "Errore durante l'aggiornamento" "unlink.tcl - L'aggiornamento del database è fallito 
                         con il seguente errore:<pre>$errmsg</pre>"
    }

    # elimino riferimento a cait
    db_dml unref "update iter_maintainers set cait_id = null where maintainer_id = :maintainer_id"

    if {$caller eq ""} {
	ad_returnredirect -message "Il manutentore indicato è stato scollegato." /iter-portal/cait/maintainers-list
    } else {
	ad_returnredirect -message "Il manutentore indicato è stato scollegato." /iter-portal/services
    }

    ad_script_abort
}    

# ora posso inserire l'utente

# Set default parameter values
array set parameter_defaults {
    self_register_p 0
    next_url {}
    return_url {}
}
foreach parameter [array names parameter_defaults] { 
    if { ![exists_and_not_null $parameter] } { 
        set $parameter $parameter_defaults($parameter)
    }
}

# Log user out if currently logged in, if specified in the includeable chunk's parameters, 
# e.g. not when creating accounts for other users
if { $self_register_p } {
    ad_user_logout 
}

# Pre-generate user_id for double-click protection
set user_id [db_nextval acs_object_id_seq]

ad_form -name register \
    -export {next_url user_id maintainer_id return_url} \
    -edit_buttons [list [list "Registra Manutentore" new]] \
        -has_edit 1 \
    -form {

    # Start section1
    {-section "sec1" {legendtext "Dati Utente"} {fieldset {class legend}}}

	{email:email(text)
	    {label Email}
	    {html {size 30}}
	}
	{username:text(hidden),optional
	    value {}
	}
	{first_names:text(text)
	    {label {Nome/i di battesimo}}
	    {html {size 30}}
	}
	{last_name:text(text)
	    {label Cognome}
	    {html {size 30}}
	}
	{password:text(password)
	    {label Password:}
	    {html {size 20}}
	}
	{password_confirm:text(password)
	    {label {Conferma Password:}}
	    {html {size 20}}
	}
	{screen_name:text(hidden),optional}
	{url:text(hidden),optional}
	{secret_question:text(hidden),optional value {}}
	{secret_answer:text(hidden),optional value {}}

    # Reset section
    {-section ""}
}

if { [exists_and_not_null rel_group_id] } {
    ad_form -extend -name register -form {
        {rel_group_id:integer(hidden),optional}
    }
    
    if { [permission::permission_p -object_id $rel_group_id -privilege "admin"] } {
        ad_form -extend -name register -form {
            {rel_type:text(select)
                {label "Role"}
                {options {[group::get_rel_types_options -group_id $rel_group_id]}}
            }
        }
    } else {
        ad_form -extend -name register -form {
            {rel_type:text(hidden)
                {value "membership_rel"}
            }
        }
    }
}

ad_form -extend -name register -on_submit {

    set errnum 0

    # check email
    if {[db_0or1row query "select 1 from parties where email = :email"]} {
        template::form::set_error register email "Utente già registrato (E-mail già presente in archivio)."
	incr errnum
    }

    if {$errnum > 0} {
	break
    }
    set current_date [db_string query "select to_char(current_date, 'YYYY-MM-DD')"] 
    db_transaction {

        # anticipo la creazione dello user OpenACS
        array set creation_info [auth::create_user \
                                     -user_id $user_id \
                                     -verify_password_confirm \
                                     -username $username \
                                     -email $email \
                                     -first_names $first_names \
                                     -last_name $last_name \
                                     -screen_name $screen_name \
                                     -password $password \
                                     -password_confirm $password_confirm \
                                     -url $url \
                                     -secret_question $secret_question \
                                     -secret_answer $secret_answer]
	
        if { [string equal $creation_info(creation_status) "ok"] && [exists_and_not_null rel_group_id] } {
            group::add_member \
                -group_id $rel_group_id \
                -user_id $user_id \
                -rel_type $rel_type
        }

	# Handle registration problems
	if {$creation_info(creation_status) ne "ok"} {
		# abort
		nonsense
	}

        # Ora devo clonare iter_maintainers rimpiazzando il vecchio codice mantainer_id con il nuovo user_id,
        # impostando la nuova mail e azzerando il campo cait_id.
        db_dml new "
            insert into iter_maintainers (
                 maintainer_id
               , name
               , address1
               , address2
               , city
               , province
               , zipcode
               , fiscal_code                                                                                                
               , iva_code
               , phone
               , mobile
               , email
               , fax
               , associated_to                                                                
               , where_registered                
               , registration_no                                
               , where_rea
               , rea_no
               , capital
               , role
               , representative_id                                                
               , notes
               , lotto_no
               , validated_p
               , validating_user
               , validating_date
               , iter_code 
               , company_type 
               , is_active_p
               , creation_user
               , creation_date 
               , editing_user
               , editing_date
               , op_number
               , an_number
               , de_number
               , approved_p
               , cait_id 
               , wallet_id
               , iban_code
               , cc_name
            ) 
            select 
                 :user_id
               , name
               , address1
               , address2
               , city
               , province
               , zipcode
               , fiscal_code                                                                                                
               , iva_code
               , phone
               , mobile
               , :email
               , fax
               , associated_to                                                                
               , where_registered                
               , registration_no                                
               , where_rea
               , rea_no
               , capital
               , role
               , representative_id                                                
               , notes
               , lotto_no
               , validated_p
               , validating_user
               , validating_date
               , iter_code 
               , company_type 
               , is_active_p
               , creation_user
               , creation_date 
               , editing_user
               , :current_date
               , op_number
               , an_number
               , de_number
               , approved_p
               , null
               , wallet_id
               , iban_code
               , cc_name

                from iter_maintainers 
                where maintainer_id = :maintainer_id"

	# ora posso aggiornare iter_operators e iter_tools con il nuovo codice
	db_dml operators "
            update iter_operators set
                maintainer_id = :user_id
            where maintainer_id = :maintainer_id"

	db_dml tools "
            update iter_tools set
                maintainer_id = :user_id
            where maintainer_id = :maintainer_id"
     

        # inserisco il nuovo holder sul portafoglio
	    db_dml -dbn $db_name new_holder "
            insert into wal_holders (
                holder_id
               ,wallet_id
               ,source_id
               ,filename
               ,name
               ,fiscal_code
               ,iva_code
               ,city
               ,cestec_user_name
               ,iban
               ,sisal_filename
            )
             select
               :user_id
              ,'x'
              ,source_id
              ,filename
              ,name
              ,fiscal_code
              ,iva_code
              ,city
              ,cestec_user_name
              ,iban
              ,sisal_filename
             
            from wal_holders
            where holder_id = :maintainer_id 
            "
        # aggiorno le transazioni con il codice del nuovo holder
        db_dml -dbn $db_name update "
            update wal_transactions set holder_id = :user_id where holder_id = :maintainer_id"
        # cancello il vecchio holder
        db_dml -dbn $db_name delete "
            delete from wal_holders where holder_id = :maintainer_id"
        # aggiorno il wallet_id sul nuovo holder
        db_dml -dbn $db_name update "
            update wal_holders set wallet_id = :wallet_id where holder_id = :user_id"
        # ora posso cancellare il vecchio maintainer
        db_dml delete "
            delete from iter_maintainers where maintainer_id = :maintainer_id"
	
    } on_error {
	ad_return_template
    }
   
} -after_submit {
    
    if { ![empty_string_p $next_url] } {
        # Add user_id and account_message to the URL
        
        ad_returnredirect [export_vars -base $next_url {user_id password {account_message $creation_info(account_message)}}]
        ns_log notice "\nUSER-NEW 1"
        ad_script_abort
    } 
    
    
    # User is registered and logged in
    if { ![exists_and_not_null return_url] } {
        # Redirect to subsite home page.
        set return_url [subsite::get_element -element url]
        ns_log notice "\nUSER-NEW 2"
    }
    
    # If the user is self registering, then try to set the preferred
    # locale (assuming the user has set it as a anonymous visitor
    # before registering).
    if { $self_register_p } {
	# We need to explicitly get the cookie and not use
	# lang::user::locale, as we are now a registered user,
	# but one without a valid locale setting.
	set locale [ad_get_cookie "ad_locale"]
	if { ![empty_string_p $locale] } {
	    lang::user::set_locale $locale
	    ad_set_cookie -replace t -max_age 0 "ad_locale" ""
	}
    }
    
    # Handle account_message
    if { ![empty_string_p $creation_info(account_message)] && $self_register_p } {
        # Only do this if user is self-registering
        # as opposed to creating an account for someone else
        ad_returnredirect [export_vars -base "[subsite::get_element -element url]register/account-message" { { message $creation_info(account_message) } return_url }]
        ns_log notice "\nUSER-NEW 3"
        ad_script_abort
    } else {
        # No messages
        ad_returnredirect -message "Il manutentore indicato è stato scollegato ah." /iter-portal/cait/maintainers-list
        ns_log notice "\nUSER-NEW 4"
        ad_script_abort
    }
}
