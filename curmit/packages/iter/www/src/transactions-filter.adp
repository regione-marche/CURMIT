<master   src="../master">
<property name="title">@page_title;noquote@</property> 
<property name="context_bar">@context_bar;noquote@</property>

<center>
<formtemplate id="@form_name;noquote@">
<formwidget   id="funzione">
<formwidget   id="caller">
<formwidget   id="nome_funz">
<formwidget   id="receiving_element">

<!-- Inizio della form colorata -->
<%=[iter_form_iniz]%>

<tr><td valign=top align=right class=form_title>Codice Manutentore</td>
    <td valign=top><formwidget id="maintainer_id">
        <formerror  id="maintainer_id"><br>
        <span class="errori">@formerror.maintainer_id;noquote@</span>
        </formerror>
    </td>
</tr>

<tr>
    <td valign=top align=right class=form_title>Nominativo Manutentore</td>
    <td valign=top nowrap><formwidget id="name">
        <formerror  id="name"><br>
        <span class="errori">@formerror.name;noquote@</span>
        </formerror>
    </td>
</tr>

<tr><td valign=top align=right class=form_title>Codice portafoglio</td>
    <td valign=top nowrap><formwidget id="wallet_id">
        <formerror  id="wallet_id"><br>
        <span class="errori">@formerror.wallet_id;noquote@</span>
        </formerror>
    </td>
</tr>

<tr>
    <td valign=top align=right class=form_title>Ente competente</td>
    <td valign=top nowrap><formwidget id="body_id">
        <formerror  id="body_id"><br>
        <span class="errori">@formerror.body_id;noquote@</span>
        </formerror>
    </td>
</tr>

<tr>
    <td valign=top align=right class=form_title>Da data movimento</td>
    <td valign=top nowrap><formwidget id="from_date">
        <formerror  id="from_date"><br>
        <span class="errori">@formerror.from_date;noquote@</span>
        </formerror>
    </td>
</tr>

<tr>
    <td valign=top align=right class=form_title>A data movimento</td>
    <td valign=top nowrap><formwidget id="to_date">
        <formerror  id="to_date"><br>
        <span class="errori">@formerror.to_date;noquote@</span>
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

