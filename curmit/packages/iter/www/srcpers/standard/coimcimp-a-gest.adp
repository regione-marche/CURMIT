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
<tr><td><table width ="100%" border=0>
        <tr>
            <td colspan=4 align=center valign=top class=func-menu><b>1. DATI GENERALI</b></td>
        </tr>
        <tr>
            <td valign=top  align=left class=form_title>Data controllo <font color=red>*</font></td>
            <td valign=top><formwidget id="data_controllo">
                <formerror  id="data_controllo"><br>
                <span class="errori">@formerror.data_controllo;noquote@</span>
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
            <td valign=top align=left class=form_title>N. protocollo</td>
            <td valign=top><formwidget id="n_prot">
                <formerror  id="n_prot"><br>
                <span class="errori">@formerror.n_prot;noquote@</span>
                </formerror>
            </td>
            <td valign=top align=left class=form_title>Data protocollo</td>
            <td valign=top><formwidget id="data_prot">
                <formerror  id="data_prot"><br>
                <span class="errori">@formerror.data_prot;noquote@</span>
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
            <td valign=top><formwidget id="data_verb">
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

        </tr>
        <if @funzione@ eq "V" or @funzione@ eq "D">
            <tr>
                <td colspan=2>Il responsabile dell'impianto &egrave;
                              @aimp_flag_resp_desc;noquote@
                </td>
            </tr>
        </if>
        <tr>
            <td valign=top align=left class=form_title >Responsabile</td>
            <td valign=top colspan=3><formwidget id="cogn_responsabile">    
                <formwidget id="nome_responsabile">@cerca_resp;noquote@
                <formerror  id="cogn_responsabile"><br>
                <span class="errori">@formerror.cogn_responsabile;noquote@</span>
                </formerror>
                <br/>@link_ins_resp;noquote@ 
            </td>
        </tr>
        <tr><td valign=top align=left class=form_title>Eventuale delegato</td>
            <td valign=top colspan=3><formwidget id="nominativo_pres">
                <formerror  id="nominativo_pres"><br>
                <span class="errori">@formerror.nominativo_pres;noquote@</span>
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
        <td valign=top><formwidget id="comsumi_ultima_stag">
            <formerror  id="comsumi_ultima_stag"><br>
            <span class="errori">@formerror.comsumi_ultima_stag;noquote@</span>
            </formerror>
        </td>
    </tr>

        </table>
    <td>
</tr>
</tr><td>&nbsp;</td></tr>
<tr>
    <td><table border=0 width="100%">
        <tr>
            <td colspan=4 align=center valign=top class=func-menu><b>2. DESTINAZIONE</b></td>
        </tr>
        <tr>
            <td class=form_title>Destinazione prevalente dell'immobile</td>
            <td class=form_title>Impianto a servizio di:</td>
            <td class=form_title>Destinazione d'uso dell'impianto</td>
            <td class=form_title>Combustibile</td>
        </tr>
        <tr>
            <td valign=top class=form_title bgcolor=white>@aimp_dest_uso;noquote@ @aimp_dest_uso_error;noquote@</td>
            <td valign=top class=form_title bgcolor=white>@aimp_tipologia;noquote@ @aimp_tipologia_error;noquote@</td>
            <td valign=top class=form_title bgcolor=white>@gend_destinazione_uso;noquote@ @gend_destinazione_uso_error;noquote@</td>
            <td valign=top><formwidget id="cod_combustibile">
                <formerror  id="cod_combustibile"><br>
                <span class="errori">@formerror.cod_combustibile;noquote@</span>
                </formerror>
            </td>
        </tr>
        </table>
    </td>
