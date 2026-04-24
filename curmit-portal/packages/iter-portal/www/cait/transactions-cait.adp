<master>
  <property name="context">@context;noquote@</property>
  <property name="title">@page_title;noquote@</property>

<br>
<h1>@page_title@</h1>


<table cellpadding="2" cellspacing="2">

  <tr>

    <td class="list-list-pane" valign="top">
      <listtemplate name="transactions"></listtemplate>
    <p>

    <table border="1">
      <tr>
        <th width="20%">Totali</th>
        <th>crediti caricati ai manutentori (A)</th>
        <th>Storno crediti caricati ai manutentori (B)</th>
        <th>Saldo crediti caricati ai manutentori (A)-(B)</th>
      </tr>
      <tr>
        <th>Nel periodo <br>@from_date@ - @to_date@</th>
	<td align="right">@carico_portafoglio_man_periodo@</td>
	<td align="right">@storno_portafoglio_man_periodo@</td>
	<td align="right">@saldo_portafoglio_man_periodo@</td>
      </tr>
      <tr>
        <th>Complessivo</th>
	<td align="right">@carico_portafoglio_man_gen@</td>
	<td align="right">@storno_portafoglio_man_gen@</td>
	<td align="right">@saldo_portafoglio_man_gen@</td>
      </tr>
    </table>

    </td>

  </tr>

</table>

