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

<!-- gab01 aggiunto titolo--> 
<h2>IVA 10%</h2>

 <tr>
    <td width=15% align=center ><b>Da 10 a 100 KW</b></td>

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
    <td align=center><b>Da 100 a 200 KW</b></td>

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
    <td align=center><b>Da 200 a 300 KW</b></td>
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
    <td align=center><b>Oltre 300 KW</b></td>

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

 <tr>
    <td align=center><b>Pompe di calore/macc.frigo da 12 a 100 KW</b></td>

    <td valign=top align=right class=form_title>Nr bollini</td>
    <td valign=top><formwidget id="nr_bollini5">
        <formerror id="nr_bollini5"><br>
        <span class="errori">@formerror.nr_bollini5;noquote@</span>
        </formerror>
    </td>

    <td valign=top align=right class=form_title>Da matricola</td>
    <td valign=top><formwidget id="matricola_da5">
        <formerror  id="matricola_da5"><br>
          <span class="errori">@formerror.matricola_da5;noquote@</span>
        </formerror>
    </td>

    <td valign=top align=right class=form_title>A matricola</td>
    <td valign=top><formwidget id="matricola_a5">
                   <formerror  id="matricola_a5"><br>
                   <span class="errori">@formerror.matricola_a5;noquote@</span>
                   </formerror>
    </td>

    <td valign=top align=right class=form_title>Costo unitario</td>
    <td valign=top><formwidget id="costo_unitario5">
                   <formerror  id="costo_unitario5"><br>
                   <span class="errori">@formerror.costo_unitario5;noquote@</span>
                   </formerror>
    </td>
    <td valign=top align=right class=form_title>Importo pagato</td>
    <td valign=top><formwidget id="imp_pagato5">
        <formerror id="imp_pagato5"><br>
        <span class="errori">@formerror.imp_pagato5;noquote@</span>
        </formerror>
    </td>
    <td valign=top align=right class=form_title>Pagati</td>
    <td valign=top><formwidget id="pagati5">
        <formerror id="pagati5"><br>
        <span class="errori">@formerror.pagati5;noquote@</span>
        </formerror>
    </td>
 </tr>
<!-- sandro tolti
 <tr>
    <td align=center><b>Pompe di calore/macc.frigo da 35 a 100 KW</b></td>

    <td valign=top align=right class=form_title>Nr bollini</td>
    <td valign=top><formwidget id="nr_bollini6">
        <formerror id="nr_bollini5"><br>
        <span class="errori">@formerror.nr_bollini6;noquote@</span>
        </formerror>
    </td>

    <td valign=top align=right class=form_title>Da matricola</td>
    <td valign=top><formwidget id="matricola_da6">
                   <formerror  id="matricola_da6"><br>
                   <span class="errori">@formerror.matricola_da6;noquote@</span>
                   </formerror>
    </td>
    <td valign=top align=right class=form_title>A matricola</td>
    <td valign=top><formwidget id="matricola_a6">
                   <formerror  id="matricola_a6"><br>
                   <span class="errori">@formerror.matricola_a6;noquote@</span>
                   </formerror>
    </td>
    <td valign=top align=right class=form_title>Costo unitario</td>
    <td valign=top><formwidget id="costo_unitario6">
                   <formerror  id="costo_unitario6"><br>
                   <span class="errori">@formerror.costo_unitario6;noquote@</span>
                   </formerror>
    </td>
    <td valign=top align=right class=form_title>Importo pagato</td>
    <td valign=top><formwidget id="imp_pagato6">
        <formerror id="imp_pagato4"><br>
        <span class="errori">@formerror.imp_pagato6;noquote@</span>
        </formerror>
    </td>
    <td valign=top align=right class=form_title>Pagati</td>
    <td valign=top><formwidget id="pagati6">
        <formerror id="pagati4"><br>
        <span class="errori">@formerror.pagati6;noquote@</span>
        </formerror>
    </td>
