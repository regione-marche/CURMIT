<master   src="../master">
<property name="title">@page_title;noquote@</property>
<property name="context_bar">@context_bar;noquote@</property>

<center>
<formtemplate id="@form_name;noquote@">
<formwidget   id="funzione">
<formwidget   id="caller">
<formwidget   id="nome_funz">
<formwidget   id="nome_funz_caller">
<formwidget   id="dummy">

<table width=100% cellspacing=0 class=func-menu>
<tr>
   <td width="25%" class=func-menu>&nbsp;</td>
   <td width="50%" class=func-menu align=center>Campagna: <b>@desc_camp;noquote@</b></td>
   <td width="25%" class=func-menu>&nbsp;</td>
</tr>
</table>

<br>
<!-- Inizio della form colorata -->
<%=[iter_form_iniz]%>
<!-- dpr74 -->
    <tr><td valign=top align=right class=form_title>Tipo documento</td>
        <td valign=top colspan=3><formwidget id="id_stampa">
            <formerror  id="id_stampa"><br>
            <span class="errori">@formerror.id_stampa;noquote@</span>
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

