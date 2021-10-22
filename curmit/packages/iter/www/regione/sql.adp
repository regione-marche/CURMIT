<master   src="../master">
<property name="title">@page_title;noquote@</property>
<property name="context_bar">@context_bar;noquote@</property>

<formtemplate id="@form_name;noquote@">

<table align="center">
  <tr><td height="30">&nbsp;</td></tr>
  <tr>
    <td>Inserire l'istruzione sql da eseguire sui database regionali</td>
  </tr>
  <tr>
   <td><formwidget id="sql_istruction">
       <formerror  id="sql_istruction"><br>
       <span class="errori">@formerror.sql_istruction;noquote@</span>
       </formerror>
   </td>
  </tr>
  <tr><td>&nbsp;</td></tr>
  <tr><td align=center><formwidget id="submit"></td></tr>
</table>

</formtemplate>

