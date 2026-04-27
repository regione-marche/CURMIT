ad_page_contract {

  Visualizza help contestuale della url ricevuta.
 
  @author Claudio Pasolini
  @cvs-id help.tcl

} {
    url
    file
}

set user_id [ad_conn user_id]
set admin_p [acs_user::site_wide_admin_p -user_id $user_id]

set context ""

# Per convenzione l'eventuale file di help si trova nella directory doc del
# file servito. Se il è ad# es.
# [ah::service_root]/packages/mis-base/www/parties/list 
# il path del file di help deve essere
# [ah::service_root]/packages/mis-base/www/doc/parties/list.adp

regsub {www} $file {www/doc} file

# controllo esistenza file di help
if {[file exists $file]} {
    # servo il file di help
    regsub {/[a-zA-Z0-9\-_]+/} $url {&doc/} help_url
ns_log notice "\nDEBUG $help_url"    
    ad_returnredirect $help_url
    ad_script_abort
} else {
    set url_list [split $url "/"]
    set package_key [lindex $url_list 1]
    if {$package_key eq "mis-prod"} {
	set package_key "mis-production"
    }
    db_1row query "select package_id from apm_packages where package_key = :package_key"
    ad_returnredirect "/mis-base/doc/help?object_id=$package_id"
}
