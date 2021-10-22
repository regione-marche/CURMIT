<!--
    USER  DATA       MODIFICHE
    ===== ========== ===========================================================================================
    rom01 06/11/2018 Su richiesta della regione Marche rinominati diversi campi, cambiata 
    rom01            impaginazione e aggiunti titoli.
    rom01            Aggiunti i campi: tratt_acqua_raff_filtraz_note_altro, tratt_acqua_raff_tratt_note_altro,
    rom01            tratt_acqua_raff_cond_note_altro.
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
<formwidget   id="last_cod_impianto">
<formwidget   id="cod_impianto">
<formwidget   id="data_fin_valid">
<formwidget   id="url_list_aimp">
<formwidget   id="url_aimp">
<formwidget   id="dummy">

@link_tab;noquote@
@dett_tab;noquote@
<table width="100%" cellspacing=0  class=func-menu>
<tr>
   <if @funzione@ eq "I">
      <td width="75%" nowrap class=func-menu>&nbsp;</td>
   </if>
   <else>
      <td width="25%" nowrap class=@func_v;noquote@>
         <a href="coimaimp-tratt-acqua-gest?funzione=V&@link_gest;noquote@" class=@func_v;noquote@>Visualizza</a>
      </td>
      <td width="25%" nowrap class=@func_m;noquote@>
         <a href="coimaimp-tratt-acqua-gest?funzione=M&@link_gest;noquote@" class=@func_m;noquote@>Modifica</a>
      </td>
   </else>
</tr>
</table>


<%=[iter_form_iniz]%>
<!-- Inizio della form colorata -->
<tr>
<td>
<table>
<tr>
<td colspan=6 align=center>
<table width="80%"><!-- rom01 aggiunta table e contenuto-->
  <tr><td class="func-menu-yellow2" align="center"><b>2.1, 2.2, 2.3, 2.4 - Trattamento acqua</b></td></tr>
  <tr><td>&nbsp;</td></tr>
