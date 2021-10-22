##
## require the : object_id, width, height and return_url
##
if {![exists_and_not_null object_id]} {
    set object_id 0
}

if {![exists_and_not_null width]} {
    set width [parameter::get_from_package_key -package_key ah-util -parameter width -default 800px] 
}

if {![exists_and_not_null height]} {
    set eight [parameter::get_from_package_key -package_key ah-util -parameter width -default 450px] 
}

if {![exists_and_not_null return_url]} {
    set return_url [get_referrer]
}


template::head::add_style -style ".google_maps { width:$width; height:$height; margin:15px 0; clear:both; overflow:hidden; }"

template::head::add_javascript -script {
    function Aumenta() {
	var elm = document.getElementById('map_canvas');
	elm.style.height = '$height';
	elm.style.width  = '$height';
    }
}

set package_id [ah::maps::get_package_id -map_id $map_id]

# Discover the position
set position_id [ah::maps::get_position_from_object_id -object_id $object_id]

# Position info
if {$position_id ne ""} {
    ah::maps::get_position_info -position_id $position_id -array position_array
    set map_id $position_array(map_id)
    set zoom   $position_array(zoom)
    set center $position_array(center)
} else {
    # The map_id must be supplied
    set space [ah::maps::get_center_and_zoom -map_id $map_id]
    util_unlist $space zoom center
}

if {![exists_and_not_null key]} {
    set key [parameter::get -package_id $package_id -parameter "KeyGoogleMaps"]
}

template::head::add_javascript -src "http://maps.google.com/maps?file=api&amp;v=2&amp;key=$key"

set maps_url [site_node::get_url_from_object_id -object_id $package_id]
set object_type [acs_object_type $object_id]

# Include the URL to the XML file
set download_url "$maps_url/$position_id.xml"

set script "function initialize() {
      if (GBrowserIsCompatible()) {
       	function createMarker(point, name) {

          var marker = new GMarker(point, markerOptions);

          GEvent.addListener(marker, \"click\", function() {
            marker.openInfoWindowHtml(name);
          });
          return marker;
        }

	// Create our \"tiny\" marker icon
	var tinyIcon = new GIcon();
	tinyIcon.image = \"http://labs.google.com/ridefinder/images/mm_20_green.png\";
	tinyIcon.shadow = \"http://labs.google.com/ridefinder/images/mm_20_shadow.png\";
	tinyIcon.iconSize = new GSize(12, 20);
	tinyIcon.shadowSize = new GSize(22, 20);
	tinyIcon.iconAnchor = new GPoint(6, 20);
	tinyIcon.infoWindowAnchor = new GPoint(5, 1);

	// Set up our GMarkerOptions object literal
	markerOptions = { icon:tinyIcon };

	//create map
 	var map = new GMap2(document.getElementById(\"map_canvas\"));
	var center = new GLatLng($center);
	map.setCenter(center, $zoom);
      	map.addControl(new GSmallMapControl());
      	map.addControl(new GMapTypeControl());

        GDownloadUrl(\"$download_url\", function(data) {
          var xml = GXml.parse(data);
       
          	var markers = xml.documentElement.getElementsByTagName(\"marker\");
		var lat, lng, name;
	   for (var i=0; i < markers.length; i++)
	   {
		var nodes = markers\[i\].childNodes;
	
		for (var j=0; j < nodes.length; j++)
		{
			switch(nodes\[j\].tagName)
			{
				case \"name\":
				name = GXml.value(nodes\[j\]);
				break;
			
				case \"lat\":
				lat = GXml.value(nodes\[j\]);
				break;
			
				case \"lng\":
				lng = GXml.value(nodes\[j\]);
				break;
			}
		}

                var point = new GLatLng(parseFloat(lat),
                                    parseFloat(lng));
           	map.addOverlay(createMarker(point, name));
	   }

	}
        );
      }
    }
"

template::head::add_javascript -script $script

template::add_body_handler -event onload -script "initialize()"
template::add_body_handler -event onunload -script "GUnload()"
