<!--
    USER  DATA       MODIFICHE
    ===== ========== =================================================================================
-->

<master   src="../master">
<property name="title">@page_title;noquote@</property>
<property name="context_bar">@context_bar;noquote@</property>
<property name="riga_vuota">f</property>
<property name="focus_field">@focus_field;noquote@</property>

<center>
<formtemplate id="@form_name;noquote@">
<formwidget   id="funzione">
<formwidget   id="caller">
<formwidget   id="nome_funz">
<formwidget   id="nome_funz_caller">
<formwidget   id="extra_par">
<formwidget   id="last_gen_prog">
<formwidget   id="cod_impianto">
<formwidget   id="url_list_aimp">
<formwidget   id="gen_prog_old">
<formwidget   id="__refreshing_p">
<formwidget   id="changed_field"> 

@link_tab;noquote@
@dett_tab;noquote@
<table width="100%" cellspacing=0 class=func-menu>
<tr>
<td width="25%" nowrap class=@func_i;noquote@>Sostituzione generatore esistente</td>
       <td width="25%" nowrap class=func-menu>Visualizza</td>
       <td width="25%" nowrap class=func-menu>Modifica</td>
       <td width="25%" nowrap class=func-menu>Cancella</td>
</tr>
</table>

<if @funzione@ eq I>
<table >
  <tr>
    <td>
      <table width="100%">
	<tr>
	  <td><big><b>ATTENZIONE</b>:inserire un ulteriore generatore solo se fa parte dello stsso impianto del/dei generatore/i gi&agrave; inserito/i.<br>Le potenze nominali utili saranno sommate in un unico Rapporto di controllo dell'efficienza energetica (<a href="#" onclick="javascript:window.open('coimgend-ins-help', 'help', 'scrollbars=yes, esizable=yes, width=580, height=320').moveTo(110,140)"><u>clicca qui per maggiori dettagli</u></a>).<br>Se il nuovo generatore non fa perte dello stesso impianto, vai al men&ugrave; "Inserisci nuovo impianto".</big></td>
	</tr>
      </table>
    </td>
  </tr>
</table>
</if>

<table border=0>

<tr><td colspan=6 class=func-menu-yellow2><b>Scheda 1.3: Generatore destinato a soddisfare i seguenti servizi</b></td></tr>
<tr><td valign=top align=right class=form_title>Destinazione d'uso <font color=red>@cod_utgi_asterisco@</font></td>
    <td valign=top colspan=3><formwidget id="cod_utgi">
        <formerror  id="cod_utgi"><br>
        <span class="errori">@formerror.cod_utgi;noquote@</span>
        </formerror>
    </td>
    <td valign=top align=right class=form_title></td>
    <td valign=top>
    </td>
</tr>
<if @flag_tipo_impianto@ eq "R">
<tr><td colspan=6 class=func-menu-yellow2><b>Scheda 4.1: Dati del Gruppo Termico/Generatore</b></td></tr> 
</if>
<if @flag_tipo_impianto@ eq "F">
<tr><td colspan=6 class=func-menu-yellow2><b>Scheda 4.4:</b></td></tr>
</if>
<if @flag_tipo_impianto@ eq "T">
<tr><td colspan=6 class=func-menu-yellow2><b>Scheda 4.5:</b></td></tr>
</if>
<if @flag_tipo_impianto@ eq "C"> 
<tr><td colspan=6 class=func-menu-yellow2><b>Scheda 4.6:</b></td></tr>
</if>
<tr>
    <if @coimtgen.regione@ eq "MARCHE">
      <td valign=top align=right class=form_title>Gruppo termico numero</td>
      <td valign=bottom><formwidget id="gen_prog_est">
          <formerror  id="gen_prog_est"><br>
            <span class="errori">@formerror.gen_prog_est;noquote@</span>
        </formerror>
      </td>
    </if>
    <else>
      <td valign=top align=right class=form_title>Gruppo termico numero</td>
      <td valign=top><formwidget id="gen_prog">
          <formerror  id="gen_prog"><br>
            <span class="errori">@formerror.gen_prog;noquote@</span>
          </formerror>
      </td>
    </else>
    <td valign=top align=right class=form_title>Descrizione</td>
    <td valign=top colspan=3><formwidget id="descrizione">
        <formerror  id="descrizione"><br>
        <span class="errori">@formerror.descrizione;noquote@</span>
        </formerror>
    </td>
</tr>
<tr>
<if @coimtgen.regione@ ne "MARCHE" > 
    <td valign=top align=right class=form_title>Data costruzione <font color=red>@data_costruz_gen_asterisco@</font></td>
    <td valign=top><formwidget id="data_costruz_gen">
        <formerror  id="data_costruz_gen"><br>
        <span class="errori">@formerror.data_costruz_gen;noquote@</span>
        </formerror>
    </td>
</if>
    <td valign=top align=right class=form_title>Data installazione <font color=red>@data_installaz_asterisco@</font></td>
    <td valign=top><formwidget id="data_installaz">
        <formerror  id="data_installaz"><br>
        <span class="errori">@formerror.data_installaz;noquote@</span>
        </formerror>
    </td>
    <td valign=top align=right nowrap class=form_title>Data dismissione</td>
    <td valign=top><formwidget id="data_rottamaz">
        <formerror  id="data_rottamaz"><br>
        <span class="errori">@formerror.data_rottamaz;noquote@</span>
        </formerror>
    </td>
