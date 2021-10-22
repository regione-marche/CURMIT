<!--
    USER  DATA       MODIFICHE
    ====  ========== =========================================================================
    rom01 21/12/2018 Aggiunto campo num_ac_sostituente

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
<formwidget   id="cod_accu_aimp">
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
         <a href="coimaccu-aimp-gest?funzione=V&@link_gest;noquote@" class=@func_v;noquote@>Visualizza</a>
      </td>
      <td width="25%" nowrap class=@func_m;noquote@>
         <a href="coimaccu-aimp-gest?funzione=M&@link_gest;noquote@" class=@func_m;noquote@>Modifica</a>
      </td>
      <td width="25%" nowrap class=@func_d;noquote@>
         <a href="coimaccu-aimp-gest?funzione=D&@link_gest;noquote@" class=@func_d;noquote@>Cancella</a>
      </td>
   </if>
   <else>
      <td width="25%" nowrap class=func-menu>Visualizza</td>
      <td width="25%" nowrap class=func-menu>Modifica</td>
      <td width="25%" nowrap class=func-menu>Cancella</td>
   </else>
</tr>
</table>
<table width="80%"><!--rom02 aggiunta table e titolo 8. Sistema di accumulo-->
  <tr><td>&nbsp;</td></tr>
  <tr>
    <td class="func-menu-yellow2"><b>8. Sistema di accumulo</b>
    </td>
  </tr>
  <tr><td>&nbsp;</td></tr>
</table>
<table>
<tr><td valign=top align=right class=form_title>AC n.</td><!--rom02 cambiata label Numero-->
    <td valign=top><formwidget id="num_ac">
        <formerror  id="num_ac"><br>
        <span class="errori">@formerror.num_ac;noquote@</span>
        </formerror>
    </td>
  <td></td>
  <td></td>
</tr>
<tr>
  <td valign=top align=right class=form_title>Sostituito?</td><!--rom01 aggiunta td e contenuto-->
  <td valign=top><formwidget id="flag_sostituito">
        <formerror id="flag_sostituito"><br>
          <span class="errori">@formerror.flag_sostituito;noquote@</span>
        </formerror>
  </td>
  <td valign=top align=right class=form_title>AC sostituente</td><!--rom02-->
  <td valign=top><formwidget id="num_ac_sostituente">
      <formerror id="num_ac_sostituente"><br>
	<span class="errori">@formerror.num_ac_sostituente;noquote@</span>
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
    <td valign=top align=right class=form_title>Fabbricante</td><!--rom01 cambita label Costruttore-->
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
    <td valign=top align=right class=form_title>Capacit&agrave; (l)</td>
    <td valign=top><formwidget id="capacita">
        <formerror  id="capacita"><br>
        <span class="errori">@formerror.capacita;noquote@</span>
        </formerror>
    </td>
</tr>

<tr>
    <td valign=top align=right class=form_title>Utilizzo</td>
    <td valign=top><formwidget id="utilizzo">
        <formerror  id="utilizzo"><br>
        <span class="errori">@formerror.utilizzo;noquote@</span>
        </formerror>
    </td>
    <td valign=top align=right class=form_title>Coibentazione</td>
    <td valign=top><formwidget id="coibentazione">
        <formerror  id="coibentazione"><br>
        <span class="errori">@formerror.coibentazione;noquote@</span>
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

