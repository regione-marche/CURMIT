<!--
    USER   DATA       MODIFICHE
    ====== ========== ====================================================================================
    rom02  19/01/2019 Aggiunta nota per il campo combustibile
    
    rom01  15/01/2019 Modificata nota in base al documento "TABELLA correz. Pompe di calore 10-01-2019"
    rom01             inviato dalla Regione Marche
  -->

<html>
  <head>
    <title>Help Inserimento Generatori</title>
    <link rel="stylesheet" href="@css_url;noquote@/header.css" type="text/css">
  </head>
  
  <body>
    
    <table><tr><td>
<br></br>
<p>
  <if @caller@ ne "combustibile"><!--rom02 aggiunta if-->
  <ul>
    <!--rom01
	<li>Pi&ugrave; generatori fanno parte dello stesso impianto se sono inseriti nello stesso sottosistema di distribuzione e funzionano con lo stesso tipo di combustibile (gassoso, solido o liquido); se l’unit&agrave; immobiliare <u>non</u> &egrave; adibita a residenza con carattere continuativo, ovvero non &egrave; abitazione civile o rurale (categoria E.1.1.a), o <u>non</u> &egrave; residenza con occupazione saltuaria (casa per vacanze, fine settimana e simili - categoria E.1.2), in presenza di generatori di aria calda, privi del sottosistema di distribuzione o con sottosistema di distribuzione separato, occorre comunque sommare le potenze nominali utili dei singoli generatori, semprech&egrave; singolarmente abbiano una potenza nominale utile superiore a 10 kW, siano alimentati dallo stesso tipo di combustibile (gassoso, solido o liquido) e servano lo stesso ambiente</li>-->
    <li>@dicitura_impianto;noquote@ fanno parte dello stesso impianto se hanno singolarmente una potenza nominale, in raffrescamento o in riscaldamento, di almeno 12 kW (se di potenza inferiore, costituiscono invece in ogni caso impianto a sé stante), sono inseriti nello stesso sottosistema di distribuzione, sono azionati dallo stesso sistema (azionamento elettrico o assorbimento a fiamma diretta, motore endotermico, alimentati da energia termica) e producono lo stesso tipo di climatizzazione (caldo, caldo+freddo, freddo. N.B.: per “caldo” si intende la climatizzazione invernale e/o la produzione di ACS);  se l’unità immobiliare non è adibita a residenza con carattere continuativo, ovvero non è abitazione civile o rurale (categoria E.1.1.a), o non è residenza con occupazione saltuaria (casa per vacanze, fine settimana e simili - categoria E.1.2), in presenza di pompe di calore/gruppi frigo privi del sottosistema di distribuzione o con sottosistema di distribuzione separato, occorre comunque considerare tali generatori  come facenti parte di uno stesso impianto sempreché singolarmente abbiano una potenza nominale, in raffrescamento o in riscaldamento, di almeno 12 kW (se di potenza inferiore, costituiscono invece in ogni caso impianto a sé stante), siano azionati dallo stesso sistema (azionamento elettrico o assorbimento a fiamma diretta, motore endotermico, alimentati da energia termica), producano lo stesso tipo di climatizzazione (caldo, caldo+freddo, freddo) e servano lo stesso ambiente.</li><!--rom01-->
  </ul>
  </if>
  <if @caller@ eq "combustibile"><!--rom02 aggiunta if e contenuto-->
    <ul>
      <li>Per le miscele di combustibili a gas di petrolio liquefatti (non presenti in elenco), selezionare la voce "GPL"</li>
    </ul>
  </if>
	</td>
      </tr>
    </table>
    
    <p>
      <br>
      <div align=center><input type=button onClick="javascript:window.close();" value ="Chiudi"></input></div>
</br>

</td></tr></table>
</body>
<html>
  
