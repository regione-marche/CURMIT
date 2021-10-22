<master   src="../master">
<property name="title">@page_title;noquote@</property>
<property name="context_bar">@context_bar;noquote@</property>

<center>
<formtemplate id="@form_name;noquote@">
<formwidget   id="funzione">
<formwidget   id="caller">
<formwidget   id="nome_funz">
<formwidget   id="nome_funz_caller">
<formwidget   id="dummy">
<formwidget   id="f_cod_via">
<if @flag_ente@ eq C>
   <formwidget id="f_cod_comune">
</if>

<table width=100% cellspacing=0 class=func-menu>
<tr>
   <td width="25%" class=func-menu>&nbsp;</td>
   <td width="50%" class=func-menu align=center>Campagna: <b>@desc_camp;noquote@</b></td>
   <td width="25%" class=func-menu>&nbsp;</td>
</tr>
</table>

<br>
<!-- Inizio della form colorata -->
<%=[iter_form_iniz]%>

<!-- dpr74 -->
<tr><td valign=top align=right class=form_title>Tipoologia impianti</td>
    <td valign=top colspan=2 nowrap><formwidget id="flag_tipo_impianto">
        <formerror id="flag_tipo_impianto"><br>
        <span class="errori">@formerror.flag_tipo_impianto;noquote@</span>
        </formerror>
    </td>
</tr>
<!-- dpr74 -->
<tr><td valign=top align=right class=form_title>Cod. impianto</td>
    <td valign=top colspan=3><formwidget id="f_cod_impianto">
        <formerror  id="f_cod_impianto"><br>
        <span class="errori">@formerror.f_cod_impianto;noquote@</span>
        </formerror>
    </td>
</tr>

<tr><td valign=top nowrap align=right class=form_title>Da Anno installazione</td>
    <td valign=top width="17%"><formwidget id="f_anno_inst_da">
        <formerror  id="f_anno_inst_da"><br>
        <span class="errori">@formerror.f_anno_inst_da;noquote@</span>
        </formerror>
    </td>
    <td valign=top width="15%" nowrap align=right class=form_title>Ad Anno installazione</td>
    <td valign=top><formwidget id="f_anno_inst_a">
        <formerror  id="f_anno_inst_a"><br>
        <span class="errori">@formerror.f_anno_inst_a;noquote@</span>
        </formerror>
    </td>
</tr>




<tr><td valign=top align=right class=form_title>Combustibile</td>
    <td valign=top colspan=3><formwidget id="f_cod_comb">
        <formerror  id="f_cod_comb"><br>
        <span class="errori">@formerror.f_cod_comb;noquote@</span>
        </formerror>
    </td>
</tr>

<tr><td valign=top align=right class=form_title>Ente Verificatore</td>
    <td valign=top colspan=3><formwidget id="f_cod_enve">
        <formerror  id="f_cod_enve"><br>
        <span class="errori">@formerror.f_cod_enve;noquote@</span>
        </formerror>
    </td>
</tr>
<tr>
    <td valign=top align=right class=form_title>Tecnico assegnato</td>
    <td valign=top colspan=3><formwidget id="f_cog_tecn">
                             <formwidget id="f_nom_tecn">@cerca_opve;noquote@
        <formerror  id="f_cog_tecn"><br>
        <span class="errori">@formerror.f_cog_tecn;noquote@</span>
        </formerror>
</tr>

<if @flag_ente@ eq "P">
    <tr><td valign=top align=right class=form_title>Comune</td>
       <td valign=top colspan=3><formwidget id="f_cod_comune">
           <formerror  id="f_cod_comune"><br>
           <span class="errori">@formerror.f_cod_comune;noquote@</span>
           </formerror>
       </td>
   </tr>
</if>

<tr><td valign=top align=right class=form_title>Indirizzo</td>
    <td valign=top colspan=3><formwidget id="f_descr_topo">
                             <formwidget id="f_descr_via">@cerca_viae;noquote@
        <formerror  id="f_descr_via"><br>
        <span class="errori">@formerror.f_descr_via;noquote@</span>
        </formerror>
    </td>
</tr>

<tr><td valign=top nowrap align=right class=form_title>Da data controllo</td>
    <td valign=top width="17%"><formwidget id="f_da_data_controllo">
        <formerror  id="f_da_data_controllo"><br>
        <span class="errori">@formerror.f_da_data_controllo;noquote@</span>
        </formerror>
    </td>
    <td valign=top width="15%" nowrap align=right class=form_title>A data controllo</td>
    <td valign=top><formwidget id="f_a_data_controllo">
        <formerror  id="f_a_data_controllo"><br>
        <span class="errori">@formerror.f_a_data_controllo;noquote@</span>
        </formerror>
    </td>
</tr>


<tr><td valign=top align=right class=form_title>Pericolosita </td>
    <td valign=top colspan=3><formwidget id="f_flag_pericolosita">
        <formerror  id="f_flag_pericolosita"><br>
        <span class="errori">@formerror.f_flag_pericolosita;noquote@</span>
        </formerror>
    </td>
</tr>
<tr><td valign=top align=right class=form_title>Esito verifica </td>
    <td valign=top colspan=3><formwidget id="f_esito_verifica">
        <formerror  id="f_esito_verifica"><br>
        <span class="errori">@formerror.f_esito_verifica;noquote@</span>
        </formerror>
    </td>
</tr>

<tr><td valign=top nowrap align=right class=form_title>Da potenza</td>
    <td valign=top width="17%"><formwidget id="f_da_potenza">
        <formerror  id="f_da_potenza"><br>
        <span class="errori">@formerror.f_da_potenza;noquote@</span>
        </formerror>
    </td>
    <td valign=top width="15%" nowrap align=right class=form_title>A potenza</td>
    <td valign=top><formwidget id="f_a_potenza">
        <formerror  id="f_a_potenza"><br>
        <span class="errori">@formerror.f_a_potenza;noquote@</span>
        </formerror>
    </td>
</tr>

<tr><td valign=top align=right class=form_title>Presente anomalia </td>
    <td valign=top colspan=3><formwidget id="f_cod_tano">
        <formerror  id="f_cod_tano"><br>
        <span class="errori">@formerror.f_cod_tano;noquote@</span>
        </formerror>
    </td>
</tr>


<if @flag_avvisi@ eq S>
    <tr><td valign=top align=right class=form_title>Tipo documento</td>
        <td valign=top colspan=3><formwidget id="id_stampa">
            <formerror  id="id_stampa"><br>
            <span class="errori">@formerror.id_stampa;noquote@</span>
            </formerror>
        </td>
    </tr>
</if>

<tr><td colspan=4>&nbsp;</td></tr>

<tr><td colspan=4 align=center><formwidget id="submit"></td></tr>

<!-- Fine della form colorata -->
<%=[iter_form_fine]%>

</formtemplate>
<p>
</center>

