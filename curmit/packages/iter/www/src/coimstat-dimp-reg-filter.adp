<master   src="../master">
<property name="title">@page_title;noquote@</property>
<property name="context_bar">@context_bar;noquote@</property>


<center>
<formtemplate id="@form_name;noquote@">
<formwidget   id="funzione">
<formwidget   id="caller">
<formwidget   id="nome_funz">
<formwidget   id="nome_funz_caller">


<!-- Inizio della form colorata -->
<%=[iter_form_iniz]%>

<tr><td valign=top align=right class=form_title>Da data Dichiarazione</td>
    <td valign=top><formwidget id="f_data_inizio">
        <formerror  id="f_data_inizio"><br>
        <span class="errori">@formerror.f_data_inizio;noquote@</span>
        </formerror>
    </td>
</tr>
<tr><td valign=top align=right class=form_title>A data Dichiarazione</td>
    <td valign=top><formwidget id="f_data_fine">
        <formerror  id="f_data_fine"><br>
        <span class="errori">@formerror.f_data_fine;noquote@</span>
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


