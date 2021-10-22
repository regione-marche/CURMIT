<!--
    USER  DATA       MODIFICHE
    ===== ========== =======================================================================
    sim01 08/05/2019 Tolto possibilità di fare modelli G e F

    nic01 15/05/2014 Comune di Rimini: se è attivo il parametro flag_gest_coimmode, deve
    nic01            comparire un menù a tendina con l'elenco dei modelli relativi al
    nic01            costruttore selezionato (tale menù a tendina deve essere rigenerato
    nic01            quando si cambia la scelta del costruttore).
-->

<master   src="../master">
<property name="title">@page_title;noquote@</property>
<property name="context_bar">@context_bar;noquote@</property>
<property name="riga_vuota">f</property>
<property name="focus_field">@focus_field;noquote@</property><!-- nic01 -->

<if @flag_no_link@ ne T>
    @link_tab;noquote@
</if>

@dett_tab;noquote@
<table width="100%" cellspacing=0 class=func-menu>
<tr>
   <if @funzione@ ne I and @menu@ eq 1>
       <td width="14.29%" nowrap class=@func_v;noquote@>
            <a href="coimdimp-gest?funzione=V&@link_gest;noquote@" class=@func_v;noquote@>Visualizza</a>
       </td>
       <if @flag_modifica@ eq T>
           <td width="14.29%" nowrap class=@func_m;noquote@>
               <a href="coimdimp-gest?funzione=M&@link_gest;noquote@" class=@func_m;noquote@>Modifica</a>
           </td>
       </if>
       <else>
            <td width="14.29%" nowrap class=func-menu>Modifica</td>
       </else>
       <td width="14.29%" nowrap class=@func_d;noquote@>
           <a href="coimdimp-gest?funzione=D&@link_gest;noquote@" class=@func_d;noquote@>Cancella</a>
       </td>
       <if @flag_modifica@ eq T>
           <td width="14.29%" nowrap class=func-menu>
               <a href="@pack_dir;noquote@/coimanom-list?@link_anom;noquote@" class=func-menu>Anomalie</a>
           </td>
       </if>
       <else>
           <td width="14.29%" nowrap class=func-menu>Anomalie</td>
       </else>
       <td width="14.29%" nowrap class=func-menu>
           <a href="@pack_dir;noquote@/coimdimp-f-layout?@link_gest;noquote@&flag_ins=N" class=func-menu target="Stampa mod F">Stampa</a>
       </td>
       <td width="14.29%" nowrap class=func-menu>
           <a href="@pack_dir;noquote@/coimdimp-f-layout?@link_gest;noquote@&flag_ins=S" class=func-menu target="Stampa mod F">Ins. Doc.</a>
       </td>
   </if>
   <else>
       <td width="14.29%" nowrap class=func-menu>Visualizza</td>
       <td width="14.29%" nowrap class=func-menu>Modifica</td>
       <td width="14.29%" nowrap class=func-menu>Cancella</td>
       <td width="14.29%" nowrap class=func-menu>Anomalie</td>
       <td width="14.29%" nowrap class=func-menu>Stampa</td>
       <td width="14.29%" nowrap class=func-menu>Ins. Doc.</td>
   </else>
</tr>
</table>

<center>
<formtemplate id="@form_name;noquote@">
<formwidget   id="funzione">
<formwidget   id="caller">
<formwidget   id="nome_funz">
<formwidget   id="nome_funz_caller">
<formwidget   id="extra_par">
<formwidget   id="last_cod_dimp">
<formwidget   id="cod_opma">
<formwidget   id="cod_impianto">
<formwidget   id="data_ins">
<formwidget   id="cod_manutentore">
<formwidget   id="cod_opmanu_new">
<formwidget   id="cod_dimp">
<formwidget   id="cod_responsabile">
<formwidget   id="url_list_aimp">
<formwidget   id="url_aimp">
<formwidget   id="url_gage">
<formwidget   id="flag_no_link">
<formwidget   id="cod_occupante">
<formwidget   id="cod_proprietario">
<formwidget   id="cod_ammi">
<formwidget   id="cod_terzi">
<formwidget   id="cod_int_contr">
<formwidget   id="list_anom_old">
<formwidget   id="flag_modifica">
<formwidget   id="gen_prog">
<formwidget   id="flag_ins_occu">
<formwidget   id="flag_ins_prop">
<formwidget   id="flag_modello_h">
<formwidget   id="nome_funz_new">
<formwidget   id="flag_tracciato">
<formwidget   id="dummy">
<if @vis_desc_contr@ eq t>
    <formwidget id="flag_status"
</if>
<formwidget   id="__refreshing_p"><!-- nic01 -->
<formwidget   id="changed_field"> <!-- nic01 -->