</tr>
<tr><td valign=top align=right class=form_title>Attivo</td>
    <td valign=top><formwidget id="flag_attivo">
        <formerror  id="flag_attivo"><br>
        <span class="errori">@formerror.flag_attivo;noquote@</span>
        </formerror>
    </td>
     <if @flag_tipo_impianto@ eq "R"><!-- dpr74 --> 
        <td valign=top align=right class=form_title>Tipo gruppo termico</td>
    	<td valign=top colspan=3><formwidget id="cod_grup_term">
	   <formerror  id="cod_grup_term"><br>
           <span class="errori">@formerror.cod_grup_term;noquote@</span>
	   </formerror>	</td>
    </if>
    <elseif @flag_tipo_impianto@ eq "C"> <!--gac01 aggiunto elseif, else e suo contenuto-->
      <td valign=top align=right class=form_title>Tipologia</td>
    	<td valign=top colspan=3><formwidget id="tipologia_cogenerazione">
	   <formerror  id="tipologia_cogenerazione"><br>
           <span class="errori">@formerror.tipologia_cogenerazione;noquote@</span>
	   </formerror>	</td>
    </elseif>
    <else>
      <td colspan=2></td>
      <td colspan=2></td>      
    </else>
</tr>
<tr>
<!--rom08    <td valign=top align=right class=form_title>Costruttore <font color=red>@cod_cost_asterisco@</font></td><!-- gab01 ->-->
<td valign=top align=right class=form_title>Fabbricante<font color=red>@cod_cost_asterisco@</font></td><!--rom08-->
    <td valign=top><formwidget id="cod_cost">
        <formerror  id="cod_cost"><br>
        <span class="errori">@formerror.cod_cost;noquote@</span>
        </formerror>
    </td>
    <td valign=top align=right class=form_title>Modello<font color=red>*</font></td><!-- gab01 -->

    <if @coimtgen.flag_gest_coimmode@ eq "F"><!-- nic01 -->
        <td valign=top><formwidget id="modello">
    	    <formerror  id="modello"><br>
            <span class="errori">@formerror.modello;noquote@</span>
	    </formerror>
	</td>
        <formwidget id="cod_mode"><!-- nic01 -->
    </if>
    <else><!-- nic01 -->
        <td valign=top><formwidget id="cod_mode"><!-- nic01 -->
    	    <formerror  id="cod_mode"><br><!-- nic01 -->
            <span class="errori">@formerror.cod_mode;noquote@</span><!-- nic01 -->
	    </formerror><!-- nic01 -->
	</td><!-- nic01 -->
        <formwidget id="modello"><!-- nic01 -->
    </else>
  
    <td valign=top align=right class=form_title>Matricola<font color=red>*</font></td><!-- gab01 -->
    <td valign=top><formwidget id="matricola">
        <formerror  id="matricola"><br>
        <span class="errori">@formerror.matricola;noquote@</span>
        </formerror>
    </td>
</tr>
<if @flag_tipo_impianto@ ne "F">
<tr><td valign=top align=right class=form_title>Combustibile <font color=red>@cod_combustibile_asterisco@</font></td><!-- gab01 -->
    <td valign=top><formwidget id="cod_combustibile">
        <formerror  id="cod_combustibile"><br>
        <span class="errori">@formerror.cod_combustibile;noquote@</span>
        </formerror>
    </td>
    <if @flag_tipo_impianto@ eq "R">
<!--rom08    <td valign=top align=right class=form_title>Numero prove fumi<font color=red>*</font></td>-->
<td valign=top align=right class=form_title>Numero analisi prove fumi previste<font color=red>*</font></td><!--rom08-->
    <td valign=top colspan=3><formwidget id="num_prove_fumi">
           <formerror  id="num_prove_fumi"><br>
           <span class="errori">@formerror.num_prove_fumi;noquote@</span>
           </formerror>
        @link_coimgend_pote;noquote@
    </td>
    </tr>
    </if> 
    <if @flag_tipo_impianto@ eq "T">
      </tr>
    </if>

</if>
<!-- gac01 aggiunta if e suo contenuto -->
    <if @flag_tipo_impianto@ ne "C" and @flag_tipo_impianto@ ne "F">
        <td valign=top align=right class=form_title>Fluido termovettore <font color=red>@mod_funz_asterisco@</font></td><!-- gab01 -->
    <td valign=top><formwidget id="mod_funz">
        <formerror  id="mod_funz"><br>
        <span class="errori">@formerror.mod_funz;noquote@</span>
        </formerror>
    </td>
          <td valign=top align=right class=form_title>Se Altro specificare</td><!--gac03-->
          <td valign=top><formwidget id="altro_funz">
             <formerror  id="altro_funz"><br>
             <span class="errori">@formerror.altro_funz;noquote@</span>
             </formerror>
	  </td>
       </tr>
    </if>
    <else>
      <td colspan=2></td>
    </else>
