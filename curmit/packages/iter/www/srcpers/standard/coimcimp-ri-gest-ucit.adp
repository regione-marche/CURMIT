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
	<td width="12.50%" nowrap class=func-menu>Aggiungi</td>
      </if>
      <else>
	<td width="12.50%" nowrap class=func-menu>@link_manc_ver;noquote@</td>
	<td width="12.50%" nowrap class=@func_i;noquote@>
	  <a href="@pack_dir;noquote@/coimcimp-gest?funzione=I&flag_tracciato=N1&@link_gest;noquote@" class=@func_i;noquote@>Aggiungi</a>
	</td>
      </else>
      <if @funzione@ ne "I">
	<td width="12.50%" nowrap class=@func_v;noquote@>
          <a href="@pack_dir;noquote@/coimcimp-gest?funzione=V&@link_gest;noquote@" class=@func_v;noquote@>Visualizza</a>
	</td>
	<if @flag_modifica@ eq T>
          <td width="12.50%" nowrap class=@func_m;noquote@>
            <a href="@pack_dir;noquote@/coimcimp-gest?funzione=M&@link_gest;noquote@" class=@func_m;noquote@>Modifica</a>
          </td>
	</if>
	<else>
          <td width="14.29%" nowrap class=func-menu>Modifica</td>
	</else>
        <td width="12.50%" nowrap class=@func_d;noquote@>
          <a href="@pack_dir;noquote@/coimcimp-gest?funzione=D&@link_gest;noquote@" class=@func_d;noquote@>Cancella</a>
        </td>
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
						<td colspan=6 align=center valign=top class=func-menu><b>1. DATI GENERALI</b></td>
					      </tr>
					      <tr>
						<td valign=top  align=left class=form_title>Data controllo <font color=red>*</font></td>
						<td valign=top><formwidget id="data_controllo">
						    <formerror  id="data_controllo"><br>
						      <span class="errori">@formerror.data_controllo;noquote@</span>
						    </formerror>
						</td>
						<td valign=top align=left class=form_title>Ora</td>
                                                <td valign=top><formwidget id="ora_inizio">                                                     <formerror  id="ora_inizio"><br>
                                                      <span class="errori">@formerror.ora_inizio;noquote@</span>
                                                    </formerror>
                                                </td>
						<td valign=top align=left class=form_title>Aggiorna appuntamento</td>
						<td valign=top><formwidget id="cod_inco">@link_inco;noquote@
						    <formerror  id="cod_inco"><br>
						      <span class="errori">@formerror.cod_inco;noquote@</span>
						    </formerror>
						</td>
					      </tr>
					      <tr>
						<td valign=top align=left class=form_title>N. verbale</td>
						<td valign=top><formwidget id="verb_n">
						    <formerror  id="verb_n"><br>
						      <span class="errori">@formerror.verb_n;noquote@</span>
						    </formerror>
						</td>
						<td valign=top align=left class=form_title>Data verbale</td>
						<td colspan=3 valign=top><formwidget id="data_verb">
						    <formerror  id="data_verb"><br>
						      <span class="errori">@formerror.data_verb;noquote@</span>
						    </formerror>
						</td>
					      </tr>

					      <tr>
						<td valign=top align=left class=form_title>Verificatore <font color=red>*</font></td>
						<td valign=top colspan=5><formwidget id="cod_opve">
						    <if @disabled_opve@ eq "disabled">
						      <formwidget id="des_opve">
						    </if>
						    <formerror  id="cod_opve"><br>
						      <span class="errori">@formerror.cod_opve;noquote@</span>
						    </formerror>
						</td>
					      </tr>

					      <if @funzione@ eq "K" >
						<tr>
						  <td valign=top  align=left class=form_title>Dichiarato</td>
						  <td valign=top><formwidget id="dichiarato">
						      <formerror  id="dichiarato"><br>
							<span class="errori">@formerror.dichiarato;noquote@</span>
						      </formerror>
						  </td>

						  <td valign=top  align=left class=form_title>Data allegato G/F</td>
						  <td valign=top><formwidget id="new1_data_dimp">
						      <formerror  id="new1_data_dimp"><br>
							<span class="errori">@formerror.new1_data_dimp;noquote@</span>
						      </formerror>
						  </td>
						</tr>
						<tr>
						  <td valign=top align=left class=form_title>Data versamento C.C.P.</td>
						  <td valign=top><formwidget id="new1_data_paga_dimp">
						      <formerror  id="new1_data_paga_dimp"><br>
							<span class="errori">@formerror.new1_data_paga_dimp;noquote@</span>
						      </formerror>
						  </td>
						  <td valign=top align=left class=form_title>Bollino N.</td>
						  <td valign=top><formwidget id="riferimento_pag_bollini">
						      <formerror  id="riferimento_pag_bollini"><br>
							<span class="errori">@formerror.riferimento_pag_bollini;noquote@</span>
						      </formerror>
						  </td>
						  <td valign=top align=left class=form_title>Importo versato</td>
						  <td valign=top><formwidget id="imp_boll_ver">
						      <formerror  id="imp_boll_ver"><br>
							<span class="errori">@formerror.imp_boll_ver;noquote@</span>
						      </formerror>
						  </td>
						</tr>
						<tr>
						  <td valign=top align=left class=form_title>Bollino ACEA</td>
						  <td valign=top><formwidget id="n_prot">
						      <formerror  id="n_prot"><br>
							<span class="errori">@formerror.n_prot;noquote@</span>
						      </formerror>
						  </td>
						  <td valign=top align=left class=form_title>Data Bollino ACEA</td>
						  <td valign=top><formwidget id="data_prot">
						      <formerror  id="data_prot"><br>
							<span class="errori">@formerror.data_prot;noquote@</span>
						      </formerror>
						  </td>
						</tr>
					      </if>
					      
					      <if @funzione@ eq "V" or @funzione@ eq "D">
						<tr>
						  <td colspan=2>Il responsabile dell'impianto &egrave; @aimp_flag_resp_desc;noquote@
						  </td>
						</tr>
					      </if>
					      <tr>
						<td valign=top align=left class=form_title >Responsabile</td>
						<td valign=top colspan=5><formwidget id="cogn_responsabile">    
						    <formwidget id="nome_responsabile">@cerca_resp;noquote@
						      <formerror  id="cogn_responsabile"><br>
							<span class="errori">@formerror.cogn_responsabile;noquote@</span>
						      </formerror>
						      <br/>@link_ins_resp;noquote@ 
						</td>
					      </tr>
					      <tr><td valign=top align=left class=form_title>Eventuale delegato</td>
						<td valign=top colspan=5><formwidget id="nominativo_pres">
						    <formerror  id="nominativo_pres"><br>
						      <span class="errori">@formerror.nominativo_pres;noquote@</span>
						    </formerror>
						</td>
					      </tr>


					      <tr>
						<td valign=top align=left class=form_title>Potenze termiche al focolare</td>
						<td valign=top><formwidget id="potenza_nom_tot_foc">(kw)
						    <formerror  id="potenza_nom_tot_foc"><br>
						      <span class="errori">@formerror.potenza_nom_tot_foc;noquote@</span>
						    </formerror>
						</td>
						<td valign=top align=left class=form_title>Utile</td>
						<td valign=top colspan=3><formwidget id="potenza_nom_tot_util">(kw)
						    <formerror  id=""potenza_nom_tot_util"><br>
						      <span class="errori">@formerror."potenza_nom_tot_util;noquote@</span>
						    </formerror>
						</td>
					      </tr>
					      
					      
					      <tr>
						<td valign=top align=left class=form_title>Volumetria riscaldata (m<sup><small>3</small></sup>)</td>
						<td valign=top><formwidget id="volumetria">
						    <formerror  id="volumetria"><br>
						      <span class="errori">@formerror.volumetria;noquote@</span>
						    </formerror>
						</td>
						<td valign=top align=left class=form_title>Consumi ultima stagione di riscaldamento (m<sup><small>3</small></sup>/kg)</td>
						<td valign=top colspan=3><formwidget id="comsumi_ultima_stag">
						    <formerror  id="comsumi_ultima_stag"><br>
						      <span class="errori">@formerror.comsumi_ultima_stag;noquote@</span>
						    </formerror>
						</td>
					      </tr>
					    </table>
					  <td>
					</tr>
					<tr><td>&nbsp;</td></tr>
					<tr>
					  <td><table border=0 width="100%">
					      <tr>
						<td colspan=4 align=center valign=top class=func-menu><b>1. DESTINAZIONE</b></td>
					      </tr>
					      <tr>
                                                <td class=form_title>Cat. Edificio</td>
						<td class=form_title>Dest.prevalente dell'immobile</td>
						<td class=form_title>Impianto a servizio di:</td>
						<td class=form_title>Destinazione d'uso dell'impianto</td>
						</tr>
					      <tr>
                                                <td valign=top><formwidget id="cod_cted">
						    <formerror  id="cod_cted"><br>
						      <span class="errori">@formerror.cod_cted;noquote@</span>
						    </formerror>
						</td>
						<td valign=top><formwidget id="cod_tpdu">
						    <formerror  id="cod_tpdu"><br>
						      <span class="errori">@formerror.cod_tpdu;noquote@</span>
						    </formerror>
						</td>
						<td valign=top><formwidget id="cod_tpim">
						    <formerror  id="cod_tpim"><br>
						      <span class="errori">@formerror.cod_tpim;noquote@</span>
						    </formerror>
						</td>
						<td valign=top><formwidget id="cod_utgi">
						    <formerror  id="cod_utgi"><br>
						      <span class="errori">@formerror.cod_utgi;noquote@</span>
						    </formerror>
						</td>
						</tr>
					    </table>
					  </td>
					</tr>


