<p>#maps.Map_view#: @map_name@</p>
<div id="map_canvas" class="google_maps"></div>
<a href="javascript:Aumenta();" title="Allarga">Allarga</a>
<if @admin_p@>
  <ul>
    <li><a href="@maps_url@admin" title="Amministrazione">Admin</a></li>
    <if @edit_url@ ne "">
      <li><a href="@edit_url@" title="Modifica posizione">Modifica posizione</a></li>
    </if>
  </ul>
</if>
