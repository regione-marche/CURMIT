<master   src="../master">
<property name="title">@page_title;noquote@</property>
<property name="context_bar">@context_bar;noquote@</property>
<property name="riga_vuota">f</property>

<p>&nbsp;</p>
<center>
<formtemplate id="@form_name;noquote@">
<formwidget   id="funzione">
<formwidget   id="caller">
<formwidget   id="nome_funz">
<formwidget   id="nome_funz_caller">


<!-- Inizio della form colorata -->
<%=[iter_form_iniz]%>

<tr>
    <td valign=top align=right class=form_title>Da data caricamento file</td>
    <td valign=top><formwidget id="f_data_caricamento_da">
        <formerror id="f_data_caricamento_da"><br>
        <span class="errori">@formerror.f_data_caricamento_da;noquote@</span>
        </formerror>
    </td>
</tr>
<tr>
    <td valign=top align=right class=form_title>A data caricamento file</td>
    <td valign=top><formwidget id="f_data_caricamento_a">
        <formerror id="f_data_caricamento_a"><br>
        <span class="errori">@formerror.f_data_caricamento_a;noquote@</span>
        </formerror>
    </td>
</tr>
<tr> 
    <td valign=top align=right class=form_title>Nome file</td>
    <td valign=top><formwidget id="f_nome_file">
        <formerror id="f_nome_file"><br>
        <span class="errori">@formerror.f_nome_file;noquote@</span>
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
