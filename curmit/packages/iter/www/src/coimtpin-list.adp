<master   src="../master">
<property name="title">@page_title;noquote@</property>
<property name="context_bar">@context_bar;noquote@</property>

<if @caller@ eq index>
    <table width="25%" cellspacing=0 class=func-menu>
    <tr>
       <td width="25%" nowrap class=func-menu>
           <a href=@url_manu;noquote@ class=func-menu>Ritorna</a>
       </td>
    </tr>
    </table>
</if>
<br>
<table width="100%">
  <tr>
    <td width="100%" align="center">@link_aggiungi;noquote@</td>
    </tr>
  </table>
    
<center>
<br><br>
<!-- genero la tabella -->
@table_result;noquote@

</center>

