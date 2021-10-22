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
<formwidget   id="cod_inco">
<formwidget   id="cod_impianto">
<formwidget   id="url_list_aimp">
<formwidget   id="url_aimp">
<formwidget   id="f_tipo_data">
<formwidget   id="f_data">
<formwidget   id="f_cod_impianto">
<formwidget   id="f_tipo_estrazione">
<formwidget   id="f_anno_inst_da">
<formwidget   id="f_anno_inst_a">
<formwidget   id="f_cod_comb">
<formwidget   id="f_cod_enve">
<formwidget   id="f_cod_tecn">
<formwidget   id="f_cod_comune">
<formwidget   id="f_descr_topo">
<formwidget   id="f_descr_via">
<formwidget   id="f_cod_via">
<formwidget   id="f_num_max">
<formwidget   id="f_cod_area">
@link_inco;noquote@
@dett_tab;noquote@

<br><br><br>
<!-- Inizio della form colorata -->
<%=[iter_form_iniz]%>
<table width=100%>

<tr>
    <td valign=top align=right class=form_title width=40%>Tipo Documento</td>
    <td valign=top align=left><formwidget id="id_stampa">
    <formerror  id="id_stampa"><br>
        <span class="errori">@formerror.id_stampa;noquote@</span>
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


<%=[iter_form_fine]%>

</formtemplate>
</center>

