<master>
  <property name="title">@page_title;noquote@</property>
  <property name="context">@context;noquote@</property>
  <property name="focus">addedit.name</property>

<br>
<big><big>Da qui puoi effettuare le seguenti operazioni sulle informazioni di @trustee_name@:
<ul>
<li>Tornare alle <a href="trustees-services?trustee_id=@trustee_id@">Operazioni sull'Amministratore</a>
<if @to_approve_p@ true >
   <br><big><b>
   <li><a href="approve?trustee_id=@trustee_id@">Conferma</a> definitivamente i dati forniti<br></li>
   </b></big><br>
</if>
</ul>
</ul>
</big></big>
<br>
<h1>@page_title@</h1>

<formtemplate id="addedit" style="standard"></formtemplate>

