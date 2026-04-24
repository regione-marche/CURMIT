ad_page_contract {
    Menu servizi dei manutentori.

    @cvs-id $Id: servcait.tcl,v 1.3 2019/08/28 07:45:14 nsadmin Exp $
} {

}
set nome_db [db_get_database];#rom01
set cait_id [auth::require_login]

if {![db_0or1row check_maint "select 1 from iter_cait where cait_id = :cait_id"]} {
    ad_returnredirect -message "Spiacente, ma questa pagina è riservata ai CAIT registrati." /
    ad_script_abort
}

set sw_wallet_usato_dal_portale [parameter::get_from_package_key -package_key wallet -parameter sw_usato_dal_portale -default 0]

set page_title "Servizi per i CAIT registrati"
set context [list "Servizi"]

if {[string match "*iter-portal-marche*" $db_name]} {#rom01 if else e loro contenuto
    set url_redirect "../cait/login-iter"
} else {
    set url_redirect "/iter-portal/iter-link"
};#rom01
