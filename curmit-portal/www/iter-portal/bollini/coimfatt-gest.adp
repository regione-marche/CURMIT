<master>
<property name="title">@page_title;noquote@</property>
<property name="riga_vuota">f</property>

<table width="100%" cellspacing=0 class=func-menu>
<tr>
<if @ritorna_gest@ eq "">
      <td nowrap class=func-menu>
          <a href="coimfatt-list?@link_list;noquote@" class=func-menu>Ritorna</a>
      </td>
</if>
<else>
   <td nowrap class=func-menu>
       <a href=@ritorna_gest;noquote@ class=func-menu>Ritorna</a>
   </td>
</else>
   <if @funzione@ eq "I">
      <td width="75%" nowrap class=func-menu>&nbsp;</td>
   </if>
   <else>
      <td width="25%" nowrap class=@func_v;noquote@>
         <a href="coimfatt-gest?funzione=V&@link_gest;noquote@" class=@func_v;noquote@>Visualizza</a>
      </td>
      <td width="25%" nowrap class=@func_m;noquote@>
         <a href="coimfatt-gest?funzione=M&@link_gest;noquote@" class=@func_m;noquote@>Modifica Testata Fattura</a>
      </td>
      <td width="25%" nowrap class=@func_d;noquote@>
         <a href="coimfatt-gest?funzione=D&@link_gest;noquote@" class=@func_d;noquote@>Cancella</a>
      </td>
   </else>
</tr>
<if @funzione@ ne "I">
        <td width="25%" nowrap class=func-menu> 
            <a href="coimfatt-layout?@link_stampa;noquote@" class=func-menu>Stampa fattura</a>
        </td>
	    <td colspan=2 class=func-menu>&nbsp;</td>
        </if>
    </tr>
</table>

<center>
<formtemplate id="@form_name;noquote@">
<formwidget   id="funzione">
<formwidget   id="caller">
<formwidget   id="nome_funz">
<formwidget   id="nome_funz_caller">
<formwidget   id="extra_par">
<formwidget   id="last_cod_fatt">
<formwidget   id="cod_fatt">
<formwidget   id="tipo_sogg">
<formwidget   id="cod_sogg">

<!-- Inizio della form colorata -->
<%=[iter_form_iniz]%>

<!-- TODO: Ricordare di posizionare gli eventuali link ai pgm di zoom -->

<tr><td valign=top align=right class=form_title>Data fattura</td>
    <td valign=top><formwidget id="data_fatt">
        <formerror  id="data_fatt"><br>
        <span class="errori">@formerror.data_fatt;noquote@</span>
        </formerror>
    </td>

    <td valign=top align=right class=form_title>Numero fattura</td>
    <td valign=top><formwidget id="num_fatt">
        <formerror  id="num_fatt"><br>
        <span class="errori">@formerror.num_fatt;noquote@</span>
        </formerror>
    </td>
</tr>

<tr><td valign=top align=right class=form_title>Manutentore</td>
    <td valign=top colspan=5><formwidget id="manutentore"><if @crea_bollini@ eq "t">@cerca_manu;noquote@</if>
        <formerror  id="manutentore"><br>
        <span class="errori">@formerror.manutentore;noquote@</span>
        </formerror>
    </td>
</tr>

<%=[iter_form_fine]%>


<%=[iter_form_iniz]%>

<tr><td valign=top align=right class=form_title>Imp. fattura</td>
    <td valign=top><formwidget id="imponibile">
        <formerror  id="imponibile"><br>
        <span class="errori">@formerror.imponibile;noquote@</span>
        </formerror>
    </td>
    <td valign=top align=right class=form_title>Tot. bollini</td>
    <td valign=top><formwidget id="n_bollini">
        <formerror  id="n_bollini"><br>
        <span class="errori">@formerror.n_bollini</span>
        </formerror>
    </td>
</tr>

<tr><td valign=top align=right class=form_title>Pagato</td>
    <td valign=top><formwidget id="flag_pag">
        <formerror  id="flag_pag"><br>
        <span class="errori">@formerror.flag_pag;noquote@</span>
        </formerror>
    </td>
    <td valign=top align=right class=form_title>Modalità di pagamento</td>
    <td valign=top><formwidget id="mod_pag">
        <formerror  id="mod_pag"><br>
        <span class="errori">@formerror.mod_pag;noquote@</span>
        </formerror>
    </td>
</tr>

