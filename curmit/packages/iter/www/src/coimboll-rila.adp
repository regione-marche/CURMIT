<master   src="../master">
<property name="title">@page_title;noquote@</property>
<property name="context_bar">@context_bar;noquote@</property>
<property name="riga_vuota">f</property>

<table width="100%" cellspacing=0 class=func-menu>
<tr>
   <if  @funzione@ ne "I"
    or  @nome_funz@ ne "boll-ins">
       <td width="25%" nowrap class=func-menu>
           <a href="@link_ritorna;noquote@" class=func-menu>Ritorna</a>
       </td>

       <if @funzione@ eq "I">
           <td width="75%" nowrap class=func-menu>&nbsp;</td>
       </if>
       <else>
          <td width="25%" nowrap class=@func_v;noquote@>
             <a href="coimboll-gest?funzione=V&@link_gest;noquote@" class=@func_v;noquote@>Visualizza</a>
          </td>
         <if @flag_attivo@ eq N>
          <td width="25%" nowrap class=@func_m;noquote@>
             <a href="coimboll-gest?funzione=M&@link_gest;noquote@" class=@func_m;noquote@>Modifica</a>
          </td>
          <td width="25%" nowrap class=@func_d;noquote@>Cancella</td>
         </if>
         <else>
          <td width="25%" nowrap class=@func_m;noquote@>
             <a href="coimboll-gest?funzione=M&@link_gest;noquote@" class=@func_m;noquote@>Modifica</a>
          </td>
          <td width="25%" nowrap class=@func_d;noquote@>
             <a href="coimboll-gest?funzione=D&@link_gest;noquote@" class=@func_d;noquote@>Cancella</a>
         </td>
         </else>
      </else>
   </if>
</tr>
<if @funzione@ ne "I">
    <tr>
        <td width="25%" nowrap class=func-menu> 
            <a href="coimboll-layout?@link_prnt;noquote@" target=stampa class=func-menu>Stampa ricevuta</a>
        </td>
        <td width="25%" nowrap class=func-menu> 
                <a href="coimfatt-gest?@link_fatt;noquote@" class=func-menu>Crea fattura</a>
            </td>
         <td width="25%" nowrap class=func-menu> 
                <a href="coimrfis-gest?@link_rfis;noquote@" class=func-menu>Crea Ricevuta Fiscale</a>
            </td>
	<td colspan=3 class=func-menu>&nbsp;</td> 
    </tr>
</if>
</table>

<center>
<formtemplate id="@form_name;noquote@">
<formwidget   id="funzione">
<formwidget   id="caller">
<formwidget   id="nome_funz">
<formwidget   id="nome_funz_caller">
<formwidget   id="extra_par">
<formwidget   id="last_order">
<formwidget   id="cod_bollini">
<formwidget   id="flag_attivo">
<formwidget   id="cod_manutentore">
<formwidget   id="dummy">

<br>

<!-- Inizio della form colorata -->

<%=[iter_form_iniz]%>
 <td align=right><tr>
 <a href="#" onclick="javascript:window.open('coimboll-help', 'help', 'scrollbars=yes, resizable=yes, width=500, height=320').moveTo(110,140)"><b>Help</b></a>
 </td></tr>
<tr>
    <td valign=top align=right class=form_title>Data consegna</td>
    <td valign=top><formwidget id="data_consegna">
        <formerror  id="data_consegna"><br>
        <span class="errori">@formerror.data_consegna;noquote@</span>
        </formerror>
    </td>
    <td valign=top align=right class=form_title>Manutentore</td>
     	<td valign=top><formwidget id="f_manu_cogn">
                       <formwidget id="f_manu_nome">@cerca_manu;noquote@
            <formerror  id="f_manu_cogn"><br>
            <span class="errori">@formerror.f_manu_cogn;noquote@</span>
            </formerror>
        </td>
</tr>
</table>
<br>

