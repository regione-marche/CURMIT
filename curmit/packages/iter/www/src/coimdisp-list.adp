<master   src="../master">
<property name="title">@page_title;noquote@</property>
<property name="context_bar">@context_bar;noquote@</property>


<formtemplate id="@form_name;noquote@">

<formwidget   id="caller">
<formwidget   id="nome_funz">
<formwidget   id="nome_funz_caller">
<formwidget   id="url_enve">
<formwidget   id="prog_disp">
<formwidget   id="cod_enve">
<formwidget   id="mese">
<formwidget   id="anno">

<table width="25%" cellspacing=0 class=func-menu>
<tr>
    <td width="25%" nowrap class=func-menu>
        <a href=@link_return;noquote@ class=func-menu>Ritorna</a>
    </td>
</tr>
</table>

<center>
<table align=center width="100%" border=1 celpadding=0 cellspacing=0>
<tr>
    <td align=center width="5%"><formwidget id="submit1"></td>
    <td align=center width="20%">@mese_nome;noquote@</td>
    <td align=center width="5%"><formwidget id="submit2"></td>
    <td align=center width="5%"><formwidget id="submit3"></td>
    <td align=center width="10%">@anno;noquote@</td>
    <td align=center width="5%"><formwidget id="submit4"></td>
    <td align=center width="5%"><formwidget id="submit5"></td>
    <td align=center width="40%">@nome_opve;noquote@</td>
    <td align=center width="5%"><formwidget id="submit6"></td>

    </tr>
   </td>
</tr>

</table>
<table cellpadding=0 cellspacing=1> 
<tr>
    <td colspan=@colspan;noquote@ align=center>
       <formwidget id="submit">
    </td>
</tr>
<tr bgcolor=#f8f8f8 class=table-header>
   <th>Giorni</th> 
    @testata;noquote@
</tr>
<multiple name=multiple_righe>
    <tr>
        <th bgcolor= <%= $color(@multiple_righe.gg;noquote@) %> valign=top align=right>@multiple_righe.gg;noquote@</th>
        <multiple name=multiple_col>
            <td valign=top align=center>
                <formwidget id="@multiple_righe.gg;noquote@.@multiple_col.fascia;noquote@.0">
            </td>
        </multiple>
    </tr>
</multiple>
<tr><td colspan=@colspan;noquote@>&nbsp;</td></tr>
<tr>
    <td colspan=@colspan;noquote@ align=center>
       <formwidget id="submit">
    </td>
</tr>
</table>

</formtemplate>
<p>
</center>

