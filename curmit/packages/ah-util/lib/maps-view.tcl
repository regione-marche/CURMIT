# This is the page that includes the Google map. Beware to the
# JavaScript code.
#
# This page accepts the following parameters:
#
#	map_id: The map we are going to serve. Defaults to 0
#	zoom: The zoom you are going to put. Defaults to space info
#	center: Where the map is going to be centered. Defaults to space info
#	key: Google maps site key. You can get a key at http://code.google.com/apis/maps/signup.html
#	edit_url: The HTML url to edit the position, including the anchor definition

if {![info exists map_id]} {
    set map_id 0
}

if {![exists_and_not_null width]} {
    set width [parameter::get_from_package_key -package_key ah-util -parameter width -default 800px] 
}

if {![exists_and_not_null height]} {
    set eight [parameter::get_from_package_key -package_key ah-util -parameter width -default 450px] 
}

template::head::add_style -style ".google_maps { width:$width; height:$height; margin:15px 0; clear:both; overflow:hidden; }"

template::head::add_javascript -script {
    function Aumenta() {
	var elm = document.getElementById('map_canvas');
	elm.style.height = '$height';
	elm.style.width  = '$width';
    }
}

set map_name   [ah::maps::get_map_name -map_id $map_id]
set package_id [ah::maps::get_package_id -map_id $map_id]
set space      [ah::maps::get_center_and_zoom -map_id $map_id -package_id $package_id]

set center [lindex $space 0]
if {![info exists zoom]} {
    set zoom [lindex $space 1]
}

set admin_p [permission::permission_p -party_id [ad_conn user_id] -object_id $map_id -privilege "admin"]

if {![info exists key]} {
    set key [parameter::get -package_id $package_id -parameter "KeyGoogleMaps"]
}

set maps_url [site_node::get_url_from_object_id -object_id $package_id]
if {![info exists edit_url]} {
    set edit_url ""
} else {
    if {$edit_url ne ""} {
	set edit_url "[site_node::get_url_from_object_id -object_id $package_id]$edit_url"
    }
}

template::head::add_javascript -order 1 -src "http://maps.google.com/maps?file=api&amp;v=2&amp;key=$key"

set download_url "$maps_url$map_id.xml"

set script "function initialize() {
      if (GBrowserIsCompatible()) {
        var map = new GMap2(document.getElementById(\"map_canvas\"));
        var center = new GLatLng($center);
        map.setCenter(center, $zoom);
        map.addControl(new GSmallMapControl());
        map.addControl(new GMapTypeControl());

	function createMarker(point, name, color) {

	// Create our \"tiny\" marker icon
	var tinyIcon = new GIcon();
	tinyIcon.image = \"http://labs.google.com/ridefinder/images/mm_20_\" + color + \".png\";
	tinyIcon.shadow = \"http://labs.google.com/ridefinder/images/mm_20_shadow.png\";
	tinyIcon.iconSize = new GSize(12, 20);
	tinyIcon.shadowSize = new GSize(22, 20);
	tinyIcon.iconAnchor = new GPoint(6, 20);
	tinyIcon.infoWindowAnchor = new GPoint(5, 1);

	// Set up our GMarkerOptions object literal
	markerOptions = { icon:tinyIcon };

        var marker = new GMarker(point, markerOptions);

          GEvent.addListener(marker, \"click\", function() {
            marker.openInfoWindowHtml(name);
          });
          return marker;
        }

        GDownloadUrl(\"$download_url\", function(data) {
          var xml = GXml.parse(data);
       
          var markers = xml.documentElement.getElementsByTagName(\"marker\");
          for (var i = 0; i < markers.length; i++) {
		var lat, lng, name;
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
				
				case \"color\":
				color = GXml.value(nodes\[j\]);
				break;

			}
		}

                var point = new GLatLng(parseFloat(lat),
                                    parseFloat(lng));

            map.addOverlay(createMarker(point, name, color));
          }
        });
      }
    }
"

template::head::add_javascript -order 2 -script $script

template::add_body_handler -event onload -script "initialize()"
template::add_body_handler -event onunload -script "GUnload()"
