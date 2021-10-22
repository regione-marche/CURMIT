<master   src="../master">
<property name="title">@page_title;noquote@</property>
<property name="context_bar">@context_bar;noquote@</property>
<property name="riga_vuota">f</property>

<table width="100%" cellspacing=0 class=func-menu>
<tr>
   <td width="25%" nowrap class=func-menu>
       <a href="coimrift-list?@link_list;noquote@" class=func-menu>Ritorna</a>
   </td>
   <td width="75%" class=func-menu>&nbsp;</td>
   
</tr>
</table>

<center>
<formtemplate id="@form_name;noquote@">
<formwidget   id="funzione">
<formwidget   id="caller">
<formwidget   id="nome_funz">
<formwidget   id="nome_funz_caller">
<formwidget   id="extra_par">
<formwidget   id="last_cod_impianto">
<formwidget   id="cod_impianto">
<formwidget   id="ruolo">
<formwidget   id="cod_soggetto">
<formwidget   id="url_list_aimp">
<formwidget   id="url_aimp">
<!-- Inizio della form colorata -->
<%=[iter_form_iniz]%>

<tr>
    <td valign=top align=right class=form_title>Ruolo</td>
    <td valign=top><formwidget id="ruolo_desc"></td>
    <td valign=top align=right class=form_title>Data fine validit&agrave;</td>
    <td valign=top><formwidget id="data_fin_valid"></td>
</tr>

<tr>
    <td valign=top align=right class=form_title>Cognome</td>
    <td valign=top><formwidget id="cognome"></td>
    <td valign=top align=right class=form_title>Nome</td>
    <td valign=top><formwidget id="nome"></td>
</tr>

<tr><td colspan=2>&nbsp;</td></tr>

<if @funzione@ ne "V">
    <tr><td colspan=4 align=center><formwidget id="submit"></td></tr>
</if>

<!-- Fine della form colorata -->
<%=[iter_form_fine]%>

</formtemplate>
<p>
</center>

