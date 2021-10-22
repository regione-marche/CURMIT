<master   src="../master">
<property name="title">@page_title;noquote@</property>
<property name="context_bar">@context_bar;noquote@</property>

<center>
<formtemplate id="@form_name;noquote@">
<formwidget   id="nome_funz">
<formwidget   id="nome_funz_caller">
<!-- Inizio della form colorata -->
<%=[iter_form_iniz]%>

<tr>
    <td valign=top align=right class=form_title>Da data inserimento</td>
    <td valign=top nowrap><formwidget id="da_data">
        <formerror  id="da_data"><br>
        <span class="errori">@formerror.da_data;noquote@</span>
        </formerror>
    </td>
</tr>

<tr><td valign=top align=right class=form_title>A data inserimento</td>
    <td valign=top nowrap><formwidget id="a_data">
        <formerror  id="a_data"><br>
        <span class="errori">@formerror.a_data;noquote@</span>
        </formerror>
    </td>
</tr>

<tr><td valign=top align=right class=form_title>Campagna dichiarazioni</td>
    <td valign=top colspan=3 nowrap><formwidget id="cod_cind">
        <formerror id="cod_cind"><br>
        <span class="errori">@formerror.cod_cind;noquote@</span>
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


