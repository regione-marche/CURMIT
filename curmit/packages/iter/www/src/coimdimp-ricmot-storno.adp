<master   src="../master">
<property name="title">@page_title;noquote@</property>
<property name="context_bar">@context;noquote@</property>
<center>
<formtemplate id="@form_name;noquote@">

<formwidget   id="cod_dimp">
<formwidget   id="nome_funz">
<formwidget   id="cod_impianto">

<!-- Inizio della form colorata -->
<%=[iter_form_iniz]%>

<tr>
    <td colspan=2 valign=top align=center
	class=form_title> <a href=@return_url;noquote@>Ritorna</a>
</td>
</tr>
<tr>
    <td valign=top align=right class=form_title>Motivazione storno</td>
    <td valign=top><formwidget id="motivo_storno">
        <formerror  id="motivo_storno"><br>
        <span class="errori">@formerror.motivo_storno;noquote@</span>
        </formerror>
    </td>
</tr>

<tr><td colspan=2>&nbsp;</td></tr>

    <tr><td colspan=2 align=center><formwidget id="submit"></td></tr>

<!-- Fine della form colorata -->

<%=[iter_form_fine]%>


</table>
</if>

</formtemplate>
<p>
</center>

