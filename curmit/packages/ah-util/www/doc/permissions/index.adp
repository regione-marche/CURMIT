<% set admin_p [acs_user::site_wide_admin_p] %>

<% set path [ah::service_root]/packages/ah-util/www/doc/permissions/index.adp %>

<master src="/packages/mis-base/www/alter-master">

<property name="title">Help di /ah-util/permissions/</property>

<property name="context">{/ah-util/permissions/ Ritorna} Help</property>

<if @admin_p@ eq 1><a href="/ah-util/help-ae?file=@path@&url=/ah-util/permissions/"> Modifica</a><p></if>

<!-- Inizio testo --><h1>I Permessi resi facili
</h1>
<p>La gestione dei permessi di <strong>Alter</strong> è molto potente e flessibile. Prima di invocare da menu la gestione dei permessi, è necessario completare i seguenti passi:
</p>
<ol>
  <li>Definire gli utenti (Anagrafiche -&gt; Utenti)</li>
  <li>Predisporre la struttura organizzativa (Anagrafiche -&gt; Unità Organizzative)</li>
  <li>Associare gli utenti alle corrispondenti Unità Organizzative</li>
</ol>
<p>I programmi di <strong>Alter</strong> sono organizzati in cartelle gerarchiche dove quelle superiori hanno lo stesso nome delle voci di Menu. Quando richiamiamo da menu la gestione dei permessi (Anagrafiche -&gt; Permessi -&gt; Programmi), viene presentata una lista delle cartelle superiori. Se la cartella contiene degli elementi (programmi o altre cartelle) l'icona <a href="/ah-util/permissions/?expand=593887&amp;root_id=457#593887"><img src="/resources/acs-templating/plus.gif" border="0" /></a> permetterà di aprire la cartella, mentre l'icona <a href="/ah-util/permissions/?root_id=457#593887"><img src="/resources/acs-templating/minus.gif" border="0" /></a> permetterà di chiuderla.
</p>
<p>In molti casi non sarà necessario aprire i livelli inferiori, in quanto interviene il principio di <em>ereditarietà</em>: tutti i permessi assegnati ad una cartella vengono cioè ereditati dagli elementi di livello inferiore. Lo stesso principio di <em>ereditarietà </em>vale anche per la struttura organizzativa: se assegno un permesso ad una Unità Organizzativa questo viene ereditato da tutte le Unità e utenti gerarchicamente dipendenti.
</p>
<p>Cliccando il link Permessi a fianco di una qualunque cartella o programma, si viene portati ad una pagina che riassume gli attuali permessi e permette di modificarli. La pagina è una matrice le cui righe rappresentano tutte le Unità Organizzative definite (indipendentemente dal fatto che abbiano o meno dei permessi assegnati) e tutti e soli gli utenti con dei permessi assegnati. Le colonne della matrice sono i tre permessi gestiti da <strong>Alter</strong>:
</p>
<ol>
  <li><em>Read</em> (Consente di eseguire il programma, ma senza poter modificare i dati)
  <br /></li>
  <li><em>Exec</em> (Consente di eseguire il programma e modificare i dati)</li>
  <li><em>Admin</em> (Consente di eseguire anche programmi speciali)</li>
</ol>
<p>Le caselle della matrice indicano se il permesso è attribuito o meno al corrispondente soggetto. La presenza del permesso viene evidenziata da due rappresentazioni differenti a seconda che si tratti di un permesso diretto
  <input name="perm" value="570201,read" checked="checked" type="checkbox" />o ereditato <img src="/shared/images/checkboxchecked" style="border: 0pt none ;" alt="X" title="Questo permesso è erditato. Per rimuoverlo clicca il bottone 'Non ereditare permessi da ...'." height="13" width="13" />.
</p>
<p>La distinzione è importante, in quanto mentre è possibile revocare un permesso diretto semplicemente cliccando sulla casella, in caso di permesso ereditato è necessario cliccare il bottone 'Non ereditare permessi da ...'.
  <br />
</p>
<p>Cliccando sulle caselle è facile attribuire o revocare il permesso desiderato: al termine dell'operazione è necessario cliccare il bottone 'Conferma modifiche' per attuare tutti i permessi della matrice.
</p>
<p>Per economia di rappresentazione, la pagina espone solo gli utenti che posseggono almeno un permesso ed esclude inoltre anche gli utenti con il privilegio di <em>site wide admin</em>, che per definizione possono eseguire qualsiasi programma.
</p>
<p>Volendo attribuire un permesso ad uno o più utenti non visualizzati basta cliccare il bottone 'Assegna permesso ad altri utenti'. Si verrà portati ad una pagina che permetterà di scegliere uno o più utenti e di associarli al permesso 'Read' o 'Exec'.
</p>
<p>Infine un'ultima annotazione sulle voci di menu Anagrafiche -&gt; Permessi-&gt; Clienti e Anagrafiche -&gt; Permessi-&gt; Fornitori. <strong>Alter</strong> gestisce tutti i soggetti con lo stesso programma e pertanto se un utente ha il permesso Exec sul programma <font face="courier new,courier,monospace">mis-base/parties/add-edit </font>é in grado di gestire sia i clienti che i fornitori. Le due voci di menu permettono di assegnare selettivamente la gestione Clienti e Fornitori a soggetti diversi, anche se utilizzano lo stesso programma.
</p>
