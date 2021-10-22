<master   src="../master">
<property name="title">@page_title;noquote@</property>
<property name="context_bar">@context_bar;noquote@</property>
<property name="riga_vuota">f</property>

@js_function;noquote@

<if @coimtgen.flag_ente@ eq "P">
    <table width="100%" cellspacing=0 class=func-menu>
    <tr>
       <td width="25%" nowrap class=func-menu>
           <a href=coimviae-filter?@link_filter;noquote@ class=func-menu>Ritorna</a>
       </td>
       <td width="75%" class=func-menu>&nbsp;</td>
    </tr>
    </table>
</if>

<!-- barra con il cerca, link di aggiungi e righe per pagina -->
@list_head;noquote@

<center>
<!-- genero la tabella -->
@table_result;noquote@
</center>

<if @ctr_rec@ ge "20">
   <p></p>
   @list_head;noquote@
</if>

