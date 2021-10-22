<master   src="../master">
<property name="title">@page_title;noquote@</property>
<property name="context_bar">@context_bar;noquote@</property>

<table width="100%" cellspacing=0 class=func-menu>
   <tr>
   <td width="25%" nowrap class=func-menu>
       <a href=coimdocu-dist-list-allegati-ammi?@link_docu_dist_list;noquote@ class=func-menu>Ritorna</a>
   </td>
   <td width="75%" class=func-menu>&nbsp;</td>
</tr>
</table>

@js_function;noquote@

<!-- barra con il cerca, link di aggiungi e righe per pagina -->
<!-- @list_head;noquote@ -->

<table border="0" cellpadding="0" cellspacing="0" width="100%">
<tr><td>&nbsp;</td></tr>
<tr>
    <td align="justify">
        In questa pagina vengono elencati tutti i allegati L inseriti da
        @uten_cognome_nome;noquote@ che non sono ancora stati riportati in una
        distinta
    </td>
</tr>
<tr><td>&nbsp;</td></tr>
<tr>
    <td align=center>Allegati L selezionati: <b>@count_L;noquote@</b>
</tr>
<tr><td>&nbsp;</td></tr>
<if @count_L@ ne "0">
<tr>
    <td align=center>
       <input type="button" onclick="javascript:location.href=('coimdocu-dist-allegati-ammi-layout?@link_docu_dist_layout;noquote@')" value ="Conferma creazione distinta">    	
    </td>
</tr>
</if>
</table>

<p>
<center>

<!-- genero la tabella -->
@table_result;noquote@

<p>

<if @count_L@ ne "0">
	<input type="button" onclick="javascript:location.href=('coimdocu-dist-allegati-ammi-layout?@link_docu_dist_layout;noquote@')" value ="Conferma creazione distinta">
</if>

</center>

