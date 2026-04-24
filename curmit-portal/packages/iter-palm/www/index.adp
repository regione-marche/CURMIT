<master src="master">
<property name="title">@page_title@</property>
<property name="context_bar">@context_bar@</property>

<formtemplate id="login">

<center>

<!-- disegna una tabella azzurra e grigia -->
<%=[iter_form_iniz]%>

<!-- Ricordare di posizionare gli eventuali link ai pgm di zoom -->
<tr><td align=right>Codice Utente</td>
    <td><formwidget id="utn_cde">
        <formerror  id="utn_cde"><br>
        <font color="red"><b>@formerror.utn_cde@</b></font></formerror>
    </td>
</tr>
<tr><td align=right>Password</td>
    <td><formwidget id="utn_psw">
        <formerror  id="utn_psw"><br>
        <font color="red"><b>@formerror.utn_psw@</b></font></formerror>
    </td>
</tr>
<tr><td colspan=2 align=center><formwidget id="submit"></td></tr>
<tr><td colspan=2>&nbsp;</td></tr>

<!-- chiusura della tabella azzurra e grigia -->
<%=[iter_form_fine]%>

</center>

</formtemplate>
