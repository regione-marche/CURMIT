# Present a login box
#
# Expects:
#   subsite_id - optional, defaults to nearest subsite
#   return_url - optional, defaults to Your Account
# Optional:
#   authority_id
#   username
#   email
#

# Redirect to HTTPS if so configured
if { [security::RestrictLoginToSSLP] } {
    security::require_secure_conn
}

set self_registration [parameter::get_from_package_key \
                                  -package_key acs-authentication \
			          -parameter AllowSelfRegister \
			          -default 1]   

if { ![exists_and_not_null package_id] } {
    set subsite_id [subsite::get_element -element object_id]
}

set email_forgotten_password_p [parameter::get \
                                    -parameter EmailForgottenPasswordP \
                                    -package_id $subsite_id \
                                    -default 1]

if { ![info exists username] } {
    set username {}
}

if { ![info exists email] } {
    set email {}
}

if { $email eq "" && $username eq "" && [ad_conn untrusted_user_id] != 0 } {
    acs_user::get -user_id [ad_conn untrusted_user_id] -array untrusted_user
    if { [auth::UseEmailForLoginP] } {
        set email $untrusted_user(email)
    } else {
        set authority_id $untrusted_user(authority_id)
        set username $untrusted_user(username)
    }
}




# Persistent login
# The logic is: 
#  1. Allowed if allowed both site-wide (on acs-kernel) and on the subsite
#  2. Default setting is in acs-kernel

set allow_persistent_login_p [parameter::get -parameter AllowPersistentLoginP -package_id [ad_acs_kernel_id] -default 1]
if { $allow_persistent_login_p } {
    set allow_persistent_login_p [parameter::get -package_id $subsite_id -parameter AllowPersistentLoginP -default 1]
}
if { $allow_persistent_login_p } {
    set default_persistent_login_p [parameter::get -parameter DefaultPersistentLoginP -package_id [ad_acs_kernel_id] -default 1]
} else {
    set default_persistent_login_p 0
}


set subsite_url [subsite::get_element -element url]
set system_name [ad_system_name]

if { [exists_and_not_null return_url] } {
    if { [util::external_url_p $return_url] } {
      ad_returnredirect -message "only urls without a host name are permitted" "."
      ad_script_abort
    }
} else {
    set return_url [ad_pvt_home]
}

set authority_options [auth::authority::get_authority_options]

if { ![exists_and_not_null authority_id] } {
    set authority_id [lindex [lindex $authority_options 0] 1]
}

set forgotten_pwd_url [auth::password::get_forgotten_url -authority_id $authority_id -username $username -email $email]

set register_url [export_vars -base "[subsite::get_url]register/user-new" { return_url }]
if { $authority_id eq [auth::get_register_authority] || [auth::UseEmailForLoginP] } {
    set register_url [export_vars -no_empty -base $register_url { username email }]
}

set login_button [list [list [_ acs-subsite.Log_In] ok]] ;
ad_form -name login -html {style "margin: 0px"} -show_required_p 0 -edit_buttons $login_button -action "[subsite::get_url]register/" -form {
    {return_url:text(hidden)}
    {time:text(hidden)}
    {token_id:text(hidden)}
    {hash:text(hidden)}
} 

ad_form -extend -name login -form {
    {-section "sec0" {legendtext "Login Ditta di Manutenzione/altri soggetti di regione-enti"} {fieldset {class legend}}}
}

set username_widget text
if { [parameter::get -parameter UsePasswordWidgetForUsername -package_id [ad_acs_kernel_id]] } {
    set username_widget password
}

