<master   src="../master">
<property name="title">@page_title;noquote@</property>
<property name="context_bar">@context_bar;noquote@</property>
<property name="riga_vuota">f</property>


<script language=JavaScript>
function checkall() {
    for (var i=0; i < document.@form_name;noquote@.elements.length;i++) {
         var e=document.@form_name;noquote@.elements[i];
         if (e.name == 'associato') {
             e.checked = document.@form_name;noquote@.checkall_input.checked;
         }
    }
}
</script>

@js_function;noquote@
@link_tab;noquote@
@dett_tab;noquote@
<!-- barra con il cerca, link di aggiungi e righe per pagina -->
@list_head;noquote@
<table width="100%" border=0>
<tr>
<td align=left nowrap class=func-menu>
  <a href="coimgend-gest?funzione=V&@link_gest;noquote@" class=@func_i;noquote@>Ritorna</a>
</td>
<td width="75%" class=func-menu>&nbsp;</td>
</tr>
</table>
<table width="100%" cellspacing=0>
  <tr>
    <td valign=top align=center class=func-menu-yellow2><b>Selezionare gli eventuali altri generatori che servono lo stesso ambiente (=stanza separata da altri locali attraverso porte o muri fino al soffitto) servito da questo generatore</b>
    </td>
  </tr>
</table>
<center>
<br>
<form name=@form_name;noquote@ method=post action="coimgend-stesso-ambiente-gest">
<input type=hidden name=nome_funz              value="@value_nome_funz;noquote@">
<input type=hidden name=nome_funz_caller       value="@value_nome_funz_caller@">
<input type=hidden name=cod_impianto           value="@value_cod_impianto;noquote@">
<input type=hidden name=gen_prog               value="@value_gen_prog;noquote@">

<!-- genero la tabella -->
@table_result;noquote@

<input type=submit value="Salva">
</form>
</center>

