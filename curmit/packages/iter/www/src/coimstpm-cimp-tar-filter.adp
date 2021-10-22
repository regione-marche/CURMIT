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
<formwidget   id="dummy">
<formwidget   id="f_cod_tecn">
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

<tr><td valign=top align=right class=form_title>Da data controllo</td>
    <td valign=top><formwidget id="f_data_da">
        <formerror  id="f_data_da"><br>
        <span class="errori">@formerror.f_data_da;noquote@</span>
        </formerror>
    </td>
</tr>


<tr>
    <td valign=top align=right class=form_title>A data controllo</td>
    <td valign=top nowrap><formwidget id="f_data_a">
        <formerror  id="f_data_a"><br>
        <span class="errori">@formerror.f_data_a;noquote@</span>
        </formerror>
    </td>
</tr>

<tr><td valign=top align=right class=form_title>Ente Verificatore</td>
    <td valign=top><formwidget id="f_cod_enve">
        <formerror  id="f_cod_enve"><br>
        <span class="errori">@formerror.f_cod_enve;noquote@</span>
        </formerror>
    </td>
</tr>
<tr>
    <td valign=top nowrap align=right class=form_title>Tecnico assegnato</td>
    <td valign=top colspan=3><formwidget id="f_cog_tecn">
        <formwidget id="f_nom_tecn">@cerca_opve;noquote@
        <formerror  id="f_cog_tecn"><br>
        <span class="errori">@formerror.f_cog_tecn;noquote@</span>
        </formerror>
    </td>
</tr>

<tr><td valign=top align=right class=form_title>Da costo verifica</td>
    <td valign=top><formwidget id="f_costo_da">
        <formerror  id="f_costo_da"><br>
        <span class="errori">@formerror.f_costo_da;noquote@</span>
        </formerror>
    </td>
</tr>

<tr>
    <td valign=top align=right class=form_title>A costo verifica</td>
    <td valign=top nowrap><formwidget id="f_costo_a">
        <formerror  id="f_costo_a"><br>
        <span class="errori">@formerror.f_costo_a;noquote@</span>
        </formerror>
    </td>
</tr>

<if @flag_ente@ ne C>
<tr>
    <td valign=top align=right class=form_title>Comune</td>
    <td valign=top nowrap><formwidget id="f_cod_comune">
        <formerror  id="f_cod_comune"><br>
        <span class="errori">@formerror.f_cod_comune;noquote@</span>
        </formerror>
    </td>
</tr>
</if>

<tr><td colspan=2>&nbsp;</td></tr>

<if @funzione@ eq "V">
    <tr><td colspan=4 align=center><formwidget id="submit"></td></tr>
</if>

<!-- Fine della form colorata -->
<%=[iter_form_fine]%>

</formtemplate>
<p>
</center>

