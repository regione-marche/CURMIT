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
<formwidget   id="last_gen_prog">
<formwidget   id="cod_impianto">
<formwidget   id="gen_prog">
<formwidget   id="url_list_aimp">


@link_tab;noquote@
@dett_tab;noquote@
<table width="100%" cellspacing=0 class=func-menu>
<tr>
<td width="25%" nowrap class=@func_i;noquote@>
  <a href="coimgend-gest?funzione=I&@link_gest;noquote@" class=@func_i;noquote@>Nuovo Gen.</a>
</td>
<if @funzione@ ne I>
<td width="25%" nowrap class=@func_v;noquote@>
  <a href="coimgend-gest?funzione=V&@link_gest;noquote@" class=@func_v;noquote@>Visualizza</a>
</td>
<td width="25%" nowrap class=@func_m;noquote@>
  <a href="coimgend-gest?funzione=M&@link_gest;noquote@" class=@func_m;noquote@>Modifica</a>
</td>
<td width="25%" nowrap class=@func_d;noquote@>
  <a href="coimgend-gest?funzione=D&@link_gest;noquote@" class=@func_d;noquote@>Cancella</a>
</td>
</if>
<else>
       <td width="25%" nowrap class=func-menu>Visualizza</td>
       <td width="25%" nowrap class=func-menu>Modifica</td>
       <td width="25%" nowrap class=func-menu>Cancella</td>
</else>
</tr>
</table>

<table>
<tr><td valign=top align=right class=form_title>Numero</td>
    <td valign=top><formwidget id="gen_prog_est">
        <formerror  id="gen_prog_est"><br>
        <span class="errori">@formerror.gen_prog_est;noquote@</span>
        </formerror>
    </td>
    <td valign=top align=right class=form_title>Descrizione</td>
    <td valign=top colspan=3><formwidget id="descrizione">
        <formerror  id="descrizione"><br>
        <span class="errori">@formerror.descrizione;noquote@</span>
        </formerror>
    </td>
</tr>

<tr><td valign=top align=right class=form_title>Matricola</td>
    <td valign=top><formwidget id="matricola">
        <formerror  id="matricola"><br>
        <span class="errori">@formerror.matricola;noquote@</span>
        </formerror>
    </td>
    <td valign=top align=right class=form_title>Modello</td>
    <td valign=top><formwidget id="modello">
        <formerror  id="modello"><br>
        <span class="errori">@formerror.modello;noquote@</span>
        </formerror>
    </td>
    <td valign=top align=right class=form_title>Costruttore</td>
    <td valign=top><formwidget id="cod_cost">
        <formerror  id="cod_cost"><br>
        <span class="errori">@formerror.cod_cost;noquote@</span>
        </formerror>
    </td>
</tr>

<tr><td valign=top align=right class=form_title>Attivo</td>
    <td valign=top><formwidget id="flag_attivo">
        <formerror  id="flag_attivo"><br>
        <span class="errori">@formerror.flag_attivo;noquote@</span>
        </formerror>
    </td>
    <td valign=top align=right class=form_title>Marcatura efficienza energetica</td>
    <td valign=top><formwidget id="marc_effic_energ">
        <formerror  id="marc_effic_energ"><br>
        <span class="errori">@formerror.marc_effic_energ;noquote@</span>
        </formerror>
    </td>
    <td valign=top align=right class=form_title nowrap>Campo di funzionamento(kW): da</td>
    <td valign=top nowrap>
        <formwidget id="campo_funzion_min">
      a <formwidget id="campo_funzion_max">
        <formerror  id="campo_funzion_max"><br>
        <span class="errori">@formerror.campo_funzion_max;noquote@</span>
        </formerror>
        <formerror  id="campo_funzion_min"><br>
        <span class="errori">@formerror.campo_funzion_min;noquote@</span>
        </formerror>
    </td>
</tr>
<tr>
    <td valign=top align=right class=form_title>Data costruzione</td>
    <td valign=top><formwidget id="data_costruz_gen">
        <formerror  id="data_costruz_gen"><br>
        <span class="errori">@formerror.data_costruz_gen;noquote@</span>
        </formerror>
    </td>
    <td valign=top align=right class=form_title>Data install</td>
    <td valign=top><formwidget id="data_installaz">
        <formerror  id="data_installaz"><br>
        <span class="errori">@formerror.data_installaz;noquote@</span>
        </formerror>
    </td>
    <td valign=top align=right nowrap class=form_title>Data rottamazione</td>
    <td valign=top><formwidget id="data_rottamaz">
        <formerror  id="data_rottamaz"><br>
        <span class="errori">@formerror.data_rottamaz;noquote@</span>
        </formerror>
    </td>
</tr>

<tr><td valign=top align=right class=form_title>Combustibile</td>
    <td valign=top><formwidget id="cod_combustibile">
        <formerror  id="cod_combustibile"><br>
        <span class="errori">@formerror.cod_combustibile;noquote@</span>
        </formerror>
    </td>
    <td valign=top align=right class=form_title>Scarico fumi</td>
    <td valign=top><formwidget id="cod_emissione">
        <formerror  id="cod_emissione"><br>
        <span class="errori">@formerror.cod_emissione;noquote@</span>
        </formerror>
    </td>
    <td valign=top align=right nowrap class=form_title>Tipo locale</td>
    <td valign=top><formwidget id="locale">
        <formerror  id="locale"><br>
        <span class="errori">@formerror.locale;noquote@</span>
        </formerror>
    </td>
</tr>

