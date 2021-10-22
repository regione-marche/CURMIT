<master   src="../master">
<property name="title">@page_title;noquote@</property>
<property name="context_bar">@context_bar;noquote@</property>
<property name="riga_vuota">f</property>

<p>&nbsp;</p>
<center>
<formtemplate id="@form_name;noquote@">
<formwidget   id="funzione">
<formwidget   id="caller">
<formwidget   id="nome_funz">
<formwidget   id="nome_funz_caller">


<!-- Inizio della form colorata -->
<%=[iter_form_iniz]%>

<tr>
    <td valign=top align=right class=form_title>Da data appuntamento</td>
    <td valign=top><formwidget id="f_data_controllo_da">
        <formerror id="f_data_controllo_da"><br>
        <span class="errori">@formerror.f_data_controllo_da;noquote@</span>
        </formerror>
    </td>
    <td valign=top align=right class=form_title>A data appuntamento</td>
    <td valign=top><formwidget id="f_data_controllo_a">
        <formerror id="f_data_controllo_a"><br>
        <span class="errori">@formerror.f_data_controllo_a;noquote@</span>
        </formerror>
    </td>
</tr>

<tr>
    <td valign=top align=right class=form_title>Da data estrazione file</td>
    <td valign=top><formwidget id="f_data_emissione_da">
        <formerror id="f_data_emissione_da"><br>
        <span class="errori">@formerror.f_data_emissione_da;noquote@</span>
        </formerror>
    </td>
    <td valign=top align=right class=form_title>A data estrazione file</td>
    <td valign=top><formwidget id="f_data_emissione_a">
        <formerror id="f_data_emissione_a"><br>
        <span class="errori">@formerror.f_data_emissione_a;noquote@</span>
        </formerror>
    </td>
</tr>

<tr>
    <td valign=top align=right class=form_title>Da data pagamento</td>
    <td valign=top><formwidget id="f_data_pagamento_da">
        <formerror id="f_data_pagamento_da"><br>
        <span class="errori">@formerror.f_data_pagamento_da;noquote@</span>
        </formerror>
    </td>
    <td valign=top align=right class=form_title>A data pagamento</td>
    <td valign=top><formwidget id="f_data_pagamento_a">
        <formerror id="f_data_pagamento_a"><br>
        <span class="errori">@formerror.f_data_pagamento_a;noquote@</span>
        </formerror>
    </td>
</tr>

<tr>
    <td valign=top align=right class=form_title>Da data scarico</td>
    <td valign=top><formwidget id="f_data_scarico_da">
        <formerror id="f_data_scarico_da"><br>
        <span class="errori">@formerror.f_data_scarico_da;noquote@</span>
        </formerror>
    </td>
    <td valign=top align=right class=form_title>A data scarico</td>
    <td valign=top><formwidget id="f_data_scarico_a">
        <formerror id="f_data_scarico_a"><br>
        <span class="errori">@formerror.f_data_scarico_a;noquote@</span>
        </formerror>
    </td>
</tr>

<tr>
    <td valign=top align=right class=form_title>Pagati</td>
    <td valign=top><formwidget id="f_flag_pagati">
        <formerror id="f_flag_pagati"><br>
        <span class="errori">@formerror.f_flag_pagati;noquote@</span>
        </formerror>
    </td>
    <td valign=top align=right class=form_title>5° campo</td>
    <td valign=top><formwidget id="f_quinto_campo">
        <formerror id="f_quinto_campo"><br>
        <span class="errori">@formerror.f_quinto_campo;noquote@</span>
        </formerror>
    </td>
</tr>

<tr> 
    <td valign=top align=right class=form_title>Cognome del responsabile dell'impianto</td>
    <td valign=top><formwidget id="f_resp_cogn">
        <formerror id="f_resp_cogn"><br>
        <span class="errori">@formerror.f_resp_cogn;noquote@</span>
        </formerror>
    </td>
    <td valign=top align=right class=form_title>Nome del responsabile dell'impianto</td>
    <td valign=top><formwidget id="f_resp_nome">
        <formerror id="f_resp_nome"><br>
        <span class="errori">@formerror.f_resp_nome;noquote@</span>
        </formerror>
    </td>
</tr>
<tr> 
    <td valign=top align=right class=form_title>Codice impianto</td>
    <td valign=top><formwidget id="f_cod_impianto_est">
        <formerror id="f_cod_impianto_est"><br>
        <span class="errori">@formerror.f_cod_impianto_est;noquote@</span>
        </formerror>
    </td>
    <td valign=top align=right class=form_title>Stato</td>
    <td valign=top><formwidget id="f_stato">
        <formerror id="f_stato"><br>
        <span class="errori">@formerror.f_stato;noquote@</span>
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
