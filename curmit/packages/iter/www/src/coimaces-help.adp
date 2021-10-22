<html>
<head>
<title>Help Filtro</title>
<link rel="stylesheet" href="@css_url;noquote@/header.css" type="text/css">
</head>


<body>

<table><tr><td>
<br></br>
<p><b>La ricerca pu&ograve; essere effettuata digitando uno o pi&ugrave; dei seguenti criteri:</b>

<OL>
<li><b>Codice dichiarazione</b><br>&nbsp;</li>
<li><b>Codice utenza</b></li>
    <br>Con questo criterio &egrave; obbligatorio indicare il Codice dichiarazione.
    <br><br>
<if @flag_ente@ eq "P">
   <li><b>Comune</b></li>
   <br> Con questo criterio di ricerca &egrave; obbligatorio indicare il comune.
   <br>E' inoltre possibile indicare la via.<br><br>
</if>
<li><b>Via</b>
    <if @flag_viario@ eq "T">
        <br>Utilizzando il tasto cerca &egrave; possibile accedere al viario e selezionare una via.<br><br>
    </if>
<li><b>Cognome Intestatario</b>
   <br>Con questo criterio si pu&ograve; utilizzare il carattere jolly *.<br>&nbsp;</li>
<li><b>Natura giuridica</b><br>&nbsp;</li>
<li><b>Combustibile</b><br>&nbsp;</li>
<li><b>Stato del nominativo acquisito</b><br>&nbsp;</li>
</OL>

<p>
<br>
<div align=center><input type=button onClick="javascript:window.close();" value ="Chiudi"></input></div>
</br>

</td>
</tr>
</table>
</body>
<html>

