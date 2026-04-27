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

    <table border="1" width="100%">
      <tr>
        <th width="25%">Totali</th>
        <th>Crediti caricati CAIT (A)</th>
	<th>Crediti caricati <br>Manutentori (B)</th>
        <th>Storno crediti <br>caricati CAIT (C)</th>
	<th>Storno crediti <br>caricati Manutentori (D)</th>
        <th>Crediti residui <br>(A)-(B)-(C)+(D)</th>
      </tr>
      <tr>
        <th>Nel periodo <br>@from_date@ - @to_date@</th>
	<td align="right">@carico_portafoglio_cait_periodo@</td>
	<td align="right">@carico_portafoglio_man_periodo@</td>
	<td align="right">@storno_portafoglio_cait_periodo@</td>
	<td align="right">@storno_portafoglio_man_periodo@</td>
	<td align="right">@saldo_portafoglio_cait_periodo@</td>
      </tr>
      <tr>
        <th>Complessivo</th>
	<td align="right">@carico_portafoglio_cait_gen@</td>
	<td align="right">@carico_portafoglio_man_gen@</td>
	<td align="right">@storno_portafoglio_cait_gen@</td>
	<td align="right">@storno_portafoglio_man_gen@</td>
	<td align="right">@saldo_portafoglio_cait_gen@</td>
      </tr>
    </table>

    </td>

  </tr>

</table>

