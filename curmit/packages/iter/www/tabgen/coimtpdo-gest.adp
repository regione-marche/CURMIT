<master   src="../master">
<property name="title">@page_title;noquote@</property>
<property name="context_bar">@context_bar;noquote@</property>
<property name="riga_vuota">f</property>

<table width="100%" cellspacing=0 class=func-menu>
<tr>
   <td width="25%" nowrap class=func-menu>
       <a href="coimtpdo-list?@link_list;noquote@" class=func-menu>Ritorna</a>
   </td>
   <if @funzione@ eq "I">
      <td width="75%" nowrap class=func-menu>&nbsp;</td>
   </if>
   <else>
      <td width="25%" nowrap class=@func_v;noquote@>
         <a href="coimtpdo-gest?funzione=V&@link_gest;noquote@" class=@func_v;noquote@>Visualizza</a>
      </td>
      <if @flag_modifica@ eq T>
         <td width="25%" nowrap class=@func_m;noquote@>
            <a href="coimtpdo-gest?funzione=M&@link_gest;noquote@" class=@func_m;noquote@>Modifica</a>
         </td>
         <td width="25%" nowrap class=@func_d;noquote@>
            <a href="coimtpdo-gest?funzione=D&@link_gest;noquote@" class=@func_d;noquote@>Cancella</a>
         </td>
      </if>
      <else>
         <td width="25%" nowrap class=@func_m;noquote@>Modifica</td>
         <td width="25%" nowrap class=@func_d;noquote@>Cancella</td>
      </else>
   </else>
</tr>
</table>

<center>
<formtemplate id="@form_name;noquote@">
<formwidget   id="funzione">
<formwidget   id="caller">
<formwidget   id="nome_funz">
<formwidget   id="extra_par">
<formwidget   id="last_descr_tpdo">

<!-- Inizio della form colorata -->
<%=[iter_form_iniz]%>


<tr><td valign=top align=right class=form_title>Codice</td>
    <td valign=top><formwidget id="cod_tpdo">
        <formerror  id="cod_tpdo"><br>
        <span class="errori">@formerror.cod_tpdo;noquote@</span>
        </formerror>
    </td>
</tr>


<tr><td nowrap valign=top align=right class=form_title>Descrizione tipi d'uso</td>
    <td  nowrap valign=top><formwidget id="descr_tpdo">
        <formerror  id="descr_tpdo"><br>
        <span class="errori">@formerror.descr_tpdo;noquote@</span>
        </formerror>
    </td>
</tr>

<tr><td colspan=2>&nbsp;</td></tr>

<if @funzione@ ne "V">
    <tr><td colspan=2 align=center><formwidget id="submit"></td></tr>
</if>

<!-- Fine della form colorata -->
<%=[iter_form_fine]%>

</formtemplate>
<p>
</center>

