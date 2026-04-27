<!--
USER  DATA       MODIFICHE
===== ========== =======================================================================
ric01 17/09/2025 Aggiunto solo per le marche link per la gestione delle deleghe (punto 40 MEV 2025).

mat01 05/09/2025 Tolto il link ai protocolli per indicazione di Sandro

but01 11/04/2023 MEV04 step1: modificato link distributori.

rom02 05/05/2023 Modifiche grafiche richieste da Carlo sull'elenco puntato.

mic01 26/05/2022 Aggiunta funzione per permettere agli admin la bonifica della mail dei manutentori.

sim09 31/03/2020 Aggiunto link per Distributori.
sim09.bis        Sandro ha detto a LucaR. al telefono che va visualizzato su tutti gli enti.

rom01 27/02/2020 Aggiunto il link "Modifica configurazione per invio e-mail".
rom01            Sandro ha detto che la funzione puo' andare bene ovunque tranne che su le Marche.

sim08 06/06/2018 Anche la Regione Marche può vedere le statistiche 

sim07 05/10/2017 Aggiunto link per Stampa movimenti e Disassocia Targa

sim06 22/06/2017 Aggiunto link per ricarica CAIT

sim05 17/03/2017 Aggiunto menù per bonifica targhe

sim04 20/02/2017 Cablato in emergenza in modo che l'amministratore manutentori veda anche i link targhe

sim03 05/12/2016 Anche la Regione Calabria può vedere le statistiche

sim02 08/11/2016 Aggiunto la gestione dei menù in base al sottogruppo. 
sim02            Questo viene gestito in base al parametro controlli_sottogruppi_flag 
sim02            nel file tcl.
sim02            Se si è in entrambi i sottogruppi significa che si un Amministratore 
sim02            di tutto il sistema.

sim01 05/09/2016 Aggiunto la gestione delle targhe in base al parametro targhe_flag_gest

nic01 10/06/2016 Parametrizzo l'adp in base ai parametri sw_wallet_usato_dal_portale
nic01            e db_name
-->
<master>
  <property name="context">@context;noquote@</property>
  <property name="title">@page_title@</property>
<big><big>
<h1>@page_title@</h1>
<p>Da questa pagina puoi accedere ai servizi riservati agli amministratori del portale:
</p> 
<ul>
 <if @is_amm_manu@ eq "1"><!--sim02-->
  <li style="margin-bottom: 12px"><a href="maintainers-list">Gestione Manutentori</a></li>
  <if  @db_name@ eq "iter-portal-marche" or @db_name@ eq "iter-portal-marche-test"><!-- ric01 aggiunta if e contenuto-->
       <li style="margin-bottom: 12px"><a href="maintainer-delegations-list">Gestione deleghe</a></li>
  </if>
  <li style="margin-bottom: 12px"><a href="/iter-portal/admin/email-bonifica">Bonifica email Manutentori</a></li><!--mic01-->
 </if>
 <if @is_amm_manu@ eq "1" and @is_amm_cont@ eq "1"><!--sim02-->
  <li style="margin-bottom: 12px"><a href="trustees-list">Gestione Amministratori di Condominio</a></li>
  <li style="margin-bottom: 12px"><a href="bodies-list">Gestione Enti</a></li> 
 </if><!--sim02-->
  <!--sim02 aggiunto condizione su is_amm_cont-->
  <if @sw_wallet_usato_dal_portale@ eq "1" and @is_amm_cont@ eq "1"><!--nic01-->
    <li style="margin-bottom: 12px"><a href="transactions-filter">Lista movimenti contabili</a></li>
    <li style="margin-bottom: 12px"><a href="transactions-print-filter">Stampa movimenti contabili</a></li><!--sim07-->
  </if>
  <if @db_name@ eq "iter-portal-prta">
    <li style="margin-bottom: 12px"><a href="recharge-cait-filter">Ricarica Cait</a></li><!--sim06>
    <!--<li style="margin-bottom: 12px"><a href="/wallet/admin/transfers-list">Lista bonifici</a></li>-->
  </if>
 <if @is_amm_manu@ eq "1"><!--sim04 tolto  and @is_amm_cont@ eq "1"-->
  <if @targhe_flag_gest@ eq "1"><!--sim01-->
    <li style="margin-bottom: 12px"><a href="/iter-portal/targhe/ordtarg-list?is_admin_p=t">Lista Ordini Targhe</a></li>
    <li style="margin-bottom: 12px"><a href="/iter-portal/targhe/coimplic-filter?is_admin_p=t">Gestione Targhe</a></li>
    <li style="margin-bottom: 12px"><a href="/iter-portal/targhe/coimtarg-filter">Ricerca Targa</a></li>
    <li style="margin-bottom: 12px"><a href="/iter-portal/targhe/coimtarg-bonifica">Bonifica Targa</a></li>
    <li style="margin-bottom: 12px"><a href="/iter-portal/targhe/coimtarg-sbianca">Disassocia Targa</a></li><!--sim07-->
