<master   src="../master">
<property name="title">@page_title;noquote@</property>
<property name="context_bar">@context_bar;noquote@</property>

<center>
<formtemplate id="@form_name;noquote@">
<formwidget   id="funzione">
<formwidget   id="caller">
<formwidget   id="nome_funz">
<formwidget   id="nome_funz_caller">


<!-- Inizio della form colorata -->
<%=[iter_form_iniz]%>

<!--rom01 tolto campo f_prot-->
<tr>
    <td valign=top align=right class=form_title></td>
    <td valign=top colspan=1 nowrap>&nbsp;
    </td>
</tr>
<tr>
    <td valign=top align=right class=form_title>Da Data pagamento</td>
    <td valign=top colspan=1 nowrap><formwidget id="f_data_pag_da">
        <formerror  id="f_data_pag_da"><br>
        <span class="errori">@formerror.f_data_pag_da;noquote@</span>
        </formerror>
    </td>
    <td valign=top align=right class=form_title>A Data pagamento</td>
    <td valign=top colspan=1 nowrap><formwidget id="f_data_pag_a">
        <formerror  id="f_data_pag_a"><br>
        <span class="errori">@formerror.f_data_pag_a;noquote@</span>
        </formerror>
    </td>
</tr>

<tr>
    <td valign=top align=right class=form_title>Da Data scadenza</td>
    <td valign=top colspan=1 nowrap><formwidget id="f_data_scad_da">
        <formerror  id="f_data_scad_da"><br>
        <span class="errori">@formerror.f_data_scad_da;noquote@</span>
        </formerror>
    </td>
    <td valign=top align=right class=form_title>A Data scadenza</td>
    <td valign=top colspan=1 nowrap><formwidget id="f_data_scad_a">
        <formerror  id="f_data_scad_a"><br>
        <span class="errori">@formerror.f_data_scad_a;noquote@</span>
        </formerror>
    </td>
</tr>

<tr>
    <td valign=top align=right class=form_title>Da Data competenza</td>
    <td valign=top colspan=1 nowrap><formwidget id="f_data_compet_da">
        <formerror  id="f_data_compet_da"><br>
        <span class="errori">@formerror.f_data_compet_da;noquote@</span>
        </formerror>
    </td>
    <td valign=top align=right class=form_title>A Data competenza</td>
    <td valign=top colspan=1 nowrap><formwidget id="f_data_compet_a">
        <formerror  id="f_data_compet_a"><br>
        <span class="errori">@formerror.f_data_compet_a;noquote@</span>
        </formerror>
    </td>
</tr>

<tr>
    <td valign=top align=right class=form_title>Da Importo</td>
    <td valign=top colspan=1 nowrap><formwidget id="f_importo_da">
        <formerror  id="f_importo_da"><br>
        <span class="errori">@formerror.f_importo_da;noquote@</span>
        </formerror>
    </td>
    <td valign=top align=right class=form_title>A Importo</td>
    <td valign=top colspan=1 nowrap><formwidget id="f_importo_a">
        <formerror  id="f_importo_a"><br>
        <span class="errori">@formerror.f_importo_a;noquote@</span>
        </formerror>
    </td>
</tr>

<tr>
    <td valign=top align=right class=form_title>Da Data Incasso</td>
    <td valign=top colspan=1 nowrap><formwidget id="f_data_incasso_da">
        <formerror  id="f_data_incasso_da"><br>
        <span class="errori">@formerror.f_data_incasso_da;noquote@</span>
        </formerror>
    </td>
    <td valign=top align=right class=form_title>A Data Incasso</td>
    <td valign=top colspan=1 nowrap><formwidget id="f_data_incasso_a">
        <formerror  id="f_data_incasso_a"><br>
        <span class="errori">@formerror.f_data_incasso_a;noquote@</span>
        </formerror>
    </td>
</tr>


<tr>
    <td valign=top align=right class=form_title>Causale Pagamento</td>
    <td valign=top colspan=3 nowrap><formwidget id="f_id_caus">
        <formerror  id="f_id_caus"><br>
        <span class="errori">@formerror.f_id_caus;noquote@</span>
        </formerror>
    </td>
</tr>
<tr> 
    <td valign=top align=right class=form_title>Tipo Pagamento</td>
    <td valign=top colspan=3 nowrap><formwidget id="f_tipo_pag">
        <formerror  id="f_tipo_pag"><br>
        <span class="errori">@formerror.f_tipo_pag;noquote@</span>
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

