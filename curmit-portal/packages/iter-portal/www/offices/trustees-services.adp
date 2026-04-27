<master>
  <property name="title">@page_title;noquote@</property>
  <property name="context">@context;noquote@</property>

<h1>@page_title@</h1>
<big><big><big><b>@reg_msg@</b></big></big></big>
<p>Da questa pagina puoi accedere alle operazioni sull'Amministratore @trustee_name@:
</p> 
<ul> 
<if @to_modify_p@ false >
   <li>Visualizza i <a href="/iter-portal/offices/trustee-view?trustee_id=@trustee_id@">Dati della Registrazione</a></li>
</if>
<if @to_modify_p@ true >
<li>Modifica i <a href="/iter-portal/offices/trustee-upd?trustee_id=@trustee_id@">Dati Anagrafici</a></li>
<if @to_approve_p@ true>
   <br><big><b>
   <li><a href="/iter-portal/offices/approve?trustee_id=@trustee_id@">Conferma</a> definitivamente i dati forniti per l'Amministratore<br></li>
   </b></big><br>
</if>
</if>    
</ul>
Torna all'elenco degli <a href="/iter-portal/offices/trustees-list">Amministratori</a> che hai registrato<br>
Torna ai <a href="/iter-portal/offices/services">Servizi per gli Studi associati</a>
