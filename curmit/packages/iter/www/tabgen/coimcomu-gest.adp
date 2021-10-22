<master   src="../master">
<property name="title">@page_title;noquote@</property>
<property name="context_bar">@context_bar;noquote@</property>
<property name="riga_vuota">f</property>

<table width=100% cellspacing=0 class=func-menu>
<tr>
   <td width="25%" nowrap class=func-menu>
       <a href=coimcomu-list?@link_list;noquote@ class=func-menu>Ritorna</a>
   </td>
   <if @funzione@ eq "I">
      <td width="75%" nowrap class=func-menu>&nbsp;</td>
   </if>
   <else>
      <td width="25%" nowrap class=@func_v;noquote@>
         <a href="coimcomu-gest?funzione=V&@link_gest;noquote@" class=@func_v;noquote@>Visualizza</a>
      </td>
      <td width="25%" nowrap class=@func_m;noquote@>
         <a href="coimcomu-gest?funzione=M&@link_gest;noquote@" class=@func_m;noquote@>Modifica</a>
      </td>
      <td width="25%" nowrap class=@func_d;noquote@>
         <a href="coimcomu-gest?funzione=D&@link_gest;noquote@" class=@func_d;noquote@>Cancella</a>
      </td>
   </else>
</tr>
</table>

<center>
<formtemplate id="@form_name;noquote@">
<formwidget   id="funzione">
<formwidget   id="caller">
<formwidget   id="nome_funz">
<formwidget   id="extra_par">
<formwidget   id="last_cod_comune">
<formwidget   id="last_denominazione">
<formwidget   id="cod_comune">
<formwidget   id="cod_provincia">

<!-- Inizio della form colorata -->
<%=[iter_form_iniz]%>

<tr><td valign=top align=right class=form_title>Provincia</td>
    <td valign=top nowrap><formwidget id="nome_prov">@cerca_prov;noquote@
        <formerror  id="nome_prov"><br>
        <span class="errori">@formerror.nome_prov;noquote@</span>
        </formerror>
    </td>
</tr>

<tr><td valign=top align=right class=form_title>Denominazione</td>
    <td valign=top nowrap><formwidget id="denominazione">
        <formerror  id="denominazione"><br>
        <span class="errori">@formerror.denominazione;noquote@</span>
        </formerror>
    </td>
</tr>

<tr><td valign=top align=right class=form_title>Flag Validit&agrave;</td>
    <td valign=top nowrap>
        <formgroup id="flag_val">@formgroup.widget;noquote@</formgroup>
        <formerror  id="flag_val"><br>
        <span class="errori">@formerror.flag_val;noquote@</span>
        </formerror>
    </td>
</tr>

<tr><td valign=top align=right class=form_title>C.A.P</td>
    <td valign=top nowrap><formwidget id="cap">
        <formerror  id="cap"><br>
        <span class="errori">@formerror.cap;noquote@</span>
        </formerror>
    </td>
</tr>

<tr><td valign=top align=right class=form_title>Cod.Belfiore</td>
    <td valign=top nowrap><formwidget id="id_belfiore">
        <formerror  id="id_belfiore"><br>
        <span class="errori">@formerror.id_belfiore;noquote@</span>
        </formerror>
    </td>
</tr>

<tr><td valign=top align=right class=form_title>Cod.ISTAT</td>
    <td valign=top nowrap><formwidget id="cod_istat">
        <formerror  id="cod_istat"><br>
        <span class="errori">@formerror.cod_istat;noquote@</span>
        </formerror>
    </td>
</tr>

<tr><td valign=top align=right class=form_title>Popolazione anagrafica</td>
    <td valign=top nowrap><formwidget id="popolaz_citt">
        <formerror  id="popolaz_citt"><br>
        <span class="errori">@formerror.popolaz_citt;noquote@</span>
        </formerror>
    </td>
</tr>
<tr><td valign=top align=right class=form_title>Popolazione Impianti</td>
    <td valign=top nowrap><formwidget id="popolaz_aimp">(@conta_aimp;noquote@)
        <formerror  id="popolaz_aimp"><br>
        <span class="errori">@formerror.popolaz_aimp;noquote@</span>
        </formerror>
    </td>
</tr>

<tr><td valign=top align=right class=form_title>Flag viario manutentore</td>
    <td valign=top nowrap>
        <formgroup id="flag_viario_manutentore">@formgroup.widget;noquote@</formgroup>
        <formerror  id="flag_viario_manutentore"><br>
        <span class="errori">@formerror.flag_viario_manutentore;noquote@</span>
        </formerror>
    </td>
</tr>
<tr><td valign=center align=right class=form_title>PEC Comune</td>
    <td valign=center><formwidget id="pec">
        <formerror  id="pec"><br>
        <span class="errori">@formerror.pec;noquote@</span>
        </formerror>
    </td>
</tr>

<tr><td colspan=2>&nbsp;</td></tr>

<if @funzione@ ne "V" and @nodelete@ eq "F">
    <tr><td colspan=2 align=center><formwidget id="submit"></td></tr>
</if>


<!-- Fine della form colorata -->
<%=[iter_form_fine]%>

</formtemplate>
<p>
</center>


