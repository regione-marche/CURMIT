ad_page_contract {
	Remove object type from map list

	@author	Eduardo Santos	(eduardo.edusantos@gmail.com)
	@creation-date	2008-04-25
} {
	{object_type:notnull}
}

acs_object_type::get -object_type $object_type -array info
set pretty_name $info(pretty_name)

ad_form -name delete -cancel_url "objects" -export {object_type} -form {
	{pretty_name:text(text) {label "[_ maps.Objects]"} {mode display} {value $pretty_name} }
} -on_submit {
	maps::unmap_objects -object_type $object_type
} -after_submit {
	ad_returnredirect -message "[_ maps.Successfull_change]" objects
	ad_script_abort
}
