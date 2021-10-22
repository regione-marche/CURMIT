<html>
<head>
<title>Note Manutentore</title>
<link rel="stylesheet" href="@css_url;noquote@/header.css" type="text/css">
</head>

<body>
<formtemplate id="@form_name;noquote@">
<center>
<table width="100%">
<tr>
    <td valign=top colspan=2 align=center class=form_tutle><b>Note Manutentore</b></td>
</tr>
<tr><td colspan=2>&nbsp;</td></tr>
<tr>
    <td valign=top align=right class=form_title>Data controllo</td>
    <td valign=top><formwidget id="data_controllo"></td>
</tr>


<tr>
    <td valign=top align=right class=form_title>Manutentore</td>
    <td valign=top><formwidget id="cognome_manu">
        <formwidget id="nome_manu"></td>
</tr>
@esito;noquote@
<tr>
    <td colspan=2><table width=100%>
        <tr>
           <td valign=bottom align=left class=form_title>Osservazioni</td>
           <td valign=bottom align=left class=form_title>Raccomandazioni</td>
           <td valign=top align=left class=form_title>Prescrizioni<br> (L'impianto pu&ograve; funzionare solo dopo l'esecuzione di quanto prescritto)</td>
        </tr>
        <tr>
            <td valign=top><formwidget id="osservazioni"></td>
            <td valign=top><formwidget id="raccomandazioni"></td>
            <td valign=top><formwidget id="prescrizioni"></td>  
       </tr> 
   </table></td>
</tr>
<tr>
    <td valign=top align=left class=form_title>Data utile interv.</td>
    <td valign=top class=form_title>Anomalia</td>
</tr> 
<multiple name=multiple_form>
<tr>
    <td valign=top align=right>
        <formwidget id="data_ut_int.@multiple_form.conta;noquote@">
    </td>
    <td valign=top>
        <formwidget id="desc.@multiple_form.conta;noquote@">
    </td>
</tr>
</multiple>

<tr>
    <td align=center colspan=2><input type=button onClick="javascript:window.close();" value ="Chiudi"></input></td>
</tr>
</table>
</formtemplate>
</center>
</body>
</html>