<!-- fine gac01-->


    <tr>
    <if @coimtgen.regione@ eq "MARCHE">
    <td valign=top align=right class=form_title>Potenza termica utile nomiale<font color=red>*</font></td><!--gac03-->
    <td valign=top><formwidget id="pot_utile_nom">
        <formerror  id="pot_utile_nom"><br>
        <span class="errori">@formerror.pot_utile_nom;noquote@</span>
        </formerror>
    </td>
    <td valign=top nowrap align=right class=form_title>Potenza termica al focolare nominale<font color=red>*</font></td><!--gac03-->
    <td valign=top><formwidget id="pot_focolare_nom">
        <formerror  id="pot_focolare_nom"><br>
        <span class="errori">@formerror.pot_focolare_nom;noquote@</span>
        </formerror>
    </td>

    </if><else>

  <td colspan=6>
    <table border=0>
 <tr><td valign=top  nowrap align=left class=form_title>Potenza a libretto: &nbsp; focolare (kW)</td>
         <td valign=top><formwidget id="pot_focolare_lib">
          <formerror  id="pot_focolare_lib"><br>
          <span class="errori">@formerror.pot_focolare_lib;noquote@</span>
          </formerror>
         </td>
         <td valign=top align=right class=form_title>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;</td>
         <td valign=top align=right class=form_title>utile (kW)</td>
         <td valign=top><formwidget id="pot_utile_lib">
           <formerror  id="pot_utile_lib"><br>
           <span class="errori">@formerror.pot_utile_lib;noquote@</span>
           </formerror>
         </td>
    </tr>
    <tr>
    <td valign=top nowrap align=left class=form_title>Potenza nominale: &nbsp; focolare (kW)<font color=red>*</font>
    </td>
    <td valign=top><formwidget id="pot_focolare_nom">
        <formerror  id="pot_focolare_nom"><br>
        <span class="errori">@formerror.pot_focolare_nom;noquote@</span>
        </formerror>
    </td>
    <td valign=top align=right class=form_title>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; </td>
    <td valign=top align=right class=form_title>utile (kW)<font color=red>*</font></td> 
    <td valign=top><formwidget id="pot_utile_nom">
        <formerror  id="pot_utile_nom"><br>
        <span class="errori">@formerror.pot_utile_nom;noquote@</span>
        </formerror>
    </td>
    </tr>
    </table> 
    </tr>
    </else>
<if @flag_tipo_impianto@ eq "R">
  <if @evidenzia_rend_ter@ eq "t"> <!-- rom03 aggiunta if e suo contenuto , aggiunta else-->
    <td valign=top align=right class=form_title colspan=2>
        <table width="100%" cellspacing=0 cellpadding=0>
                <tr>
                        
                        <td>
                        <table width="100%" style="border-width:2px; border-style:solid;" bordercolor="red" cellspacing="0" cellpadding="2">
                        <tr>
			   <td valign=top align=right class=form_title>Rendimento termico utile a Pn max (%)<font color=red>*</font></td>
                           <td colspan=2 valign=top><formwidget id="rend_ter_max">
                              <formerror  id="rend_ter_max"><br>
                              <span class="errori">@formerror.rend_ter_max;noquote@</span>
                              </formerror>
                           </td>
                        </tr>
                        </table>
                        </td>
                        <td width="30%">&nbsp;</td>
                </tr>
        </table>
    </td>
  </if>
  <else>
    <td valign=top align=right class=form_title>Rendimento termico utile a Pn max (%)<font color=red>*</font></td>
        <td colspan=2 valign=top><formwidget id="rend_ter_max">
            <formerror  id="rend_ter_max"><br>
            <span class="errori">@formerror.rend_ter_max;noquote@</span>
            </formerror>
        </td>
  </else>
 </tr>
</if> 
<if @flag_tipo_impianto@ eq "F">
<tr>
  <td valign=top align=right class=form_title>Fluido termovettore <font color=red>@mod_funz_asterisco@</font></td><!-- gab01 -->
  <td valign=top><formwidget id="mod_funz">
        <formerror  id="mod_funz">
        <span class="errori">@formerror.mod_funz;noquote@</span>
        </formerror>
  </td>
  
  <td valign=top align=right class=form_title>Numero circuiti<font color=red>*</font></td>
  <td valign=top><formwidget id="num_circuiti">
        <formerror  id="num_circuiti"><br>
	<span class="errori">@formerror.num_circuiti;noquote@</span>
        </formerror>
  </td>
  <td colspan=2></td>
</tr>
<tr><!-- rom04  aggiunta tr-->
   <td valign=top align=right class=form_title>Altro</td>
   <td valign=top><formwidget id="altro_funz">
            <formerror  id="altro_funz"><br>
            <span class="errori">@formerror.altro_funz;noquote@</span>
            </formerror>
  </td>
</tr>
<tr>
 <td valign=top align=right class=form_title>EER (o GUE) @ast_MARCHE;noquote@</td>
        <td valign=top><formwidget id="per">
           <formerror  id="per"><br>
           <span class="errori">@formerror.per;noquote@</span>
           </formerror>
        </td>
 <td valign=top align=right class=form_title>COP  @ast_MARCHE;noquote@</td>
        <td valign=top><formwidget id="cop">
           <formerror  id="cop"><br>
           <span class="errori">@formerror.cop;noquote@</span>
           </formerror>
        </td>
  <td colspan=2></td>
