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
<tr>
   <td align=right colspan=2><a href="#" onclick="javascript:window.open('coimmanu-help', 'help', 'scrollbars=yes, resizable=yes, width=570, height=320').moveTo(110,140)"><b>Help</b></a>
    </td>
</tr>

<tr><td valign=top align=right class=form_title>Codice Manutentore</td>
    <td valign=top><formwidget id="f_cod_manutentore">
        <formerror  id="f_cod_manutentore"><br>
        <span class="errori">@formerror.f_cod_manutentore;noquote@</span>
        </formerror>
    </td>
</tr>

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
    <td valign=top align=right class=form_title>Ruolo</td>
    <td valign=top nowrap><formwidget id="f_ruolo">
        <formerror  id="f_ruolo"><br>
        <span class="errori">@formerror.f_ruolo;noquote@</span>
        </formerror>
    </td>
</tr>

<tr>
    <td valign=top align=right class=form_title>Convenzionato</td>
    <td valign=top nowrap><formwidget id="f_convenzionato">
        <formerror  id="f_convenzionato"><br>
        <span class="errori">@formerror.f_convenzionato;noquote@</span>
        </formerror>
    </td>
</tr>

<tr>
    <td valign=top align=right class=form_title>Stato</td>
    <td valign=top nowrap><formwidget id="f_stato">
        <formerror  id="f_stato"><br>
        <span class="errori">@formerror.f_stato;noquote@</span>
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