<tr>
					  <td><table border=0 width="100%">
					      <tr>
                                               <td class=form_title>Combustibile</td>
					      </tr>
					      <tr>
                                               	<td valign=top><formwidget id="cod_combustibile">
						    <formerror  id="cod_combustibile"><br>
						      <span class="errori">@formerror.cod_combustibile;noquote@</span>
						    </formerror>
						</td>
					      </tr>
                                             </tr>

					    </table>
					  </td>
					  <tr>
					  <td>
                                            <table border=0 width="100%">
                                              <tr>
                                               <td class=form_title>Trattamento in riscaldamento
					       <formwidget id="tratt_in_risc">
                                                    <formerror  id="tratt_in_risc"><br>
                                                      <span class="errori">@formerror.tratt_in_risc;noquote@</span>
                                                    </formerror>
                                                </td>
                                                                                           
                                                <td class=form_title>Trattamento in acs
                                                <formwidget id="tratt_in_acs">
                                                    <formerror  id="tratt_in_acs"><br>
                                                      <span class="errori">@formerror.tratt_in_acs;noquote@</span>
                                                    </formerror>
                                                </td>
                                              </tr>
                                             </tr>

                                            </table>
                                          </td>
					  
					</tr>
					<tr>
					  <td>
					  <table border=0 width="100%">
                                              <tr>
                                                <td colspan=6 align=center valign=top class=func-menu><b>2. GENERATORI</b></t\
