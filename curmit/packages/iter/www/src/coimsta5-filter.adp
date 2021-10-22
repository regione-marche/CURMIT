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

<!-- dpr74 -->
<tr><td valign=top align=right class=form_title>Tipoologia impianti</td>
    <td valign=top colspan=2 nowrap><formwidget id="flag_tipo_impianto">
        <formerror id="flag_tipo_impianto"><br>
        <span class="errori">@formerror.flag_tipo_impianto;noquote@</span>
        </formerror>
    </td>
</tr>
<!-- dpr74 -->

<tr><td valign=top align=right class=form_title>Data controllo da</td>
    <td valign=top colspan=1><formwidget id="f_data1">
        <formerror  id="f_data1"><br>
        <span class="errori">@formerror.f_data1;noquote@</span>
        </formerror>
    </td>

    <td valign=top align=right class=form_title>a</td>
    <td valign=top><formwidget id="f_data2">
        <formerror id="f_data2"><br>
        <span class="errori">@formerror.f_data2;noquote@</span>
        </formerror>
    </td>
</tr>

<tr><td colspan=2>&nbsp;</td></tr>

<tr><td colspan=4 align=center><formwidget id="submit"></td></tr>

<!-- Fine della form colorata -->
<%=[iter_form_fine]%>

</formtemplate>
<p>
</center>

