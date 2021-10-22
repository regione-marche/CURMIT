<master   src="../master">
<property name="title">@page_title;noquote@</property>
<property name="context_bar">@context_bar;noquote@</property>

<center>
<formtemplate id="@form_name;noquote@">
<formwidget   id="funzione">
<formwidget   id="caller">
<formwidget   id="nome_funz">
<formwidget   id="nome_funz_caller">
<formwidget   id="flag_cod_tecn">
<formwidget   id="flag_cod_enve">
<formwidget   id="cod_opve">
<!-- Inizio della form colorata -->
<%=[iter_form_iniz]%>

<if @flag_cod_tecn@ ne t and @flag_cod_enve@ ne t>
    <tr><td valign=top align=right class=form_title>Ente Verificatore</td>
        <td valign=top colspan=3><formwidget id="cod_enve">
            <formerror  id="cod_enve"><br>
            <span class="errori">@formerror.cod_enve;noquote@</span>
            </formerror>
        </td>
    </tr>
</if>
<else>
    <tr><td valign=top align=right class=form_title>Ente Verificatore</td>
        <td valign=top colspan=3><formwidget id="desc_enve"></td>
    </tr>
</else>
<tr>
    <td valign=top align=right class=form_title>Tecnico assegnato</td>
    <td valign=top colspan=3><formwidget id="f_cog_tecn">
                             <formwidget id="f_nom_tecn"><if @livello@ eq "5">@cerca_opve;noquote@</if>
        <formerror  id="f_cog_tecn"><br>
        <span class="errori">@formerror.f_cog_tecn;noquote@</span>
        </formerror>
</tr>
<tr><td valign=top align=right class=form_title>Mese</td>
    <td valign=top colspan=1><formwidget id="mese"></td>
        <formerror  id="mese"><br>
        <span class="errori">@formerror.mese;noquote@</span>
        </formerror>
    <td valign=top align=right class=form_title>Anno</td>
    <td valign=top colspan=1><formwidget id="anno">
        <formerror  id="anno"><br>
        <span class="errori">@formerror.anno;noquote@</span>
        </formerror>
</tr>

<tr><td colspan=4>&nbsp;</td></tr>
<tr><td colspan=4 align=center><formwidget id="submit"></td></tr>

<!-- Fine della form colorata -->
<%=[iter_form_fine]%>

</formtemplate>
<p>
</center>

