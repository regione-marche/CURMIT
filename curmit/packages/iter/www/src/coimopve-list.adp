<master   src="../master">
<property name="title">@page_title;noquote@</property>
<property name="context_bar">@context_bar;noquote@</property>

<table align=center>
      <tr>
         <td align=center>Ente verificatore: <b>@nome_enve;noquote@</b></td>
      </tr>
    </table>
<if @caller@ eq index>
    <table width="25%" cellspacing=0 class=func-menu>
    <tr>
       <td width="25%" nowrap class=func-menu>
           <a href=@url_enve;noquote@ class=func-menu>Ritorna</a>
       </td>
    </tr>
    </table>
</if>

@js_function;noquote@

<!-- barra con il cerca, link di aggiungi e righe per pagina -->
@list_head;noquote@

<center>
<!-- genero la tabella -->
@table_result;noquote@

</center>

