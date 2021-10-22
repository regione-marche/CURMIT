<!--
    USER  DATA       MODIFICHE
    ====  ========== =========================================================================
    rom01 21/12/2018 Aggiunto campo num_vr_sostituente
-->

<master   src="../master">
  <property name="title">@page_title;noquote@</property>
  <property name="context_bar">@context_bar;noquote@</property>
  <property name="riga_vuota">f</property>
  
<center>
<formtemplate id="@form_name;noquote@">
<formwidget   id="funzione">
<formwidget   id="funzione_caller">
<formwidget   id="caller">
<formwidget   id="nome_funz">
<formwidget   id="nome_funz_caller">
<formwidget   id="extra_par">
<formwidget   id="cod_impianto">
<formwidget   id="url_list_aimp">
<formwidget   id="cod_valvola_regolazione_aimp">
<formwidget   id="url_aimp">

  @link_tab;noquote@
  @dett_tab;noquote@
  <table width="100%" cellspacing=0 class=func-menu>
    <tr>
      <td width="25%" nowrap class=@func_i;noquote@>
	<a href="coimaimp-regol-contab-gest?@link_gest;noquote@&funzione=@funzione_caller;noquote@" class=@func_i;noquote@>Ritorna</a>
      </td>
      <if @funzione@ ne I>
	<td width="25%" nowrap class=@func_v;noquote@>
          <a href="coimvalv-reg-gest?funzione=V&@link_gest;noquote@&funzione_caller=@funzione_caller;noquote@" class=@func_v;noquote@>Visualizza</a>
	</td>
	<td width="25%" nowrap class=@func_m;noquote@>
          <a href="coimvalv-reg-gest?funzione=M&@link_gest;noquote@&funzione_caller=@funzione_caller;noquote@" class=@func_m;noquote@>Modifica</a>
	</td>
	<td width="25%" nowrap class=@func_d;noquote@>
          <a href="coimvalv-reg-gest?funzione=D&@link_gest;noquote@&funzione_caller=@funzione_caller;noquote@" class=@func_d;noquote@>Cancella</a>
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
    <tr><td>&nbsp;</td></tr>
    <tr>
      <td align="center" class="func-menu-yellow2">
	<b>Valvola di Regolazione</b>
      </td>
    </tr>
    <tr><td>&nbsp;</td></tr>
  </table>
  <table>
    <tr><td valign=top align=right class=form_title>VR n.</td>
      <td valign=top><formwidget id="num_vr">
          <formerror  id="num_vr"><br>
            <span class="errori">@formerror.num_vr;noquote@</span>
          </formerror>
      </td>
    </tr>
    <tr>
      <td valign=top align=right class=form_title>Sostituito?</td>
      <td valign=top><formwidget id="flag_sostituito">
	  <formerror id="flag_sostituito"><br>
	    <span class="errori">@formerror.flag_sostituito;noquote@</span>
	  </formerror>
      </td>
      <td valign=top align=right class=form_title>VR sostituente</td>
      <td valign=top><formwidget id="num_vr_sostituente">
      <formerror id="num_vr_sostituente"><br>
	<span class="errori">@formerror.num_vr_sostituente;noquote@</span>
      </formerror>
</td>
</tr>

<tr>
  <td valign=top align=right class=form_title>Data Installazione</td>
  <td valign=top><formwidget id="data_installazione">
      <formerror  id="data_installazione"><br>
          <span class="errori">@formerror.data_installazione;noquote@</span>
        </formerror>
    </td>
    <td valign=top align=right class=form_title>Data Dismissione</td>
    <td valign=top><formwidget id="data_dismissione">
	<formerror  id="data_dismissione"><br>
          <span class="errori">@formerror.data_dismissione;noquote@</span>
	</formerror>
    </td>
    </tr>
    
    <tr>
      <td valign=top align=right class=form_title>Fabbricante</td>
      <td valign=top><formwidget id="fabbricante">
          <formerror  id="fabbricante"><br>
            <span class="errori">@formerror.fabbricante;noquote@</span>
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
      <td valign=top align=right class=form_title>Numero di vie</td>
      <td valign=top><formwidget id="numero_vie">
	  <formerror  id="numero_vie"><br>
            <span class="errori">@formerror.numero_vie;noquote@</span>
	  </formerror>
      </td>
      <td valign=top align=right class=form_title>Servomotore</td>
      <td valign=top><formwidget id="servomotore">
	  <formerror id="servomotore"><br>
	    <span class="errori">@formerror.servomotore;noquote@</span>
	  </formerror>
      </td>
    </tr>
    <tr><td>&nbsp;</td></tr>
    
    <if @funzione@ ne "V">
      <tr><td colspan=4 align=center><formwidget id="submit"></td></tr>
    </if>
    
  </table>
  
</formtemplate>
<p>
</center>

