<!--
    USER  DATA       MODIFICHE
    ====  ========== =========================================================================
    rmo03 21/12/2018 Aggiunto campo_num_te_sostituente

    rom02 09/11/2018 Aggiunto titolo in alto alla pagina e cambiate alcune label.

    rom01 04/09/2018 Aggiunto campo flag_sostituto
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
<formwidget   id="cod_torr_evap_aimp">
<formwidget   id="url_aimp">

@link_tab;noquote@
@dett_tab;noquote@
<table width="100%" cellspacing=0 class=func-menu>
<tr>
   <td width="25%" nowrap class=@func_i;noquote@>
       <a href="coimaimp-altre-schede-list?@link_gest;noquote@" class=@func_i;noquote@>Ritorna</a>
   </td>
   <if @funzione@ ne I>
      <td width="25%" nowrap class=@func_v;noquote@>
         <a href="coimtorr-evap-aimp-gest?funzione=V&@link_gest;noquote@" class=@func_v;noquote@>Visualizza</a>
      </td>
      <td width="25%" nowrap class=@func_m;noquote@>
         <a href="coimtorr-evap-aimp-gest?funzione=M&@link_gest;noquote@" class=@func_m;noquote@>Modifica</a>
      </td>
      <td width="25%" nowrap class=@func_d;noquote@>
         <a href="coimtorr-evap-aimp-gest?funzione=D&@link_gest;noquote@" class=@func_d;noquote@>Cancella</a>
      </td>
   </if>
   <else>
      <td width="25%" nowrap class=func-menu>Visualizza</td>
      <td width="25%" nowrap class=func-menu>Modifica</td>
      <td width="25%" nowrap class=func-menu>Cancella</td>
   </else>
</tr>
</table>

<table width="80%"><!--rom02 aggiunta table e titolo 9.1 Torri evaporative-->
  <tr><td>&nbsp;</td></tr>
  <tr>
    <td class="func-menu-yellow2" align="center"><b>9.1 Torri evaporative</b></td>
  </tr>
  <tr><td>&nbsp;</td></tr>
</table>

<table>
  <tr><td valign=top align=right class=form_title>TE n.</td><!--rom02 cambiata label Numero-->
    <td valign=top><formwidget id="num_te">
        <formerror  id="num_te"><br>
          <span class="errori">@formerror.num_te;noquote@</span>
        </formerror>
    </td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td valign=top align=right class=form_title>Sostituto</td><!--rom01 aggiunta td-->
    <td valign=top><formwidget id="flag_sostituito">
	<formerror id="flag_sostituito"><br>
	  <span class="errori">@formerror.flag_sostituito;noquote@</span>
	</formerror>
    </td>
    <td valign=top align=right class=form_title>TE sostituente</td><!--rom02-->
    <td valign=top><formwidget id="num_te_sostituente">
	<formerror id="num_te_sostituente"><br>
	  <span class="errori">@formerror.num_te_sostituente;noquote@</span>
	</formerror>
    </td>
  </tr>
<tr>
    <td valign=top align=right class=form_title>Data installazione</td>
    <td valign=top><formwidget id="data_installaz">
        <formerror  id="data_installaz"><br>
        <span class="errori">@formerror.data_installaz;noquote@</span>
        </formerror>
    </td>
  <td valign=top align=right class=form_title>Data dismissione</td>
  <td valign=top colspan=3><formwidget id="data_dismissione">
      <formerror  id="data_dismissione"><br>
        <span class="errori">@formerror.data_dismissione;noquote@</span>
      </formerror>
  </td>
</tr>

<tr>
    <td valign=top align=right class=form_title>Fabbricante</td><!--rom02 cambiata label Costruttore-->
    <td valign=top><formwidget id="cod_cost">
        <formerror  id="cod_cost"><br>
        <span class="errori">@formerror.cod_cost;noquote@</span>
        </formerror>
    </td>
 
    <td valign=top align=right class=form_title>Modello</td>
    <td valign=top><formwidget id="modello">
        <formerror  id="modello"><br>
        <span class="errori">@formerror.modello;noquote@</span>
        </formerror>
    </td>
</tr>

<tr>
    <td valign=top align=right class=form_title>Matricola</td>
    <td valign=top><formwidget id="matricola">
        <formerror  id="matricola"><br>
        <span class="errori">@formerror.matricola;noquote@</span>
        </formerror>
    </td>
    <td valign=top align=right class=form_title>Capacit&agrave; nominale (l)</td>
    <td valign=top><formwidget id="capacita">
        <formerror  id="capacita"><br>
        <span class="errori">@formerror.capacita;noquote@</span>
        </formerror>
    </td>
</tr>

<tr>
    <td valign=top align=right class=form_title>Numero ventilatori</td>
    <td valign=top><formwidget id="num_ventilatori">
        <formerror  id="num_ventilatori"><br>
        <span class="errori">@formerror.num_ventilatori;noquote@</span>
        </formerror>
    </td>
    <td valign=top align=right class=form_title>Tipo ventilatori</td>
    <td valign=top><formwidget id="tipi_ventilatori">
        <formerror  id="tipi_ventilatori"><br>
        <span class="errori">@formerror.tipi_ventilatori;noquote@</span>
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