</tr>
<tr>
    <td><table border=0 width="100%">
        <tr>
            <td colspan=4 align=center valign=top class=func-menu><b>3. GENERATORI</b></td>
        </tr>
        <tr>
            <td valign=top width="25%" align=left class=form_title>Generatore</td>
            <td valign=top width="25%" align=right class=form_title bgcolor=white>@gend_gen_prog_est;noquote@</td>
            <td valign=top width="50%" align=left class=form_title colspan=2>i) Dati nominali</td>
        </tr>
        <tr>
            <td valign=top align=left class=form_title>a) Fluido termovettore</td>
            <td valign=top  align=right class=form_title bgcolor=white>@gend_fluido_termovettore;noquote@ @gend_fluido_termovettore_error;noquote@</td>
            <td valign=top align=left class=form_title>Potenza termica al focolare</td>
            <td valign=top align=right>(kW)
                <formwidget id="pot_focolare_nom">
                <formerror  id="pot_focolare_nom"><br>
                <span class="errori">@formerror.pot_focolare_nom;noquote@</span>
                </formerror>
            </td>
        </tr>
        <tr>
            <td valign=top align=left class=form_title>b) Tipo caldaia</td>
            <td valign=top  align=right class=form_title bgcolor=white>@gend_tipo_focolare;noquote@ @gend_tipo_focolare_error;noquote@</td>
            <td valign=top align=left class=form_title>Potenza termica utile</td>
            <td valign=top align=right>(kW)
                <formwidget id="pot_utile_nom">
                <formerror  id="pot_utile_nom"><br>
                <span class="errori">@formerror.pot_utile_nom;noquote@</span>
                </formerror>
            </td>
        </tr> 
        <tr>
            <td valign=top align=left class=form_title>c) Data installazione impianto</td>
            <td valign=top  align=right class=form_title bgcolor=white>@gend_data_installazione;noquote@</td>
            <td valign=top align=left class=form_title coplspan=2> Dati misurati</td>
        </tr>

        <tr>
            <td valign=top align=left class=form_title>d) Et&agrave; generatore</td>
            <td valign=top align=right class=form_title bgcolor=white>@gend_eta_gend;noquote@</td>
            <td valign=top align=left class=form_title>Portata di combustibile</td>
            <td valign=top align=right>(m<sup>3</sup>/h)/(kg/h)
                <formwidget id="mis_port_combust">
                <formerror  id="mis_port_combust"><br>
                <span class="errori">@formerror.mis_port_combust;noquote@</span>
                </formerror>
            </td>
  
        <tr>
            <td valign=top align=left class=form_title>e) Costruttore generatore</td>
            <td valign=top align=right class=form_title bgcolor=white>@gend_descr_cost;noquote@ @gend_descr_cost_error;noquote@</td>  
            <td valign=top align=left class=form_title>Potenza termica al focolare</td>
            <td valign=top align=right>(kW)
                <formwidget id="mis_pot_focolare">
                <formerror  id="mis_pot_focolare"><br>
                <span class="errori">@formerror.mis_pot_focolare;noquote@</span>
                </formerror>
            </td>
        </tr> 
        <tr>
            <td valign=top align=left class=form_title>f)Modello e matricol generatore</td>
            <td valign=top align=right class=form_title bgcolor=white>@gend_modello;noquote@ @gend_matricola;noquote@</td>  
            <td colspan=2>&nbsp;</td>
        </tr> 
        <tr>
            <td valign=top align=left class=form_title>g)Locale d'installazione</td>
            <td valign=top align=right class=form_title bgcolor=white>@gend_tipologia_locale;noquote@  @gend_tipologia_locale_error;noquote@</td>  
            <td colspan=2>&nbsp;</td>
        </tr> 
        <tr>
            <td valign=top align=left class=form_title>h)Classificazione DPR 660/96</td>
            <td valign=top align=right class=form_title bgcolor=white>@gend_dpr_660_96;noquote@</td>  
            <td colspan=2>&nbsp;</td>
        </tr>
        </table>
    </td>
</tr>

