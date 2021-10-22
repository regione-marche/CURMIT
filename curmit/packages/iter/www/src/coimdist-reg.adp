<master src="../master">
<property name="title">@page_title;noquote@</property>
<property name="context_bar">@context_bar;noquote@</property>

<formtemplate id="distributore">

<center>

<!-- disegna una tabella azzurra e grigia -->
<%=[iter_form_iniz]%>

<!-- Ricordare di posizionare gli eventuali link ai pgm di zoom -->

<tr><td><table>
        <tr><td colspan=2>&nbsp;</td></tr>
        <tr><td><td width=40% align=right valign=top nowrap>Inserisca il codice fiscale della ditta</td>
        <td><formwidget id="cod_fisc">
            <formerror  id="cod_fisc"><br>
            <font color="red"><b>@formerror.cod_fisc;noquote@</b></font></formerror>
        </td>
        </tr>
<tr><td colspan=2>&nbsp;</td></tr>
<tr><td colspan=2 align=right><formwidget id="submit"></td></tr>
<tr><td colspan=2>&nbsp;</td></tr>
</table>

<!-- chiusura della tabella azzurra e grigia -->
<%=[iter_form_fine]%>

</center>

</formtemplate>

