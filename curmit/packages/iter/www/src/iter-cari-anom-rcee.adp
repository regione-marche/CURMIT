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

<!-- Inizio della form colorata -->
<%=[iter_form_iniz]%>
<tr><td colspan=2>&nbsp;</td></tr>
<tr><td colspan=2 align=center><formwidget id="submit"></td></tr>
<tr><td colspan=2>&nbsp;</td></tr>


<tr><td valign=top align=right class=form_title>Data inizio controlli</td>
    <td valign=top><formwidget id="data_ini_elab">
        <formerror  id="data_ini_elab"><br>
        <span class="errori">@formerror.data_ini_elab@</span>
        </formerror>
    </td>
</tr>
<tr><td valign=top align=right class=form_title>Esito generazione</td>
    <td valign=top><formwidget id="msg">
        <formerror  id="msg"><br>
        <span class="errori">@formerror.msg;noquote@</span>
        </formerror>
    </td>
</tr>

<!-- Fine della form colorata -->
<%=[iter_form_fine]%>

</formtemplate>
<p>
</center>

