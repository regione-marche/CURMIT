<master>
<property name="doc_type"><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"></property>
<property name="head">
    
    <script src="http://maps.google.com/maps?file=api&amp;v=2&amp;key=@key@"
            type="text/javascript"></script>
    <script type="text/javascript">

    function initialize() {
      if (GBrowserIsCompatible()) {
        var map = new GMap2(document.getElementById("map_canvas"));
	var center = new GLatLng(@center@)
        map.setCenter(center, @zoom@);
        map.addControl(new GSmallMapControl());
        map.addControl(new GMapTypeControl());
		
	var marker = new GMarker(center, {draggable: true});


		 GEvent.addListener(marker, "dragend", function() {
          		var position = marker.getLatLng();
          		document.form_position.position.value = position;
			document.form_position.center.value = position;
        	});	
		 
		GEvent.addListener(map, "zoomend", function() {
			var zoom = map.getZoom();
			document.form_position.zoom.value = zoom;
		});

            map.addOverlay(marker);
      }
    }
    </script>
</property>

<div id="map_canvas" style="width: 500px; height: 300px"></div>
<div class="form-help-text">
  <img width="12" height="9" border="0" title="Help text" alt="[i]" src="/shared/images/info.gif">
  #maps.Edit_position_help#
</div>
<formtemplate id="form_position"></formtemplate>
