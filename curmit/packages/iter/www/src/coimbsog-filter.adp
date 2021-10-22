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

<!-- Inizio della form colorata -->
<%=[iter_form_iniz]%>

<tr>
    <td valign=top align=right class=form_title>Cognome</td>
    <td valign=top nowrap><formwidget id="f_cognome">
        <formerror  id="f_cognome"><br>
        <span class="errori">@formerror.f_cognome;noquote@</span>
        </formerror>
    </td>
</tr>

<tr><td valign=top align=right class=form_title>Nome</td>
    <td valign=top nowrap><formwidget id="f_nome">
        <formerror  id="f_nome"><br>
        <span class="errori">@formerror.f_nome;noquote@</span>
        </formerror>
    </td>
</tr>

<tr>
    <td valign=top align=right class=form_title>Comune</td>
    <td valign=top nowrap><formwidget id="f_comune">@link_comune;noquote@
        <formerror  id="f_comune"><br>
        <span class="errori">@formerror.f_comune;noquote@</span>
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

