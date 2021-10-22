<!--
    USER  DATA       MODIFICHE
    ===== ========== =======================================================================
    rom01 12/07/2018 Aggiunta ricerca per Manutentore.

    san01 19/07/2016 Aggiunto filtro per cod_zona.
-->

<master   src="../master">
<property name="title">@page_title;noquote@</property>
<property name="context_bar">@context_bar;noquote@</property>

<center>
<formtemplate id="@form_name;noquote@">
<formwidget   id="funzione">
<formwidget   id="caller">
<formwidget   id="nome_funz">
<formwidget   id="dummy">
<formwidget   id="f_cod_via">
<if @flag_ente@ eq C>
   <formwidget id="cod_comune">
</if>

<table width="100%" cellspacing=0 class=func-menu>
    <tr>
        <td width="25%" class=func-menu>
           &nbsp;
        </td>
        <td width="50%" class=func-menu align=center>
            Campagna: <b>@desc_camp;noquote@</b>
        </td>
        <td width="25%" class=func-menu>
           &nbsp;
        </td>
    </tr>
</table>
<br>
<!-- Inizio della form colorata -->
<%=[iter_form_iniz]%>
<!-- dpr74 -->

<tr><td valign=top align=right class=form_title>Tipologia impianti <font color=red>*</font></td>
    <td valign=top colspan=2 nowrap><formwidget id="flag_tipo_impianto">
        <formerror id="flag_tipo_impianto"><br>
        <span class="errori">@formerror.flag_tipo_impianto;noquote@</span>
        </formerror>
    </td>
</tr>
<!-- dpr74 -->
<tr><td valign=top align=right class=form_title>Tipo estrazione <font color=red>*</font></td>
    <td valign=top colspan=2 nowrap><formwidget id="tipo_estrazione">
        <formerror id="tipo_estrazione"><br>
        <span class="errori">@formerror.tipo_estrazione;noquote@</span>
        </formerror>
    </td>
</tr>
<tr><td valign=top align=right class=form_title nowrap>Con dichiarazione scaduta</td>
    <td valign=top colspan=1 nowrap><formwidget id="flag_scaduto">
        <formerror id="flag_scaduto"><br>
        <span class="errori">@formerror.flag_scaduto;noquote@</span>
        </formerror>
</td>
   <td valign=top align=right class=form_title nowrap>Fino al</td>
    <td valign=top colspan=2 nowrap><formwidget id="data_scad">
        <formerror id="data_scad"><br>
        <span class="errori">@formerror.data_scad;noquote@</span>
        </formerror>
    </td>

</tr>
<tr><td valign=top align=right class=form_title width="30%">Da Anno installazione</td>
    <td valign=top width="15%"><formwidget id="anno_inst_da">
        <formerror  id="anno_inst_da"><br>
        <span class="errori">@formerror.anno_inst_da;noquote@</span>
        </formerror>
    </td>
    <td valign=top align=right class=form_title width="20%" nowrap>A Anno installazione</td>
    <td valign=top width="35%"><formwidget id="anno_inst_a">
        <formerror  id="anno_inst_a"><br>
        <span class="errori">@formerror.anno_inst_a;noquote@</span>
        </formerror>
    </td>
</tr>

<tr><td valign=top align=right class=form_title>Combustibile</td>
    <td valign=top colspan=3 nowrap><formwidget id="cod_combustibile">
        <formerror id="cod_combustibile"><br>
        <span class="errori">@formerror.cod_combustibile;noquote@</span>
        </formerror>
    </td>
</tr>

<if @flag_ente@ eq P>
   <tr><td valign=top align=right class=form_title>Comune</td>
       <td valign=top colspan=3 nowrap><formwidget id="cod_comune">
           <formerror  id="cod_comune"><br>
           <span class="errori">@formerror.cod_comune;noquote@</span>
           </formerror>
       </td>
   </tr>
</if>

<tr><td valign=top align=right class=form_title>Indirizzo</td>
    <td valign=top colspan=3 nowrap><formwidget id="descr_topo">
        <formwidget id="descr_via">@cerca_viae;noquote@
        <formerror  id="descr_via"><br>
        <span class="errori">@formerror.descr_via;noquote@</span>
        </formerror>
    </td>
</tr>

<tr><td valign=top align=right class=form_title nowrap>Numero max di imp. da estr. <font color=red>*</font></td>
    <td valign=top colspan=3><formwidget id="num_max">
        <formerror  id="num_max"><br>
        <span class="errori">@formerror.num_max;noquote@</span>
        </formerror>
    </td>
</tr>
<tr><td colspan=4>&nbsp;</td></tr>
<tr><td valign=top nowrap align=right class=form_title>
       <b>Ricerca per Manutentore:</b>
    </td>
    <td colspan=3>&nbsp;</td>
<tr>
<tr><td valign=top align=right class=form_title>Cognome</td>
    <td valign=top><formwidget id="f_manu_cogn">
       <formerror  id="f_manu_cogn"><br>
       <span class="errori">@formerror.f_manu_cogn;noquote@</span>
       </formerror>
    </td>
    <td valign=top align=right class=form_title>Nome</td>
    <td valign=top><formwidget id="f_manu_nome">@cerca_manu;noquote@
       <formerror  id="f_manu_nome"><br>
       <span class="errori">@formerror.f_manu_nome;noquote@</span>
       </formerror>
    </td>
</tr>
<tr><td colspan=4>&nbsp;</td></tr>

           <tr><td valign=top align=right class=form_title>Con raccomandazioni</td>
               <td valign=top  colspan=1><formwidget id="flag_racc">
                   <formerror  id="flag_racc"><br>
                   <span class="errori">@formerror.flag_racc;noquote@</span>
                   </formerror>
               </td>
               <td valign=top align=right class=form_title>Inviare anche al Comune?</td><!--rom01 aggiunto td-->
	       <td valign=top  colspan=2><formwidget id="f_invio_comune">
                   <formerror  id="f_invio_comune"><br>
                   <span class="errori">@formerror.f_invio_comune;noquote@</span>
                   </formerror>
               </td><!--rom01-->
           </tr>
           <tr><td valign=top align=right class=form_title>Con prescrizioni</td>
               <td valign=top colspan=3><formwidget id="flag_pres">
                   <formerror  id="flag_pres"><br>
                   <span class="errori">@formerror.flag_pres;noquote@</span>
                   </formerror>
               </td>
           </tr>

<tr><td colspan=4>&nbsp;</td></tr>

<tr><td colspan=4 align=center><formwidget id="submitbut"></td></tr>

<!-- Fine della form colorata -->
<%=[iter_form_fine]%>

</formtemplate>
<p>
</center>

