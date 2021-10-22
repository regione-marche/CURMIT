<!--
    USER  DATA       MODIFICHE
    ===== ========== ==========================================================================
    rom02 07/03/2019 Modifiche su label e diciture richieste da Autorita' competenti e Ispettori
    rom02            della Regione Marche.

    rom01 27/06/018  Intervento sui link da visualizzare o meno a seconda del tipo utente richiesto
    rom01            dalle Marche.

    rom01 25/10/2018 Modificata label "Note non conformit&agrave;" con "Note" su richiesta di Sandro. 
-->

<master   src="../../master">
  <property name="title">@page_title;noquote@</property>
  <property name="context_bar">@context_bar;noquote@</property>
  <property name="riga_vuota">f</property>

  @link_inc;noquote@
  @link_tab;noquote@
  @dett_tab;noquote@
  <table width="100%" cellspacing=0 class=func-menu>
    <tr>
      <if  @flag_cimp@ ne "S"
	   and @flag_inco@ ne "S">
	<td width="12.50%" nowrap class=func-menu>
	  <a href="@pack_dir;noquote@/coimcimp-list?@link_list;noquote@" class=func-menu>Ritorna</a>
	</td>
       <if @flag_cod_manu@ eq "f"><!-- rom01 aggiunta if -->
	<td width="12.50%" nowrap class=func-menu>Aggiungi</td>
       </if><!-- rom01-->
     </if>
      <else>
	<td width="12.50%" nowrap class=func-menu>@link_manc_ver;noquote@</td>
        <if @flag_cod_manu@ eq "f"><!-- rom01 aggiunta if -->
	  <if  @menu@ eq 1>
	<td width="12.50%" nowrap class=@func_i;noquote@>
	  <a href="@pack_dir;noquote@/coimcimp-gest?funzione=I&flag_tracciato=N1&@link_gest;noquote@" class=@func_i;noquote@>Aggiungi</a>
	</td>
	</if>
	  <else>
	    <td width="12.50%" nowrap class=func-menu>Aggiungi</td>
	    </else>
        </if><!-- rom01-->
      </else>
      <if @funzione@ ne "I" and @menu@ eq 1>
	<td width="12.50%" nowrap class=@func_v;noquote@>
          <a href="@pack_dir;noquote@/coimcimp-gest?funzione=V&@link_gest;noquote@" class=@func_v;noquote@>Visualizza</a>
	</td>
	<if @flag_modifica@ eq T>
	  <if @flag_cod_manu@ eq "f"><!-- rom01 aggiunta if -->
          <td width="12.50%" nowrap class=@func_m;noquote@>
            <a href="@pack_dir;noquote@/coimcimp-gest?funzione=M&@link_gest;noquote@" class=@func_m;noquote@>Modifica</a>
          </td>
	  </if><!-- rom01-->
	</if>
	<else>
	  <if @flag_cod_manu@ eq "f"><!-- rom01 aggiunta if -->
          <td width="14.29%" nowrap class=func-menu>Modifica</td>
          </if><!-- rom01-->
	</else>
       <if @flag_cod_manu@ eq "f"><!-- rom01 aggiunta if -->
        <td width="12.50%" nowrap class=@func_d;noquote@>
          <a href="@pack_dir;noquote@/coimcimp-gest?funzione=D&@link_gest;noquote@" class=@func_d;noquote@>Cancella</a>
        </td>
          </if><!-- rom01-->
	<if @flag_modifica@ eq T>
          <td width="12.50%" nowrap class=func-menu>
            <a href="@pack_dir;noquote@/coimanom-list?@link_anom;noquote@" class=func-menu>Anomalie</a>
          </td>
	</if>
	<else>
          <td width="14.29%" nowrap class=func-menu>Anomalie</td>
	</else> 
	<td width="12.50%" nowrap class=func-menu>
          <a href="@pack_dir;noquote@/coimcimp-layout?@link_prnt;noquote@&flag_ins=N" class=func-menu target="Stampa verifica">Stampa</a>
	</td>
	<td width="12.50%" nowrap class=func-menu>
          <a href="@pack_dir;noquote@/coimcimp-layout?@link_prn2;noquote@&flag_ins=S" class=func-menu target="Stampa verifica">Ins. Doc.</a>
	</td>
      </if>
      <else>
	<td width="12.50%" nowrap class=func-menu>Visualizza</td>
	<td width="12.50%" nowrap class=func-menu>Modifica</td>
	<td width="12.50%" nowrap class=func-menu>Cancella</td>
	<td width="12.50%" nowrap class=func-menu>Anomalie</td>
	<td width="12.50%" nowrap class=func-menu>Stampa</td>
	<td width="12.50%" nowrap class=func-menu>Ins. Doc.</td>
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
    <formwidget   id="cod_responsabile">
    <formwidget   id="list_anom_old">
    <formwidget   id="flag_modifica">
    <formwidget   id="cod_cimp">
      <formwidget   id="is_controllo_ok">
      <if @vis_desc_ver@ eq t>
      <formwidget id="esito_verifica">
    </if>
