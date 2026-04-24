<master>
  <property name="title">#acs-subsite.Register#</property>
  <property name="context">{#acs-subsite.Register#}</property>
  <property name="focus">register.email</property>
  <br>
i dati inseriti vengono resi in forma di autodichiarazione ai sensi del DPR 445/2000 e come tali saranno sottoposti a verifica. La dichiarazione mendace e la falsità in atti costituiscono reati ai sensi dell'articolo 76 del D.P.R. 445/2000 e comportano l'applicazione della sanzione penale. Le informazioni indicate nella presente dichiarazione verranno utilizzate unicamente per le finalità per le quali sono state acquisite.
  <br>
  Consapevole che chiunque rilascia dichiarazioni mendaci è punito ai sensi del codice penale e delle leggi speciali in materia, ai sensi e per gli effetti dell'art. 46 D.P.R. n. 445/2000
  <br>
  <if @db_name;noquote@ eq "iter-portal-marche" or @db_name;noquote@ eq "iter-portal-marche-test"><!--rom01 aggiunta if ma non il contenuto-->
      <div align="right"><a href="/iter-portal/loading/data/resistrazione_ditta_sul_portale.mp4" target="_blank">Help videoguida</a></div>
  </if>
<include src="/packages/iter-portal/lib/user-new" email="" return_url="/iter-portal/services" />
