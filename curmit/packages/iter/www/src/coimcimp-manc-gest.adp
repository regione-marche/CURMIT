<!--
    USER  DATA       MODIFICHE
    ===== ========== =======================================================================
    rom01 11/06/2021 Aggiunti link per Stampare e storicizzare la stampa della mancata ispezione.
    rom01            Disponibile per tutti tranne che per le Marche.
-->

<master   src="../master">
<property name="title">@page_title;noquote@</property>
<property name="context_bar">@context_bar;noquote@</property>
<property name="riga_vuota">f</property>

@link_inc;noquote@
@link_tab;noquote@
@dett_tab;noquote@
<table width="100%" cellspacing=0 class=func-menu>
<!--rom01 Rimonssi tutti i width dei td-->
<tr>
   <td nowrap class=func-menu>
    <if  @flag_cimp@ ne "S"
     and @flag_inco@ ne "S">
           <a href="@pack_dir;noquote@/coimcimp-list?@link_list;noquote@" class=func-menu>Ritorna</a>

    </if>
    <else>
      <!--rom01  &nbsp;-->
    </else>
   </td>
   <if @funzione@ eq "I">
      <td nowrap class=func-menu>&nbsp;</td>
   </if>
   <else>
      <td nowrap class=@func_v;noquote@>
         <a href="coimcimp-manc-gest?funzione=V&@link_gest;noquote@" class=@func_v;noquote@>Visualizza</a>
      </td>
      <if @flag_modifica@ eq T>
          <td nowrap class=@func_m;noquote@>
             <a href="coimcimp-manc-gest?funzione=M&@link_gest;noquote@" class=@func_m;noquote@>Modifica</a>
          </td>
      </if>
      <else>
          <td nowrap class=func-menu>Modifica</td>
      </else>
      </td>
      <td nowrap class=@func_d;noquote@>
         <a href="coimcimp-manc-gest?funzione=D&@link_gest;noquote@" class=@func_d;noquote@>Cancella</a>
      </td>
      <if @coimtgen.regione@ ne "MARCHE"><!--rom01 Aggiunta if e contenuto-->
	<td nowrap class=func-menu>
	  <a href="coimcimp-manc-layout?@link_prnt;noquote@&flag_ins=N" class=func-menu target="Stampa Mancata Ispezione">Stampa</a>
	</td>
	<td nowrap class=func-menu>
	  <a href="coimcimp-manc-layout?@link_prn2;noquote@&flag_ins=S" class=func-menu target="Stampa Mancata Ispezione">Ins. Doc.</a>
	</td>
      </if><!--rom01-->
</else>
</tr>
</table>

<center>
<formtemplate id="@form_name;noquote@">
<formwidget   id="funzione">
<formwidget   id="caller">
<formwidget   id="nome_funz">
<formwidget   id="extra_par">
<formwidget   id="last_cod_cimp">
<formwidget   id="cod_impianto">
<formwidget   id="gen_prog">
<formwidget   id="url_aimp">
<formwidget   id="url_list_aimp">
<formwidget   id="flag_cimp">
<formwidget   id="extra_par_inco">
<formwidget   id="flag_inco">
<formwidget   id="cod_inco_old">
<formwidget   id="flag_modifica">
<formwidget   id="cod_cimp">

<!-- Inizio della form colorata -->
<%=[iter_form_iniz]%>
        <tr>
            <td nowrap valign=top  align=right class=form_title>Data mancata ispezione</td>
            <td valign=top><formwidget id="data_controllo">
                <formerror  id="data_controllo"><br>
                <span class="errori">@formerror.data_controllo;noquote@</span>
                </formerror>
            </td>
            <td valign=top align=right class=form_title>Aggiorna appuntamento</td>
            <td valign=top><formwidget id="cod_inco">@link_inco;noquote@
                <formerror  id="cod_inco"><br>
                <span class="errori">@formerror.cod_inco;noquote@</span>
                </formerror>
            </td>
        </tr>

        <tr>
            <td nowrap valign=top  align=right class=form_title>N. verbale</td>
            <td valign=top><formwidget id="verb_n">
                <formerror  id="verb_n"><br>
                <span class="errori">@formerror.verb_n;noquote@</span>
                </formerror>
            </td>
            <td colspan=2>&nbsp;</td>
        </tr>

        <tr>
            <td valign=top align=right class=form_title>Ispettore</td>
            <td valign=top colspan=3><formwidget id="cod_opve">
                <if @disabled_opve@ eq "disabled">
                    <formwidget id="des_opve">
                </if>
                <formerror  id="cod_opve"><br>
                <span class="errori">@formerror.cod_opve;noquote@</span>
                </formerror>
            </td>
        </tr>
        <tr>
            <td valign=top align=right class=form_title>Tipologia costo</td>
            <td valign=top ><formwidget id="tipologia_costo">
                <formerror  id="tipologia_costo"><br>
                <span class="errori">@formerror.tipologia_costo;noquote@</span>
                 </formerror>
            </td>

	    <td valign=top align=right class=form_title>Costo &#8364;</td>
	    <td valign=top><formwidget id="costo">
                <formerror  id="costo"><br>
                <span class="errori">@formerror.costo;noquote@</span>
                </formerror>
            </td>
	</tr>
	<tr>
	    <td valign=top align=right class=form_title>Riferimento pag.</td>
	    <td valign=top ><formwidget id="riferimento_pag">
	        <formerror  id="riferimento_pag"><br>
		<span class="errori">@formerror.riferimento_pag;noquote@</span>
		</formerror>
            </td>
	    <if @funzione@ eq I
	     or @funzione@ eq M>
                <td valign=top align=right class=form_title>Pagato</td>
		<td valign=top ><formwidget id="flag_pagato">
		    <formerror  id="flag_pagato"><br>
	            <span class="errori">@formerror.flag_pagato;noquote@</span>
		    </formerror>
                </td>
            </if>
	</tr>
        <tr>
            <td valign=top align=right class=form_title>Data scad. pagamento</td>
	    <td valign=top colspan=3><formwidget id="data_scad_pagamento">
	        <formerror  id="data_scad_pagamento"><br>
		<span class="errori">@formerror.data_scad_pagamento;noquote@</span>
		</formerror>
            </td>
	    <td>&nbsp;</td>
        </tr>
        <tr>
            <td valign=top align=right class=form_title>Motivazione</td>
	    <td valign=top colspan=3><formwidget id="cod_noin">
	        <formerror  id="cod_noin"><br>
		<span class="errori">@formerror.cod_noin;noquote@</span>
		</formerror>
            </td>
	    <td>&nbsp;</td>
        </tr>
   <tr>
            <td valign=top align=right class=form_title>Note</td>
	    <td valign=top colspan=3><formwidget id="note_verificatore">
	        <formerror  id="note_verificatore"><br>
		<span class="errori">@formerror.note_verificatore@</span>
		</formerror>
            </td>
	    <td>&nbsp;</td>
        </tr>

 

<if @funzione@ ne "V">
    <tr><td colspan=4 align=center><formwidget id="submit"></td></tr>
</if>

<!-- Fine della form colorata -->
<%=[iter_form_fine]%>

</formtemplate>
<p>
</center>