</table>
</td>
</tr>
<tr>
  <td valign=top align=right class=form_title>Contenuto d'acqua dell'impianto<br>di climatizzazione (m&#179;)</td>
  <td valign=top>
      <formwidget id="tratt_acqua_contenuto">
      <formerror  id="tratt_acqua_contenuto"><br>
      <span class="errori">@formerror.tratt_acqua_contenuto;noquote@</span>
      </formerror>
  </td>
  <td valign=top align=right class=form_title>Durezza totale dell'acqua (°fr)</td>
  <td valign=top>
      <formwidget id="tratt_acqua_durezza">
      <formerror  id="tratt_acqua_durezza"><br>
      <span class="errori">@formerror.tratt_acqua_durezza;noquote@</span>
      </formerror>
  </td>
  <td>
    </td>
      <td>
          </td>
</tr>
<tr>
  <td valign=top align=right class=form_title>Trattamento dell'acqua<br>dell'impianto di climatizzazione</td>
  <td valign=top>
      <formwidget id="tratt_acqua_clima_tipo">
      <formerror  id="tratt_acqua_clima_tipo"><br>
      <span class="errori">@formerror.tratt_acqua_clima_tipo;noquote@</span>
      </formerror>
  </td>
  <td valign=top align=right class=form_title>Durezza totale all'uscita<br>dell'addolcitore (°fr)</td>
  <td valign=top>
      <formwidget id="tratt_acqua_clima_addolc">
      <formerror  id="tratt_acqua_clima_addolc"><br>
      <span class="errori">@formerror.tratt_acqua_clima_addolc;noquote@</span>
      </formerror>
  </td>
  <td>
  </td>
  <td>
    </td>
</tr>
<tr>
  <td valign=top align=right class=form_title rowspan=2>Protezione del gelo</td>
  <td valign=top rowspan=2>
      <formwidget id="tratt_acqua_clima_prot_gelo">
      <formerror  id="tratt_acqua_clima_prot_gelo"><br>
      <span class="errori">@formerror.tratt_acqua_clima_prot_gelo;noquote@</span>
      </formerror>
  </td>
  <td valign=top align=right class=form_title>Concentrazione glic. etilenico<br>nel fluido termovettore (%)</td>
  <td valign=top>
      <formwidget id="tratt_acqua_clima_prot_gelo_eti_perc">
      <formerror  id="tratt_acqua_clima_prot_gelo_eti_perc"><br>
      <span class="errori">@formerror.tratt_acqua_clima_prot_gelo_eti_perc;noquote@</span>
      </formerror>
  </td>
  <td valign=top align=right class=form_title>Concentrazione glic. etilenico<br>nel fluido termovettore (pH)</td>
  <td valign=top>
      <formwidget id="tratt_acqua_clima_prot_gelo_eti">
      <formerror  id="tratt_acqua_clima_prot_gelo_eti"><br>
      <span class="errori">@formerror.tratt_acqua_clima_prot_gelo_eti;noquote@</span>
      </formerror>
  </td>
</tr>
<tr>
  <td valign=top align=right class=form_title>Concentrazione glic. propilenico<br>nel fluido termovettore (%)</td>
  <td valign=top>
      <formwidget id="tratt_acqua_clima_prot_gelo_pro_perc">
      <formerror  id="tratt_acqua_clima_prot_gelo_pro_perc"><br>
      <span class="errori">@formerror.tratt_acqua_clima_prot_gelo_pro_perc;noquote@</span>
      </formerror>
  </td>
  <td valign=top align=right class=form_title>Concentrazione glic. propilenico<br>nel fluido termovettore (pH)</td>
  <td valign=top>
      <formwidget id="tratt_acqua_clima_prot_gelo_pro">
      <formerror  id="tratt_acqua_clima_prot_gelo_pro"><br>
      <span class="errori">@formerror.tratt_acqua_clima_prot_gelo_pro;noquote@</span>
      </formerror>
  </td>
</tr>
<tr>
  <td valign=top align=right class=form_title>Trattamento dell'acqua calda sanitaria</td>
  <td valign=top>
      <formwidget id="tratt_acqua_calda_sanit_tipo">
      <formerror  id="tratt_acqua_calda_sanit_tipo"><br>
      <span class="errori">@formerror.tratt_acqua_calda_sanit_tipo;noquote@</span>
      </formerror>
  </td>
  <td valign=top align=right class=form_title>Durezza totale all'uscita<br> dell'addolcitore (°fr)</td>
  <td valign=top>
      <formwidget id="tratt_acqua_calda_sanit_addolc">
      <formerror  id="tratt_acqua_calda_sanit_addolc"><br>
      <span class="errori">@formerror.tratt_acqua_calda_sanit_addolc;noquote@</span>
      </formerror>
  </td>
  <td>
  </td>
  <td>
    </td>
</tr>
<tr><td>&nbsp;</td></tr>
<tr>
<td colspan=6 align=center>
<table width="80%"><!-- rom01 aggiunta table e contenuto-->
  <tr><td class="func-menu-yellow2" align="center"><b>2.5 - Acqua di raffreddamento dell'impianto di climatizzazione estiva</b></td></tr>
  <tr><td>&nbsp;</td></tr>
</table>
</td>
</tr>
  <tr>
    <td valign=top align=right class=form_title>Tipologia circuito<br>di raffreddamento</td>
    <td valign=top>
      <formwidget id="tratt_acqua_raff_tipo_circuito">
	<formerror  id="tratt_acqua_raff_tipo_circuito"><br>
	  <span class="errori">@formerror.tratt_acqua_raff_tipo_circuito;noquote@</span>
	</formerror>
    </td>
    <td valign=top align=right class=form_title>Origine acqua di alimento</td>
    <td valign=top>
      <formwidget id="tratt_acqua_raff_origine">
	<formerror  id="tratt_acqua_raff_origine"><br>
	  <span class="errori">@formerror.tratt_acqua_raff_origine;noquote@</span>
	</formerror>
    </td>
    <td valign=top align=right class=form_title>Trattamento acqua raffreddamento<br>imp. climatizzazione estiva assente</td>
    <td valign=top>
      <formwidget id="tratt_acqua_raff_assente">
	<formerror  id="tratt_acqua_raff_assente"><br>
	  <span class="errori">@formerror.tratt_acqua_raff_assente;noquote@</span>
	</formerror>
    </td>
  </tr>
  <tr><!--rom01 tr e contenuto-->
    <td valign="top" align="right" class="form_title"><b>Trattamenti acqua esistenti:</b></td>
  </tr>
  <tr>
    <td valign=top align=right class=form_title rowspan=2>Filtrazione</td>
    <td valign=top rowspan=2>
      <formwidget id="tratt_acqua_raff_filtraz_flag">
	<formerror  id="tratt_acqua_raff_filtraz_flag"><br>
	  <span class="errori">@formerror.tratt_acqua_raff_filtraz_flag;noquote@</span>
	</formerror>
    </td>
    <td valign=top align=right class=form_title>Filtrazione di sicurezza</td>
    <td valign=top>
      <formwidget id="tratt_acqua_raff_filtraz_1">
	<formerror  id="tratt_acqua_raff_filtraz_1"><br>
	  <span class="errori">@formerror.tratt_acqua_raff_filtraz_1;noquote@</span>
	</formerror>
    </td>
    <td valign=top align=right class=form_title>Filtrazione a masse</td>
    <td valign=top>
      <formwidget id="tratt_acqua_raff_filtraz_2">
	<formerror  id="tratt_acqua_raff_filtraz_2"><br>
	  <span class="errori">@formerror.tratt_acqua_raff_filtraz_2;noquote@</span>
	</formerror>
    </td>
  </tr>
  <tr>
  <td valign=top align=right class=form_title>Altro</td>
  <td valign=top>
      <formwidget id="tratt_acqua_raff_filtraz_3">
	<formerror  id="tratt_acqua_raff_filtraz_3"><br>
      <span class="errori">@formerror.tratt_acqua_raff_filtraz_3;noquote@</span>
	</formerror>
  </td>
  <td valign=top align=right class=form_title>Nessun trattamento</td>
  <td valign=top>
    <formwidget id="tratt_acqua_raff_filtraz_4">
      <formerror  id="tratt_acqua_raff_filtraz_4"><br>
      <span class="errori">@formerror.tratt_acqua_raff_filtraz_4;noquote@</span>
      </formerror>
  </td>
  </tr>
  <tr><!--rom01 aggiunta tr e contenuto-->
    <td colspan="3" valign="top" align="right" class="form_title">Note Altro</td>
    <td colspan="3" valign="top" align="left">
      <formwidget id="tratt_acqua_raff_filtraz_note_altro">
	<formerror  id="tratt_acqua_raff_filtraz_note_altro"><br>
	  <span class="errori">@formerror.tratt_acqua_raff_filtraz_note_altro;noquote@</span>
	</formerror>
    </td>
  </tr>
    <tr><td colspan="6">&nbsp;</td></tr><!--rom01-->
  <tr>
    <td valign=top align=right class=form_title rowspan=3>Trattamento acqua</td>
    <td valign=top rowspan=3>
      <formwidget id="tratt_acqua_raff_tratt_flag">
	<formerror  id="tratt_acqua_raff_tratt_flag"><br>
	  <span class="errori">@formerror.tratt_acqua_raff_tratt_flag;noquote@</span>
      </formerror>
    </td>
    <td valign=top align=right class=form_title>Addolcimento</td>
    <td valign=top>
      <formwidget id="tratt_acqua_raff_tratt_1">
	<formerror  id="tratt_acqua_raff_tratt_1"><br>
	  <span class="errori">@formerror.tratt_acqua_raff_tratt_1;noquote@</span>
	</formerror>
    </td>
    <td valign=top align=right class=form_title>Osmosi inversa</td>
    <td valign=top>
      <formwidget id="tratt_acqua_raff_tratt_2">
	<formerror  id="tratt_acqua_raff_tratt_2"><br>
	  <span class="errori">@formerror.tratt_acqua_raff_tratt_2;noquote@</span>
	</formerror>
    </td>
  </tr>
  <tr>
    <td valign=top align=right class=form_title>Demineralizzazione</td>
    <td valign=top>
      <formwidget id="tratt_acqua_raff_tratt_3">
	<formerror  id="tratt_acqua_raff_tratt_3"><br>
	  <span class="errori">@formerror.tratt_acqua_raff_tratt_3;noquote@</span>
	</formerror>
    </td>
    <td valign=top align=right class=form_title>Nessun trattamento</td>
    <td valign=top>
      <formwidget id="tratt_acqua_raff_tratt_5">
	<formerror  id="tratt_acqua_raff_tratt_5"><br>
	  <span class="errori">@formerror.tratt_acqua_raff_tratt_5;noquote@</span>
	</formerror>
    </td>
  </tr>
  <tr>
    <td valign=top align=right class=form_title>Altro</td>
    <td valign=top colspan=3>
      <formwidget id="tratt_acqua_raff_tratt_4">
	<formerror  id="tratt_acqua_raff_tratt_4"><br>
	  <span class="errori">@formerror.tratt_acqua_raff_tratt_4;noquote@</span>
	</formerror>
    </td>
  </tr>
  <tr><!--rom01 aggiunta tr e contenuto-->
    <td colspan="3" valign="top" align="right" class="form_title">Note Altro</td>
    <td colspan="3" valign="top" align="left">
      <formwidget id="tratt_acqua_raff_tratt_note_altro">
	<formerror  id="tratt_acqua_raff_tratt_note_altro"><br>
	  <span class="errori">@formerror.tratt_acqua_raff_tratt_note_altro;noquote@</span>
	</formerror>
    </td>
  </tr>
    <tr><td colspan="6">&nbsp;</td></tr><!--rom01-->
  <tr>
    <td valign=top align=right class=form_title rowspan=3>Condizionamento chimico</td>
    <td valign=top rowspan=3>
      <formwidget id="tratt_acqua_raff_cond_flag">
	<formerror  id="tratt_acqua_raff_cond_flag"><br>
	  <span class="errori">@formerror.tratt_acqua_raff_cond_flag;noquote@</span>
	</formerror>
    </td>
    <td valign=top align=right class=form_title>Azione antincrostante</td>
    <td valign=top>
      <formwidget id="tratt_acqua_raff_cond_1">
	<formerror  id="tratt_acqua_raff_cond_1"><br>
	  <span class="errori">@formerror.tratt_acqua_raff_cond_1;noquote@</span>
	</formerror>
    </td>
    <td valign=top align=right class=form_title>Azione anticorrosiva</td>
  <td valign=top>
    <formwidget id="tratt_acqua_raff_cond_2">
      <formerror  id="tratt_acqua_raff_cond_2"><br>
	<span class="errori">@formerror.tratt_acqua_raff_cond_2;noquote@</span>
      </formerror>
  </td>
  </tr>
  <tr>
    <td valign=top align=right class=form_title>Azione antincrostante e<br> anticorrosiva</td>
    <td valign=top>
      <formwidget id="tratt_acqua_raff_cond_3">
      <formerror  id="tratt_acqua_raff_cond_3"><br>
	<span class="errori">@formerror.tratt_acqua_raff_cond_3;noquote@</span>
      </formerror>
    </td>
    <td valign=top align=right class=form_title>Biocida</td>
    <td valign=top>
      <formwidget id="tratt_acqua_raff_cond_4">
      <formerror  id="tratt_acqua_raff_cond_4"><br>
	<span class="errori">@formerror.tratt_acqua_raff_cond_4;noquote@</span>
      </formerror>
    </td>
  </tr>
  <tr>
    <td valign=top align=right class=form_title>Altro</td>
    <td valign=top>
      <formwidget id="tratt_acqua_raff_cond_5">
	<formerror  id="tratt_acqua_raff_cond_5"><br>
	  <span class="errori">@formerror.tratt_acqua_raff_cond_5;noquote@</span>
	</formerror>
    </td>
    <td valign=top align=right class=form_title>Nessun trattamento</td>
    <td valign=top>
      <formwidget id="tratt_acqua_raff_cond_6">
	<formerror  id="tratt_acqua_raff_cond_6"><br>
	  <span class="errori">@formerror.tratt_acqua_raff_cond_6;noquote@</span>
	</formerror>
    </td>
  </tr>
  <tr><!--rom01 aggiunta tr e contenuto-->
    <td colspan="3" valign="top" align="right" class="form_title">Note Altro</td>
    <td colspan="3" valign="top" align="left">
      <formwidget id="tratt_acqua_raff_cond_note_altro">
	<formerror  id="tratt_acqua_raff_cond_note_altro"><br>
	  <span class="errori">@formerror.tratt_acqua_raff_cond_note_altro;noquote@</span>
	</formerror>
    </td>
  </tr>
      <tr><td colspan="6">&nbsp;</td></tr><!--rom01-->
  <tr><!--rom01 tr e contenuto-->
    <td valign="top" align="right" class="form_title"><b>Gestione torre di raffreddamento:</b></td>
  </tr>
  <tr>
    <td valign=top align=right class=form_title>Presenza sistema spurgo automatico</td>
    <td valign=top>
      <formwidget id="tratt_acqua_raff_spurgo_flag">
	<formerror  id="tratt_acqua_raff_spurgo_flag"><br>
	  <span class="errori">@formerror.tratt_acqua_raff_spurgo_flag;noquote@</span>
	</formerror>
    </td>
    <td valign=top align=right class=form_title>Conducibilit&agrave;<br> acqua in ingresso (&#181;S/cm)</td>
    <td valign=top>
      <formwidget id="tratt_acqua_raff_spurgo_cond_ing">
	<formerror  id="tratt_acqua_raff_spurgo_cond_ing"><br>
	  <span class="errori">@formerror.tratt_acqua_raff_spurgo_cond_ing;noquote@</span>
	</formerror>
    </td>
    <td valign=top align=right class=form_title>Taratura valore conducibilit&agrave;<br> inizio spurgo (&#181;S/cm)</td>
    <td valign=top>
      <formwidget id="tratt_acqua_raff_spurgo_tara_cond">
	<formerror  id="tratt_acqua_raff_spurgo_tara_cond"><br>
	  <span class="errori">@formerror.tratt_acqua_raff_spurgo_tara_cond;noquote@</span>
	</formerror>
    </td>
  <tr>
</table></td>
<tr><td colspan=6>&nbsp;</td></tr>
<if @funzione@ ne "V">
  <tr>
    <td colspan=6 align=center><formwidget id="submit"></td>
  </tr>
</if>

<!-- Fine della form colorata -->
<%=[iter_form_fine]%>

</formtemplate>
<p>
</center>

