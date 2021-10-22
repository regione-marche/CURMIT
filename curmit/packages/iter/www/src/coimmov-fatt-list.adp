<master   src="../master">
<property name="title">@page_title;noquote@</property>
<property name="context_bar">@context_bar;noquote@</property>

<script language=JavaScript>
function checkall() {
    for (var i=0; i < document.@form_name;noquote@.elements.length;i++) {
         var e=document.@form_name;noquote@.elements[i];
         if (e.name == 'conferma') {
             e.checked = document.@form_name;noquote@.checkall_input.checked;
         }
    }
}
</script>

<table width="100%" cellspacing=0 class=func-menu>
<tr>
   <td width="50%" nowrap class=func-menu>
       <a href="coimmov-fatt-filter?@link_filter;noquote@" class=func-menu>Ritorna</a>
   </td>
   <td width="50%" nowrap class=func-menu>

   </td>

</tr>
</table>
@js_function;noquote@

<!-- barra con il cerca, link di aggiungi e righe per pagina -->
@list_head;noquote@

<center>

<table width=100% border=0 cellpadding=0 cellspacing=0>
  <tr>
    <td align=center>
      <form name=@form_name;noquote@ method=post action="coimfatt-isp-stmp">
        <input type=hidden name=caller           value="@value_caller;noquote@">
        <input type=hidden name=nome_funz        value="@value_nome_funz;noquote@">
        <input type=hidden name=nome_funz_caller value="@value_nome_funz_caller;noquote@">
	<input type=hidden name=extra_par        value="@value_extra_par;noquote@">
	<input type=hidden name=data_fattura     value="@value_data_fattura;noquote@">
      </td>
   </tr>
</table>




<table border=0>
<tr>
    <td align=left>@link_sel;noquote@</td>
</tr>
<tr>
<!-- genero la tabella -->
@table_result;noquote@
</tr>

<tr>
<td>
&nbsp
</td>
</tr>

<tr>
<td align=center>
 <input type=submit value="Stampa Fatture selezionate">
</td>
</tr>
<tr>
<td>
&nbsp
</td>
</tr>
</table>
</center>
