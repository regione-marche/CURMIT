<master>
  <property name="title">@page_title;noquote@</property>
  <property name="context">@context;noquote@</property>

<h1>@page_title@</h1>
<p>Da questa pagina puoi accedere alle operazioni sull'Ispettore @inspector_name@:
</p> 
<ul> 
<if @approved_p@ true>
   <li>Visualizza i <a href="/iter-portal/companies/inspector-view?inspector_id=@inspector_id@">Dati della Registrazione</a></li>
</if>
<else>
    <li>Modifica i <a href="/iter-portal/companies/inspector-upd?inspector_id=@inspector_id@">Dati Anagrafici</a></li>
    <if @to_approve_p@ eq "t" >
       <br><big><b>
       <li><a href="/iter-portal/companies/approve?inspector_id=@inspector_id@">Conferma</a> definitivamente i dati forniti per l'ispettore<br></li>
       </b></big><br>
    </if>
</else>    
</ul>
Torna all'elenco degli <a href="/iter-portal/companies/inspectors-list">Ispettori</a> che hai registrato<br>
Torna ai <a href="/iter-portal/companies/services">Servizi per le Aziende di Ispezione</a>
