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

<tr><td valign=top align=right class=form_title>Data Documento da</td>
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

<tr><td valign=top align=right class=form_title>Comune</td>
    <td valign=top colspan=3><formwidget id="f_comune">
        <formerror  id="f_comune"><br>
        <span class="errori">@formerror.f_comune;noquote@</span>
        </formerror>
    </td>
</tr>


<tr>
    <td valign=top align=right class=form_title>Manutentore</td>
    <td valign=top colspan=3><formwidget id="cognome_manu"><formwidget id="nome_manu">@cerca_manu;noquote@
        <formerror  id="cognome_manu"><br>
        <span class="errori">@formerror.cognome_manu;noquote@</span>
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