set focus {}
if { [auth::UseEmailForLoginP] } {
    ad_form -extend -name login -form [list [list email:text($username_widget),nospell,optional [list label [_ acs-subsite.Email]] [list html [list style "width: 150px"]]]]
    set user_id_widget_name email
    if { $email ne "" } {
        set focus "password"
    } else {
        set focus "email"
    }
} else {
    if { [llength $authority_options] > 1 } {
        ad_form -extend -name login -form {
            {authority_id:integer(select) 
                {label "[_ acs-subsite.Authority]"} 
                {options $authority_options}
            }
        }
    }

    ad_form -extend -name login -form [list [list username:text($username_widget),nospell [list label [_ acs-subsite.Username]] [list html [list style "width: 150px"]]]]
    set user_id_widget_name username
    if { $username ne "" } {
        set focus "password"
    } else {
        set focus "username"
    }
}
set focus "login.$focus"
ad_form -extend -name login -form {
    {password:text(password),optional 
        {label "[_ acs-subsite.Password]"}
	{html {style "width: 150px"}}
    }
}
set options_list [list [list [_ acs-subsite.Remember_my_login] "t"]]
if { $allow_persistent_login_p } {
    ad_form -extend -name login -form {
        {persistent_p:text(checkbox),optional
            {label ""}
            {options $options_list}
	    
         }
    }
}

#but01 aggiunto la form url_verif
set url_verif "";#but01
set forgot_pw "";#but01
set forgot_pw "<a href=\"[auth::password::get_forgotten_url -authority_id $authority_id -username $username -email $email]\">Hai dimenticato la tua password?</a>"
ad_form -extend -name login -form {
    {url_verif:text(hidden),optional 
        {label ""}
	{after_html "$forgot_pw"}
    }
}

#####fai un extend dove metterai il campo codice_utente e password_utente
#rom01

ad_form -extend -name login -form {
    {-section "sec1" {legendtext "Login Operatore/amministratore di condominio"} {fieldset {class legend}}}
}


ad_form -extend -name login -form [list [list codice_utente_operatore:text($username_widget),nospell,optional [list label "Codice utente"] [list html [list style "width: 150px"]]]]

    #set user_id_widget_name codice_utente

ad_form -extend -name login -form {
    {password_operatore:text(password),optional 
        {label "Password"}
	{html {style "width: 150px"}}
    }
}
#but01 aggiunto la form url_verif
set url_verif_op "";#but01
set forgot_pw_op "";#but01
set forgot_pw_op "<a href= \"pre_recover_password\">Hai dimenticato la tua password?</a>";#but01

if {$forgot_pw_op eq "t"} {
    set forgot_pw_op "<a href= \"pre_recover_password\">Hai dimenticato la tua password?</a>";#but01
    }

ad_form -extend -name login -form {
    {url_verif_op:text(hidden),optional 
        {label ""}
	{after_html "$forgot_pw_op"}
    }

# Reset section
{-section ""}
}
    


