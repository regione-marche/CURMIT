<!--
    USER  DATA       MODIFICHE
    ====  ========== =========================================================================
    rom02 09/11/2018 Aggiunto titolo ad inizio pagina e modificate alcune label.

    rom01 04/09/2018 Aggiunto campo flag_sostituito
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
<formwidget   id="cod_trat_aria_aimp">
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
         <a href="coimtrat-aria-aimp-gest?funzione=V&@link_gest;noquote@" class=@func_v;noquote@>Visualizza</a>
      </td>
      <td width="25%" nowrap class=@func_m;noquote@>
         <a href="coimtrat-aria-aimp-gest?funzione=M&@link_gest;noquote@" class=@func_m;noquote@>Modifica</a>
      </td>
      <td width="25%" nowrap class=@func_d;noquote@>
         <a href="coimtrat-aria-aimp-gest?funzione=D&@link_gest;noquote@" class=@func_d;noquote@>Cancella</a>
      </td>
   </if>
   <else>
      <td width="25%" nowrap class=func-menu>Visualizza</td>
      <td width="25%" nowrap class=func-menu>Modifica</td>
      <td width="25%" nowrap class=func-menu>Cancella</td>
   </else>
</tr>
</table>

<table width="80%">
  <tr><td>&nbsp;</td><tr><!--rom02 aggiunta table e titolo-->
  <tr>
    <td align="center" class="func-menu-yellow2"><b>9.5 Unit&agrave; di trattamento aria</b></td>
  </tr>
    <tr><td>&nbsp;</td><tr>
</table>
  
<table>
<tr><td valign=top align=right class=form_title>UT n.</td><!--rom02 cambiata label Numero-->
    <td valign=top><formwidget id="num_ut">
        <formerror  id="num_ut"><br>
        <span class="errori">@formerror.num_ut;noquote@</span>
        </formerror>
    </td>
<!--rom01    <td></td>
    <td></td> -->
    <td valign=top align=right class=form_title>Sostituito?</td><!--rom01 aggiunta td e contenuto-->
    <td valign=top><formwidget id="flag_sostituito">
        <formerror id="flag_sostituito"><br>
          <span class="errori">@formerror.flag_sostituito;noquote@</span>
        </formerror>
    </td>
</tr>
<tr>
  <td valign=top align=right class=form_title>UT sostituente</td>
  <td valign=top><formwidget id="num_ut_sostituente">
      <formerror id="num_ut_sostituente"><br>
	<span class="errori">@formerror.num_ut_sostituente;noquote@</span>
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
    <td valign=top align=right class=form_title>Fabbricante</td><!--rom02 modificata label Costruttore-->
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
    <td></td>
    <td></td>
</tr>

<tr>
    <td valign=top align=right class=form_title>Portata ventilatore di mandata (l/s) </td>
    <td valign=top><formwidget id="portata_mandata">
        <formerror  id="portata_mandata"><br>
        <span class="errori">@formerror.portata_mandata;noquote@</span>
        </formerror>
    </td>
    <td valign=top align=right class=form_title>Potenza ventilatore di mandata (kW)</td>
    <td valign=top><formwidget id="potenza_mandata">
        <formerror  id="potenza_mandata"><br>
        <span class="errori">@formerror.potenza_mandata;noquote@</span>
        </formerror>
    </td>
</tr>   

<tr>
    <td valign=top align=right class=form_title>Portata ventilatore di ripresa (l/s)</td>
    <td valign=top><formwidget id="portata_ripresa">
        <formerror  id="portata_ripresa"><br>
        <span class="errori">@formerror.portata_ripresa;noquote@</span>
        </formerror>
    </td>
    <td valign=top align=right class=form_title>Potenza ventilatore di ripresa (kW)</td>
    <td valign=top><formwidget id="potenza_ripresa">
        <formerror  id="potenza_ripresa"><br>
        <span class="errori">@formerror.potenza_ripresa;noquote@</span>
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

