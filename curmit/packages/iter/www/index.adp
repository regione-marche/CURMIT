<master src="master">
<property name="title">@page_title;noquote@</property>
<property name="context_bar">@context_bar;noquote@</property>

<formtemplate id="login">

<center>

<!-- disegna una tabella azzurra e grigia -->
<%=[iter_form_iniz]%>

<!-- Ricordare di posizionare gli eventuali link ai pgm di zoom -->
<br>
<br>
<tr><td align=right><b>Codice Utente</b></td>
    <td><formwidget id="utn_cde">
        <formerror  id="utn_cde"><br>
        <font color="red"><b>@formerror.utn_cde;noquote@</b></font></formerror>
    </td>
</tr>
<tr><td align=right><b>Password</b></td>
    <td><formwidget id="utn_psw">
        <formerror  id="utn_psw"><br>
        <font color="red"><b>@formerror.utn_psw;noquote@</b></font></formerror>
    </td>
</tr>
<br>
<br>
<tr><td colspan=2 align=center><formwidget id="submit"></td></tr>
<tr><td colspan=2>&nbsp;</td></tr>

<!-- chiusura della tabella azzurra e grigia -->
<%=[iter_form_fine]%>

</center>



</formtemplate>

