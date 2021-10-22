<master   src="../master">
<property name="title">@page_title;noquote@</property>
<property name="context_bar">@context_bar;noquote@</property>
<property name="riga_vuota">f</property>

<center>

@link_tab;noquote@
@dett_tab;noquote@

<table width="100%" cellspacing=0  class=func-menu>
<tr>
   <if @funzione@ eq "I">
      <td width="75%" nowrap class=func-menu>&nbsp;</td>
   </if>
   <else>
      <td width="25%" nowrap class=@func_v;noquote@>
         <a href="coimaimp-maps?funzione=V&@link_gest;noquote@" class=@func_v;noquote@>Mappe</a>
      </td>
      <td width="25%" nowrap class=@func_m;noquote@>
         <a href="coimaimp-ubic?funzione=V&@link_gest;noquote@">Visualizza</a>
      </td>
      <td width="25%" nowrap class=@func_m;noquote@>
         <a href="coimaimp-ubic?funzione=M&@link_gest;noquote@" class=@func_m;noquote@>Modifica</a>
      </td>
      <td width="25%" nowrap class=func-menu>
         <a href="coimstub-list?@link_stub;noquote@" class=func-menu>Storico ubicazioni</a>
      </td>
   </else>
</tr>
</table>

    <script src="http://maps.google.com/maps?file=api&amp;v=2&amp;key=@google_api_key;noquote@" type="text/javascript"></script>    
    
    <script type="text/javascript">
    //<![CDATA[
    var map = null;
    var geocoder = null;

    function load() {
      if (GBrowserIsCompatible()) {
        map = new GMap2(document.getElementById("map"));
        map.addControl(new GLargeMapControl());
	map.addControl(new GMapTypeControl());
        map.setCenter(new GLatLng(@lat;noquote@, @lon;noquote@), 13);
        var marker = new GMarker(new GLatLng(@lat;noquote@, @lon;noquote@));
        map.addOverlay(marker);
        geocoder = new GClientGeocoder();
      }
    }
    function showAddress(address) {
      if (geocoder) {
        geocoder.getLatLng(
          address,
          function(point) {
            if (!point) {
              alert(address + " not found");
            } else {
	      document.location.href="coimaimp-maps?nome_funz=impianti&color=@color;noquote@&@link_maps;noquote@&aaa="+point+"&address="+address;
            }
          }
        );
      }
    }
    //]]>
    </script>
<%=[iter_form_iniz]%>
<! --Google Maps -->
    <form action="#" onsubmit="showAddress(this.address.value); return false">
      <table border="0">
        <tr>
        <td>
        <input type="text" size="60" name="address" value="@address;noquote@" /><br/>
        <input type="hidden" size="10" name="lat" value="@lat;noquote@" /><br />
        <input type="hidden" size="10" name="lon" value="@lon;noquote@" />
        </td>
        <td valign="top"> 
        <input type="submit" value="Trova impianto" />
        </td>
        </tr>
      </table>
    </form>
      <center>
          <font face="Arial" size="2" color="@color;noquote@">
            <b>@wrn_map;noquote@</b>
          </font>
      </center>
      <div id="map" style="width: 500px; height: 300px"><div>
<!-- Fine della form colorata -->
<%=[iter_form_fine]%>

</center>

