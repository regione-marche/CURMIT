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
         <td width="25%" nowrap class=func-menu> 
                <a href="coimboap-list?@link_boap;noquote@" class=func-menu>Trasferimenti</a>
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

<tr><td valign=top align=right class=form_title>Nr bollini</td>
    <td valign=top><formwidget id="nr_bollini">
        <formerror id="nr_bollini"><br>
        <span class="errori">@formerror.nr_bollini;noquote@</span>
        </formerror>
    </td>
    <td valign=top align=right class=form_title>Nr bollini resi</td>
    <td valign=top><formwidget id="nr_bollini_resi">
        <formerror  id="nr_bollini_resi"><br>
        <span class="errori">@formerror.nr_bollini_resi;noquote@</span>
        </formerror>
    </td>
</tr>

<tr><td valign=top align=right class=form_title>Da matricola</td>
    <td valign=top><formwidget id="matricola_da">
        <formerror  id="matricola_da"><br>
        <span class="errori">@formerror.matricola_da;noquote@</span>
        </formerror>
    </td>
    <td valign=top align=right class=form_title>A matricola</td>
    <td valign=top><formwidget id="matricola_a">
        <formerror  id="matricola_a"><br>
        <span class="errori">@formerror.matricola_a;noquote@</span>
        </formerror>
    </td>
</tr>

<tr>
    <td valign=top align=right class=form_title>Data scadenza</td>
    <td valign=top><formwidget id="data_scadenza">
        <formerror  id="data_scadenza"><br>
        <span class="errori">@formerror.data_scadenza;noquote@</span>
        </formerror>
    </td>
    <td valign=top align=right class=form_title>Tipo bollino</td>
    <td valign=top><formwidget id="cod_tpbo">
        <formerror  id="cod_tpbo"><br>
        <span class="errori">@formerror.cod_tpbo;noquote@</span>
        </formerror>
    </td>
</tr>

<tr><td valign=top align=right class=form_title>Pagati</td>
    <td valign=top><formwidget id="pagati">
        <formerror  id="pagati"><br>
        <span class="errori">@formerror.pagati;noquote@</span>
        </formerror>
    </td>
    <td valign=top align=right class=form_title>Costo unitario</td>
    <td valign=top><formwidget id="costo_unitario">
        <formerror  id="costo_unitario"><br>
        <span class="errori">@formerror.costo_unitario;noquote@</span>
        </formerror>
    </td>
</tr>

<tr><td valign=top align=right class=form_title>Importo pagato</td>
    <td valign=top><formwidget id="imp_pagato">
        <formerror  id="imp_pagato"><br>
        <span class="errori">@formerror.imp_pagato;noquote@</span>
        </formerror>
    </td>
    <if @flag_ente@ eq C and @sigla_prov@ eq PD>
        <td valign=top align=right class=form_title>Importo dovuto</td>
        <td valign=top><formwidget id="imp_dovuto">
            <formerror  id="imp_dovuto"><br>
            <span class="errori">@formerror.imp_dovuto;noquote@</span>
            </formerror>
        </td>
    </if>
    <else>
        <td valign=top align=right class=form_title>Sconto</td>
        <td valign=top><formwidget id="imp_sconto">
            <formerror  id="imp_sconto"><br>
            <span class="errori">@formerror.imp_sconto;noquote@</span>
            </formerror>
        </td>
    </else>
</tr>

<tr><td valign=top align=right class=form_title>Tipologia</td>
    <td valign=top><formwidget id="cod_tpbl">
        <formerror  id="cod_tpbl"><br>
        <span class="errori">@formerror.cod_tpbl;noquote@</span>
        </formerror>
    </td>

    <if @coimtgen.ente@ eq "CRIMINI">
    <td valign=top align=right class=form_title>Data Pagamento</td>
    <td valign=top><formwidget id="data_pag">
        <formerror  id="data_pag"><br>
        <span class="errori">@formerror.data_pag;noquote@</span>
        </formerror>
    </td>
    </if>
</tr>


<if @coimtgen.ente@ eq "CRIMINI">
<tr><td valign=top align=right class=form_title>Modalità Pagamento</td>
    <td valign=top colspan=3><formwidget id="mod_pag">
        <formerror  id="mod_pag"><br>
        <span class="errori">@formerror.mod_pag;noquote@</span>
        </formerror>
    </td>
</tr>
</if>

<tr><td valign=top align=right class=form_title>Note</td>
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

