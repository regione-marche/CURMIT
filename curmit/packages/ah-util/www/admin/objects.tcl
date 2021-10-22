ad_page_contract {
	Insert new objects to be part in the maps

	@author	Eduardo Santos	(eduardo.edusantos@gmail.com)
	@creation-date	2008-04-25
} {

}

# Breadcrumbs
set context [list "[_ maps.Objects]"]

set package_id [ad_conn package_id]

template::list::create \
	-name objects \
	-key object_type \
	-actions {} \
	-elements {
		object_type {
			label "[_ maps.Objects]"
		}
		object_color {
			label "[_ maps.Color]"
		}
		actions {
			display_template {
				<a href="delete?object_type=@objects.object_type@" title="#maps.Delete_object#"><img src="/resources/acs-subsite/Delete16.gif" width="16" height="16" border="0"></a>
			}
		}
	}

db_multirow objects select_objects {} {

}

foreach lista [db_list_of_lists find_objects {}] {
	set pretty_name [lindex $lista 0]
	set object_type [lindex $lista 1]
	if {[regexp {#} $pretty_name]} {
		set pretty_name [lang::message::lookup [ad_conn locale] [string trim $pretty_name "#"]]
	} 
	lappend object_options "{$pretty_name} {$object_type}"
}
set object_options [lsort -dictionary -index 0 $object_options]

ad_form -name add -form {
	{type:text(select) {label "[_ maps.Objects]"} {options $object_options} }
	{color:text(text) {label "[_ maps.Color]"} {help_text "[_ maps.Color_help]"} }
} -on_submit {
	# Let's make sure the callback exists, so we don't see any errors
	if {![callback::impl_exists -callback maps::object_info -impl $type]} {
		template::element::set_error add type "[_ maps.No_callback_error]"
		break
	}
	maps::map_objects -object_type $type -color $color
} -after_submit {
	ad_returnredirect -message "[_ maps.Successfull_change]" [ad_conn url]
	ad_script_abort
}