ad_form -extend -name login -on_request {


    # Populate fields from local vars 
    

    set persistent_p [ad_decode $default_persistent_login_p 1 "t" ""]

    # One common problem with login is that people can hit the back button
    # after a user logs out and relogin by using the cached password in
    # the browser. We generate a unique hashed timestamp so that users
    # cannot use the back button.
    
    set time [ns_time]
    set token_id [sec_get_random_cached_token_id]
    set token [sec_get_token $token_id]
    set hash [ns_sha1 "$time$token_id$token"]
    
} -on_submit {

    #se sono valorizzati entrambi i campi blocco e scrivo "Impossibile collegarsi sia come ditta di manutenzione che 
    #come operatore"
    if {$email ne "" && $codice_utente_operatore ne "" } {
	template::form::set_error login email "Impossibile collegarsi contemporaneamente sia come ditta di manutenzione che come operatore"
	break
    }
   
    if {$email ne "" && $password eq ""} {

	template::form::set_error login password "Inserire password"
	break

    }

    if {$codice_utente_operatore ne "" && $password_operatore eq ""} {

        template::form::set_error login password_operatore "Inserire password"
        break
    }


    #se email inizia per MA e non contiene il carattere @ lo blocco perchè è un operatore
    if {$email ne "" && [string range $email 0 1] eq  "MA" && [regsub -all "@" $email "l" email] == 0} {
	template::form::set_error login email "L'utente indicato deve loggarsi come operatore"
	break
    }

    if {$email ne "" && [string range $email 0 1] eq  "AM" && [regsub -all "@" $email "l" email] == 0} {
	template::form::set_error login email "L'utente indicato deve loggarsi come amministratore"
	break
    }

    #se codice_operatore not like 'MA' e contiene il carattere @ lo blocco perchè è l'utente della ditta di manutenzione
    if {$codice_utente_operatore ne "" && (([string range $codice_utente_operatore 0 1] ne "MA" && [string range $codice_utente_operatore 0 1] ne "AM") || [regsub -all "@" $email "l" email] != 0)} {
        template::form::set_error login codice_utente_operatore "L'utente deve loggarsi come ditta di manutenzione"
	break
    }
        
    set login_operatore "f"
    # se mi loggo come operatore, per non cambiare le funzionalità sotto valorizzo i vecchi campi col valore presente
    # nel nuovo login
    if { $codice_utente_operatore ne "" && $password_operatore ne ""} {
	set email $codice_utente_operatore
	set password $password_operatore
	set login_operatore "t"
    }

    # Check timestamp
    set token [sec_get_token $token_id]
    set computed_hash [ns_sha1 "$time$token_id$token"]
    
    set expiration_time [parameter::get -parameter LoginPageExpirationTime -package_id [ad_acs_kernel_id] -default 600]
    if { $expiration_time < 30 } { 
        # If expiration_time is less than 30 seconds, it's practically impossible to login
        # and you will have completely hosed login on your entire site
        set expiration_time 30
    }

    if { $hash ne $computed_hash  || \
             $time < [ns_time] - $expiration_time } {
        ad_returnredirect -message [_ acs-subsite.Login_has_expired] -- [export_vars -base [ad_conn url] { return_url }]
        ad_script_abort
    }

    if { ![exists_and_not_null authority_id] } {
        # Will be defaulted to local authority
        set authority_id {}
    }

    if { ![exists_and_not_null persistent_p] } {
        set persistent_p "f"
    }
    if {![element exists login email]} {
	set email [ns_queryget email ""]
    }
    set first_names [ns_queryget first_names ""]
    set last_name [ns_queryget last_name ""]
    
    array set auth_info [auth::authenticate \
                             -return_url $return_url \
                             -authority_id $authority_id \
                             -email [string trim $email] \
                             -first_names $first_names \
                             -last_name $last_name \
                             -username [string trim $username] \
                             -password $password \
                             -persistent=[expr {$allow_persistent_login_p && [template::util::is_true $persistent_p]}]]
    
    # Handle authentication problems
    switch $auth_info(auth_status) {
        ok {
            # Continue below
        }
        bad_password {

	    if {$login_operatore eq "f"} {
            form set_error login password $auth_info(auth_message)
	    } else {
		form set_error login password_operatore $auth_info(auth_message)
	    }
            break
        }
        default {
	    if {$login_operatore eq "f"} {
            form set_error login $user_id_widget_name $auth_info(auth_message)
	    } else {
		form set_error login codice_utente_operatore $auth_info(auth_message)
	    }
            break
        }
    }
    if { [exists_and_not_null auth_info(account_url)] } {
        ad_returnredirect $auth_info(account_url)
        ad_script_abort
    }

    # Handle account status
    switch $auth_info(account_status) {
        ok {
            # Continue below
        }
        default { 
	    # if element_messages exists we try to get the element info
	    if {[info exists auth_info(element_messages)]
		&& [auth::authority::get_element \
			-authority_id $authority_id \
			-element allow_user_entered_info_p]} {
		foreach message [lsort $auth_info(element_messages)] {
		    ns_log notice "LOGIN $message"
		    switch -glob -- $message {
			*email* {
 			    if {[element exists login email]} {
 				set operation set_properties
 			    } else {
 				set operation create
 			    }
			    element $operation login email -widget $username_widget -datatype text -label [_ acs-subsite.Email]
			    if {[element error_p login email]} {
				template::form::set_error login email [_ acs-subsite.Email_not_provided_by_authority]
			    }
			}
			*first* {
			    element create login first_names -widget text -datatype text -label [_ acs-subsite.First_names]
			    template::form::set_error login email [_ acs-subsite.First_names_not_provided_by_authority]
			}
			*last* {
			    element create login last_name -widget text -datatype text -label [_ acs-subsite.Last_name]
			    template::form::set_error login last_name [_ acs-subsite.Last_name_not_provided_by_authority]
			}
		    }
		}
		set auth_info(account_message) ""
		    
		ad_return_template
		
	    } else {
		# Display the message on a separate page
            ad_returnredirect \
                -message $auth_info(account_message) \
                -html \
                [export_vars \
                     -base "[subsite::get_element \
                                -element url]register/account-closed"]
		ad_script_abort
	    }
        }
    }
} -after_submit {
    #rom01 cablaggio fatto per collegare gli operatori drettamente dal portale a iter. DA TOGLIERE !!!! 
    if {[db_0or1row q "select 1
                        where (:email like 'MA%' or :email like 'AM%')
                          and :email not like '%@%'
"]} {#rom01 if e suo contenuto 
	
	set db_name [parameter::get_from_package_key -package_key iter -parameter dbname_portale -default ""]
	set id_utente $email

	#rom02 Se è attivo il parametro login_operatore_codice_fiscale e se trovo più record sulla iter_operators
	#rom02 con lo stesso fiscal_code dal codice operatore passato allora non vado direttamente al single-sign-on
	#rom02 ma faccio scegliere all'operatore con quale utenza a lui associata per codice fiscale vuole loggarsi.
	set login_operatore_codice_fiscale [parameter::get_from_package_key -package_key iter-portal -parameter login_operatore_codice_fiscale -default "0"]
	if {$login_operatore_codice_fiscale == 1 &&
	    [db_0or1row q "select count(*)
                             from iter_operators o
                            where o.fiscal_code = (
                                  select o2.fiscal_code
                                    from iter_operators o2
                                   where o2.iter_no = :id_utente
                                  )
                              and o.iter_no != :id_utente
                           having count(*) > 0"]} {#rom02 Aggiunta if e il suo contenuto

	    set url_redirect "/iter-portal/single-sign-on-chose-uten?id_utente=$id_utente"

	} else {#rom02 Aggiunta else ma non il contenuto

	    set token_code_new $id_utente[randomRange 99999999] 

	    db_dml q "update iter_login
                     set token_code       = :token_code_new
                       , data_last_login  = current_timestamp
                   where utente           = :id_utente"

	    # trovo il subsite
	    array set arr [site_node::get_from_url -url /]
	    set context_id $arr(package_id)

	    # ottengo il gruppo a cui appartengono, con relazione di
	    # composizione, tutti gli altri gruppi 
	    set subsite_group_id [application_group::group_id_from_package_id -package_id $context_id]

	    set url [db_string a "select p.url
    from acs_rels r, groups g, parties p, iter_instances i
    where r.rel_type='composition_rel' and 
          r.object_id_one = :subsite_group_id and 
          r.object_id_two = g.group_id and
          g.group_id      = p.party_id and
          g.group_id      = i.instance_id
    order by group_name
    limit 1"]

	    ns_log notice "luca21 context_id:$context_id subsite_group_id:$subsite_group_id url:$url"
	    set url_redirect "$url/iter/single-sign-on?id_utente=$id_utente&token_code=$token_code_new&caller=portale"

	};#rom02

	ns_log notice "luca23 url_redirect: $url_redirect"

	#prima di fare il redirect alla pagina di login su iter sloggo l'utente dal portale. 
	#In questo modo se rientra non è loggato come operatore e può consultarlo senza vedere i link che sono prori 
	#della ditta di manutenzione
	ad_user_logout
	db_release_unused_handles
	
	ns_returnredirect $url_redirect

    };#ROM01

    # We're logged in
    
    # Handle account_message
    if { [exists_and_not_null auth_info(account_message)] } {
        ad_returnredirect [export_vars -base "[subsite::get_element -element url]register/account-message" { { message $auth_info(account_message) } return_url }]
        ad_script_abort
    }  else {
	if {![info exists auth_info(element_messages)]} {
	    # No message
	    ad_returnredirect $return_url 
	    ad_script_abort
	    
	}
    }
    
    
    
}
