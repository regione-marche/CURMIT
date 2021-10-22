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

@js_function;noquote@
<!-- barra con il cerca, link di aggiungi e righe per pagina -->
@list_head;noquote@

<center>

<table width=100% border=0 cellpadding=0 cellspacing=0>
  <tr>
    <td align=center>
      <form name=@form_name;noquote@ method=post action="coimsobo-layout">
        <input type=hidden name=caller           value="@value_caller;noquote@">
        <input type=hidden name=nome_funz        value="@value_nome_funz;noquote@">
        <input type=hidden name=nome_funz_caller value="@value_nome_funz_caller;noquote@">

        <input type=submit value="Conferma stampa">
      </td>
   </tr>
</table>

<table border=0>
<tr>
    <td>@link_sel;noquote@</td>
</tr>
<tr>
    <td>@table_result;noquote@</td>
</tr>
</table>

<p>
<input type=submit value="Conferma stampa">
</form>

</center>

