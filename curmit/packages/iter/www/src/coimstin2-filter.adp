<!--
    USER  DATA       MODIFICHE
    ===== ========== =======================================================================
    san01 21/07/2016 Aggiunto filtro da_data_ins e a data_ins.
-->

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

<tr>
   <td valign=top align=right class=form_title>Manutentore</td>
   <td valign=top><formwidget id="f_manu_cogn">
       <formwidget id="f_manu_nome">@cerca_manu;noquote@
       <formerror  id="f_manu_cogn"><br>
       <span class="errori">@formerror.f_manu_cogn;noquote@</span>
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
<tr><td valign=top align=right class=form_title>Presenti osservazioni</td>
    <td valign=top colspan=3><formwidget id="osserv">
        <formerror  id="osserv"><br>
        <span class="errori">@formerror.osserv;noquote@</span>
        </formerror>
    </td>
</tr>
<tr><td valign=top align=right class=form_title>Presenti prescrizioni</td>
    <td valign=top colspan=3><formwidget id="prescr">
        <formerror  id="prescr"><br>
        <span class="errori">@formerror.prescr;noquote@</span>
        </formerror>
    </td>
</tr>
<tr><td valign=top align=right class=form_title>Presenti raccomandazioni</td>
    <td valign=top colspan=3><formwidget id="raccom">
        <formerror  id="raccom"><br>
        <span class="errori">@formerror.raccom;noquote@</span>
        </formerror>
    </td>
</tr>

<tr><td valign=top align=right class=form_title>Impianto puo' Funzionare</td>
    <td valign=top colspan=3><formwidget id="funzionare">
        <formerror  id="funzionare"><br>
        <span class="errori">@formerror.funzionare;noquote@</span>
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

<tr><td valign=top align=right class=form_title>Da data inserimento</td>
    <td valign=top colspan=1><formwidget id="da_data_ins">
        <formerror  id="da_data_ins"><br>
        <span class="errori">@formerror.da_data_ins;noquote@</span>
        </formerror>
    </td>
    <td valign=top align=right class=form_title>A data inserimento</td>
    <td valign=top colspan=1><formwidget id="a_data_ins">
        <formerror  id="a_data_ins"><br>
        <span class="errori">@formerror.a_data_ins;noquote@</span>
        </formerror>
    </td>
</tr><!-- san01 -->

<tr><td colspan=2>&nbsp;</td></tr>

<tr><td colspan=4 align=center><formwidget id="submit"><formwidget id="submit1"></td></tr>

<!-- Fine della form colorata -->
<%=[iter_form_fine]%>

</formtemplate>
<p>
</center>

