ad_page_contract {
    Page for users to register themselves on the site.
    @author Gacalin Lufi
    @cvs-id $Id: citizen-new.tcl,v 1.1 2019/08/27 08:14:53 nsadmin Exp $
} {
    {email ""}
    {return_url [ad_pvt_home]}
    documento:trim,optional
    documento.tmpfile:tmpfile,optional
}

set email ""
set password ""

set registration_url [parameter::get -parameter RegistrationRedirectUrl]
if {![string eq "" $registration_url]} {
    ad_returnredirect $registration_url
}


# Check if user can self register
auth::self_registration

# Set default parameter values
array set parameter_defaults {
    self_register_p 1
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

# l'utente ha diritti di admin sul package?
set admin_p [permission::permission_p \
                 -no_login \
                 -object_id [ad_conn package_id] \
                 -privilege admin
	    ]

ad_form -name register \
    -export {next_url user_id return_url} \
    -edit_buttons [list [list "Avvia Registrazione" new]] \
    -has_edit 1 \
    -html {enctype multipart/form-data} \
    -form {
	
	{-section "sec1" {legendtext "Dati Cittadino"} {fieldset {class legend}}}

	{first_names:text(text)
	    {label {Nome}}
	    {html {size 30}}
	}
	{last_name:text(text)
	    {label Cognome}
	    {html {size 30}}
	}
        {fiscal_code:text
            {label {Codice fiscale}}
            {html {maxlength 16}}
        }
	{email:email(text)
	    {label Email}
	    {html {size 30}}
	}
	{username:text(hidden),optional
	    value {}
	}

	{screen_name:text(hidden),optional}
        {url:text(hidden),optional}
	{secret_question:text(hidden),optional value {}}
	{secret_answer:text(hidden),optional value {}}

	{mobile:text,optional
	    {label {Cellulare}}
	}
	{password:text(password)
	    {label Password:}
	    {html {size 20}}
	}
	{password_confirm:text(password)
	    {label {Conferma Password:}}
	    {html {size 20}}
	}

	{-section "sec2" {legendtext "Informativa sulla privacy"} {fieldset {class legend}}}

	{informativa_privacy:text(checkbox),optional
	    {label {Ha preso visione e accetta l'informativa sulla <a href="/privacy" target="_blank">privacy</a>?}}
	    {options { {"Si accetta?" "t"}}}
	}	    

	# Reset section
	{-section ""}
    }

if { [exists_and_not_null rel_group_id] } {
    ad_form -extend -name register -form {
        {rel_group_id:integer(hidden),optional}
    }
}

ad_form -extend -name register -on_request {
    # Populate elements from local variables
    set is_active_p t    
} -on_submit {
    
    set errnum 0
    
    # check email
    if {[string is space $email]} {
	template::form::set_error register email "Inserire email"
	incr errnum
    }
    
    if {[db_0or1row query "select 1 from iter_citizens where email = :email"]} {
        template::form::set_error register email "Utente già registrato (E-mail già presente in archivio)."
	incr errnum
    }
        
    if {[string is space $password]} {
	template::form::set_error register password "Inserire password"
        incr errnum
    }
    
    if {$password ne $password_confirm} {
        template::form::set_error register password "Le password inserite non coincidono tra loro."
        incr errnum
    }

    if {![string is space $fiscal_code]} {
	set l [string length $fiscal_code]
	if {$l != 16 && $l != 11} {
	    template::form::set_error register fiscal_code "Lunghezza errata."
	    incr errnum
	} elseif {$l == 16 && [iter::verifyfc -xcodfis $fiscal_code] == 0} {
	    template::form::set_error register fiscal_code "Codice Fiscale errato."
	    incr errnum
	} elseif {$l == 11 && [iter::verifyvc -xcodfis $fiscal_code] == 0} {
	    template::form::set_error register fiscal_code "Codice Fiscale errato."
	    incr errnum
	} else {
	    if {[db_0or1row check_fiscal_code "select 1 from iter_citizens where fiscal_code = :fiscal_code limit 1"]} {
		template::form::set_error register fiscal_code "Codice fiscale già presente in archivio."
		incr errnum
	    }
	}
    } else {
	template::form::set_error register fiscal_code "Inserire codice fiscale"
    }
    
#    if {[string is space $mobile]} {
#	template::form::set_error register mobile "Inserire cellulare"
#    }
    
    if {$informativa_privacy ne "t"} {#gac01 if e suo contenuto
	template::form::set_error register informativa_privacy "E' necessaria la presa visione della privacy"
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
	
        ns_log notice "\nuser-new: creation_info=$creation_info(creation_status)"

        if { [string equal $creation_info(creation_status) "ok"] && [exists_and_not_null rel_group_id] } {

            group::add_member \
                -group_id $rel_group_id \
                -user_id $user_id 
	        	    
	}

	set group_id [db_string q "select group_id 
                                     from groups 
                                    where group_name ='Cittadino'"]
	    group::add_member \
		-group_id $group_id \
		-user_id $user_id 

	#creation_info(creation_status)
	# Handle registration problems
	if {$creation_info(creation_status) ne "ok"} {
	    # abort
	    nonsense

	}
	
	# inserisco cittadino
	db_dml citizen_add "
            insert into iter_citizens (
                 citizen_id   
               , first_name
               , last_name    
               , mobile        
               , fiscal_code 
               , email  
            ) values (
                 :user_id
               , upper(:first_names)
               , upper(:last_name)
               , :mobile        
               , upper(:fiscal_code)
               , :email
            )"
	
    } on_error {
	##	ad_return_template 
	$errmsg
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
        ad_returnredirect "/iter-portal/citizen-services?caller=new"
        ns_log notice "\nUSER-NEW 4"
        ad_script_abort
    }
}