<!-- Inizio della form colorata -->
<%=[iter_form_iniz]%>
<tr><td><table width="100%"><tr>
<td align="left" width="50%">@esito;noquote@</td>
<if @funzione@ eq "V">
<td align="right" width="50%">Inserito da: @nome_utente_ins;noquote@</td></tr>
<tr><td align="left" width="50%">&nbsp;</td>
<td align="right" width="50%">In data: @data_ins_edit;noquote@</td></tr>
</if>
<else>
<td width="50%">&nbsp;</td></tr>
</else>
<if @flag_portafoglio@ eq T>
<tr>
<td align="center" colspan=2><b><font color=red>@report;noquote@</font></b></td></tr>
<!-- <tr><td align="center" colspan=2><b><font color=red><small>@report1;noquote@</small></font></b></td></tr -->
<tr>
<td align="center" colspan=2><b><font color=red>@msg_limite;noquote@</font></b></td></tr>
<tr>
<td align="right" colspan=2><b>Saldo attuale del portafoglio N. <formwidget id="cod_portafoglio">: &#8364;<formwidget id="saldo_manu"></b></td></tr>
<tr>
<td colspan=2>&nbsp;</td></tr>
</table></td></tr>
</if>
<else>
</table></td></tr>
</else>
<tr><td><table><tr>
    <td valign=top align=right class=form_title>Data controllo <font color=red>*</font></td>
    <td valign=top><formwidget id="data_controllo">
        <formerror  id="data_controllo"><br>
        <span class="errori">@formerror.data_controllo;noquote@</span>
        </formerror>
    </td>
    <td valign=top align=right class=form_title>Rapporto di controllo N&deg;</td>
    <td valign=top><formwidget id="num_autocert">
        <formerror  id="num_autocert"><br>
        <span class="errori">@formerror.num_autocert;noquote@</span>
        </formerror>
    </td>
    <td valign=top align=right class=form_title>Orario di arrivo presso l'impianto</td>
    <td  valign=top><formwidget id="ora_inizio">
        <formerror  id="ora_inizio"><br>
        <span class="errori">@formerror.ora_inizio;noquote@</span>
        </formerror>
    </td>

    <td valign=top align=right class=form_title>Orario di partenza dall'impianto</td>
    <td  valign=top><formwidget id="ora_fine">
        <formerror  id="ora_fine"><br>
        <span class="errori">@formerror.ora_fine;noquote@</span>
        </formerror>
    </td>

</tr>
<tr>
    <td valign=top align=right class=form_title>Num. protocollo</td>
    <td valign=top><formwidget id="n_prot">
        <formerror  id="n_prot"><br>
        <span class="errori">@formerror.n_prot;noquote@</span>
        </formerror>
    </td>
    <td valign=top align=right class=form_title>Data protocollo</td>
    <td valign=top><formwidget id="data_prot">
        <formerror  id="data_prot"><br>
        <span class="errori">@formerror.data_prot;noquote@</span>
        </formerror>
    </td>
    <td valign=top align=right class=form_title>Data di arrivo all'ente</td>
    <td valign=top><formwidget id="data_arrivo_ente">
        <formerror  id="data_arrivo_ente"><br>
        <span class="errori">@formerror.data_arrivo_ente;noquote@</span>
        </formerror>
    </td>

    <if @flag_cind@ eq "S">
       <td valign=top align=right class=form_title>Campagna</td>
       <td valign=top><formwidget id="cod_cind">
         <formerror  id="cod_cind"><br>
         <span class="errori">@formerror.cod_cind;noquote@</span>
         </formerror>
       </td>
    </if>




</tr></table></td>
</tr>
<tr><td><table width="100%">
    <tr><td colspan=3 valign=top align=left><b>A. IDENTIFICAZIONE DELL'IMPIANTO</b></td></tr>
    <tr>
        <td width="16%" valign=top align=left class=form_title>Ditta manut.<font color=red>*</font></td>
        <td width="17%" valign=top align=left class=form_title>Op. manutentore</td>
        <td width="67%" valign=top align=left class=form_title>&nbsp;</td>
    </tr>
    <tr>
    <td valign=top><formwidget id="cognome_manu"><br>
        <formwidget id="nome_manu">@cerca_manu;noquote@
        <formerror  id="cognome_manu"><br>
        <span class="errori">@formerror.cognome_manu;noquote@</span>
        </formerror>
    </td>
        <td valign=top><formwidget id="cognome_opma"><br>
            <formwidget id="nome_opma">@cerca_opma;noquote@
            <formerror  id="cognome_opma"><br>
            <span class="errori">@formerror.cognome_opma;noquote@</span>
            </formerror>
        </td>
    </tr></table></td>
</tr>

