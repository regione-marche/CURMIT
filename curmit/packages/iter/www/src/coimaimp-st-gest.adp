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
<formwidget   id="url_aimp">
<formwidget   id="url_list_aimp">
<formwidget   id="scaduto">
<formwidget   id="desc_conf">
<if @funzione@ ne M>
    <formwidget   id="cod_potenza">
</if>
 
<if @flag_assegnazione@ ne t>
@link_tab;noquote@
</if>
@dett_tab;noquote@
<table width="100%" cellspacing=0  class=func-menu>
<tr>
   <if @flag_assegnazione@ ne t>
          <td width="25%" nowrap class=@func_v;noquote@>
             <a href="coimaimp-st-gest?funzione=V&@link_gest;noquote@" class=@func_v;noquote@>Visualizza</a>
          </td>
          <td width="75%" class=func-menu>&nbsp;</td>
</if>
<else>
          <td width="25%" nowrap class=func-menu>
              <a href="coimmai2-filter?&@link_mai2;noquote@" class=func-menu>Ritorna</a>
          </td>
          <td width="75%" class=func-menu>&nbsp;</td>
</else>
</tr>
</table>

<table>
<tr>
    <td valign=top width="1%" align=right class=form_title>Cod. impianto</td>
    <td valign=top width="1%"><formwidget id="cod_impianto_est">
        <formerror  id="cod_impianto_est"><br>
        <span class="errori">@formerror.cod_impianto_est;noquote@</span>
        </formerror>
    </td>
    <td valign=top width="1%" align=right class=form_title>@imp_provenienza;noquote@</td>
    <td valign=top width="1%"><formwidget id="cod_impianto_est_prov">
        <formerror  id="cod_impianto_est_prov"><br>
        <span class="errori">@formerror.cod_impianto_est_prov;noquote@</span>
        </formerror>
    </td>

    <td valign=top width="1%" align=right nowrap class=form_title>N&deg; generatori</td>
    <td valign=top width="1%"><formwidget id="n_generatori">
        <formerror  id="n_generatori"><br>       
        <span class="errori">@formerror.n_generatori;noquote@</span>
        </formerror>
    </td>
</tr>

<tr>
    <td valign=top align=right class=form_title>Combustibile</td>
    <td valign=top><formwidget id="cod_combustibile">
        <formerror  id="cod_combustibile"><br>
        <span class="errori">@formerror.cod_combustibile;noquote@</span>
        </formerror>
    </td>
    <td valign=top align=right nowrap class=form_title>Cons. annuo(m<sup><small>3</small></sup>/kg)</small></td>
    <td valign=top><formwidget id="consumo_annuo">
        <formerror  id="consumo_annuo"><br>
        <span class="errori">@formerror.consumo_annuo;noquote@</span>
        </formerror>
    </td>
    <td valign=top align=right class=form_title>Proven. dati</td>
    <td valign=top><formwidget id="provenienza_dati">
        <formerror  id="provenienza_dati"><br>
        <span class="errori">@formerror.provenienza_dati;noquote@</span>
        </formerror>
    </td>

</tr>

<tr>
    <td valign=top align=right class=form_title nowrap>Pot. foc. nom.</td>
    <td valign=top><formwidget id="potenza">(kW)
        <formerror  id="potenza"><br>
        <span class="errori">@formerror.potenza;noquote@</span>
        </formerror>
    </td>
    <td valign=top align=right class=form_title>Fascia</td>
    <if @funzione@ ne M>
       <td valign=top width="1%" colspan=3><formwidget id="descr_potenza">
    </if>
    <else>
       <td valign=top width="1%" colspan=3><formwidget id="cod_potenza">
    </else>
</tr>
<tr>
    <td valign=top align=right class=form_title nowrap>Pot. utile nom.</td>
    <td valign=top><formwidget id="potenza_utile">(kW)
        <formerror  id="potenza_utile"><br>
        <span class="errori">@formerror.potenza_utile;noquote@</span>
        </formerror>
    </td>
    <td valign=top nowrap align=right class=form_title>@dpr412;noquote@</td>
    <td valign=top colspan=3 width="1%"><formwidget id="flag_dpr412">
        <formerror  id="flag_dpr412"><br>
        <span class="errori">@formerror.flag_dpr412;noquote@</span>
        </formerror>
    </td>
</tr>

<tr>
    <td valign=top align=right class=form_title nowrap>Portata</td>
    <td valign=top><formwidget id="portata">(m<small><sup>3</sup></small>/h)/(kg/h)
        <formerror  id="portata"><br>
        <span class="errori">@formerror.portata;noquote@</span>
        </formerror>
    </td>
    <td valign=top align=right nowrap class=form_title>@desc_conf;noquote@</td>
    <td valign=top><formwidget id="stato_conformita">
        <formerror  id="stato_conformita"><br>
        <span class="errori">@formerror.stato_conformita;noquote@</span>
        </formerror>
    </td>
    <td colspan=2>&nbsp;</td>
</tr>

<tr>
    <td valign=top align=right nowrap class=form_title>Tipologia</td>
    <td valign=top><formwidget id="cod_tpim">
        <formerror  id="cod_tpim"><br>
        <span class="errori">@formerror.cod_tpim;noquote@</span>
        </formerror>
    </td>
    <td valign=top align=right nowrap class=form_title>Tariffa</td>
    <td valign=top width="1%" colspan=3><formwidget id="tariffa">
        <formerror  id="tariffa"><br>
        <span class="errori">@formerror.tariffa;noquote@</span>
        </formerror>
    </td>
