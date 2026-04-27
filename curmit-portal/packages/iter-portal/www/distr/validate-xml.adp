<master>
<property name="title">@page_title;noquote@</property>
<property name="context">@context;noquote@</property>

<h1>@page_title;noquote@</h1>

<h3>Risultati dell'elaborazione</h3>
<p>
Numero di forniture elaborate: @count@. <br>
Numero di forniture scartate:  @errors@.

<if @errors@ eq "0">
<p>Puoi <a href="receipt?object_id=@object_id@&attachment_id=@attachment_id@">stampare la ricevuta</a> del caricamento della fornitura.
</if>
<else>
<h2>Errori riscontrati</h2>
@html_errors;noquote@
</else>

