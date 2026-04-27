<master>
  <property name="context">@context;noquote@</property>
  <property name="title">@page_title;noquote@</property>

<big><big><big><strong>@reg_msg@</strong></big></big></big><!--mat01 sostituito il tag b con strong-->
<br><br>
<big><big>Da qui puoi:
<ul>
<li>Visualizzare i <a href="/iter-portal/user-view">Dati Anagrafici</a></li>
<li>Gestire gli <a href="/iter-portal/operators-list">Operatori</a><br>
<li>Gestire i tuoi <a href="/iter-portal/tools-list?type=@oth_type@">@oth_tools_type@</a><br>
<li>Gestire le <a href="/iter-portal/maintainer-installations-list">Tipologie degli impianti su cui l'impresa opera</a><br>
<li>Tornare ai <a href="/iter-portal/services">Servizi</a>
<!-- i manutentrori devono essere approvati dall'ente oppure in automatico
<if @to_approve_p@ eq "t" >
   <br><big><strong><!--mat01 sostituito il tag b con strong-->
   <li><a href="/iter-portal/approve">Conferma</a> definitivamente i dati forniti<br></li>
   </strong></big><br>
</if>
-->
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