<table width=100%>
 <tr>
    <td width=15% align=center ><b>Fino a 35 KW</b></td>

    <td width=10% valign=top align=right class=form_title>Nr bollini</td>
    <td width=11% valign=top><formwidget id="nr_bollini1">
        <formerror id="nr_bollini1"><br>
          <span class="errori">@formerror.nr_bollini1;noquote@</span>
        </formerror>
    </td>
    
    <td width=10% valign=top align=right class=form_title>Da matricola</td>
    <td width=11% valign=top><formwidget id="matricola_da1">
        <formerror  id="matricola_da1"><br>
                   <span class="errori">@formerror.matricola_da1;noquote@</span>
        </formerror>
    </td>
    
    <td width=10% valign=top align=right class=form_title>A matricola</td>
    <td width=11% valign=top><formwidget id="matricola_a1">
        <formerror  id="matricola_a1"><br>
          <span class="errori">@formerror.matricola_a1;noquote@</span>
        </formerror>
    </td>
    
    <td width=10% valign=top align=right class=form_title>Costo unitario</td>
    <td width=11% valign=top><formwidget id="costo_unitario1">
        <formerror  id="costo_unitario1"><br>
          <span class="errori">@formerror.costo_unitario1;noquote@</span>
        </formerror>
    </td>
 </tr>

 <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td valign=top align=right class=form_title>Importo pagato</td>
    <td valign=top><formwidget id="imp_pagato1">
        <formerror id="imp_pagato1"><br>
        <span class="errori">@formerror.imp_pagato1;noquote@</span>
        </formerror>
    </td>
    <td valign=top align=right class=form_title>Pagati</td>
    <td valign=top><formwidget id="pagati1">
        <formerror id="pagati1"><br>
        <span class="errori">@formerror.pagati1;noquote@</span>
        </formerror>
    </td>
 </tr>

 <tr>
    <td align=center><b>Da 35 a 116 KW</b></td>

    <td valign=top align=right class=form_title>Nr bollini</td>
    <td valign=top><formwidget id="nr_bollini2">
        <formerror id="nr_bollini2"><br>
        <span class="errori">@formerror.nr_bollini2;noquote@</span>
        </formerror>
    </td>

    <td valign=top align=right class=form_title>Da matricola</td>
    <td valign=top><formwidget id="matricola_da2">
        <formerror  id="matricola_da2"><br>
          <span class="errori">@formerror.matricola_da2;noquote@</span>
        </formerror>
    </td>
    <td valign=top align=right class=form_title>A matricola</td>
    <td valign=top><formwidget id="matricola_a2">
        <formerror  id="matricola_a2"><br>
          <span class="errori">@formerror.matricola_a2;noquote@</span>
        </formerror>
    </td>

    <td valign=top align=right class=form_title>Costo unitario</td>
    <td valign=top><formwidget id="costo_unitario2">
                   <formerror  id="costo_unitario2"><br>
                   <span class="errori">@formerror.costo_unitario2;noquote@</span>
                   </formerror>
    </td>
</tr>

<tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td valign=top align=right class=form_title>Importo pagato</td>
    <td valign=top><formwidget id="imp_pagato2">
        <formerror id="imp_pagato2"><br>
        <span class="errori">@formerror.imp_pagato2;noquote@</span>
        </formerror>
    </td>
    <td valign=top align=right class=form_title>Pagati</td>
    <td valign=top><formwidget id="pagati2">
        <formerror id="pagati2"><br>
        <span class="errori">@formerror.pagati2;noquote@</span>
        </formerror>
    </td>
 </tr>

 <tr>
    <td align=center><b>Da 116 a 350 KW</b></td>
    <td valign=top align=right class=form_title>Nr bollini</td>
    <td valign=top><formwidget id="nr_bollini3">
        <formerror id="nr_bollini3"><br>
        <span class="errori">@formerror.nr_bollini3;noquote@</span>
        </formerror>
    </td>

    <td valign=top align=right class=form_title>Da matricola</td>
    <td valign=top><formwidget id="matricola_da3">
                   <formerror  id="matricola_da3"><br>
                   <span class="errori">@formerror.matricola_da3;noquote@</span>
                   </formerror>
    </td>

    <td valign=top align=right class=form_title>A matricola</td>
    <td valign=top><formwidget id="matricola_a3">
                   <formerror  id="matricola_a3"><br>
                   <span class="errori">@formerror.matricola_a3;noquote@</span>
                   </formerror>
    </td>

    <td valign=top align=right class=form_title>Costo unitario</td>
    <td valign=top><formwidget id="costo_unitario3">
                   <formerror  id="costo_unitario3"><br>
                   <span class="errori">@formerror.costo_unitario3;noquote@</span>
                   </formerror>
    </td>