<tr><td><fieldset><legend><b>Gestione Soggetti</b></legend>
<table width="100%">
<tr><td><table width="100%">
    <tr><td colspan=5 valign=top align=left>Responsabile
        <formwidget id="flag_responsabile"><br>
        <formerror  id="flag_responsabile"><br>
        <span class="errori">@formerror.flag_responsabile;noquote@</span>
        </formerror>
    </td></tr>
    <tr>
        <td valign=top align=left class=form_title>Proprietario</td>
        <td valign=top align=left class=form_title>Occupante</td>
        <td valign=top align=left class=form_title>Amministratore</td>
        <td valign=top align=left class=form_title>Intestatario contratto</td>
        <td valign=top align=left class=form_title>Terzo Resp.</td>
    </tr>
    <tr>
    <td valign=top><formwidget id="cognome_prop"><br>
        <formwidget id="nome_prop">@cerca_prop;noquote@
        <formerror  id="cognome_prop"><br>
        <span class="errori">@formerror.cognome_prop;noquote@</span>
        </formerror>
        <br>@link_ins_prop;noquote@
    </td>
    <td valign=top><formwidget id="cognome_occu"><br>
        <formwidget id="nome_occu">@cerca_occu;noquote@
        <formerror  id="cognome_occu"><br>
        <span class="errori">@formerror.cognome_occu;noquote@</span>
        </formerror>
        <br>@link_ins_occu;noquote@
    </td>
    <td valign=top><formwidget id="cognome_ammi"><br>
        <formwidget id="nome_ammi">@cerca_ammi;noquote@
        <formerror  id="cognome_ammi"><br>
        <span class="errori">@formerror.cognome_ammi;noquote@</span>
        </formerror>
    </td>
    <td valign=top><formwidget id="cognome_contr"><br>
        <formwidget id="nome_contr">@cerca_contr;noquote@
        <formerror  id="cognome_contr"><br>
        <span class="errori">@formerror.cognome_contr;noquote@</span>
        </formerror>
    </td>
    <td valign=top><formwidget id="cognome_terzi"><br>
        <formwidget id="nome_terzi">@cerca_terzi;noquote@
        <formerror  id="cognome_terzi"><br>
        <span class="errori">@formerror.cognome_terzi;noquote@</span>
        </formerror>
    </td>
    </tr></table></td>
