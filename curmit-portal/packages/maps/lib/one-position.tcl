##
## requires: position_id
##
db_1row position "
    select name
         , address
         , edit_url
         , lat
         , lng
         , center
         , zoom
    from maps_positions
    where position_id = :position_id
"

set width  [parameter::get_from_package_key -package_key maps -parameter Width]
set height [parameter::get_from_package_key -package_key maps -parameter Height]
set gkey   [parameter::get_from_package_key -package_key maps -parameter KeyGoogleMapsV3]

template::head::add_style -style "#map_canvas {width:$width; height:$height; margin:15px 0; clear:both; overflow:hidden;}"
template::head::add_javascript -src "http://maps.googleapis.com/maps/api/js?key=$gkey&sensor=false" -order 10
template::head::add_javascript -script "

      function initialize() {

        var myLatlng = new google.maps.LatLng($lat,$lng);
        var myOptions = {
          zoom: $zoom,
          center: myLatlng,
          mapTypeId: google.maps.MapTypeId.ROADMAP
        }

        var map = new google.maps.Map(document.getElementById(\"map_canvas\"), myOptions);

        var contentString = '<div id=\"content\">'+
          '<div id=\"siteNotice\">'+
            '</div>'+
          '<h1 id=\"firstHeading\" class=\"firstHeading\">$name</h1>'+
          '<div id=\"bodyContent\">'+
            '<p>$edit_url'+
            '</div>'+
          '</div>';
      
        var infowindow = new google.maps.InfoWindow({
          content: contentString
        });

        var marker = new google.maps.Marker({
          position: myLatlng,
          map: map,
          title: '$address'
        });

        google.maps.event.addListener(marker, 'click', function() {
          infowindow.open(map,marker);
        });

      }
  " -order 20

template::add_body_handler -event onload -script "initialize()"