</tr>
</if>
<if @flag_tipo_impianto@ ne "R">
<tr>
  <td colspan=6>
     <table>
       <tr>
        <td valign=top nowrap align=left class=form_title>
           <!-- dpr74 Potenza nominale: &nbsp; focolare (kW)-->
         <% if {$flag_tipo_impianto eq "F"} {
               set label_pot_focolare_nom "Potenza frigorifera: &nbsp; </td><td valign=top nowrap align=left class=form_title>nominale (kW)"
           } elseif {$flag_tipo_impianto eq "T"} {
               set label_pot_focolare_nom "Potenza nominale: &nbsp; focolare (kW)"
           } elseif {$flag_tipo_impianto eq "C"} {
	      set label_pot_focolare_nom "Potenza nominale: &nbsp; termica (kW)"
	   }
        %><!-- dpr74 -->
        @label_pot_focolare_nom;noquote@<font color=red>*</font><!-- dpr74 -->
        </td>
        <td valign=top><formwidget id="pot_focolare_nom">
        <formerror  id="pot_focolare_nom"><br>
        <span class="errori">@formerror.pot_focolare_nom;noquote@</span>
        </formerror>
        </td>
        <if @flag_tipo_impianto@ eq "F" > <!--sim04 if e suo contenuto -->
          <td valign=top align=right class=form_title>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; </td>
          <td valign=top align=right class=form_title>utile (kW)<font color=red>*</font></td>
          <td valign=top><formwidget id="pot_utile_nom_freddo">
          <formerror  id="pot_utile_nom_freddo"><br>
          <span class="errori">@formerror.pot_utile_nom_freddo;noquote@</span>
          </formerror>
          </td>
        </if>
        <td valign=top align=right class=form_title>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; </td>
   
        <if @flag_tipo_impianto@ eq "T" >
          <td valign=top align=right class=form_title>utile (kW)<font color=red>*</font></td>
        </if>
	<if @flag_tipo_impianto@ eq "C" >
          <td valign=top align=right class=form_title>elettrica (kW)<font color=red>*</font></td>
        </if>
        <if @flag_tipo_impianto@ eq "F" > 
          <td valign=top align=right class=form_title>assorb.(kW)<font color=red>*</font></td>
        </if>
        <td valign=top><formwidget id="pot_utile_nom">
        <formerror  id="pot_utile_nom"><br>
        <span class="errori">@formerror.pot_utile_nom;noquote@</span>
        </formerror>
        </td>
      </tr>
      <!--inizio sim01 -->
      <if @flag_tipo_impianto@ eq "F">
      <tr>
        <td valign=top nowrap align=left class=form_title>
          Potenza riscaldamento:</td> <td valign=top nowrap align=left class=form_title>nominale (kW)@ast_freddo;noquote@
        </td>
        <td valign=top><formwidget id="pot_focolare_lib">
         <formerror  id="pot_focolare_lib"><br>
         <span class="errori">@formerror.pot_focolare_lib;noquote@</span>
         </formerror>
        </td>
        <td valign=top align=right class=form_title>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; </td>
        <td valign=top align=right class=form_title>assorb.(kW)@ast_freddo;noquote@</td>
        <td valign=top><formwidget id="pot_utile_lib">
         <formerror  id="pot_utile_lib"><br>
         <span class="errori">@formerror.pot_utile_lib;noquote@</span>
         </formerror>
        </td>
     </tr>
     </if>
<!--fine sim01 -->
   </table>
  </td>
</tr>
</if><!-- chiusura if su freddo e teleriscaldamento-->