</tr></table></fieldset></td></tr>
<tr><td><table width=100%>
    <tr>
        <td valign=top align=right class=form_title>Combustibile</td>
        <td valign=top><formwidget id="combustibile">
            <formerror  id="combustibile"><br>
            <span class="errori">@formerror.combustibile;noquote@</span>
            </formerror>
        </td>
        <td valign=top align=right class=form_title>Destinazione</td>
        <td valign=top><formwidget id="destinazione">
            <formerror  id="destinazione"><br>
            <span class="errori">@formerror.destinazione;noquote@</span>
            </formerror>
        </td>
    </tr>
    <tr>
        <td valign=top align=right class=form_title>Volumetria riscaldata (m<sup><small>3</small></sup>)</td>
        <td valign=top><formwidget id="volimetria_risc">
            <formerror  id="volimetria_risc"><br>
            <span class="errori">@formerror.volimetria_risc;noquote@</span>
            </formerror>
        </td>
        <td colspan=2>&nbsp;</td>
    </tr>
    <tr>
        <td valign=top align=right class=form_title>Stagione di riscaldamento attuale</td>
        <td valign=top><formwidget id="stagione_risc">
            <formerror  id="stagione_risc"><br>
            <span class="errori">@formerror.stagione_risc;noquote@</span>
            </formerror>
        </td>
        <td valign=top align=right class=form_title>Consumi (m<sup><small>3</small></sup>/kg)</td>
        <td valign=top><formwidget id="consumo_annuo">
            <formerror  id="consumo_annuo"><br>
            <span class="errori">@formerror.consumo_annuo;noquote@</span>
            </formerror>
        </td>
    </tr>
    <tr>
        <td valign=top align=right class=form_title>Stagione di riscaldamento precedente</td>
        <td valign=top><formwidget id="stagione_risc2">
            <formerror  id="stagione_risc2"><br>
            <span class="errori">@formerror.stagione_risc2;noquote@</span>
            </formerror>
        </td>
        <td valign=top align=right class=form_title>Consumi (m<sup><small>3</small></sup>/kg)</td>
        <td valign=top><formwidget id="consumo_annuo2">
            <formerror  id="consumo_annuo2"><br>
            <span class="errori">@formerror.consumo_annuo2;noquote@</span>
            </formerror>
        </td>
    </tr>
    <tr>
        <td valign=top align=left class=form_title colspan=4><b>B. DOCUMENTAZIONE TECNICA A CORREDO</b></td>
    </tr>
    <tr>
        <td valign=top align=right class=form_title>Libretto d'impianto</td>
        <td valign=top><formwidget id="lib_impianto">
            <formerror  id="lib_impianto"><br>
            <span class="errori">@formerror.lib_impianto;noquote@</span>
            </formerror>
        </td>
        <td valign=top colspan=2><formwidget id="lib_impianto_note"></td>
     </tr>

    <tr>
        <td valign=top align=right class=form_title>Rapporto di controllo ex UNI 10435 (imp a gas)</td>
        <td valign=top><formwidget id="rapp_contr">
            <formerror  id="rapp_contr"><br>
            <span class="errori">@formerror.rapp_contr;noquote@</span>
            </formerror>
        </td>
        <td valign=top colspan=2><formwidget id="rapp_contr_note"></td>
     </tr>

    <tr>
        <td valign=top align=right class=form_title>Certificazione ex UNI 8364</td>
        <td valign=top><formwidget id="certificaz">
            <formerror  id="certificaz"><br>
            <span class="errori">@formerror.certificaz;noquote@</span>
            </formerror>
        </td>
        <td valign=top colspan=2><formwidget id="certificaz_note"></td>
    </tr>

    <tr>
        <td valign=top align=right class=form_title>Dichiarazione di conformit&agrave;</td>
        <td valign=top><formwidget id="dich_conf">
            <formerror  id="dich_conf"><br>
            <span class="errori">@formerror.dich_conf;noquote@</span>
            </formerror>
        </td>
        <td valign=top colspan=2><formwidget id="dich_conf_note"></td>
    </tr>

    <tr>
        <td valign=top align=right class=form_title>Libretto/i d'uso/manutenzione caldaia/e</td>
        <td valign=top><formwidget id="lib_uso_man">
            <formerror  id="lib_uso_man"><br>
            <span class="errori">@formerror.lib_uso_man;noquote@</span>
            </formerror>
        </td>
        <td valign=top colspan=2><formwidget id="lib_uso_man_note"></td>
    </tr>

    <tr>
        <td valign=top align=right class=form_title>Libretto/i uso/manutenzione bruciatore/i</td>
        <td valign=top><formwidget id="libretto_bruc">
            <formerror  id="libretto_bruc"><br>
            <span class="errori">@formerror.libretto_bruc;noquote@</span>
            </formerror>
        </td>
        <td valign=top colspan=2><formwidget id="libretto_bruc_note"></td>
    </tr>

    <tr>
        <td valign=top align=right class=form_title>Schemi funzionali idraulici</td>
        <td valign=top><formwidget id="schemi_funz_idr">
            <formerror  id="schemi_funz_idr"><br>
            <span class="errori">@formerror.schemi_funz_idr;noquote@</span>
            </formerror>
        </td>
        <td valign=top colspan=2><formwidget id="schemi_funz_idr_note"></td>
    </tr>

    <tr>
        <td valign=top align=right class=form_title>Schemi funzionali elettrici</td>
        <td valign=top><formwidget id="schemi_funz_ele">
            <formerror  id="schemi_funz_ele"><br>
            <span class="errori">@formerror.schemi_funz_ele;noquote@</span>
            </formerror>
        </td>
        <td valign=top colspan=2><formwidget id="schemi_funz_ele_note"></td>
    </tr>

    <tr>
        <td valign=top align=right class=form_title>Pratica ISPESL</td>
        <td valign=top><formwidget id="ispesl">
            <formerror  id="ispesl"><br>
            <span class="errori">@formerror.ispesl;noquote@</span>
            </formerror>
        </td>
        <td valign=top colspan=2><formwidget id="ispesl_note"></td>
    </tr>

    <tr>
        <td valign=top align=right class=form_title>Certificato prevenzione incendi</td>
        <td valign=top><formwidget id="prev_incendi">
            <formerror  id="prev_incendi"><br>
            <span class="errori">@formerror.prev_incendi;noquote@</span>
            </formerror>
        </td>
        <td valign=top colspan=2><formwidget id="prev_incendi_note"></td>
    </tr>
    <tr>
        <td valign=top align=left class=form_title colspan=4><b>C. ESAME VISIVO E CONTROLLO DELL'IMPIANTO</b></td>
    </tr>
    <tr>
        <td valign=top align=left class=form_title colspan=2 ><b>1. Centrale termica</b></td>
        <td valign=top align=left class=form_title width="30%"><b>2. Esame visivo linee elettriche</b></td>
        <td valign=top width="20%"><formwidget id="esame_vis_l_elet">
            <formerror  id="esame_vis_l_elet"><br>
            <span class="errori">@formerror.esame_vis_l_elet;noquote@</span>
            </formerror>
        </td>       
    </tr>
    <tr>
        <td valign=top align=right class=form_title width="40%">Idoneit&agrave; del locale di installaz.</td>
        <td valign=top width="10%"><formwidget id="idoneita_locale">
            <formerror  id="idoneita_locale"><br>
            <span class="errori">@formerror.idoneita_locale;noquote@</span>
            </formerror>
        </td>
        <td valign=top align=left class=form_title><b>3. Controllo assenza fughe</b></td>
        <td valign=top><formwidget id="assenza_fughe">
            <formerror  id="assenza_fughe"><br>
            <span class="errori">@formerror.assenza_fughe;noquote@</span>
            </formerror>
        </td>
    </tr>
    <tr>
        <td valign=top align=right class=form_title>Adeguate dimensione aperture ventilazione</td>
        <td valign=top><formwidget id="ap_ventilaz">
            <formerror  id="ap_ventilaz"><br>
            <span class="errori">@formerror.ap_ventilaz;noquote@</span>
            </formerror>
        </td>
        <td valign=top align=left class=form_title><b>4. Esame visivo delle coibentazione</b></td>
        <td valign=top><formwidget id="coibentazione">
            <formerror  id="coibentazione"><br>
            <span class="errori">@formerror.coibentazione;noquote@</span>
            </formerror>
        </td>
    </tr>    
    <tr>
        <td valign=top align=right class=form_title>Aperture di ventilazione libere da ostruzioni</td>
        <td valign=top><formwidget id="ap_vent_ostruz">
            <formerror  id="ap_vent_ostruz"><br>
            <span class="errori">@formerror.ap_vent_ostruz;noquote@</span>
            </formerror>
        </td>
        <td valign=top align=left class=form_title><b>5. Esame visivo camino e canale da fumo</b></td>
        <td valign=top><formwidget id="conservazione">
            <formerror  id="conservazione"><br>
            <span class="errori">@formerror.conservazione;noquote@</span>
            </formerror>
        </td>
    </tr>
