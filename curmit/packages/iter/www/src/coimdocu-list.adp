<master   src="../master">
<property name="title">@page_title;noquote@</property>
<property name="context_bar">@context_bar;noquote@</property>
<property name="riga_vuota">f</property>

@link_tab;noquote@
@dett_tab;noquote@
<if @caller@ eq "coimdocu-filter">
    <table width="100%" cellspacing=0 class=func-menu>
    <tr>
       <td width="25%" nowrap colspan=1 class=func-menu>
          <a href="coimdocu-filter?@link_filter;noquote@" class=func-menu>Ritorna</a>
       </td>
       <td width="75%" cellspacing=0 class=func-menu>&nbsp;</td>
    </tr>
</if>

@js_function;noquote@

<!-- barra con il cerca, link di aggiungi e righe per pagina -->
@list_head;noquote@

<center>
<!-- genero la tabella -->
@table_result;noquote@

</center>
