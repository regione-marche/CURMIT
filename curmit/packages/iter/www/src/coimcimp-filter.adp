<master   src="../master">
<property name="title">@page_title;noquote@</property>
<property name="context_bar">@context_bar;noquote@</property>

<center>
<formtemplate id="@form_name;noquote@">
<formwidget   id="funzione">
<formwidget   id="caller">
<formwidget   id="nome_funz">
<formwidget   id="dummy">
<formwidget   id="f_cod_tecn">
<formwidget   id="f_cod_via">
<if @flag_cod_enve@ eq t>
    <formwidget id="f_cod_enve">
</if>

<if @flag_ente@ eq C>
   <formwidget id="f_cod_comune">
</if>



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
  

<tr><td valign=top nowrap align=right class=form_title width="30%">Numero verbale</td>
    <td valign=top width="15%"><formwidget id="f_verb_n">
        <formerror  id="f_verb_n"><br>
        <span class="errori">@formerror.f_verb_n;noquote@</span>
        </formerror>
    </td>
</tr>

<tr><td valign=top nowrap align=right class=form_title width="30%">Da Data controllo</td>
    <td valign=top width="15%"><formwidget id="f_data_controllo_da">
        <formerror  id="f_data_controllo_da"><br>
        <span class="errori">@formerror.f_data_controllo_da;noquote@</span>
        </formerror>
    </td>
    <td valign=top nowrap align=right class=form_title width="20%">A Data controllo</td>
    <td valign=top width="45%"><formwidget id="f_data_controllo_a">
        <formerror  id="f_data_controllo_a"><br>
        <span class="errori">@formerror.f_data_controllo_a;noquote@</span>
        </formerror>
    </td>
</tr>

<tr><td valign=top nowrap align=right class=form_title width="30%">Da Anno installazione</td>
    <td valign=top width="15%"><formwidget id="f_anno_inst_da">
        <formerror  id="f_anno_inst_da"><br>
        <span class="errori">@formerror.f_anno_inst_da;noquote@</span>
        </formerror>
    </td>
    <td valign=top nowrap align=right class=form_title width="20%">A Anno installazione</td>
    <td valign=top width="40%"><formwidget id="f_anno_inst_a">
        <formerror  id="f_anno_inst_a"><br>
        <span class="errori">@formerror.f_anno_inst_a;noquote@</span>
        </formerror>
    </td>
</tr>

<tr><td valign=top nowrap align=right class=form_title>Combustibile</td>
    <td valign=top colspan=3><formwidget id="f_cod_comb">
        <formerror  id="f_cod_comb"><br>
        <span class="errori">@formerror.f_cod_comb;noquote@</span>
        </formerror>
    </td>
</tr>
<if @flag_cod_tecn@ ne t and @flag_cod_enve@ ne t>
    <tr><td valign=top align=right class=form_title>Ente Verificatore</td>
        <td valign=top colspan=3><formwidget id="f_cod_enve">
            <formerror  id="f_cod_enve"><br>
            <span class="errori">@formerror.f_cod_enve;noquote@</span>
            </formerror>
        </td>
    </tr>
</if>
<else>
    <tr><td valign=top align=right class=form_title>Ente Verificatore</td>
        <td valign=top colspan=3><formwidget id="desc_enve"></td>
    </tr>
</else>
<tr>
    <td valign=top nowrap align=right class=form_title>Tecnico assegnato</td>
    <td valign=top colspan=3><formwidget id="f_cog_tecn">
        <formwidget id="f_nom_tecn">@cerca_opve;noquote@
        <formerror  id="f_cog_tecn"><br>
        <span class="errori">@formerror.f_cog_tecn;noquote@</span>
        </formerror>
    </td>
</tr>

<if @flag_ente@ eq P>
    <tr><td valign=top nowrap align=right class=form_title>Comune</td>
       <td valign=top colspan=3><formwidget id="f_cod_comune">
           <formerror  id="f_cod_comune"><br>
           <span class="errori">@formerror.f_cod_comune;noquote@</span>
           </formerror>
       </td>
   </tr>
</if>

<tr><td valign=top nowrap align=right class=form_title>Indirizzo</td>
    <td valign=top colspan=3><formwidget id="f_descr_topo">
       <formwidget id="f_descr_via">@cerca_viae;noquote@
       <formerror  id="f_descr_via"><br>
       <span class="errori">@formerror.f_descr_via;noquote@</span>
       </formerror>
   </td>
</tr>


<tr><td colspan=4>&nbsp;</td></tr>

<tr><td colspan=4 align=center><formwidget id="submit"></td></tr>

<!-- Fine della form colorata -->
<%=[iter_form_fine]%>

</formtemplate>
<p>
</center>

