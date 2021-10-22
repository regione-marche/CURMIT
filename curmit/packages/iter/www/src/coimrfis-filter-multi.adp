<master   src="../master">
<property name="title">@page_title;noquote@</property>
<property name="context_bar">@context_bar;noquote@</property>

<center>
<formtemplate id="@form_name;noquote@">
<formwidget   id="nome_funz">
<formwidget   id="nome_funz_caller">
<!-- Inizio della form colorata -->
<%=[iter_form_iniz]%>

<tr>
    <td valign=top align=right class=form_title>Da numero ricevuta</td>
    <td valign=top nowrap><formwidget id="f_da_num_rfis">
        <formerror  id="f_da_num_rfis"><br>
        <span class="errori">@formerror.f_da_num_rfis;noquote@</span>
        </formerror>
    </td>
</tr>

<tr>
    <td valign=top align=right class=form_title>A numero ricevuta</td>
    <td valign=top nowrap colspan=3><formwidget id="f_a_num_rfis">
        <formerror  id="f_a_num_rfis"><br>
        <span class="errori">@formerror.f_a_num_rfis;noquote@</span>
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