<if @flag_tipo_impianto@ eq "C">
<!-- gac01 dati cogenerazione -->
<tr>
  <td colspan=6>
   <table>
   <tr>
     <td align=center><b>Dati targa:</b></td>
     <td align=center><b>min</b></td>
     <td align=center><b>max</b></td>
     <td align=center></td>
     <td align=center><b>min</b></td>
     <td align=center><b>max</b></td>
   </tr>
   <tr>
     <td valign=top align=left class=form_title>Temperatura acqua in uscita (°C):
     <formerror  id="temp_h2o_uscita"><br>
     <span class="errori">@formerror.temp_h2o_uscita;noquote@</span>
     </formerror>
     </td>
     <td valign=top><formwidget id="temp_h2o_uscita_min">
     <formerror  id="temp_h2o_uscita_min"><br>
     <span class="errori">@formerror.temp_h2o_uscita_min;noquote@</span>
     </formerror>
     </td>
     <td valign=top><formwidget id="temp_h2o_uscita_max">
     <formerror  id="temp_h2o_uscita_max"><br>
     <span class="errori">@formerror.temp_h2o_uscita_max;noquote@</span>
     </formerror>
     </td>
     <td valign=top nowrap align=left class=form_title>Temperatura fumi a valle dello scambiatore (°C): 
     <formerror  id="temp_fumi_valle"><br>
     <span class="errori">@formerror.temp_fumi_valle;noquote@</span>
     </formerror>
     </td>
     <td valign=top><formwidget id="temp_fumi_valle_min">
     <formerror  id="temp_fumi_valle_min"><br>
     <span class="errori">@formerror.temp_fumi_valle_min;noquote@</span>
     </formerror>
     </td>
     <td valign=top><formwidget id="temp_fumi_valle_max">
     <formerror  id="temp_fumi_valle_max"><br>
     <span class="errori">@formerror.temp_fumi_valle_max;noquote@</span>
     </formerror>
     </td>
  </tr>
   <tr>
     <td valign=top nowrap align=left class=form_title>Temperatura acqua in ingresso (°C):
     <formerror  id="temp_h2o_ingresso"><br>
     <span class="errori">@formerror.temp_h2o_ingresso;noquote@</span>
     </formerror>
     </td>
     <td valign=top><formwidget id="temp_h2o_ingresso_min">
     <formerror  id="temp_h2o_ingresso_min"><br>
     <span class="errori">@formerror.temp_h2o_ingresso_min;noquote@</span>
     </formerror>
     </td>
     <td valign=top><formwidget id="temp_h2o_ingresso_max">
     <formerror  id="temp_h2o_ingresso_max"><br>
     <span class="errori">@formerror.temp_h2o_ingresso_max;noquote@</span>
     </formerror>
     </td>
     <td valign=top nowrap align=left class=form_title>Temperatura fumi a monte dello scambiatore (°C): 
     <formerror  id="temp_fumi_monte"><br>
     <span class="errori">@formerror.temp_fumi_monte;noquote@</span>
     </formerror>
     </td>
     <td valign=top><formwidget id="temp_fumi_monte_min">
     <formerror  id="temp_fumi_monte_min"><br>
     <span class="errori">@formerror.temp_fumi_monte_min;noquote@</span>
     </formerror>
     </td>
     <td valign=top><formwidget id="temp_fumi_monte_max">
     <formerror  id="temp_fumi_monte_max"><br>
     <span class="errori">@formerror.temp_fumi_monte_max;noquote@</span>
     </formerror>
     </td>
  </tr>
   <tr>
     <td valign=top align=left class=form_title>Temperatura acqua motore <small>(solo m.c.i.)</small> (°C):
     <formerror  id="temp_h2o_motore"><br>
     <span class="errori">@formerror.temp_h2o_motore;noquote@</span>
     </formerror>
     </td>
     <td valign=top><formwidget id="temp_h2o_motore_min">
     <formerror  id="temp_h2o_motore_min"><br>
     <span class="errori">@formerror.temp_h2o_motore_min;noquote@</span>
     </formerror>
     </td>
     <td valign=top><formwidget id="temp_h2o_motore_max">
     <formerror  id="temp_h2o_motore_max"><br>
     <span class="errori">@formerror.temp_h2o_motore_max;noquote@</span>
     </formerror>
     </td>
     <td valign=top align=left class=form_title>Emissioni di monossido di carbonio CO<br>(mg/Nm<small><sup>3</sup></small> riportati al 5% di O<small><sub>2</sub></small> nei fumi )
     <formerror  id="emissioni_monossido_co"><br>
     <span class="errori">@formerror.emissioni_monossido_co;noquote@</span>
     </formerror>
     </td>
     <td valign=top><formwidget id="emissioni_monossido_co_min">
     <formerror  id="emissioni_monossido_co_min"><br>
     <span class="errori">@formerror.emissioni_monossido_co_min;noquote@</span>
     </formerror>
     </td>
     <td valign=top><formwidget id="emissioni_monossido_co_max">
     <formerror  id="emissioni_monossido_co_max"><br>
     <span class="errori">@formerror.emissioni_monossido_co_max;noquote@</span>
     </formerror>
     </td>
  </tr>
  </table>
</td>
</tr>
</if>
<!--fine gac01-->
<!-- gac03 spostato scheda 4.1bis prima della scheda 4.2-->
<if @coimtgen.regione@ eq "MARCHE" > <!-- rom02 aggiunte if ed else  -->
<tr><td colspan=6 class=func-menu-yellow2><b>Scheda 4.1bis: Dati Specifici Gruppi Termici</b></td></tr>
</if>
<else>
<tr><td colspan=6 class=func-menu-yellow2><b>Altri campi obbligatori non presenti sul libretto ma richiesti dalla legge regionale:</b></ td></tr>   
</else>
<if @flag_tipo_impianto@ ne "T" and @flag_tipo_impianto@ ne "C"> <!-- gab02 aggiunta if-->
<tr>
    <td valign=top align=right class=form_title nowrap>Marcatura efficienza energetica @ast_MARCHE;noquote@</td>
    <td valign=top><formwidget id="marc_effic_energ">
        <formerror  id="marc_effic_energ"><br>
        <span class="errori">@formerror.marc_effic_energ;noquote@</span>
        </formerror><br><font color=red><small>Obbligatoria per impianti installati dal 2015</small></font><!--gac04-->
    </td>
    <if @coimtgen.regione@ ne "MARCHE"> <!-- rom02 aggiunta if -->
    <td valign=top align=right class=form_title nowrap>Campo di funzionam. <small>(kW)</small>: da</td>
    <td valign=top class=form_title nowrap colspan=3>
        <formwidget id="campo_funzion_min">
      a <formwidget id="campo_funzion_max">
        <formerror  id="campo_funzion_max"><br>
        <span class="errori">@formerror.campo_funzion_max;noquote@</span>
        </formerror>
        <formerror  id="campo_funzion_min"><br>
        <span class="errori">@formerror.campo_funzion_min;noquote@</span>
        </formerror>
    </td>
    </if>
    <if @coimtgen.regione@ eq "MARCHE" > <!-- rom02 aggiunta if -->
    	 <td valign=top align=right class=form_title>Data costruzione <font color=red>@data_costruz_gen_asterisco@</font></td><!--gab01-->
         <td valign=top><formwidget id="data_costruz_gen">
             <formerror  id="data_costruz_gen"><br>
             <span class="errori">@formerror.data_costruz_gen;noquote@</span>
             </formerror><br><font color=red><small>Se data non nota inserire solo l'anno</small></font
             </formerror>
         </td>
    </if>
