<!--
    USER  DATA       MODIFICHE
    ====  ========== =========================================================================
    rom01 07/11/2018 aggiunto campo data_installaz_nuova_conf e aggiunto campo flag_sostituito.
    rom01            Aggiunto titolo a inizio pagina
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
<formwidget   id="cod_camp_sola_aimp">
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
         <a href="coimcamp-sola-aimp-gest?funzione=V&@link_gest;noquote@" class=@func_v;noquote@>Visualizza</a>
      </td>
      <td width="25%" nowrap class=@func_m;noquote@>
         <a href="coimcamp-sola-aimp-gest?funzione=M&@link_gest;noquote@" class=@func_m;noquote@>Modifica</a>
      </td>
      <td width="25%" nowrap class=@func_d;noquote@>
         <a href="coimcamp-sola-aimp-gest?funzione=D&@link_gest;noquote@" class=@func_d;noquote@>Cancella</a>
      </td>
   </if>
   <else>
      <td width="25%" nowrap class=func-menu>Visualizza</td>
      <td width="25%" nowrap class=func-menu>Modifica</td>
      <td width="25%" nowrap class=func-menu>Cancella</td>
   </else>
</tr>
</table>
<table width="80%"><!-- rom02 aggiunta table e contenuto-->
  <tr><td>&nbsp;</td></tr>
  <tr>
    <td class="func-menu-yellow2" align="center"><b>4.7 - Campi solari termici</b>
    </td>
  </tr>
  <tr><td>&nbsp;</td></tr>
</table>
<table>
  <tr><td valign=top align=right class=form_title>CS n.</td>
    <td valign=top><formwidget id="num_cs">
        <formerror  id="num_cs"><br>
          <span class="errori">@formerror.num_cs;noquote@</span>
        </formerror>
    </td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td valign=top align=right class=form_title>Sostituito?</td><!--rom01 aggiunta td per campo flag_sostituito-->
    <td valign=top><formwidget id="flag_sostituito">
	<formerror id="flag_sostituito"><br>
	  <span class="errori">@formerror.flag_sostituito;noquote@</span>
	</formerror>
    </td>
    <td valign=top align=right class=form_title>CS sostituente</td><!--rom02-->
    <td valign=top><formwidget id="num_cs_sostituente">
	<formerror id="num_cs_sostituente"><br>
	  <span class="errori">@formerror.num_cs_sostituente;noquote@</span>
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
<!--rom01    <td></td>
    <td></td>-->
    <td valign=top align=right class=form_title>Data installazione nuova configurazione</td><!--rom01-->
    <td valign=top><formwidget id="data_installaz_nuova_conf">
        <formerror  id="data_installaz_nuova_conf"><br>
        <span class="errori">@formerror.data_installaz_nuova_conf;noquote@</span>
        </formerror>
    </td>
</tr>

<tr>
    <td valign=top align=right class=form_title>Fabbricante</td>
    <td valign=top><formwidget id="cod_cost">
        <formerror  id="cod_cost"><br>
        <span class="errori">@formerror.cod_cost;noquote@</span>
        </formerror>
    </td>
    <td></td>
    <td></td>
</tr>

<tr>
    <td valign=top align=right class=form_title>Collettori (n&deg;)</td>
    <td valign=top><formwidget id="collettori">
        <formerror  id="collettori"><br>
        <span class="errori">@formerror.collettori;noquote@</span>
        </formerror>
    </td>
    <td valign=top align=right class=form_title>Superficie totale di apertura(m<sup>2</sup>)</td>
    <td valign=top><formwidget id="sup_totale">
        <formerror  id="sup_totale"><br>
        <span class="errori">@formerror.sup_totale;noquote@</span>
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

