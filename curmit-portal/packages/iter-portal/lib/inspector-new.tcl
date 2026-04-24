# Expects parameters:
#
# self_register_p - Is the form for users who self register (1) or
#                   for administrators who create other users (0)?
# next_url        - Any url to redirect to after the form has been submitted. The
#                   variables user_id, password, and account_messages will be added to the URL. Optional.
# email           - Prepopulate the register form with given email. Optional.
# return_url      - URL to redirect to after creation, will not get any query vars added
# rel_group_id    - The name of a group which you want to relate this user to after creating the user.
#                   Will add an element to the form where the user can pick a relation among the permissible 
#                   rel-types for the group.

# USER  DATA       MODIFICHE
# ===== ========== ==============================================================================
# sim01 28/03/2019 Per motivi di sicurezza è stato aggiunto autocomplete off ai campi password

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

ad_form -name register \
    -export {next_url user_id return_url} \
    -edit_buttons [list [list "Avvia Registrazione" new]] \
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
	    {html {size 20 autocomplete off}}
	}
	{password_confirm:text(password)
	    {label {Conferma Password:}}
	    {html {size 20 autocomplete off}}
	}
	{screen_name:text(hidden),optional}
	{url:text(hidden),optional}
	{secret_question:text(hidden),optional value {}}
	{secret_answer:text(hidden),optional value {}}

	# Start section2
	{-section "sec2" {legendtext "Dati Ispettore"} {fieldset {class legend}}}
	{name:text 
	    {label {Cognome/Ragione sociale}}
	    {html {size 50 maxlength 200}}
	}
	{first_name:text 
	    {label {Nome}}
	    {html {size 50 maxlength 200}}
	}
	{address1:text
	    {label {Indirizzo}}
	    {html {size 50 maxlength 200}}
	}
	{city:text
	    {label {Comune}}
	    {html {size 50 maxlength 40}}
	}
	{address2:text,optional 
	    {label {Località}}
	    {html {size 50 maxlength 40}}
	}
	{province:text
	    {label {Provincia}}
	    {html {size 5 maxlength 2}}
	}
	{zipcode:text
	    {label {C.A.P.}}
	    {html {size 10 maxlength 5}}
	}
	{course_type:text(radio)
	    {label {Tipo corso frequentato}}
	    {options { {"Enea" E} {"Ente Locale" L} }}
	}
	{course_resp:text,optional
	    {label {Ente responsabile del corso}}
	    {help_text {Obbligatorio se il corso è stato organizzato da un Ente Locale}}
	}
	{course_certif:text
	    {label {Attestato del corso}}
	}
	{fiscal_code:text
	    {label {Codice fiscale}}
	    {html {maxlength 16}}
	}
	{iva_code:text
	    {label {P.IVA}}
	    {html {maxlength 11}}
	}
	{phone:text
	    {label {Telefono}}
	}
	{fax:text,optional 
	    {label {Fax}}
	}
	{mobile:text,optional 
	    {label {Cellulare}}
	}
	{notes:text(textarea),optional,nospell 
	    {label Note}
	    {html {rows 5 cols 50 wrap soft}}
	}

	# Start section5
	{-section "sec5" {legendtext "Analizzatori di Combustione (registrarne almeno 1)"} {fieldset {class legend}}}

        {an_brand:text 
            {label {Marca}}
            {html {size 50 maxlength 200}}
        }
        {an_model:text 
            {label {Modello}}
            {html {size 50 maxlength 200}}
        }
        {an_no:text 
            {label {Matricola}}
            {html {size 50 maxlength 200}}
        }
        {an_last_calibration_date_pretty:text 
            {label {Data Ultima Taratura (gg/mm/aaaa)}}
            {html {size 10 maxlength 10}}
        }

	# Start section6
	{-section "sec6" {legendtext "Deprimometri (registrarne almeno 1)"} {fieldset {class legend}}}

        {de_brand:text 
            {label {Marca}}
            {html {size 50 maxlength 200}}
        }
        {de_model:text 
            {label {Modello}}
            {html {size 50 maxlength 200}}
        }
        {de_no:text 
            {label {Matricola}}
            {html {size 50 maxlength 200}}
        }
        {de_last_calibration_date_pretty:text 
            {label {Data Ultima Taratura (gg/mm/aaaa)}}
            {html {size 10 maxlength 10}}
        }

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

    if {$course_type eq "L" && $course_resp eq ""} {
        template::form::set_error register course_resp "Campo obbligatorio"
	incr errnum
    }
    
    if {$fiscal_code ne ""} {
	set l [string length $fiscal_code]
	if {$l != 16 && $l != 11} {
	    template::form::set_error register fiscal_code "Lunghezza errata."
	    incr errnum
	} else {
	    if {[db_0or1row check_fiscal_code "select 1 from iter_inspectors where fiscal_code = :fiscal_code"]} {
		template::form::set_error register fiscal_code "Codice fiscale già presente in archivio."
		incr errnum
	    }
	}
    }

    if {$iva_code ne ""} {
	set l [string length $iva_code]
	if {$l != 11} {
	    template::form::set_error register iva_code "Lunghezza errata."
	    incr errnum
	} else {
	    if {[db_0or1row check_iva_code "select 1 from iter_inspectors where iva_code = :iva_code"]} {
		template::form::set_error register iva_code "Partita IVA già presente in archivio."
		incr errnum
	    }
	}
    }

    set an_last_calibration_date [ah::check_date -input_date $an_last_calibration_date_pretty]
    if {$an_last_calibration_date eq "0"} {
	template::form::set_error register an_last_calibration_date_pretty  "Data errata."
	incr errnum
    }

    set de_last_calibration_date [ah::check_date -input_date $de_last_calibration_date_pretty]
    if {$de_last_calibration_date eq "0"} {
	template::form::set_error register de_last_calibration_date_pretty  "Data errata."
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
	    ns_log notice "\ninspector_new errore imprevisto: creation_status=$creation_info(creation_status)"
	    # abort
	    nonsense
	}

	db_dml query "
            insert into iter_inspectors (
                 inspector_id
               , name
               , first_name
               , address1
               , address2
               , city
               , province
               , zipcode
               , course_type
               , course_resp
               , course_certif
               , fiscal_code
               , iva_code
               , phone
               , mobile
               , email
               , fax
               , is_active_p
               , notes
               , creation_date                                                                
               , validated_p
               , approved_p
            ) values (
                 :user_id
               , upper(:name)
               , upper(:first_name)
               , upper(:address1)
               , upper(:address2)
               , upper(:city)
               , upper(:province)
               , upper(:zipcode)
               , :course_type
               , upper(:course_resp)
               , :course_certif
               , upper(:fiscal_code)
               , :iva_code
               , :phone
               , :mobile
               , :email
               , :fax
               , 't'
               , upper(:notes)
               , current_date                                                                
               , 'f'
               , 'f'
            )"
ns_log notice "\nSERENA"
	set tool_id [db_string query "select coalesce(max(tool_id) + 1, 1) from iter_inspectors_tools"]
	# inserisco analizzatore di combustione
	db_dml tool1 "
            insert into iter_inspectors_tools (
                 tool_id   
               , type
               , inspector_id
               , brand
               , model
               , no
               , last_calibration_date
               , creation_date
            ) values (
                 :tool_id
               , '0'
               , :user_id 
               , upper(:an_brand)
               , upper(:an_model)
               , upper(:an_no)            
               , :an_last_calibration_date
               , current_date
            )"

ns_log notice "\nSERENA1"
	set tool_id [db_string query "select coalesce(max(tool_id) + 1, 1) from iter_inspectors_tools"]
	# inserisco analizzatore di combustione
	db_dml tool2 "insert into iter_inspectors_tools (tool_id, type, inspector_id, brand, model, no, last_calibration_date, creation_date) values (:tool_id, '1', :user_id, upper(:de_brand), upper(:de_model), upper(:de_no), :de_last_calibration_date, current_date)"
ns_log notice "\nSERENA2"
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
	ad_returnredirect "/iter-portal/inspectors/services"
	ns_log notice "\nUSER-NEW 4"
	ad_script_abort
    }
}
