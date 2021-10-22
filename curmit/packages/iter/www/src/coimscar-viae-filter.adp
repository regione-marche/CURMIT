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
<tr><td valign=top align=right class=form_title>Comune</td>
    <td valign=top><formwidget id="f_comune">
        <formerror  id="f_comune"><br>
        <span class="errori">@formerror.f_comune;noquote@</span>
        </formerror>
    </td>
</tr>

<tr><td colspan=2>&nbsp;</td></tr>

<tr><td colspan=2 align=center><formwidget id="submit"></td></tr>

<!-- Fine della form colorata -->
<%=[iter_form_fine]%>

</formtemplate>
<!-- <a href="coimscar-file?nome_funz=scar-file">Scarico complessivo di tutte le tabelle coimaimp, coimcimp, coimdimp</a> -->
<br>
</center>