</tr>

<tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td valign=top align=right class=form_title>Importo pagato</td>
    <td valign=top><formwidget id="imp_pagato3">
        <formerror id="imp_pagato3"><br>
        <span class="errori">@formerror.imp_pagato3;noquote@</span>
        </formerror>
    </td>
    <td valign=top align=right class=form_title>Pagati</td>
    <td valign=top><formwidget id="pagati3">
        <formerror id="pagati3"><br>
        <span class="errori">@formerror.pagati3;noquote@</span>
        </formerror>
    </td>
 </tr>

 <tr>
    <td align=center><b>Oltre 350 KW</b></td>

    <td valign=top align=right class=form_title>Nr bollini</td>
    <td valign=top><formwidget id="nr_bollini4">
        <formerror id="nr_bollini4"><br>
        <span class="errori">@formerror.nr_bollini4;noquote@</span>
        </formerror>
    </td>

    <td valign=top align=right class=form_title>Da matricola</td>
    <td valign=top><formwidget id="matricola_da4">
                   <formerror  id="matricola_da4"><br>
                   <span class="errori">@formerror.matricola_da4;noquote@</span>
                   </formerror>
    </td>

    <td valign=top align=right class=form_title>A matricola</td>
    <td valign=top><formwidget id="matricola_a4">
                   <formerror  id="matricola_a4"><br>
                   <span class="errori">@formerror.matricola_a4;noquote@</span>
                   </formerror>
    </td>

    <td valign=top align=right class=form_title>Costo unitario</td>
    <td valign=top><formwidget id="costo_unitario4">
                   <formerror  id="costo_unitario4"><br>
                   <span class="errori">@formerror.costo_unitario4;noquote@</span>
                   </formerror>
    </td>
</tr>

<tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td valign=top align=right class=form_title>Importo pagato</td>
    <td valign=top><formwidget id="imp_pagato4">
        <formerror id="imp_pagato4"><br>
        <span class="errori">@formerror.imp_pagato4;noquote@</span>
        </formerror>
    </td>
    <td valign=top align=right class=form_title>Pagati</td>
    <td valign=top><formwidget id="pagati4">
        <formerror id="pagati4"><br>
        <span class="errori">@formerror.pagati4;noquote@</span>
        </formerror>
    </td>
</tr>

</table>
<br>

<table>

<tr>
    <td valign=top align=right class=form_title>Data scadenza</td>
    <td valign=top><formwidget id="data_scadenza">
        <formerror  id="data_scadenza"><br>
        <span class="errori">@formerror.data_scadenza;noquote@</span>
        </formerror>
    </td>
    <td valign=top align=right class=form_title>Sconto</td>
    <td valign=top><formwidget id="imp_sconto">
        <formerror  id="imp_sconto"><br>
        <span class="errori">@formerror.imp_sconto;noquote@</span>
        </formerror>
    </td> 
    <td valign=top align=right class=form_title>Note</td>
    <td valign=top colspan=3><formwidget id="note">
        <formerror  id="note"><br>
        <span class="errori">@formerror.note;noquote@</span>
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