</if><!--sim04--> 
<if @is_amm_manu@ eq "1" and @is_amm_cont@ eq "1" and @targhe_flag_gest@ eq "1"><!--sim04 queste restano solo per i super amministratori-->
    <li style="margin-bottom: 12px"><a href="/iter-portal/targhe/coimlott-list">Generazione Targhe</a></li>
  </if>
</if><!--sim04-->
 <if @is_amm_manu@ eq "1" and @is_amm_cont@ eq "1"><!--sim04 queste restano solo per i super amministratori-->
  <li style="margin-bottom: 12px"><a href="become">Impersona un utente</a></li>

  <if @sw_wallet_usato_dal_portale@ eq "0"><!--nic01: se presente il wallet, non vanno usati-->
    <li style="margin-bottom: 12px"><a href="/iter-portal/bollini/ordboll-list?is_admin_p=t">Lista Ordini Bollini</a></li>
    <li style="margin-bottom: 12px"><a href="/iter-portal/bollini/coimboll-filter?is_admin_p=t">Gestione Bollini</a></li>
    <li style="margin-bottom: 12px"><a href="/iter-portal/bollini/coimfatt-filter?is_admin_p=t">Fatture Bollini</a></li>
    <li style="margin-bottom: 12px"><a href="/iter-portal/bollini/coimfatt-csv-filter?is_admin_p=t">Scarico Fatture CSV</a></li>
  </if>

  <!--mat01 <li style="margin-bottom: 12px"><a href="/iter-portal/bollini/iterprot-menu?is_admin_p=t">Protocolli</a></li> -->
  <li style="margin-bottom: 12px"><a href="/iter-portal/admin/services_distributori">Distributori</a></li><!--but01-->
  <!--sim03 aggiunto condizione su iter-portal-calabria-->
  <!--sim07 aggiunto condizione su iter-portal-marche-->
  <if @db_name@ eq "iter-portal-dev" or @db_name@ eq "iter-portal-calabria" or @db_name@ eq "iter-portal-marche" or @db_name@ eq "iter-portal-marche-test"><!-- nic01: Sandro conferma che va solo sul dev -->
    <li style="margin-bottom: 12px"><a href="/iter-portal/stat/iterstat-menu?is_admin_p=t">Statistiche</a></li>
  </if>
 </if><!--sim02-->
  <if @db_name@ ne "iter-portal-marche" and @db_name@ ne "iter-portal-marche-test"><!--rom01 aggiunta if e suo contenuto-->
    <li style="margin-bottom: 12px"><a href="/iter-portal/iter-link">Accesso al programma</a></li>
    <li style="margin-bottom: 12px"><a href="/iter-portal/admin/smtp-configuration-edit.tcl">Modifica configurazione per invio e-mail</a></li>
  </if> 
  <else>
  <li style="margin-bottom: 12px"><a href="/iter-portal/iter-link">Accesso al programma di CURMIT</a></li>
  </else>

</ul>
</big></big>