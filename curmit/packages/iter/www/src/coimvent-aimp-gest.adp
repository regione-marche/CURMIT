<!--
    USER  DATA       MODIFICHE
    ===== ========== =========================================================================
    gac01 21/12/2018

    rom02 09/11/2018 Aggiunto titolo a inizio pagina e modificate label.

    rom01 04/09/2018 Aggiunto flag_sostituito
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
<formwidget   id="cod_vent_aimp">
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
         <a href="coimvent-aimp-gest?funzione=V&@link_gest;noquote@" class=@func_v;noquote@>Visualizza</a>
      </td>
      <td width="25%" nowrap class=@func_m;noquote@>
         <a href="coimvent-aimp-gest?funzione=M&@link_gest;noquote@" class=@func_m;noquote@>Modifica</a>
      </td>
      <td width="25%" nowrap class=@func_d;noquote@>
         <a href="coimvent-aimp-gest?funzione=D&@link_gest;noquote@" class=@func_d;noquote@>Cancella</a>
      </td>
   </if>
   <else>
      <td width="25%" nowrap class=func-menu>Visualizza</td>
      <td width="25%" nowrap class=func-menu>Modifica</td>
      <td width="25%" nowrap class=func-menu>Cancella</td>
   </else>
</tr>
</table>

<table width="80%"><!--rom02 aggiunta table e titolo-->
  <tr><td>&nbsp;</td></tr>
  <tr>
    <td align="center" class="func-menu-yellow2"><b>10.1 Impianto di Ventilazione Meccanica Controllata</b>
    </td>
  </tr>
  <tr><td>&nbsp;</td></tr>
</table>
  
<table>
<tr><td valign=top align=right class=form_title>VM n.</td><!--rom02 cambiata label Numero-->
    <td valign=top><formwidget id="num_vm">
        <formerror  id="num_vm"><br>
        <span class="errori">@formerror.num_vm;noquote@</span>
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
  <td valign=top align=right class=form_title>VM sostituente</td>
  <td valign=top><formwidget id="num_vm_sostituente">
      <formerror id="num_vm_sostituente"><br>
	<span class="errori">@formerror.num_vm_sostituente;noquote@</span>
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
  <td valign=top colspan=3><formwidget id="modello">
      <formerror  id="modello"><br>
        <span class="errori">@formerror.modello;noquote@</span>
      </formerror>
  </td>
</tr>

<tr>
    <td valign=top align=right class=form_title>Tipologia</td>
    <td valign=top><formwidget id="tipologia">
        <formerror  id="tipologia"><br>
        <span class="errori">@formerror.tipologia;noquote@</span>
        </formerror>
    </td>
  <td></td>
  <td></td>
</tr>

<tr>
    <td valign=top align=right class=form_title>Note Altro</td>
    <td valign=top><formwidget id="note_tipologia_altro">
        <formerror  id="note_tipologia_altro"><br>
        <span class="errori">@formerror.note_tipologia_altro;noquote@</span>
        </formerror>
    </td>
	<td></td>
	<td></td>
</tr>

<tr>
    <td valign=top align=right class=form_title>Massima portata aria (m&sup3;/h)</td>
    <td valign=top><formwidget id="portata_aria">
        <formerror  id="portata_aria"><br>
        <span class="errori">@formerror.portata_aria;noquote@</span>
        </formerror>
    </td>
  <td valign=top align=right class=form_title>Rendimento di recupero / COP</td>
  <td valign=top colspan=3><formwidget id="rendimento_rec">
      <formerror  id="rendimento_rec"><br>
        <span class="errori">@formerror.rendimento_rec;noquote@</span>
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

