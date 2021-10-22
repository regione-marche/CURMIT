<master   src="../master">
<property name="title">@page_title;noquote@</property>
<property name="context_bar">@context_bar;noquote@</property>
<property name="riga_vuota">f</property>



<table width="100%" cellspacing=0 class=func-menu>
<tr>
   <td width="25%" nowrap class=func-menu>
       <a href=coimaimp-ins-filter?@link_filter;noquote@ class=func-menu>Ritorna</a>
   </td>
   <td width="75%" class=func-menu>&nbsp;</td>
</tr>
</table>

<!-- barra con il cerca, link di aggiungi e righe per pagina -->
@list_head;noquote@
<center>
@mex_error;noquote@
</center>
<formtemplate id="@form_name;noquote@">

<formwidget   id="caller">
<formwidget   id="extra_par">
<formwidget   id="nome_funz">
<formwidget   id="nome_funz_caller">
<formwidget   id="flag_tracciato">


<center>
<table>
   <tr>
      <td colspan="7" align="center">
	 <formwidget id="submit">
      </td>
   </tr>

   <tr bgcolor="#f8f8f8" class="table-header">
      <th>Azioni</th>
      <th>seleziona<br>da bonificare</th>
      <th>Responsabile</th>
      <th>Comune</th>
      <th>Indirizzo</th>
      <th>Stato</th>
      <th>seleziona<br>destinazione</th>
   </tr>


<!-- genero la tabella -->
   <multiple name="impianti">
   <tr>
      <td valign="top" align="left">@impianti.link;noquote@</td>
      <td valign="top" align="center">
         <formgroup id="compatta.@impianti.cod_impianto;noquote@">@formgroup.widget;noquote@</formgroup>
         <formerror  id="compatta.@impianti.cod_impianto;noquote@"><br>
            <span class="errori"><%= $formerror(compatta.@impianti.cod_impianto;noquote@) %></span>
         </formerror>
      </td>
      <td valign="top" align="left">@impianti.resp;noquote@</td>
      <td valign="top" align="left">@impianti.comune;noquote@</td>
      <td valign="top" align="left">@impianti.indir;noquote@</td>
      <td valign="top" align="left">@impianti.stato;noquote@</td>
      <td valign="top" align="center">@impianti.destinaz;noquote@</td>
   </tr>    
   </multiple>

   <tr><td colspan="7">&nbsp;</td></tr>

   <tr>
      <td colspan="7" align="center">
         <formwidget id="submit">
      </td>
   </tr>
</table>
</formtemplate>

</center>


