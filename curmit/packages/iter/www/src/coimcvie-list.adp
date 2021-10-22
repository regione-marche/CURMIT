<master   src="../master">
<property name="title">@page_title;noquote@</property>
<property name="context_bar">@context_bar;noquote@</property>
<property name="riga_vuota">f</property>



<table width="100%" cellspacing=0 class=func-menu>
<tr>
   <td width="25%" nowrap class=func-menu>
       <a href=coimcvie-filter?@link_filter;noquote@ class=func-menu>Ritorna</a>
   </td>
   <td width="75%" class=func-menu>&nbsp;</td>
</tr>
</table>

<!-- barra con il cerca, link di aggiungi e righe per pagina -->
@list_head;noquote@
<center>
@msg_errore;noquote@
</center>
<formtemplate id="@form_name;noquote@">

<formwidget   id="caller">
<formwidget   id="extra_par">
<formwidget   id="nome_funz">
<formwidget   id="nome_funz_caller">


<center>

<table>
<tr>
    <td colspan=8 align=center>
       <formwidget id="submit">
    </td>
</tr>

<tr bgcolor=#f8f8f8 class=table-header>
   <th>seleziona<br>da bonificare</th>
   <th>Codice</th>
   <th>Toponimo</th>
   <th>Descrizione</th>
   <th>Descrizione Estesa</th>
   <th>Comune</th>
   <th>seleziona<br>destinazione</th>
</tr>

<!-- genero la tabella -->

<multiple name=vie>
<tr>
    <td valign=top align=center>
       <formgroup id="compatta.@vie.cod_via;noquote@">@formgroup.widget;noquote@</formgroup>
       <formerror  id="compatta.@vie.cod_via;noquote@"><br>
       <span class="errori"><%= $formerror(compatta.@vie.cod_via;noquote@) %></span>
       </formerror>
    </td>
    <td valign=top align=right>@vie.cod_via;noquote@</td>
    <td valign=top align=left>@vie.descr_topo;noquote@</td>
    <td valign=top align=left>@vie.descrizione;noquote@</td>
    <td valign=top align=left>@vie.descr_estesa;noquote@</td>
    <td valign=top align=left>@vie.denom_comune;noquote@</td>
    <td valign=top align=center>@vie.destinaz;noquote@</td>
</tr>    
</multiple>

<tr><td colspan=8>&nbsp;</td></tr>

<tr>
    <td colspan=8 align=center>
       <formwidget id="submit">
    </td>
</tr>
</formtemplate>

</center>


