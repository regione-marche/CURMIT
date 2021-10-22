<!--
    USER  DATA       MODIFICHE
    ===== ========== =================================================================================
-->

<master   src="../master">
<property name="title">@page_title;noquote@</property>
<property name="context_bar">@context_bar;noquote@</property>
<property name="riga_vuota">f</property>
<property name="focus_field">@focus_field;noquote@</property><!-- nic01 -->

<center>
<formtemplate id="@form_name;noquote@">
<formwidget   id="funzione">
<formwidget   id="caller">
<formwidget   id="nome_funz">
<formwidget   id="nome_funz_caller">
<formwidget   id="cod_impianto">
<formwidget   id="gen_prog">
@link_tab;noquote@
@dett_tab;noquote@
<table width="100%">
<tr>
<td nowrap class=@func_i;noquote@>
  <a href="coimgend-gest?funzione=V&@link_gest;noquote@" class=@func_i;noquote@>Ritorna</a>
</td>
<td nowrap class=@func_v;noquote@>
  <a href="coimgend-pote?funzione=V&@link_gest;noquote@" class=@func_v;noquote@>Visualizza</a>
</td>
<td nowrap class=@func_m;noquote@>
  <a href="coimgend-pote?funzione=M&@link_gest;noquote@" class=@func_m;noquote@>Modifica</a>
</td>
</tr>
</table>

<table border=0 cellspacing=0 cellpadding=0 width=80%>

<!--sezione multirow per potenze dei singoli moduli -->
<tr><td class=func-menu-yellow2><b>Inserire le potenze per ogni prova fumi:</b></td></tr>
<tr><td>&nbsp;</td></tr>
<tr><td align=center>
 <table border=0 cellspacing=0 cellpadding=0 width=50%>
    <tr>
      <td valign=top align=center>Modulo</td>
      <td valign=top align=center>Portata termica utile nomiale Pn (kW)</td>
      <td valign=top nowrap align=center>Portata nominale focolare (kW)</td>
    </tr>
    <tr><td colspan=3>&nbsp;</td></tr>
<multiple name=multiple_form_prfumi>
    <tr>
      <td valign=top align=center><formwidget id="progressivo_prova_fumi.@multiple_form_prfumi.conta_prfumi;noquote@">
        <formerror  id="progressivo_prova_fumi.@multiple_form_prfumi.conta_prfumi;noquote@"><br>
        <span class="errori"><%= $formerror(progressivo_prova_fumi.@multiple_form_prfumi.conta_prfumi;noquote@) %></span>
        </formerror>
      </td>     
      <td valign=top align=center><formwidget id="potenza_utile_focolare.@multiple_form_prfumi.conta_prfumi;noquote@"><font color=red>*</font>
        <formerror  id="potenza_utile_focolare.@multiple_form_prfumi.conta_prfumi;noquote@"><br>
        <span class="errori"><%= $formerror(potenza_utile_focolare.@multiple_form_prfumi.conta_prfumi;noquote@) %></span>
        </formerror>
      </td>
      <td valign=top align=center><formwidget id="potenza_nominale_focolare.@multiple_form_prfumi.conta_prfumi;noquote@"><font color=red>*</font>
        <formerror  id="potenza_nominale_focolare.@multiple_form_prfumi.conta_prfumi;noquote@"><br>
        <span class="errori"><%= $formerror(potenza_nominale_focolare.@multiple_form_prfumi.conta_prfumi;noquote@) %></span>
        </formerror>
      </td>
    </tr>
    <tr><td colspan=3>&nbsp;</td></tr>
</multiple>
  </table>
</td>
</tr>
<if @funzione@ ne "V">
    <tr><td colspan=7 align=center><formwidget id="submit"></td></tr>
</if>
</table>
</formtemplate>
<p>
</center>

