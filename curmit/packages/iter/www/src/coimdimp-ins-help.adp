<html>
<head>
<title>Help Ricerca Impianti</title>
<link rel="stylesheet" href="@css_url;noquote@/header.css" type="text/css">
</head>

<body>

<table><tr><td>
<br></br>
<p><b>La ricerca deve essere effettuata per almeno uno dei seguenti criteri:</b><br>
<ol>

      <li><b>Targa</b>
    <br>In questo caso a titolo di esempio viene visualizzata una sempice modalità di targatura
    <br>di un impianto.
    <br>&nbsp;
    </li>


    <li><b>Responsabile</b>
    <br>In questo caso la ricerca avviene per cognome del responsabile.
    <br>In aggiunta &egrave; possibile indicare anche anche il nome.
    <br>E' possibile utilizzare il carattere jolly '*'.
    <br>Con questo criterio l'elenco viene ordinato per responsabile.
    <br>&nbsp;
    </li>

    <li><b>Indirizzo</b>
    <if @flag_ente@ eq "P">
        <br>Con questo criterio di ricerca &egrave; obbligatorio indicare il comune.
        <br>E' inoltre possibile indicare la via.
    </if>
    <else>
        <br>Con questo criterio di ricerca &egrave; possibile indicare la via.
    </else>
    <if @flag_viario@ eq "T">
        <br>Utilizzando il tasto cerca &egrave; possibile accedere al viario e selezionare una via.
    </if>
    <br>In questo caso l'elenco viene ordinato per indirizzo.
    <br>Se pero' &egrave; stato indicato anche il cognome, allora l'elenco viene ordinato per responsabile.
    <br>&nbsp;
    </li>
</ol>

<p>
<br>
<div align=center><input type=button onClick="javascript:window.close();" value ="Chiudi"></input></div>
</br>

</td></tr></table>
</body>
<html>

