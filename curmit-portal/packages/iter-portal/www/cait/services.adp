<master>
  <property name="title">@page_title;noquote@</property>
  <property name="context">@context;noquote@</property>

<h1>@page_title@</h1>
<big><big><big><b>@reg_msg@</b></big></big></big>
<p>Da questa pagina puoi accedere alle operazioni sul Manutentore @maintainer_name@:
</p> 
<ul> 
<if @to_modify_p@ eq "f" >
   <li>Visualizza i <a href="/iter-portal/cait/maintainer-view?maintainer_id=@maintainer_id@">Dati della Registrazione</a></li>
</if>
<if @to_modify_p@ ne "f" >
<li>Visualizza i <a href="/iter-portal/cait/maintainer-view?maintainer_id=@maintainer_id@">Dati della Registrazione</a></li>
<li>Gestisci gli <a href="/iter-portal/cait/operators-list?maintainer_id=@maintainer_id@">Operatori</a>
<li>Gestisci i <a href="/iter-portal/cait/tools-list?type=1&maintainer_id=@maintainer_id@">Deprimometri</a><br></li>
<li>Gestisci gli <a href="/iter-portal/cait/tools-list?type=0&maintainer_id=@maintainer_id@">Analizzatori di Combustione</a><br></li>
<if @to_approve_p@ eq "t" >
   <br><big><b>
   <li><a href="/iter-portal/cait/approve?maintainer_id=@maintainer_id@">Conferma</a> definitivamente i dati forniti per il manutentore<br></li>
   </b></big><br>
</if>
</if>    
</ul>
Torna all'elenco dei <a href="/iter-portal/cait/maintainers-list">Manutentori</a> che hai registrato<br>
Torna ai <a href="/iter-portal/cait/servcait">Servizi per i CAIT</a>
