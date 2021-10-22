<master   src="../master">
<property name="title">@page_title;noquote@</property>
<property name="context_bar">@context_bar;noquote@</property>
<property name="riga_vuota">f</property>


<!-- tabella con le azioni di questo programma -->
@link_inco;noquote@
<!-- tabella con i dati dell'impianto -->
@dett_tab;noquote@


<!-- barra con il cerca, link di aggiungi e righe per pagina -->
@list_head;noquote@
<center>
@mex_error;noquote@
</center>
<formtemplate id="@form_name;noquote@">

<formwidget   id="caller">
<formwidget   id="extra_par">
<formwidget   id="nome_funz">
<formwidget   id="nome_funz_caller">
<formwidget   id="receiving_element">
<formwidget   id="cod_impianto">
<formwidget   id="cod_inco">
<formwidget   id="stato">
<formwidget   id="esito">
<formwidget   id="url_list_aimp">
<formwidget   id="url_aimp">
<formwidget   id="extra_par_inco">
<formwidget   id="f_comune">
<formwidget   id="f_cod_via">
<formwidget   id="flag_cerca">
<formwidget   id="dummy">


<center>

<table width=\"100%\" border=0>
    <tr><td valign=top align=right class=form_title>Cognome</td>
        <td valign=top><formwidget id="f_resp_cogn"></td>
        <td valign=top align=right class=form_title>Nome</td>
        <td valign=top><formwidget id="f_resp_nome"></td>
        <td valign=top align=right class=form_title>Indirizzo</td>
        <td valign=top nowrap>
            <formwidget id="f_desc_topo">
            <formwidget id="f_desc_via">@cerca_viae;noquote@
                <formerror  id="f_desc_via"><br>
                <span class="errori">@formerror.f_desc_via;noquote@</span>
                </formerror>
        </td>
        <td>
            <input type=submit name=bottone value="Cerca" class=ric_submit>
        </td>
    </tr>
</table>

<table>
<tr>
    <td colspan=7 align=center>
       <formwidget id="submit">
    </td>
</tr>
<tr bgcolor=#f8f8f8 class=table-header>
   <th>Azioni</th>
   <th>seleziona<br>da bonificare</th>
   <th>Cod. impianto</th>
   <th>Responsabile</th>
   <th>Comune</th>
   <th>Indirizzo</th>
   <th>Stato</th>
   <th>seleziona<br>destinazione</th>
</tr>


<!-- genero la tabella -->
<multiple name=impianti>
<tr>
    <td valign=top align=left>@impianti.link;noquote@</td>
    <td valign=top align=center>
       <formgroup id="compatta.@impianti.cod_impianto;noquote@">@formgroup.widget;noquote@</formgroup>
       <formerror  id="compatta.@impianti.cod_impianto;noquote@"><br>
       <span class="errori"><%= $formerror(compatta.@impianti.cod_impianto;noquote@) %></span>
       </formerror>
    </td>
    <td valign=top align=left>@impianti.cod_impianto_est;noquote@</td>
    <td valign=top align=left>@impianti.resp;noquote@</td>
    <td valign=top align=left>@impianti.comune;noquote@</td>
    <td valign=top align=left>@impianti.indir;noquote@</td>
    <td valign=top align=left>@impianti.stato;noquote@</td>
    <td valign=top align=center>@impianti.destinaz;noquote@</td>
</tr>    
</multiple>

<tr><td colspan=7>&nbsp;</td></tr>

<tr>
    <td colspan=7 align=center>
       <formwidget id="submit">
    </td>
</tr>
</formtemplate>

</center>


