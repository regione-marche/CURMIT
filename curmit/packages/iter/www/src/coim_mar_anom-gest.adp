<master   src="../master">
<property name="title">@page_title;noquote@</property>
<property name="context_bar">@context_bar;noquote@</property>
<property name="riga_vuota">f</property>

@link_tab;noquote@
@dett_tab;noquote@
<table width="100%" cellspacing=0 class=func-menu>
<tr>
<!--
   <td width=20% nowrap class=func-menu>
       <a href="coim_d_anom-list?@link_list;noquote@" class=func-menu>Lista</a>
   </td>
-->
   <if @funzione@ eq "I">
      <td width=100% nowrap class=func-menu>&nbsp;</td>
   </if>
   <else>
      <td width=25% nowrap class=@func_v;noquote@>
         <a href="coim_d_anom-gest?funzione=V&@link_gest;noquote@" class=@func_v;noquote@>Visualizza</a>
      </td>
      <td width=75%>&nbsp;</td>
   </else>
</tr>
</table>

<center>
<formtemplate id="@form_name;noquote@">
<formwidget   id="funzione">
<formwidget   id="caller">
<formwidget   id="nome_funz">
<formwidget   id="nome_funz_caller">
<formwidget   id="extra_par">
<formwidget   id="last_data_controllo">

<!-- Inizio della form colorata -->
<%=[iter_form_iniz]%>

<tr><td valign=top align=right class=form_title>Codice anomalia</td>
    <td valign=top><formwidget id="cod_d_tano">
        <formerror  id="cod_d_tano"><br>
        <span class="errori">@formerror.cod_d_tano;noquote@</span>
        </formerror>
    </td>
</tr>

<tr><td valign=top align=right class=form_title>Data controllo</td>
    <td valign=top><formwidget id="data_controllo">
        <formerror  id="data_controllo"><br>
        <span class="errori">@formerror.data_controllo;noquote@</span>
        </formerror>
    </td>
</tr>

<tr><td valign=top align=right class=form_title>Descrizione</td>
    <td valign=top><formwidget id="descr_breve">
        <formerror  id="descr_breve"><br>
        <span class="errori">@formerror.descr_breve;noquote@</span>
        </formerror>
    </td>
</tr>

<tr>
    <td valign=top align=right class=form_title>Data invio lettera</td>
    <td valign=top><formwidget id="data_invio_lettera">
        <formerror  id="data_invio_lettera"><br>
        <span class="errori">@formerror.data_invio_lettera;noquote@</span>
        </formerror>
    </td>
</tr>

<tr><td>&nbsp;</td></tr>

<if @funzione@ ne "V">
    <tr><td align=center><formwidget id="submit"></td></tr>
</if>

<!-- Fine della form colorata -->
<%=[iter_form_fine]%>

</formtemplate>
<p>
</center>