</tr>
-->

 <tr>
    <td align=center><b>Pompe di calore/macc.frigo > 100 KW</b></td>

    <td valign=top align=right class=form_title>Nr bollini</td>
    <td valign=top><formwidget id="nr_bollini7">
        <formerror id="nr_bollini7"><br>
        <span class="errori">@formerror.nr_bollini7;noquote@</span>
        </formerror>
    </td>

    <td valign=top align=right class=form_title>Da matricola</td>
    <td valign=top><formwidget id="matricola_da7">
                   <formerror  id="matricola_da7"><br>
                   <span class="errori">@formerror.matricola_da7;noquote@</span>
                   </formerror>
    </td>
    <td valign=top align=right class=form_title>A matricola</td>
    <td valign=top><formwidget id="matricola_a7">
                   <formerror  id="matricola_a7"><br>
                   <span class="errori">@formerror.matricola_a7;noquote@</span>
                   </formerror>
    </td>
    <td valign=top align=right class=form_title>Costo unitario</td>
    <td valign=top><formwidget id="costo_unitario7">
                   <formerror  id="costo_unitario7"><br>
                   <span class="errori">@formerror.costo_unitario7;noquote@</span>
                   </formerror>
    </td>
    <td valign=top align=right class=form_title>Importo pagato</td>
    <td valign=top><formwidget id="imp_pagato7">
        <formerror id="imp_pagato7"><br>
        <span class="errori">@formerror.imp_pagato7;noquote@</span>
        </formerror>
    </td>
    <td valign=top align=right class=form_title>Pagati</td>
    <td valign=top><formwidget id="pagati7">
        <formerror id="pagati7"><br>
        <span class="errori">@formerror.pagati7;noquote@</span>
        </formerror>
    </td>