</tr>
</if>
<if @flag_tipo_impianto@ eq "F">
<tr><td valign=top align=right class=form_title>Combustibile <font color=red>@cod_combustibile_asterisco@</font></td><!-- gab01 -->
    <td valign=top><formwidget id="cod_combustibile">
        <formerror  id="cod_combustibile"><br>
        <span class="errori">@formerror.cod_combustibile;noquote@</span>
        </formerror>
    </td>
    <td colspan=4></td>
</tr>
</if>
<if @flag_tipo_impianto@ eq "T"  and @coimtgen.regione@ eq "MARCHE" or @flag_tipo_impianto@ eq "C" and @coimtgen.regione@ eq "MARCHE" >
<tr>
<td valign=top align=right class=form_title>Data costruzione <font color=red>@data_costruz_gen_asterisco@</font></td><!--gab01-->
         <td valign=top><formwidget id="data_costruz_gen">
             <formerror  id="data_costruz_gen"><br>
             <span class="errori">@formerror.data_costruz_gen;noquote@</span>
             </formerror>
         </td>
</tr>
</if> 
<if @flag_tipo_impianto@ ne "T" and @flag_tipo_impianto@ ne "C">
    <td valign=top align=right class=form_title>Scarico fumi <font color=red>*</font></td>
    <td valign=top><formwidget id="cod_emissione">
        <formerror  id="cod_emissione"><br>
        <span class="errori">@formerror.cod_emissione;noquote@</span>
        </formerror>
    </td>
    <td valign=top align=right nowrap class=form_title>Tipo locale <font color=red>@locale_asterisco@</font></td><!-- gab01 -->
    <td valign=top><formwidget id="locale">
        <formerror  id="locale"><br>
        <span class="errori">@formerror.locale;noquote@</span>
        </formerror>
    </td>
    <if @coimtgen.regione@ ne "MARCHE">
    <td valign=top align=right class=form_title>Classif. DPR 660/96<font color=red>@dpr_660_96_asterisco@</font></td>
    <td valign=top><formwidget id="dpr_660_96">
        <formerror  id="dpr_660_96"><br>
        <span class="errori">@formerror.dpr_660_96;noquote@</span>
        </formerror><br><font color=red><small>Obbligatoria per combustibile diverso da Solido</small></font> <!--gac04-->
    </td>
    </if>
</if>
<if @flag_tipo_impianto@ eq "F">
<tr>
  <td colspan=6>
    <table>
    <tr>
    <td valign="top" align="right" class="form_title">Tipo condizionatore</td>
    <td valign="top" colspan="1">
        <formwidget id="cod_tpco">
        <formerror  id="cod_tpco"><br>
        <span class="errori">@formerror.cod_tpco;noquote@</span>
        </formerror>
    </td>
    <td valign="top" align="right" class="form_title">Fluido refrigerante</td>
    <td valign="top">
        <formwidget id="cod_flre">
        <formerror  id="cod_flre"><br>
        <span class="errori">@formerror.cod_flre;noquote@</span>
        </formerror>
    </td>
    </tr>
    <tr>
    <td valign="top" align="right" class="form_title">Carica refrigerante (Kg)</td>
    <td valign="top" colspan="1">
        <formwidget id="carica_refrigerante">
        <formerror  id="carica_refrigerante"><br>
        <span class="errori">@formerror.carica_refrigerante;noquote@</span>
        </formerror>
    </td>
    <td valign="top" colspan="1" align="right" class="form_title">Carica ermeticamente sigillata</td>
    <td valign="top">
        <formwidget id="sigillatura_carica">
        <formerror  id="sigillatura_carica"><br>
        <span class="errori">@formerror.sigillatura_carica;noquote@</span>
        </formerror>
    </td>
    </tr>
    </table>
  </td>
</tr>
</if>
<if @flag_tipo_impianto@ eq "R">
<tr>
    <td valign=top align=right nowrap class=form_title>@label_tipo_foco@<font color=red>@tipo_foco_asterisco@</font></td>
    <td valign=top><formwidget id="tipo_foco">
        <formerror  id="tipo_foco"><br>
        <span class="errori">@formerror.tipo_foco;noquote@</span>
        </formerror>
    </td>
    <td valign=top align=right nowrap class=form_title>@label_tiraggio@<font color=red>@tiraggio_asterisco@</font></td>
    <td valign=top><formwidget id="tiraggio">
        <formerror  id="tiraggio"><br>
        <span class="errori">@formerror.tiraggio;noquote@</span>
        </formerror>
    </td>
