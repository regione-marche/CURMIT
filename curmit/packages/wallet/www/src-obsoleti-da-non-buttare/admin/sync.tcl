ad_page_contract {
    
    Sincronizza ambienti
    
    @cvs-id $Id: sync.tcl
} {
    
}

ad_script_abort

apm_parameter_register sisal_ftp_ip "Indirizzo IP del ftp server di Sisal" wallet "80.88.171.35" string 

apm_parameter_register sisal_ftp_user "ftp user name" wallet "Cestec" string 

apm_parameter_register sisal_ftp_password "ftp password" wallet "Cestec" string 

ns_return 200 text/html "Parametri registrati"
