<?xml version="1.0"?>
<queryset>

  <fullquery name="select_objects">
    <querytext>
		select mp.object_id,
			   mo.object_type,
			   ot.pretty_name
		from maps_position mp
		inner join maps_objects mo on mp.type = mo.object_type
		inner join acs_object_types ot on mo.object_type = ot.object_type
		where mo.package_id = :package_id
	</querytext>
  </fullquery>

</queryset>
