<master src="../master">
<property name="title">@page_title;noquote@</property>
<property name="context_bar">@context_bar;noquote@</property>

<formtemplate id="login">

<center>

<!-- disegna una tabella azzurra e grigia -->
<%=[iter_form_iniz]%>

<!-- Ricordare di posizionare gli eventuali link ai pgm di zoom -->

<tr><td><table width=70%>
          <if @msg@ ne N>@msg;noquote@</if>
          <tr><td align=left><b>Se ha gi&agrave; effettuato la registrazione inserisca l'utente e la password.</b></td></tr>
        </table>
</td></tr>
<tr><td>&nbsp;</td></tr>
<tr><td><table width=70%>
        <tr><td align=right>Utente Distributore</td>
        <td><formwidget id="utn_cde">
            <formerror  id="utn_cde"><br>
            <font color="red"><b>@formerror.utn_cde;noquote@</b></font></formerror>
        </td>
        </tr>
        <tr><td align=right>Password</td>
            <td><formwidget id="utn_psw">
                <formerror  id="utn_psw"><br>
                <font color="red"><b>@formerror.utn_psw;noquote@</b></font></formerror>
            </td>
        </tr>
        </table>
</td></tr>
<tr><td colspan=2>&nbsp;</td></tr>
<tr><td colspan=2 align=center><formwidget id="submit"></td></tr>
<tr><td colspan=2>&nbsp;</td></tr>
<tr><td align=left>oppure 
       <a href=coimdist-reg><big><b>Compili la scheda identificativa</b></big></a>
</td></tr>

<!-- chiusura della tabella azzurra e grigia -->
<%=[iter_form_fine]%>

</center>

</formtemplate>

