<!--
    USER   DATA       MODIFICHE
    ====== ========== ============================================================================
    rom01  28/06/2018 Aggiunte frasi all'inizio della schermata su richiesta della regione Marche.

    sim01  10/09/2014 Aggiunto nuovo campo cod_impianto_princ
-->

<html>
<head>
<title>Help Selezione Impianti</title>
<link rel="stylesheet" href="@css_url;noquote@/header.css" type="text/css">
</head>

<body>

<table><tr><td><!--rom01 aggiunta table e contenuto -->
<br></br>
<p>
<ul>
<li>Per gli impianti dotati di generatore di calore a fiamma le potenze nominali utili dei singoli generatori devono essere sommate  se sono inseriti nello stesso sottosistema di distribuzione e funzionano con lo stesso tipo di combustibile (gassoso, solido o liquido); nel caso l’unità immobiliare non sia adibita a residenza con carattere continuativo, quali abitazioni civili e rurali (categoria E.1.1.a) o a residenza con occupazione saltuaria, quali case per vacanze, fine settimana e simili (categoria E.1.2), in presenza di generatori di aria calda, privi del sottosistema di distribuzione o con sottosistema di distribuzione separato, occorre comunque sommare le potenze nominali utili dei singoli generatori, sempreché singolarmente abbiano una potenza nominale utile superiore a 10 kW, siano alimentati dallo stesso tipo di combustibile (gassoso, solido o liquido) e servano lo stesso ambiente
</li>
<li>per gli impianti dotati di gruppi frigo o pompe di calore le potenze nominali utili dei singoli generatori devono essere sommate   se hanno singolarmente una potenza nominale superiore a 12 kW, sono inserite nello stesso sottosistema di distribuzione, sono azionate dallo stesso sistema (azionamento elettrico o assorbimento a fiamma diretta, motore endotermico, alimentate da energia termica) e producono lo stesso tipo di climatizzazione (caldo, caldo + freddo, freddo); nel caso l’unità immobiliare non sia adibita a residenza con carattere continuativo, quali abitazioni civili e rurali (categoria E.1.1.a) o a residenza con occupazione saltuaria, quali case per vacanze, fine settimana e simili (categoria E.1.2), in presenza di pompe di calore/gruppi frigo, privi del sottosistema di distribuzione o con sottosistema di distribuzione separato, occorre comunque sommare le potenze utili nominali dei generatori presenti sempreché singolarmente siano superiori a 12 kW, siano azionate dallo stesso sistema (azionamento elettrico o assorbimento a fiamma diretta, motore endotermico, alimentate da energia termica), producano lo stesso tipo di climatizzazione (caldo, caldo+freddo, freddo) e servano lo stesso ambiente.
</li>
</ul>
</td>
</tr>
</table><!--rom01-->
<table><tr><td>
<br></br>
<p><b>La ricerca deve essere effettuata per almeno uno dei seguenti criteri:</b><br>
<ol>
    <li><b>Codice Impianto</b>
    <br>Con questo criterio non &egrave; possibile indicare nessun altro criterio di selezione.
    <br>&nbsp;
    </li>
     
    <li><b>PDR</b>
    <br>E' possibile ricercare tramite il PDR se correttamente inserito
    <br>&nbsp;
    </li>

  
    <li><b>Codice Impianto principale</b><!-- sim01 -->
    <br>E' stata aggiunta la possibilità di unire più impianti diversi per tipologia ma che sottendono allo stesso impianto (es. Metano + Biomasse legnose ...).<!-- sim01 -->
    <br>&nbsp;<!-- sim01 -->
    </li><!-- sim01 -->

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
        <br>Con questo criterio di ricerca &egrave; possibile indicare il quartiere e/o la via.
    </else>
    <if @flag_viario@ eq "T">
        <br>Utilizzando il tasto cerca &egrave; possibile accedere al viario e selezionare una via.
    </if>
    <br>In questo caso l'elenco viene ordinato per indirizzo.
    <br>Se pero' &egrave; stato indicato anche il cognome, allora l'elenco viene ordinato per responsabile.
    <br>&nbsp;
    </li>

    <li><b>Manutentore</b>
    <br>In questo caso la ricerca avviene per cognome e nome del manutentore.
    <br>Utilizzando il tasto cerca &egrave; possibile selezionare un manutentore.
    <br>Se &egrave; presente solo questo criterio l'elenco viene ordinato per responsabile.
    <br>&nbsp;
    </li>

    <li><b>Impianti inseriti o modificati...</b>
    <br>Con questo criterio di ricerca &egrave; possibile cercare tutti gli impianti
    <br>che sono stati inseriti o modificati nel periodo o dall'utente indicato.
    <br>Se &egrave; presente solo questo criterio l'elenco viene ordinato per responsabile.
    </li>

    <li><b>Ricerca per Bollino e Matricola del primo generatore...</b>
    <br>Con questo criterio di ricerca &egrave; possibile cercare tutti gli impianti
    <br>che hanno dei rapporti con il bollino indicato, oppure con la matricola scritta nell'apposito campo
    <br>E' possibile ricercare utilizzando il carattere jolly (*)
    </li>

</ol>

<p><b>Infine possono essere indicati questi criteri aggiuntivi: (esempio)</b><br>
<ol>
    <li><b>Potenza</b>
    <br>Pu&ograve; essere indicato l'intervallo di valori di potenza entro cui selezionare gli impianti.
    <br>Pu&ograve; essere valorizzato anche solo il valore minimo o massimo.
    <br>&nbsp;
    </li>

    <li><b>Data installazione</b>
    <br>Pu&ograve; essere indicato l'intervallo di date di installazione entro cui selezionare gli impianti.
    <br>Pu&ograve; essere valorizzato anche solo la data minima o massima.
    <br>&nbsp;
    </li>

    <li><b>Stato dichiarazione</b>
    <br>&nbsp;
    </li>

    <li><b>Stato conformit&agrave;</b>
    <br>&nbsp;
    </li>

    <li><b>Combustibile</b>
    <br>&nbsp;
    </li>

    <li><b>Tipologia</b>
    <br>&nbsp;
    </li>

    <li><b>Destinazione d'uso dell'edificio</b>
    <br>&nbsp;
    </li>

    <li><b>Stato dell'impianto</b>
      <br>&nbsp;
    </li>

    <li><b>Le date devono essere scritte nel formato gg/mm/aaaa oppure nel formato ggmmaaaa</b>
          </li>
</ol>

<p>
<br>
<div align=center><input type=button onClick="javascript:window.close();" value ="Chiudi"></input></div>
</br>

</td></tr></table>
</body>
<html>

