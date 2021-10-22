<master   src="../master">
<property name="title">@page_title;noquote@</property>
<property name="context_bar">@context_bar;noquote@</property>

<center>

<table width="100%" cellspacing=0 class=func-menu>
   <tr>
   <td width="25%" nowrap class=func-menu>
       <a href=coimrife-filter?@link_filter;noquote@  class=func-menu>Ritorna</a>
   </td>
   <if @flag_trovato@ eq S>
      <td width="25%" nowrap class=func-menu>
          <a href="@link_aimp;noquote@" class=func-menu>Impianto</a>
       </td>
   </if>
   <else>
      <td width="25%" nowrap class=func-menu>Impianto</td>
   </else>
   <td width="50%" class=func-menu>&nbsp;</td>
</tr>
</table>

@maschera;noquote@

</center>

