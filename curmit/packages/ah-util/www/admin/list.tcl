ad_page_contract {
	This page lists all the objects in this maps instance and suplies
	a link to edit the object position

	@author	Eduardo Santos	(eduardo.edusantos@gmail.com)
	@creation-date	2008-04-29
} {
	{package_id ""}
}

# Breadcrumbs
set context [list "[_ maps.List_objects]"]

if {$package_id eq ""} {
	set package_id [ad_conn package_id]
}

# Return URL
set return_url [get_referrer]

template::list::create \
	-name objects \
	-key object_id \
	-actions [list "#maps.Back#" "$return_url" "#maps.Back#"] \
	-elements {
		pretty_name {
			label "[_ maps.Objects]"
		}
		actions {
			display_template {
				<a href="../edit-position?object_id=@objects.object_id@&object_type=@objects.object_type@" title="#maps.edit_position_title#" class="button">#maps.edit_position#</a>
			}
		}
	}

db_multirow objects select_objects {} {
	if {[regexp {#} $pretty_name]} {
		set pretty_name [lang::message::lookup [ad_conn locale] [string trim $pretty_name "#"]]
	} 
}
