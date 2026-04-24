<master> <!--innes    src="../master"> -->
<property name="title">@page_title;noquote@</property>
<property name="context_bar">@context_bar;noquote@</property>
<property name="riga_vuota">f</property>

<!-- innes
@link_inco;noquote@
<if @flag_cimp@ ne S and @flag_inco@ ne S>
    <table width="25%" cellspacing=0 class=func-menu>
     <tr>
       <td width="25%" nowrap class=func-menu>
        <a href="coimcimp-filter?@link_filt;noquote@" class=func-menu>Ritorna</a>
      </td>
    </tr>
   </table>
</if>
<if @flag_vis@ eq S>
<table align="center" width="35%" border="0" cellpadding="0" cellspacing="0">
<tr>
   <td width="34%" align="center"><a href="coimcimp-list-csv?@link_scar_csv;noquote@">Scarica file csv</a></td>
   <td width="33%" align="center">Numero <strong>@conta;noquote@</strong></td><!--mat01 sostituito <b> con <strong>-->
   <td width="34%" align="center"><a href="coimcimp-list-pdf?@link_scar_csv;noquote@" target="_blank">Stampa file pdf</a></td> 
</tr>
</table>
</if>
@js_function;noquote@
-->


<table>
<tr>
<td>&nbsp;</td>
</tr>
</table>

<!--mat01 <center> -->
<div align="center"><!--mat01-->
<strong>Lista Rapporti di ispezione</strong><br><!--mat01 sostituito <b> con <strong>-->
&Egrave; possibile stampare (Stampa) i documenti.
<br><br>
<!-- genero la tabella -->
@table_result;noquote@

<!--mat01 </center>-->
<br>
</div><!--mat01-->
