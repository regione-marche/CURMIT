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
<formwidget   id="cod_manutentore">
<formwidget   id="url_list_aimp">


@link_tab;noquote@
@dett_tab;noquote@
<table width="100%" cellspacing=0 class=func-menu>
<tr>
<if @funzione@ ne I>
<td width="25%" nowrap class=@func_v;noquote@>
  <a href="coimnove-gest?funzione=V&@link_gest;noquote@" class=@func_v;noquote@>Visualizza</a>
</td>
<td width="25%" nowrap class=@func_m;noquote@>
  <a href="coimnove-gest?funzione=M&@link_gest;noquote@" class=@func_m;noquote@>Modifica</a>
</td>
<td width="25%" nowrap class=@func_d;noquote@>
  <a href="coimnove-gest?funzione=D&@link_gest;noquote@" class=@func_d;noquote@>Cancella</a>
</td>
</if>
<else>
       <td width="25%" nowrap class=func-menu>Visualizza</td>
       <td width="25%" nowrap class=func-menu>Modifica</td>
       <td width="25%" nowrap class=func-menu>Cancella</td>
</else>
<if @funzione@ eq V>
   <td width="25%" nowrap class=func-menu>
       <a href="coimnove-layout?@link_gest;noquote@" class=func-menu target="Stampa allegato IX">Stampa</a>
   </td>
</if>
<else>
   <td width="25%" nowrap class=func-menu>Stampa allegato IX</td>
</else>
</tr>
</table>