<!-- gab02 aggiunte Spese postali -->
<tr><td valign=top align=right class=form_title>Spese postali</td>
    <td valign=top><formwidget id="spe_postali">
        <formerror  id="spe_postali"><br>
        <span class="errori">@formerror.spe_postali;noquote@</span>
        </formerror>
    </td>
</tr>

<tr><td valign=top align=right class=form_title>Nota</td>
    <td colspan=3 valign=top><formwidget id="nota">
        <formerror  id="nota"><br>
        <span class="errori">@formerror.nota</span>
        </formerror>
    </td>
</tr>

<%=[iter_form_fine]%>

<%=[iter_form_iniz]%>

<!-- gab01 aggiunto titolo-->
<h2>IVA 10%</h2>

 <tr>
   <td width=15% align=center ><b>Da 10 a 100 KW</b></td>
    <td width=10% valign=top align=right class=form_title>Nr. bollini</td>
    <td width=11% valign=top><formwidget id="n_bollini1">
        <formerror  id="n_bollini1"><br>
        <span class="errori">@formerror.n_bollini1</span>
        </formerror>
    </td>
   
    <td width=10% valign=top align=right class=form_title>Da matricola</td>
    <td width=11% valign=top><formwidget id="matr_da1">
        <formerror  id="matr_da1"><br>
        <span class="errori">@formerror.matr_da1;noquote@</span>
        </formerror>
    </td>

    <td width=10% valign=top align=right class=form_title>A matricola</td>
    <td width=11% valign=top><formwidget id="matr_a1">
        <formerror  id="matr_a1"><br>
        <span class="errori">@formerror.matr_a1;noquote@</span>
        </formerror>
    </td>

    <td valign=top align=right class=form_title>Imp. bollini</td>
    <td valign=top><formwidget id="imp_pagato1">
        <formerror id="imp_pagato1"><br>
        <span class="errori">@formerror.imp_pagato1;noquote@</span>
        </formerror>
    </td>
 </tr>
 <tr>
   <td align=center><b>Da 100 a 200 KW</b></td>
    <td width=10% valign=top align=right class=form_title>Nr. bollini</td>
    <td width=11% valign=top><formwidget id="n_bollini2">
        <formerror  id="n_bollini2"><br>
        <span class="errori">@formerror.n_bollini2</span>
        </formerror>
    </td>
   
    <td width=10% valign=top align=right class=form_title>Da matricola</td>
    <td width=11% valign=top><formwidget id="matr_da2">
        <formerror  id="matr_da2"><br>
        <span class="errori">@formerror.matr_da2;noquote@</span>
        </formerror>
    </td>

    <td width=10% valign=top align=right class=form_title>A matricola</td>
    <td width=11% valign=top><formwidget id="matr_a2">
        <formerror  id="matr_a2"><br>
        <span class="errori">@formerror.matr_a2;noquote@</span>
        </formerror>
    </td>

    <td valign=top align=right class=form_title>Imp. bollini</td>
    <td valign=top><formwidget id="imp_pagato2">
        <formerror id="imp_pagato2"><br>
        <span class="errori">@formerror.imp_pagato2;noquote@</span>
        </formerror>
    </td>
</tr>

<tr>
  <td align=center><b>Da 200 a 300 KW</b></td>
    <td width=10% valign=top align=right class=form_title>Nr. bollini</td>
    <td width=11% valign=top><formwidget id="n_bollini3">
        <formerror  id="n_bollini3"><br>
        <span class="errori">@formerror.n_bollini3</span>
        </formerror>
    </td>
   
    <td width=10% valign=top align=right class=form_title>Da matricola</td>
    <td width=11% valign=top><formwidget id="matr_da3">
        <formerror  id="matr_da3"><br>
        <span class="errori">@formerror.matr_da3;noquote@</span>
        </formerror>
    </td>

    <td width=10% valign=top align=right class=form_title>A matricola</td>
    <td width=11% valign=top><formwidget id="matr_a3">
        <formerror  id="matr_a3"><br>
        <span class="errori">@formerror.matr_a3;noquote@</span>
        </formerror>
    </td>

    <td valign=top align=right class=form_title>Imp. bollini</td>
    <td valign=top><formwidget id="imp_pagato3">
        <formerror id="imp_pagato3"><br>
        <span class="errori">@formerror.imp_pagato3;noquote@</span>
        </formerror>
    </td>
</tr>

