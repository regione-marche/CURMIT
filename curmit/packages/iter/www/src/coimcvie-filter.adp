<master   src="../master">
<property name="title">@page_title;noquote@</property>
<property name="context_bar">@context_bar;noquote@</property>

<center>
<formtemplate id="@form_name;noquote@">
<formwidget   id="caller">
<formwidget   id="nome_funz">
<if @flag_ente eq C>
    <formwidget id="cod_comune">
</if>

<!-- Inizio della form colorata -->
<%=[iter_form_iniz]%>

<if @flag_ente@ ne C>
    <tr>
        <td valign=top align=right class=form_title>Comune</td>
        <td valign=top nowrap><formwidget id="f_cod_comune">
            <formerror  id="f_cod_comune"><br>
            <span class="errori">@formerror.f_cod_comune;noquote@</span>
            </formerror>
        </td>
    </tr>
</if>

<tr><td valign=top align=right class=form_title>Descrizione via</td>
    <td valign=top nowrap><formwidget id="f_descrizione">
        <formerror  id="f_descrizione"><br>
        <span class="errori">@formerror.f_descrizione;noquote@</span>
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