</tr></table></td>
<tr><td><table width=100%>
    <tr>
        <td valign=top align=left class=form_title colspan=4><b>D. DATI GENERALI DEI GENERATORI</b></td>
    </tr>
    <tr>
        <td valign=top align=left call=form_title><b>Generatore di calore</b></td>
    </tr>
    <tr>
        <td valign=top align=right class=form_title>Costruttore</td>
        <td valign=top><formwidget id="costruttore">
            <formerror  id="costruttore"><br>
            <span class="errori">@formerror.costruttore;noquote@</span>
            </formerror>
        </td>

        <td valign=top align=right class=form_title>Modello</td>
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

        <td valign=top align=right class=form_title>Matricola</td>
        <td valign=top><formwidget id="matricola">
            <formerror  id="matricola"><br>
            <span class="errori">@formerror.matricola;noquote@</span>
            </formerror>
        </td>
    </tr>
    <tr>
         <td valign=top align=right class=form_title>Anno di costruzione</td>
         <td valign=top><formwidget id="data_costruz_gen"></td>
         <td valign=top align=right class=form_title>Tipologia</td>
         <td valign=top><formwidget id="tipo_a_c"></td>
         <td valign=top align=right class=form_title>Marcatura efficienza energetica:(DPR 660/96)</td>
         <td valign=top><formwidget id="marc_effic_energ"></td>
    </tr>
    <tr>
        <td valign=top align=right class=form_title>Pot. term. nom. utile (kW)</td>
        <td valign=top><formwidget id="potenza">
            <formerror  id="potenza"><br>
            <span class="errori">@formerror.potenza;noquote@</span>
            </formerror>
        </td>
        <td valign=top align=right class=form_title>Pot. term. nom al focolare (kW)</td>
        <td valign=top><formwidget id="pot_focolare_nom"></td>
        <td valign=top align=right class=form_title>Fluido termovettore</td>
        <td valign=top><formwidget id="mod_funz"></td>       
    </tr>
    <tr>
        <td valign=top align=left call=form_title><b>Bruciatore abbinato</b></td>
    </tr>
    <tr>
        <td valign=top align=right class=form_title>Costruttore</td>
        <td valign=top><formwidget id="costruttore_bruc"></td>

        <td valign=top align=right class=form_title>Modello</td>
 	<if @coimtgen.flag_gest_coimmode@ eq "F"><!-- nic01 -->
            <td valign=top><formwidget id="modello_bruc">
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

        <td valign=top align=right class=form_title>Matricola</td>
        <td valign=top><formwidget id="matricola_bruc"></td>
    </tr>
    <tr>
         <td valign=top align=right class=form_title>Anno di costruzione</td>
         <td valign=top><formwidget id="data_costruz_bruc">
            <formerror  id="data_costruz_bruc"><br>
            <span class="errori">@formerror.data_costruz_bruc;noquote@</span>
            </formerror>
         </td>
         <td valign=top align=right class=form_title>Tipologia</td>
         <td valign=top><formwidget id="tipo_bruciatore"></td>
         <td valign=top align=right class=form_title nowrap>Campo di funzionamento(kW) da</td>
         <td valign=top nowrap><formwidget id="campo_funzion_min">
                      a <formwidget id="campo_funzion_max"></td>
    </tr>
    <tr>
        <td valign=top align=right class=form_title><b>Data installaz. del generatore di calore</b></td>
        <td valign=top><formwidget id="data_insta">
            <formerror  id="data_insta"><br>
            <span class="errori">@formerror.data_insta@</span>
            </formerror>
        </td>       
    </tr>