<tr>
  <td align=center><b>Oltre 300 KW</b></td>
    <td width=10% valign=top align=right class=form_title>Nr. bollini</td>
    <td width=11% valign=top><formwidget id="n_bollini4">
        <formerror  id="n_bollini4"><br>
        <span class="errori">@formerror.n_bollini4</span>
        </formerror>
    </td>
   
    <td width=10% valign=top align=right class=form_title>Da matricola</td>
    <td width=11% valign=top><formwidget id="matr_da4">
        <formerror  id="matr_da4"><br>
        <span class="errori">@formerror.matr_da4;noquote@</span>
        </formerror>
    </td>

    <td width=10% valign=top align=right class=form_title>A matricola</td>
    <td width=11% valign=top><formwidget id="matr_a4">
        <formerror  id="matr_a4"><br>
        <span class="errori">@formerror.matr_a4;noquote@</span>
        </formerror>
    </td>

    <td valign=top align=right class=form_title>Imp. bollini</td>
    <td valign=top><formwidget id="imp_pagato4">
        <formerror id="imp_pagato4"><br>
        <span class="errori">@formerror.imp_pagato4;noquote@</span>
        </formerror>
    </td>
</tr>

<tr>
  <td align=center><b>Pompe di calore/macc.frigo da 12 a 100 KW</b></td>
    <td width=10% valign=top align=right class=form_title>Nr. bollini</td>
    <td width=11% valign=top><formwidget id="n_bollini5">
        <formerror  id="n_bollini5"><br>
        <span class="errori">@formerror.n_bollini5</span>
        </formerror>
    </td>
   
    <td width=10% valign=top align=right class=form_title>Da matricola</td>
    <td width=11% valign=top><formwidget id="matr_da5">
        <formerror  id="matr_da5"><br>
        <span class="errori">@formerror.matr_da5;noquote@</span>
        </formerror>
    </td>

    <td width=10% valign=top align=right class=form_title>A matricola</td>
    <td width=11% valign=top><formwidget id="matr_a5">
        <formerror  id="matr_a5"><br>
        <span class="errori">@formerror.matr_a5;noquote@</span>
        </formerror>
    </td>

    <td valign=top align=right class=form_title>Imp. bollini</td>
    <td valign=top><formwidget id="imp_pagato5">
        <formerror id="imp_pagato5"><br>
        <span class="errori">@formerror.imp_pagato5;noquote@</span>
        </formerror>
    </td>
</tr>
<!-- disattivato la fascia
<tr>
    <td width=10% valign=top align=right class=form_title>Nr. bollini <br>fr. 35-100 KW</td>
    <td width=11% valign=top><formwidget id="n_bollini6">
        <formerror  id="n_bollini6"><br>
        <span class="errori">@formerror.n_bollini6</span>
        </formerror>
    </td>
   
    <td width=10% valign=top align=right class=form_title>Da matricola</td>
    <td width=11% valign=top><formwidget id="matr_da6">
        <formerror  id="matr_da6"><br>
        <span class="errori">@formerror.matr_da6;noquote@</span>
        </formerror>
    </td>

    <td width=10% valign=top align=right class=form_title>A matricola</td>
    <td width=11% valign=top><formwidget id="matr_a6">
        <formerror  id="matr_a6"><br>
        <span class="errori">@formerror.matr_a6;noquote@</span>
        </formerror>
    </td>

    <td valign=top align=right class=form_title>Imp. bollini</td>
    <td valign=top><formwidget id="imp_pagato6">
        <formerror id="imp_pagato6"><br>
        <span class="errori">@formerror.imp_pagato6;noquote@</span>
        </formerror>
    </td>
</tr>

-->
<tr>
<td align=center><b>Pompe di calore/macc.frigo > 100 KW</b></td>
    <td width=10% valign=top align=right class=form_title>Nr. bollini</td>
    <td width=11% valign=top><formwidget id="n_bollini7">
        <formerror  id="n_bollini7"><br>
        <span class="errori">@formerror.n_bollini7</span>
        </formerror>
    </td>
   
    <td width=10% valign=top align=right class=form_title>Da matricola</td>
    <td width=11% valign=top><formwidget id="matr_da7">
        <formerror  id="matr_da7"><br>
        <span class="errori">@formerror.matr_da7;noquote@</span>
        </formerror>
    </td>

    <td width=10% valign=top align=right class=form_title>A matricola</td>
    <td width=11% valign=top><formwidget id="matr_a7">
        <formerror  id="matr_a7"><br>
        <span class="errori">@formerror.matr_a7;noquote@</span>
        </formerror>
    </td>

    <td valign=top align=right class=form_title>Imp. bollini</td>
    <td valign=top><formwidget id="imp_pagato7">
        <formerror id="imp_pagato7"><br>
        <span class="errori">@formerror.imp_pagato7;noquote@</span>
        </formerror>
    </td>