<tr>
    <td><table border=0 width="100%">
        <tr>
            <td colspan=4 align=center valign=top class=func-menu><b>4. STATO DELL'IMPIANTO</b></td>
        </tr>
	<tr>
            <td valign=top colspan=2 align=left class=form_title><b>a) Esame visivo condotti di evacuazione e foro di prelievo</b></td>
	    <td valign=top colspan=2 align=left class=form_title><b>b) Controllo evacuazione prodotti della combustione</b></td>
        </tr>

        <tr>         
	    <td valign=top width="25%" align=left class=form_title>Pendenza corretta dei canali da fumo</td>
            <td valign=top width="25%" align=right >
                <formwidget id="pendenza">
                <formerror  id="pendenza"><br>
                <span class="errori">@formerror.pendenza;noquote@</span>
                </formerror>
            </td>            
	    <td valign=top width="25%" align=left class=form_title>L'apparecchio scarica:</td>
            <td valign=top width="25%" align=right class=form_title bgcolor=white>@gend_tipologia_emissione;noquote@ @gend_tipologia_emissione_error;noquote@</td>

        </tr>
        <tr>
	    <td valign=top align=left class=form_title>Buono stato di conservazione condotti di evacuazione <font color=red>*</font></td>
            <td valign=top align=right><formwidget id="effic_evac">
                <formerror  id="effic_evac"><br>
                <span class="errori">@formerror.effic_evac;noquote@</span>
                </formerror>
            </td>
             <td valign=top align=left class=form_title>L'apparecchio scarica direttamente all'esterno</td>
            <td valign=top align=right><formwidget id="scarico_dir_esterno">
                <formerror  id="scarico_dir_esterno"><br>
                <span class="errori">@formerror.scarico_dir_esterno;noquote@</span>
                </formerror>
        </td>
            	    <td valign=top align=left class=form_title>&nbsp;</td>
        </tr>
        <tr>
	    <td valign=top align=left class=form_title>Foro per prelievo presente e accessibile</td>
            <td valign=top align=right><formwidget id="new1_foro_presente">
                <formerror  id="new1_foro_presente"><br>
                <span class="errori">@formerror.new1_foro_presente;noquote@</span>
                </formerror>
            </td>
	    <td valign=top align=left class=form_title><b>d) Verifica visiva dello stato delle coibentazioni</b> <font color=red>*</font></td>
            <td valign=top align=right>
                <formwidget id="stato_coiben">
                <formerror  id="stato_coiben"><br>
                <span class="errori">@formerror.stato_coiben;noquote@</span>
                </formerror>
            </td>
        </tr>
        <tr>
	    <td valign=top align=left class=form_title>Foro in posizione corretta</td>
            <td valign=top align=right><formwidget id="new1_foro_corretto">
                <formerror  id="new1_foro_corretto"><br>
                <span class="errori">@formerror.new1_foro_corretto;noquote@</span>
                </formerror>
            </td>
	    
        </tr>	
        <tr>
	    <td valign=top align=left class=form_title>Chiusura foro corretta</td>
            <td valign=top align=right><formwidget id="new1_foro_accessibile">
                <formerror  id="new1_foro_accessibile"><br>
                <span class="errori">@formerror.new1_foro_accessibile;noquote@</span>
                </formerror>
            </td>
	    <td valign=top align=left class=form_title><b>e) Dispositivi</b></td>
        </tr>	
        <tr>
	    <td valign=top align=left class=form_title colspan=2><b>c) Esame visivo locale di installazione</b></td>
	    <td valign=top align=left class=form_title>Dispositivi di regolazione e controllo presenti</td>
            <td valign=top align=right><formwidget id="disp_reg_cont_pre">
                <formerror  id="disp_reg_cont_pre"><br>
                <span class="errori">@formerror.disp_reg_cont_pre;noquote@</span>
                </formerror>
            </td>
        </tr>	
        <tr>
	    <td valign=top align=left class=form_title>Idoneit&agrave; locale</td>
            <td valign=top align=right><formwidget id="new1_conf_locale">
                <formerror  id="new1_conf_locale"><br>
                <span class="errori">@formerror.new1_conf_locale;noquote@</span>
                </formerror>
            </td>
	    <td valign=top align=left class=form_title>Dispositivi di regolazione e controllo funzionanti</td>
            <td valign=top align=right><formwidget id="disp_reg_cont_funz">
                <formerror  id="disp_reg_cont_funz"><br>
                <span class="errori">@formerror.disp_reg_cont_funz;noquote@</span>
                </formerror>
            </td>
        </tr>	
        <tr>
	    <td valign=top align=left class=form_title>Adeguate dimensioni e posizione delle aperture di ventilazione <font color=red>*</font></td>
            <td valign=top align=right><formwidget id="verifica_areaz">
                <formerror  id="verifica_areaz"><br>
                <span class="errori">@formerror.verifica_areaz;noquote@</span>
                </formerror>
            </td>
	    <td valign=top align=left class=form_title>Dispositivi di regolazione climatica presente <font color=red>*</font></td>
            <td valign=top align=right><formwidget id="new1_disp_regolaz">
                <formerror  id="new1_disp_regolaz"><br>
                <span class="errori">@formerror.new1_disp_regolaz;noquote@</span>
                </formerror>
            </td>
        </tr>	
        <tr>
	    <td valign=top align=left class=form_title>Aperture di ventilazione libere da ostruzioni</td>
            <td valign=top align=right><formwidget id="ventilaz_lib_ostruz">
                <formerror  id="ventilaz_lib_ostruz"><br>
                <span class="errori">@formerror.ventilaz_lib_ostruz;noquote@</span>
                </formerror>
            </td>
	    <td valign=top align=left class=form_title>Dispositivi di regolazione climatica funzionante</td>
            <td valign=top align=right><formwidget id="disp_reg_clim_funz">
                <formerror  id="disp_reg_clim_funz"><br>
                <span class="errori">@formerror.disp_reg_clim_funz;noquote@</span>
                </formerror>
            </td>
        </tr>
        </table>
    </td>