</tr>
</if>
<if @coimtgen.regione@ eq "MARCHE"> <!-- rom02 aggiunta if -->
   <if @flag_tipo_impianto@ ne "F" > <!-- rom05 aggiunta if -->
    <tr>
	 <td valign=top align=right class=form_title>Classif. DPR 660/96<font color=red>@dpr_660_96_asterisco@</font></td>
    <td valign=top><formwidget id="dpr_660_96">
        <formerror  id="dpr_660_96"><br>
        <span class="errori">@formerror.dpr_660_96;noquote@</span>
        </formerror><br><font color=red><small>Obbligatoria per combustibile diverso da Solido</small></font> <!--gac04-->
    </td>
    
	 <td valign=top align=right nowrap class=form_title colspan=2>Caldaia a condensazioni che utilizza combustibile liquido</td>
    <td valign=top colspan=2><formwidget id="flag_caldaia_comb_liquid">
        <formerror  id="flag_caldaia_comb_liquid"><br>
        <span class="errori">@formerror.flag_caldaia_comb_liquid;noquote@</span>
        </formerror>
        </td>
    </tr>
   </if>
   <!--gac02 aggiunti campi rif_uni_10389 e altro_rif -->
  <tr>
    <td valign=top align=right class=form_title>Riferimento</td>
    <td valign=top><formwidget id="rif_uni_10389">
        <formerror  id="rif_uni_10389"><br>
          <span class="errori">@formerror.rif_uni_10389;noquote@</span>
        </formerror>
        <td valign=top align=right class=form_title>Altro</td>
	<td valign=top colspan=3><formwidget id="altro_rif">
            <formerror  id="altro_rif"><br>
              <span class="errori">@formerror.altro_rif;noquote@</span>
            </formerror>
        </td>
    </tr>
  <if @flag_tipo_impianto@ ne "F"> <!-- rom05 aggiunta if -->
    <tr><td colspan=6 class=func-menu-yellow2><b>Generatore destinato a soddisfare i seguenti servizi:</b></td></tr><!--rom09 aggiunta tr-->
    <tr><td valign=top align=right class=form_title>Funzione del GT<font color=red>*</font></td>
      <td valign=top><formwidget id="funzione_grup_ter">
          <formerror  id="funzione_grup_ter"><br>
            <span class="errori">@formerror.funzione_grup_ter;noquote@</span>
          </formerror>
      </td>
    </if> <!-- rom05 -->
    <td valign=top align=right class=form_title>Note Funzione GT</td>
    <td valign=top colspan=3><formwidget id="funzione_grup_ter_note_altro">
        <formerror  id="funzione_grup_ter_note_altro"><br>
          <span class="errori">@formerror.funzione_grup_ter_note_altro;noquote@</span>
        </formerror>
    </td>
  </tr>
</if><!-- rom05 -->
</if>
<tr><td valign=top align=right class=form_title>Note</td>
  <td valign=top colspan=5><formwidget id="note">
      <formerror  id="note"><br>
        <span class="errori">@formerror.note;noquote@</span>
      </formerror>
  </td>
</tr>
<if @coimtgen.regione@ eq "MARCHE"><!--rom07 aggiunta if e contenuto-->
  <tr>
   <td valign=top colspan=6>
      <a href="coimgend-stesso-ambiente?@link_gest@">Inserire eventuali generatori che servono lo stesso ambiente<small>(=stanza separata da altri locali attraverso porte o muri fino al soffitto)</small>servito da questo generatore
      </a>
  </td>
</tr>
</if><!--rom07-->
<!--gac03 spostato scheda 4.1bis prima della scheda 4.2 -->
<if @flag_tipo_impianto@ eq "R">
<tr>
<!--rom09 Rimpaginata tutta la sezione 4.2 e cambiate le label su richiesta della Regione Marche.
          Per ogni label che cambio riporto di fianco al td la vecchia dicitura commentata.-->
<td valign=top colspan=6 nowrap class=func-menu-yellow2><b>Scheda 4.2: Dati Bruciatore</b></td>
</tr>
<if @coimtgen.regione@ ne "MARCHE"><!--rom09.bis-->
<tr><td valign=top align=right class=form_title>Data costruzione bruciatore</td>
    <td valign=top><formwidget id="data_costruz_bruc">
        <formerror  id="data_costruz_bruc"><br>
        <span class="errori">@formerror.data_costruz_bruc;noquote@</span>
        </formerror>
    </td>
</if>
    <td valign=top align=right class=form_title>Data di installazione</td><!--rom09 Data installazione bruciatore-->
    <td valign=top><formwidget id="data_installaz_bruc">
        <formerror  id="data_installaz_bruc"><br>
        <span class="errori">@formerror.data_installaz_bruc;noquote@</span>
        </formerror>
    </td>
    <td valign=top align=right class=form_title>Data di dismissione</td><!--rom09 Data rottamazione bruciatore-->
    <td valign=top><formwidget id="data_rottamaz_bruc">
        <formerror  id="data_rottamaz_bruc"><br>
        <span class="errori">@formerror.data_rottamaz_bruc;noquote@</span>
        </formerror>
    </td>