</tr>


<%=[iter_form_fine]%>

<!-- gab01 sezione con diversa categoria di iva -->
<!-- gab01 inizio -->
<%=[iter_form_iniz]%>
<!-- gab01 aggiunto titolo-->
<h2>IVA 22%</h2>

 <tr>
   <td width=15% align=center ><b>Da 10 a 100 KW</b></td>
    <td width=10% valign=top align=right class=form_title>Nr. bollini</td>
    <td width=11% valign=top><formwidget id="n_bollini1_sec_iva">
        <formerror  id="n_bollini1_sec_iva"><br>
        <span class="errori">@formerror.n_bollini1_sec_iva</span>
        </formerror>
    </td>
   
    <td width=10% valign=top align=right class=form_title>Da matricola</td>
    <td width=11% valign=top><formwidget id="matr_da1_sec_iva">
        <formerror  id="matr_da1_sec_iva"><br>
        <span class="errori">@formerror.matr_da1_sec_iva;noquote@</span>
        </formerror>
    </td>

    <td width=10% valign=top align=right class=form_title>A matricola</td>
    <td width=11% valign=top><formwidget id="matr_a1_sec_iva">
        <formerror  id="matr_a1_sec_iva"><br>
        <span class="errori">@formerror.matr_a1_sec_iva;noquote@</span>
        </formerror>
    </td>

    <td valign=top align=right class=form_title>Imp. bollini</td>
    <td valign=top><formwidget id="imp_pagato1_sec_iva">
        <formerror id="imp_pagato1_sec_iva"><br>
        <span class="errori">@formerror.imp_pagato1_sec_iva;noquote@</span>
        </formerror>
    </td>
 </tr>
 <tr>
   <td align=center><b>Da 100 a 200 KW</b></td>
    <td width=10% valign=top align=right class=form_title>Nr. bollini</td>
    <td width=11% valign=top><formwidget id="n_bollini2_sec_iva">
        <formerror  id="n_bollini2_sec_iva"><br>
        <span class="errori">@formerror.n_bollini2_sec_iva</span>
        </formerror>
    </td>
   
    <td width=10% valign=top align=right class=form_title>Da matricola</td>
    <td width=11% valign=top><formwidget id="matr_da2_sec_iva">
        <formerror  id="matr_da2_sec_iva"><br>
        <span class="errori">@formerror.matr_da2_sec_iva;noquote@</span>
        </formerror>
    </td>

    <td width=10% valign=top align=right class=form_title>A matricola</td>
    <td width=11% valign=top><formwidget id="matr_a2_sec_iva">
        <formerror  id="matr_a2_sec_iva"><br>
        <span class="errori">@formerror.matr_a2_sec_iva;noquote@</span>
        </formerror>
    </td>

    <td valign=top align=right class=form_title>Imp. bollini</td>
    <td valign=top><formwidget id="imp_pagato2_sec_iva">
        <formerror id="imp_pagato2_sec_iva"><br>
        <span class="errori">@formerror.imp_pagato2_sec_iva;noquote@</span>
        </formerror>
    </td>
</tr>

<tr>
  <td align=center><b>Da 200 a 300 KW</b></td>
    <td width=10% valign=top align=right class=form_title>Nr. bollini</td>
    <td width=11% valign=top><formwidget id="n_bollini3_sec_iva">
        <formerror  id="n_bollini3_sec_iva"><br>
        <span class="errori">@formerror.n_bollini3_sec_iva</span>
        </formerror>
    </td>
   
    <td width=10% valign=top align=right class=form_title>Da matricola</td>
    <td width=11% valign=top><formwidget id="matr_da3_sec_iva">
        <formerror  id="matr_da3_sec_iva"><br>
        <span class="errori">@formerror.matr_da3_sec_iva;noquote@</span>
        </formerror>
    </td>

    <td width=10% valign=top align=right class=form_title>A matricola</td>
    <td width=11% valign=top><formwidget id="matr_a3_sec_iva">
        <formerror  id="matr_a3_sec_iva"><br>
        <span class="errori">@formerror.matr_a3_sec_iva;noquote@</span>
        </formerror>
    </td>

    <td valign=top align=right class=form_title>Imp. bollini</td>
    <td valign=top><formwidget id="imp_pagato3_sec_iva">
        <formerror id="imp_pagato3_sec_iva"><br>
        <span class="errori">@formerror.imp_pagato3_sec_iva;noquote@</span>
        </formerror>
    </td>
</tr>

