<!--
    USER  DATA       MODIFICHE
    ====  ========== =========================================================================
    rom01 08/11/2018 Aggiunto titolo e campi sistem_emis_radiatore, sistem_emis_termoconvettore, 
    rom01            sistem_emis_ventilconvettore, sistem_emis_pannello_radiante, sistem_emis_bocchetta, 
    rom01            sistem_emis_striscia_radiante, sistem_emis_trave_fredda, sistem_emis_altro.
-->

<master   src="../master">
<property name="title">@page_title;noquote@</property>
<property name="context_bar">@context_bar;noquote@</property>
<property name="riga_vuota">f</property>

<center>
<formtemplate id="@form_name;noquote@">
<formwidget   id="funzione">
<formwidget   id="caller">
<formwidget   id="nome_funz">
<formwidget   id="nome_funz_caller">
<formwidget   id="extra_par">
<formwidget   id="cod_impianto">
<formwidget   id="url_list_aimp">
<formwidget   id="url_aimp">


@link_tab;noquote@
@dett_tab;noquote@
<table width="100%" cellspacing=0 class=func-menu>
<tr>
   <td width="50%" nowrap class=@func_v;noquote@>
      <a href="coimaimp-sist-emissione-gest?funzione=V&@link_gest;noquote@" class=@func_v;noquote@>Visualizza</a>
   </td>
   <td width="50%" nowrap class=@func_m;noquote@>
      <a href="coimaimp-sist-emissione-gest?funzione=M&@link_gest;noquote@" class=@func_m;noquote@>Modifica</a>
   </td>
</tr>
</table>

<table width="80%"><!-- rom01aggiunta table e contenuto-->
  <tr><td>&nbsp;</td></tr>
  <tr>
    <td aling="center" class="func-menu-yellow2"><b>7. Sistema di emissione</b>
    </td>
  </tr>
</table>  

<table width="50%"border=0>
<!--rom01<tr><td valign=top align=right class=form_title>Tipo di emissione</td>
    <td valign=top><formwidget id="sistem_emis_tipo">
        <formerror  id="sistem_emis_tipo"><br>
        <span class="errori">@formerror.sistem_emis_tipo;noquote@</span>
        </formerror>
    </td>
</tr>-->

<tr>
  <td valign=top align=right class=form_title width=25%>Radiatori</td>
  <td valign=top width=25%><formwidget id="sistem_emis_radiatore">
      <formerror  id="sistem_emis_radiatore"><br>
	<span class="errori">@formerror.sistem_emis_radiatore;noquote@</span>
      </formerror>
  </td>
  <td valign=top align=right class=form_title>Termoconvettori</td>
  <td valign=top><formwidget id="sistem_emis_termoconvettore">
      <formerror  id="sistem_emis_termoconvettore"><br>
	<span class="errori">@formerror.sistem_emis_termoconvettore;noquote@</span>
      </formerror>
  </td>
</tr>
<tr>
  <td valign=top align=right class=form_title>Ventilconvettori</td>
  <td valign=top><formwidget id="sistem_emis_ventilconvettore">
      <formerror  id="sistem_emis_ventilconvettore"><br>
	<span class="errori">@formerror.sistem_emis_ventilconvettore;noquote@</span>
      </formerror>
  </td>
  <td valign=top align=right class=form_title>Pannelli Radianti</td>
  <td valign=top><formwidget id="sistem_emis_pannello_radiante">
      <formerror  id="sistem_emis_pannello_radiante"><br>
	<span class="errori">@formerror.sistem_emis_pannello_radiante;noquote@</span>
      </formerror>
  </td>
</tr>
<tr>
  <td valign=top align=right class=form_title>Bocchette</td>
  <td valign=top><formwidget id="sistem_emis_bocchetta">
      <formerror  id="sistem_emis_bocchetta"><br>
	<span class="errori">@formerror.sistem_emis_bocchetta;noquote@</span>
      </formerror>
  </td>
  <td valign=top align=right class=form_title>Strisce Radianti</td>
  <td valign=top><formwidget id="sistem_emis_striscia_radiante">
    <formerror  id="sistem_emis_striscia_radiante"><br>
      <span class="errori">@formerror.sistem_emis_striscia_radiante;noquote@</span>
    </formerror>
  </td>
</tr>
<tr>
  <td valign=top align=right class=form_title>Travi Fredde</td>
  <td valign=top><formwidget id="sistem_emis_trave_fredda">
      <formerror  id="sistem_emis_trave_fredda"><br>
	<span class="errori">@formerror.sistem_emis_trave_fredda;noquote@</span>
      </formerror>
  </td>
  <td valign=top align=right class=form_title>Altro</td>
  <td valign=top><formwidget id="sistem_emis_altro">
      <formerror  id="sistem_emis_altro"><br>
	<span class="errori">@formerror.sistem_emis_altro;noquote@</span>
      </formerror>
  </td>
</tr>

<tr>
  <td valign=top align=right class=form_title>Note Altro</td>
  <td valign=top colspan=3><formwidget id="sistem_emis_note_altro">
      <formerror  id="sistem_emis_note_altro"><br>
        <span class="errori">@formerror.sistem_emis_note_altro;noquote@</span>
      </formerror>
  </td>
</tr>

<if @funzione@ ne "V">
  <tr><td colspan=4 align=center><formwidget id="submit"></td></tr>
</if>
</table>

</formtemplate>
<p>
</center>

