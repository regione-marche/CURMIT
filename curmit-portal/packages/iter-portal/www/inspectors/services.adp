<master>
  <property name="title">@page_title;noquote@</property>
  <property name="context">@context;noquote@</property>

<h1>@page_title@</h1>
<p>Da questa pagina puoi accedere ai servizi riservati agli Ispettori registrati:
</p> 
<ul> 
<if @validated_p@ true >
    <li>Accedi al <a href="/iter-portal/iter-link">programma I.Ter</a></li>
</if>
<if @approved_p@ true >
    <li>Visualizza i <a href="/iter-portal/inspectors/view">Dati della Registrazione</a></li>
</if>
<if @approved_p@ false >
    <li>Modifica i <a href="/iter-portal/inspectors/edit">Dati Anagrafici</a></li>
    <li>Gestisci i <a href="/iter-portal/inspectors/tools-list?type=1">Deprimometri</a><br></li>
    <li>Gestisci gli <a href="/iter-portal/inspectors/tools-list?type=0">Analizzatori di Combustione</a><br></li>
    <if @to_approve_p@ true >
        <br><big><b>
        <li><a href="/iter-portal/inspectors/approve">Conferma</a> definitivamente i dati forniti<br></li>
       </b></big><br>
    </if>
</if>
</ul>