</tr>
</table>
<!-- gab01 sezione con diversa categoria di iva -->
<!-- gab01 inizio -->
<table width=100%>
<!-- gab01 aggiunto titolo-->
 <h2>IVA 22%</h2>

 <tr>
    <td width=15% align=center ><b>Da 10 a 100 KW</b></td>

    <td width=10% valign=top align=right class=form_title>Nr bollini</td>
    <td width=11% valign=top><formwidget id="nr_bollini1_sec_iva">
        <formerror id="nr_bollini1_sec_iva"><br>
          <span class="errori">@formerror.nr_bollini1_sec_iva;noquote@</span>
        </formerror>
    </td>
    
    <td width=10% valign=top align=right class=form_title>Da matricola</td>
    <td width=11% valign=top><formwidget id="matricola_da1_sec_iva">
        <formerror  id="matricola_da1_sec_iva"><br>
                   <span class="errori">@formerror.matricola_da1_sec_iva;noquote@</span>
        </formerror>
    </td>
    
    <td width=10% valign=top align=right class=form_title>A matricola</td>
    <td width=11% valign=top><formwidget id="matricola_a1_sec_iva">
        <formerror  id="matricola_a1_sec_iva"><br>
          <span class="errori">@formerror.matricola_a1_sec_iva;noquote@</span>
        </formerror>
    </td>
    
    <td width=10% valign=top align=right class=form_title>Costo unitario</td>
    <td width=11% valign=top><formwidget id="costo_unitario1_sec_iva">
        <formerror  id="costo_unitario1_sec_iva"><br>
          <span class="errori">@formerror.costo_unitario1_sec_iva;noquote@</span>
        </formerror>
    </td>
    <td valign=top align=right class=form_title>Importo pagato</td>
    <td valign=top><formwidget id="imp_pagato1_sec_iva">
        <formerror id="imp_pagato1_sec_iva"><br>
        <span class="errori">@formerror.imp_pagato1_sec_iva;noquote@</span>
        </formerror>
    </td>
    <td valign=top align=right class=form_title>Pagati</td>
    <td valign=top><formwidget id="pagati1_sec_iva">
        <formerror id="pagati1_sec_iva"><br>
        <span class="errori">@formerror.pagati1_sec_iva;noquote@</span>
        </formerror>
    </td>
 </tr>
 <tr>
    <td align=center><b>Da 100 a 200 KW</b></td>

    <td valign=top align=right class=form_title>Nr bollini</td>
    <td valign=top><formwidget id="nr_bollini2_sec_iva">
        <formerror id="nr_bollini2_sec_iva"><br>
        <span class="errori">@formerror.nr_bollini2_sec_iva;noquote@</span>
        </formerror>
    </td>

    <td valign=top align=right class=form_title>Da matricola</td>
    <td valign=top><formwidget id="matricola_da2_sec_iva">
        <formerror  id="matricola_da2_a1_sec_iva"><br>
          <span class="errori">@formerror.matricola_da2_sec_iva;noquote@</span>
        </formerror>
    </td>
    <td valign=top align=right class=form_title>A matricola</td>
    <td valign=top><formwidget id="matricola_a2_sec_iva">
        <formerror  id="matricola_a2_a1_sec_iva"><br>
          <span class="errori">@formerror.matricola_a2_sec_iva;noquote@</span>
        </formerror>
    </td>

    <td valign=top align=right class=form_title>Costo unitario</td>
    <td valign=top><formwidget id="costo_unitario2_sec_iva">
                   <formerror  id="costo_unitario2_sec_iva"><br>
                   <span class="errori">@formerror.costo_unitario2_sec_iva;noquote@</span>
                   </formerror>
    </td>
    <td valign=top align=right class=form_title>Importo pagato</td>
    <td valign=top><formwidget id="imp_pagato2_sec_iva">
        <formerror id="imp_pagato2_sec_iva"><br>
        <span class="errori">@formerror.imp_pagato2_sec_iva;noquote@</span>
        </formerror>
    </td>
    <td valign=top align=right class=form_title>Pagati</td>
    <td valign=top><formwidget id="pagati2_sec_iva">
        <formerror id="pagati2_sec_iva"><br>
        <span class="errori">@formerror.pagati2_sec_iva;noquote@</span>
        </formerror>
    </td>
 </tr>

 <tr>
    <td align=center><b>Da 200 a 300 KW</b></td>
    <td valign=top align=right class=form_title>Nr bollini</td>
    <td valign=top><formwidget id="nr_bollini3_sec_iva">
        <formerror id="nr_bollini3_sec_iva"><br>
        <span class="errori">@formerror.nr_bollini3_sec_iva;noquote@</span>
        </formerror>
    </td>

    <td valign=top align=right class=form_title>Da matricola</td>
    <td valign=top><formwidget id="matricola_da3_sec_iva">
                   <formerror  id="matricola_da3_sec_iva"><br>
                   <span class="errori">@formerror.matricola_da3_sec_iva;noquote@</span>
                   </formerror>
    </td>

    <td valign=top align=right class=form_title>A matricola</td>
    <td valign=top><formwidget id="matricola_a3_sec_iva">
                   <formerror  id="matricola_a3_sec_iva"><br>
                   <span class="errori">@formerror.matricola_a3_sec_iva;noquote@</span>
                   </formerror>
    </td>

    <td valign=top align=right class=form_title>Costo unitario</td>
    <td valign=top><formwidget id="costo_unitario3_sec_iva">
                   <formerror  id="costo_unitario3_sec_iva"><br>
                   <span class="errori">@formerror.costo_unitario3_sec_iva;noquote@</span>
                   </formerror>
    </td>
    <td valign=top align=right class=form_title>Importo pagato</td>
    <td valign=top><formwidget id="imp_pagato3_sec_iva">
        <formerror id="imp_pagato3_sec_iva"><br>
        <span class="errori">@formerror.imp_pagato3_sec_iva;noquote@</span>
        </formerror>
    </td>
    <td valign=top align=right class=form_title>Pagati</td>
    <td valign=top><formwidget id="pagati3_sec_iva">
        <formerror id="pagati3_sec_iva"><br>
        <span class="errori">@formerror.pagati3_sec_iva;noquote@</span>
        </formerror>
    </td>
 </tr>

 <tr>
    <td align=center><b>Oltre 300 KW</b></td>

    <td valign=top align=right class=form_title>Nr bollini</td>
    <td valign=top><formwidget id="nr_bollini4_sec_iva">
        <formerror id="nr_bollini4_sec_iva"><br>
        <span class="errori">@formerror.nr_bollini4_sec_iva;noquote@</span>
        </formerror>
    </td>

    <td valign=top align=right class=form_title>Da matricola</td>
    <td valign=top><formwidget id="matricola_da4_sec_iva">
                   <formerror  id="matricola_da4_sec_iva"><br>
                   <span class="errori">@formerror.matricola_da4_sec_iva;noquote@</span>
                   </formerror>
    </td>
    <td valign=top align=right class=form_title>A matricola</td>
    <td valign=top><formwidget id="matricola_a4_sec_iva">
                   <formerror  id="matricola_a4_sec_iva"><br>
                   <span class="errori">@formerror.matricola_a4_sec_iva;noquote@</span>
                   </formerror>
    </td>
    <td valign=top align=right class=form_title>Costo unitario</td>
    <td valign=top><formwidget id="costo_unitario4_sec_iva">
                   <formerror  id="costo_unitario4_sec_iva"><br>
                   <span class="errori">@formerror.costo_unitario4_sec_iva;noquote@</span>
                   </formerror>
    </td>
    <td valign=top align=right class=form_title>Importo pagato</td>
    <td valign=top><formwidget id="imp_pagato4_sec_iva">
        <formerror id="imp_pagato4_sec_iva"><br>
        <span class="errori">@formerror.imp_pagato4_sec_iva;noquote@</span>
        </formerror>
    </td>
    <td valign=top align=right class=form_title>Pagati</td>
    <td valign=top><formwidget id="pagati4_sec_iva">
        <formerror id="pagati4_sec_iva"><br>
        <span class="errori">@formerror.pagati4_sec_iva;noquote@</span>
        </formerror>
    </td>
 </tr>

 <tr>
    <td align=center><b>Pompe di calore/macc.frigo da 12 a 100 KW</b></td>

    <td valign=top align=right class=form_title>Nr bollini</td>
    <td valign=top><formwidget id="nr_bollini5_sec_iva">
        <formerror id="nr_bollini5_sec_iva"><br>
        <span class="errori">@formerror.nr_bollini5_sec_iva;noquote@</span>
        </formerror>
    </td>

    <td valign=top align=right class=form_title>Da matricola</td>
    <td valign=top><formwidget id="matricola_da5_sec_iva">
        <formerror  id="matricola_da5_sec_iva"><br>
          <span class="errori">@formerror.matricola_da5_sec_iva;noquote@</span>
        </formerror>
    </td>

    <td valign=top align=right class=form_title>A matricola</td>
    <td valign=top><formwidget id="matricola_a5_sec_iva">
                   <formerror  id="matricola_a5_sec_iva"><br>
                   <span class="errori">@formerror.matricola_a5_sec_iva;noquote@</span>
                   </formerror>
    </td>

    <td valign=top align=right class=form_title>Costo unitario</td>
    <td valign=top><formwidget id="costo_unitario5_sec_iva">
                   <formerror  id="costo_unitario5_sec_iva"><br>
                   <span class="errori">@formerror.costo_unitario5_sec_iva;noquote@</span>
                   </formerror>
    </td>
    <td valign=top align=right class=form_title>Importo pagato</td>
    <td valign=top><formwidget id="imp_pagato5_sec_iva">
        <formerror id="imp_pagato5_sec_iva"><br>
        <span class="errori">@formerror.imp_pagato5_sec_iva;noquote@</span>
        </formerror>
    </td>
    <td valign=top align=right class=form_title>Pagati</td>
    <td valign=top><formwidget id="pagati5_sec_iva">
        <formerror id="pagati5_sec_iva"><br>
        <span class="errori">@formerror.pagati5_sec_iva;noquote@</span>
        </formerror>
    </td>
 </tr>

 <tr>
    <td align=center><b>Pompe di calore/macc.frigo > 100 KW</b></td>

    <td valign=top align=right class=form_title>Nr bollini</td>
    <td valign=top><formwidget id="nr_bollini7_sec_iva">
        <formerror id="nr_bollini7_sec_iva"><br>
        <span class="errori">@formerror.nr_bollini7_sec_iva;noquote@</span>
        </formerror>
    </td>

    <td valign=top align=right class=form_title>Da matricola</td>
    <td valign=top><formwidget id="matricola_da7_sec_iva">
                   <formerror  id="matricola_da7_sec_iva"><br>
                   <span class="errori">@formerror.matricola_da7_sec_iva;noquote@</span>
                   </formerror>
    </td>
    <td valign=top align=right class=form_title>A matricola</td>
    <td valign=top><formwidget id="matricola_a7_sec_iva">
                   <formerror  id="matricola_a7_sec_iva"><br>
                   <span class="errori">@formerror.matricola_a7_sec_iva;noquote@</span>
                   </formerror>
    </td>
    <td valign=top align=right class=form_title>Costo unitario</td>
    <td valign=top><formwidget id="costo_unitario7_sec_iva">
                   <formerror  id="costo_unitario7_sec_iva"><br>
                   <span class="errori">@formerror.costo_unitario7_sec_iva;noquote@</span>
                   </formerror>
    </td>
    <td valign=top align=right class=form_title>Importo pagato</td>
    <td valign=top><formwidget id="imp_pagato7_sec_iva">
        <formerror id="imp_pagato7_sec_iva"><br>
        <span class="errori">@formerror.imp_pagato7_sec_iva;noquote@</span>
        </formerror>
    </td>
    <td valign=top align=right class=form_title>Pagati</td>
    <td valign=top><formwidget id="pagati7_sec_iva">
        <formerror id="pagati7_sec_iva"><br>
        <span class="errori">@formerror.pagati7_sec_iva;noquote@</span>
        </formerror>
    </td>
</tr>
<!-- gab01 fine -->
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

