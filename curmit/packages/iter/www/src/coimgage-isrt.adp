<master   src="../master">
<property name="title">@page_title;noquote@</property>
<property name="context_bar">@context_bar;noquote@</property>
<property name="riga_vuota">f</property>

@link_tab;noquote@
@dett_tab;noquote@

<center>
<formtemplate id="@form_name;noquote@">
<formwidget   id="caller">
<formwidget   id="nome_funz">
<formwidget   id="cod_impianto">
<formwidget   id="url_aimp">
<formwidget   id="url_list_aimp">
<!-- Inizio della form colorata -->
<%=[iter_form_iniz]%>

<tr><td>&nbsp;</td>
    <td>Controlli da eseguire presenti in agenda: @gage_num;noquote@</td>
</tr>

<tr><td colspan=2>&nbsp;</td></tr>

<tr><td valign=top align=right class=form_title>Data prevista</td>
    <td valign=top><formwidget id="data_prevista">
        <formerror  id="data_prevista"><br>
        <span class="errori">@formerror.data_prevista;noquote@</span>
        </formerror>
    </td>
</tr>

<tr><td valign=top align=right class=form_title>Note</td>
    <td valign=top><formwidget id="note">
        <formerror  id="note"><br>
        <span class="errori">@formerror.note;noquote@</span>
        </formerror>
    </td>
</tr>

<if @error_in_form_is_request@ ne "t">
   <tr><td colspan=2 align=center><formwidget id="submit"></td></tr>
</if>

<!-- Fine della form colorata -->
<%=[iter_form_fine]%>

</formtemplate>
<p>
</center>

