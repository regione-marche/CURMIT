<master>
  <property name="context">@context;noquote@</property>
  <property name="title">@page_title;noquote@</property>

<br>
<h1>@page_title@</h1>


<table cellpadding="2" cellspacing="2">

  <tr>

    <td class="list-list-pane" valign="top">
      <listtemplate name="transactions"></listtemplate>
<!--mat01    <p> -->

    <table border="1" class=table_s>
      <tr>
<!--sim vecchie diciture
        <th width="15%">Totali</th>
        <th width="10%">crediti caricati<br>(B)</th>
        <th width="10%">riaccrediti <br>da Regione (storni)<br>(C)</th>
        <th width="10%">riaccrediti da altri enti (storni)<br>(D)</th>
        <th width="10%">debiti Vs Regione<br>(E)</th>
        <th width="10%">debiti Vs altri enti<br>(F)</th>
        <th width="10%">SALDO Vs Regione<br>(E-C)</th>
        <th width="10%">SALDO Vs altri enti<br>(F-D)</th>
        <th width="10%">crediti residui<br>(B+C+D)-(E+F)</th> 
-->
	<!-- mat01 aggiunto scope a tutti i th-->
        <th width="15%" scope="col">Totali</th>
        <th width="10%" scope="col">crediti caricati<br>(B)</th>
        <th width="10%" scope="col">Storni contributo<br>regionale<br>(C)</th>
        <th width="10%" scope="col">Storni contributo<br>Enti<br>(D)</th>
        <th width="10%" scope="col">Contributo Regione<br>(E)</th>
        <th width="10%" scope="col">Contributo Enti<br>(F)</th>
        <th width="10%" scope="col">SALDO Vs Regione<br>(E-C)</th>
        <th width="10%" scope="col">SALDO Vs Enti<br>(F-D)</th>
        <th width="10%" scope="col">crediti residui<br>(B+C+D)-(E+F)</th>
      </tr>
      <tr>
        <td class="td_int">Nel periodo <br>@from_date@ - @to_date@</td>
	<td align="right">@carico_portafoglio_periodo@</td>
	<td align="right">@storno_regione_periodo@</td>
	<td align="right">@storno_enti_periodo@</td>
	<td align="right">@debito_regione_periodo@</td>
	<td align="right">@debito_enti_periodo@</td>
	<td align="right">@saldo_regione_periodo@</td>
	<td align="right">@saldo_enti_periodo@</td>
	<td align="right">@credito_residuo_periodo@</td>
      </tr>
      <tr>
        <td class="td_int">Complessivo</td>
	<td align="right">@carico_portafoglio_gen@</td>
	<td align="right">@storno_regione_gen@</td>
	<td align="right">@storno_enti_gen@</td>
	<td align="right">@debito_regione_gen@</td>
	<td align="right">@debito_enti_gen@</td>
	<td align="right">@saldo_regione_gen@</td>
	<td align="right">@saldo_enti_gen@</td>
	<td align="right">@credito_residuo_gen@</td>
      </tr>
    </table>

    </td>

  </tr>

</table>