</tr>
<tr>
    <td><table border=0 width="100%">
        <tr>
            <td colspan=4 align=center valign=top class=func-menu><b>5. STATO DELLA DOCUMENTAZIONE</b></td>
        </tr>
            <td valign=top width="45%" align=left class=form_title>a) Libretto impianto o centrale presente</td>
            <td valign=top width="5%"align=right width="10%">
                <formwidget id="presenza_libretto">
                <formerror  id="presenza_libretto"><br>
                <span class="errori">@formerror.presenza_libretto;noquote@</span>
                </formerror>
            </td>
            <td valign=top align=left class=form_title>b) Compilazione libretto impianto o centrale completa</td>
            <td valign=top align=right><formwidget id="libretto_corretto">
                <formerror  id="libretto_corretto"><br>
                <span class="errori">@formerror.libretto_corretto;noquote@</span>
                </formerror>
            </td>
        <tr>
        </tr> 
            <td valign=top width="35%" align=left class=form_title>c) Dichiarazione conformit&agrave;</td>
            <td valign=top width="15%" align=right >
                <formwidget id="dich_conformita">
                <formerror  id="dich_conformita"><br>
                <span class="errori">@formerror.dich_conformita;noquote@</span>
                </formerror>
            </td>
            <td valign=top width="35%" align=left class=form_title>d) Libretto/i di uso e manutenzione presente/i</td>
            <td valign=top width="15%" align=right >
                <formwidget id="libretto_manutenz">
                <formerror  id="libretto_manutenz"><br>
                <span class="errori">@formerror.libretto_manutenz;noquote@</span>
                </formerror>
            </td>
        </tr>
        </table>
    </td>
