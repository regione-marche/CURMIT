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


<tr><td valign=top align=right class=form_title>Campagna</td>
    <td valign=top colspan=1><formwidget id="f_campagna">
        <formerror  id="f_campagna"><br>
        <span class="errori">@formerror.f_campagna;noquote@</span>
        </formerror>
    </td>
</tr>

<tr>
    <td valign=top align=right class=form_title>Tipo statistica</td>
    <td valign=top colspan=1><formwidget id="f_tipo_stat">
       <formerror  id="f_tipo_stat"><br>
       <span class="errori">@formerror.f_tipo_stat;noquote@</span>
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

