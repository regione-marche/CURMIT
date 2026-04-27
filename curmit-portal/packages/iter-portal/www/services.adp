<!DOCTYPE html>
<!--
USER  DATA       MODIFICHE
===== ========== =======================================================================
rom06 01/04/2026 Fatto in modo che la stampa dei dati Anagrafici venga aperta in una nuova scheda.
rom06            Aggiornato a mano anche /xowiki/www/portlets/servizi-manutentori.adp

ric02 27/11/2025 Modificate scritte come richiesto nella call del 25/11/2025.

ric01 19/09/2025 Aggiunto solo per le marche e se ditta di manutenzione link per la gestione delle deleghe (punto 40 MEV 2025).

rom07 24/11/2023 Con Sandro si e' deciso di rendere disponibili per tutti gli enti, esclusa Regione Marche,
rom07            i link per i tracciati di caricamento massivo degli rcee.
rom07            Aggiornato a mano anche il programma /xowiki/www/portlets/servizi-manutentori.adp

rom06 19/10/2023 Anche Napoli deve vedere i link per i tracciati di caricamento massivo degli rcee.
rom06            Il link per il tracciato xml e' stato rinominato per non avere il nome di Palermo.
rom06            Aggiornato a mano anche il programma /xowiki/www/portlets/servizi-manutentori.adp

rom05 16/05/2023 Benevento non vede i link del CAIT ma vede i link messi da rom04.
rom05            Modifica grafica ai tag li.
rom05            Ricordarsi di aggiornare a mano anche i programmi /xowiki/www/portlets/servizi-manutentori

rom04 14/11/2022 Per Palermo aggiunto link per i tracciati di caricamento massivo degli rcee.

rom03 10/06/2020 faccio vedere il link per la videoguida solo per le Marche.

rom02 31/07/2018 su richiesta della Regione Marche sostituita label per il link a iter-link.

rom01 27/06/2018 Sostituito label del link Operatori in Tecnici.

gab01 10/04/2018 In caso di gestione del multiportafoglio il link per consultare i 
gab01            Movimenti di Portafoglio punta a un pre-filtro per scegliere l'ente
gab01            portafoglio prima di arrivare alla lista. 
 
sim01 05/09/2016 Aggiunto la gestione delle targhe in base al parametro targhe_flag_gest
-->
<master>
  <property name="title">@page_title;noquote@</property>
  <property name="context">@context;noquote@</property>
<big><big>
<h1>@page_title@</h1>
<!--<big><big><big><b>@reg_msg@</b></big></big></big>-->
<p>Da questa pagina puoi accedere ai servizi riservati ai manutentori registrati:
</p> 
<ul> 
   <li style="margin-bottom: 12px">Modifica la <a href="/user/password-update">tua password</a></li>
   <if @validated_p@ eq "t" >
