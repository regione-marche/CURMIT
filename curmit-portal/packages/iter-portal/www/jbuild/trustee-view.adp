<master>
  <property name="title">#acs-subsite.Register#</property>
  <property name="context">{#acs-subsite.Register#}</property>

<br>
<big><big>Da qui puoi:
<ul>
<if @validated_p@ eq "t" >
   <li>Accedere al <a href="/iter-portal/jbuild/iter-link">programma I.Ter</a> per l'inserimento dei modelli F e G</li>
</if>
   <li>Tornare ai <a href="/iter-portal/jbuild/servtrust">Servizi</a>
</ul>
</big></big>
<br>
<h1>@page_title@</h1>

<formtemplate id="addedit" style="standard"></formtemplate>
