# /www/register/logout.tcl

ad_page_contract {
    Logs a user out

    @cvs-id $Id: logout.tcl,v 1.4 2007/01/10 21:22:09 gustafn Exp $


    USER  DATA       MODIFICHE
    ===== ========== ========================================================================
    nic01 13/11/2018 Se un utente si e' collegato con Cohesion, e' possibile fare la solita
    nic01            ad_user_logout ma devo fare anche un redirect particolare a Cohesion.
} {
    {return_url ""}
}

ns_log Notice "packages/acs-subsite/www/register/logout;inizio";#nic01

if { $return_url eq "" } {
    if { [permission::permission_p -object_id [subsite::get_element -element package_id] -party_id 0 -privilege read] } {
        set return_url [subsite::get_element -element url]
    } else {
        set return_url /
    }
}

ad_user_logout 
db_release_unused_handles


set token_cohesion [ad_get_client_property iter token_cohesion];#nic01
if {$token_cohesion ne ""} {#nic01: aggiunta if e suo contenuto
    # Leggo dinamicamente il parametro del kernel SystemURL che viene impostato da
    # /admin/site-map Kernel
    # Dovrebbe contenere, ad esempio https://portal-marche-dev.iter-web.it
    set SystemURL    [parameter::get_from_package_key -package_key acs-kernel -parameter SystemURL -default ""]

    # Ora imposto la ReturnUrl alla quale Cohesion deve tornare dopo aver fatto logout
    set ReturnUrl    $SystemURL

    # Ho fatto milioni di tentativi ma l'unico che funziona e' il seguente con ip pubblico
    # cablato (col dns e con https non funziona).
    set ip_pubblico  [iter::get_ip_pubblico]
    set redirect_url [export_vars -base "http://$ip_pubblico:8080/CohesionServlet/Logout" {ReturnUrl}]

    ns_log Notice "packages/acs-subsite/www/register/logout;per Cohesion, faccio ad_returnredirect -allow_complete_url $redirect_url"

    ad_returnredirect -allow_complete_url $redirect_url

    ns_log Notice "packages/acs-subsite/www/register/logout;Fine"
    ad_script_abort
}

ad_returnredirect $return_url

