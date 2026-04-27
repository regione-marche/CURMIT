<!--
USER  DATA       MODIFICHE
===== ========== =======================================================================
-->
<master>
  <property name="title">@page_title;noquote@</property>
  <property name="context">@context;noquote@</property>

<h1>@page_title@</h1>
<if @caller;noquote@ eq "new">
<big><big><big><b>@reg_msg@</b></big></big></big>
</if>
<p>Da questa pagina puoi inserire/modificare i seguenti moduli:
</p> 
<ul> 
   <li><a href="/iter-portal/citizen-documents-add-edit?@link_list_aimp@&flag_type_document=CCR">Comunicazione cambio del nominatico del responsabile dell'impianto termico</a></li>
   <li><a href="/iter-portal/citizen-documents-add-edit?@link_list_aimp@&flag_type_document=DAA">Dichiarazione di avvenuto adeguamento dell'impianto termico</a></li>
</ul>
  <p>
    
