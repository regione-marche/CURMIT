<master>
  <property name="context">@context;noquote@</property>
  <property name="title">@page_title;noquote@</property>

<br>
<h1>@page_title@</h1>

<center>
<formtemplate id="@form_name;noquote@">
<formwidget   id="funzione">
<formwidget   id="caller">
<formwidget   id="nome_funz">
<formwidget   id="extra_par">
<formwidget   id="saldo_manu">
<formwidget   id="cod_portafoglio">
<formwidget   id="f_ente_portafoglio">

<table width="100%" cellspacing=0 class=func-menu>
  <tr>
     <td width="25%" nowrap class=func-menu>
       <a href="../admin/@return_url@" class=func-menu>Ritorna</a>
     </td>
  </tr>
</table>

<!-- Inizio della form colorata -->
<%=[iter_form_iniz]%>

<tr>
<td>Manutentore</td>
<td valign=top><formwidget id="cognome_manu">@cerca_manu;noquote@ <!-- gab01 -->
        <formerror  id="cognome_manu"><br>
        <span class="errori">@formerror.cognome_manu;noquote@</span>
        </formerror>
</td>
</tr>
<tr>
<td>Data Versamento</td>
<td valign=top>
  <formwidget id="payment_date">        
    <formerror  id="payment_date"><br>
      <span class="errori">@formerror.payment_date;noquote@</span>
    </formerror>
</td>
</tr>
<tr>
<td>Importo</td>
<td valign=top>
  <formwidget id="amount">        
    <formerror  id="amount"><br>
      <span class="errori">@formerror.amount;noquote@</span>
    </formerror>
</td>
</tr>
<tr>
<td>Estremi del Versamento</td>
<td valign=top>
  <formwidget id="description">
    <formerror id="description"><br>
      <span class="errori">@formerror.description;noquote@</span>
    </formerror>
</td>
</tr>
    <tr><td colspan=2 align=center><formwidget id="submit"></td></tr>

<!-- Fine della form colorata -->
<%=[iter_form_fine]%>

</formtemplate>
<p>
</center>

