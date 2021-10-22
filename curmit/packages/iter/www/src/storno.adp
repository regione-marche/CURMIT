<master src="../master">
<property name="title">@page_title@</property>
<property name="context">@context;noquote@</property>
<property name="context_bar">@context_bar;noquote@</property>

<table width=100% cellspacing=0 class=func-menu>
<tr>
   <td width="25%" nowrap class=func-menu>
       <a href=transactions?@link_list;noquote@ class=func-menu>Ritorna</a>
   </td>
   <td width="75%" nowrap class=func-menu>&nbsp;</td>
</tr>
</table>

<center>
<formtemplate id="@form_name;noquote@">
<formwidget   id="caller">
<formwidget   id="nome_funz">
<formwidget   id="extra_par">
<!-- Inizio della form colorata -->
<%=[iter_form_iniz]%>

<tr>
<td>Causale dello storno</td>
<td valign=top>
  <formwidget id="reason">
    <formerror id="reason"><br>
      <span class="errori">@formerror.reason;noquote@</span>
    </formerror>
</td>
</tr>
    <tr><td colspan=2 align=center><formwidget id="submit"></td></tr>

<!-- Fine della form colorata -->
<%=[iter_form_fine]%>

</formtemplate>
<p>
</center>



