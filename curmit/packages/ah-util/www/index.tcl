ad_page_contract {
	This is the index page for the instance.
	Here we render the map with all the mapped objects for this instance

    @author Alessandro Landim	
    @creation-date 2007-12-07
} {
    party_id
}

template::add_body_handler -event onload -script "initialize()"
template::add_body_handler -event onunload -script "GUnload()"

set package_id [ad_conn package_id]

set admin_p [permission::permission_p -party_id [ad_conn user_id] -object_id [ad_conn package_id] -privilege admin]
set map_id [maps::get_map_id -package_id $package_id]

set edit_url "admin/list?package_id=$package_id"
