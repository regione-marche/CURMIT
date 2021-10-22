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


<!-- dpr74 -->
<tr><td valign=top align=right class=form_title>Tipoologia impianti</td>
    <td valign=top colspan=2 nowrap><formwidget id="flag_tipo_impianto">
        <formerror id="flag_tipo_impianto"><br>
        <span class="errori">@formerror.flag_tipo_impianto;noquote@</span>
        </formerror>
    </td>
</tr>
<!-- dpr74 -->


<tr><td valign=top align=right class=form_title>Manutentore</td>
     <td valign=top colspan=3><formwidget id="cod_manutentore">
         <formerror  id="cod_manutentore"><br>
         <span class="errori">@formerror.cod_manutentore;noquote@</span>
         </formerror>
     </td>
 </tr>

<tr><td valign=top align=right class=form_title>Comune</td>
    <td valign=top colspan=3><formwidget id="cod_comune">
        <formerror  id="cod_comune"><br>
        <span class="errori">@formerror.cod_comune;noquote@</span>
        </formerror>
    </td>
</tr>
<tr><td valign=top align=right class=form_title>Da data controllo</td>
    <td valign=top colspan=1><formwidget id="da_data_app">
        <formerror  id="da_data_app"><br>
        <span class="errori">@formerror.da_data_app;noquote@</span>
        </formerror>
    </td>
    <td valign=top align=right class=form_title>A data controllo</td>
    <td valign=top colspan=1><formwidget id="a_data_app">
        <formerror  id="a_data_app"><br>
        <span class="errori">@formerror.a_data_app;noquote@</span>
        </formerror>
    </td>
</tr>


<tr><td colspan=2>&nbsp;</td></tr>

<tr><td colspan=4 align=center><formwidget id="submit"><formwidget id="submit1"></td></tr>

<!-- Fine della form colorata -->
<%=[iter_form_fine]%>

</formtemplate>
<p>
</center>