</tr></table></td>
<tr><td><table width=100%>
    <tr>
        <td valign=top align=left class=form_title colspan=2><b>E. ESAME VISIVO E CONTROLLO DEI GENERATORI</b></td>
    </tr>
    <tr>
        <td valign=top align=left class=form_title colspan=2>Bruciatore</td>
    </tr>
    <tr>
        <td valign=top align=right class=form_title width="30%">Ugelli puliti</td>
        <td valign=top width="30%"><formwidget id="pulizia_ugelli">
            <formerror  id="pulizia_ugelli"><br>
            <span class="errori">@formerror.pulizia_ugelli;noquote@</span>
            </formerror>
        </td>
        <td valign=top align=right class=form_title width="20%">Funzionamento corretto</td>
        <td valign=top width="20%"><formwidget id="funz_corr_bruc">
            <formerror  id="funz_corr_bruc"><br>
            <span class="errori">@formerror.funz_corr_bruc;noquote@</span>
            </formerror>
        </td>
    </tr>
    <tr>
        <td valign=top align=left class=form_title colspan=4>Generatore di calore</td>
    </tr>
    <tr>
        <td valign=top align=right class=form_title>Scambiatore lato fumi</td>
        <td valign=top><formwidget id="scambiatore">
            <formerror  id="scambiatore"><br>
            <span class="errori">@formerror.scambiatore;noquote@</span>
            </formerror>
        </td>
        <td valign=top align=right class=form_title>Accensione e funzionamento regolari</td>
        <td valign=top><formwidget id="accens_reg">
            <formerror  id="accens_reg"><br>
            <span class="errori">@formerror.accens_reg;noquote@</span>
            </formerror>
        </td>
    </tr>
    <tr>
        <td valign=top align=right class=form_title>Dispositivi di comando funzionanti correttamente</td>
        <td valign=top><formwidget id="disp_comando">
            <formerror  id="disp_comando"><br>
            <span class="errori">@formerror.disp_comando;noquote@</span>
            </formerror>
        </td>
        <td valign=top align=right class=form_title>Assenza di perdite e ossidazioni dai/sui raccordi</td>
        <td valign=top><formwidget id="ass_perdite">
            <formerror  id="ass_perdite"><br>
            <span class="errori">@formerror.ass_perdite;noquote@</span>
            </formerror>
        </td>
    </tr>
    <tr>
        <td valign=top align=right class=form_title>Dispositivi di sicurezza non manomessi e/o cortocircuitati</td>
        <td valign=top><formwidget id="disp_sic_manom">
            <formerror  id="disp_sic_manom"><br>
            <span class="errori">@formerror.disp_sic_manom;noquote@</span>
            </formerror>
        </td>
        <td valign=top align=right class=form_title>Vaso di espansione carico</td>
        <td valign=top><formwidget id="vaso_esp">
            <formerror  id="vaso_esp"><br>
            <span class="errori">@formerror.vaso_esp;noquote@</span>
            </formerror>
        </td>
    </tr>
    <tr>
        <td valign=top align=right class=form_title>Organi soggetti a sollecitazioni termiche integri e senza segni di usura e/o deformazione</td>
        <td valign=top><formwidget id="organi_integri">
            <formerror  id="organi_integri"><br>
            <span class="errori">@formerror.organi_integri;noquote@</span>
            </formerror>
        </td>
    </tr>
</tr></table></td>
</tr>
<tr>
    <td valign=top align=left class_form_title><b>F. CONTROLLO DEL RENDIMENTO DI COMBUSTIONE</b>
        <formwidget id="cont_rend">
        <formerror  id="eff_evac_fum"><br>
        <span class="errori">@formerror.eff_evac_fum;noquote@</span>
        </formerror>
    </td>
