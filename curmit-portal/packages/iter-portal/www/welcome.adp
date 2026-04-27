<master>
<property name="title">@page_title@</property>
<property name="context">@context;noquote@</property>

<br><br>
<big><big>
Torna ai <href="
  <switch @party_type@>
    <case value="maintainer">
      services
    </case>
    <case value="trustee">
      jbuild/servtrust
    </case>
    <case value="cait">
      cait/services
    </case>
    <case value="office">
      offices/trustees-services
    </case>
  </switch>
">Servizi</a>
</big></big>
<br><br>

<big>
Buongiorno @name@,<br>come utente dei servizi CURIT hai a disposizione un portafoglio per effettuare online tutte le attività relative al Catasto compreso il pagamento del Contributo Regionale.<br>Il tuo portafoglio ha il seguente codice identificativo: <b>@wallet_id@</b><br><br>
<if @retcode@ eq "OK">
Il credito disponibile attuale è pari a @wallet_credit_pretty@. Ti ricordiamo che il credito del Portafoglio è solo consumabile e l'eventuale credito residuo non è rimborsabile.<br><br>Ti consigliamo di stampare il tuo codice perchè questo può aiutarti in tutte le procedure di ricarica: <a href="#" onClick="javascript:window.open('print-wallet-code?maintainer_id=@maintainer_id@&trustee_id=@trustee_id@')">Stampa il Codice</a><br><br>Di seguito trovi gli strumenti disponibili per ricaricare il tuo portafoglio manutentore CURIT.
</if>
<else>
<b>Spiacente, ma non è possibile determinare il tuo credito. Questa è la risposta del server: @retcode@</b>
</else>
<br><br>
<b>Bonifico Bancario</b><br><br>
Per ricaricare il tuo portafoglio puoi effetture dei versamenti sul conto corrente CURIT attraverso la tua banca o il tuo servizio di home banking. Informati sul costo di tali operazioni presso il tuo istituto bancario.<br>Per utilizzare questa modalità di ricarica è necessario registrarsi utilizzando la seguente procedura: <a href="wcodes-add-edit?maintainer_id=@maintainer_id@&trustee_id=@trustee_id@">Registrazione</a>.<br>
Se hai la necessità di effettuare il bonifico attraverso un conto corrente diverso ricordati di utilizzare nuovamente questa procedura. Potrai utilizzarla tutte le volte che vuoi. Prima di cambiare il tuo codice IBAN registrato, ti consigliamo di accertarti che tutti i precedenti bonifici siano stati regolarmente caricati sul tuo Portafoglio.<br><br>
<b>Ricevitorie Lottomatica</b><br><br>
A partire dal 18 Agosto, puoi ricaricare il tuo portafoglio presso una qualunque ricevitoria Lottomatica sul territorio nazionale comunicando all'operatore il tuo Codice Portafoglio e l'importo che intendi ricaricare. Ti sarà possibile effettuare ricariche del tuo portafoglio con operazioni dell'importo da te stabilito (importo massimo 2.500 Euro). Per ogni operazione, indipendentemente dal suo importo, Lottomatica ti addebiterà un costo commissione di un (1,55) Euro.<br><br>
Per effettuare la tua ricarica ricordati di portare con te il tuo Codice Portafoglio manutentore, puoi direttamente mostrarlo all'operatore per evitare errori di trascrizione ( <a href="#" onClick="javascript:window.open('print-wallet-code?maintainer_id=@maintainer_id@&trustee_id=@trustee_id@')">Stampa il Codice</a> ).<br><br>
Ricerca i punti vendita Lottomatica andando al seguente indirizzo : <a href ="http://www.lottomatica.it/home/dovegiocare.html" target="lotto">www.lottomatica.it/home/dovegiocare</a>.
</big>




