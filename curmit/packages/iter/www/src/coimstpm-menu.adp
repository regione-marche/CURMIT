<master   src="../master">
<property name="title">@page_title;noquote@</property>
<property name="context_bar">@context_bar;noquote@</property>
<property name="riga_vuota">f</property>

<center>
<formtemplate id="@form_name;noquote@">
<formwidget   id="funzione">
<formwidget   id="caller">
<formwidget   id="nome_funz">
<formwidget   id="nome_funz_caller">
<formwidget   id="extra_par">
<formwidget   id="last_cod_impianto">
<formwidget   id="cod_impianto">
<formwidget   id="url_list_aimp">
<formwidget   id="url_aimp">

@link_tab;noquote@
@dett_tab;noquote@

<!-- Inizio della form colorata -->
<%=[iter_form_iniz]%>
<table width=100%>

<tr>
    <td valign=top align=right class=form_title width=50%>Tipo Documento</td>
    <td valign=top width=50%><formwidget id="id_stampa">
    <formerror  id="id_stampa"><br>
        <span class="errori">@formerror.id_stampa;noquote@</span>
    </formerror>
    </td>
</tr>

<tr>
    <td valign=top align=right class=form_title width=50%>Ragruppamento</td>
    <td valign=top width=50%><formwidget id="cod_rgen">
    <formerror  id="cod_rgen"><br>
        <span class="errori">@formerror.cod_rgen;noquote@</span>
    </formerror>
    </td>
</tr>

<tr>
    <td colspan=2 >&nbsp;
    </td>
</tr>

<tr>
    <td colspan=2 align=center><formwidget id="submit">
    </td>
</tr>

<!-- Fine della form colorata -->
</table>

<%=[iter_form_fine]%>

</formtemplate>
</center>

