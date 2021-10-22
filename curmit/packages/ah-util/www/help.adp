<master src="/packages/mis-base/www/alter-master">
<property name="title">Help Manager</property>
<property name="context">@context;noquote@</property>

<blockquote>
Spiacente, ma non esiste alcuna pagina di help per <a href="@url@">@url@</a>.
<p>
<if @admin_p@ eq "1">
  Se vuoi puoi <a href="help-ae?url=@url@&file=@file@">crearlo</a> adesso.
</if>
<p>
<a href="@url@">Ritorna</a>

</blockquote>