<!-- Inizio della form colorata -->
<%=[iter_form_iniz]%>
@errore;noquote@					
<tr>
  <td>
    <table width ="100%" border=0>
      <tr>
	<td colspan=7 align=center valign=top class=func-menu><b>1. DATI GENERALI</b></td>
      </tr>
      <tr>
        <td valign=top  align=left class=form_title>a) Catasto impianti/codice</td>
	<td valign=top><formwidget id="cod_impianto_est">
	       <formerror  id="cod_impianto_est"><br>
	       <span class="errori">@formerror.cod_impianto_est;noquote@</span>
	       </formerror>
	</td>
      </tr>	
      <tr>
        <td valign=top  align=left class=form_title>b) Ispezione</td>
	<td valign=top  align=left class=form_title>Data:<font color=red>*</font></td>
	<td valign=top><formwidget id="data_controllo">
	       <formerror  id="data_controllo"><br>
	       <span class="errori">@formerror.data_controllo;noquote@</span>
	       </formerror>
	</td>
	<td valign=top align=left class=form_title>Ora:</td>
        <td valign=top><formwidget id="ora_inizio">     
                       <formerror  id="ora_inizio"><br>
                          <span class="errori">@formerror.ora_inizio;noquote@</span>
                       </formerror>
        </td>
	<td valign=top align=left class=form_title>Numero:</td>
	<td valign=top><formwidget id="cod_inco">@link_inco;noquote@
	       <formerror  id="cod_inco"><br>
	           <span class="errori">@formerror.cod_inco;noquote@</span>
	       </formerror>
	</td>
     </tr>
     <tr>
        <td valign=top align=left class=form_title>c) Rapporto di controllo efficienza energetica</td>
        <td valign=top align=left class=form_title>Inviato</td>
        <td valign=top><formwidget id="rapp_cont_inviato">
            <formerror  id="rapp_cont_inviato"><br>
                <span class="errori">@formerror.rapp_cont_inviato;noquote@</span>
            </formerror>
        </td>
	<td valign=top align=left class=form_title>Bollino presente</td>
        <td valign=top><formwidget id="rapp_cont_bollino">
            <formerror  id="rapp_cont_bollino"><br>
                <span class="errori">@formerror.rapp_cont_bollino;noquote@</span>
            </formerror>
        </td>
	<td valign=top align=left class=form_title>Data compilazione</td>
	<td valign=top><formwidget id="data_verb">
	       <formerror  id="data_verb"><br>
	       <span class="errori">@formerror.data_verb;noquote@</span>
	       </formerror>
	</td>
     </tr>
     <tr>
        <td valign=top align=left class=form_title>d) Ispettore</td>
	<td valign=top align=left class=form_title>Cognome e nome:<font color=red>*</font></td>
	<td valign=top><formwidget id="cod_opve">
	    <if @disabled_opve@ eq "disabled">
	      <formwidget id="des_opve">
	    </if>
	    <formerror  id="cod_opve"><br>
 	       <span class="errori">@formerror.cod_opve;noquote@</span>
	    </formerror>
	</td>
	<td valign=top align=left class=form_title>Estremi/qualifica:</td>
	<td valign=top></td>
     </tr>
     <tr>
        <td valign=top align=left class=form_title>e) Impianto</td>
	<td valign=top align=left class=form_title>Data prima installazione:</td>
	<td valign=top align=left><formwidget id="gend_data_installaz_v">
	    <formerror  id="gend_data_installaz_v"><br>
	      <span class="errori">@formerror.gend_data_installaz_v@</span>
	    </formerror>
	</td>
	</td>
	<td valign=top align=left class=form_title>Potenze termiche nominali totali:</td>
	<td valign=top align=left class=form_title>al focolare <formwidget id="potenza_nom_tot_foc">(kw)
	    <formerror  id="potenza_nom_tot_foc"><br>
	      <span class="errori">@formerror.potenza_nom_tot_foc;noquote@</span>
	    </formerror>
	</td>
	<td valign=top align=left class=form_title>Utile <formwidget id="potenza_nom_tot_util">(kw)
	    <formerror  id="potenza_nom_tot_util"><br>
	      <span class="errori">@formerror.potenza_nom_tot_util;noquote@</span>
	    </formerror>
	</td>
     </tr>
     <tr>
     <td align=left class=form_title rowspan=2>f) Ubicazione</td>
     <td valign=top align=left class=form_title>Comune:</td>
     <td valign=top><formwidget id="descr_comune">
         <formerror  id="descr_comune"><br>
	   <span class="errori">@formerror.descr_comune;noquote@</span>
	 </formerror>
     </td>
     <td valign=top align=left class=form_title>Localit&agrave;:</td>
     <td valign=top><formwidget id="localita">
         <formerror  id="localita"><br>
           <span class="errori">@formerror.localita;noquote@</span>
         </formerror>
     </td>
     </tr>
     <tr>
     <td valign=top align=left class=form_title>Indirizzo:</td>
     <td valign=top><formwidget id="indirizzo">
         <formerror  id="indirizzo"><br>
	    <span class="errori">@formerror.indirizzo;noquote@</span>
         </formerror>
     </td>
     </tr>
     <tr>
       <td valign=top align=left class=form_title>g) Responsabile</td>
       <td valign=top><formwidget id="descr_flag_resp">
	     <formerror id="descr_flag_resp"><br>
	       <span class="errori">@formerror.descr_flag_resp;noquote@/span>
	     </formerror>
	</td>   
        <td valign=top align=left class=form_title>Cognome e nome:</td>
	<td valign=top><formwidget id="cogn_responsabile">    
	    <formwidget id="nome_responsabile">@cerca_resp;noquote@
	      <formerror id="cogn_responsabile"><br>
		<span class="errori">@formerror.cogn_responsabile;noquote@</span>
	      </formerror>
	      <br/>@link_ins_resp;noquote@ 
	</td>
     </tr>
     <tr>
        <td valign=top align=left class=form_title>i) Delegato</td>
        <td valign=top align=left class=form_title>Cognome e nome:</td>
        <td valign=top><formwidget id="nominativo_pres">
	    <formerror  id="nominativo_pres"><br>
	      <span class="errori">@formerror.nominativo_pres;noquote@</span>
	    </formerror>
	</td>
        <td valign=top align=left class=form_title>Delega</td>
	<td valign=top><formwidget id="delega_pres">
	    <formerror  id="delega_pres"><br>
	      <span class="errori">@formerror.delega_pres;noquote@</span>
	    </formerror>
	</td>
     </tr>
    </table>
  </td>
</tr>
<tr><td>&nbsp;</td></tr>
<tr>
  <td><table border=0 width="100%">
      <tr>
	<td colspan=4 align=center valign=top class=func-menu><b>2. DESTINAZIONE</b></td>
      </tr>
      <tr>
        <td class=form_title>a) Categoria dell'edificio</td>
        <td valign=top><formwidget id="cod_cted">
	    <formerror  id="cod_cted"><br>
	      <span class="errori">@formerror.cod_cted;noquote@</span>
	    </formerror>
	</td>
      </tr>
      <tr>
	<td class=form_title>b) Unit&agrave; immobiliari servite</td>
	<td valign=top><formwidget id="cod_tpim">
	    <formerror  id="cod_tpim"><br>
	      <span class="errori">@formerror.cod_tpim;noquote@</span>
	    </formerror>
	</td>
	<td class=form_title>c) Uso dell'impianto</td>
	<td valign=top><formwidget id="cod_utgi">
	    <formerror  id="cod_utgi"><br>
	      <span class="errori">@formerror.cod_utgi;noquote@</span>
	    </formerror>
	</td>
      </tr>
      <tr>
        <td valign=top class=form_title>d) Volume lordo riscaldato</td>
        <td valign=top><formwidget id="volumetria">
            <formerror  id="volumetria"><br>
              <span class="errori">@formerror.volumetria;noquote@</span>
            </formerror>
        </td>
        <td valign=top class=form_title>e) Combustibile</td>
       	<td valign=top><formwidget id="cod_combustibile">
  	    <formerror  id="cod_combustibile"><br>
	      <span class="errori">@formerror.cod_combustibile;noquote@</span>
	    </formerror>
	</td>
      </tr>
      <tr>
        <td class=form_title rowspan=2>f) Trattamento dell'acqua</td>
	<td><table><tr>
        <td valign=top class=form_title>in riscaldamento</td>
        <td valign=top><formwidget id="tratt_in_risc">
          <formerror  id="tratt_in_risc"><br>
              <span class="errori">@formerror.tratt_in_risc;noquote@</span>
          </formerror>
        </td>
	</tr>
	<tr>
        <td valign=top class=form_title>in produzione di ACS</td>
        <td valign=top><formwidget id="tratt_in_acs">
           <formerror  id="tratt_in_acs"><br>
              <span class="errori">@formerror.tratt_in_acs;noquote@</span>
           </formerror>
        </td>
      </tr>
      </table>
      </td>
      </tr>
      </table>
  </td>
