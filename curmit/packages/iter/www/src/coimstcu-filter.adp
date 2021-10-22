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

<tr><td valign=top align=right class=form_title>Stato impianto</td>
    <td valign=top colspan=3><formwidget id="f_stato">
        <formerror  id="f_stato"><br>
        <span class="errori">@formerror.f_stato;noquote@</span>
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
    <td valign=top align=right class=form_title>Da codice impianto</td>
    <td valign=top align=left><formwidget id="f_da_impianto">
    <formerror  id="f_da_impianto"><br>
        <span class="errori">@formerror.f_da_impianto;noquote@</span>
    </formerror>
    </td>
    <td valign=top align=right class=form_title>A</td>
    <td valign=top align=left><formwidget id="f_a_impianto">
    <formerror  id="f_a_impianto"><br>
        <span class="errori">@formerror.f_a_impianto;noquote@</span>
    </formerror>
    </td>
</tr>

<tr>
    <td valign=top align=right class=form_title>Tipo Documento</td>
    <td valign=top align=left colspan=3><formwidget id="id_stampa">
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