<tr><td valign=top align=right class=form_title>Dest. d'uso</td>
    <td valign=top colspan=3><formwidget id="cod_utgi">
        <formerror  id="cod_utgi"><br>
        <span class="errori">@formerror.cod_utgi;noquote@</span>
        </formerror>
    </td>
    <td valign=top align=right class=form_title>Fluido termovettore</td>
    <td valign=top><formwidget id="mod_funz">
        <formerror  id="mod_funz"><br>
        <span class="errori">@formerror.mod_funz;noquote@</span>
        </formerror>
    </td>
</tr>
<tr>
    <td valign=top colspan=3 align=right class=form_title>Classificazione DPR 660/96</td>
    <td valign=top><formwidget id="dpr_660_96">
        <formerror  id="dpr_660_96"><br>
        <span class="errori">@formerror.dpr_660_96;noquote@</span>
        </formerror>
    </td>
</tr>
<tr><td valign=top align=right nowrap class=form_title>Bruciatore</td>
    <td valign=top><formwidget id="tipo_bruciatore">
        <formerror  id="tipo_bruciatore"><br>
        <span class="errori">@formerror.tipo_bruciatore;noquote@</span>
        </formerror>
    </td>
    <td valign=top align=right nowrap class=form_title>Tipo generatore</td>
    <td valign=top><formwidget id="tipo_foco">
        <formerror  id="tipo_foco"><br>
        <span class="errori">@formerror.tipo_foco;noquote@</span>
        </formerror>
    </td>
    <td valign=top align=right nowrap class=form_title>Tiraggio</td>
    <td valign=top><formwidget id="tiraggio">
        <formerror  id="tiraggio"><br>
        <span class="errori">@formerror.tiraggio;noquote@</span>
        </formerror>
    </td>
</tr>

<tr><td valign=top align=right class=form_title>Matric. bruc.</td>
    <td valign=top><formwidget id="matricola_bruc">
        <formerror  id="matricola_bruc"><br>
        <span class="errori">@formerror.matricola_bruc;noquote@</span>
        </formerror>
    </td>
    <td valign=top align=right class=form_title>Modello bruc.</td>
    <td valign=top><formwidget id="modello_bruc">
        <formerror  id="modello_bruc"><br>
        <span class="errori">@formerror.modello_bruc;noquote@</span>
        </formerror>
    </td>
    <td valign=top align=right class=form_title>Costr. bruc.</td>
    <td valign=top><formwidget id="cod_cost_bruc">
        <formerror  id="cod_cost_bruc"><br>
        <span class="errori">@formerror.cod_cost_bruc;noquote@</span>
        </formerror>
    </td>
</tr>

<tr><td valign=top align=right class=form_title>Data costruzione bruc.</td>
    <td valign=top><formwidget id="data_costruz_bruc">
        <formerror  id="data_costruz_bruc"><br>
        <span class="errori">@formerror.data_costruz_bruc;noquote@</span>
        </formerror>
    </td>
    <td valign=top align=right class=form_title>Data install. bruc.</td>
    <td valign=top><formwidget id="data_installaz_bruc">
        <formerror  id="data_installaz_bruc"><br>
        <span class="errori">@formerror.data_installaz_bruc;noquote@</span>
        </formerror>
    </td>
    <td valign=top align=right class=form_title>Data rottamaz. bruc.</td>
    <td valign=top><formwidget id="data_rottamaz_bruc">
        <formerror  id="data_rottamaz_bruc"><br>
        <span class="errori">@formerror.data_rottamaz_bruc;noquote@</span>
        </formerror>
    </td>
</tr>

<tr><td colspan=4><table>
<tr><td valign=top  nowrap align=left class=form_title>Potenza a libretto: &nbsp; focolare (kW)</td>
    <td valign=top><formwidget id="pot_focolare_lib">
        <formerror  id="pot_focolare_lib"><br>
        <span class="errori">@formerror.pot_focolare_lib;noquote@</span>
        </formerror>
    </td>
    <td valign=top align=right class=form_title>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;</td>
    <td valign=top align=right class=form_title>utile (kW)</td>
    <td valign=top><formwidget id="pot_utile_lib">
        <formerror  id="pot_utile_lib"><br>
        <span class="errori">@formerror.pot_utile_lib;noquote@</span>
        </formerror>
    </td>
</tr>
</table></td></tr>

<tr><td colspan=4><table>
<tr><td valign=top nowrap align=left class=form_title>Potenza nominale: &nbsp; focolare (kW)</td>
    <td valign=top><formwidget id="pot_focolare_nom">
        <formerror  id="pot_focolare_nom"><br>
        <span class="errori">@formerror.pot_focolare_nom;noquote@</span>
        </formerror>
    </td>
    <td valign=top align=right class=form_title>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; </td>
    <td valign=top align=right class=form_title>utile (kW)</td>
    <td valign=top><formwidget id="pot_utile_nom">
        <formerror  id="pot_utile_nom"><br>
        <span class="errori">@formerror.pot_utile_nom;noquote@</span>
        </formerror>
    </td>
</tr>
</table></td></tr>

<tr><td valign=top align=right class=form_title>Note</td>
    <td valign=top colspan=6><formwidget id="note">
        <formerror  id="note"><br>
        <span class="errori">@formerror.note;noquote@</span>
        </formerror>
    </td>
</tr>

<if @funzione@ ne "V">
    <tr><td colspan=7 align=center><formwidget id="submit"></td></tr>
</if>

</table>
</formtemplate>
<p>
</center>