</tr>
<tr>
  <td><table border=0 width="100%">
     <tr>
	<td colspan=4 align=center valign=top class=func-menu><b>3. CONTROLLO DELL'IMPIANTO</b></td>
     </tr>
     <tr>
	<td valign=top align=left class=form_title>a) Installazione interna: locale idoneo</td>
	<td valign=top align=left><formwidget id="interna_locale_idoneo">
	    <formerror  id="interna_locale_idoneo"><br>
	      <span class="errori">@formerror.interna_locale_idoneo;noquote@</span>
	    </formerror>
	</td>            
	<td valign=top align=left class=form_title>b) Installazione esterna: generatori idonei</td>
	<td valign=top align=left><formwidget id="esterna_generatore_idoneo">
	    <formerror  id="esterna_generatore_idoneo"><br>
	      <span class="errori">@formerror.esterna_generatore_idoneo;noquote@</span>
	    </formerror>
	</td>
      </tr>
       <tr>
 	<td valign=top align=left class=form_title>c) Sistema di ventilazione sufficiente</td> 
	<td valign=top align=left><formwidget id="ventilazione_locali">
	    <formerror  id="ventilazione_locali"><br>
	      <span class="errori">@formerror.ventilazione_locali;noquote@</span>
	    </formerror>
	</td>
	<td valign=top align=left class=form_title>d) Sistema evacuazione fumi idoneo (esame visivo)</td>
	<td valign=top align=left><formwidget id="canale_fumo_idoneo">
	    <formerror id="canale_fumo_idoneo"><br>
	      <span class="errori">@formerror.canale_fumo_idoneo;noquote@</span>
	    </formerror>
	</td>
      </tr>
      <tr>
	<td valign=top align=left class=form_title>e) Cartellonistica prevista presente</td>
	<td valign=top align=left ><formwidget id="new1_pres_cartell">
	    <formerror id="new1_pres_cartell"><br>
	      <span class="errori">@formerror.new1_pres_cartell;noquote@</span>
	    </formerror>
	</td>
        <td valign=top align=left class=form_title>f) Mezzi estinzione incendi presenti e revisionati<font color=red>*</font></td>
	<td valign=top align=left ><formwidget id="new1_pres_mezzi">
	    <formerror id="new1_pres_mezzi"><br>
	      <span class="errori">@formerror.new1_pres_mezzi;noquote@</span>
	    </formerror>
	</td>    
      </tr>
      <tr>       
      	<td valign=top align=left class=form_title>g) Interruttore generale presente <font color=red>*</font></td>
	<td valign=top align=left ><formwidget id="new1_pres_interrut">
	    <formerror id="new1_pres_interrut"><br>
	      <span class="errori">@formerror.new1_pres_interrut;noquote@</span>
	    </formerror>
	</td>
        <td valign=top align=left class=form_title>h) Rubinetto intercettazione esterno presente<font color=red>*</font></td>
	<td valign=top align=left>
	  <formwidget id="new1_pres_intercet">
	    <formerror id="new1_pres_intercet"><br>
	      <span class="errori">@formerror.new1_pres_intercet;noquote@</span>
	    </formerror>
	</td>
      </tr> 
      <tr>       
	<td valign=top align=left class=form_title>i) Assenza perdite comb. (esame visivo)</td>
	<td valign=top align=left><formwidget id="ass_perdite_comb">
	    <formerror id="ass_perdite_comb"><br>
	      <span class="errori">@formerror.ass_perdite_comb;noquote@</span>
	    </formerror>
	</td>
	<td valign=top align=left class=form_title>j) Sistema regolazione temp. ambiente funzionante</td>
	<td valign=top align=left><formwidget id="verifica_disp_regolazione">
	    <formerror id="verifica_disp_regolazione"><br>
	      <span class="errori">@formerror.verifica_disp_regolazione;noquote@</span>
	    < /formerror>
	</td>
      </tr>	
      <tr>
    </table>
  </td>
</tr>
<tr>
  <td><table border=0 width="100%">
      <tr>
	<td colspan=4 align=center valign=top class=func-menu><b>4. STATO DELLA DOCUMENTAZIONE</b></td>
      </tr>
      <tr>
	<td valign=top align=left class=form_title>a) Libretto di impianto presente</td>
	<td valign=top align=right><formwidget id="presenza_libretto">
	    <formerror id="presenza_libretto"><br>
	      <span class="errori">@formerror.presenza_libretto;noquote@</span>
	    </formerror>
	</td>
	<td valign=top align=left class=form_title>b) Libretto di impianto compilato in tute le sue parti</td>
	<td valign=top align=right><formwidget id="libretto_corretto">
	    <formerror id="libretto_corretto"><br>
	      <span class="errori">@formerror.libretto_corretto;noquote@</span>
	    </formerror>
	</td>
      </tr> 
      <tr>
	<td valign=top align=left class=form_title>c) Dichiarazione conformit&agrave;/rispondenza presente</td>
	<td valign=top align=right><formwidget id="dich_conformita">
	    <formerror id="dich_conformita"><br>
	      <span class="errori">@formerror.dich_conformita;noquote@</span>
	    </formerror>
	</td>
	<td valign=top align=left class=form_title>d) Libretti uso/manutenzione generatore presenti</td>
	<td valign=top align=right><formwidget id="libretto_manutenz">
	    <formerror id="libretto_manutenz"><br>
	       <span class="errori">@formerror.libretto_manutenz;noquote@</span>
	    </formerror>
	</td>
      <tr> 
	<td valign=top align=left class=form_title>e) Pratica VV.F. presente ove richiesto</td>
	<td valign=top align=right><formwidget id="doc_prev_incendi">
	    <formerror  id="doc_prev_incendi"><br>
	      <span class="errori">@formerror.doc_prev_incendi;noquote@</span>
	    </formerror>
	</td>
	<td valign=top align=left class=form_title>f) Pratica INAIL presente (gi&agrave; ISPESL)</td>
	<td valign=top align=right><formwidget id="doc_ispesl">
	    <formerror  id="doc_ispesl"><br>
	      <span class="errori">@formerror.doc_ispesl;noquote@</span>
	    </formerror>
	</td>
      </tr>
     </table>
  </td>