</tr>
<tr>
    <td><table border=0 width="100%">
        <tr>
            <td colspan=4 align=center valign=top class=func-menu><b>6. MANUTENZIONE ED ANALISI</b></td>
        </tr>
        <tr>
            <td valign=top width="25%" align=left class=form_title>Data ultima manutenzione</td>
            <td valign=top width="25%" align=right>
                <formwidget id="new1_data_ultima_manu">
                <formerror  id="new1_data_ultima_manu"><br>
                <span class="errori">@formerror.new1_data_ultima_manu;noquote@</span>
                </formerror>
            </td>
            <td valign=top width="25%" align=left class=form_title>Data ultima analisi combustibile</td>
            <td valign=top width="25%" align=right>
                <formwidget id="new1_data_ultima_anal">
                <formerror  id="new1_data_ultima_anal"><br>
                <span class="errori">@formerror.new1_data_ultima_anal;noquote@</span>
                </formerror>
            </td>
        </tr>
        <tr>
            <td  align=left rowspan=2 class=form_title>Rapporto di controllo tecnico (allegato G)</td>
            <td valign=top  align=right>Presente
                <formwidget id="new1_dimp_pres">
                <formerror  id="new1_dimp_pres"><br>
                <span class="errori">@formerror.new1_dimp_pres;noquote@</span>
                </formerror>
            </td>
            <td valign=top align=left class=form_title colspan=2 rowspan=2>
                Note &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
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
            <td valign=top align=right>Con prescrizioni
                <formwidget id="new1_dimp_prescriz">
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
            <td colspan=5 align=center valign=top class=func-menu><b>7. MISURA DEL RENDIMENTO DI COMBUSTIONE (UNI 10389)</b></td>
        </tr>
        <tr>
            <td colspan=5 >&nbsp;</td>
        </tr>

        <tr>
            <td valign=center align=right  class=form_title>Analizzatore</td>
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
            <td valign=top align=center width="30%" class=form_title>Misure</td>
            <td valign=top align=center width="17.5%" class=form_title>Prova 1</td>
            <td valign=top align=center width="17.5%" class=form_title>Prova 2</td>
            <td valign=top align=center width="17.5%" class=form_title>Prova 3</td>
            <td valign=top align=center width="17.5%" class=form_title>Media</td>
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
         </table>
    </td>
