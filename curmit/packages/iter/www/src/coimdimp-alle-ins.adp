<master   src="../master">
<property name="title">@page_title;noquote@</property>
<property name="context_bar">@context_bar;noquote@</property>
<property name="riga_vuota">f</property>


@link_tab;noquote@
@dett_tab;noquote@

<center>
<formtemplate id="@form_name;noquote@">
<formwidget   id="funzione">
<formwidget   id="caller">
<formwidget   id="nome_funz">
<formwidget   id="nome_funz_caller">
<formwidget   id="extra_par">
<formwidget   id="cod_impianto">
<formwidget   id="url_aimp">
<formwidget   id="url_list_aimp">

<!-- Inizio della form colorata -->
<%=[iter_form_iniz]%>

<tr>
<tr><td valign=top align=right class=form_title>Contenuto</td>
    <td valign=top colspan=3><formwidget id="contenuto">
        <formerror  id="contenuto"><br>
        <span class="errori">@formerror.contenuto;noquote@</span>
        </formerror>
    </td>
</tr>

<tr><td colspan=4 align=center><formwidget id="submit"></td></tr>

<!-- Fine della form colorata -->
<%=[iter_form_fine]%>

</formtemplate>
<p>
</center>