</tr>
<tr>
  <td valign=top align=right class=form_title>Fabbricante</td><!--rom09 Costruttore bruciatore-->
  <td valign=top><formwidget id="cod_cost_bruc">
      <formerror  id="cod_cost_bruc"><br>
        <span class="errori">@formerror.cod_cost_bruc;noquote@</span>
        </formerror>
    </td>

    <td valign=top align=right class=form_title>Modello</td><!--rom09 Modello bruciatore -->
    <if @coimtgen.flag_gest_coimmode@ eq "F"><!-- nic01 -->
        <td valign=top><formwidget id="modello_bruc">
    	    <formerror  id="modello_bruc"><br>
            <span class="errori">@formerror.modello_bruc;noquote@</span>
	    </formerror>
	</td>
        <formwidget id="cod_mode_bruc"><!-- nic01 -->
    </if>
    <else><!-- nic01 -->
        <td valign=top><formwidget id="cod_mode_bruc"><!-- nic01 -->
    	    <formerror  id="cod_mode_bruc"><br><!-- nic01 -->
            <span class="errori">@formerror.cod_mode_bruc;noquote@</span><!-- nic01 -->
	    </formerror><!-- nic01 -->
	</td><!-- nic01 -->
        <formwidget id="modello_bruc"><!-- nic01 -->
    </else>
    <td valign=top align=right class=form_title>Matricola</td><!--rom09 Matricola bruciatore-->
    <td valign=top><formwidget id="matricola_bruc">
        <formerror  id="matricola_bruc"><br>
        <span class="errori">@formerror.matricola_bruc;noquote@</span>
        </formerror>
    </td>
</tr>
<tr><td valign=top align=right nowrap class=form_title>Tipologia</td><!--rom09 Bruciatore-->
    <td valign=top><formwidget id="tipo_bruciatore">
        <formerror  id="tipo_bruciatore"><br>
          <span class="errori">@formerror.tipo_bruciatore;noquote@</span>
        </formerror>
    </td>
    <if @coimtgen.regione@ eq "MARCHE"> <!-- rom02 aggiunta if -->
      <!--rom09    <td valign=top align=right class=form_title nowrap>Campo di funzionam. <small>(kW)</small>: da</td> -->
      <!--rom09    <td valign=top class=form_title nowrap colspan=3>                                                   -->
      <!--rom09        <formwidget id="campo_funzion_min">                                                             -->
      <!--rom09      a <formwidget id="campo_funzion_max">                                                             -->
      <!--rom09        <formerror  id="campo_funzion_max"><br>                                                         -->
      <!--rom09        <span class="errori">@formerror.campo_funzion_max;noquote@</span>                               -->
      <!--rom09        </formerror>                                                                                    -->
      <!--rom09        <formerror  id="campo_funzion_min"><br>                                                         -->
      <!--rom09        <span class="errori">@formerror.campo_funzion_min;noquote@</span>                               -->
      <!--rom09        </formerror>                                                                                    -->
      <!--rom09    </td>                                                                                               -->
      <td valign=top align=right class=form_title nowrap>Portata termica max nominale</td><!--rom09-->
      <td valign=top><formwidget id="campo_funzion_max">(kW)
	  <formerror  id="campo_funzion_max"><br>
	    <span class="errori">@formerror.campo_funzion_max;noquote@</span>
	  </formerror>
      </td>
      <td valign=top align=right class=form_title nowrap>Portata termica min nominale</td><!--rom09-->
      <td valign=top><formwidget id="campo_funzion_min">(kW)
	  <formerror  id="campo_funzion_min"><br>
	    <span class="errori">@formerror.campo_funzion_min;noquote@</span>
	  </formerror>
      </td>
    </if>
</tr>
<tr>
  <td colspan=6>
    <table>
<!-- rom02 Tolta su indicazione di Sandro 
     <tr><td valign=top  nowrap align=left class=form_title>Potenza a libretto: &nbsp; focolare (kW)</td>
         <td valign=top><formwidget id="pot_focolare_lib">
          <formerror  id="pot_focolare_lib"><br>
          <span class="errori">@formerror.pot_focolare_lib;noquote@</span>
          </formerror>
         </td>
         <td valign=top align=right class=form_title>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;</td>
         <td valign=top align=right class=form_title>utile (kW)</td>
         <td valign=top><formwidget id="pot_utile_lib">
           <formerror  id="pot_utile_lib"><br>
           <span class="errori">@formerror.pot_utile_lib;noquote@</span>
           </formerror>
         </td>
    </tr>     -->

    </table>
  </td>
</tr>
</if> <!--fine if su dati bruciatore del caldo-->


<if @funzione@ ne "V">
    <tr><td colspan=7 align=center><formwidget id="submit"></td></tr>
</if>
<tr>	
   <td colspan=7  align=right class=form_title><font color=red><small>I campi con il segno * sono obbligatori</small></font></td><!-- rom01 --> 	
</tr>
</table>
</formtemplate>
<p>
</center>

