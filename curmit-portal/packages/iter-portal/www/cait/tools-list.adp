<master>
  <property name="context">@context;noquote@</property>
  <property name="title">@page_title;noquote@</property>

<big><big><big><b>@reg_msg@</b></big></big></big>
<br><br>
<big><big>Da qui puoi effettuare le seguenti operazioni sulle informazioni di @maintainer_name@:
<ul>
<li>Visualizzare i <a href="/iter-portal/cait/maintainer-view?&maintainer_id=@maintainer_id@">Dati Anagrafici</a><br>
<li>Gestire gli <a href="/iter-portal/cait/operators-list?maintainer_id=@maintainer_id@">Operatori</a><br>
<li>Gestire <a href="/iter-portal/cait/tools-list?type=@oth_type@&maintainer_id=@maintainer_id@">@oth_tools_type@</a><br>
<li>Tornare alle <a href="/iter-portal/cait/services?maintainer_id=@maintainer_id@">Operazioni sul Manutentore</a>
<if @to_approve_p@ eq "t" >
   <br><big><b>
   <li><a href="/iter-portal/cait/approve?maintainer_id=@maintainer_id@">Conferma</a> definitivamente i dati forniti<br></li>
   </b></big><br>
</if>
</ul>
</big></big>
<br>
<h1>@page_title@</h1>
<table cellpadding="3" cellspacing="3">

  <tr>

    <td class="list-list-pane" valign="top">

      <listtemplate name="tools"></listtemplate>

    </td>

  </tr>

</table>



