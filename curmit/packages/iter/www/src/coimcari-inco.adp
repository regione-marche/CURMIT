<master   src="../master">
<property name="title">@page_title;noquote@</property>
<property name="context_bar">@context_bar;noquote@</property>
<property name="riga_vuota">f</property>

<center>


<formtemplate id="@form_name;noquote@">
<formwidget   id="funzione">
<formwidget   id="caller">
<formwidget   id="nome_funz">

<!-- Inizio della form colorata -->
<%=[iter_form_iniz]%>


<tr><td colspan=2>&nbsp;</td></tr>

<tr>
    <td valign=top align=right class=form_title>Verificatore</td>
    <td valign=top><formwidget id="cod_opve">
        <formerror  id="cod_opve"><br>
        <span class="errori">@formerror.cod_opve;noquote@</span>
        </formerror>
    </td>
</tr>

<tr>
    <td valign=top align=right class=form_title>File da importare</td>
    <td valign=top><formwidget id="file_name">
        <formerror  id="file_name"><br>
        <span class="errori">@formerror.file_name;noquote@</span>
        </formerror>
    </td>
</tr>

<tr><td colspan=2>&nbsp;</td></tr>

<if @funzione@ ne "V">
    <tr><td colspan=2 align=center><formwidget id="submit"></td></tr>
</if>
<else>
    <tr><td colspan=2 align=center><span class="errori">@page_title;noquote@</span></td></tr>
</else>

<!-- Fine della form colorata -->

<%=[iter_form_fine]%>



</formtemplate>
</center>

