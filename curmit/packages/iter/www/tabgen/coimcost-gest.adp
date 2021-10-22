<master   src="../master">
<property name="title">@page_title;noquote@</property>
<property name="context_bar">@context_bar;noquote@</property>
<property name="riga_vuota">f</property>

<table width=100% cellspacing=0 class=func-menu>
<tr>
   <td nowrap class=func-menu>
       <a width="20%" href=coimcost-list?@link_list;noquote@ class=func-menu>Ritorna</a>
   </td>
   <if @funzione@ eq "I">
      <td width="80%" nowrap class=func-menu>&nbsp;</td>
   </if>
   <else>
      <td width="20%" nowrap class=@func_v;noquote@>
         <a href="coimcost-gest?funzione=V&@link_gest;noquote@" class=@func_v;noquote@>Visualizza</a>
      </td>
      <td width="20%" nowrap class=@func_m;noquote@>
         <a href="coimcost-gest?funzione=M&@link_gest;noquote@" class=@func_m;noquote@>Modifica</a>
      </td>
      <td width="20%" nowrap class=@func_d;noquote@>
         <a href="coimcost-gest?funzione=D&@link_gest;noquote@" class=@func_d;noquote@>Cancella</a>
      </td>
      <if @coimtgen.flag_gest_coimmode@ eq "T">
         <td nowrap class=func-menu>
	    <a href="coimmode-list?@link_mode;noquote@" class=func-menu;noquote@>Modelli</a>
	 </td>
      </if>
      <else>
         <td width="20%" nowrap class=func-menu>&nbsp;</td>
      </else>
   </else>
</tr>
</table>

<p></p>

<center>
<formtemplate id="@form_name;noquote@">
<formwidget   id="funzione">
<formwidget   id="caller">
<formwidget   id="nome_funz">
<formwidget   id="extra_par">
<formwidget   id="last_key_order_by">
<formwidget   id="cod_cost">

<!-- Inizio della form colorata -->
<%=[iter_form_iniz]%>


<tr><td valign=top align=right class=form_title>Descrizione</td>
    <td valign=top nowrap><formwidget id="descr_cost">
        <formerror  id="descr_cost"><br>
        <span class="errori">@formerror.descr_cost;noquote@</span>
        </formerror>
    </td>
</tr>

<tr><td colspan=2>&nbsp;</td></tr>

<if @funzione@ ne "V" and @nodelete@ eq "F">
    <tr><td colspan=2 align=center><formwidget id="submit"></td></tr>
</if>

<!-- Fine della form colorata -->
<%=[iter_form_fine]%>

</formtemplate>
<p>
</center>