</tr>
<tr>
    <td><table border=0 width="100%"><tr>
    <td valign=top width="50%"><table border=0 width="100%">
        <tr>
            <td colspan=2 align=center valign=top class=func-menu><b>8. RISULTATI DELLA VERIFICA</b></td>
        </tr>
        <tr>
            <td valign=top colspan=2 align=left class=form_title><b>a) Manutenzione</b></td>
        </tr>
        <tr>
            <td valign=top width="50%" align=left>Anno in corso<br>
                <formwidget id="manutenzione_8a">
                <formerror  id="manutenzione_8a"><br>
                <span class="errori">@formerror.manutenzione_8a;noquote@</span>
                </formerror>
            </td>
            <td valign=top width="50%"align=left>Anni precedenti<br>
                <formwidget id="new1_manu_prec_8a">
                <formerror  id="new1_manu_prec_8a"><br>
                <span class="errori">@formerror.new1_manu_prec_8a;noquote@</span>
                </formerror>
            </td>
        </tr>
        <tr>
            <td valign=top colspan=2 align=left class=form_title><b>b) Monossido di carbonio</b><small> nei fumi secchi e senz'aria (deve essere inferiore o uguale a 1000 ppm = 0,1%)</small></td>
        </tr>
        <tr>
            <td valign=top align=left>Valore rilevato<br>
                <formwidget id="new1_co_rilevato">(ppm)
                <formerror  id="new1_co_rilevato"><br>
                <span class="errori">@formerror.new1_co_rilevato;noquote@</span>
                </formerror>
            </td>
            <td valign=bottom align=left>
                <formwidget id="co_fumi_secchi_8b">
                <formerror  id="co_fumi_secchi_8b"><br>
                <span class="errori">@formerror.co_fumi_secchi_8b;noquote@</span>
                </formerror>
            </td>
        </tr> 
        <tr>
            <td valign=top colspan=2 align=left class=form_title><b>c) Indice di fumosit&agrave;</b><small> = N&#176; di Bacharach (per gasolio minore o uguale a 2; per olio combustibile minore o uguale a 6)</small> </td>
        </tr>
        <tr>
            <td valign=top align=left>Valore rilevato<br>
                <formwidget id="indic_fumosita_md">
                <formerror  id="indic_fumosita_md"><br>
                <span class="errori">@formerror.indic_fumosita_md;noquote@</span>
                </formerror>
            </td>
            <td valign=bottom align=left>
                <formwidget id="indic_fumosita_8c">
                <formerror  id="indic_fumosita_8c"><br>
                <span class="errori">@formerror.indic_fumosita_8c;noquote@</span>
                </formerror>
            </td>
        </tr> 
        <tr>
            <td valign=top colspan=2 align=left class=form_title><b>d) Rendimento di Combustione</b></td>
        </tr>
        <tr>
            <td valign=top align=left class=form_title><small>il valore deve essere superiore o uguale a</small></td> 
            <td valign=bottom align=left>
                <formwidget id="rend_comb_min"><br><if @funzione@ eq "I"><small>* @rendimento_min_notice;noquote@</small></if>
                <formerror  id="rend_comb_min"><br>
                <span class="errori">@formerror.rend_comb_min;noquote@</span>
                </formerror>
            </td>
        </tr>
        <tr>
            <td valign=top align=left>Valore rilevato <small>(accettabile entro il -2% del rend. min.)</small><br>
                <formwidget id="rend_comb_conv">%
                <formerror  id="rend_comb_conv"><br>
                <span class="errori">@formerror.rend_comb_conv;noquote@</span>
                </formerror>
            </td>
            <td valign=bottom align=left>
                <formwidget id="rend_comb_8d">
                <formerror  id="rend_comb_8d"><br>
                <span class="errori">@formerror.rend_comb_8d;noquote@</span>
                </formerror>
            </td>
               
        </tr> 
        <tr>
            <td valign=top colspan=2 align=left class=form_title><b>P Impianto pericoloso</b> <small>vedi motivazione al punto 9</small></td>
        </tr> 
        <tr>
            <td valign=top align=left>
                <formwidget id="new1_flag_peri_8p">
                <formerror  id="new1_flag_peri_8p"><br>
                <span class="errori">@formerror.new1_flag_peri_8p;noquote@</span>
                </formerror>
            </td>
        </tr>
        </table>
    </td>
    <td valign=top width="50%"> 
        <table border=0 width="100%">
        <tr>
            <td colspan=2 align=center valign=top class=func-menu><b>9. ESITO DELLA PROVA</b></td>
        </tr>
        <tr>
            <td valign=top align=left class=form_title><b>Esito Positivo: Rientra</b><small> nei termini di legge<br></small><b>Esito Negativo: Non rientra</b><small> nei termini di legge</small></td>
        </tr>
        <tr>
            <if @vis_desc_ver@ eq f>
                <td valign=top><formwidget id="esito_verifica">
                    <formerror  id="esito_verifica"><br>
                    <span class="errori">@formerror.esito_verifica;noquote@</span>
                    </formerror>
                </td>
            </if>
            <else>
                <td valign=top><formwidget id="text_esito_verifica">
                    <formerror  id="text_esito_verifica"><br>
                    <span class="errori">@formerror.text_esito_verifica;noquote@</span>
                    </formerror>
                </td>
            </else>
        </tr>
        <tr>
            <td valign=top align=left class=form_title>Prescrizioni</td>
        </tr> 
        <tr>
            <td valign=top><formwidget id="note_verificatore">
                <formerror  id="note_verificatore"><br>
                <span class="errori">@formerror.note_verificatore;noquote@</span>
                </formerror>
            </td>
        </tr>
        </table>
    </td>
    </tr></table>
    </td>
</tr>
<tr>
    <td><table border=0 width="100%">
        <tr>
            <td colspan=2 align=center valign=top class=func-menu><b>10. OSSERVAZIONI DEL VERIFICATORE</b></td>
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
            <td colspan=2 align=center valign=top class=func-menu><b>11. DICHIARAZIONI DEL RESPONSABILE IMPIANTO</b></td>
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
    <td align=right><table width="100%">
    <tr>
        <td valign=top align=right class=form_title>Data utile interv.</td>
        <td valign=top class=form_title>Anomalia</td>
        <td valign=top class=form_title>Anom.Princ.</td>
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
            <td valign=top colspan=4><formwidget id="tipologia_costo">
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
            <td valign=top colspan=6><formwidget id="data_scad_pagamento">
                <formerror  id="data_scad_pagamento"><br>
                <span class="errori">@formerror.data_scad_pagamento;noquote@</span>
                </formerror>
            </td>
        </tr>
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



