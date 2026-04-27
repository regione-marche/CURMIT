ad_library {

    Maps Library

    @author Claudio Pasolini
    @cvs-id $Id: maps-procs.tcl

}

namespace eval maps {}

ad_proc -public maps::geocode {
    -address:required
    {-locality ""}
} {
    Calls the Google geocoding web service.
    Returns a list composed by: status, lat, lng and an optional error message.
} {

    if {$locality eq ""} {
	set locality [parameter::get_from_package_key -package_key maps -parameter locality]
    }

    set url http://maps.googleapis.com/maps/api/geocode/xml
    set formvars "sensor=false&address=[ad_urlencode $address]"

    with_catch errmsg {

        # calls the web service
        set xml [ns_httpget ${url}?$formvars]

	set doc  [dom parse $xml]
	set root [$doc documentElement]
	
	# finds status
	set node   [$root selectNodes /GeocodeResponse/status/text()]
	set status [$node nodeValue]

	if {$status eq "OK"} {

	    # finds results
	    set results [$root selectNodes /GeocodeResponse/result]

	    # there could be more than one result
	    set results_no [llength $results]
	    set found_p 0
	    if {$results_no > 1} {
		foreach result $results {
		    if {$locality ne ""} {
			# looks for the required locality
			set node [$result selectNodes address_component\[type/text()='locality'\]/short_name/text()]
			if {$node ne ""} {
			    # found locality element
			    set loc [$node nodeValue]
			    if {$loc eq "$locality"} {
				# found the desired locality
				set found_p 1
				break
			    }
			}
		    } else {
			# can't choose between multiple results
			break
		    }
		}
	    } else {
		set result  $results
		set found_p 1
	    }

            if {$found_p} {
		# finds lat & lng
		set node [$result selectNodes geometry/location/lat/text()]
		set lat  [$node nodeValue]
		set node [$result selectNodes geometry/location/lng/text()]
		set lng  [$node nodeValue]
	    } else {
		set lat {}
		set lng {}
		set status {}
		set errmsg "Impossibile scegliere fra diversi risultati."
	    }

	    # delete DOM
	    $root delete

	} else {
	    return [list $status {} {} {}]
	}
    } {
	return [list {} {} {} $errmsg]
	ad_script_abort
    }
    return [list $status $lat $lng {}]
}

ad_proc -public maps::create_or_replace_position {
    -position_id
    -name
    -address
} {
    Calls the Google geocoding web service.
    Creates or replaces the entity position.
} {

    set add_edit_script [parameter::get_from_package_key -package_key maps -parameter add_edit_script]
    set id_name         [parameter::get_from_package_key -package_key maps -parameter id_name]
    set zoom            [parameter::get_from_package_key -package_key maps -parameter Zoom]

    set edit_url "<a href=\"${add_edit_script}?$id_name=$position_id\">$address</a>"

    # calls the web service
    set response [maps::geocode -address $address]
    util_unlist $response status lat lng errmsg

    if {$status eq "OK"} {

	set center "$lat,$lng"

        # deletes the position if it exsists
	if {[db_0or1row get "select position_id from maps_positions where position_id = :position_id"]} {
            db_dml delete "delete from maps_positions where position_id = :position_id"
	}

	# creates the position
	db_dml new "
            insert into maps_positions (
                position_id
               ,name
               ,address
               ,edit_url
               ,lat
               ,lng
               ,center
               ,zoom
            ) values (
                :position_id
               ,:name
               ,:address
               ,:edit_url
               ,:lat
               ,:lng
               ,:center
               ,:zoom
            )"

	return [list $position_id OK]

    } elseif {$status eq ""} {
	return [list 0 "Si è verificato un errore imprevisto: $errmsg"]
    } else {
	return [list 0 "Il web service Google ha risposto: $status"]
    }

}

