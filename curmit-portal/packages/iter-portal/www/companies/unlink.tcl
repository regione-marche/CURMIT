ad_page_contract {
    Scollega un ispettore e lo registra come utente OpenACS

    @cvs-id $Id: unlink.tcl
} {
    inspector_id
}

set company_id [auth::require_login]

# controlla se l'ispettore è validato
db_1row inspector "select * from iter_inspectors where inspector_id = :inspector_id"

if {!$validated_p} {
    ad_returnredirect -message "L'ispettore non è scollegabile, in quanto non ancora validato." inspectors-list
    ad_script_abort
}

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
    -export {next_url user_id inspector_id return_url} \
    -edit_buttons [list [list "Registra Ispettore" new]] \
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

        # Ora devo clonare iter_inspectors rimpiazzando il vecchio codice inspector_id con il nuovo user_id,
        # impostando la nuova mail e azzerando il campo company_id.
        db_dml new "
            insert into iter_inspectors (
                 inspector_id
               , name
               , first_name
               , inspector_no
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
               , validated_p
               , validating_user
               , validating_date
               , iter_code
               , is_active_p
               , creation_user
               , creation_date 
               , editing_user
               , editing_date
               , approved_p
               , notes
               , password
               , null
            ) 
            select 
                 :user_id
               , name
               , first_name
               , inspector_no
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
               , validated_p
               , validating_user
               , validating_date
               , iter_code
               , is_active_p
               , creation_user
               , creation_date 
               , editing_user
               , editing_date
               , approved_p
               , notes
               , password
               , null
               
                from iter_inspectors 
                where inspector_id = :inspector_id"

        # ora posso cancellare il vecchio inspector
        db_dml delete "
            delete from iter_inspectors where inspector_id = :inspector_id"
	
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
        ad_returnredirect -message "L'ispettore indicato è stato scollegato." /iter-portal/companies/inspectors-list
        ns_log notice "\nUSER-NEW 4"
        ad_script_abort
    }
}
