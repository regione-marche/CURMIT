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
# but01 08/03/2024 Aggiunto il campo f_rete_o_extrarete.

# sim02 22/09/2020 La Regione Marche, per la privacy, ha un apposito pdf

# sim01 28/03/2019 Per motivi di sicurezza è stato aggiunto autocomplete off ai campi password

# gac01 03/10/2017 Aggiunto informativa_privacy

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

set db_name [db_get_database];#sim02
set link_privacy "/privacy";#sim02
if {[string match "*iter-portal-marche*" $db_name]} {#sim02
    set link_privacy "/iter-portal/doc/Informativa_CURMIT_Distr_Combustibile_GDPR.pdf"
}

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
    {-section "sec2" {legendtext "Dati Distributore"} {fieldset {class legend}}}
        {name:text 
            {label {Ragione sociale}}
            {html {size 50 maxlength 200}}
        }
        {fiscal_code:text,optional
            {label {Codice fiscale}}
            {html {maxlength 16}}
        }
        {iva_code:text,optional
            {label {P.IVA}}
            {html {maxlength 11}}
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
    {phone:text
        {label {Telefono}}
    }
    {fax:text,optional 
        {label {Fax}}
    }
    {mobile:text,optional 
        {label {Cellulare}}
    }
    {f_rete_o_extrarete:text(select)
	{label {Rete/Extra rete}}
	{options {{{} {}} {"RETE" r} {"EXTRA RETE" e}}}
    }
    {notes:text(textarea),optional,nospell 
            {label Note}
            {html {rows 5 cols 50 wrap soft}}
        }
    # Start section3
    {-section "sec3" {legendtext "Rappresentante Legale"} {fieldset {class legend}}}

        {rep_name:text 
            {label {Cognome}}
            {html {size 50 maxlength 200}}
        }
        {rep_first_name:text 
            {label {Nome}}
            {html {size 50 maxlength 200}}
        }
    {rep_address1:text
        {label {Indirizzo}}
        {html {size 50 maxlength 200}}
    }
    {rep_city:text
        {label {Comune}}
        {html {size 50 maxlength 40}}
    }
    {rep_address2:text,optional 
        {label {Località}}
        {html {size 50 maxlength 40}}
    }
    {rep_province:text
        {label {Provincia}}
        {html {size 5 maxlength 2}}
    }
    {rep_zipcode:text
        {label {C.A.P.}}
        {html {size 10 maxlength 5}}
    }
        {rep_fiscal_code:text,optional
            {label {Codice fiscale}}
            {html {maxlength 16}}
        }

    # Start section4 gac01 aggiunto section e informativa_privacy
    {-section "sec4" {legendtext "Privacy"} {fieldset {class legend}}}

    {informativa_privacy:text(checkbox),optional
	{label {Ha preso visione e accetta l'informativa sulla <a href=$link_privacy target="_blank">privacy</a>?}}
	{options { {"Si accetta?" "t"}}}
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

ad_form -extend -name register -on_request {
    # Populate elements from local variables
    set is_active_p t    
} -on_submit {

    set errnum 0

    set is_email_p "f"
    # check email
    if {[db_0or1row query "select party_id from parties where email = :email"]} {
	set is_email_p "t"
	set user_id $party_id
    }

    set l [string length $fiscal_code]
#    if {$l != 16 && $l != 11} {
#	template::form::set_error register fiscal_code "Lunghezza errata."
#	incr errnum
#    } else {
#	if {[db_0or1row check_fiscal_code "select 1 from iter_distributors where fiscal_code = :fiscal_code"]} {
#	    template::form::set_error register fiscal_code "Codice fiscale già presente in archivio."
#	    incr errnum
#	}
#    }

    set l [string length $iva_code]
#    if {$l != 11} {
#	template::form::set_error register iva_code "Lunghezza errata."
#	incr errnum
#    } else {
#	if {[db_0or1row check_iva_code "select 1 from iter_distributors where iva_code = :iva_code"]} {
#	    template::form::set_error register iva_code "Partita IVA già presente in archivio."
#	    incr errnum
#	}
#    }

    # controllo codice fiscale del rappresentante legale
    set l [string length $rep_fiscal_code]
#    if {$l != 16} {
#	template::form::set_error register rep_fiscal_code "Lunghezza errata."
#	incr errnum
#    } else {
#	if {[db_0or1row check_rep_fiscal_code "select 1 from iter_parties where fiscal_code = :rep_fiscal_code"]} {
#	    template::form::set_error register rep_fiscal_code "Codice fiscale già presente in archivio."
#	    incr errnum
#	}
#    }
    
    if {$informativa_privacy ne "t"} {#gac01 if e suo contenuto
        template::form::set_error register informativa_privacy "E' necessaria la presa visione della privacy"
        incr errnum
    }

    if {$errnum > 0} {
	break
    }

    db_transaction {

	if {[string equal $is_email_p "f"]} {
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
	}
	set party_id [db_string query "select coalesce(max(party_id) + 1, 1) from iter_parties"]
	# inserisco rappresentante legale
	db_dml query "
            insert into iter_parties (
                 party_id
               , name
               , first_name
               , address1
               , address2
               , city
               , province
               , zipcode
               , fiscal_code                                                                                                
               , creation_date                                                                
            ) values (
                 :party_id
               , upper(:rep_name)
               , upper(:rep_first_name)
               , upper(:rep_address1)
               , upper(:rep_address2)
               , upper(:rep_city)
               , upper(:rep_province)
               , :rep_zipcode
               , upper(:rep_fiscal_code) 
               , current_date                                                                
            )"
	
	# inserisco distributore
	db_dml cait_add "
            insert into iter_distributors (
                 distributor_id
               , representative_id
               , name
               , fiscal_code
               , iva_code
               , address1
               , address2
               , city
               , province
               , zipcode
               , phone
               , mobile
               , email
               , fax
               , notes
               , creation_date
               , f_rete_o_extrarete --but01
             ) values (
                 :user_id
               , :party_id
               , upper(:name)
               , :fiscal_code
               , :iva_code
               , upper(:address1)
               , upper(:address2)
               , upper(:city)
               , upper(:province)
               , upper(:zipcode)
               , :phone
               , :mobile
               , :email
               , :fax
               , upper(:notes)
               , current_date 
               , :f_rete_o_extrarete   --but01 
            )"
ns_log notice "\nClaudio debug"	
    } on_error {
	ad_return_template
    }
   
} -after_submit {
    
        ad_returnredirect "/iter-portal/distr/services"
        ns_log notice "\nUSER-NEW 4"
        ad_script_abort

}
