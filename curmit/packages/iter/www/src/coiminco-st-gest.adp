<master   src="../master">
<property name="title">@page_title;noquote@</property>
<property name="context_bar">@context_bar;noquote@</property>
<property name="riga_vuota">f</property>

    <table width="100%" cellspacing=0 class=func-menu>
    <tr>
       <td width="25%" class=func-menu>
           <a href="coiminco-st-list?@link_list;noquote@" class=func-menu>Ritorna</a>
       </td>
       <td width="75%" class=func-menu>&nbsp;</td>
    </tr>
    </table>

<center>
<formtemplate id="@form_name;noquote@">
<formwidget   id="funzione">
<formwidget   id="caller">
<formwidget   id="nome_funz">
<formwidget   id="nome_funz_caller">
<formwidget   id="extra_par">
<formwidget   id="stato">
<formwidget   id="cod_opve">
<formwidget   id="cod_documento_01">
<formwidget   id="cod_documento_02">
<formwidget   id="flag_aimp">
<formwidget   id="cod_impianto">
<formwidget   id="url_aimp">
<formwidget   id="url_list_aimp">
<formwidget   id="last_cod_inco">
<formwidget   id="cod_cinc">
<formwidget   id="cod_opve_old">
<formwidget   id="data_verifica_old">
<formwidget   id="ora_verifica_old">
<formwidget   id="stato_old">

<!-- Inizio della form colorata -->
<%=[iter_form_iniz]%>

<tr><td valign=top nowrap align=right class=form_title>Codice appuntamento</td>
    <td valign=top><formwidget id="cod_inco">
        <formerror  id="cod_inco"><br>
        <span class="errori">@formerror.cod_inco;noquote@</span>
        </formerror>
    </td>

    <td valign=top nowrap align=right class=form_title>Campagna</td>
    <td valign=top><formwidget id="desc_camp">
        <formerror  id="desc_camp"><br>
        <span class="errori">@formerror.desc_camp;noquote@</span>
        </formerror>
    </td>
</tr>

<tr><td colspan=2>&nbsp;</td>
    <td valign=top nowrap align=right class=form_title>Stato appuntamento</td>
    <td valign=top><formwidget id="des_stato">
        <formerror  id="des_stato"><br>
        <span class="errori">@formerror.des_stato;noquote@</span>
        </formerror>
    </td>
</tr>

<tr><td valign=top nowrap align=right class=form_title>Data estrazione</td>
    <td valign=top><formwidget id="data_estrazione">
        <formerror  id="data_estrazione"><br>
        <span class="errori">@formerror.data_estrazione;noquote@</span>
        </formerror>
    </td>
    <td valign=top nowrap align=right class=form_title>Tipo estrazione</td>
    <td valign=top><formwidget id="tipo_estrazione">
        <formerror  id="tipo_estrazione"><br>
        <span class="errori">@formerror.tipo_estrazione;noquote@</span>
        </formerror>
    </td>
</tr>

<tr><td valign=top nowrap align=right class=form_title>Data assegnazione</td>
    <td valign=top><formwidget id="data_assegn">
        <formerror  id="data_assegn"><br>
        <span class="errori">@formerror.data_assegn;noquote@</span>
        </formerror>
    </td>
    <td colspan=2>&nbsp;</td>
</tr>
<tr>
    <td valign=top nowrap align=right class=form_title>Data appuntamento</td>
    <td valign=top><formwidget id="data_verifica">
        <formerror  id="data_verifica"><br>
        <span class="errori">@formerror.data_verifica;noquote@</span>
        </formerror>
    </td>
    <td valign=top nowrap align=right class=form_title>Ora appuntamento</td>
    <td valign=top><formwidget id="ora_verifica">
        <formerror  id="ora_verifica"><br>
        <span class="errori">@formerror.ora_verifica;noquote@</span>
        </formerror>
    </td>
</tr>

<tr>
    <td valign=top nowrap align=right class=form_title>Ente Verificatore</td>
    <td valign=top><formwidget id="cod_enve">
        <if @disabled_ace_enve@ eq "disabled">
            <formwidget id="desc_enve">
        </if>
        <formerror  id="cod_enve"><br>
        <span class="errori">@formerror.cod_enve;noquote@</span>
        </formerror>
    </td>
    <td valign=top nowrap align=right class=form_title>Tecnico assegnato</td>
    <td valign=top><formwidget id="cog_tecn">
        <formwidget id="nom_tecn">@cerca_opve;noquote@
        <formerror  id="cog_tecn"><br>
        <span class="errori">@formerror.cog_tecn;noquote@</span>
        </formerror>
    </td>
</tr>

<tr><td valign=top nowrap align=right class=form_title>Note</td>
    <td valign=top colspan=3><formwidget id="note">
        <formerror  id="note"><br>
        <span class="errori">@formerror.note;noquote@</span>
        </formerror>
    </td>
</tr>

<tr><td valign=top nowrap align=right class=form_title>Motivi annullamento</td>
    <td valign=top colspan=3><formwidget id="cod_noin">
        <formerror  id="cod_noin"><br>
        <span class="errori">@formerror.cod_noin;noquote@</span>
        </formerror>
    </td>
</tr>

<tr><td valign=top nowrap align=right class=form_title>Data avviso di ispezione</td>
    <td valign=top><formwidget id="data_avviso_01">
        <formerror  id="data_avviso_01"><br>
        <span class="errori">@formerror.data_avviso_01;noquote@</span>
        </formerror>
    </td>
    <td valign=top colspan=3 nowrap align=left class=form_title>@link_alle_stav;noquote@</td>
</tr>

<tr><td valign=top nowrap align=right class=form_title>Data stampa esito</td>
    <td valign=top><formwidget id="data_avviso_02">
        <formerror  id="data_avviso_02"><br>
        <span class="errori">@formerror.data_avviso_02;noquote@</span>
        </formerror>
    </td>
    <td valign=top colspan=3 nowrap align=left class=form_title>@link_alle_stev;noquote@</td>
</tr>

<if @flag_ente@ eq "P" and @sigla_prov@ eq "TN" and @funzione@ eq "V" and @stato@ eq "2">
<tr><td colspan=3>&nbsp;</td>
    <td colspan=1><table border bordercolor="#00008B" cellpadding=3 cellspacing=0>
                     <tr><td>Comune di @nome_comu;noquote@</td></tr>
                     <tr><td>Controlli effettivi: @conta_effettivi;noquote@
                         <br>Controlli di riserva: @conta_riserve;noquote@</td></tr>
                  </table>
    </td>
</tr>
</if>

<tr><td colspan=4>&nbsp;</td></tr>

<if @funzione@ ne "V">
    <tr><td colspan=4 align=center><formwidget id="submit"></td></tr>
</if>

<!-- Fine della form colorata -->
<%=[iter_form_fine]%>

</formtemplate>
<p>
</center>

