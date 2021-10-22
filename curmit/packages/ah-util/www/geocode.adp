<master>
<property name="doc_type"><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"></property>
<property name="head">
    
    <script src="http://maps.google.com/maps?file=api&amp;v=2&amp;key=@key@"
            type="text/javascript"></script>
    <script type="text/javascript">

    var address = "@address@";

    function initialize() {
      if (GBrowserIsCompatible()) {
        var map = new GMap2(document.getElementById("map_canvas"));

        // Utilizziamo la classe gClientGeocoder per creare l'oggetto geocoder
        geocoder = new GClientGeocoder();
 
        // Utilizzando il metodo getLatLng, otteniamo le coordinate 
        geocoder.getLatLng(address,
        function(point) {
          if (!point) {
              // Indirizzo non trovato
              location.replace('edit-position?object_id=@object_id@&object_type=@object_type@&return_url=@return_url@&address=' + address);
          } else {
              // Utilizzo i dati ricavati dal geocoder
              location.replace('create-position?object_id=@object_id@&return_url=@return_url@&lng=' + point.x + '&lat=' + point.y);
          }
        });
      }
    }

    </script>

</property>

    <div id="map_canvas" style="width: 500px; height: 300px"></div>
	<div class="form-help-text">
	  <img width="12" height="9" border="0" title="Help text" alt="[i]" src="/shared/images/info.gif">
	  #maps.Edit_position_help#
	</div>

