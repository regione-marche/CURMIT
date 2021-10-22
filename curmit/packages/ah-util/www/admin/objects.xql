<?xml version="1.0"?>
<queryset>

  <fullquery name="select_objects">
    <querytext>
		select object_type,
			   color as object_color
		from maps_objects
		where package_id = :package_id
	</querytext>
  </fullquery>

  <fullquery name="find_objects">
    <querytext>
		select pretty_name, object_type
		from acs_object_types
		order by pretty_name
	</querytext>
  </fullquery>

</queryset>
