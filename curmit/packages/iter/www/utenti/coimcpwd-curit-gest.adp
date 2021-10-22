<master   src="../master">
<property name="title">@page_title;noquote@</property>
<property name="context_bar">@context_bar;noquote@</property>

<center>
<formtemplate id="@form_name;noquote@">
<formwidget   id="funzione">
<formwidget   id="nome_funz">

<!-- Inizio della form colorata -->
<%=[iter_form_iniz]%>

<!-- TODO: Ricordare di posizionare gli eventuali link ai pgm di zoom -->

<tr><td valign=top align=right class=form_title>Password attuale</td>
    <td valign=top><formwidget id="utn_psw">
        <formerror  id="utn_psw"><br>
        <span class="errori">@formerror.utn_psw;noquote@</span>
        </formerror>
    </td>
</tr>

<tr><td valign=top align=right class=form_title>Nuova Password</td>
    <td valign=top><formwidget id="utn_psw_new">
        <formerror  id="utn_psw_new"><br>
        <span class="errori">@formerror.utn_psw_new;noquote@</span>
        </formerror>
    </td>
</tr>

<tr><td valign=top align=right class=form_title>Conferma Password</td>
    <td valign=top><formwidget id="utn_psw_cnf">
        <formerror  id="utn_psw_cnf"><br>
        <span class="errori">@formerror.utn_psw_cnf;noquote@</span>
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