</tr>
<tr>
<td><table border=0 width="100%">	
  <tr>
    <td align=center valign=top colspan=5 class=func-menu><b>5. INTERVENTI DI MIGLIORAMENTO ENERGETICO DELL'IMPIANTO</b></td><!--rom02-->
  </tr>
  <tr>
    <td align=left align=center rowspan=2>a) Check-list</td>
    <td valign=top align=left>Adozione di valvole Termostatiche sui corpi scaldanti</td>
    <td valign=top align=left><formwidget id="check_valvole">
        <formerror  id="check_valvole"><br>
           <span class="errori">@formerror.check_valvole;noquote@</span>
        </formerror>
    </td>
    <td valign=top align=left>Isolamente della rete di distribuzione nei locali non riscaldati</td>
    <td valign=top align=left><formwidget id="check_isolamento">
        <formerror id="check_isolamento"><br>
         <span class="errori">@formerror.check_isolamento;noquote@</span>
      </formerror>
     </td>
   </tr>
   <tr>
      <td valign=top align=left>Intrudozione di un sistema di trattamento dell'acqua</td>
      <td valign=top align=left><formwidget id="check_trattamento">
          <formerror  id="check_trattamento"><br>
             <span class="errori">@formerror.check_trattamento;noquote@</span>
          </formerror>
      </td>
      <td valign=top align=left>Sostituzione di un sistema di regolazione on/off con un sistema programmabile</td>
      <td valign=top align=left><formwidget id="check_regolazione">
         <formerror  id="check_regolazione"><br>
       	    <span class="errori">@formerror.check_regolazione;noquote@</span>
	 </formerror>
     </td>
  </tr>
  <tr>
    <td valign=top align=left>b) Interventi atti a migliorare il rendimento energetico</td>
    <td valign=top align=left><formwidget id="int_rend_term">
        <formerror  id="int_rend_term"><br>
           <span class="errori">@formerror.int_rend_term;noquote@</span>
        </formerror>
    </td>
    <td></td>
    <td valign=top align=left> Motivo valutazione non eseguita:</td>
    <td valign=top align=left><formwidget id="int_rend_term_note">
        <formerror  id="int_rend_term_note"><br>
           <span class="errori">@formerror.int_rend_term_note;noquote@</span>
        </formerror>
    </td>
  </tr>
  <tr>
    <td valign=top align=left>c) Stima del dimensionamento del/i generatore/i</td>
    <td valign=top align=left><formwidget id="dimensionamento_gen">
	<formerror  id="dimensionamento_gen"><br>
	  <span class="errori">@formerror.dimensionamento_gen;noquote@</span>
	</formerror>
    </td>
  </tr>
 </table>
</td>
</tr>	
<tr>
  <td>
  <table border=0 width="100%">
     <tr>
       <td colspan=6 align=center valign=top class=func-menu><b>6. GENERATORE</b></td>
    </tr>
    <tr>
        <td valign=top align=left class=form_title>a) Generatore N° @gend_gen_prog_est;noquote@ di @n_generatori;noquote@</td>
    </tr>
    <tr>
	<td valign=top align=left class=form_title>b) Data installazione</td>
	<td valign=top align=left><formwidget id="gend_data_installaz_v">
	    <formerror  id="gend_data_installaz_v"><br>
	      <span class="errori">@formerror.gend_data_installaz_v@</span>
	    </formerror>
	</td>
     </tr>
     <tr>
	<td valign=top align=left class=form_title>c) Fluido termovettore</td>
	<td valign=top align=left><formwidget id="mod_funz">
	    <formerror  id="mod_funz"><br>
	      <span class="errori">@formerror.mod_funz;noquote@</span>
	    </formerror>
	</td>
     </tr>
     <tr>
    	<td valign=top align=left class_form_title>d) Modalita&grave; di evacuazione fumi</td>
        <td valign=top align=left><formwidget id="gend_tiraggio">
            <formerror  id="gend_tiraggio"><br>
                <span class="errori">@formerror.gend_tiraggio;noquote@</span>
            </formerror>
        </td>
      </tr>
      <tr>
        <td valign=top align=left class=form_title>e) Costruttore caldaia</td>
	<td valign=top align=left><formwidget id="cod_cost">
	    <formerror  id="cod_cost"><br>
	      <span class="errori">@formerror.cod_cost;noquote@</span>
	    </formerror>
	</td>
      </tr>
      <tr>
	<td valign=top align=left class=form_title>f) modello e matricola caldaia</td>
	<td valign=top align=left><formwidget id="modello">
	    <formerror  id="modello"><br>
	      <span class="errori">@formerror.modello;noquote@</span>
	    </formerror>
	<td valign=top align=left><formwidget id="matricola">
	    <formerror  id="matricola"><br>
	      <span class="errori">@formerror.matricola;noquote@</span>
	    </formerror>
	</td>
      </tr>
      <tr>
        <td valign=top align=left class=form_title>g) Costruttore Bruciatore</td>
	<td valign=top align=left><formwidget id="cod_cost_bruc">
	    <formerror  id="cod_cost_bruc"><br>
	      <span class="errori">@formerror.cod_cost_bruc;noquote@</span>
	    </formerror>
	</td>
      </tr>
      <tr>
	<td valign=top align=left class=form_title>h) modello e matricola Bruciatore</td>
	<td valign=top align=left><formwidget id="modello_bruc">
	    <formerror  id="modello_bruc"><br>
	      <span class="errori">@formerror.modello_bruc;noquote@</span>
	    </formerror>
	</td>
	<td valign=top align=left><formwidget id="matricola_bruc">
	    <formerror  id="matricola_bruc"><br>
	      <span class="errori">@formerror.matricola_bruc;noquote@</span>
	    </formerror>
	</td>
      </tr>
      <tr>
        <td valign=top align=left class=form_title>i) Tipologia gruppo termico</td>
        <td valign=top align=left><formwidget id="tipo_foco">
            <formerror  id="tipo_foco"><br>
               <span class="errori">@formerror.tipo_foco;noquote@</span>
            </formerror>
        </td>
      </tr>								    
      <tr>
	<td valign=top align=left class=form_title>j) Classificazione DPR 660/96</td>
	<td valign=top align=left><formwidget id="dpr_660_96">
	    <formerror  id="dpr_660_96"><br>
	      <span class="errori">@formerror.dpr_660_96;noquote@</span>
	    </formerror>
	</td>
      </tr>	
      <tr>
        <td valign=top align=left class=form_title>k) Dati Nominali:</td>
        <td valign=top align=left class=form_title>Potenza termica al focolare:</td>
	<td valign=top align=left><formwidget id="pot_focolare_nom">(kW)
	    <formerror  id="pot_focolare_nom"><br>
	      <span class="errori">@formerror.pot_focolare_nom;noquote@</span>
	    </formerror>
	</td>
        <td valign=top align=left class=form_title>Potenza termica utile:</td>
	<td valign=top align=left><formwidget id="pot_utile_nom">(kW)
	    <formerror id="pot_utile_nom"><br>
	      <span class="errori">@formerror.pot_utile_nom;noquote@</span>
	    </formerror>
	</td>
      </tr>
      <tr>
        <td></td>
	<td valign=top align=left class=form_title>Campo di lavoro bruciatore:</td>
	<td valign=top align=left>da <formwidget id="campo_funzion_min">(kW)
	    <formerror id="campo_funzion_min"><br>
	      <span class="errori">@formerror.campo_funzion_min;noquote@</span>
	    </formerror>
	</td>
       	<td valign=top align=left>a <formwidget id="campo_funzion_max">
	    <formerror id="campo_funzion_max"><br>
	      <span class="errori">@formerror.campo_funzion_max;noquote@</span>
	    </formerror>
	</td>
      </tr>
      <tr>
        <td valign=top align=left class=form_title>l) Dati misurati:</td>
        <td valign=top align=left class=form_title>Portata di combustibile:</td>
	<td valign=top align=left><formwidget id="mis_port_combust">(m<sup>3</sup>/h)/(kg/h)
	    <formerror  id="mis_port_combust"><br>
	      <span class="errori">@formerror.mis_port_combust;noquote@</span>
	    </formerror>
	</td>
	<td valign=top align=left class=form_title>Potenza termica al focolare</td>
	<td valign=top align=left><formwidget id="mis_pot_focolare">(kW)
	    <formerror  id="mis_pot_focolare"><br>
	      <span class="errori">@formerror.mis_pot_focolare;noquote@</span>
	    </formerror>
	</td>
      </tr>
   </table>
 </td>
