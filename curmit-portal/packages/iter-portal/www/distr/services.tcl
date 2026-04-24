ad_page_contract {
    Menu servizi dei distributori.

    @cvs-id $Id: services.tcl,v 1.2 2021/07/27 15:06:33 nsadmin Exp $

    USER  DATA       MODIFICHE
    ===== ========== =========================================================================
    sim01 27/07/2021 Cambiato carburante in combustibile

} {

}

set user_id [auth::require_login]

    if {![db_0or1row check_maint "select 1 from iter_distributors where distributor_id = :user_id"]} {
	ad_returnredirect -message "Spiacente, ma questa pagina è riservata ai distributori registrati." /
	ad_script_abort
    }

#sim01 set page_title "Servizi per i Distributori di carburante registrati" 
set page_title "Servizi per i Distributori di combustibile registrati";#sim01
set context [list "Servizi"]
