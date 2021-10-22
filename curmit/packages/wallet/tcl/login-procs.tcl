ad_library {

    Holders Procs.

    @author claudio.pasolini@comune.mantova.it
    @cvs-id $Id:

}

ad_proc -public wallet_check_login {
} { 
} {

    set ip_chiamante              [ns_set iget [ns_conn headers] X-Real-IP]
    set lista_ip_server_chiamanti [parameter::get_from_package_key -package_key wallet -parameter ip_server_chiamanti]

    if {$ip_chiamante ni $lista_ip_server_chiamanti} {
    
	ns_return 200 text/plain [list "La chiamata al web-service di wallet non puo' essere effettuata da questo ip: $ip_chiamante" 0 0 [list]]
	ad_script_abort
    }
    
}