</tr>
<tr><td colspan=2 width=100%><table cellspacing=0 cellpadding=0 width=100% border=1>
   </tr><tr>
    <td valign=top align=center class=form_title>Temp. fumi (&deg;C)</td>
    <td valign=top align=center class=form_title>Temp. aria<br> comb. (&deg;C)</td>
    <td valign=top align=center class=form_title>O<sub><small>2</small></sub>(%)</td>
    <td valign=top align=center class=form_title>CO<sub><small>2</small></sub>(%)</td>
    <td valign=top align=center class=form_title>Bacharach (n.)</td>
    <td valign=top align=center class=form_title>CO calc. @misura_co;noquote@</td>
    <td valign=top align=center class=form_title>Rend.to combustione<br>a pot. nominale(%)</td>
    <td valign=top align=center class=form_title>Tiraggio (Pa)</td>
   </tr><tr>
    <td valign=top align=center><formwidget id="temp_fumi">
        <formerror  id="temp_fumi"><br>
        <span class="errori">@formerror.temp_fumi;noquote@</span>
        </formerror>
    </td>

    <td valign=top align=center><formwidget id="temp_ambi">
        <formerror  id="temp_ambi"><br>
        <span class="errori">@formerror.temp_ambi;noquote@</span>
        </formerror>
    </td>
    
    <td valign=top align=center><formwidget id="o2">
        <formerror  id="o2"><br>
        <span class="errori">@formerror.o2;noquote@</span>
        </formerror>
    </td>
    
    <td valign=top align=center><formwidget id="co2">
        <formerror  id="co2"><br>
        <span class="errori">@formerror.co2;noquote@</span>
        </formerror>
    </td>

    <td valign=top align=center><formwidget id="bacharach">
        <formerror  id="bacharach"><br>
        <span class="errori">@formerror.bacharach;noquote@</span>
        </formerror>
    </td>

    <td valign=top align=center><formwidget id="co">
        <formerror  id="co"><br>
        <span class="errori">@formerror.co;noquote@</span>
        </formerror>
    </td>

    <td valign=top align=center><formwidget id="rend_combust">
        <formerror  id="rend_combust"><br>
        <span class="errori">@formerror.rend_combust;noquote@</span>
        </formerror>
    </td>

    <td valign=top align=center><formwidget id="tiraggio_fumi">
        <formerror  id="tiraggio_fumi"><br>
        <span class="errori">@formerror.tiraggio_fumi;noquote@</span>
        </formerror>
    </td>
    </tr></table></td>
 </tr></table></td>
</tr>

