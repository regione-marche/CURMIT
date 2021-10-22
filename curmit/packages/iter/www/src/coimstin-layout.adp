<master   src="../master">
<property name="title">@page_title;noquote@</property>
<property name="context_bar">@context_bar;noquote@</property>

<table width="100%" cellspacing=0 class=func-menu>
   <tr>
   <td width="25%" nowrap class=func-menu>
       <a href=coimstin-filter?@link_filter;noquote@  class=func-menu>Ritorna</a>
   </td>
   <td width="75%" class=func-menu>&nbsp;</td>
</tr>
</table>

<center>

<button onclick="javascript:window.open('@file_pdf_url;noquote@', 'stampa', 'scrollbars=yes, resizable=yes')">Stampa</button>
 
<br>
<a href="@file_csv_url;noquote@">Scarica file csv</a>
<br>
@stampa;noquote@
<br>
<button onclick="javascript:window.open('@file_pdf_url;noquote@', 'stampa', 'scrollbars=yes, resizable=yes')">Stampa</button>

</center>

