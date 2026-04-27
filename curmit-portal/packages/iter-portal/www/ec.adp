<master>
  <property name="context">@context;noquote@</property>
  <property name="title">@page_title;noquote@</property>

<br>
<h1>@page_title@</h1>

<table cellpadding="2" cellspacing="2">
  <tr>
    <th>Manutentore:</th><td>@name@</td>
    <th>Cod. portafoglio</th><td>@wallet_id@</td>
  </tr>
</table>

<if @errnum@ nil>
<table cellpadding="2" cellspacing="2">
  <tr>
    <th>Entrate nel periodo</th><td>@entrate@</td>
    <th>Uscite nel periodo</th><td>@uscite@</td>
    <th>Differenza</th><td>@delta@</td>
    <th>Credito residuo</th><td>@final_balance@</td>
  </tr>
</table>
</if>

<table cellpadding="2" cellspacing="2">

  <tr>

    <td class="list-filter-pane" valign="top" width="200">
      <formtemplate id="filter" style="filter"></formtemplate>
      <listfilters name="ec"></listfilters>
    </td>

    <td class="list-list-pane" valign="top">
      <listtemplate name="ec"></listtemplate>
    </td>

  </tr>

</table>