<tr>
    <td align=center width="100%"><table>
         <tr>
           <td valign=bottom align=left class=form_title><b>Osservazioni</b></td>
         </tr>
         <tr>
           <td valign=top><formwidget id="osservazioni">
               <formerror  id="osservazioni"><br>
               <span class="errori">@formerror.osservazioni;noquote@</span>
               </formerror>

           </td>
         </tr>
         <tr>
             <td valign=bottom align=left class=form_title><b>Raccomandazioni</b><br> (in attesa di questi interventi l'impianto pu&ograve; essere messo in funzione)</td>
         </tr>
         <tr>
            <td valign=top><formwidget id="raccomandazioni">
                <formerror  id="raccomandazioni"><br>
                <span class="errori">@formerror.raccomandazioni;noquote@</span>
                </formerror>
            </td>
         </tr>
         <tr>
            <td valign=top align=left class=form_title><b>Prescrizioni</b><br> (in attesa di questi interventi l'impianto <b>non</b> pu&ograve; essere messo in funzione)</td>
         </tr>
         <tr>
            <td valign=top><formwidget id="prescrizioni">
               <formerror  id="prescrizioni"><br>
               <span class="errori">@formerror.prescrizioni;noquote@</span>
               </formerror>
            </td>  
         </tr>
    </tr></table></td>
</tr>

<tr>
    <td align=center><table><tr>
    <td valign=top align=right class=form_title>Data limite intervento</td>
    <td valign=top><formwidget id="data_utile_inter">
        <formerror  id="data_utile_inter"><br>
        <span class="errori">@formerror.data_utile_inter;noquote@</span>
        </formerror>
    </td>
    <td valign=top align=right class=form_title>Delega responsabile</td>
    <td valign=top><formwidget id="delega_resp">
        <formerror  id="delega_resp"><br>
        <span class="errori">@formerror.delega_resp;noquote@</span>
        </formerror>
    </td>
    <td valign=top align=right class=form_title>Delega manutentore</td>
    <td valign=top><formwidget id="delega_manut">
        <formerror  id="delega_manut"><br>
        <span class="errori">@formerror.delega_manut;noquote@</span>
        </formerror>
    </td>
    </tr></table></td>
</tr>

<tr><td align=center><table width="100%">
    <tr>
        <td valign=top align=right class=form_title>Data utile interv.</td>
        <td valign=top class=form_title>Anomalia</td>
    </tr> 

    <formwidget id="prog_anom_max">

    <multiple name=multiple_form>
    <tr>
        <formwidget id="prog_anom.@multiple_form.conta;noquote@">
        <td valign=top width ="20%" align=right><formwidget id="data_ut_int.@multiple_form.conta;noquote@">
            <formerror  id="data_ut_int.@multiple_form.conta;noquote@"><br>
            <span class="errori"><%= $formerror(data_ut_int.@multiple_form.conta;noquote@) %></span>
            </formerror>
        </td>
        <td valign=top width="80%"><formwidget id="cod_anom.@multiple_form.conta;noquote@">
            <formerror  id="cod_anom.@multiple_form.conta;noquote@"><br>
            <span class="errori"><%= $formerror(cod_anom.@multiple_form.conta;noquote@) %></span>
            </formerror>
        </td>
    </tr>
    </multiple>
</tr>
</table></td></tr>
<tr><td align=center><table><tr>
<tr>
    <td colspan=2 valign=top align=left class=form_title><b>Ai fini della sicurezza l'impianto pu&ograve; funzionare
<if @vis_desc_contr@ eq f>
    <td valign=top><formwidget id="flag_status">
        <formerror  id="flag_status"><br>
        <span class="errori">@formerror.flag_status;noquote@</span>
        </formerror>
    </td>
</if>
<else>
    <td valign=top><formwidget id="flag_stat">
        <formerror  id="flag_stat"><br>
        <span class="errori">@formerror.flag_stat;noquote@</span>
        </formerror>
    </td>
</else>
    <td  valign=top align=left class=form_title>Data scadenza dichiarazione
    <td valign=top><formwidget id="data_scadenza_autocert">
        <formerror  id="data_scadenza_autocert"><br>
        <span class="errori">@formerror.data_scadenza_autocert;noquote@</span>
        </formerror>
    </td>
</tr>
</table></td></tr>
<tr><td colspan=2>&nbsp;</td></tr>
<tr><td colspan=2><table>
<if @flag_portafoglio@ eq T>
<tr>
    <td valign=top align=right class=form_title width=13%>Tariffa</td>
    <td valign=top width=10%><formwidget id="tariffa_reg">
        <formerror  id="tariffa_reg"><br>
        <span class="errori">@formerror.tariffa_reg;noquote@</span>
        </formerror>
    </td>
    <td valign=top align=right class=form_title width=9%>Importo</td>
    <td valign=top width=10% nowrap><formwidget id="importo_tariffa">&#8364;
        <formerror  id="importo_tariffa"><br>
        <span class="errori">@formerror.importo_tariffa;noquote@</span>
        </formerror>
    </td>
    <if @funzione@ eq V>
     @message;noquote@
    </if>
    <else>
     <td>&nbsp;</td>
    </else>
</tr>
</if>
</table></td></tr>
<tr><td><table>
<tr>
    <td valign=top align=right class=form_title>Tipologia Costo</td>
    <td valign=top><formwidget id="tipologia_costo">
        <formerror  id="tipologia_costo"><br>
        <span class="errori">@formerror.tipologia_costo;noquote@</span>
        </formerror>
    </td>
    <td valign=top align=right class=form_title width=21%>Costo &#8364;</td>
    <td valign=top><formwidget id="costo">
        <formerror  id="costo"><br>
        <span class="errori">@formerror.costo;noquote@</span>
        </formerror>
    </td>
</tr>
<tr>
    <td valign=top align=right class=form_title>Rif./Numero bollino</td>
    <td valign=top><formwidget id="riferimento_pag">
        <formerror  id="riferimento_pag"><br>
        <span class="errori">@formerror.riferimento_pag;noquote@</span>
        </formerror>
    </td>
    <if @funzione@ eq I
     or @funzione@ eq M>
        <td valign=top align=right class=form_title>Pagato</td>
        <td valign=top><formwidget id="flag_pagato">
            <formerror  id="flag_pagato"><br>
            <span class="errori">@formerror.flag_pagato;noquote@</span>
            </formerror>
        </td>
    </if>
    </tr>
    <tr>
        <td valign=top align=right class=form_title>Data scad. pagamento</td>
        <td valign=top><formwidget id="data_scad_pagamento">
            <formerror  id="data_scad_pagamento"><br>
            <span class="errori">@formerror.data_scad_pagamento;noquote@</span>
            </formerror>
        </td>
    </tr></table></td>
</tr>

<tr><td colspan=2>&nbsp;</td></tr>

<if @funzione@ ne "V">
    <tr><td colspan=1 align=center><formwidget id="submit"></td></tr>
</if>

<!-- Fine della form colorata -->
<%=[iter_form_fine]%>

</formtemplate>
<p>
</center>