<!--rom02     <li style="margin-bottom: 12px">Accedi a <a href="/iter-portal/iter-link">CURMIT</a> per l'inserimento dei modelli RCEE</li> -->
     <li style="margin-bottom: 12px">Accedi al men&ugrave; <a href="/iter-portal/iter-link">Gestione Impianti (creazione/aggiornamento) del libretto d'impianto, trasmissione RCEE e altra modulistica)</a></li> <!--rom02 su richiesta della Regione Marche sostituita label -->
     <if @nome_db@ ne "iter-portal-asiabenevento"><!--rom05 Aggiunta if ma non il suo contenuto -->
     <if @cait_id@ eq "">
     <li style="margin-bottom: 12px">Aderisci ad un <a href="/iter-portal/cait-list">CAIT</a>.</li>
    </if>
    <else>
      <li style="margin-bottom: 12px">Abbandona <a href="/iter-portal/cait/unlink?maintainer_id=@maintainer_id@&caller=services">CAIT</a>.</li>
    </else>
    </if><!--rom05-->
     <if @sw_wallet_usato_dal_portale@ eq "1"><!-- Nicola 10/06/2016 -->
       <!--Non serve per la regione
       <li style="margin-bottom: 12px">Ricarica <a href="/iter-portal/welcome?maintainer_id=@maintainer_id@">Portafoglio Manutentore</a>.</li>-->
       <if @sw_multi_portafoglio@ eq "1"><!-- gab01 aggiunta if e contenuto-->
	 <li style="margin-bottom: 12px">Consulta i tuoi <a href="/iter-portal/ec-filter?maintainer_id=@maintainer_id@">Movimenti di Portafoglio</a>.</li> 
       </if>
       <else><!-- gab01 aggiunta else-->
	 <li style="margin-bottom: 12px">Consulta i tuoi <a href="/iter-portal/ec?maintainer_id=@maintainer_id@">Movimenti di Portafoglio</a>.</li>
       </else>
     </if>
   </if>
   <if @to_modify_p@ eq "f" >
     <li style="margin-bottom: 12px">Visualizza i <a href="/iter-portal/user-view">Dati della Registrazione</a></li>
   </if>

   <if @sw_wallet_usato_dal_portale@ ne "1"><!-- Nicola 10/06/2016 -->
     <li style="margin-bottom: 12px">Visualizza la <a href="/iter-portal/bollini/ordboll-list?is_admin_p=f">Lista Ordini Bollini</a></li>
     <li style="margin-bottom: 12px">Crea <a href="/iter-portal/bollini/ordboll-add-edit">Ordine Bollini</a></li>
   </if>

   <if @targhe_flag_gest@ eq "1"><!--sim01-->
     <li style="margin-bottom: 12px">Crea <a href="/iter-portal/targhe/ordtarg-add-edit">Ordine Targhe</a></li>
   </if>

   <if @to_modify_p@ ne "f" >
     <li style="margin-bottom: 12px">Visualizza i <a href="/iter-portal/user-view">Dati Anagrafici</a></li>
     <li style="margin-bottom: 12px"><a href="/iter-portal/bollini/maintainer-print" target="maintainer-print">Stampa dati Anagrafici</a></li>

     <if @nome_db@ eq "iter-portal-marche" or @nome_db@ eq "iter-portal-marche-test"><!-- ric01 aggiunta if e contenuto-->
       <li style="margin-bottom: 12px">Gestisci le deleghe:
	 <ul>
	   <if @role@ eq "1">
	     <li style="margin-bottom: 12px">Inserisci/Modifica le <a href="maintainer-delegations-list">deleghe ricevute delle ditte di installazione</a></li><!--ric02-->
	   </if>
	   <if @role@ eq "0">
	     <li style="margin-bottom: 12px">Visualizza le <a href="delegations-list">deleghe inserite dalle ditte delegate alla prima accensione (CAT)</a></li><!--ric02-->
	   </if>
	   <if @role@ eq "2">
	     <li style="margin-bottom: 12px">Inserisci/Modifica le <a href="maintainer-delegations-list">deleghe ricevute delle ditte di installazione</a></li><!--ric02-->
	     <li style="margin-bottom: 12px">Visualizza le <a href="delegations-list">deleghe inserite dalle ditte delegate alla prima accensione (CAT)</a></li><!--ric02-->
	   </if>
	 </ul>
       </li>
     </if>
     
     <li style="margin-bottom: 12px">Gestisci i <a href="/iter-portal/operators-list">Tecnici</a><!--rom01 Sostituito Operatori-->
     <li style="margin-bottom: 12px">Gestisci i <a href="/iter-portal/tools-list?type=1">Deprimometri</a><br></li>
     <li style="margin-bottom: 12px">Gestisci gli <a href="/iter-portal/tools-list?type=0">Analizzatori di Combustione</a><br></li>
     <li style="margin-bottom: 12px">Gestire le <a href="/iter-portal/maintainer-installations-list">Tipologie degli impianti su cui l'impresa opera</a><br></li>
   <!-- rom05 Aggiunta condizione su benevento -->
   <!-- rom06 Aggiunta condizione su napoli    -->
   <!-- rom07 Modificata if mettendo la condizione @nome_db@ ne "iter-portal-marche"
        rom07 invece delle condizioni  @nome_db@ eq "iter-portal-palermo" or @nome_db@ eq "iter-portal-asiabenevento" or @nome_db@ eq "iter-portal-napoli" -->
   <if @nome_db@ ne "iter-portal-marche" and @nome_db@ ne "iter-portal-marche-test"><!--rom04 aggiunta if e il suo contenuto -->
       <li style="margin-bottom: 12px">Scarica i tracciati di caricamento massivo degli RCEE
         <ul>
	   <li style="margin-bottom: 12px"><a href="/iter-portal/Tracciato_caricamento_standard_rcee1v2.pdf">Tracciato caricamento standard rcee1</a></li>
    <!-- rom06 <li style="margin-bottom: 12px"><a href="/iter-portal/tracciato_xml_rcee1_palermo.xml">Tracciato caricamento rcee1 con xml</a></li> -->
   	       <li style="margin-bottom: 12px"><a href="/iter-portal/tracciato_xml_rcee1_standard.xml">Tracciato caricamento rcee1 con xml</a></li><!-- rom06 -->
	 </ul>
       </li>
   </if>
     <if @to_approve_p@ eq "t" >
       <br><big><b>
	   <li style="margin-bottom: 12px"><a href="/iter-portal/approve">Conferma</a> definitivamente i dati forniti<br></li>
       </b></big><br>
     </if>
   </if>
   <if @nome_db@ eq "iter-portal-marche" or @nome_db@ eq "iter-portal-marche-test"><!--rom03 aggiunta if ma non contenuto-->
       <li style="margin-bottom: 12px"><a href="/videoguida">Visualizza videoguide</a></li>
   </if>
</ul>
  <p>
    <if @validated_p@ true >
<!--      <big><b>
	  Se hai ricevuto una lettera da UCIT che ti invita a verificare i tuoi impianti, puoi 
	  <a href="/iter-portal/adjust/adjust">attivare la relativa procedura</a>.<br>
	  ( Per farlo avrai bisogno del codice e della password contenuti nella
	  lettera ).<br>
	  LA PROCEDURA PUO' ESSERE ESEGUITA UNA SOLA VOLTA. SI PREGA QUINDI DI PORRE
	  ATENZIONE NELLA SELEZIONE DEGLI IMPIANTI DA BONIFICARE.</b></big> 
-->
    </if>
</big></big>
    
