<master   src="../master">
<property name="title">@page_title;noquote@</property>
<property name="context_bar">@context_bar;noquote@</property>

@js_function;noquote@

<table width="100%" cellspacing=0 class=func-menu>
<tr>
<td width=20% class=func-menu>
<a href="coimlist-list?nome_funz=listini-test" class=func-menu>Ritorna</a>
</td>
<td class=func-menu>
Tariffe associate al listino: <b>@cod_listino;noquote@ - @descrizione;noquote@</b>
</td>
</tr>
</table>

<!-- barra con il cerca, link di aggiungi e righe per pagina -->
@list_head;noquote@


<center>
<br>
<!-- genero la tabella -->
@table_result;noquote@

</center>