<tr>
  <td align=center><b>Oltre 300 KW</b></td>
    <td width=10% valign=top align=right class=form_title>Nr. bollini</td>
    <td width=11% valign=top><formwidget id="n_bollini4_sec_iva">
        <formerror  id="n_bollini4_sec_iva"><br>
        <span class="errori">@formerror.n_bollini4_sec_iva</span>
        </formerror>
    </td>
   
    <td width=10% valign=top align=right class=form_title>Da matricola</td>
    <td width=11% valign=top><formwidget id="matr_da4_sec_iva">
        <formerror  id="matr_da4_sec_iva"><br>
        <span class="errori">@formerror.matr_da4_sec_iva;noquote@</span>
        </formerror>
    </td>

    <td width=10% valign=top align=right class=form_title>A matricola</td>
    <td width=11% valign=top><formwidget id="matr_a4_sec_iva">
        <formerror  id="matr_a4_sec_iva"><br>
        <span class="errori">@formerror.matr_a4_sec_iva;noquote@</span>
        </formerror>
    </td>

    <td valign=top align=right class=form_title>Imp. bollini</td>
    <td valign=top><formwidget id="imp_pagato4_sec_iva">
        <formerror id="imp_pagato4_sec_iva"><br>
        <span class="errori">@formerror.imp_pagato4_sec_iva;noquote@</span>
        </formerror>
    </td>
</tr>

<tr>
  <td align=center><b>Pompe di calore/macc.frigo da 12 a 100 KW</b></td>
    <td width=10% valign=top align=right class=form_title>Nr. bollini</td>
    <td width=11% valign=top><formwidget id="n_bollini5_sec_iva">
        <formerror  id="n_bollini5_sec_iva"><br>
        <span class="errori">@formerror.n_bollini5_sec_iva</span>
        </formerror>
    </td>
   
    <td width=10% valign=top align=right class=form_title>Da matricola</td>
    <td width=11% valign=top><formwidget id="matr_da5_sec_iva">
        <formerror  id="matr_da5_sec_iva"><br>
        <span class="errori">@formerror.matr_da5_sec_iva;noquote@</span>
        </formerror>
    </td>

    <td width=10% valign=top align=right class=form_title>A matricola</td>
    <td width=11% valign=top><formwidget id="matr_a5_sec_iva">
        <formerror  id="matr_a5_sec_iva"><br>
        <span class="errori">@formerror.matr_a5_sec_iva;noquote@</span>
        </formerror>
    </td>

    <td valign=top align=right class=form_title>Imp. bollini</td>
    <td valign=top><formwidget id="imp_pagato5_sec_iva">
        <formerror id="imp_pagato5_sec_iva"><br>
        <span class="errori">@formerror.imp_pagato5_sec_iva;noquote@</span>
        </formerror>
    </td>
</tr>
<tr>
  <td align=center><b>Pompe di calore/macc.frigo > 100 KW</b></td>
    <td width=10% valign=top align=right class=form_title>Nr. bollini</td>
    <td width=11% valign=top><formwidget id="n_bollini7_sec_iva">
        <formerror  id="n_bollini7_sec_iva"><br>
        <span class="errori">@formerror.n_bollini7_sec_iva</span>
        </formerror>
    </td>
   
    <td width=10% valign=top align=right class=form_title>Da matricola</td>
    <td width=11% valign=top><formwidget id="matr_da7_sec_iva">
        <formerror  id="matr_da7_sec_iva"><br>
        <span class="errori">@formerror.matr_da7_sec_iva;noquote@</span>
        </formerror>
    </td>

    <td width=10% valign=top align=right class=form_title>A matricola</td>
    <td width=11% valign=top><formwidget id="matr_a7_sec_iva">
        <formerror  id="matr_a7_sec_iva"><br>
        <span class="errori">@formerror.matr_a7_sec_iva;noquote@</span>
        </formerror>
    </td>

    <td valign=top align=right class=form_title>Imp. bollini</td>
    <td valign=top><formwidget id="imp_pagato7_sec_iva">
        <formerror id="imp_pagato7_sec_iva"><br>
        <span class="errori">@formerror.imp_pagato7_sec_iva;noquote@</span>
        </formerror>
    </td>
</tr>
<!-- gab01 fine -->

<%=[iter_form_fine]%>

<%=[iter_form_iniz]%>
 <tr><td>&nbsp;</td></tr>

 <if @funzione@ ne "V">
    <tr><td align=center><formwidget id="submit"></td></tr>
 </if>
<%=[iter_form_fine]%>
<!-- Fine della form colorata -->

</formtemplate>
<p>
</center>