</tr>

<tr>
    <td valign=top align=right nowrap class=form_title>Cat. edificio</td>
    <td valign=top width="1%"><formwidget id="cod_cted">
        <formerror  id="cod_cted"><br>
        <span class="errori">@formerror.cod_cted;noquote@</span>
        </formerror>
    </td>
    <td valign=top align=right nowrap class=form_title>Edificio adibito a:</td>
    <td valign=top colspan="3"><formwidget id="adibito_a">
        <formerror  id="adibito_a"><br>
        <span class="errori">@formerror.adibito_a;noquote@</span>
        </formerror>
    </td>
</tr>
<tr>
    <td valign="top" align="right" nowrap class="form_title">Tipo Attivit&agrave;</td>
    <td colspan="5" valign="top"><formwidget id="cod_tipo_attivita">
        <formerror id="cod_tipo_attivita">br>
	<span class="errori">@formerror.adibito_a;noquote@</span>
	</formerror>
    </td>
</tr>

<tr>
    <td valign=top align=right class=form_title>Data costruzione</td>
    <td valign=top><formwidget id="anno_costruzione">
        <formerror  id="anno_costruzione"><br>
        <span class="errori">@formerror.anno_costruzione;noquote@</span>
        </formerror>
    </td>
    <td valign=top align=right class=form_title>Marcatura efficienza energetica</td>
    <td valign=top><formwidget id="marc_effic_energ">
        <formerror  id="marc_effic_energ"><br>
        <span class="errori">@formerror.marc_effic_energ;noquote@</span>
        </formerror>
    </td>
    <td valign=top align=right class=form_title>Volumetria riscaldata m<sup><small>3</small></sup></td>
    <td valign=top><formwidget id="volimetria_risc">
        <formerror  id="volimetria_risc"><br>
        <span class="errori">@formerror.volimetria_risc;noquote@</span>
        </formerror>
    </td>
</tr>

<tr>
    <td valign=top align=right class=form_title>Data install.</td>
    <td valign=top><formwidget id="data_installaz">
        <formerror  id="data_installaz"><br>
        <span class="errori">@formerror.data_installaz;noquote@</span>
        </formerror>
    </td>
    <td valign=top align=right class=form_title>Data rottam.</td>
    <td valign=top><formwidget id="data_rottamaz">
        <formerror  id="data_rottamaz"><br>
        <span class="errori">@formerror.data_rottamaz;noquote@</span>
        </formerror>
    </td>
    <td valign=top align=right class=form_title>Data attivaz.</td>
    <td valign=top><formwidget id="data_attivaz">
        <formerror  id="data_attivaz"><br>
        <span class="errori">@formerror.data_attivaz;noquote@</span>
        </formerror>
    </td>
</tr>

<tr>
     <td valign=top align=right class=form_title>Dichiarato</td>
     <td valign=top nowrap><formwidget id="flag_dichiarato">@scaduto;noquote@
        <formerror  id="flag_dichiarato"><br>
        <span class="errori">@formerror.flag_dichiarato;noquote@</span>
        </formerror>
     </td>
     
     <td valign=top align=right class=form_title>Data prima dich.</td>
     <td valign=top nowrap><formwidget id="data_prima_dich">
        <formerror  id="data_prima_dich"><br>
        <span class="errori">@formerror.data_prima_dich;noquote@</span>
        </formerror>
     </td>
     <td valign=top align=right class=form_title>Data ult. dich.</td>
     <td valign=top nowrap><formwidget id="data_ultim_dich">
        <formerror  id="data_ultim_dich"><br>
        <span class="errori">@formerror.data_ultim_dich;noquote@</span>
        </formerror>
     </td>
</tr>
<tr>
    <td valign=top align=right class=form_title>Stato</td>
    <td colspan="3" valign=top><table width=100%><tr>
        <td valign=top width=14% bgcolor=@color;noquote@ bordercolor=000000>&nbsp;</td>
        <td valign=top width=80%><formwidget id="stato">
             <formerror  id="stato"><br>
             <span class="errori">@formerror.stato;noquote@</span>
             </formerror>
        </td>
    </tr></table></td>
     <td valign=top align=right class=form_title>Data scad. dich.</td>
     <td valign=top nowrap><formwidget id="data_scad_dich">
        <formerror  id="data_scad_dich"><br>
        <span class="errori">@formerror.data_scad_dich;noquote@</span>
        </formerror>
     </td>
</tr>

<tr>
    <td valign=top align=right class=form_title>Note</td>
    <td valign=top width="1%" colspan=3><formwidget id="note">
        <formerror  id="note"><br>
        <span class="errori">@formerror.note;noquote@</span>
        </formerror>
    </td>
    <td valign="top" align="right" class="form_title">Etichetta Stampa</td>
    <td valign="top"><formwidget id="flag_targa_stampata">
    </td>
</tr>

<if @funzione@ ne "V">
<tr>
    <td colspan=8 align=center><formwidget id="submit"></td>
</tr>
</if>

<!-- Fine della form colorata -->
</table>

</formtemplate>
<p>
</center>

