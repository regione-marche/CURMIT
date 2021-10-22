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
<formwidget   id="f_cod_tecn">
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
<tr>
    <td valign=top align=right class=form_title>Data </td>
    <td valign=top colspan=3><formwidget id="f_tipo_data">
                             <formwidget id="f_data">
        <formerror  id="f_data"><br>
        <span class="errori">@formerror.f_data;noquote@</span>
        </formerror>
    </td>
</tr>

<tr><td valign=top align=right class=form_title>Cod. impianto</td>
    <td valign=top colspan=3><formwidget id="f_cod_impianto">
        <formerror  id="f_cod_impianto"><br>
        <span class="errori">@formerror.f_cod_impianto;noquote@</span>
        </formerror>
    </td>
</tr>

<tr><td valign=top align=right class=form_title>Tipo estrazione</td>
    <td valign=top colspan=3><formwidget id="f_tipo_estrazione">
        <formerror  id="f_tipo_estrazione"><br>
        <span class="errori">@formerror.f_tipo_estrazione;noquote@</span>
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
<tr><td>&nbsp</td></tr>
<tr><td valign=top align=right class=form_title>Ente Verificatore da assegnare</td>
    <td valign=top colspan=3><formwidget id="f_cod_enve">
        <formerror  id="f_cod_enve"><br>
        <span class="errori">@formerror.f_cod_enve;noquote@</span>
        </formerror>
    </td>
</tr>
<tr>
    <td valign=top align=right class=form_title>Tecnico da assegnare</td>
    <td valign=top colspan=3><formwidget id="f_cog_tecn">
                             <formwidget id="f_nom_tecn">@cerca_opve;noquote@
        <formerror  id="f_cog_tecn"><br>
        <span class="errori">@formerror.f_cog_tecn;noquote@</span>
        </formerror>
</tr>

<tr><td valign=top nowrap align=right class=form_title>Numero</td>
    <td valign=top width="17%"><formwidget id="f_numero">
        <formerror  id="f_numero"><br>
        <span class="errori">@formerror.f_numero;noquote@</span>
        </formerror>
     </td>
</tr>


<tr><td colspan=4>&nbsp;</td></tr>

<tr><td colspan=4 align=center><formwidget id="submit"><formwidget id="submit2"></td></tr>


<!-- Fine della form colorata -->
<%=[iter_form_fine]%>

</formtemplate>
<p>
</center>