</tr>
<tr>
  <td><table border=0 width="100%">
       <tr>
         <td colspan=7 align=center valign=top class=func-menu><b>7. MANUTENZIONE E ANALISI</b></td>
       </tr>
       <tr>
          <td valign=middle align=left rowspan=2>a) Operazioni di controllo e manutenzione</td>
          <td valign=top align=left>Frequenza</td>
	  <td valign=top align=left><formwidget id="frequenza_manut">
	      <formerror  id="frequenza_manut"><br>
  	         <span class="errori">@formerror.frequenza_manut;noquote@</span>
	      </formerror>
	  </td>
          <td valign=top align=left>Altra frequenza:</td>
	  <td valign=top align=left><formwidget id="frequenza_manut_altro">
 	      <formerror  id="frequenza_manut_altro"><br>
	         <span class="errori">@formerror.frequenza_manut_altro;noquote@</span>
	       </formerror>
	  </td>
	</tr>
	<tr>
	  <td valign=top align=left> Ultima manutenzione prevista</td>
	  <td align=left><formwidget id="new1_manu_prec_8a">
	      <formerror id="new1_manu_prec_8a"><br>
	        <span class="errori">@formerror.new1_manu_prec_8a;noquote@</span>
              </formerror>
	  </td>
	  <td valign=top align=left>In data:</td>
	  <td align=left><formwidget id="new1_data_ultima_manu">
	    <formerror  id="new1_data_ultima_manu"><br>
	      <span class="errori">@formerror.new1_data_ultima_manu;noquote@</span>
	    </formerror>
	  </td>
      </tr>
      <tr>
	<td align=left calign=top class=form_title>b) Rapporto controllo efficienza energetica</td>
	<td valign=top align=left>Presente</td>
	<td align=left><formwidget id="new1_dimp_pres">
  	    <formerror  id="new1_dimp_pres"><br>
	      <span class="errori">@formerror.new1_dimp_pres;noquote@</span>
	    </formerror>
	</td>
	<td valign=top align=left>Con:</td>
        <td valign=top align=left>Osservazioni <formwidget id="rcee_osservazioni">
	    <formerror  id="rcee_osservazioni"><br>
	      <span class="errori">@formerror.rcee_osservazioni;noquote@</span>
	    </formerror>
	</td>
        <td valign=top align=left>Raccomandazioni <formwidget id="rcee_raccomandazioni">
	    <formerror  id="rcee_raccomandazioni"><br>
	      <span class="errori">@formerrorrcee_raccomandazioni;noquote@</span>
	    </formerror>
	</td>
	<td valign=top align=left>Prescrizioni <formwidget id="new1_dimp_prescriz">
	    <formerror  id="new1_dimp_prescriz"><br>
	      <span class="errori">@formerror.new1_dimp_prescriz;noquote@</span>
	    </formerror>
	</td>
	</tr>
    </table>
  </td>
