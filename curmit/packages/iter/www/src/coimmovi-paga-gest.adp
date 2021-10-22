<master   src="../master">
<property name="title">@page_title;noquote@</property>
<property name="context_bar">@context_bar;noquote@</property>
<property name="riga_vuota">f</property>

@link_tab;noquote@
@dett_tab;noquote@

<table width="100%" cellspacing=0 class=func-menu>
<tr>
   <td width="25%" nowrap class=func-menu>
       <a href="coimmovi-paga-gest?funzione=I&@link_gest;noquote@" class=func-menu>Nuovo Pagamento</a>
   </td>
   <if @funzione@ eq "I">
      <td width="75%" nowrap class=func-menu>&nbsp;</td>
   </if>
   <else>
      <td width="25%" nowrap class=@func_v;noquote@>
         <a href="coimmovi-paga-gest?funzione=V&@link_gest;noquote@" class=@func_v;noquote@>Visualizza</a>
      </td>
      <td width="25%" nowrap class=@func_m;noquote@>
         <a href="coimmovi-paga-gest?funzione=M&@link_gest;noquote@" class=@func_m;noquote@>Modifica</a>
      </td>
      <td width="25%" nowrap class=@func_d;noquote@>
         <a href="coimmovi-paga-gest?funzione=D&@link_gest;noquote@" class=@func_d;noquote@>Cancella</a>
      </td>
   </else>
</tr>
</table>

<center>
<formtemplate id="@form_name;noquote@">
<formwidget   id="funzione">
<formwidget   id="caller">
<formwidget   id="nome_funz">
<formwidget   id="nome_funz_caller">
<formwidget   id="extra_par">
<formwidget   id="last_cod_movi">
<formwidget   id="cod_impianto">
<formwidget   id="url_aimp">
<formwidget   id="url_list_aimp">

<!-- Inizio della form colorata -->
<%=[iter_form_iniz]%>

<tr><td valign=top align=right class=form_title>Codice</td>
    <td valign=top><formwidget id="cod_movi">
        <formerror  id="cod_movi"><br>
        <span class="errori">@formerror.cod_movi;noquote@</span>
        </formerror>
    </td>
    <td valign=top align=right class=form_title>Causale pagamento</td>
    <td valign=top nowrap><formwidget id="id_caus">
        <formerror  id="id_caus"><br>
        <span class="errori">@formerror.id_caus;noquote@</span>
        </formerror>
    </td>
</tr>
<tr>
<tr><td valign=top align=right class=form_title>Data Competenza</td>
    <td valign=top><formwidget id="data_compet">
        <formerror  id="data_compet"><br>
        <span class="errori">@formerror.data_compet;noquote@</span>
        </formerror>
    </td>
</tr>
<tr><td valign=top align=right class=form_title>Data scadenza</td>
    <td valign=top><formwidget id="data_scad">
        <formerror  id="data_scad"><br>
        <span class="errori">@formerror.data_scad;noquote@</span>
        </formerror>
    </td>
    <td valign=top align=right class=form_title>Importo</td>
    <td valign=top><formwidget id="importo">
        <formerror  id="importo"><br>
        <span class="errori">@formerror.importo;noquote@</span>
        </formerror>
    </td>
</tr>

<tr><td valign=top align=right class=form_title>Data pagamento</td>
    <td valign=top><formwidget id="data_pag">
        <formerror  id="data_pag"><br>
        <span class="errori">@formerror.data_pag;noquote@</span>
        </formerror>
    </td>
    <td valign=top align=right class=form_title>Importo pagato</td>
    <td valign=top><formwidget id="importo_pag">
        <formerror  id="importo_pag"><br>
        <span class="errori">@formerror.importo_pag;noquote@</span>
        </formerror>
    </td>
</tr>

<tr> <td valign=top align=right class=form_title>Data Incasso</td>
    <td valign=top><formwidget id="data_incasso">
        <formerror  id="data_incasso"><br>
        <span class="errori">@formerror.data_incasso;noquote@</span>
        </formerror>
    </td>
    <td colspan=2></td>
</tr>

<tr><td valign=top align=right class=form_title>Tipo pagamento</td>
    <td valign=top><formwidget id="tipo_pag">
        <formerror  id="tipo_pag"><br>
        <span class="errori">@formerror.tipo_pag;noquote@</span>
        </formerror>
    </td>
    <td valign=top align=right class=form_title>Pagato</td>
    <td valign=top><formwidget id="flag_pagato">
        <formerror  id="flag_pagato"><br>
        <span class="errori">@formerror.flag_pagato;noquote@</span>
        </formerror>
    </td>
</tr>

<tr><td valign=top align=right class=form_title>Eventuale riferimento pag.</td>
    <td valign=top colspan=3><formwidget id="riferimento">
        <formerror  id="riferimento"><br>
        <span class="errori">@formerror.riferimento;noquote@</span>
        </formerror>
    </td>
</tr>

<tr><td valign=top align=right class=form_title>Nota</td>
    <td valign=top colspan=3><formwidget id="nota">
        <formerror  id="nota"><br>
        <span class="errori">@formerror.nota;noquote@</span>
        </formerror>
    </td>
</tr>

<tr><td colspan=4>&nbsp;</td></tr>

<if @funzione@ ne "V">
    <tr><td colspan=4 align=center><formwidget id="submit"></td></tr>
</if>

<!-- Fine della form colorata -->
<%=[iter_form_fine]%>

</formtemplate>
<p>
</center>

