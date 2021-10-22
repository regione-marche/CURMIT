<master   src="../master">
<property name="title">@page_title;noquote@</property>
<property name="context_bar">@context_bar;noquote@</property>

<center>
<formtemplate id="@form_name;noquote@">
<formwidget   id="funzione">
<formwidget   id="caller">
<formwidget   id="nome_funz">
<formwidget   id="f_cod_manu">
<formwidget   id="dummy">

<!-- Inizio della form colorata -->
<%=[iter_form_iniz]%>

<tr>
    <td valign=top align=right class=form_title>Manutentore</td>
    <td valign=top nowrap><formwidget id="f_manu_cogn">
                          <formwidget id="f_manu_nome">@cerca_manu;noquote@
        <formerror  id="f_manu_cogn"><br>
        <span class="errori">@formerror.f_manu_cogn;noquote@</span>
        </formerror>
    </td>
</tr>

<tr>
    <td valign=top align=right class=form_title>Da data consegna</td>
    <td valign=top nowrap><formwidget id="f_data_ril_da">
        <formerror  id="f_data_ril_da"><br>
        <span class="errori">@formerror.f_data_ril_da;noquote@</span>
        </formerror>
    </td>
</tr>

<tr>
    <td valign=top align=right class=form_title>A data consegna</td>
    <td valign=top nowrap><formwidget id="f_data_ril_a">
        <formerror  id="f_data_ril_a"><br>
        <span class="errori">@formerror.f_data_ril_a;noquote@</span>
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


