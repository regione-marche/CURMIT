<master   src="../master">
<property name="title">@page_title;noquote@</property>
<property name="context_bar">@context_bar;noquote@</property>

<center>
<formtemplate id="@form_name;noquote@">
<formwidget   id="funzione">
<formwidget   id="caller">
<formwidget   id="nome_funz">
<formwidget   id="nome_funz_caller">

<table width=100% cellspacing=0 class=func-menu>
<!-- Inizio della form colorata -->
<%=[iter_form_iniz]%>
<tr><td valign=top align=right class=form_title>Ente Verificatore</td>
    <td valign=top colspan=3><formwidget id="f_cod_enve">
        <formerror  id="f_cod_enve"><br>
        <span class="errori">@formerror.f_cod_enve;noquote@</span>
        </formerror>
    </td>
</tr>

<tr>
    <td valign=top align=right class=form_title>Tecnico assegnato</td>
    <td valign=top colspan=3><formwidget id="f_cog_tecn">
                             <formwidget id="f_nom_tecn">@cerca_opve;noquote@
        <formerror  id="f_cog_tecn"><br>
        <span class="errori">@formerror.f_cog_tecn;noquote@</span>
        </formerror>
</tr>

<tr><td colspan=2>&nbsp;</td></tr>

<tr><td colspan=2 align=center><formwidget id="submit"></td></tr>

<!-- Fine della form colorata -->
<%=[iter_form_fine]%>

</formtemplate>
<p>
</center>

