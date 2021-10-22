<!--
    USER  DATA       MODIFICHE
    ===== ========== ==========================================================================

  -->

<master   src="../master">
<property name="title">@page_title;noquote@</property>
<property name="context_bar">@context_bar;noquote@</property>

<if @flag_valor_cod@ eq t>
  
<script type="text/javascript">
function sel() {
 window.opener.document.coimtarg.targa.value = '@targa;noquote@';
 @javascript_sel;noquote@ <!--gac01-->
 window.close();
 } 

setTimeout('sel()',0);
</script>
</if>

<if @flag_valor_cod@ ne t>
  @js_function;noquote@

<!-- barra con il cerca, link di aggiungi e righe per pagina -->
@list_head;noquote@

<center>
<!-- genero la tabella -->
@table_result;noquote@

</center>
</if>

