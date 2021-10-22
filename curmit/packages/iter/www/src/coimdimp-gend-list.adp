<master   src="../master">
<property name="title">@page_title;noquote@</property>
<property name="context_bar">@context_bar;noquote@</property>
<property name="riga_vuota">f</property>

<!-- visualizzo la barra dei link degli appuntamenti oppure degli impianti -->
<!-- in base ai parametri flag_cimp e flag_inco -->
@link_inc;noquote@
@link_tab;noquote@
<!-- visualizzo in ogni caso i dati salienti dell'impianto. -->
@dett_tab;noquote@

@js_function;noquote@

<table width=100% cellpadding=0 cellspacing=0>
  <tr>
      <td align=center><b>Scegliere il generatore a cui si riferisce il Modello da inserire</b><br>&nbsp;
     </td>
  </tr>
</table>

<!-- barra con il cerca, link di aggiungi e righe per pagina -->
@list_head;noquote@

<center>

<!-- genero la tabella -->
@table_result;noquote@
</center>

