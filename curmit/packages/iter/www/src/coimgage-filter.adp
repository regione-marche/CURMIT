<master   src="../master">
<property name="title">@page_title;noquote@</property>
<property name="context_bar">@context_bar;noquote@</property>

<center>
<formtemplate id="@form_name;noquote@">
<formwidget   id="funzione">
<formwidget   id="caller">
<formwidget   id="nome_funz">

<!-- Inizio della form colorata -->
<%=[iter_form_iniz]%>

<tr>
    <td valign=top align=right class=form_title>Stato controlli</td>
    <td valign=top nowrap><formwidget id="f_stato">
        <formerror  id="f_stato"><br>
        <span class="errori">@formerror.f_stato;noquote@</span>
        </formerror>
    </td>
</tr><tr>
    <td valign=top align=right class=form_title>Da data</td>
    <td valign=top nowrap><formwidget id="f_data_iniz">
        <formerror  id="f_data_iniz"><br>
        <span class="errori">@formerror.f_data_iniz;noquote@</span>
        </formerror>
    </td>
</tr><tr>
    <td valign=top align=right class=form_title>A data</td>
    <td valign=top nowrap><formwidget id="f_data_fine">
        <formerror  id="f_data_fine"><br>
        <span class="errori">@formerror.f_data_fine;noquote@</span>
        </formerror>
    </td>
</tr>

<tr><td colspan=4>&nbsp;</td></tr>

<tr><td colspan=4 align=center><formwidget id="submit"></td></tr>

<!-- Fine della form colorata -->
<%=[iter_form_fine]%>

</formtemplate>
<p>
</center>


