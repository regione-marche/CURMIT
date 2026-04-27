<master>
  <property name="title">@page_title;noquote@</property>
  <property name="context">@context;noquote@</property>

<h1>@page_title@</h1>
<p>Da questa pagina puoi accedere ai servizi riservati agli Amministratori di Condominio registrati:
</p> 
<ul> 
   <li>Modifica la <a href="/user/password-update">tua password</a></li>
<if @validated_p@ eq "t" >
   <li>Accedi al <a href="/iter-portal/iter-link">programma I.Ter</a> per l'inserimento dei modelli F e G</li>
   <li>Ricarica il tuo <a href="/iter-portal/welcome?trustee_id=@trustee_id@">Portafoglio</a>.</li>
   <li>Consulta i tuoi <a href="/iter-portal/ec?trustee_id=@trustee_id@">Movimenti di Portafoglio</a>.</li>
</if>
<li>Visualizza i <a href="/iter-portal/jbuild/trustee-view">Dati Anagrafici</a></li>
<if @approved_p@ ne "t" >
<if @to_approve_p@ eq "t" >
   <br><big><b>
   <li><a href="/iter-portal/jbuild/approve">Conferma</a> definitivamente i dati forniti<br></li>
   </b></big><br>
</if>
</if>
</ul>

