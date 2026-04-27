<master>
  <property name="title">@page_title;noquote@</property>
  <property name="context">@context;noquote@</property>
  <property name="focus">addedit.name</property>

<br>
<big><big>Da qui puoi effettuare le seguenti operazioni sulle informazioni di @maintainer_name@:
<ul>
<li>Gestire gli <a href="/iter-portal/cait/operators-list?maintainer_id=@maintainer_id@">Operatori</a><br>
<li>Gestire i <a href="/iter-portal/cait/tools-list?type=1&maintainer_id=@maintainer_id@">Deprimometri</a><br>
<li>Gestire gli <a href="/iter-portal/cait/tools-list?type=0&maintainer_id=@maintainer_id@">Analizzatori di Combustione</a><br>
<li>Tornare alle <a href="/iter-portal/cait/services?maintainer_id=@maintainer_id@">Operazioni sul Manutentore</a>
<if @to_approve_p@ eq "t" >
   <br><big><b>
   <li><a href="/iter-portal/cait/approve?maintainer_id=@maintainer_id@">Conferma</a> definitivamente i dati forniti<br></li>
   </b></big><br>
</if>
</ul>
</ul>
</big></big>
<br>
<h1>@page_title@</h1>

<formtemplate id="addedit" style="standard"></formtemplate>

