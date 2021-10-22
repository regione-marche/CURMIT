<master   src="../master">
<property name="title">@page_title;noquote@</property>
<property name="context_bar">@context_bar;noquote@</property>
<property name="riga_vuota">f</property>

<table width="100%" cellspacing=0 class=func-menu>
<tr>
   <td width="25%" nowrap class=func-menu>
       <a href="coimbpos-list?@link_list;noquote@" class=func-menu>Ritorna</a>
   </td>
   <td width="25%" nowrap class=@func_v;noquote@>
      <a href="coimbpos-gest?funzione=V&@link_gest;noquote@" class=@func_v;noquote@>Visualizza</a>
   </td>
   <td width="25%" nowrap class=@func_m;noquote@>
      <a href="coimbpos-gest?funzione=M&@link_gest;noquote@" class=@func_m;noquote@>Modifica</a>
   </td>
   <td width="25%" nowrap class=@func_m;noquote@>
      &nbsp;
   </td>
</tr>
</table>

<center>
<formtemplate id="@form_name;noquote@">
<formwidget   id="funzione">
<formwidget   id="caller">
<formwidget   id="nome_funz">
<formwidget   id="nome_funz_caller">
<formwidget   id="extra_par">
<formwidget   id="last_cod_bpos">

<formwidget   id="cod_bpos">

<!-- Inizio della form colorata -->
<%=[iter_form_iniz]%>

<tr><td colspan=2>&nbsp;</td></tr>

<tr>
    <td valign=top align=right class=form_title>Data estrazione file</td>
    <td valign=top><formwidget id="data_emissione">
        <formerror id="data_emissione"><br>
        <span class="errori">@formerror.data_emissione;noquote@</span>
        </formerror>
    </td>
</tr>

<tr>
    <td valign=top align=right class=form_title>5&deg; campo</td>
    <td valign=top><formwidget id="quinto_campo">
        <formerror id="quinto_campo"><br>
        <span class="errori">@formerror.quinto_campo;noquote@</span>
        </formerror>
    </td>
</tr>

<tr>
    <td valign=top align=right class=form_title>Cod. impianto</td>
    <td valign=top><formwidget id="cod_impianto_est">
        <formerror id="cod_impianto_est"><br>
        <span class="errori">@formerror.cod_impianto_est;noquote@</span>
        </formerror>
    </td>
</tr>

<tr>
    <td valign=top align=right class=form_title>Responsabile</td>
    <td valign=top><formwidget id="responsabile">
        <formerror id="responsabile"><br>
        <span class="errori">@formerror.responsabile;noquote@</span>
        </formerror>
    </td>
</tr>

<tr>
    <td valign=top align=right class=form_title>Data appuntamento</td>
    <td valign=top><formwidget id="data_verifica">
        <formerror id="data_verifica"><br>
        <span class="errori">@formerror.data_verifica;noquote@</span>
        </formerror>
    </td>
</tr>

<tr>
    <td valign=top align=right class=form_title>Importo da pagare</td>
    <td valign=top><formwidget id="importo_emesso">
        <formerror  id="importo_emesso"><br>
        <span class="errori">@formerror.importo_emesso;noquote@</span>
        </formerror>
    </td>
</tr>

<tr>
    <td valign=top align=right class=form_title>Importo pagato</td>
    <td valign=top><formwidget id="importo_pagato">
        <formerror  id="importo_pagato"><br>
        <span class="errori">@formerror.importo_pagato;noquote@</span>
        </formerror>
    </td>
</tr>

<tr><td valign=top align=right class=form_title>Data pagamento</td>
    <td valign=top><formwidget id="data_pagamento">
        <formerror  id="data_pagamento"><br>
        <span class="errori">@formerror.data_pagamento;noquote@</span>
        </formerror>
    </td>
</tr>

<tr>
    <td valign=top align=right class=form_title>Data scarico</td>
    <td valign=top><formwidget id="data_scarico">
        <formerror  id="data_scarico"><br>
        <span class="errori">@formerror.data_scarico;noquote@</span>
        </formerror>
    </td>
</tr>

<tr><td valign=top align=right class=form_title>Stato</td>
    <td valign=top><formwidget id="stato">
        <formerror  id="stato"><br>
        <span class="errori">@formerror.stato;noquote@</span>
        </formerror>
    </td>
</tr>

<tr><td colspan=2>&nbsp;</td></tr>

<if @funzione@ ne "V">
    <tr><td colspan=2 align=center><formwidget id="submit"></td></tr>
</if>

<!-- Fine della form colorata -->
<%=[iter_form_fine]%>

</formtemplate>
<p>
</center>

