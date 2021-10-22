<html>
<head>
<title>Incontri</title>
<link rel="stylesheet" href="@css_url;noquote@/header.css" type="text/css">
</head>

<body>

<table><tr><td>
<br></br>
<p><b>Attenzione:</b><br>
<ol>
    <b>Predisposizione controlli e registrazioni esisti</b>
       <li> Caricamento controlli da effettuare da file esterno </li>
            L'Ente può istituire controlli partendo da una sorgente esterna di dati essenzialmente anagrafici, per esempio provenienti da elenchi forniti da distributori di energia che operano sul territorio. 
            E'  possibile visualizzare lo stato di caricamento dei dati provenienti da file visualizzando, alla fine del processo, l’esito. Tale esito genera un nuovo file con valorizzati i dati scartati comprensivi della motivazione di scarto.
       <li>   Gestione campagna controllo </li>
           Prima di inserire o estrarre qualsiasi controllo è necessario inserire almeno una campagna [attiva]. Non possono essere inserite più campagne attive nello stesso momento. Le campagne sono da intendersi come “contenitori logici” in cui confluiscono tutti gli appuntamenti estratti nel periodo compreso tra [data inizio] e [data fine] campagna.
           Le campagne sono gestibili da parte dell’utente  e possono assumere i seguenti stati: 
           <br>•	Aperta: tutte le nuove estrazioni impianti, e di conseguenza tutta la gestione degli appuntamenti, fino alla compilazione del rapporto di verifica, rientrano nella campagna attiva. Non possono essere inseriti più incontri per lo stesso impianto nella stessa campagna.
           <br>•	Chiusa: quando una campagna è chiusa non si possono più visualizzare, nella sezione Predisposizione controlli e registrazione esiti, gli appuntamenti ad essa associati/effettuati. Traccia degli appuntamenti rimane, ovviamente, sul singolo impianto. 
           <br>•	Preventivata: al momento si comporta a tutti gli effetti come se fosse  nello stato [Chiusa], serve ad indicare quando partirà una successiva campagna rispetto a quella in stato di [Attiva].
         
            Qualora rimangano degli impianti estratti in una campagna [Chiusa], questi non vengono visualizzati, ma possono essere estratti in modo massivo nella nuova campagna [Aperta].

       <li>L’estrazione massiva non viene infatti effettuata per gli impianti:</li>
            <br>•	< 35 kW già verificati negli ultimi 2 anni (il calcolo viene fatto a partire dalla data del rapporto di verifica);
            <br>•	>35 kW già verificati nell'ultimo anno (il calcolo viene fatto a partire dalla data del rapporto di verifica)
            <br>E’ stata lasciata la possibilità di pianificare un appuntamento dal singolo impianto, anche se non sono trascorsi i tempi sopra indicati, questo per lasciare una certa flessibilità al programma.

            <br>N.B: L’eventuale sovrapposizione delle date di due o più campagne è ininfluente. E’ quindi possibile inserire campagne in cui alcuni periodi si sovrappongono. Gli impianti estratti vengono collegati alla campagna attiva riportando il codice della campagna e non la data di estrazione. 
     <li>Gestione pianificazione appuntamenti</li>
         Tutte le funzioni che andremo ora a descrivere fanno riferimento alla gestione degli appuntamenti.  
Prima di poter effettuare una verifica l’Ente ispettore dovrà:

    <br> 1.	Estrarre gli impianti da sottoporre ad ispezione
    <br> 2.	assegnare l’impianto/i da sottoporre ad ispezione ad un ispettore
    <br> 3.	stampare l’avviso/i di ispezione
    <br> 4.	confermare o annullare l’appuntamento

      <br>Infine si potrà procedere alla registrazione del rapporto di prova effettuato ed eventualmente inviare al responsabile dell’impianto una lettera di “Ispezione effettuata” sulla quale possono anche essere elencate le eventuali anomalie riscontrate dall’ispettore in fase di controllo.
       
       <li>Estrazione impianti per controlli (estrazione massiva)</li>
<br>Esiste la necessità di estrarre una serie di impianti per i quali si deve predisporre un’ispezione.
<br>Si apre una campagna di controllo e si esegue un’ estrazione degli impianti presenti nel catasto.
<br>La selezione deve avvenire in base ai seguenti parametri:
<br>	Impianti < 35 kW dichiarati
<br>	Possibilità di scegliere tra gli impianti che presentano osservazioni, raccomandazioni, prescrizioni 
<br>	Impianti  >= 35 kW dichiarati
<br>	Impianti non dichiarati
<br>	Impianti < 35 kW da accatastare
<br>	Numero di impianti da estrarre
<br>            Parametri aggiuntivi:
<br>	Da anno ad anno di installazione
<br>	Combustibile
<br>	Quartiere/comune in cui è collocato l’impianto 
<br>	Indirizzo
<br>	Area

<br>Se si desidera associare gli incontri ad un’altra campagna, si  cambia stato alla campagna in essere, ponendola in stato [preventivata].

<li>Assegnazione multipla appuntamenti</li>
<br>Attraverso questa funzione è possibile assegnare in modo massivo ad un ispettore gli appuntamenti estratti.
<br>L’ente può infatti scegliere che la gestione dei singoli appuntamenti sia fatta dal ispettore che ha il compito di fissarsi così i propri incontri in base alle proprie disponibilità di giorno e di ora.

<li>Stampa multipla avvisi di verifica</li>
Per stampare gli avvisi dopo l’assegnazione da parte dell’ente ispettore.
Gli incontri devono essere tutti in stato [assegnato].

<li>Estrazione singolo impianto per  controllo</li>
<br>Per estrarre solamente un impianto da ispezionare.
<br>L’estrazione del singolo impianto per l’accertamento può avvenire in diversi punti della procedura. Si ritiene comunque più semplice e veloce posizionarsi sull’impianto e pianificare un appuntamento.
         
 
<li>Gestione singolo appuntamento</li>
<br>Se occorre modificare qualche informazione relativa agli appuntamenti tra responsabili dell’impianto ed enti ispettori.
<br>E’ un modo per intervenire sugli appuntamenti per sistemare eventuali imprevisti o errori di pianificazione.
<br>1.	Assegnazione appuntamento
<br>Per definire data e ora dell’appuntamento tra ispettore e responsabile dell’impianto.
<br>2.	Stampa singolo avviso d’ispezione
<br>Per stampare un solo avviso (es. estrazione di un solo impianto su segnalazione).
<br>Dopo che abbiamo estratto l’impianto e lo abbiamo  assegnato ad un Ente ispettore.
<br>Importante è ricordare che, per effettuare la stampa dell’avviso d’ispezione, l’appuntamento deve essere in stato assegnato.
<br>3.	Effettuazione appuntamento
<br>L’ente ispettore ha eseguito l’accertamento sull’impianto.
<br>4.	Annullamento appuntamento
<br>Per eliminare dalla lista degli appuntamenti un incontro tra il ispettore e il responsabile dell’impianto, a causa dell’impossibilità  ad effettuare l’incontro da parte di una delle due parti.
<br>5.	Registrazione rapporto di ispezione
<br>Nella lista appare in modo chiaro l’esito dell’ispezione.
</b>
    <br>&nbsp;
   

  
<p>
<br>
<div align=center><input type=button onClick="javascript:window.close();" value ="Chiudi"></input></div>
</br>

</td></tr></table>
</body>
<html>