</tr>
<tr>
  <td><table border=0 cellpadding=0 cellspacing=0 width="100%">
      <tr>
	<td colspan=5 align=center valign=top class=func-menu><b>8. MISURA DEL RENDIMENTO DI COMBUSTIONE (UNI 10389-1)</b></td>
      </tr>
      <tr>
	<td colspan=5 >&nbsp;</td>
      </tr>
      <tr>
	<td valign=top align=left class=form_title>a) Modulo termico N° @gend_gen_prog_est;noquote@ di @n_generatori;noquote@</td>
	<td align=left valign=top class=form_title>b) Indice di fumosit&agrave; (solo per combustibili liquidi)</td>
	<td valign=top align=left>1° misura: <formwidget id="indic_fumosita_1a">
	    <formerror  id="indic_fumosita_1a"><br>
 	      <span class="errori">@formerror.indic_fumosita_1a;noquote@</span>
           </formerror>
	</td>
	<td valign=top align=left>2° misura: <formwidget id="indic_fumosita_2a">
	    <formerror  id="indic_fumosita_2a"><br>
 	      <span class="errori">@formerror.indic_fumosita_2a;noquote@</span>
           </formerror>
	</td> 
	<td valign=top align=left>3° misura: <formwidget id="indic_fumosita_3a">
	    <formerror  id="indic_fumosita_3a"><br>
 	      <span class="errori">@formerror.indic_fumosita_3a;noquote@</span>
           </formerror>
	</td>
     </tr>
     <tr>
        <td valign=top align=left class=form_title>c) Strumenti utilizzati</td>
	<td valign=top align=left class=form_title>Analizzatore</td>
	<td align=left valign=top>
	  <formwidget id="cod_strumento_01">
	    <formerror  id="cod_strumento_01"><br>
	      <span class="errori">@formerror.cod_strumento_01;noquote@</span>
	    </formerror>
	</td>
	<td valign=top align=left  class=form_title>Deprimometro</td>
	<td align=left valign=top colspan=>
	  <formwidget id="cod_strumento_02">
	    <formerror  id="cod_strumento_02"><br>
	      <span class="errori">@formerror.cod_strumento_02;noquote@</span>
	    </formerror>
	</td>
      </tr>
      <tr>
        <td colspan=2>
	  <table width=100%>
	    <tr>
	      <td valign=top align=center class=form_title>d) Valori Misurati (media delle tre misure)</td>
	    </tr>
            <tr>
	      <td valign=top align=left class=form_title>Temperatura del fluido di mandata (&#176;C)</td>
   	      <td valign=top  align=left><formwidget id="temp_h2o_out_1a">
	          <formerror  id="temp_h2o_out_1a"><br>
	             <span class="errori">@formerror.temp_h2o_out_1a;noquote@</span>
	          </formerror>
  	      </td>
            </tr>
            <tr>
	      <td valign=top align=left class=form_title>Temperatura dell'aria comburente (&#176;C)</td>
	      <td valign=top align=left><formwidget id="t_aria_comb_1a">
	          <formerror  id="t_aria_comb_1a"><br>
        	      <span class="errori">@formerror.t_aria_comb_1a;noquote@</span>
                  </formerror>
	      </td>
            </tr>
            <tr>
	      <td valign=top align=left class=form_title>Temperatura fumi (&#176;C)</td>
    	      <td valign=top align=left><formwidget id="temp_fumi_1a">
	          <formerror  id="temp_fumi_1a"><br>
	             <span class="errori">@formerror.temp_fumi_1a;noquote@</span>
	          </formerror>
	      </td>
            </tr>
            <tr>
	       <td valign=top align=left class=form_title>O<small><sub>2</sub></small> (%)</td>
     	       <td valign=top align=left><formwidget id="o2_1a">
	           <formerror  id="o2_1a"><br>
	             <span class="errori">@formerror.o2_1a;noquote@</span>
	           </formerror>
   	       </td>
           </tr>
           <tr>  
 	      <td valign=top align=left class=form_title>CO<small><sub>2</sub></small> (%)</td>
	      <td valign=top align=left><formwidget id="co2_1a">
	          <formerror  id="co2_1a"><br>
	             <span class="errori">@formerror.co2_1a;noquote@</span>
	          </formerror>
	      </td>
          </tr>
          <tr>
	     <td valign=top align=left class=form_title>CO nei fumi secchi (ppm)</td>
	     <td valign=top align=left><formwidget id="co_1a">
	         <formerror  id="co_1a"><br>
	             <span class="errori">@formerror.co_1a;noquote@</span>
  	         </formerror>
	     </td>
           </tr>
          </table>
        </td>
        <td colspan=3>
          <table width=100% border=0>
            <tr>
  	      <td valign=top align=center class=form_title colspan=2>e) Valori Calcolati</td>
            </tr>
     <tr>
	<td >Indice d'aria (n)</td>
	<td valign=top align=left><formwidget id="eccesso_aria_perc">
	    <formerror  id="eccesso_aria_perc"><br>
	      <span class="errori">@formerror.eccesso_aria_perc;noquote@</span>
	    </formerror>
	</td>
      </tr>
      <tr>
	<td valign=top align=left class=form_title>CO nei fumi secchi e senz'aria (ppm)</td>
	<td valign=top align=left><formwidget id="co_2a">
	    <formerror  id="co_2a"><br>
	      <span class="errori">@formerror.co_2a;noquote@</span>
	    </formerror>
	</td>
      </tr>
      <tr>
	<td valign=top align=left class=form_title>Potenza termica persa al camino Qs(%)</td>
	<td valign=top align=left><formwidget id="perdita_ai_fumi">
	    <formerror  id="perdita_ai_fumi"><br>
	      <span class="errori">@formerror.perdita_ai_fumi;noquote@</span>
	    </formerror>
	</td>
      </tr>
      <tr>
	<td valign=top align=left class=form_title>Recupero calore di condensazione E.T. (%)</td>
	<td valign=top align=left><formwidget id="et">
	    <formerror  id="et"><br>
      <span class="errori">@formerror.et;noquote@</span>
	    </formerror>
		</td>
     </tr>
     <tr>
       <td valign=top align=left class=form_title>Rendimento di combustione &#951;<small>comb</small></td>
       <td  valign=top align=left><formwidget id="rend_comb_min"><br><if @funzione@ eq "I"><small>* @rendimento_min_notice;noquote@</small></if>
	  <formerror  id="rend_comb_min"><br>
	    <span class="errori">@formerror.rend_comb_min;noquote@</span>
	  </formerror>
       </td>
     </tr>
     <tr>
       <td colspan=2></td>
     </tr>
          </table>
        </td>
      </tr>	
    </table>  
  </td>
</tr>
<tr>
  <td align=center valign=top class=func-menu><b>9. ESITO DELLA PROVA</b></td>					     </tr>
<tr>	   
  <td>				    
     <table border=0 width="100%">
				      <tr>
        <!-- <td valign=top colspan=3 align=left>L'impianto ha rispettato le periodicità' previste per controllo e manutentzione<br>
                                                   <formwidget id="esito_periodicita">
                                                     <formerror  id="esito_periodicita"><br>
                                                       <span class="errori">@formerror.esito_periodicita;noquote@</span>
                                                     </formerror>
                                          </td>					       
       <td valign=top align=left class=form_title>
                <b>Esito Positivo: Rientra</b><small> nei termini di legge<br></small><b>Esito Negativo: Non rientra</b><small><small> le non conformità vanno sanate entro 60 gg pena una sazione</small></small>
	</td>
	<if @vis_desc_ver@ eq f>
                                          <td valign=top align=left><formwidget id="esito_verifica">
                                                       <formerror  id="esito_verifica"><br>
                                                         <span class="errori">@formerror.esito_verifica;noquote@</span>
                                                       </formerror>
                                           </td>
                                           </if>
                                           <else>
                                           <td valign=top align=left><formwidget id="text_esito_verifica">
                                                      <formerror  id="text_esito_verifica"><br>
                                                         <span class="errori">@formerror.text_esito_verifica;noquote@</span>
                                                       </formerror>
                                           </td>
                                           </else>
	       </tr>-->
       <tr>
         <!-- <td valign=top colspan=5 align=left>E' presente la documentazione di cui al D.Lgs.152/2006 (ove richiesto)?
                                                  <formwidget id="docu_152">
                                                     <formerror  id="docu_152"><br>
                                                       <span class="errori">@formerror.docu_152;noquote@</span>
                                                     </formerror>
                                          </td> -->
       </tr>
       <tr>
        <td colspan=3 valign=bottom align=left class=form_title><b>a) Monossido di carbonio</b><small> nei fumi secchi e senz'aria (deve essere inferiore o uguale a 1000 ppm = 0,1%)</small>
                                           </td>
	  <td colspan=2 valign=top align=left></td>
        </tr>
	<tr>
	<td colspan=3 align=left>Valore rilevato
                                           </td>
	<td valign=top colspan=2 rowspan=5>
                                           </td>
	</tr>
	<tr>
	  <td valign=top align=left>
                                                   <formwidget id="new1_co_rilevato">(ppm)
                                                     <formerror  id="new1_co_rilevato"><br>
                                                       <span class="errori">@formerror.new1_co_rilevato;noquote@</span>
                                                      </formerror>
		  </td>	  
		  <td colspan=2 valign=top align=left>
			<formwidget id="co_fumi_secchi_8b">
                                                      <formerror  id="co_fumi_secchi_8b"><br>
                                                        <span class="errori">@formerror.co_fumi_secchi_8b;noquote@</span>
                                                    </formerror>
		  </td>
		</tr>
                                            <tr>
		<td colspan=3 valign=bottom align=left class=form_title><b>b) Indice di fumosit&agrave;</b><small> = N&#176; di Bacharach (per gasolio minore o uguale a 2; per olio combustibile minore o uguale a 6)</small> </td>
		</tr>
		<tr>
		  <td colspan=3 align=left>Valore rilevato</td>
		</tr>
		<tr>
		  <td valign=top align=left>
			<formwidget id="indic_fumosita_md">
			  <formerror  id="indic_fumosita_md"><br>
			    <span class="errori">@formerror.indic_fumosita_md;noquote@</span>
			  </formerror>
		  </td>
		  <td colspan=2 valign=top align=left>
			<formwidget id="indic_fumosita_8c">			
			  <formerror  id="indic_fumosita_8c"><br>		
			    <span class="errori">@formerror.indic_fumosita_8c;noquote@</span>
			  </formerror>						  
		 <tr>
		  <td valign=top colspan=5 align=left class=form_title><b>c) Rendimento di Combustione</b></td>
		</tr>
		<tr>
		  <td valign=top align=left class=form_title><small>il valore deve essere superiore o uguale a</small></td> 
		  <td colspan=4 valign=bottom align=left>
			<formwidget id="rend_comb_min"><br><if @funzione@ eq "I"><small>* @rendimento_min_notice;noquote@</small></if>
			  <formerror  id="rend_comb_min"><br>
			    <span class="errori">@formerror.rend_comb_min;noquote@</span>
			  </formerror>
		  </td>
		</tr>
		<tr>
		  <td colspan=4 valign=top align=left>Valore rilevato <small>(+2% del rend. min.)</small><br>
		  </td>
		<tr>
		  <td>	
			<formwidget id="rend_comb_conv">%
			  <formerror  id="rend_comb_conv"><br>
			    <span class="errori">@formerror.rend_comb_conv;noquote@</span>
			  </formerror>
		  </td>
		  <td colspan=4 valign=bottom align=left>
			<formwidget id="rend_comb_8d">
			  <formerror  id="rend_comb_8d"><br>
			    <span class="errori">@formerror.rend_comb_8d;noquote@</span>
			  </formerror>
		  </td>
		</tr> 
		<tr>
		  <td valign=top align=left class=form_title><b>Impianto Critico</b> <small>vedi motivazione al punto 9</small></td>
		</tr> 
		<tr>
		  <td  valign=top align=left>
			<formwidget id="new1_flag_peri_8p">
			  <formerror  id="new1_flag_peri_8p"><br>
			    <span class="errori">@formerror.new1_flag_peri_8p;noquote@</span>
			  </formerror>
		  </td>
                                              </tr>
                                              <tr>
			<td colspan=5>
		<table border=0 width=100%><tr>

          <td valign=top  align=left class=form_title> Rispetta 7a 
		<formwidget id="norm_7a">
		  <formerror  id="norm_7a">
		    <span class="errori">@formerror.norm_7a;noquote@</span>
		  </formerror>
	  </td>

          <td valign=top  align=left class=form_title> Rispetta 9a	
		<formwidget id="norm_9a">
		  <formerror  id="norm_9a">
		    <span class="errori">@formerror.norm_9a;noquote@</span>
		  </formerror>
	  </td>

          <td valign=top  align=left class=form_title> Rispetta 9b
		<formwidget id="norm_9b">
		  <formerror  id="norm_9b">
		    <span class="errori">@formerror.norm_9b;noquote@</span>
		  </formerror>
	  </td>
          <td valign=top  align=left class=form_title> Rispetta 9c
		<formwidget id="norm_9c">
		  <formerror  id="norm_9c">
		    <span class="errori">@formerror.norm_9c;noquote@</span>
		  </formerror>
	  </td>
	</tr></table></td>
	</tr>
	<tr>
	  <td colspan=5><table border=0 width="100%">
	      <tr>
		<td colspan=2 align=center valign=top class=func-menu><b>10. OSSERVAZIONI</b></td>
	      </tr>
