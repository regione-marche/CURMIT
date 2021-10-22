ad_page_contract {
    Esegue il geocoding dell'oggetto, dato il suo indirizzo.

    @author Claudio Pasolini
    @creation-date 2009-09-14
    @cvs-id $Id: geocode.tcl
} {
    {object_id ""}
    {object_type ""}
    {address ""}
    {return_url ""}
}

permission::require_permission -party_id [ad_conn user_id] -object_id $object_id -privilege admin
template::add_body_handler -event onload -script "initialize()"
template::add_body_handler -event onunload -script "GUnload()"
set key [parameter::get -package_id [ad_conn package_id] -parameter "KeyGoogleMaps"]

set package_id [ad_conn package_id]

# Position info
set map_id [maps::get_map_id -package_id $package_id]

set space [maps::get_center_and_zoom -map_id $map_id -package_id $package_id]
set center [lindex $space 0]
set zoom [lindex $space 1]

# Get object type specific info
callback -impl $object_type maps::object_info -object_id $object_id
set url $map_info(url)
set pname $map_info(pname)
set object_id $map_info(object_id)
set message $map_info(message)

# View parameters
set map_package_id [maps::get_package_id -map_id $map_id]
set center [string trimleft $center "("]
set center [string trimright $center ")"]

ad_return_template
