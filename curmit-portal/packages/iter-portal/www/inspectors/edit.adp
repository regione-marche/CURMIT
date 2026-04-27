<master>
  <property name="title">@page_title;noquote@</property>
  <property name="context">@context;noquote@</property>
  <property name="focus">addedit.name</property>

<br>
<big><big>Da qui puoi:
<ul>
<li>Tornare ai <a href="/iter-portal/inspectors/services">Servizi</a>
<if @to_approve_p@ eq "t" >
   <br><big><b>
   <li><a href="/iter-portal/inspectors/approve">Conferma</a> definitivamente i dati forniti<br></li>
   </b></big><br>
</if>
</ul>
</big></big>
<br>
<h1>@page_title@</h1>

<formtemplate id="addedit" style="standard"></formtemplate>