<table width="70%">
    <tr><td colspan=2>&nbsp;</td></tr>

    <tr><td valign=top align=left class=form_title>Progressivo:</td>
        <td valign=top align=left><formwidget id="cod_nove">
            <formerror  id="cod_nove"><br>
            <span class="errori">@formerror.cod_nove;noquote@</span>
            </formerror>
        </td>
    </tr>

    <tr><td valign=top align=left class=form_title nowrap>Data consegna:</td>
        <td valign=top align=left><formwidget id="data_consegna">
            <formerror  id="data_consegna"><br>
            <span class="errori">@formerror.data_consegna;noquote@</span>
            </formerror>
        </td>
    </tr>

    <tr><td valign=top align=left class=form_title>Luogo consegna:</td>
        <td valign=top><formwidget id="luogo_consegna">
    </tr>

    <tr>
        <td align=left class=form_title>Io sottoscritto</td>
        <td nowrap><formwidget id="cognome_manu"><formwidget id="nome_manu">@cerca_manu;noquote@ manutentore &nbsp;\&nbsp; @cerca_citt;noquote@ cittadino
           <formerror  id="cognome_manu"><br>
            <span class="errori">@formerror.cognome_manu;noquote@</span>
            </formerror>
        </td>
    </tr>

    <tr><td colspan=2>&nbsp;</td></tr>
    <tr><td align=left colspan=2>in possesso dei requisiti di cui</td></tr>
    <tr><td colspan=2>&nbsp;</td></tr>

    <tr><td align=left><formgroup id="flag_art_109">@formgroup.widget;noquote@</formgroup></td>
        <td align=left>all'articolo 109 del decreto del Presidente della Repubblica 6 giugno 2001, n. 380,</td>
    </tr>
    <tr><td align=left><formgroup id="flag_art_11">@formgroup.widget;noquote@</formgroup></td>
         <td align=left>all'articolo 11 del decreto del Presidente della Repubblica 26 agosto 1993, n. 412,</td>
    </tr>

    <tr><td colspan=2>&nbsp;</td></tr>
    <tr><td align=left colspan=2>dichiaro</td></tr>
    <tr><td colspan=2>&nbsp;</td></tr>

    <tr><td align=left><formgroup id="flag_installatore">@formgroup.widget;noquote@</formgroup></td>
        <td align=left>di aver installato un impianto termico civile</td>
    </tr>
    <tr><td align=left><formgroup id="flag_manutentore">@formgroup.widget;noquote@</formgroup></td>
        <td align=left>di essere responsabile dell'esercizio e della manutenzione di un impianto termico civile</td>
    </tr>
    <tr><td colspan=2>&nbsp;</td></tr>

   <tr><td colspan=2>Data installazione impianto: @data_installaz;noquote@</td></tr>

   <tr><td colspan=2><table width=100%>
    <tr><td valign=top align=left class=form_title width=30%><b>1. Potenza termica nominale dell'impianto (MW):</b></td>
        <td valign=top align=left width=20%><formwidget id="pot_termica_mw">
            <formerror  id="pot_termica_mw"><br>
            <span class="errori">@formerror.pot_termica_mw;noquote@</span>
            </formerror>
        </td>
	<if @funzione@ eq V>
            <td valign=top align=left><b>in kW: @pot_termica_kw;noquote@</b></td>
        </if>
        <else>
            <td valign=top align=left>&nbsp;</td>
        </else>
    </tr>

    <tr><td valign=top align=left class=form_title><b>2. Combustibili utilizzati</b></td>
        <td valign=top colspan=2><formwidget id="combustibili">
    </tr>

    <tr><td valign=top align=left class=form_title colspan=3><b>3.Focolari</b></td></tr>
    <tr><td valign=top align=left class=form_title>numero totale:</td>
        <td valign=top colspan=2><formwidget id="n_focolari">
            <formerror  id="n_focolari"><br>
            <span class="errori">@formerror.n_focolari;noquote@</span>
            </formerror>
        </td>
    </tr>

    <tr><td valign=top align=left class=form_title>potenza termica nominale di ogni singolo focolare (MW):</td>
        <td valign=top colspan=2><formwidget id="pot_focolari_mw">
    </tr>

    <tr><td valign=top align=left class=form_title colspan=3><b>4. Bruciatori e griglie mobili</b></td></tr>
    <tr><td valign=top align=left class=form_title>numero totale:</td>
        <td valign=top colspan=2><formwidget id="n_bruciatori">
            <formerror  id="n_bruciatori"><br>
            <span class="errori">@formerror.n_bruciatori;noquote@</span>
            </formerror>
        </td>
    </tr>

    <tr><td valign=top align=left class=form_title>potenzialit&agrave; e tipo del singolo dispositivo (MW):</td>
        <td valign=top colspan=2><formwidget id="pot_tipi_bruc">
    </tr>

    <tr><td valign=top align=left class=form_title>apparecchi accessori:</td>
        <td valign=top colspan=2><formwidget id="apparecchi_acc">
    </tr>

    <tr><td valign=top align=left class=form_title colspan=3><b>5. Canali da fumo</b></td></tr>
    <tr><td valign=top align=left class=form_title>numero totale:</td>
        <td valign=top colspan=2><formwidget id="n_canali_fumo">
            <formerror  id="n_canali_fumo"><br>
            <span class="errori">@formerror.n_canali_fumo;noquote@</span>
            </formerror>
        </td>
    </tr>

    <tr><td valign=top align=left class=form_title>sezione minima (m<snall><sup>2</sup></small>):</td>
        <td valign=top colspan=2><formwidget id="sez_min_canali">
            <formerror  id="sez_min_canali"><br>
            <span class="errori">@formerror.sez_min_canali;noquote@</span>
            </formerror>
        </td>
    </tr>

    <tr><td valign=top align=left class=form_title>sviluppo complessivo (m):</td>
        <td valign=top colspan=2><formwidget id="svil_totale">
            <formerror  id="svil_totale"><br>
            <span class="errori">@formerror.svil_totale;noquote@</span>
            </formerror>
        </td>
    </tr>

    <tr><td valign=top align=left class=form_title>aperture di ispezione:</td>
        <td valign=top colspan=2><formwidget id="aperture_ispez">
    </tr>

    <tr><td valign=top align=left class=form_title colspan=3><b>6. Camini</b></td></tr>
    <tr><td valign=top align=left class=form_title>numero totale:</td>
        <td valign=top colspan=2><formwidget id="n_camini">
            <formerror  id="n_camini"><br>
            <span class="errori">@formerror.n_camini;noquote@</span>
            </formerror>
        </td>
    </tr>

    <tr><td valign=top align=left class=form_title>sezioni minime (cm<snall><sup>2</sup></small>):</td>
        <td valign=top colspan=2><formwidget id="sez_min_camini">
            <formerror  id="sez_min_camini"><br>
            <span class="errori">@formerror.sez_min_camini;noquote@</span>
            </formerror>
        </td>
    </tr>

    <tr><td valign=top align=left class=form_title>altezze delle bocche in relazione agli ostacoli e alle strutture circostanti:</td>
        <td valign=top colspan=2><formwidget id="altezze_bocche">
    </tr>

    <tr><td valign=top align=left class=form_title><b>7. Durata del ciclo di vita dell'impianto</b></td>
        <td valign=top colspan=2><formwidget id="durata_impianto">
    </tr>

    <tr><td valign=top align=left class=form_title><b>8. Manutenzioni ordinarie</b> che devono essere effettuate per garantire il rispetto dei valori limite di emissione per l'intera durata del ciclo di vita dell'impianto:</td>
        <td valign=top colspan=2><formwidget id="manut_ordinarie">
    </tr>

    <tr><td valign=top align=left class=form_title><b>9. Manutenzioni straordinarie:</b> che devono essere effettuate per garantire il rispetto dei valori limite di emissione per l'intera durata del ciclo di vita dell'impianto:</td>
        <td valign=top colspan=2><formwidget id="manut_straord">
    </tr>

    <tr><td valign=top align=left class=form_title><b>10. varie</b></td>
        <td valign=top colspan=2><formwidget id="varie">
    </tr>
    </table></td></tr>

    <tr><td colspan=2>&nbsp;</td></tr>

    <tr><td valign=top align=left class=form_title>Firma</td>
        <td valign=top><formwidget id="firma">
    </tr>

    <tr><td valign=top align=left class=form_title>Data rilascio:</td>
        <td valign=top align=left><formwidget id="data_rilascio">
            <formerror  id="data_rilascio"><br>
            <span class="errori">@formerror.data_rilascio;noquote@</span>
            </formerror>
        </td>
    </tr>


    <tr><td valign=top align=left class=form_title nowrapwidth=10%>Consegnato:</td>
        <td valign=top align=left><formwidget id="flag_consegnato">
            <formerror  id="flag_consegnato"><br>
            <span class="errori">@formerror.flag_consegnato;noquote@</span>
            </formerror>
        </td>
    </tr>

    <tr><td colspan=2>&nbsp;</td></tr>

<if @funzione@ ne "V">
    <tr><td colspan=2 align=center><formwidget id="submit"></td></tr>
</if>

</table>
</formtemplate>
<p>
</center>

