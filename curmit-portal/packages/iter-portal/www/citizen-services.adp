<!--
USER  DATA       MODIFICHE
===== ========== =======================================================================
-->
<master>
  <property name="title">@page_title;noquote@</property>
  <property name="context">@context;noquote@</property>

<h1>@page_title@</h1>
<if @caller;noquote@ eq "new">
<big><big><big><b>@reg_msg@</b></big></big></big>
</if>
<p>Da questa pagina puoi accedere ai servizi riservati ai cittadini registrati:
</p> 
<ul>
   <if @login_cohesion_marche_p;noquote@ ne "1">
       <li>Modifica la <a href="/user/password-update">tua password</a></li>
   </if>
   <li><a href="/iter-portal/plants-filter">Visualizzazione impianti cittadino</a></li>
   <li><a href="/iter-portal/companies">Cerca Manutentore/Installatore</a></li>
   <if @login_cohesion_marche_p;noquote@ ne "1">
      <li><a href="/iter-portal/citizen-edit">Modifica Dati Personali</a></li>
   </if>
</ul>
<p>
