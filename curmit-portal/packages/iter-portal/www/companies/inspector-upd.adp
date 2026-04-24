<master>
  <property name="title">@page_title;noquote@</property>
  <property name="context">@context;noquote@</property>
  <property name="focus">addedit.name</property>

<br>
<big><big>Da qui puoi effettuare le seguenti operazioni sulle informazioni di @inspector_name@:
<ul>
<li>Tornare alle <a href="/iter-portal/companies/inspector-services?inspector_id=@inspector_id@">Operazioni sull'Ispettore</a>
<if @to_approve_p@ eq "t" >
   <br><big><b>
   <li><a href="/iter-portal/companies/approve?inspector_id=@inspector_id@">Conferma</a> definitivamente i dati forniti<br></li>
   </b></big><br>
</if>
</ul>
</ul>
</big></big>
<br>
<h1>@page_title@</h1>

<formtemplate id="addedit" style="standard"></formtemplate>

