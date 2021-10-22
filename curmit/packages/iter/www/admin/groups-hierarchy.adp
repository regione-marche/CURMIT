<master src="../master">
<property name="title">Struttura organizzativa esplosa</property>
<property name="context_bar">@context;noquote@</property>

<table cellpadding="3" cellspacing="3">
  <tr>
    <th>Unità Organizzativa:</th>
    <td>
      <a href="group-add-edit?group_id=@parent_id@">@parent_name@</a>
      <if @parent_id@ ne @company_group_id@>(<a href="groups-hierarchy">Torna al vertice della struttura</a>)</if>
    </td>
  </tr>  
</table>

<p>

<table cellpadding="3" cellspacing="3">
  <tr>
    <td class="list-list-pane" valign="top">
      <listtemplate name="groups"></listtemplate>
    </td>
  </tr>
</table>



