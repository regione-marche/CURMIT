<!--
USER  DATA       MODIFICHE
===== ========== =======================================================================
rom03 01/04/2026 Fatto in modo che la stampa dei dati Anagrafici venga aperta in una nuova scheda.

rom02 30/07/2018 su richiesta della Regione Marche sostituita label per il link a iter-link.

rom01 25/06/2018 Fatto vedere alla region Marche il link "Aderisci ad un CAIT"

gab01 11/04/2018 In caso di gestione del multiportafoglio il link per consultare i
gab01            Movimenti di Portafoglio punta a un pre-filtro per scegliere l'ente
gab01            portafoglio prima di arrivare alla lista.
-->
<!--<big><big><big><b>@reg_msg@</b></big></big></big>-->
<p>Da questa pagina puoi accedere ai servizi riservati ai Manutentori/Installatori registrati:
</p> 
<ul> 
   <li>Modifica la <a href="/user/password-update">tua password</a></li>
   <if @validated_p@ eq "t" >
<!--rom02     <li>Accedi a <a href="/iter-portal/iter-link">CURMIT</a> per l'inserimento dei modelli RCEE</li> -->
     <li>Accedi al men&ugrave; <a href="/iter-portal/iter-link">Gestione Impianti</a> (creazione/aggiornamento del libretto d'impianto, trasmissione RCEE e altra modulistica)</li> <!--rom02 su richiesta della Regione Marche sostituita label -->
     <if @nome_db@ eq "iter-portal-dev" or "iter-portal-marche"> <!-- rom01 aggiunto "iter-portal-marche" -->
     <li>Aderisci ad un <a href="/iter-portal/cait-list">CAIT</a>.</li>
     </if>
     <if @sw_wallet_usato_dal_portale@ eq "1"><!-- Nicola 10/06/2016 -->
        <!--Non serve per la regione
       <li>Ricarica <a href="/iter-portal/welcome?maintainer_id=@maintainer_id@">Portafoglio Manutentore</a>.</li>-->
       <if @sw_multi_portafoglio@ eq "1"><!-- gab01 aggiunta if e contenuto-->
	 <li>Consulta i tuoi <a href="/iter-portal/ec-filter?maintainer_id=@maintainer_id@">Movimenti di Portafoglio</a>.</li>
       </if>
       <else><!-- gab01 aggiunta else-->
	 <li>Consulta i tuoi <a href="/iter-portal/ec?maintainer_id=@maintainer_id@">Movimenti di Portafoglio</a>.</li>
       </else>
     </if>
   </if>
   <if @to_modify_p@ eq "f" >
     <li>Visualizza i <a href="/iter-portal/user-view">Dati della Registrazione</a></li>
   </if>

   <if @sw_wallet_usato_dal_portale@ ne "1"><!-- Nicola 10/06/2016 -->
     <li>Visualizza la <a href="/iter-portal/bollini/ordboll-list?is_admin_p=f">Lista Ordini Bollini</a></li>
     <li>Crea <a href="/iter-portal/bollini/ordboll-add-edit">Ordine Bollini</a></li>
   </if>

   <if @targhe_flag_gest@ eq "1"><!--sim01-->
     <li>Visualizza la <a href="/iter-portal/targhe/ordtarg-list?is_admin_p=f">Lista Ordini Targhe</a></li>
     <li>Crea <a href="/iter-portal/targhe/ordtarg-add-edit">Ordine Targhe</a></li>
   </if>

   <if @to_modify_p@ ne "f" >
     <li>Visualizza i <a href="/iter-portal/user-view">Dati Anagrafici</a></li>
     <li><a href="/iter-portal/bollini/maintainer-print" target="maintainer-print">Stampa dati Anagrafici</a></li>
     <li>Gestisci gli <a href="/iter-portal/operators-list">Operatori</a>
     <li>Gestisci i <a href="/iter-portal/tools-list?type=1">Deprimometri</a><br></li>
     <li>Gestisci gli <a href="/iter-portal/tools-list?type=0">Analizzatori di Combustione</a><br></li>
     <li>Gestire le <a href="/iter-portal/maintainer-installations-list">Tipologie degli impianti su cui l'impresa opera</a><br></li>
     <if @to_approve_p@ eq "t" >
       <br><big><b>
	   <li><a href="/iter-portal/approve">Conferma</a> definitivamente i dati forniti<br></li>
       </b></big><br>
     </if>
   </if>    
<li><a href="/videoguida">Visualizza videoguide</a></li>
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
    
