ad_page_contract {
    Menu  distributori.

    @cvs-id $Id: services_distributori.tcl,v 1.1 2024/05/15 15:00:08 nsadmin Exp $

    USER  DATA       MODIFICHE
    ===== ========== =========================================================================
   sim01 27/07/2021 Cambiato carburante in combustibile

} {

}

set user_id [auth::require_login]


#sim01 set page_title "Servizi per i Distributori di carburante registrati" 
set page_title "Servizi"
set context [list "Servizi"]
