<master   src="../master">
<property name="title">@page_title;noquote@</property>
<property name="context_bar">@context_bar;noquote@</property>

<h3>Risultati dell'elaborazione</h3>
<p>
Numero di righe elaborate: @count@. <br>
Numero di righe errate:  @errors@.
<if @error_descr@ eq "">
  <br>Numero di righe caricate: @success_count@
</if>
<else>
  <h3>Errori riscontrati</h3>
  <ul>
    @error_descr;noquote@
  </ul>
</else>

