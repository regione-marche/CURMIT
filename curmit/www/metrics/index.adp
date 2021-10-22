<master>

<h1>Confronto codice istanze I.ter</h1>

Da questa pagina puoi avviare il confronto fra due istanze I.ter presenti sul server.
<p>
I dati necessari al confronto vengono salvati in una tabella d'appoggio che fotografa la situazione del codice nel momento in cui la tabella viene creata. Pertanto, prima di procedere all'analisi, si raccomanda di <a href="metrics-load">ricaricare la tabella</a> (l'operazione dura pochi minuti).
<p>
Le istanze presenti sul server sono: <b>iter-portal-demo ucit iterprud iterprgo iterprpn</b>
<p>
Per avviare il confronto copia la url seguente e sostituisci il nome delle istanze che vuoi confrontare: http://demo.iter-web.it/metrics/metrics?origin1=<i>istanza1</i>&origin2=<i>istanza2</i>
<p>
Il programma di analisi propone inizialmente una tabella riepilogativa in cui vengono conteggiati i file delle due istanze divisi per tipologia (tcl, adp,xql e sql). Cliccando uno dei numeri della prima istanza vengono evidenziati in una nuova tabella i file presenti <b>solo</b> sulla prima istanza e <b>non</b> sulla seconda. Esattamente il contrario avviene cliccando su uno dei numeri della seconda istanza.
<p>
In testa alla pagina appare la lista gerarchica delle cartelle che permette, cliccandone una, di restringere il confronto alla cartella selezionata. Contemporaneamente appaiono nuove colonne che permettono di svolgere ulteriori analisi.
<ul>
<li>La prima evidenzia il numero di file con nome identico nelle due istanze.</li>
<li>La seconda evidenzia il numero di file con nome identico e size identico.</li>
<li>La terza evidenzia il numero di file con nome identico e size diversa.</li>
</ul>
Cliccando su una delle ultime due (quella più significativa è evidentemente l'ultima) appare la lista degli specifici file. Infine, cliccando su uno specifico file, si ottiene a video la differenza fra i due file nel tipico formato <i>diff</i>.
