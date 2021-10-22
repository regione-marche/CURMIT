ad_page_contract {
	Admin page for package maps

	@author	Eduardo Santos	(eduardo.edusantos@gmail.com)
	@creation-date	2008-04-29
}

set return_url [ad_conn url]
set package_id [ad_conn package_id]
set subsite_url [subsite::get_url]
set map_id [maps::get_map_id -package_id $package_id]
