<master   src="../master">
<property name="title">@page_title;noquote@</property>
<property name="context_bar">@context_bar;noquote@</property>

<center>
<formtemplate id="@form_name;noquote@">
<formwidget   id="funzione">
<formwidget   id="caller">
<formwidget   id="nome_funz">
<formwidget   id="nome_funz_caller">
<formwidget   id="receiving_element">
<formwidget   id="f_cod_manu">
<formwidget   id="dummy">

<!-- Inizio della form colorata -->
<%=[iter_form_iniz]%>
<tr><td colspan=2>&nbsp;</td></tr>

<tr><td valign=top align=right class=form_title>Manutentore</td>
    <td valign=top><formwidget id="f_manu_cogn">
        <formerror  id="f_manu_cogn"><br>
        <span class="errori">@formerror.f_manu_cogn;noquote@</span>
        </formerror>
    </td>   
</tr>

<tr><td valign=top align=right class=form_title>&nbsp;</td>
    <td valign=top><formwidget id="f_manu_nome">@cerca_manu;noquote@
        <formerror  id="f_manu_nome"><br>
        <span class="errori">@formerror.f_manu_nome;noquote@</span>
        </formerror>
    </td>   
</tr>

<tr><td colspan=2>&nbsp;</td></tr>

<tr><td colspan=2>&nbsp;</td></tr>
<tr><td colspan=2 align=center><formwidget id="submit"></td></tr>

<!-- Fine della form colorata -->
<%=[iter_form_fine]%>

</formtemplate>
<p>
</center>

