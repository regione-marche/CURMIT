<master   src="../master">
<property name="title">@page_title;noquote@</property>
<property name="context_bar">@context_bar;noquote@</property>

<center>
<formtemplate id="@form_name;noquote@">
<formwidget   id="funzione">
<formwidget   id="caller">
<formwidget   id="nome_funz">
<formwidget   id="nome_funz_caller">
<formwidget   id="receiving_element">

<!-- Inizio della form colorata -->
<%=[iter_form_iniz]%>

<tr>
    <td valign=top align=right class=form_title>Combustibile</td>
    <td valign=top nowrap><formwidget id="f_combustibile">
        <formerror  id="f_combustibile"><br>
        <span class="errori">@formerror.f_combustibile;noquote@</span>
        </formerror>
    </td>
</tr>

<tr><td colspan=2>&nbsp;</td></tr>
<tr><td colspan=2 align=center><formwidget id="submit"></td></tr>

<!-- Fine della form colorata -->
<%=[iter_form_fine]%>

</formtemplate>
<p>
</center>

