<master>
  <property name="title">@page_title;noquote@</property>
  <property name="context">@context;noquote@</property>
  <property name="focus">addedit.name</property>

<br>
<big><big>Da qui puoi:
<ul>
<li>Gestire i tuoi <a href="/iter-portal/operators-list">Operatori</a><br>
<li>Gestire i tuoi <a href="/iter-portal/tools-list?type=1">Deprimometri</a><br>
<li>Gestire i tuoi <a href="/iter-portal/tools-list?type=0">Analizzatori di Combustione</a><br>
<li>Tornare ai <a href="/iter-portal/services">Servizi</a>
<if @to_approve_p@ eq "t" >
   <br><big><b>
   <li><a href="/iter-portal/approve">Conferma</a> definitivamente i dati forniti<br></li>
   </b></big><br>
</if>
</ul>
</big></big>
<br>
<h1>@page_title@</h1>

<formtemplate id="addedit" style="standard"></formtemplate>

