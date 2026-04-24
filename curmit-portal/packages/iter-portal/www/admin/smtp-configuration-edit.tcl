ad_page_contract {

    @author Luca Romitti
    @cvs-id smtp-configuration-edit.tcl

    USER  DATA       MODIFICHE
    ===== ========== ===============================================================================
    rom01 14/12/2023 Fatto in modo che la mail per la modifica della configurazione venga mandato
    rom01            col smtp di oasi.
    
} {
    {caller   ""}
    {mode "edit"}
}
set context [list [list]]

if {[string equal $mode "edit"]} {
    set page_title "Modifica configurazione per invio e-mail"
    set buttons [list [list "Modifica" edit]]
    set field_mode display
} else {
    set page_title "Visualizza configurazione per invio e-mail"
    set buttons [list [list "OK" view]]
    set field_mode display
}

set db_name [db_get_database]

set user_id [auth::require_login] 

ad_form -name addedit \
    -mode $mode \
    -export {} \
    -edit_buttons $buttons \
    -html {enctype multipart/form-data} \
    -has_edit 1 \
    -form {
	
	# Start section2
	{-section "sec2" {legendtext "Dati per invio e-mail"} {fieldset {class legend}}}
        {smtp_server:text 
            {label {smtp_server}}
            {html {size 50 maxlength 100}}
        }
	{smtp_user:text
	    {label {smtp_user}}
	    {html {size 50 maxlength 100}}
	}
	{smtp_password:text(password)
	    {label {smtp_password}}
	    {html {size 50 maxlength 100}}
	}
	{smtp_port:text
	    {label {smtp_port}}
	    {html {size 50 maxlength 100}}
	}
    } -on_request {
	db_1row q "select * from iter_smtp_configuration"
    } -on_submit {
	
	db_transaction {
	    #"$smtp_server - $smtp_user - $smtp_password - $smtp_port"
	    if {[db_0or1row q "select smtp_server as smtp_server_old
                                    , smtp_user   as smtp_user_old
                                    , smtp_password as smtp_password_old
                                    , smtp_port as smtp_port_old 
                                 from iter_smtp_configuration
                                where (smtp_server is null or smtp_user is null or smtp_password is null or smtp_port is null)
                                   or (smtp_server   != :smtp_server
                                   or smtp_user     != :smtp_user
                                   or smtp_password != :smtp_password
                                   or smtp_port     != :smtp_port)"]} {

		#rom01set to_addr "assistenza@oasisoftware.it,spesci@oasisoftware.it"
		set to_addr "<noreply@oasisoftware.it>,<spesci@oasisoftware.it>,<lromitti@oasisoftware.it>"
		set subject "Modifica configurazione dell'invio e-mail sulla istanza $db_name"
		set body "Sulla istanza $db_name e' stata modificata la configurazione dell'invio e-mail nella tabella iter_smtp_configuration. 

La configurazione precedente era: 

smtp_server:   $smtp_server_old 
smtp_user:     $smtp_user_old 
smtp_password: $smtp_password_old 
smtp_port:     $smtp_port_old 

La nuova configurazione e': 

smtp_server:   $smtp_server 
smtp_user:     $smtp_user 
smtp_password: $smtp_password 
smtp_port:     $smtp_port 

E' necessario andare ad aggiornare al piu' presto la configurazione di Postfix."

		set from_addr "<noreplay@oasisoftware.it>"
		
		set extra_headers [list]
		
		#rom01acs_mail_lite::send -send_immediately -valid_email -to_addr $to_addr -cc_addr $cc_addr -bcc_addr "" -from_addr $from_addr -subject $subject -body $body -mime_type "text/html"
		package require smtp
		package require mime
		
		# Per praticita', preparo il comando per ottenere data ed ora da scrivere sul log
		set get_current_time {[clock format [clock seconds] -format {%Y-%m-%d %H:%M:%S}]}

		puts "[subst $get_current_time] Pre mime::initialize"
		set token [mime::initialize -canonical text/plain -string $body]

		puts "[subst $get_current_time] Pre mime::setheader"
		mime::setheader $token Subject $subject
		
		set email_server "localhost"
		set mittente $from_addr
		set destinatari $to_addr
		
		smtp::sendmessage $token \
		    -originator $mittente \
		    -header     [list From $mittente] \
		    -header     [list To   $destinatari] \
		    -servers    $email_server

		db_dml upd_smtp_conf "update iter_smtp_configuration
                                         set smtp_server   = :smtp_server
                                           , smtp_user     = :smtp_user
                                           , smtp_password = :smtp_password
                                           , smtp_port     = :smtp_port"

	
	    }
	} on_error {
	    ah::transaction_error
	}

    } -after_submit {
	ad_returnredirect -message "Dati modificati correttamente" "/iter-portal"
	ad_script_abort
    }



