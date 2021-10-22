<!--
    USER  DATA       MODIFICHE
    ====  ========== =========================================================================
    rom01 08/11/2018 Cambiate diciture label; gestito il ritorno a coimaimp-sist-distribuz-gest
    rom01            in base alla funzione con cui vengo chiamato.
-->

<master   src="../master">
<property name="title">@page_title;noquote@</property>
<property name="context_bar">@context_bar;noquote@</property>
<property name="riga_vuota">f</property>

<center>
<formtemplate id="@form_name;noquote@">
<formwidget   id="funzione">
<formwidget   id="funzione_caller"><!--rom01-->
<formwidget   id="caller">
<formwidget   id="nome_funz">
<formwidget   id="nome_funz_caller">
<formwidget   id="extra_par">
<formwidget   id="cod_impianto">
<formwidget   id="url_list_aimp">
<formwidget   id="cod_vasi_espa_aimp">
<formwidget   id="url_aimp">

@link_tab;noquote@
@dett_tab;noquote@
<!--rom01 aggiunta variabile funzione_caller a tutte le url-->
<table width="100%" cellspacing=0 class=func-menu>
<tr>
   <td width="25%" nowrap class=@func_i;noquote@>
       <a href="coimaimp-sist-distribuz-gest?@link_gest;noquote@&funzione=@funzione_caller;noquote@" class=@func_i;noquote@>Ritorna</a>
   </td>
   <if @funzione@ ne I>
      <td width="25%" nowrap class=@func_v;noquote@>
         <a href="coimvasi-espa-aimp-gest?funzione=V&@link_gest;noquote@&funzione_caller=@funzione_caller;noquote@" class=@func_v;noquote@>Visualizza</a>
      </td>
      <td width="25%" nowrap class=@func_m;noquote@>
         <a href="coimvasi-espa-aimp-gest?funzione=M&@link_gest;noquote@&funzione_caller=@funzione_caller;noquote@" class=@func_m;noquote@>Modifica</a>
      </td>
      <td width="25%" nowrap class=@func_d;noquote@>
         <a href="coimvasi-espa-aimp-gest?funzione=D&@link_gest;noquote@&funzione_caller=@funzione_caller;noquote@" class=@func_d;noquote@>Cancella</a>
      </td>
   </if>
   <else>
      <td width="25%" nowrap class=func-menu>Visualizza</td>
      <td width="25%" nowrap class=func-menu>Modifica</td>
      <td width="25%" nowrap class=func-menu>Cancella</td>
   </else>
</tr>
</table>

<table>
<tr><td valign=top align=right class=form_title width="50%">VX n.</td><!--rom01 Rinominata label "Numero" in "VX n."-->
    <td valign=top><formwidget id="num_vx">
        <formerror  id="num_vx"><br>
        <span class="errori">@formerror.num_vx;noquote@</span>
        </formerror>
    </td>
    <td></td>
    <td></td>
</tr>

<tr>
    <td valign=top align=right class=form_title>Capacit&agrave; (l)</td>
    <td valign=top><formwidget id="capacita">
        <formerror  id="capacita"><br>
        <span class="errori">@formerror.capacita;noquote@</span>
        </formerror>
    </td>
    <td></td>
    <td></td>
</tr>

<tr>
    <td valign=top align=right class=form_title>Aperto/Chiuso</td>
    <td valign=top><formwidget id="flag_aperto">
        <formerror  id="flag_aperto"><br>
        <span class="errori">@formerror.flag_aperto;noquote@</span>
        </formerror>
    </td>
    <td></td>
    <td></td>
</tr>

<tr>
  <!--rom01 Rinominata label "Pressione (bar)"  in "Pressione di precairca solo per vasi chiusi (bar)"-->
  <td valign=top align=right class=form_title>Pressione di precairca solo per vasi chiusi (bar)</td>
  <td valign=top colspan=3><formwidget id="pressione">
      <formerror  id="pressione"><br>
        <span class="errori">@formerror.pressione;noquote@</span>
      </formerror>
  </td>
  <td></td>
  <td></td>
</tr>

<if @funzione@ ne "V">
    <tr><td colspan=4 align=center><formwidget id="submit"></td></tr>
</if>

</table>

</formtemplate>
<p>
</center>

