<master   src="../master">
<property name="title">@page_title;noquote@</property>
<property name="context_bar">@context_bar;noquote@</property>


<center>
<formtemplate id="@form_name;noquote@">
<formwidget   id="funzione">
<formwidget   id="caller">
<formwidget   id="nome_funz">
<formwidget   id="f_cod_comune">

<!-- Inizio della form colorata -->
<%=[iter_form_iniz]%>

<if @flag_ente@ eq P>
    <tr>
        <td valign=top align=right class=form_title>Comune</td>
        <td valign=top colspan=3><formwidget id="comune">@link_comune;noquote@
            <formerror  id="comune"><br>
            <span class="errori">@formerror.comune;noquote@</span>
            </formerror>
        </td>
    </tr>
</if>

<tr><td valign=top align=right class=form_title>Causale pagamento</td>
    <td valign=top colspan=1><formwidget id="f_id_caus">
        <formerror  id="f_id_caus"><br>
        <span class="errori">@formerror.f_id_caus;noquote@</span>
        </formerror>
    </td>
</tr>

<tr>
    <td valign=top align=right class=form_title>Importo minimo</td>
    <td valign=top><formwidget id="f_importo">
        <formerror id="f_importo"><br>
        <span class="errori">@formerror.f_importo;noquote@</span>
        </formerror>
    </td>
</tr>

<tr>
    <td valign=top align=right class=form_title>Data limite scadenza</td>
    <td valign=top><formwidget id="f_data_scadenza">
        <formerror id="f_data_scadenza"><br>
        <span class="errori">@formerror.f_data_scadenza;noquote@</span>
        </formerror>
    </td>
</tr>

<tr>
    <td valign=top align=right class=form_title width=40%>Tipo Documento</td>
    <td valign=top align=left><formwidget id="id_stampa">
    <formerror  id="id_stampa"><br>
        <span class="errori">@formerror.id_stampa;noquote@</span>
    </formerror>
    </td>
</tr>

<tr>
    <td valign=top align=right class=form_title>Ristampa (0=prima stampa)</td>
    <td valign=top><formwidget id="f_contatore">
        <formerror id="f_contatore"><br>
        <span class="errori">@formerror.f_contatore;noquote@</span>
        </formerror>
    </td>
</tr>

<tr><td colspan=2>&nbsp;</td></tr>

<tr><td colspan=4 align=center><formwidget id="submit"></td></tr>

<!-- Fine della form colorata -->
<%=[iter_form_fine]%>

</formtemplate>
<p>
</center>

