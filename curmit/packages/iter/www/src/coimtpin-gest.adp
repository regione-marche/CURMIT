<master   src="../master">
<property name="title">@page_title;noquote@</property>
<property name="context_bar">@context_bar;noquote@</property>
<property name="riga_vuota">f</property>

<table align=center>
      <tr>
         <td align=center>Ditta manutentrice: <b>@nome_manu;noquote@</b></td>
      </tr>
      <tr>
         <td align=center>&nbsp;</td>
      </tr>
</table>

<table width="100%" cellspacing=0 class=func-menu>
<tr>
   <td width="25%" nowrap class=func-menu>
       <a href="coimtpin-list?@link_list;noquote@" class=func-menu>Ritorna</a>
   </td>
   <if @funzione@ eq "I">
      <td width="75%" nowrap class=func-menu>&nbsp;</td>
   </if>
   <else>
      <td width="25%" nowrap class=@func_v;noquote@>
         <a href="coimopma-gest?funzione=V&@link_gest;noquote@" class=@func_v;noquote@>Visualizza</a>
      </td>
      <td width="25%" nowrap class=@func_m;noquote@>
         <a href="coimopma-gest?funzione=M&@link_gest;noquote@" class=@func_m;noquote@>Modifica</a>
      </td>
      <td width="25%" nowrap class=@func_d;noquote@>
<!-- Sandro in data 08/03/2017 ha chiesto che venisse disabilitata la cancellazione
         <a href="coimopma-gest?funzione=D&@link_gest;noquote@" class=@func_d;noquote@>Cancella</a>
-->
      </td>
   </tr>
   </else>
</tr>
</table>

<center>
<formtemplate id="@form_name;noquote@">
<formwidget   id="funzione">
<formwidget   id="caller">
<formwidget   id="nome_funz">
<formwidget   id="extra_par">
<formwidget   id="cod_manutentore">
<formwidget   id="url_manu">
<formwidget   id="nome_funz_caller">

<!-- Inizio della form colorata -->
<%=[iter_form_iniz]%>

<tr><td colspan=4>&nbsp;</td></tr>
<tr><td valign=top align=right class=form_title>Tipologia Impianto</td>
    <td valign=top><formwidget id="tipologia_impianto">
        <formerror  id="tipologia_impianto"><br>
        <span class="errori">@formerror.tipologia_impianto;noquote@</span>
        </formerror>
    </td>
</tr>

<tr><td colspan=4 align=center><formwidget id="submit"></td></tr>

<!-- Fine della form colorata -->
<%=[iter_form_fine]%>

</formtemplate>
<p>
</center>

