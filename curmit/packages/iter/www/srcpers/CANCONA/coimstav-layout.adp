<master   src="../../master">
<property name="title">@page_title;noquote@</property>
<property name="context_bar">@context_bar;noquote@</property>

<center>
@link_inco;noquote@
@dett_tab;noquote@

<table width=100% cellspacing=0 class=func-menu>
<tr>
   <if @flag_inco@ ne S>
       <td width="25%" class=func-menu>
           <a href="@pack_dir;noquote@/coimstav-filter?@link_filter;noquote@" class=func-menu>Ritorna</a>
       </td>
   </if>
   <else>
       <td width="25%" class=func-menu>&nbsp;</td>
   </else>
   <td width="50%" class=func-menu align=center>Campagna: <b>@desc_camp;noquote@</b></td>
   <td width="25%" class=func-menu>&nbsp;</td>
</tr>
</table>

Avvisi creati: <b>@ctr;noquote@</b>
<if @ctr@ ne 0>
   <p>
   <button onclick="javascript:window.open('@file_pdf_url2;noquote@', 'stampa', 'scrollbars=yes, resizable=yes')">Stampa</button>
   <p>
    @stampa3;noquote@
</if>
<else>
    <p>
    <b>Nessun appuntamento in stato assegnato corrisponde ai criteri impostati.</b>
</else>
</center>



