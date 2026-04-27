<master>
  <property name="title">#acs-subsite.Register#</property>
  <property name="context">{#acs-subsite.Register#}</property>

<br>
<big><big>Da qui puoi:
<ul>
<if @validated_p@ eq "t" >
   <li>Accedere al <a href="/iter-portal/iter-link">programma I.Ter</a> per l'inserimento dei modelli RCEE</li>
</if>
   <li>Tornare ai <a href="/iter-portal/services">Servizi</a>
</ul>
</big></big>
<br>
<h1>@page_title@</h1>

<formtemplate id="addedit" style="standard"></formtemplate>

<!--rom01<h1> Operatori</h1>-->
<h1>Tecnici</h1>
<table cellpadding="3" cellspacing="3">

  <tr>

    <td class="list-list-pane" valign="top">

      <listtemplate name="operators"></listtemplate>

    </td>

  </tr>

</table>

<h1>Deprimometri</h1>
<table cellpadding="3" cellspacing="3">

  <tr>

    <td class="list-list-pane" valign="top">

      <listtemplate name="detools"></listtemplate>

    </td>

  </tr>

</table>

<h1>Analizzatori di Combustione</h1>
<table cellpadding="3" cellspacing="3">

  <tr>

    <td class="list-list-pane" valign="top">

      <listtemplate name="antools"></listtemplate>

    </td>

  </tr>

</table>


<h1>Tipologia degli impianti su cui l'impresa opera</h1>
<table cellpadding="3" cellspacing="3">

  <tr>

    <td class="list-list-pane" valign="top">

      <listtemplate name="maintainer_installations"></listtemplate>

    </td>

  </tr>

</table>