d>
                                              </tr>
					      <tr>
                                                <td valign=top align=left class=form_title>Generatore</td>
                                                <td valign=top align=right class=form_title bgcolor=white>@gend_gen_prog_est;noquote@/@n_generatori;noquote@</td>
						<td valign=top align=left class=form_title>Data installazione impianto</td>
						<td valign=top align=right><formwidget id="aimp_data_installaz_v">
						    <formerror  id="aimp_data_installaz_v"><br>
						      <span class="errori">@formerror.aimp_data_installaz_v@</span>
						    </formerror>
						</td>
						<td valign=top align=left class=form_title>Data installazione generatore</td>
						<td valign=top align=right><formwidget id="gend_data_installaz_v">
						    <formerror  id="gend_data_installaz_v"><br>
						      <span class="errori">@formerror.gend_data_installaz_v@</span>
						    </formerror>
						</td>
                                               </tr>
					       <tr>
					         <td valign=top align=left class=form_title>Tipo caldaia</td>
						<td valign=top align=right><formwidget id="tipo_foco">
						    <formerror  id="tipo_foco"><br>
						      <span class="errori">@formerror.tipo_foco;noquote@</span>
						    </formerror>
						</td>
						<!--<td valign=top align=left class=form_title>Scarico Fumi</td>
						<td valign=top align=right><formwidget id="gend_cod_emissione">
                                                    <formerror  id="gend_cod_emissione"><br>
                                                      <span class="errori">@formerror.gend_cod_emissione;noquote@</span>
                                                    </formerror>
                                                </td> -->
                                                <td valign=top align=left class=form_title>Tiraggio</td>
						<td valign=top align=right><formwidget id="gend_tiraggio">
                                                    <formerror  id="gend_tiraggio"><br>
                                                      <span class="errori">@formerror.gend_tiraggio;noquote@</span>
                                                    </formerror>
                                                </td>
						<td valign=top align=left class=form_title>Fluido termovettore</td>
 						<td valign=top align=right><formwidget id="mod_funz">
						    <formerror  id="mod_funz"><br>
						      <span class="errori">@formerror.mod_funz;noquote@</span>
						    </formerror>
						</td>
					      </tr>
					      <tr>
                                                <td valign=top align=left class=form_title>Costruttore generatore</td>
						<td valign=top align=right><formwidget id="cod_cost">
						    <formerror  id="cod_cost"><br>
						      <span class="errori">@formerror.cod_cost;noquote@</span>
						    </formerror>
						</td>
						<td valign=top align=left class=form_title>Modello generatore</td>
						<td valign=top align=right><formwidget id="modello">
						    <formerror  id="modello"><br>
						      <span class="errori">@formerror.modello;noquote@</span>
						    </formerror>
						</td>
						<td valign=top align=left class=form_title>Matricola</td>
						<td valign=top align=right><formwidget id="matricola">
						    <formerror  id="matricola"><br>
						      <span class="errori">@formerror.matricola;noquote@</span>
						    </formerror>
						</td>
					      </tr>
					      <tr>
						<td valign=top align=left class=form_title>Classificazione DPR 660/96</td>
						<td valign=top align=right><formwidget id="dpr_660_96">
						    <formerror  id="dpr_660_96"><br>
						      <span class="errori">@formerror.dpr_660_96;noquote@</span>
						    </formerror>
						</td>
						<td valign=top align=left class=form_title>Locale d'installazione</td>
						<td valign=top align=right><formwidget id="locale">
						    <formerror  id="locale"><br>
						      <span class="errori">@formerror.locale;noquote@</span>
						    </formerror>
						</td>
                                                <tr>
                                                <td valign=top align=left class=form_title><b>Bruciatore</b></td>
                                                </tr><tr>
                                                <td valign=top align=left class=form_title>Costruttore Bruciatore</td>
						<td valign=top align=right><formwidget id="cod_cost_bruc">
						    <formerror  id="cod_cost_bruc"><br>
						      <span class="errori">@formerror.cod_cost_bruc;noquote@</span>
						    </formerror>
						</td>
						<td valign=top align=left class=form_title>Modello Bruciatore</td>
						<td valign=top align=right><formwidget id="modello_bruc">
						    <formerror  id="modello_bruc"><br>
						      <span class="errori">@formerror.modello_bruc;noquote@</span>
						    </formerror>
						</td>
						<td valign=top align=left class=form_title>Matricola Bruc.</td>
						<td valign=top align=right><formwidget id="matricola_bruc">
						    <formerror  id="matricola_bruc"><br>
						      <span class="errori">@formerror.matricola_bruc;noquote@</span>
						    </formerror>
						</td>
					      </tr>
					      <tr>
						<td valign=top align=left class=form_title>Tipo Bruciatore</td>
						<td valign=top align=right><formwidget id="tipo_bruciatore">
						    <formerror  id="tipo_bruciatore"><br>
						      <span class="errori">@formerror.tipo_bruciatore;noquote@</span>
						    </formerror>
						</td>
						<td valign=top align=left class=form_title>Campo di funzionamento</td>
						<td valign=top align=right><formwidget id="campo_funzion_min">
						    <formerror  id="campo_funzion_min"><br>
						      <span class="errori">@formerror.campo_funzion_min;noquote@</span>
						    </formerror>
						</td>
                                               	<td valign=top align=right><formwidget id="campo_funzion_max">
						    <formerror  id="campo_funzion_max"><br>
						      <span class="errori">@formerror.campo_funzion_max;noquote@</span>
						    </formerror>
						</td>
						<td colspan=3></td>
					      </tr>
					      <tr>
                                                 <td colspan=2 class=form_title>Dati Nominali:</td>
                                                 <td valign=top align=left class=form_title>Potenza termica al focolare</td>
						<td valign=top align=right>(kW)
						  <formwidget id="pot_focolare_nom">
						    <formerror  id="pot_focolare_nom"><br>
						      <span class="errori">@formerror.pot_focolare_nom;noquote@</span>
						    </formerror>
						</td>
                                                <td valign=top align=left class=form_title>Potenza termica utile</td>
						<td valign=top align=right>(kW)
						  <formwidget id="pot_utile_nom">
						    <formerror  id="pot_utile_nom"><br>
						      <span class="errori">@formerror.pot_utile_nom;noquote@</span>
						    </formerror>
						</td>
                                              </tr>
                                              <tr>
 	                                        <td valign=top align=left class=form_title colspan=2>Dati Effettivi:</td>
                                                <td valign=top align=left class=form_title>Potenza termica al focolare</td>
						<td valign=top align=right>(kW)
						  <formwidget id="potenza_effettiva_nom">
						    <formerror  id="potenza_effettiva_nom"><br>
						      <span class="errori">@formerror.potenza_effettiva_nom;noquote@</span>
						    </formerror>
						</td>
						<td valign=top align=left class=form_title>Potenza termica utile</td>
						<td valign=top align=right>(kW)
						  <formwidget id="potenza_effettiva_util">
						    <formerror  id="potenza_effettiva_util"><br>
						      <span class="errori">@formerror.potenza_effettiva_util;noquote@</span>
						    </formerror>
						</td>
                                              </tr>
                                              <tr>
                                                <td valign=top align=left class=form_title colspan=2>Dati misurati:</td>
                                                <td valign=top align=left class=form_title>Portata di combustibile</td>
						<td valign=top align=right>(m<sup>3</sup>/h)/(kg/h)
						  <formwidget id="mis_port_combust">
						    <formerror  id="mis_port_combust"><br>
						      <span class="errori">@formerror.mis_port_combust;noquote@</span>
						    </formerror>
						</td>
						<td valign=top align=left class=form_title>Potenza termica al focolare</td>
						<td valign=top align=right>(kW)
						  <formwidget id="mis_pot_focolare">
						    <formerror  id="mis_pot_focolare"><br>
						      <span class="errori">@formerror.mis_pot_focolare;noquote@</span>
						    </formerror>
						</td>
                                              </tr>
					      <tr>
					         <td valign=top align=left class=form_title>Gruppo Termico</td>
					         <td valign=top colspan=5><formwidget id="cod_grup_term">
						    <formerror  id="cod_grup_term"><br>
						      <span class="errori">@formerror.cod_grup_term;noquote@</span>
						    </formerror>
						</td>						
					      </tr>
					      </table>
				          </td>
					  </tr>
					  <tr>
					  <td><table border=0 width="100%">
					      <tr>
						<td colspan=4 align=center valign=top class=func-menu><b>3. STATO DELL'IMPIANTO</b></td>
					      </tr>
					      <tr>
						<td valign=top width="25%" align=left class=form_title>Installazione interna Locale idoneo:</td>
						<td valign=top width="25%" align=right >
						  <formwidget id="interna_locale_idoneo">
						    <formerror  id="interna_locale_idoneo"><br>
						      <span class="errori">@formerror.interna_locale_idoneo;noquote@</span>
						    </formerror>
						</td>            
						<td valign=top align=left class=form_title>Installazione esterna generatore Idoneo</td>
						<td valign=top align=right><formwidget id="esterna_generatore_idoneo">
						    <formerror  id="esterna_generatore_idoneo"><br>
						      <span class="errori">@formerror.esterna_generatore_idoneo;noquote@</span>
						    </formerror>
						</td>
						<!-- <td valign=top width="25%" align=right class=form_title>@gend_tipologia_emissione;noquote@ @gend_tipologia_emissione_error;noquote@</td> -->
					      </tr>
                                              <tr><td colspan=4 align=center valign=top>
                                              <table width="100%" border=0>

                                               <tr>
						<td valign=top align=left class=form_title>Verifica ventilazione locali</td> 
						<td valign=top align=right><formwidget id="ventilazione_locali">
						    <formerror  id="ventilazione_locali"><br>
						      <span class="errori">@formerror.ventilazione_locali;noquote@</span>
						    </formerror>
						</td>
                                                <td valign=top align=right class=form_title> Minore di cm2</td> 
						<td valign=top align=left><formwidget id="ventilazione_locali_mis">
						    <formerror  id="ventilazione_locali_mis"><br>
						      <span class="errori">@formerror.ventilazione_locali_mis;noquote@</span>
						    </formerror>
						</td>

						<td valign=top align=left class=form_title>Verifica areazione locali</td>
						<td valign=top align=right><formwidget id="areazione_locali">
						    <formerror  id="areazione_locali"><br>
						      <span class="errori">@formerror.areazione_locali;noquote@</span>
						    </formerror>
						</td>
					      </tr></table></td></tr>
					      <tr>
						<td valign=top align=left class=form_title> Stato canale da Fumo</td>
						<td valign=top align=right><formwidget id="effic_evac">
						    <formerror  id="effic_evac"><br>
						      <span class="errori">@formerror.effic_evac;noquote@</span>
						    </formerror>
						</td>
						<td valign=top align=left class=form_title>Idoneo * <small> dim./pend./alt./larg./cambi di direz./ non conforme</small></td>
						<td valign=top align=right><formwidget id="canale_fumo_idoneo">
						    <formerror  id="canale_fumo_idoneo"><br>
						      <span class="errori">@formerror.canale_fumo_idoneo;noquote@</span>
						    </formerror>
						</td>
					      </tr>
					      <tr>
						<td valign=top align=left class=form_title>Verifica visiva dello stato delle coibentazioni</td>
						<td valign=top align=right>
						  <formwidget id="stato_coiben">
						    <formerror  id="stato_coiben"><br>
						      <span class="errori">@formerror.stato_coiben;noquote@</span>
						    </formerror>
						</td>
					      </tr>
					      <tr>
						<td valign=top align=left class=form_title>Verifica dispositivo di regolazione e controllo</td>
						<td valign=top align=right><formwidget id="verifica_disp_regolazione">
						    <formerror  id="verifica_disp_regolazione"><br>
						      <span class="errori">@formerror.verifica_disp_regolazione;noquote@</span>
						    </formerror>
						</td>
						
					      </tr>	
					      <tr>
			    
					    </table>
					  </td>
					</tr>
					<tr>
					  <td>
					    <table border=0 width="100%">
					      <tr>
						<td colspan=4 align=center valign=top class=func-menu><b>4. STATO DELLA DOCUMENTAZIONE MANUTENZIONE ED ANALISI</b></td>
					      </tr>
					      <tr>
						<td valign=top width="35%" align=left class=form_title>Libretto impianto o centrale presente</td>
						<td valign=top width="15%"align=right width="10%">
						  <formwidget id="presenza_libretto">
						    <formerror  id="presenza_libretto"><br>
						      <span class="errori">@formerror.presenza_libretto;noquote@</span>
						    </formerror>
						</td>
						<td valign=top align=left class=form_title>Compilazione libretto impianto o centrale completa</td>
						<td valign=top align=right><formwidget id="libretto_corretto">
						    <formerror  id="libretto_corretto"><br>
						      <span class="errori">@formerror.libretto_corretto;noquote@</span>
						    </formerror>
						</td>
				              </tr> 
					      <tr>
						<td valign=top width="35%" align=left class=form_title>Dichiarazione conformit&agrave;</td>
						<td valign=top width="15%" align=right>
						  <formwidget id="dich_conformita">
						    <formerror  id="dich_conformita"><br>
						      <span class="errori">@formerror.dich_conformita;noquote@</span>
						    </formerror>
						</td>
						<td valign=top width="35%" align=left class=form_title>Libretto/i di uso e manutenzione presente/i</td>
						<td valign=top width="15%" align=right>
						  <formwidget id="libretto_manutenz">
						    <formerror  id="libretto_manutenz"><br>
						      <span class="errori">@formerror.libretto_manutenz;noquote@</span>
						    </formerror>
						</td>
						<tr>
                                                <td valign=top width="35%" align=left class=form_title>Dichiarazione D.Lgs. 152 presente</td>
                                                <td valign=top width="15%" align=right>
                                                  <formwidget id="dich_152_presente">
                                                    <formerror  id="dich_152_presente"><br>
                                                      <span class="errori">@formerror.dich_152_presente;noquote@</span>
                                                    </formerror>
                                                </td>
						<td colspan=2></td>
						</tr>
                                                </tr>
                                                <tr> 
						<td valign=top width=35% align=left class=form_title>
						         Certificato prevenzione incendi per impianti mag.116,3 kW
					        </td>
						<td valign=top width="15%" align=right>
						  <formwidget id="doc_prev_incendi">
						    <formerror  id="doc_prev_incendi"><br>
						      <span class="errori">@formerror.doc_prev_incendi;noquote@</span>
						    </formerror>
						</td>
						<td valign=top width="35%" align=left class=form_title>Pratica INAIL (ex ISPESL) per generatori in pressione</td>
						<td valign=top width="15%" align=right>
						  <formwidget id="doc_ispesl">
						    <formerror  id="doc_ispesl"><br>
						      <span class="errori">@formerror.doc_ispesl;noquote@</span>
						    </formerror>
						</td>
					      </tr>
                                                <tr>
						<td valign=top align=left class=form_title>Cartellonistica prevista presente</td>
						<td valign=top align=right >
						  <formwidget id="new1_pres_cartell">
						    <formerror  id="new1_pres_cartell"><br>
						      <span class="errori">@formerror.new1_pres_cartell;noquote@</span>
						    </formerror>
						</td>
                                                <td valign=top align=left class=form_title>g) Mezzi di estinzione degli incendi presenti <font color=red>*</font></td>
						<td valign=top align=right >
						  <formwidget id="new1_pres_mezzi">
						    <formerror  id="new1_pres_mezzi"><br>
						      <span class="errori">@formerror.new1_pres_mezzi;noquote@</span>
						    </formerror>
						</td>    
                                                </tr>
                                                <tr>       
						<td valign=top width="35%" align=left class=form_title>Interruttore generale esterno presente <font color=red>*</font></td>
						<td valign=top width="15%" align=right >
						  <formwidget id="new1_pres_interrut">
						    <formerror  id="new1_pres_interrut"><br>
						      <span class="errori">@formerror.new1_pres_interrut;noquote@</span>
						    </formerror>
						</td>
					       <td valign=top align=left class=form_title>Rubinetto di intercettazione manuale esterna presente <font color=red>*</font></td>
						<td valign=top align=right >
						  <formwidget id="new1_pres_intercet">
						    <formerror  id="new1_pres_intercet"><br>
						      <span class="errori">@formerror.new1_pres_intercet;noquote@</span>
						    </formerror>
						</td>
					      </tr> 
					     </table>
					  </td>
					</tr>
					<tr>
					  <td><table border=0 width="100%">
                                                    <tr>
				                      <td valign=top colspan=6 align=left class=form_title><b>Manutenzione</b></td>
						    </tr>
						    <tr>
						      <td valign=top align=left>Anno in corso
							<formwidget id="manutenzione_8a">
							  <formerror  id="manutenzione_8a"><br>
							    <span class="errori">@formerror.manutenzione_8a;noquote@</span>
							  </formerror>
						      </td>
						      <td valign=top width=13% align=left>Anni precedenti
						       </td><td align=left>
							<formwidget id="new1_manu_prec_8a">
							  <formerror  id="new1_manu_prec_8a"><br>
							    <span class="errori">@formerror.new1_manu_prec_8a;noquote@</span>
							  </formerror>
						      </td>
                                                       <td valign=top align=left>Frequenza
							<formwidget id="frequenza_manut">
							  <formerror  id="frequenza_manut"><br>
							    <span class="errori">@formerror.frequenza_manut;noquote@</span>
							  </formerror>
						      </td>
                                                     <td valign=top align=left>Altra freq.
							<formwidget id="frequenza_manut_altro">
							  <formerror  id="frequenza_manut_altro"><br>
							    <span class="errori">@formerror.frequenza_manut_altro;noquote@</span>
							  </formerror>
						      </td>

						    </tr>
					          <tr>
						<td valign=top align=left>Data ultima manutenzione
						 <formwidget id="new1_data_ultima_manu">
						    <formerror  id="new1_data_ultima_manu"><br>
						      <span class="errori">@formerror.new1_data_ultima_manu;noquote@</span>
						    </formerror>
						</td>
						<td valign=top colspan=4 align=left >Data ultima prova Eff. energetica
						 <formwidget id="new1_data_ultima_anal">
						    <formerror  id="new1_data_ultima_anal"><br>
						      <span class="errori">@formerror.new1_data_ultima_anal;noquote@</span>
						    </formerror>
						</td>
					      </tr>
					      <tr>
						<td  align=center rowspan=4 class=form_title>Rapporto di Eff. energetica:
                                                </td>
						<td valign=top  align=left>Presente
						</td><td align=left>
						  <formwidget id="new1_dimp_pres">
						    <formerror  id="new1_dimp_pres"><br>
						      <span class="errori">@formerror.new1_dimp_pres;noquote@</span>
						    </formerror>
						</td>
						<td valign=top align=left class=form_title colspan=2 rowspan=4>
						  Note prescrizioni &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						  @link_note_view;noquote@<br>
						  <formwidget id="new1_note_manu">
						    <formerror  id="new1_note_manu"><br>
						      <span class="errori">@formerror.new1_note_manu;noquote@</span>
						    </formerror>
						</td>
					      </tr> 
					      <tr>
						<td valign=top align=left>Con prescrizioni
						</td><td align=left>
						  <formwidget id="new1_dimp_prescriz">
						    <formerror  id="new1_dimp_prescriz"><br>
						      <span class="errori">@formerror.new1_dimp_prescriz;noquote@</span>
						    </formerror>
						</td>
					       </tr>
					       <tr>
                                               <td valign=top align=left>Con osservazioni
					       </td><td align=left>
						  <formwidget id="rcee_osservazioni">
						    <formerror  id="rcee_osservazioni"><br>
						      <span class="errori">@formerror.rcee_osservazioni;noquote@</span>
						    </formerror>
						</td>
						</tr>
						<tr>
                                                <td valign=top align=left>Con Raccomandazioni
						</td><td align=left>
						  <formwidget id="rcee_raccomandazioni">
						    <formerror  id="rcee_raccomandazioni"><br>
						      <span class="errori">@formerrorrcee_raccomandazioni;noquote@</span>
						    </formerror>
						</td>
						</tr>
					      </tr>

                                                <tr>
                                                <!--    <td valign=top  align=left class=form_title>RCEE inviato
						  <formwidget id="rcee_inviato">
						      <formerror  id="rcee_inviato"><br>
							<span class="errori">@formerror.rcee_inviato;noquote@</span>
						      </formerror>
						  </td>--> 
                                                <td valign=top  align=left class=form_title>Rispetto della periodicità prev. per norma di legge app. bollino e trasm. all'ente
						</td><td align=left>
						      <formwidget id="dichiarato">
						      <formerror  id="dichiarato"><br>
							<span class="errori">@formerror.dichiarato;noquote@</span>
						      </formerror>
						  </td>

                                                <td valign=top colspan=2 align=left class=form_title>Bollino N.
						  <formwidget id="riferimento_pag_bollini">
						      <formerror  id="riferimento_pag_bollini"><br>
							<span class="errori">@formerror.riferimento_pag_bollini;noquote@</span>
						      </formerror>
						  </td>
                                            </tr>
					    </table>
					  </td>
					</tr>

					<tr>
					  <td><table border=0 cellpadding=0 cellspacing=0 width="100%">
					      <tr>
						<td colspan=5 align=center valign=top class=func-menu><b>5. MISURA DEL RENDIMENTO DI COMBUSTIONE (UNI 10389)</b></td>
					      </tr>
					      <tr>
						<td colspan=5 >&nbsp;</td>
					      </tr>

                                             <tr>
						<td valign=center align=right class=form_title>Possibile effettuare la misura del rendimento</td>
						<td align=left valign=center>
						  <formwidget id="misurazione_rendimento">
						    <formerror  id="misurazione_rendimento"><br>
						      <span class="errori">@formerror.misurazione_rendimento;noquote@</span>
						    </formerror>
						</tr>


					      <tr>
						<td valign=center align=right class=form_title>Analizzatore</td>
						<td align=left valign=center>
						  <formwidget id="cod_strumento_01">
						    <formerror  id="cod_strumento_01"><br>
						      <span class="errori">@formerror.cod_strumento_01;noquote@</span>
						    </formerror>
						</td>
						<td valign=center align=right  class=form_title>Deprimometro</td>
						<td align=left valign=center colspan=2>
						  <formwidget id="cod_strumento_02">
						    <formerror  id="cod_strumento_02"><br>
						      <span class="errori">@formerror.cod_strumento_02;noquote@</span>
						    </formerror>
						</td>
					      </tr>

					      <tr>
						<td valign=top align=right width="30%" class=form_title>Misure</td>
						<td valign=top align=right width="17.5%" class=form_title>Prova 1</td>
						<td valign=top align=right width="17.5%" class=form_title>Prova 2</td>
						<td valign=top align=right width="17.5%" class=form_title>Prova 3</td>
						<td valign=top align=right width="17.5%" class=form_title>Media</td>
					      </tr>
					      <tr>
						<td valign=top align=left  class=form_title>Bacharach (per combustibili liquidi)</td>
						<td valign=top align=right>(N.)
						  <formwidget id="indic_fumosita_1a">
						    <formerror  id="indic_fumosita_1a"><br>
						      <span class="errori">@formerror.indic_fumosita_1a;noquote@</span>
						    </formerror>
						</td>
						<td valign=top align=right>
						  <formwidget id="indic_fumosita_2a">
						    <formerror  id="indic_fumosita_2a"><br>
						      <span class="errori">@formerror.indic_fumosita_2a;noquote@</span>
						    </formerror>
						</td>
						<td valign=top align=right>
						  <formwidget id="indic_fumosita_3a">
						    <formerror  id="indic_fumosita_3a"><br>
						      <span class="errori">@formerror.indic_fumosita_3a;noquote@</span>
						    </formerror>
						</td>
						<td >&nbsp;</td>
					      </tr>
					      <tr>
						<td valign=top align=left class=form_title>Temperatura fumi</td>
						<td valign=top align=right>(&#176;C)
						  <formwidget id="temp_fumi_1a">
						    <formerror  id="temp_fumi_1a"><br>
						      <span class="errori">@formerror.temp_fumi_1a;noquote@</span>
						    </formerror>
						</td>
						<td valign=top align=right>
						  <formwidget id="temp_fumi_2a">
						    <formerror  id="temp_fumi_2a"><br>
						      <span class="errori">@formerror.temp_fumi_2a;noquote@</span>
						    </formerror>
						</td>
						<td valign=top align=right>
						  <formwidget id="temp_fumi_3a">
						    <formerror  id="temp_fumi_3a"><br>
						      <span class="errori">@formerror.temp_fumi_3a;noquote@</span>
						    </formerror>
						</td>
						<td valign=top align=right>
						  <formwidget id="temp_fumi_md">
						    <formerror  id="temp_fumi_md"><br>
						      <span class="errori">@formerror.temp_fumi_md;noquote@</span>
						    </formerror>
						</td>
					      </tr>
					      
					      <tr>
						<td valign=top align=left class=form_title>Temperatura aria comburente</td>
						<td valign=top align=right>(&#176;C)
						  <formwidget id="t_aria_comb_1a">
						    <formerror  id="t_aria_comb_1a"><br>
						      <span class="errori">@formerror.t_aria_comb_1a;noquote@</span>
						    </formerror>
						</td>
						<td valign=top align=right>
						  <formwidget id="t_aria_comb_2a">
						    <formerror  id="t_aria_comb_2a"><br>
						      <span class="errori">@formerror.t_aria_comb_2a;noquote@</span>
						    </formerror>
						</td>
						<td valign=top align=right>
						  <formwidget id="t_aria_comb_3a">
						    <formerror  id="t_aria_comb_3a"><br>
						      <span class="errori">@formerror.t_aria_comb_3a;noquote@</span>
						    </formerror>
						</td>
						<td valign=top align=right>
						  <formwidget id="t_aria_comb_md">
						    <formerror  id="t_aria_comb_md"><br>
						      <span class="errori">@formerror.t_aria_comb_md;noquote@</span>
						    </formerror>
						</td>
					      </tr>
					      
					      
					      <tr>
						<td valign=top align=left class=form_title>CO<small><sub>2</sub></small></td>
						<td valign=top align=right>(%)
						  <formwidget id="co2_1a">
						    <formerror  id="co2_1a"><br>
						      <span class="errori">@formerror.co2_1a;noquote@</span>
						    </formerror>
						</td>
						<td valign=top align=right>
						  <formwidget id="co2_2a">
						    <formerror  id="co2_2a"><br>
						      <span class="errori">@formerror.co2_2a;noquote@</span>
						    </formerror>
						</td>
						<td valign=top align=right>
						  <formwidget id="co2_3a">
						    <formerror  id="co2_3a"><br>
						      <span class="errori">@formerror.co2_3a;noquote@</span>
						    </formerror>
						</td>
						<td valign=top align=right>
						  <formwidget id="co2_md">
						    <formerror  id="co2_md"><br>
						      <span class="errori">@formerror.co2_md;noquote@</span>
						    </formerror>
						</td>
					      </tr>
					      <tr>
						<td valign=top align=left class=form_title>O<small><sub>2</sub></small></td>
						<td valign=top align=right>(%)
						  <formwidget id="o2_1a">
						    <formerror  id="o2_1a"><br>
						      <span class="errori">@formerror.o2_1a;noquote@</span>
						    </formerror>
						</td>
						<td valign=top align=right>
						  <formwidget id="o2_2a">
						    <formerror  id="o2_2a"><br>
						      <span class="errori">@formerror.o2_2a;noquote@</span>
						    </formerror>
						</td>
						<td valign=top align=right>
						  <formwidget id="o2_3a">
						    <formerror  id="o2_3a"><br>
						      <span class="errori">@formerror.o2_3a;noquote@</span>
						    </formerror>
						</td>
						<td valign=top align=right>
						  <formwidget id="o2_md">
						    <formerror  id="o2_md"><br>
						      <span class="errori">@formerror.o2_md;noquote@</span>
						    </formerror>
						</td>
					      </tr>
					      <tr>
						<td valign=top align=left class=form_title>CO misurato</td>
						<td valign=top align=right>(ppm)
						  <formwidget id="co_1a">
						    <formerror  id="co_1a"><br>
						      <span class="errori">@formerror.co_1a;noquote@</span>
						    </formerror>
						</td>
						<td valign=top align=right>
						  <formwidget id="co_2a">
						    <formerror  id="co_2a"><br>
						      <span class="errori">@formerror.co_2a;noquote@</span>
						    </formerror>
						</td>
						<td valign=top align=right>
						  <formwidget id="co_3a">
						    <formerror  id="co_3a"><br>
						      <span class="errori">@formerror.co_3a;noquote@</span>
						    </formerror>
						</td>
						<td valign=top align=right>
						  <formwidget id="co_md">
						    <formerror  id="co_md"><br>
						      <span class="errori">@formerror.co_md;noquote@</span>
						    </formerror>
						</td>
					      </tr>
					      <tr>
						<td valign=top align=left class=form_title>Temperatura fluido di mandata</td>
						<td valign=top  align=right>(&#176;C)
						  <formwidget id="temp_h2o_out_1a">
						    <formerror  id="temp_h2o_out_1a"><br>
						      <span class="errori">@formerror.temp_h2o_out_1a;noquote@</span>
						    </formerror>
						</td>
						<td valign=top  align=right>
						  <formwidget id="temp_h2o_out_2a">
						    <formerror  id="temp_h2o_out_2a"><br>
						      <span class="errori">@formerror.temp_h2o_out_2a;noquote@</span>
						    </formerror>
						</td>
						<td valign=top  align=right>
						  <formwidget id="temp_h2o_out_3a">
						    <formerror  id="temp_h2o_out_3a"><br>
						      <span class="errori">@formerror.temp_h2o_out_3a;noquote@</span>
						    </formerror>
						</td>
						<td valign=top  align=right>
						  <formwidget id="temp_h2o_out_md">
						    <formerror  id="temp_h2o_out_md"><br>
						      <span class="errori">@formerror.temp_h2o_out_md;noquote@</span>
						    </formerror>
						</td>
					      </tr>
					      <tr>
						<td >Tiraggio</td>
						<td valign=top align=right>(Pa)
						  <formwidget id="tiraggio">
						    <formerror  id="tiraggio"><br>
						      <span class="errori">@formerror.tiraggio;noquote@</span>
						    </formerror>
						</td>
						
						<td colspan=3>&nbsp;</td>
					      </tr>
					      <tr>
						<td >E.T. (per cadaie non condensanti E.T. = 0)</td>
						<td valign=top align=right>(%)
						  <formwidget id="et">
						    <formerror  id="et"><br>
						      <span class="errori">@formerror.et;noquote@</span>
						    </formerror>
						</td>
						<td colspan=3>&nbsp;</td>
					      </tr>
                                             <tr>
						<td >Indice aria</td>
						<td valign=top align=right>
						  <formwidget id="eccesso_aria_perc">
						    <formerror  id="eccesso_aria_perc"><br>
						      <span class="errori">@formerror.eccesso_aria_perc;noquote@</span>
						    </formerror>
						</td>
						<td colspan=3>&nbsp;</td>
					      </tr>
                                             <tr>
						<td >Perdita ai fumi</td>
						<td valign=top align=right>(%)
						  <formwidget id="perdita_ai_fumi">
						    <formerror  id="perdita_ai_fumi"><br>
						      <span class="errori">@formerror.perdita_ai_fumi;noquote@</span>
						    </formerror>
						</td>
						<td colspan=3>&nbsp;</td>
					      </tr>
					    </table>
					  </td>
					</tr>
					<tr>
					  <td align=center valign=top class=func-menu><b>6. ESITO DELLA PROVA</b></td>					     </tr>
					<tr>	   
					  <td>				    
					     <table border=0 width="100%">
					      <tr>
					       <td valign=top colspan=3 align=left>L'impianto ha rispettato le periodicità' previste per controllo e manutentzione<br>
                                                        <formwidget id="esito_periodicita">
                                                          <formerror  id="esito_periodicita"><br>
                                                            <span class="errori">@formerror.esito_periodicita;noquote@</span>
                                                          </formerror>
                                               </td>					       
					       <td valign=top align=left class=form_title>
					                <b>Esito Positivo: Rientra</b><small> nei termini di legge<br></small><b>Esito Negativo: Non rientra</b><small> nei termini di legge</small>
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
					       <tr>
					          <td valign=top colspan=5 align=left>E' presente la documentazione di cui al D.Lgs.152/2006 (ove richiesto)?
                                                        <formwidget id="docu_152">
                                                          <formerror  id="docu_152"><br>
                                                            <span class="errori">@formerror.docu_152;noquote@</span>
                                                          </formerror>
                                               </td>
					       </tr>
					       <tr>
					        <td colspan=3 valign=bottom align=left class=form_title><b>Monossido di carbonio</b><small> nei fumi secchi e senz'aria (deve essere inferiore o uguale a 1000 ppm = 0,1%)</small>
                                                </td>
						  <td colspan=2 valign=top align=left>Prescrizioni</td>
					        </tr>
						<tr>
						<td colspan=3 align=left>Valore rilevato
                                                </td>
						<td valign=top colspan=2 rowspan=5><formwidget id="note_verificatore">
                                                          <formerror  id="note_verificatore"><br>
                                                            <span class="errori">@formerror.note_verificatore;noquote@</span>
                                                          </formerror>
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
						<td colspan=3 valign=bottom align=left class=form_title><b>Indice di fumosit&agrave;</b><small> = N&#176; di Bacharach (per gasolio minore o uguale a 2; per olio combustibile minore o uguale a 6)</small> </td>
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
						  <td valign=top colspan=5 align=left class=form_title><b>Rendimento di Combustione</b></td>
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
						  <td valign=top colspan=5 align=left class=form_title><b>Impianto Critico</b> <small>vedi motivazione al punto 9</small></td>
						</tr> 
						<tr>
						  <td colspan=5 valign=top align=left>
							<formwidget id="new1_flag_peri_8p">
							  <formerror  id="new1_flag_peri_8p"><br>
							    <span class="errori">@formerror.new1_flag_peri_8p;noquote@</span>
							  </formerror>
						  </td>
						</tr>
						<tr>
						  <td colspan=5 align=left>CHECK-LIST:<br>
						      Elenco dei possibili interventi dei quali va valutata la convenienza economica, che qualora applicabili potrebbero comportare un miglioramento della prestazione energetica:
						  </td>
						</tr>
					        <tr>
						     <td colspan=5 valign=top align=left>Adozione di valvole Termostatiche
							<formwidget id="check_valvole">
							  <formerror  id="check_valvole"><br>
							    <span class="errori">@formerror.check_valvole;noquote@</span>
							  </formerror>
						      </td>
						</tr>
						<tr>
                                                      <td colspan=5 valign=top align=left>L'isolamente della rete di distribuzione nei locali non riscaldati
							<formwidget id="check_isolamento">
							  <formerror  id="check_isolamento"><br>
							    <span class="errori">@formerror.check_isolamento;noquote@</span>
							  </formerror>
						      </td>
						</tr>
						<tr>
                                                    <td colspan=5 valign=top align=left>Intrudozione di un sistema di trattamento dell'acqua  sanitaria  e per riscaldamento
							<formwidget id="check_trattamento">
							  <formerror  id="check_trattamento"><br>
							    <span class="errori">@formerror.check_trattamento;noquote@</span>
							  </formerror>
						      </td>
						</tr>
						<tr>
                                                     <td valign=top align=left>Sostituzione di un sistema di regolazione on/off con un sistema programmabile a piu' livelli
							<formwidget id="check_regolazione">
							  <formerror  id="check_regolazione"><br>
							    <span class="errori">@formerror.check_regolazione;noquote@</span>
							  </formerror>
						      </td>
						</tr>
						<tr>
                                                   <td valign=top align=left>Stima del dimensionamento
							<formwidget id="dimensionamento_gen">
							  <formerror  id="dimensionamento_gen"><br>
							    <span class="errori">@formerror.dimensionamento_gen;noquote@</span>
							  </formerror>
						      </td>
						   </tr>
						   </table>
					  </td>
					</tr>						
					<tr>
					  <td><table border=0 width="100%">
					      <tr>
						<td colspan=2 align=center valign=top class=func-menu><b>OSSERVAZIONI DEL VERIFICATORE</b></td>
					      </tr>
					      <tr>
						<td valign=top align=right class=form_title>Note non conformit&agrave;</td>
						<td valign=top ><formwidget id="note_conf">
						    <formerror  id="note_conf"><br>
						      <span class="errori">@formerror.note_conf;noquote@</span>
						    </formerror>
						</td>
					      </tr>
					    </table>
					  </td>
					</tr>
					<tr>
					  <td><table border=0 width="100%">
					      <tr>
						<td colspan=2 align=center valign=top class=func-menu><b>DICHIARAZIONI DEL RESPONSABILE IMPIANTO</b></td>
					      </tr>
					      <tr>
						<td valign=top align=right class=form_title>Note responsabile</td>
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
					  <td>Rilasciata dichiarazione:</td>
					       <td valign=top align=left class=form_title>Mod. Verde
                                                <formwidget id="mod_verde">
                                                    <formerror  id="mod_verde"><br>
                                                      <span class="errori">@formerror.mod_verde;noquote@</span>
                                                    </formerror>
                                                </td>
						<td valign=top align=left class=form_title>Mod. Rosa
                                                <formwidget id="mod_rosa">
                                                    <formerror  id="mod_rosa"><br>
                                                      <span class="errori">@formerror.mod_rosa;noquote@</span>
                                                    </formerror>
                                                </td>	
					  </tr>
					  <tr>
                                          <td></td>
                                               <td colspan=4 valign=top align=left class=form_title>Autocertificazione adeguamento D.Lgs 152/2006
                                                <formwidget id="auto_adeg_152">
                                                    <formerror  id="auto_adeg_152"><br>
                                                      <span class="errori">@formerror.auto_adeg_152;noquote@</span>
                                                    </formerror>
                                                </td>
                                          </tr>      
					  </table>
					  </td>
					  </tr>

					<tr>
					  <td align=right><table width="100%">
					      <tr>
						 <td valign=top align=right class=form_title>Data utile interv.</td>
                                           <td valign=top class=form_title>Anomalia</td>
                                           <td valign=top class=form_title>Princ.</td>
					      </tr> 
					      <formwidget id="prog_anom_max">
						<multiple name=multiple_form>
						  <tr>
						    <formwidget id="prog_anom.@multiple_form.conta;noquote@">
						      <td valign=top align=right><formwidget id="data_ut_int.@multiple_form.conta;noquote@">
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
						    <td valign=top align=right class=form_title>Tipo sanzione 1</td>
						    <td valign=top colspan=3><formwidget id="cod_sanzione_1">@mess_err_sanz1;noquote@
							<formerror  id="cod_sanzione_1"><br>
							  <span class="errori">@formerror.cod_sanzione_1;noquote@</span>
							</formerror>
						    </td>
						  </tr>
						  <tr>
						    <td valign=top align=right class=form_title>Tipo sanzione 2</td>
						    <td valign=top><formwidget id="cod_sanzione_2">@mess_err_sanz2;noquote@
							<formerror  id="cod_sanzione_2"><br>
							  <span class="errori">@formerror.cod_sanzione_2;noquote@</span>
							</formerror>
						    </td>
						    <td valign=top align=right class=form_title>Importo totale</td>
						    <td valign=top><formwidget id="costo">
							<formerror  id="costo"><br>
							  <span class="errori">@formerror.costo;noquote@</span>
							</formerror>
						    </td>
						  </tr>
						  <tr>
						    <td valign=top align=right class=form_title>Data scad. pagamento</td>
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
					      <td><table border=0 width="100%">
						  <tr>
						    <td valign=top align=right class=form_title>Tipologia costo</td>
						    <td valign=top colspan=3><formwidget id="tipologia_costo">
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
						    <td valign=top align=right class=form_title>Data scad. pagamento</td>
						    <td valign=top ><formwidget id="data_scad_pagamento">
							<formerror  id="data_scad_pagamento"><br>
							  <span class="errori">@formerror.data_scad_pagamento;noquote@</span>
							</formerror>
						    </td>
						    <td valign=top align=right class=form_title>Numero fattura</td>
						    <td valign=top ><formwidget id="numfatt">
							<formerror  id="numfatt"><br>
							  <span class="errori">@formerror.numfatt;noquote@</span>
							</formerror>
						    </td>
						    <td valign=top align=right class=form_title>Data fattura</td>
						    <td valign=top ><formwidget id="data_fatt">
							<formerror  id="data_fatt"><br>
							  <span class="errori">@formerror.data_fatt;noquote@</span>
							</formerror>
						    </td>
						  </tr>
						  <tr>
						    <td valign=top align=right class=form_title>Presenza firma Tecnico</td>
						    <td valign=top ><formwidget id="fl_firma_tecnico">
							<formerror id="fl_firma_tecnico"><br>
							  <span class="errori">@formerror.fl_firma_tecnico;noquote@</span>
							</formerror>
						    </td>
						    <td valign=top align=right class=form_title>Presenza firma responsabile</td>
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
						    </td>
						  </tr>
						  <tr><td colspan="4">&nbsp;</td></tr>
						</table>
					      </td>
					    </tr>
					  </else>
					</if>

					<if @funzione@ ne "V">
					  <tr><td  align=center><formwidget id="submitbut"></td></tr>
					</if>

					<!-- Fine della form colorata -->
					<%=[iter_form_fine]%>

    </formtemplate>
    <p>
  </center>