<!--            <td valign=top align=left class=form_title>Controllato Cucina</td>
		<td valign=top align=left><formwidget id="controllo_cucina">
		    <formerror id="controllo_cucina"><br>
		        <span class="errori">@formerror.controllo_cucina;noquote@</span>
		    </formerror> -->
	        </td>
              </tr>	       
	      <tr>
	        <td valign=top align=left class=form_title>Osservazioni</td>
		<td valign=top><formwidget id="note_conf">
		    <formerror  id="note_conf"><br>
		      <span class="errori">@formerror.note_conf;noquote@</span>
		    </formerror>
		</td>
	      </tr>
              <td colspan=2 align=center valign=top class=func-menu><b>11. PRESCRIZIONI</b></td>
            </tr>
            <tr>
              <td valign=top align=left class=form_title>Prescrizioni</td>
              <td valign=top align=left><formwidget id="note_verificatore">
                  <formerror  id="note_verificatore"><br>
                      <span class="errori">@formerror.note_verificatore;noquote@</span>
                  </formerror>
              </td>
            </tr>
	    <tr>
	      <td colspan=2 align=center valign=top class=func-menu><b>12. DICHIARAZIONI DEL RESPONSABILE IMPIANTO</b></td>
	      </tr>
	      <tr>
                <td valign=top align=left class=form_title>Dichiarazioni</td>
                <td valign=top ><formwidget id="note_resp">
		    <formerror  id="note_resp"><br>
		      <span class="errori">@formerror.note_resp;noquote@</span>
		    </formerror>
		</td>
	      </tr>
	    </table>
	  </td>
	</tr>
	<tr>
	 <td>
	  <table border=0 width=50%>
	  <tr>
	    <!-- <td>Rilasciata dichiarazione:</td>
	     <td valign=top align=left class=form_title>Mod. Verde
                                            <formwidget id="mod_verde">
                                                <formerror  id="mod_verde"><br>
                                                  <span class="errori">@formerror.mod_verde;noquote@</span>
                                                </formerror>
                                            </td> -->
		<!-- <td valign=top align=left class=form_title>Mod. Rosa
                                            <formwidget id="mod_rosa">
                                                <formerror  id="mod_rosa"><br>
                                                  <span class="errori">@formerror.mod_rosa;noquote@</span>
                                                </formerror>
                                            </td> -->	
	  </tr>
	  <tr>
                                      <td></td>
                                          <!-- <td colspan=4 valign=top align=left class=form_title>Autocertificazione adeguamento D.Lgs 152/2006
                                            <formwidget id="auto_adeg_152">
                                                <formerror  id="auto_adeg_152"><br>
                                                  <span class="errori">@formerror.auto_adeg_152;noquote@</span>
                                                </formerror>
                                            </td> -->
                                      </tr>      
	  </table>
	  </td>
	  </tr> 

	<tr>
	  <td colspan=5 align=left><table width="100%">
	      <tr>
		 <td valign=top align=left class=form_title>Data utile interv.</td>
                                       <td valign=top class=form_title>Anomalia</td>
                                       <td valign=top class=form_title>Princ.</td>
	      </tr> 
	      <formwidget id="prog_anom_max">
		<multiple name=multiple_form>
		  <tr>
		    <formwidget id="prog_anom.@multiple_form.conta;noquote@">
		      <td valign=top align=left><formwidget id="data_ut_int.@multiple_form.conta;noquote@">
			  <formerror  id="data_ut_int.@multiple_form.conta;noquote@"><br>
			    <span class="errori"><%= $formerror(data_ut_int.@multiple_form.conta;noquote@) %></span>
			  </formerror>
		      </td>
		      <td valign=top><formwidget id="cod_anom.@multiple_form.conta;noquote@">
			  <formerror  id="cod_anom.@multiple_form.conta;noquote@"><br>
			    <span class="errori"><%= $formerror(cod_anom.@multiple_form.conta;noquote@) %></span>
			  </formerror>
		      </td>
                                             <td valign=top><formwidget id="princip.@multiple_form.conta;noquote@">
                                              <formerror  id="princip.@multiple_form.conta;noquote@"><br>
                                            <span class="errori"><%= $formerror(princip.@multiple_form.conta;noquote@) %></span>
                                             </formerror>
    </td>

		  </tr>
		</multiple>
	  </table></td>
	</tr>

	<if @flag_cod_tecn@ ne S>
	  <if @flag_sanzioni@ eq S>
	    <tr>
	      <td><table border=0 width="100%">
		  @mess_err_sanz;noquote@
		  <tr>
		    <td valign=top align=left class=form_title>Tipo sanzione 1</td>
		    <td valign=top colspan=3><formwidget id="cod_sanzione_1">@mess_err_sanz1;noquote@
			<formerror  id="cod_sanzione_1"><br>
			  <span class="errori">@formerror.cod_sanzione_1;noquote@</span>
			</formerror>
		    </td>
		  </tr>
		  <tr>
		    <td valign=top align=left class=form_title>Tipo sanzione 2</td>
		    <td valign=top><formwidget id="cod_sanzione_2">@mess_err_sanz2;noquote@
			<formerror  id="cod_sanzione_2"><br>
			  <span class="errori">@formerror.cod_sanzione_2;noquote@</span>
			</formerror>
		    </td>
		    <td valign=top align=left class=form_title>Importo totale</td>
		    <td valign=top><formwidget id="costo">
			<formerror  id="costo"><br>
			  <span class="errori">@formerror.costo;noquote@</span>
			</formerror>
		    </td>
		  </tr>
		  <tr>
		    <td valign=top align=left class=form_title>Data scad. pagamento</td>
		    <td valign=top colspan=3><formwidget id="data_scad_pagamento">
			<formerror  id="data_scad_pagamento"><br>
			  <span class="errori">@formerror.data_scad_pagamento;noquote@</span>
			</formerror>
		    </td>
		  </tr>
	      </table></td>
	    </tr>
	  </if>
	  <else>
	    <tr>
	      <td colspan=5><table border=0 width="100%">
		  <tr>
		    <td valign=top align=left class=form_title>Tipologia costo</td>
		    <td valign=top colspan=3><formwidget id="tipologia_costo">
			<formerror  id="tipologia_costo"><br>
			  <span class="errori">@formerror.tipologia_costo;noquote@</span>
			</formerror>
		    </td>
		    <td valign=top align=left class=form_title>Costo &#8364;</td>
		    <td valign=top><formwidget id="costo">
			<formerror  id="costo"><br>
			  <span class="errori">@formerror.costo;noquote@</span>
			</formerror>
		    </td>
		  </tr>
		  <tr>
		    <td valign=top align=left class=form_title>Data scad. pagamento</td>
		    <td valign=top ><formwidget id="data_scad_pagamento">
			<formerror  id="data_scad_pagamento"><br>
			  <span class="errori">@formerror.data_scad_pagamento;noquote@</span>
			</formerror>
		    </td>
		   <!-- <td valign=top align=left class=form_title>Numero fattura</td>
		    <td valign=top ><formwidget id="numfatt">
			<formerror  id="numfatt"><br>
			  <span class="errori">@formerror.numfatt;noquote@</span>
			</formerror>
		    </td>
		    <td valign=top align=left class=form_title>Data fattura</td>
		    <td valign=top ><formwidget id="data_fatt">
			<formerror  id="data_fatt"><br>
			  <span class="errori">@formerror.data_fatt;noquote@</span>
			</formerror>
		    </td> -->
		  </tr>
		  <tr>
		<!--    <td valign=top align=left class=form_title>Presenza firma Tecnico</td>
		    <td valign=top ><formwidget id="fl_firma_tecnico">
			<formerror id="fl_firma_tecnico"><br>
			  <span class="errori">@formerror.fl_firma_tecnico;noquote@</span>
			</formerror>
		    </td>
		    <td valign=top align=left class=form_title>Presenza firma responsabile</td>
		    <td><formwidget id="fl_firma_resp">
			<formerror id="fl_firma_resp"><br>
			  <span class="errori">@formerror.fl_firma_resp;noquote@</span>
			</formerror>
		    </td>
		    <td> Rifiuto firma</td>
		    <td>
		      <formwidget id="fl_rifiuto_firma">
			<formerror id="fl_rifiuto_firma"><br>
			  <span class="errori">@formerror.fl_rifiuto_firma;noquote@</span>
			</formerror>
		    </td> -->
		  </tr>
		  <tr><td colspan="4">&nbsp;</td></tr>
		</table>
	      </td>
	    </tr>
	  </else>
	</if>
