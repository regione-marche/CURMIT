<master>
  <property name="title">@page_title;noquote@</property>
  <property name="context">@context;noquote@</property>
<big><big>
<h1>@page_title@</h1>
<p>Da questa pagina puoi accedere ai servizi riservati alle Software-house registrate:</p> 

<if @is_active_p@>
  <ul> 

    <li>Modifica la <a href="/user/password-update">tua password</a>.</li>

    <li>Accedi al <a href="https://curmit-cm-ancona-test.regione.marche.it" target="iter">programma I.Ter</a> di test per l'inserimento massivo degli RCEE.
    </li>
    <small>
      <ul>Le credenziali di accesso sono:
        <li>Codice Utente: MA60003201</li>
	<li>Password: 81448901</li>
      </ul>
    </small>
    <br>
    <li>Visualizza i <a href="/iter-portal/software-house/software-house-view">Dati Anagrafici</a>.</li>

  </ul>

  <p>Scarica i file per ogni ente:</p>
  <multiple name="instances">
    <ul>@instances.group_name@:
      <li><a href="@instances.url_via@">Viario</a></li>
      <li><a href="@instances.url_par@">Parametri</a></li>   
    </ul>
  </multiple>
  </big></big>

</if>
<else>
<p>L'utente non risulta attivo, non è possibile usufruire dei servizi.</p>
</else>