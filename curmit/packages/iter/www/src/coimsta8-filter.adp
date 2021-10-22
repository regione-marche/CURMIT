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

<tr><td valign=top align=right class=form_title>Data consegna da</td>
    <td valign=top colspan=1><formwidget id="da_data_cons">
        <formerror  id="da_data_cons"><br>
        <span class="errori">@formerror.da_data_cons;noquote@</span>
        </formerror>
    </td>

    <td valign=top align=right class=form_title>a</td>
    <td valign=top><formwidget id="a_data_cons">
        <formerror id="a_data_cons"><br>
        <span class="errori">@formerror.a_data_cons;noquote@</span>
        </formerror>
    </td>
</tr>

<tr><td valign=top align=right class=form_title>Data scadenza da</td>
    <td valign=top colspan=1><formwidget id="da_data_scad">
        <formerror  id="da_data_scad"><br>
        <span class="errori">@formerror.da_data_scad;noquote@</span>
        </formerror>
    </td>

    <td valign=top align=right class=form_title>a</td>
    <td valign=top><formwidget id="a_data_scad">
        <formerror id="a_data_scad"><br>
        <span class="errori">@formerror.a_data_scad;noquote@</span>
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

