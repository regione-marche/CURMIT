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
<formwidget   id="cod_inco">
<formwidget   id="cod_impianto">
<formwidget   id="url_list_aimp">
<formwidget   id="url_aimp">
<formwidget   id="f_tipo_data">
<formwidget   id="f_data">
<formwidget   id="f_cod_impianto">
<formwidget   id="f_tipo_estrazione">
<formwidget   id="f_anno_inst_da">
<formwidget   id="f_anno_inst_a">
<formwidget   id="f_cod_comb">
<formwidget   id="f_cod_enve">
<formwidget   id="f_cod_tecn">
<formwidget   id="f_cod_comune">
<formwidget   id="f_descr_topo">
<formwidget   id="f_descr_via">
<formwidget   id="f_cod_via">
<formwidget   id="f_num_max">
<formwidget   id="f_cod_area">
<formwidget   id="f_flag_pericolosita">
<formwidget   id="f_esito_verifica">   
<formwidget   id="f_da_potenza">       
<formwidget   id="f_a_potenza">        
<formwidget   id="f_cod_tano">         
<formwidget   id="f_da_data_controllo">
<formwidget   id="f_a_data_controllo"> 
@link_inco;noquote@
@dett_tab;noquote@

<!-- Inizio della form colorata -->
<%=[iter_form_iniz]%>

<tr><td valign=top align=right class=form_title>Tipo Protocollo</td>
    <td valign=top nowrap><formwidget id="id_protocollo">
	<formerror  id="id_protocollo"><br>
        <span class="errori">@formerror.id_protocollo;noquote@</span>
        </formerror>
    </td>
    <td valign=top align=right class=form_title>Data protocollo</td>
    <td valign=top nowrap><formwidget id="protocollo_dt">
	<formerror  id="protocollo_dt"><br>
        <span class="errori">@formerror.protocollo_dt;noquote@</span>
        </formerror>
    </td>
</tr>

<if @campo5@ ne "">
<tr><td valign=top align=right class=form_title>@campo1;noquote@</td>
    <td valign=top><formwidget id="@campo1_testo;noquote@">
        <formerror  id="@campo1_testo;noquote@"></formerror>
    </td>
    <td valign=top align=right class=form_title>@campo2;noquote@</td>
    <td valign=top><formwidget id="@campo2_testo;noquote@">
        <formerror  id="@campo2_testo;noquote@"></formerror>
    </td>
</tr>
<tr><td valign=top align=right class=form_title>@campo3;noquote@</td>
    <td valign=top><formwidget id="@campo3_testo;noquote@">
        <formerror  id="@campo3_testo;noquote@"></formerror>
    </td>
    <td valign=top align=right class=form_title>@campo4;noquote@</td>
    <td valign=top><formwidget id="@campo4_testo;noquote@">
        <formerror  id="@campo4_testo;noquote@"></formerror>
    </td>
</tr>
<tr><td valign=top align=right class=form_title>@campo5;noquote@</td>
    <td valign=top colspan=3><formwidget id="@campo5_testo;noquote@">
        <formerror  id="@campo5_testo;noquote@"></formerror>
    </td>
</tr>
</if>
<else>
<if @campo4@ ne "">
<tr><td valign=top align=right class=form_title>@campo1;noquote@</td>
    <td valign=top><formwidget id="@campo1_testo;noquote@">
        <formerror  id="@campo1_testo;noquote@"></formerror>
    </td>
    <td valign=top align=right class=form_title>@campo2;noquote@</td>
    <td valign=top><formwidget id="@campo2_testo;noquote@">
        <formerror  id="@campo2_testo;noquote@"></formerror>
    </td>
</tr>
<tr><td valign=top align=right class=form_title>@campo3;noquote@</td>
    <td valign=top><formwidget id="@campo3_testo;noquote@">
        <formerror  id="@campo3_testo;noquote@"></formerror>
    </td>
    <td valign=top align=right class=form_title>@campo4;noquote@</td>
    <td valign=top><formwidget id="@campo4_testo;noquote@">
        <formerror  id="@campo4_testo;noquote@"></formerror>
    </td>
</tr>
</if>
<else>
<if @campo3@ ne "">
<tr><td valign=top align=right class=form_title>@campo1;noquote@</td>
    <td valign=top><formwidget id="@campo1_testo;noquote@">
        <formerror  id="@campo1_testo;noquote@"></formerror>
    </td>
    <td valign=top align=right class=form_title>@campo2;noquote@</td>
    <td valign=top><formwidget id="@campo2_testo;noquote@">
        <formerror  id="@campo2_testo;noquote@"></formerror>
    </td>
</tr>
<tr><td valign=top align=right class=form_title>@campo3;noquote@</td>
    <td valign=top colspan=3><formwidget id="@campo3_testo;noquote@">
        <formerror  id="@campo3_testo;noquote@"></formerror>
    </td>
</tr>
</if>
<else>
<if @campo2@ ne "">
<tr><td valign=top align=right class=form_title>@campo1;noquote@</td>
    <td valign=top><formwidget id="@campo1_testo;noquote@">
        <formerror  id="@campo1_testo;noquote@"></formerror>
    </td>
    <td valign=top align=right class=form_title>@campo2;noquote@</td>
    <td valign=top><formwidget id="@campo2_testo;noquote@">
        <formerror  id="@campo2_testo;noquote@"></formerror>
    </td>
</tr>
</if>
<else>
<if @campo1@ ne "">
<tr><td valign=top align=right class=form_title>@campo1;noquote@</td>
    <td valign=top colspan=3><formwidget id="@campo1_testo;noquote@">
        <formerror  id="@campo1_testo;noquote@"></formerror>
    </td>
</tr>
</if>
<if @var_testo@ eq "S">
<tr><td valign=top align=right class=form_title>Nota</td>
    <td valign=top colspan=3><formwidget id="nota">
        <formerror  id="nota"></formerror>
    </td>
</tr>
</if>
</else> 
</else> 
</else> 
</else>

<tr><td valign=top align=right class=form_title>Stampa in formato</td>
    <td valign=top colspan=3>
        <table>
        <formgroup id="swc_formato">
           <tr><td>@formgroup.widget;noquote@ @formgroup.label;noquote@</td></tr>
        </formgroup>
           <tr>
               <td colspan=2>
               <formerror  id="swc_formato">
               <span class="errori">@formerror.swc_formato;noquote@</span>
               </formerror>
               </td>
            </tr>
        </table>
    </td>
</tr>

<tr><td colspan=4 align=center><formwidget id="submit"></td></tr>

<!-- Fine della form colorata -->
<%=[iter_form_fine]%>

</formtemplate>
<p>
</center>

