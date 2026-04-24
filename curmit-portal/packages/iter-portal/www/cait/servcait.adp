<master>
  <property name="title">@page_title;noquote@</property>
  <property name="context">@context;noquote@</property>

<h1>@page_title@</h1>
<p>Da questa pagina puoi accedere ai servizi riservati ai CAIT registrati:
</p> 
<ul> 
   <li>Modifica la <a href="/user/password-update">tua password</a></li>
   <if @nome_db@ eq "iter-portal-marche" or @nome_db@ eq "iter-portal-marche-test"><!-- rom01 aggiunta if e suo contenuto, aggiunta esle -->
     <li>Accedi a <a href=@url_redirect@>CURMIT</a> per l'inserimento dei modelli RCEE</li>
   </if>
   <else>
   <li>Accedi al <a href=@url_redirect@>programma I.Ter</a> per l'inserimento dei modelli RCEE</li>
   </else><!-- rom01 -->
   <li>Visualizza i <a href="/iter-portal/cait/cait-view">Dati della Registrazione</a></li>
<!--27-06-2017 Sandro ha dato ok per toglielo <li>Registra i <a href="/iter-portal/cait/maint-nomail-new">Manutentori senza mail</a></li>-->
<li>Gestisci i <a href="/iter-portal/cait/maintainers-list">Manutentori</a> che hai registrato</li>

  <if @sw_wallet_usato_dal_portale@ eq "1">
    <li><a href="transactions-filter-cait">Lista movimenti</a></li>
  </if>

</ul>
