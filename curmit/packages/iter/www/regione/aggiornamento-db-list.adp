<master   src="../master">
<property name="title">@page_title;noquote@</property>
<property name="context_bar">@context_bar;noquote@</property>

<script language=JavaScript>
function checkall() {
    for (var i=0; i < document.@form_name;noquote@.elements.length;i++) {
         var e=document.@form_name;noquote@.elements[i];
         if (e.name == 'nome_database') {
             e.checked = document.@form_name;noquote@.checkall_input.checked;
         }
    }
}
</script>


<form name="@form_name;noquote@" id="@form_name;noquote@" method=post action="aggiornamento-db-gest">
        <input type=hidden name=caller           value="@value_caller;noquote@">
        <input type=hidden name=nome_funz        value="@value_nome_funz;noquote@">
        <input type=hidden name=nome_funz_caller value="@value_nome_funz_caller;noquote@">
	<input type=hidden name=sql_istruction   value="@sql_istruction;noquote@">

<table align="center">
  <tr><td height="30">&nbsp;</td></tr>
  <tr>
    <td>Selezionare i database su cui effettuare l'aggiornamento</td>
  </tr>
  <tr><td>&nbsp;</td></tr>
  <tr><td>@link_sel;noquote@</td></tr>
  <tr><td>@table_result;noquote@</td></tr>
  <tr><td><input type="submit" value="Conferma"></td></tr>

</table>


</form>

