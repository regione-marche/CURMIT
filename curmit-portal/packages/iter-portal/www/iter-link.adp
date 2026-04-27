<master>
  <property name="title">@page_title;noquote@</property>
  <property name="context">@context;noquote@</property>

<br><br>
<big><big>Torna ai <a href="
  <switch @party_type@>
    <case value="maintainer">
      services
    </case>
    <case value="trustee">
      jbuild/servtrust
    </case>
    <case value="cait">
      cait/servcait
    </case>
    <case value="office">
      offices/services
    </case>
    <case value="company">
      companies/services
    </case>
    <case value="inspector">
      inspectors/services
    </case>
  </switch>
">servizi</a>

<br>
<h1>@page_title@</h1>
<p>Accedi all'ente:
</p> 
<ul> 
  <multiple name="instances">
      <li><a href="@instances.url@" target="iter">@instances.group_name@</a></li>
  </multiple>
</ul>
</big></big>

<!--
link finale da attivare solo quando sarà pronto il single sign on
<li><a href="iter-login?url=@instances.url@&dbname=@instances.instance_name@&iter_code=$iter_code">@instances.group_name@</a>
-->
