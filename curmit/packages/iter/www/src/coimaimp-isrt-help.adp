<!--
    USER  DATA       MODIFICHE
    ===== ========== ============================================================================
    rom01 09/09/2021 In base al valore di link_caller che ricevo mostro o meno parte del contenuto.
-->

<html>
  <head>
    <title>Help Selezione Impianti</title>
    <link rel="stylesheet" href="@css_url;noquote@/header.css" type="text/css">
  </head>
  
  <body>

    <table>
      <tr>
	<td><br>
	  <if @link_caller@ eq "somma_potenze"><!--rom01 Aggiunta if ma non il contenuto-->
	    <p>
	      <ul>
		<li>Per gli impianti dotati di generatore di calore a fiamma le potenze nominali utili dei singoli generatori devono essere sommate  se sono inseriti nello stesso sottosistema di distribuzione e funzionano con lo stesso tipo di combustibile (gassoso, solido o liquido); nel caso l'unit&agrave; immobiliare non sia adibita a residenza con carattere continuativo, quali abitazioni civili e rurali (categoria E.1.1.a) o a residenza con occupazione saltuaria, quali case per vacanze, fine settimana e simili (categoria E.1.2), in presenza di generatori di aria calda, privi del sottosistema di distribuzione o con sottosistema di distribuzione separato, occorre comunque sommare le potenze nominali utili dei singoli generatori, sempreché singolarmente abbiano una potenza nominale utile superiore a 10 kW, siano alimentati dallo stesso tipo di combustibile (gassoso, solido o liquido) e servano lo stesso ambiente</li>
		<li>per gli impianti dotati di gruppi frigo o pompe di calore le potenze nominali utili dei singoli generatori devono essere sommate   se hanno singolarmente una potenza nominale superiore a 12 kW, sono inserite nello stesso sottosistema di distribuzione, sono azionate dallo stesso sistema (azionamento elettrico o assorbimento a fiamma diretta, motore endotermico, alimentate da energia termica) e producono lo stesso tipo di climatizzazione (caldo, caldo + freddo, freddo); nel caso l'unit&agrave; immobiliare non sia adibita a residenza con carattere continuativo, quali abitazioni civili e rurali (categoria E.1.1.a) o a residenza con occupazione saltuaria, quali case per vacanze, fine settimana e simili (categoria E.1.2), in presenza di pompe di calore/gruppi frigo, privi del sottosistema di distribuzione o con sottosistema di distribuzione separato, occorre comunque sommare le potenze utili nominali dei generatori presenti sempreché singolarmente siano superiori a 12 kW, siano azionate dallo stesso sistema (azionamento elettrico o assorbimento a fiamma diretta, motore endotermico, alimentate da energia termica), producano lo stesso tipo di climatizzazione (caldo, caldo+freddo, freddo) e servano lo stesso ambiente.</li>
	      </ul>
	    </p>
	  </if>
	  <if @link_caller@ eq "procedura_accatastamento"><!--rom01 Aggiunta elseif e il contenuto-->
	    <p align="justify">
	      <b>In tutti i casi di caminetti, stufe, ecc., <u>senza costruttore, modello e matricola</u><br>(es.: caminetto autocostruito), il censimento dovr&agrave; avvenire come segue:</b>
	      <ol>
		<li><b> Campo POD:</b> Trattandosi di impianto non collegato alla rete di distribuzione del gas, il campo POD &egrave; obbligatorio. Qualora l'edificio fosse sprovvisto da tempo di fornitura di elettricit&agrave; e non fosse possibile risalire all'ultimo POD, occorrer&agrave; immettere in tale campo la seguente dicitura di quattordici caratteri: "Caminetto_110%";</li>
	      
		<li><b> Campo Costruttore:</b> selezionare dal menù a tendina la voce "Caminetto o simili 110%";</li>

		<li><b> Campo Modello:</b> inserire la dicitura "Caminetto o simili 110%";</li>

		<li><b> Campo Matricola:</b> inserire la dicitura "Caminetto_Cognome_Nome", dove Cognome e Nome sono quelli del responsabile d'impianto, fino ad esaurimento dei 40 caratteri disponibili. Ad es., se la responsabile d'impianto si chiama Maria Giovanna Di Francescantonio, occorrer&agrave; scrivere "Caminetto_Difrancescantonio_Mariagiovann".</li>
		
	      </ol>
	    </p>
	  </if>
	</td>
      </tr>
    </table>

    <p>
      <div align=center><input type=button onClick="javascript:window.close();" value ="Chiudi"></input></div>
      <br>
    </p>
  
  </body>
<html>
  
