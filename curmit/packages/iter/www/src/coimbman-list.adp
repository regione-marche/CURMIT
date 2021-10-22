<master   src="../master">
<property name="title">@page_title;noquote@</property>
<property name="context_bar">@context_bar;noquote@</property>

<table width="100%" cellspacing=0 class=func-menu>
   <tr>
   <td width="25%" nowrap class=func-menu>
       <a href=coimbman-filter?@link_filter;noquote@  class=func-menu>Ritorna</a>
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
<formwidget   id="nome_funz">
<formwidget   id="nome_funz_caller">
<formwidget   id="f_nome">
<formwidget   id="search_word">

<center>


<table>
<tr>
    <td colspan=6 align=center>
       <formwidget id="submit">
    </td>
</tr>

<tr bgcolor=#f8f8f8 class=table-header>
   <th>seleziona<br>da bonificare</th>
   <th>Codice</th>
   <th>Nominativo</th>
   <th>Indirizzo</th>
   <th>Comune</th>
   <th>Codice Fiscale</th>
   <th>Selez<br>destinazione</th>
</tr>


<!-- genero la tabella -->
<multiple name=manutentori>
<tr>
    <td valign=top align=center>
       <formgroup id="compatta.@manutentori.cod_manutentore;noquote@">@formgroup.widget;noquote@</formgroup>
       <formerror  id="compatta.@manutentori.cod_manutentore;noquote@"><br>
       <span class="errori"><%= $formerror(compatta.@manutentori.cod_manutentore;noquote@) %></span>
       </formerror>
    </td>
    <td valign=top align=left>@manutentori.cod_manu;noquote@</td>
    <td valign=top align=left>@manutentori.nominativo;noquote@</td>
    <td valign=top align=left>@manutentori.indirizzo;noquote@</td>
    <td valign=top align=left>@manutentori.comune;noquote@</td>
    <td valign=top align=left>@manutentori.cod_fiscale;noquote@</td>
    <td valign=top align=center>@manutentori.destinaz;noquote@</td>
</tr>    
</multiple>

<tr><td colspan=6>&nbsp;</td></tr>

<tr>
    <td colspan=6 align=center>
       <formwidget id="submit">
    </td>
</tr>
</formtemplate>

</center>


