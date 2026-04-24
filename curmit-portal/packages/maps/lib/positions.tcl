##
## requires: subquery
##

set objects [db_list_of_lists positions "
    select position_id
         , name
         , edit_url
         , lat
         , lng
    from maps_positions
    where position_id in ($subquery)
"]

# prepares markers info
set positions {        var objects = [}
foreach object $objects {
    util_unlist $object position_id name edit_url lat lng

    regsub -all {'} $edit_url { } edit_url

    append positions "\['$name', $lat, $lng, $position_id, '$edit_url' \],"
}
# remove last comma
set positions [string range $positions 0 end-1]
append positions {        ];}

set width  [parameter::get_from_package_key -package_key maps -parameter Width]
set height [parameter::get_from_package_key -package_key maps -parameter Height]
set center [parameter::get_from_package_key -package_key maps -parameter Center]
set gkey   [parameter::get_from_package_key -package_key maps -parameter KeyGoogleMapsV3]
set zoom   [parameter::get_from_package_key -package_key maps -parameter MultiZoom]

set add_edit_script [parameter::get_from_package_key -package_key maps -parameter add_edit_script]
set id_name         [parameter::get_from_package_key -package_key maps -parameter id_name]

template::head::add_style -style "#map_canvas {width:$width; height:$height; margin:15px 0; clear:both; overflow:hidden;}"
template::head::add_javascript -src "http://maps.googleapis.com/maps/api/js?key=$gkey&sensor=false" -order 10

# compile javascript
set script "
      function initialize() {

        var myOptions = {
          zoom: $zoom,
          center: new google.maps.LatLng($center),
          mapTypeId: google.maps.MapTypeId.ROADMAP
        }

        var map = new google.maps.Map(document.getElementById(\"map_canvas\"), myOptions);

        setMarkers(map, objects);
      }

      // defines markers (name, lat, lng and edit_url)
      $positions

      function setMarkers(map, locations) {
        // Add markers to the map

        var infowindow = new google.maps.InfoWindow();
        var marker, i;

        for (var i = 0; i < locations.length; i++) {
	  var object = locations\[i\];
	  var myLatLng = new google.maps.LatLng(object\[1\], object\[2\]);
     
	  marker = new google.maps.Marker({
	    position: myLatLng,
	    map: map,
	    title: object\[0\],
	  });

          google.maps.event.addListener(marker, 'click', (function(marker, i) {
            return function() {
              infowindow.setContent(locations\[i\]\[4\]);
              infowindow.open(map, marker);
            }
          })(marker, i));

        }
      }
"

template::head::add_javascript -script $script -order 20

template::add_body_handler -event onload -script "initialize()"
