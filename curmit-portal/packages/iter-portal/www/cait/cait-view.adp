<master>
  <property name="title">#acs-subsite.Register#</property>
  <property name="context">{#acs-subsite.Register#}</property>

<br>
<big><big>Da qui puoi:
<ul>
  <if @nome_db@ eq "iter-portal-marche" or @nome_db@ eq "iter-portal-marche-test"><!-- rom01 aggiunta if e contenuto, aggiunta else -->
   <li>Accedere a <a href="@url_redirect@">CURMIT</a> per l'inserimento dei modelli RCEE</li>
  </if>
  <else>
   <li>Accedere al <a href="@url_redirect@">programma I.Ter</a> per l'inserimento dei modelli RCEE</li>
  </else><!-- rom01 -->
   <li>Tornare ai <a href="/iter-portal/cait/servcait">Servizi per i CAIT</a>
</ul>
</big></big>
<br>
<h1>@page_title@</h1>

<formtemplate id="addedit" style="standard"></formtemplate>