<!--        <tr>
	  <td colspan=5>
            <table border=0 width="100%">
	      <tr>
		<td colspan=4 align=center valign=top class=func-menu><b>DATI FINALI</b></td>
	      </tr>
	      <tr>
		<td width="32%" valign=top align=left class=form_title>Deve presentare Modulo RIMESSA a NORMA</td>
		<td width="08%" valign=top><formwidget id="deve_non_messa_norma">
		    <formerror  id="deve_non_messa_norma"><br>
		      <span class="errori">@formerror.deve_non_messa_norma;noquote@</span>
		    </formerror>
		</td>
                <td width="34%" valign=top align=left class=form_title>Deve presentare Nuovo RCEE Tipo 1</td>
		<td width="26%" valign=top ><formwidget id="deve_non_rcee">
		    <formerror  id="deve_non_rcee"><br>
		      <span class="errori">@formerror.deve_non_rcee;noquote@</span>
		    </formerror>
		</td>
             </tr>
             <tr>
                <td valign=top align=left class=form_title>L'impianto PUO' Rimanere in funzione</td>
		<td valign=top ><formwidget id="rimanere_funzione">
		    <formerror  id="rimanere_funzione"><br>
		      <span class="errori">@formerror.rimanere_funzione;noquote@</span>
		    </formerror>
		</td>
                <td valign=top align=left class=form_title>Pagamento effettuato prima del controllo</td>
		<td valign=top ><formwidget id="pagamento_effettuato">
		    <formerror  id="pagamento_effettuato"><br>
		      <span class="errori">@formerror.pagamento_effettuato;noquote@</span>
		    </formerror>
		</td>
	      </tr>
                                          <tr><td colspan="4">&nbsp;</td></tr>
	    </table>
	  </td>
	</tr> -->
	<tr>
	<td colspan=5>
	<table width=100% border=0>
	  <tr>
		    <td valign=top align=left class=form_title>
	                <b>Esito Positivo: Rientra</b><small> nei termini di legge<br></small><b>Esito Negativo: Non rientra</b><small><small> le non conformità vanno sanate entro 60 gg pena una sanzione</small></small>
		</td>
		<if @vis_desc_ver@ eq f>
                                            <td valign=top align=left><formwidget id="esito_verifica">
                                                        <formerror  id="esito_verifica"><br>
                                                          <span class="errori">@formerror.esito_verifica;noquote@</span>
                                                        </formerror>
                                            </td>
                                            </if>
                                            <else>
                                            <td valign=top align=left><formwidget id="text_esito_verifica">
                                                       <formerror  id="text_esito_verifica"><br>
                                                          <span class="errori">@formerror.text_esito_verifica;noquote@</span>
                                                        </formerror>
                                            </td>
                                            </else>
	       </tr>
	  </table>
	  </td>
	  </tr>     

	<if @funzione@ ne "V">
	  <tr><td colspan=5 align=center><formwidget id="submitbut"></td></tr>
	</if>

	<!-- Fine della form colorata -->
	<%=[iter_form_fine]%>

    </formtemplate>
    <p>
  </center>
