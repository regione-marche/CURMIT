<!--
    USER  DATA       MODIFICHE
    ===== ========== =======================================================================
    mat01 02/09/2025 Modifiche fatte per l'accessibilità.(ho usato mauve++ per vedere gli errori)
    mat01            Sostituito il tag font con uno span. Tolto il tag center e sostituito con
    mat01            un div. Sostituiti i tag <b> con <strong>. Aggiunto uno script javascript
    mat01            per aggiungere autocomplete off a tutti i widget. Aggiunto scope="col"
    mat01            ai th. Aggiunto uno script javascript per aggiungere automaticamente la label.
    mat01            Aggiunto class=form_title ai td label in cui mancava.

    rom06 19/02/2019 Su richiesta della regione marche ho rinominato il bottone
    rom06            "Ins. Doc." in "Storicizza stampa RCEE".

    gac09 21/12/2018 Aggiunto warning_dfm

    gac08 12/12/2018 Aggiunta frase_inserimento_ciclo che mi indica il generatore che sto 
    gac08            inserendo se sono in un ciclo e nascosto "Cerca" manutentore e installatore
    gac08            nel caso sia in un ciclo di inserimento

    gac07 09/11/2018 Varie modifiche alle label e spostamento campi

    rom05 03/10/2018 La regione Marche ha richiesto che non fosse più possibile inserire 
    rom05            Proprietario e Occupante dalla schermata degli RCEE quindi gli oscuro i link.

    gac06 20/07/2018 Aggiunto nuovi campi strumenti Analizzatore e Deprtimometro utilizzato 
    gac06            per le prove fumi.

    gac05 02/07/2018 Modificate label
          20/12/2018 

    rom04 08/06/2018 Aggiunti i campi co_fumi_secchi_ppm e barra_an

    rom02 28/05/2018 Modificate le diciture 'Num. protocollo' e 'Data protocollo' in 
    rom02            'Numero Rif. interno' e 'Data Rif. interno' su indicazione di Sandro.
    rom02            Non faccio più vedere il campo 'data di arrivo all'ente'.
    gac04 07/06/2018 aggiunto campi elettricità

    rom02M28/05/2018 Modificate le diciture 'Num. protocollo' e 'Data protocollo' in 
    rom02M           'Numero Rif. interno' e 'Data Rif. interno' su indicazione di Sandro.
    rom02M           Non faccio più vedere il campo 'data di arrivo all'ente'.
 
    innes 17/05/2018 Innesto da iter-dev a iter-portal-dev. Tutte le query verranno eseguite
    innes            passando il dbn che riceviamo dalla pagina di filtro. Abbiamo gestito il
    innes            dbn anche per le proc iter_get_coimtgen.


    gac03 11/05/2018 Aggiunto campo portata_termica_effettiva e relativo warning     

    gac02 07/05/2018 Aggiunti nuovi campi bacharach2, bacharach3, portata_comb, rispetta_indice_bacharach, co_fumi_secchi,
    gac02            rend_magg_o_ugua_rend_min

    gac01 02/05/2018 Aggiunti campi acquisti, acquisti2, scorta_o_lett_iniz, scorta_o_lett_iniz2,
    gac01            scorta_o_lett_fin, scorta_o_lett_fin2

    rom01 26/01/2018 Aggiunto sezione multirow per prove fumi aggiuntive

    mis01 17/10/2016 Aggiunto asterisco sui campi obbligatori.

    nic01 15/05/2014 Comune di Rimini: se è attivo il parametro flag_gest_coimmode, deve
    nic01            comparire un menù a tendina con l'elenco dei modelli relativi al
    nic01            costruttore selezionato (tale menù a tendina deve essere rigenerato
    nic01            quando si cambia la scelta del costruttore).
-->

<!-- innes <master   src="../master"> -->
<master> <!-- innes -->
<property name="title">@page_title;noquote@</property>
<property name="context_bar">@context_bar;noquote@</property>
<property name="riga_vuota">f</property>

<!--mat01<center>--> <!-- innes -->


<!--mat01 <center>-->
<div align="center"><!--mat01-->
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
<formwidget   id="list_anom_old">
<formwidget   id="flag_modifica">
<formwidget   id="gen_prog">
<formwidget   id="flag_ins_occu">
<formwidget   id="flag_ins_prop">
<formwidget   id="flag_modello_h">
<formwidget   id="nome_funz_new">
<formwidget   id="nome_funz_gest">
<formwidget   id="flag_tracciato">
<formwidget   id="locale">
<formwidget   id="esente">
<formwidget   id="is_warning_p">
<if @vis_desc_contr@ eq t>
    <formwidget id="flag_status"
</if>
<formwidget   id="__refreshing_p"><!-- nic01 -->
<formwidget   id="changed_field"> <!-- nic01 -->
  <if @coimtgen.regione@ eq "MARCHE"><!--gac07-->
    <formwidget   id="cont_rend">
</if>
<!-- Inizio della form colorata -->
<%=[iter_form_iniz]%>
<tr><td><table width="100%"><tr>
<td align="left" width="50%">@esito;noquote@</td>
<if @funzione@ eq "V">
<!-- innes <td align="right" width="50%">Inserito da: @nome_utente_ins;noquote@</td></tr> -->
<td align="center" width="50%">Inserito da: @nome_utente_ins;noquote@</td></tr> <!-- innes -->
<tr><td align="left" width="50%">&nbsp;</td>
<td align="right" width="50%">In data: @data_ins_edit;noquote@</td></tr>
</table></td></tr> <!-- innes -->
</if>
<else>
<td width="50%">&nbsp;</td></tr>
</else>
<tr><td><table width="100%" border=0>
<if @coimtgen.regione@ eq "MARCHE"><!--gac07-->
  <tr>
    <th valign=top colspan=4 align=left class=form_title scope="col">A.DATI IDENTIFICATIVI</th>
  </tr>
<tr>
<td class=form_title>Impianto: di Potenza termica nominale totale max (kW)</td>
<td valign=top><formwidget id="pot_ter_nom_tot_max">
   <formerror  id="pot_ter_nom_tot_max"><br>
      <span class="errori">@formerror.pot_ter_nom_tot_max;noquote@</span>
   </formerror>
</td>
</tr>
<tr>
    <td valign=top width=25% align=right class=form_title>Rapporto di controllo N&deg;</td>
    <td valign=top><formwidget id="num_autocert">
        <formerror  id="num_autocert"><br>
        <span class="errori">@formerror.num_autocert;noquote@</span>
        </formerror>
    </td>

</tr>
</if>
<else>
<tr>
    <td valign=top width=25% align=right class=form_title>Rapporto di controllo N&deg;</td>
    <td valign=top><formwidget id="num_autocert">
        <formerror  id="num_autocert"><br>
        <span class="errori">@formerror.num_autocert;noquote@</span>
        </formerror>
    </td>
    <td valign=top align=right class=form_title nowrap>Data del controllo <span style="color:red">*</span></td><!--mat01-->
    <td  valign=top><formwidget id="data_controllo">
        <formerror  id="data_controllo"><br>
        <span class="errori">@formerror.data_controllo;noquote@</span>
        </formerror>
    </td>

    <td valign=top align=right class=form_title>Orario di arrivo presso l'impianto @ast;noquote@</td><!-- mis01 -->
    <td  valign=top><formwidget id="ora_inizio">
        <formerror  id="ora_inizio"><br>
        <span class="errori">@formerror.ora_inizio;noquote@</span>
        </formerror>
    </td>

    <td valign=top align=right class=form_title>Orario di partenza dall'impianto @ast;noquote@</td><!-- mis01 -->
    <td  valign=top><formwidget id="ora_fine">
        <formerror  id="ora_fine"><br>
        <span class="errori">@formerror.ora_fine;noquote@</span>
        </formerror>
    </td>

</tr>
</else>


<tr>
    <td valign=top align=right class=form_title>Numero Rif. interno</td>
    <td valign=top><formwidget id="n_prot">
        <formerror  id="n_prot"><br>
        <span class="errori">@formerror.n_prot;noquote@</span>
        </formerror>
    </td>
    <td valign=top align=right class=form_title>Data Rif. interno</td>
    <td valign=top><formwidget id="data_prot">
        <formerror  id="data_prot"><br>
        <span class="errori">@formerror.data_prot;noquote@</span>
        </formerror>
    </td>
<!-- rom02M
    <td valign=top align=right class=form_title>Data di arrivo all'ente</td>
    <td valign=top><formwidget id="data_arrivo_ente">
        <formerror  id="data_arrivo_ente"><br>
        <span class="errori">@formerror.data_arrivo_ente;noquote@</span>
        </formerror>
    </td>
-->
    <if @flag_cind@ eq "S">
       <td valign=top align=right class=form_title>Campagna<if @funzione@ eq "I">@ast;noquote@</if></td><!-- mis01 -->
       <td valign=top><formwidget id="cod_cind">
         <formerror  id="cod_cind"><br>
         <span class="errori">@formerror.cod_cind;noquote@</span>
         </formerror>
       </td>
    </if>

    </tr></table></td>
</tr>
<tr><td><table border=0 width="100%">
    <tr>
        <td width="17%" valign=top align=left class=form_title>Responsabile d'impianto</td>
<if @coimtgen.regione@ ne "MARCHE"> <!--gac07-->
        <td width="17%" valign=top align=left class=form_title>Proprietario</td>
        <td width="17%" valign=top align=left class=form_title>Occupante</td>
        <td width="16%" valign=top align=left class=form_title>Intestatario Contratto</td>
</if>	
        <td width="16%" valign=top align=left class=form_title>Impresa manutentrice<span style="color:red">*</span></td><!--mat01-->
        <td width="17%" valign=top align=left nowrap class=form_title>Tecnico che ha effettuato il controllo<if @coimtgen.ente@ ne "PLI"
                                                                               and @coimtgen.ente@ ne "PVE"
                                                                               and @coimtgen.ente@ ne "PCE"
                                                                               and @coimtgen.ente@ ne "PPO"
                                                                               and @coimtgen.ente@ ne "PPD"
                                                                               and @coimtgen.ente@ ne "PBT"
                                                                               and @sw_iterprfi@ ne "1">@ast;noquote@</if></td><!-- mis01 -->
    </tr>
    <tr>
    <td valign=top><formwidget id="cognome_resp"><if @cod_dimp_precedente@ eq "">@link_gest_resp;noquote@</if><br>
        <formwidget id="nome_resp"><if @cod_dimp_precedente@ eq "">@cerca_resp;noquote@</if><br>
        <formwidget id="cod_fiscale_resp">(CF)<br>
        <formerror  id="cognome_resp"><br>
        <span class="errori">@formerror.cognome_resp;noquote@</span>
        </formerror>
    </td>
<if @coimtgen.regione@ ne "MARCHE"><!--gac07 le marche non devono vedere proprietario, occupante e intestatario contratto-->
<td valign=top><formwidget id="cognome_prop"><br>
        <formwidget id="nome_prop">@cerca_prop;noquote@
        <formerror  id="cognome_prop"><br>
        <span class="errori">@formerror.cognome_prop;noquote@</span>
        </formerror>
       <br><if @coimtgen.regione@ ne "MARCHE">@link_ins_prop;noquote@</if><!--rom05 aggiunta if, le marche non devono poter inserire
                                                                               soggetti dall'rcee quindi gli oscuro il link -->
    </td>
    <td valign=top><formwidget id="cognome_occu"><br>
        <formwidget id="nome_occu">@cerca_occu;noquote@
        <formerror  id="cognome_occu"><br>
        <span class="errori">@formerror.cognome_occu;noquote@</span>
        </formerror>
        <br><if @coimtgen.regione@ ne "MARCHE">@link_ins_occu;noquote@</if><!--rom05 aggiunta if, le marche non devono poter inserire 
									       soggetti dall'rcee quindi gli oscuro il link -->
    </td>
    <td valign=top><formwidget id="cognome_contr"><br>
        <formwidget id="nome_contr">@cerca_contr;noquote@
        <formerror  id="cognome_contr"><br>
        <span class="errori">@formerror.cognome_contr;noquote@</span>
        </formerror>
    </td>
</if>
    <td valign=top><formwidget id="cognome_manu"><br>
        <formwidget id="nome_manu"><if @cod_dimp_precedente@ eq "">@cerca_manu;noquote@</if><!--gac08-->
        <formerror  id="cognome_manu"><br>
        <span class="errori">@formerror.cognome_manu;noquote@</span>
        </formerror>
    </td>
        <td valign=top><formwidget id="cognome_opma"><br>
            <formwidget id="nome_opma"><if @cod_dimp_precedente@ eq "">@cerca_opma;noquote@</if><!--gac08-->
            <formerror  id="cognome_opma"><br>
            <span class="errori">@formerror.cognome_opma;noquote@</span>
            </formerror>
        </td>
    </tr></table></td>
</tr>

<tr><td><table border=0 width=100%><tr>
    <td width=50% valign=top><table border=0 width=100%><tr>
    <th valign=top colspan=4 align=left class=form_title scope="col">B.DOCUMENTAZIONE TECNICA DI CORREDO</th>
    </tr>

    <tr>
    <td valign=top align=right class=form_title>Dichiarazione di Conformit&agrave; presente</td>
    <td valign=top><formwidget id="conformita">
        <formerror  id="conformita"><br>
        <span class="errori">@formerror.conformita;noquote@</span>
        </formerror>
    </td>
  
    <td valign=top align=right class=form_title>Libretti uso/manutenzione generatore presenti</td>
    <td valign=top><formwidget id="lib_uso_man">
        <formerror  id="lib_uso_man"><br>
        <span class="errori">@formerror.lib_uso_man;noquote@</span>
        </formerror>
    </td>
    </tr>

    <tr>
    <td valign=top align=right class=form_title>Libretto d'impianto presente</td>
    <td valign=top><formwidget id="lib_impianto">
        <formerror  id="lib_impianto"><br>
        <span class="errori">@formerror.lib_impianto;noquote@</span>
        </formerror>
    </td>
   
    <td valign=top align=right class=form_title>Libretto compilato in tutte le sue parti</td>
    <td valign=top><formwidget id="rct_lib_uso_man_comp">
        <formerror  id="lib_uso_man"><br>
        <span class="errori">@formerror.rct_lib_uso_man_comp;noquote@</span>
        </formerror>
    </td>
    </tr>

    <tr>
    <th valign=top colspan=2 align=left class=form_title scope="col">C.TRATTAMENTO DELL'ACQUA</th>
    </tr><tr>
    <td valign=top align=right class=form_title>Durezza totale dell'acqua (°fr)</td>
    <td valign=top><formwidget id="rct_dur_acqua">
        <formerror  id="rct_dur_acqua"><br>
        <span class="errori">@formerror.rct_dur_acqua;noquote@</span>
        </formerror>
    </td>
    </tr><tr>
    <td valign=top align=right class=form_title>Trattamento in riscaldamento:</td>
    <td valign=top><formwidget id="rct_tratt_in_risc">
        <formerror  id="rct_tratt_in_risc"><br>
        <span class="errori">@formerror.rct_tratt_in_risc;noquote@</span>
        </formerror>
    </td>
    </tr><tr>
    <td valign=top align=right class=form_title>Trattamento in ACS:</td>
    <td valign=top><formwidget id="rct_tratt_in_acs">
        <formerror  id="rct_tratt_in_acs"><br>
        <span class="errori">@formerror.rct_tratt_in_acs;noquote@</span>
        </formerror>
    </td>
    </tr><tr>

    <th valign=top align=left colspan=2 class=form_title scope="col">D. CONTROLLO DELL'IMPIANTO</th>
    </tr><tr> 
    <td valign=top align=right class=form_title>Per installazione interna: in locale idoneo</td><!--gac05-->
    <td valign=top><formwidget id="idoneita_locale">
        <formerror  id="idoneita_locale"><br>
        <span class="errori">@formerror.idoneita_locale;noquote@</span>
        </formerror>
    </td>
       <td valign=top align=right class=form_title>Canali da fumo e condotti di scarico idonei (esame visivo)</td><!--gac05-->
    <td valign=top><formwidget id="rct_canale_fumo_idoneo">
        <formerror  id="rct_canale_fumo_idoneo"><br>
        <span class="errori">@formerror.rct_canale_fumo_idoneo;noquote@</span>
        </formerror>
    </td>
    </tr><tr>
     </tr><tr> 
    <td valign=top align=right class=form_title>Per installazione esterna:generatori idonei</td>
    <td valign=top><formwidget id="rct_install_interna">
        <formerror  id="rct_install_interna"><br>
        <span class="errori">@formerror.rct_install_interna;noquote@</span>
        </formerror>
    </td>
     <td valign=top align=right class=form_title>Sistema di regolazione temp. ambiente funzionante</td>
    <td valign=top><formwidget id="rct_sistema_reg_temp_amb">
        <formerror  id="sistema_reg_temp_amb"><br>
        <span class="errori">@formerror.sistema_reg_temp_amb;noquote@</span>
        </formerror>
    </td>
    </tr><tr>
          <td valign=top align=right class=form_title>Aperture di ventilazione/areazione libere da ostruzioni</td>
    <td valign=top><formwidget id="ap_vent_ostruz">
        <formerror  id="ap_vent_ostruz"><br>
        <span class="errori">@formerror.ap_vent_ostruz;noquote@</span>
        </formerror>
    </td>
    <td valign=top align=right class=form_title>Assenza di perdite di combustibile liquido </td>
    <td valign=top><formwidget id="rct_assenza_per_comb"><!--innes <a href="#" onclick="javascript:window.open('coimaimp-gest-help?caller=rct-assenza-per-comb', 'help', 'scrollbars=yes, esizable=yes, width=520, height=280').moveTo(110,140)"><strong>Vedi nota</strong></a>--> <!--gac07 aggiunto pop-up su richiesta delle Marche-->
        <formerror  id="rct_assenza_per_comb"><br>
        <span class="errori">@formerror.rct_assenza_per_comb;noquote@</span>
        </formerror>    </td>
    </tr><tr>
    <td valign=top align=right class=form_title>Adeguate dimensione aperture ventilazione/areazione</td>
    <td valign=top><formwidget id="ap_ventilaz">
        <formerror  id="ap_ventilaz"><br>
        <span class="errori">@formerror.ap_ventilaz;noquote@</span>
        </formerror>
    </td>
    <td valign=top align=right class=form_title>Idonea tenuta dell'impianto interno e raccordi con il generatore</td>
    <td valign=top><formwidget id="rct_idonea_tenuta">
<!--innes <a href="#" onclick="javascript:window.open('coimaimp-gest-help?caller=rct-idonea-tenuta', 'help', 'scrollbars=yes, esizable=yes, width=520, height=280').moveTo(110,140)"><strong>Vedi nota</strong></a>--> <!--gac07 aggiunto pop-up su richiesta delle Marche-->
        <formerror  id="rct_idonea_tenuta"><br>
        <span class="errori">@formerror.rct_idonea_tenuta;noquote@</span>
        </formerror>
    </td>
    </tr> </table></td></tr>

<!-- gac01 -->
<tr><td><table border=0 width=100%>
<tr><td colspan=6><strong>D.bis. CONSUMI</strong></td></tr>
<tr>   
    <td valign=top align=center colspan=6 class=form_title><strong>Consumi di combustibile <if @um;noquote@ ne "">(@um;noquote@)</if></strong>
</tr>
<tr>
    <td width=21% valign=top align=center class=form_title>Stagione di riscaldamento attuale</td>
    <td width=15% valign=top align=center class=form_title>Acquisti</td>
    <td width=15% valign=top align=center class=form_title>Scorta o lettura iniziale</td>
    <td width=15% valign=top align=center class=form_title>Scorta o lettura finale</td>
    <td width=34% valign=top align=center class=form_title>Consumi stagione </td>
</tr>
<tr>
    <td valign=top align=center><formwidget id="stagione_risc">
        <formerror  id="stagione_risc"><br>
        <span class="errori">@formerror.stagione_risc;noquote@</span>
        </formerror>
    </td>
    <td valign=top align=center><formwidget id="acquisti">
        <formerror  id="acquisti"><br>
        <span class="errori">@formerror.acquisti;noquote@</span>
        </formerror>
    </td>
    <td valign=top align=center><formwidget id="scorta_o_lett_iniz">
        <formerror id="scorta_o_lett_iniz"><br>
        <span class="errori">@formerror.scorta_o_lett_iniz;noquote@</span>
        </formerror>
    </td>
    <td valign=top align=center><formwidget id="scorta_o_lett_fin">
        <formerror id="scorta_o_lett_fin"><br>
        <span class="errori">@formerror.scorta_o_lett_fin;noquote@</span>
        </formerror>
    </td>
    <td valign=top align=center><formwidget id="consumo_annuo">
        <formerror  id="consumo_annuo"><br>
        <span class="errori">@formerror.consumo_annuo;noquote@</span>
        </formerror>
    </td>
</tr>
<tr>
<td>&nbsp;</td>
<td>&nbsp;</td>
<td>&nbsp;</td>
<td>&nbsp;</td>
<td>@cons_annuo;noquote@</td>
</tr>
<tr>
    <td valign=top align=center class=form_title>Stagione di riscaldamento precedente</td>
    <td valign=top align=center class=form_title>Acquisti</td>
    <td valign=top align=center class=form_title>Scorta o lett. iniziale</td>
    <td valign=top align=center class=form_title>Scorta o lett. finale</td>
    <td valign=top align=center class=form_title>Consumi stagione</td>
</tr>
<tr>
    <td valign=top align=center><formwidget id="stagione_risc2">
        <formerror  id="stagione_risc2"><br>
        <span class="errori">@formerror.stagione_risc2;noquote@</span>
        </formerror>
    </td>
    <td valign=top align=center><formwidget id="acquisti2">
        <formerror  id="acquisti2"><br>
        <span class="errori">@formerror.acquisti2;noquote@</span>
        </formerror>
    </td>
    <td valign=top align=center><formwidget id="scorta_o_lett_iniz2">
        <formerror id="scorta_o_lett_iniz2"><br>
        <span class="errori">@formerror.scorta_o_lett_iniz2;noquote@</span>
        </formerror>
    </td>
    <td valign=top align=center><formwidget id="scorta_o_lett_fin2">
        <formerror id="scorta_o_lett_fin2"><br>
        <span class="errori">@formerror.scorta_o_lett_fin2;noquote@</span>
        </formerror>
    </td>
    <td valign=top align=center><formwidget id="consumo_annuo2">
        <formerror  id="consumo_annuo2"><br>
        <span class="errori">@formerror.consumo_annuo2;noquote@</span>
        </formerror>
    </td>
</tr>
<tr>
<td>&nbsp;</td>
<td>&nbsp;</td>
<td>&nbsp;</td>
<td>&nbsp;</td>
<td>@cons_annuo;noquote@</td>
</tr>
</table></td></tr>
<tr><td><table border=0 width=100%><!--gac04 aggiunto campi elettricità -->
<tr>   
    <td valign=top align=center colspan=4 class=form_title><strong>Consumi elettrici</strong>
</tr>
<tr>
    <td valign=top align=center class=form_title>Esercizio</td>
    <td valign=top align=center class=form_title>Lettura iniziale (kWh)</td>
    <td valign=top align=center class=form_title>Lettura finale (kWh)</td>
    <td valign=top align=center class=form_title>Consumo totale (kWh)</td>
</tr>
<tr>
    <td valign=top align=center><formwidget id="elet_esercizio_1">
        <formerror  id="elet_esercizio_1"><br>
        <span class="errori">@formerror.elet_esercizio_1;noquote@</span>
        </formerror>
    / <formwidget id="elet_esercizio_2">
        <formerror  id="elet_esercizio_2"><br>
        <span class="errori">@formerror.elet_esercizio_2;noquote@</span>
        </formerror>
    </td>
    <td valign=top align=center><formwidget id="elet_lettura_iniziale">
        <formerror  id="elet_lettura_iniziale"><br>
        <span class="errori">@formerror.elet_lettura_iniziale;noquote@</span>
        </formerror>
    </td>
    <td valign=top align=center><formwidget id="elet_lettura_finale">
        <formerror  id="elet_lettura_finale"><br>
        <span class="errori">@formerror.elet_lettura_finale;noquote@</span>
        </formerror>
    </td>
    <td valign=top align=center><formwidget id="elet_consumo_totale">
        <formerror  id="elet_consumo_totale"><br>
        <span class="errori">@formerror.elet_consumo_totale;noquote@</span>
        </formerror>
    </td>
</tr>
<tr>
    <td valign=top align=center><formwidget id="elet_esercizio_3">
        <formerror  id="elet_esercizio_3"><br>
        <span class="errori">@formerror.elet_esercizio_3;noquote@</span>
        </formerror>
    / <formwidget id="elet_esercizio_4">
        <formerror  id="elet_esercizio_4"><br>
        <span class="errori">@formerror.elet_esercizio_4;noquote@</span>
        </formerror>
    </td>
    <td valign=top align=center><formwidget id="elet_lettura_iniziale_2">
        <formerror  id="elet_lettura_iniziale_2"><br>
        <span class="errori">@formerror.elet_lettura_iniziale_2;noquote@</span>
        </formerror>
    </td>
    <td valign=top align=center><formwidget id="elet_lettura_finale_2">
        <formerror  id="elet_lettura_finale_2"><br>
        <span class="errori">@formerror.elet_lettura_finale_2;noquote@</span>
        </formerror>
    </td>
    <td valign=top align=center><formwidget id="elet_consumo_totale_2">
        <formerror  id="elet_consumo_totale_2"><br>
        <span class="errori">@formerror.elet_consumo_totale_2;noquote@</span>
        </formerror>
    </td>
</tr>

</table></td></tr>

<tr><td><table border=0 width=100%>
      <tr><td colspan=6><strong>E. CONTROLLO E VERIFICA ENERGETICA DEL GRUPPO TERMICO G T @gen_prog@ DATA INSTALLAZIONE:
	    <if @coimtgen.regione@ eq "MARCHE">
	      <formwidget id="data_insta">
	  </if></strong>
      </td></tr>
    <tr>
    <td valign=top align=right class=form_title>Fabbricante <if @flag_mod_gend@ eq "S">@ast;noquote@</if></td><!-- mis01 -->
    <if @coimtgen.regione@ eq "MARCHE"><!--gac08 Aggiunto campi solo per regione Marche in quanto devono essere solo visualizzabili-->
      <td valign=top><formwidget id="descr_cost">
        <formerror  id="descr_cost"><br>
        <span class="errori">@formerror.descr_cost;noquote@</span>
        </formerror>
    </td>
    </if>
    <else>
      <td valign=top><formwidget id="costruttore">
          <formerror  id="costruttore"><br>
            <span class="errori">@formerror.costruttore;noquote@</span>
          </formerror>
      </td>
    </else>
    <td valign=top align=right class=form_title>Modello <if @flag_mod_gend@ eq "S">@ast;noquote@</if></td><!-- mis01 -->
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

    <td valign=top align=right class=form_title>Matricola <if @flag_mod_gend@ eq "S">@ast;noquote@</if></td><!-- mis01 -->
    <td valign=top><formwidget id="matricola">
        <formerror  id="matricola"><br>
        <span class="errori">@formerror.matricola;noquote@</span>
        </formerror>
    </td>
</tr>
<tr>
    <td valign=top align=right class=form_title>Tipo Gruppo Termico</td>
    <if @coimtgen.regione@ eq "MARCHE"><!--gac08 Aggiunto campi solo per regione Marche in quanto devono essere solo visualizzabili-->
      <td valign=top><formwidget id="desc_grup_term">
        <formerror  id="desc_grup_term"><br>
        <span class="errori">@formerror.desc_grup_term;noquote@</span>
        </formerror>
    </td>
    </if>
    <else>
      <td valign=top><formwidget id="rct_gruppo_termico">
	  <formerror  id="rct_gruppo_termico"><br>
	    <span class="errori">@formerror.rct_gruppo_termico;noquote@</span>
	  </formerror>
      </td>
    </else>
</tr>
<tr>
    <td valign=top align=right class=form_title>Potenza termica nominale massima al focolare (kW) @ast;noquote@</td><!-- mis01 -->
    <td valign=top><formwidget id="pot_focolare_nom">
        <formerror  id="pot_focolare_nom"><br>
        <span class="errori">@formerror.pot_focolare_nom;noquote@</span>
        </formerror>
    </td>
    <td valign=top align=right class=form_title>Potenza termica nominale utile (kW) @ast;noquote@</td><!-- mis01 -->
    <td valign=top><formwidget id="potenza">
        <formerror  id="potenza"><br>
        <span class="errori">@formerror.potenza;noquote@</span>
        </formerror>
    </td>
    <if @coimtgen.regione@ ne "MARCHE">
      <td valign=top align=right class=form_title>Data costruzione</td>
      <td valign=top><formwidget id="data_costruz_gen">
        <formerror  id="data_costruz_gen"><br>
        <span class="errori">@formerror.data_costruz_gen;noquote@</span>
        </formerror>
    </td>
    </if>
</tr>
<tr>
    <td valign=top align=right class=form_title>Marcatura efficienza energetica (DPR 660/96)</td>
    <td valign=top><formwidget id="marc_effic_energ">
        <formerror  id="marc_effic_energ"><br>
        <span class="errori">@formerror.marc_effic_energ;noquote@</span>
        </formerror>
    </td>
    <if @coimtgen.regione@ ne "MARCHE"><!--gac07 aggiunta if e suo contenuto-->
    <td valign=top align=right class=form_title>Destinazione @ast;noquote@</td>
    <td valign=top><formwidget id="destinazione">
        <formerror  id="destinazione"><br>
        <span class="errori">@formerror.destinazione;noquote@</span>
        </formerror>
    </td>
    </if>
    
    <if @coimtgen.regione@ ne "MARCHE">
      <td valign=top align=right class=form_title>Data installazione @ast;noquote@</td><!-- mis01 -->
      <td valign=top><formwidget id="data_insta">
        <formerror  id="data_insta"><br>
        <span class="errori">@formerror.data_insta;noquote@</span>
        </formerror>
      </td>
    </if>
    <else>
    <td valign=top align=right class=form_title>Data costruzione</td>
    <td valign=top><formwidget id="data_costruz_gen">
        <formerror  id="data_costruz_gen"><br>
        <span class="errori">@formerror.data_costruz_gen;noquote@</span>
        </formerror>
    </td>
      </else>
</tr>
				    
<if @coimtgen.regione@ eq "MARCHE"><!--gac07 aggiunta if e suo contenuto-->	
<tr>
    <td valign=top align=right class=form_title>Climatizzazione invernale @ast;noquote@</td>
    <td valign=top><formwidget id="flag_clima_invernale_gen">
    <formerror  id="flag_clima_invernale_gen"><br>
       <span class="errori">@formerror.flag_clima_invernale_gen;noquote@</span>
    </formerror>
    </td>
    <td valign=top align=right class=form_title>Produzione di acqua calda sanitaria @ast;noquote@</td>
    <td valign=top><formwidget id="flag_prod_acqua_calda_gen">
<!--innes<a href="#" onclick="javascript:window.open('coimaimp-gest-help?caller=flag-clima-e-prod', 'help', 'scrollbars=yes, esizable=yes, width=520, height=280').moveTo(110,140)"><strong>Vedi nota</strong></a> --><!--gac07 aggiunto pop-up su richiesta delle Marche-->
    <formerror  id="flag_prod_acqua_calda_gen"><br>
       <span class="errori">@formerror.flag_prod_acqua_calda_gen;noquote@</span>
    </formerror>     
    </td>
</tr>
</if>
<tr>
    <td valign=top align=right class=form_title>Combustibile <if @flag_mod_gend@ eq "S">@ast;noquote@</if></td><!-- mis01 -->
    <if @coimtgen.regione@ eq "MARCHE"><!--gac08 Aggiunto campi solo per regione Marche in quanto devono essere solo visualizzabili-->
      <td valign=top><formwidget id="descr_comb">
        <formerror  id="descr_comb"><br>
        <span class="errori">@formerror.descr_comb;noquote@</span>
        </formerror>
    </td>
    </if>
    <else>
      <td valign=top><formwidget id="combustibile">
          <formerror  id="combustibile"><br>
            <span class="errori">@formerror.combustibile;noquote@</span>
          </formerror>
      </td>
    </else>
    <td valign=top align=right class=form_title colspan=1>Camera di combustione<if @flag_mod_gend@ eq "S">@ast_PFI;noquote@</if></td>
    <if @coimtgen.regione@ eq "MARCHE"><!--gac08 Aggiunto campi solo per regione Marche in quanto devono essere solo visualizzabili-->
      <td valign=top><formwidget id="tipo_a_c_gen">
        <formerror  id="tipo_a_c_gen"><br>
        <span class="errori">@formerror.tipo_a_c_gen;noquote@</span>
        </formerror>
    </td>
    </if>
    <else>
      <td valign=top><formwidget id="tipo_a_c">
	  <formerror  id="tipo_a_c"><br>
	    <span class="errori">@formerror.tipo_a_c;noquote@</span>
	  </formerror>
      </td>
    </else>
    <td valign=top align=right class=form_title>Modalità di evacuazione fumi <if @flag_mod_gend@ eq "S">@ast_PFI;noquote@</if></td>
    <if @coimtgen.regione@ eq "MARCHE"><!--gac08 Aggiunto campi solo per regione Marche in quanto devono essere solo visualizzabili-->
      <td valign=top><formwidget id="tiraggio_gen">
        <formerror  id="tiraggio_gen"><br>
        <span class="errori">@formerror.tiraggio_gen;noquote@</span>
        </formerror>
    </td>
    </if>
    <else>
      <td valign=top><formwidget id="tiraggio">
          <formerror  id="tiraggio"><br>
            <span class="errori">@formerror.tiraggio;noquote@</span>
          </formerror>
      </td>
    </else>
</tr>

</table></td></tr>
<tr><td><table width=100% border=0>
<tr>
    <td valign=top align=right class=form_title width=40%>Dispositivi di comando e regolazione funzionanti correttamente</td>
    <td valign=top><formwidget id="disp_comando">
        <formerror  id="disp_comando"><br>
        <span class="errori">@formerror.disp_comando;noquote@</span>
        </formerror>
    </td>
    </tr><tr>
    <td valign=top align=right class=form_title >Dispositivi di sicurezza non manomessi e/o cortocircuitati</td>
    <td valign=top><formwidget id="disp_sic_manom">
        <formerror  id="disp_sic_manom"><br>
        <span class="errori">@formerror.disp_sic_manom;noquote@</span>
        </formerror>
    </td>
    </tr><tr>
    <td valign=top align=right class=form_title>Valvola di sicurezza alla sovrapressione a scarico libero</td>
    <td valign=top><formwidget id="rct_valv_sicurezza">
        <formerror  id="rct_valv_sicurezza"><br>
        <span class="errori">@formerror.rct_valv_sicurezza;noquote@</span>
        </formerror>
    </td>
    </tr><tr>
    <td valign=top align=right class=form_title>Controllato e pulito scambiatore lato fumi</td>
    <td valign=top><formwidget id="rct_scambiatore_lato_fumi">
        <formerror  id="rct_scambiatore_lato_fumi"><br>
        <span class="errori">@formerror.rct_scambiatore_lato_fumi;noquote@</span>
        </formerror>
    </td>
    </tr><tr>
     <td valign=top align=right class=form_title>Presenza riflusso dei prodotti della combustione</td>
    <td valign=top><formwidget id="rct_riflussi_comb">
        <formerror  id="rct_riflussi_comb"><br>
        <span class="errori">@formerror.rct_riflussi_comb;noquote@</span>
        </formerror>
    </td>
    </tr><tr>
    <td valign=top align=right class=form_title>Risultati controllo secondo norma UNI 10389-1 conformi alla legge</td>
    <td valign=top><formwidget id="rct_uni_10389">
        <formerror  id="rct_uni_10389"><br>
        <span class="errori">@formerror.rct_uni_10389;noquote@</span>
        </formerror>
    </td>
    </tr>
<tr>
<!--<tr>-->
<!--    <td valign=top align=left class_form_title><strong>F. CONTROLLO DEL RENDIMENTO DI COMBUSTIONE</strong>-->
<!--        <formwidget id="cont_rend">-->
<!--        <formerror  id="eff_evac_fum"><br>-->
<!--        <span class="errori">@formerror.eff_evac_fum;noquote@</span>-->
<!--        </formerror>-->
<!--    </td>-->
<!--</tr>-->
</table>
    <if @coimtgen.regione@ eq "MARCHE">
      <table width=100% border=0>
     <tr>
     <td>&nbsp;</td>
     </tr>

     <tr>
     <td valign=top align=right class=form_title>Motivo compilazione REE: @ast;noquote@ </td><!--sim58 aggiuno campo cod_tprc-->
     <td valign=top align=left ><formwidget id="cod_tprc">
        <formerror  id="cod_tprc"><br>
        <span class="errori">@formerror.cod_tprc;noquote@</span>
        </formerror>
    </td>
    </tr>
</table >
</if>
<table width=100% border=0>
    <tr>
    <th valign=top align=left class=form_title width=40% scope="col">Controllo del rendimento di combustione</th>
    <if @coimtgen.regione@ eq "MARCHE">
      <td valign=top align=left colspan=1><formwidget id="cont_rend_gen">
<!--innes <a href="#" onclick="javascript:window.open('coimaimp-gest-help?caller=cont_rend', 'help', 'scrollbars=yes, esizable=yes, width=520, height=280').moveTo(110,140)"><strong>Vedi nota</strong></a>--> <!--gac07 aggiunto pop-up su richiesta delle Marche-->
        <formerror  id="cont_rend_gen"><br>
        <span class="errori">@formerror.cont_rend_gen;noquote@</span>
      </formerror>    </td>
    </if>
    <else>
      <td valign=top align=left colspan=1><formwidget id="cont_rend">
<!--innes <a href="#" onclick="javascript:window.open('coimaimp-gest-help?caller=cont_rend', 'help', 'scrollbars=yes, esizable=yes, width=520, height=280').moveTo(110,140)"><strong>Vedi nota</strong></a> --><!--gac07 aggiunto pop-up su richiesta delle Marche-->
        <formerror  id="cont_rend"><br>
        <span class="errori">@formerror.cont_rend;noquote@</span>
        </formerror>    </td>
    </else>
    </tr>
    <tr>
    <td colspan=2 color><strong><span style="color:blue"><formwidget id="warning_cont_rend"></span></strong><!--mat01-->
    <formerror  id="warning_cont_rend">
    <span class="errori">@formerror.warning_cont_rend;noquote@</span></td>
    </formerror>
    </tr>
    </table>
    </td>
</tr>
<tr><td colspan=2 width=100%><table border=0 cellspacing=0 cellpadding=0 width=100%>
    <tr>
 <td valign=top colspan=2 align=center class=form_title>Depressione canale da Fumo (Pa)
 <if @coimtgen.regione@ eq "MARCHE">
  <if @cont_rend@ eq "S">
     <if @tipo_comb@ eq "G" and @tiraggio@ eq "N">@ast;noquote@</if>
  </if>
 </if>
 <else>
 <if @cont_rend@ eq "S" and @conbustibile_solido@ eq "N">@ast;noquote@</if>
 </else>
 </td>
    <td colspan=10 valign=top align=left><formwidget id="tiraggio_fumi"><!--innes<a href="#" onclick="javascript:window.open('coimaimp-gest-help?caller=tiraggio-fumi', 'help', 'scrollbars=yes, esizable=yes, width=580, height=280').moveTo(110,140)"><strong>Vedi nota</strong></a>--> <!--gac07 aggiunto pop-up su richiesta delle Marche-->
        <formerror  id="tiraggio_fumi"><br>
        <span class="errori">@formerror.tiraggio_fumi;noquote@</span>
        </formerror>
    </td>
   </tr>
   <tr>
      <td valign=top align=center class=form_title>Portata combustibile<br>(m<small><sup>3</sup></small>/h oppure kg/h)</td>
      <td valign=top align=center class=form_title>Portata termica effettiva<br>(kW)</td>
      <td valign=top align=center class=form_title>Temp. fumi (&deg;C)
 <if @coimtgen.regione@ eq "MARCHE">
  <if @cont_rend@ eq "S">
     <if @combustibile@ eq "5" or @combustibile@ eq "8" or @combustibile@ eq "4" or @combustibile@ eq "9" or @combustibile@ eq "3" or @combustibile@ eq "1">@ast;noquote@</if>
  </if>
 </if>
 <else>
 <if @cont_rend@ eq "S" and @conbustibile_solido@ eq "N">@ast;noquote@</if><!-- mis01 -->
 </else>
</td>
      <td valign=top align=center class=form_title>Temp. aria<br> comb. (&deg;C)
 <if @coimtgen.regione@ eq "MARCHE">
  <if @cont_rend@ eq "S">
     <if @combustibile@ eq "5" or @combustibile@ eq "8" or @combustibile@ eq "4" or @combustibile@ eq "9" or @combustibile@ eq "3" or @combustibile@ eq "1">@ast;noquote@</if>
  </if>
 </if>
 <else>
 <if @cont_rend@ eq "S" and @conbustibile_solido@ eq "N">@ast;noquote@</if><!-- mis01 -->
 </else>
</td>
      <td valign=top align=center class=form_title>O<sub><small>2</small></sub>(%)
 <if @coimtgen.regione@ eq "MARCHE">
  <if @cont_rend@ eq "S">
     <if @combustibile@ eq "5" or @combustibile@ eq "8" or @combustibile@ eq "4" or @combustibile@ eq "9" or @combustibile@ eq "3" or @combustibile@ eq "1">@ast;noquote@</if>
  </if>
 </if>
 <else>
 <if @cont_rend@ eq "S" and @conbustibile_solido@ eq "N">@ast;noquote@</if>
 </else>
</td>
      <td valign=top align=center class=form_title>CO<sub><small>2</small></sub>(%)
 <if @coimtgen.regione@ eq "MARCHE">
  <if @cont_rend@ eq "S">
     <if @combustibile@ eq "5" or @combustibile@ eq "8" or @combustibile@ eq "4" or @combustibile@ eq "9" or @combustibile@ eq "3" or @combustibile@ eq "1">@ast;noquote@</if>
  </if>
 </if>
 <else>
 <if @cont_rend@ eq "S" and @conbustibile_solido@ eq "N">@ast;noquote@</if><!-- mis01 -->
 </else>
</td>
      <td valign=top align=center class=form_title>Bacharach (n.) <if @coimtgen.regione@ eq "MARCHE">
	                                                            <if @descr_comb@ eq "GASOLIO">
	                                                                 @ast;noquote@</if></if>
                                                                  <else>
	                                                            <if @flag_mod_gend@ eq "N" and @descr_combustibile@ eq "GASOLIO">
								         @ast;noquote@</if>
                                                                  </else></td><!-- mis01 -->
      <td valign=top align=center class=form_title>CO fumi secchi <br>(ppm)
       <if @coimtgen.regione@ eq "MARCHE">
  <if @cont_rend@ eq "S">
     <if @combustibile@ eq "5" or @combustibile@ eq "8" or @combustibile@ eq "4" or @combustibile@ eq "9" or @combustibile@ eq "3" or @combustibile@ eq "1">@ast;noquote@</if>
  </if>
 </if>
 <else>
 <if @cont_rend@ eq "S" and @conbustibile_solido@ eq "N">@ast;noquote@</if><!-- mis01 -->
 </else>
</td>

      <td valign=top align=center class=form_title>CO corretto. <br><!--@misura_co;noquote@-->(ppm)
 <if @coimtgen.regione@ eq "MARCHE">
  <if @cont_rend@ eq "S">
     <if @combustibile@ eq "5" or @combustibile@ eq "8" or @combustibile@ eq "4" or @combustibile@ eq "9" or @combustibile@ eq "3" or @combustibile@ eq "1">@ast;noquote@</if>
  </if>
 </if>
 <else>
 <if @cont_rend@ eq "S" and @conbustibile_solido@ eq "N">@ast;noquote@</if><!-- mis01 -->
 </else>
</td>

      <td valign=top align=center class=form_title>Rend.to di <br>combustione(%)
 <if @coimtgen.regione@ eq "MARCHE">
  <if @cont_rend@ eq "S">
     <if @combustibile@ eq "5" or @combustibile@ eq "8" or @combustibile@ eq "4" or @combustibile@ eq "9" or @combustibile@ eq "3" or @combustibile@ eq "1">@ast;noquote@</if>
  </if>
 </if>
 <else>
 <if @cont_rend@ eq "S" and @conbustibile_solido@ eq "N">@ast;noquote@</if><!-- mis01 -->
 </else>
<br><!-- mis01 --><!--innes<a href="#" onclick="javascript:window.open('coimaimp-gest-help?caller=rend_comb', 'help', 'scrollbars=yes, esizable=yes, width=520, height=280').moveTo(110,140)"><strong>Vedi nota</strong></a>--> <!--gac07 aggiunto pop-up su richiesta delle Marche-->
 
</td>
       <td valign=top align=center class=form_title>Rend.to combustione<br>minimo di legge (%)
 <if @coimtgen.regione@ eq "MARCHE">
  <if @cont_rend@ eq "S">
     <if @combustibile@ eq "5" or @combustibile@ eq "8" or @combustibile@ eq "4" or @combustibile@ eq "9" or @combustibile@ eq "3" or @combustibile@ eq "1">@ast;noquote@</if>
  </if>
 </if>
 <else>
 <if @cont_rend@ eq "S" and @conbustibile_solido@ eq "N">@ast;noquote@</if><!-- mis01 -->
 </else>
</td>
       <td valign=top align=center colspan=2 class=form_title>Modulo termico</td>
    </tr><tr>

<if @barra_ann@ ne "" and @portata_comb@ eq "" > <!-- rom04 if e suo contenuto -->
    <td valign=top align=center>@barra_ann@</td>
</if>
<else><!-- rom04 aggiunta else -->
    <td valign=top align=center><formwidget id="portata_comb">
        <formerror  id="portata_comb"><br>
        <span class="errori">@formerror.portata_comb;noquote@</span>
        </formerror>
    </td>
</else>
<if @barra_ann@ ne "" and  @portata_termica_effettiva@ eq ""> <!-- rom04 if e suo contenuto -->
    <td valign=top align=center>@barra_ann@</td>
</if>
<else><!-- rom04 aggiunta else -->
    <td valign=top align=center><formwidget id="portata_termica_effettiva">
        <formerror  id="portata_termica_effettiva"><br>
        <span class="errori">@formerror.portata_termica_effettiva;noquote@</span>
        </formerror>
    </td>
</else>
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

    <td valign=top align=center><formwidget id="bacharach">/
	<formwidget id="bacharach2">/
        <formwidget id="bacharach3">
        <formerror  id="bacharach"><br>
        <span class="errori">@formerror.bacharach;noquote@</span>
        </formerror>
    </td>
    <td valign=top align=center><formwidget id="co_fumi_secchi_ppm">
        <formerror  id="co_fumi_secchi_ppm"><br>
        <span class="errori">@formerror.co_fumi_secchi_ppm;noquote@</span>
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

    <td valign=top align=center><formwidget id="rct_rend_min_legge">
        <formerror  id="rct_rend_min_legge"><br>
        <span class="errori">@formerror.rct_rend_min_legge;noquote@</span>
        </formerror>
    </td>

    <td valign=top align=center><formwidget id="rct_modulo_termico">
        <formerror  id="rct_modulo_termico"><br>
        <span class="errori">@formerror.rct_modulo_termico;noquote@</span>
        </formerror>
    </td>
  
    </tr>

    <tr>
    <td colspan=7>&nbsp;@warning_co_corretto;noquote@</td>
       <td align=center colspan=2><formwidget id="warning_co_corretto">
          <formerror  id="warning_co_corretto">
              <span class="errori">@formerror.warning_co_corretto;noquote@</span>
          </formerror>
     </td>
   </tr>
</table></td>


</tr>

<!--rom01 aggiunto sezione multirow per prove fumi aggiuntive-->
<if @conta_prfumi ne 0>
<multiple name=multiple_form_prfumi>
<tr><td colspan=2 width=110%><table border=0 cellspacing=0 cellpadding=0 width=100%>
    <tr>
 <td valign=top colspan=2 align=center class=form_title>Depressione canale da Fumo (Pa)
 <if @coimtgen.regione@ eq "MARCHE">
  <if @cont_rend@ eq "S">
     <if @tipo_comb@ eq "G">@ast;noquote@</if>
  </if>
 </if>
 <else>
 <if @cont_rend@ eq "S" and @conbustibile_solido@ eq "N">@ast;noquote@</if>
 </else>
 </td>
    <td valign=top colspan=10 align=left><formwidget id="tiraggio_fumi.@multiple_form_prfumi.conta_prfumi;noquote@">
    <a href="#" onclick="javascript:window.open('coimaimp-gest-help?caller=tiraggio-fumi', 'help', 'scrollbars=yes, esizable=yes, width=580, height=280').moveTo(110,140)"><strong>Vedi nota</strong></a> <!--gac07 aggiunto pop-up su richiesta delle Marche-->
        <formerror  id="tiraggio_fumi.@multiple_form_prfumi.conta_prfumi;noquote@"><br>
        <span class="errori"><%= $formerror(tiraggio_fumi.@multiple_form_prfumi.conta_prfumi;noquote@) %></span>
        </formerror>
    </td>
   </tr><tr>
	<!--gac02-->
	<td valign=top align=center class=form_title>Portata combustibile<br>(m<small><sup>3</sup></small>/h oppure kg/h)</td>
	<td valign=top align=center class=form_title>Portata termica effettiva<br>(kW)</td>
      <td valign=top align=center class=form_title>Temp. fumi (&deg;C)
 <if @coimtgen.regione@ eq "MARCHE">
  <if @cont_rend@ eq "S">
     <if @combustibile@ eq "5" or @combustibile@ eq "8" or @combustibile@ eq "4" or @combustibile@ eq "9" or @combustibile@ eq "3" or @combustibile@ eq "1">@ast;noquote@</if>
  </if>
 </if>
 <else>
 <if @cont_rend@ eq "S" and @conbustibile_solido@ eq "N">@ast;noquote@</if><!-- mis01 -->
 </else>
</td>
      <td valign=top align=center class=form_title>Temp. aria<br> comb. (&deg;C)
 <if @coimtgen.regione@ eq "MARCHE">
  <if @cont_rend@ eq "S">
     <if @combustibile@ eq "5" or @combustibile@ eq "8" or @combustibile@ eq "4" or @combustibile@ eq "9" or @combustibile@ eq "3" or @combustibile@ eq "1">@ast;noquote@</if>
  </if>
 </if>
 <else>
 <if @cont_rend@ eq "S" and @conbustibile_solido@ eq "N">@ast;noquote@</if><!-- mis01 -->
 </else>
</td>
      <td valign=top align=center class=form_title>O<sub><small>2</small></sub>(%)
 <if @coimtgen.regione@ eq "MARCHE">
  <if @cont_rend@ eq "S">
     <if @combustibile@ eq "5" or @combustibile@ eq "8" or @combustibile@ eq "4" or @combustibile@ eq "9" or @combustibile@ eq "3" or @combustibile@ eq "1">@ast;noquote@</if>
  </if>
 </if>
 <else>
 <if @cont_rend@ eq "S" and @conbustibile_solido@ eq "N">@ast;noquote@</if><!-- mis01 -->
 </else>
</td>
      <td valign=top align=center class=form_title>CO<sub><small>2</small></sub>(%)
 <if @coimtgen.regione@ eq "MARCHE">
  <if @cont_rend@ eq "S">
     <if @combustibile@ eq "5" or @combustibile@ eq "8" or @combustibile@ eq "4" or @combustibile@ eq "9" or @combustibile@ eq "3" or @combustibile@ eq "1">@ast;noquote@</if>
  </if>
 </if>
 <else>
 <if @cont_rend@ eq "S" and @conbustibile_solido@ eq "N">@ast;noquote@</if><!-- mis01 -->
 </else>
</td>
      <td valign=top align=center class=form_title>Bacharach(n.) <if @coimtgen.regione@ eq "MARCHE">
	                                                            <if @descr_comb@ eq "GASOLIO">
	                                                                 @ast;noquote@</if></if>
                                                                  <else>
	                                                            <if @flag_mod_gend@ eq "N" and @descr_combustibile@ eq "GASOLIO">
								         @ast;noquote@</if>
                                                                  </else></td><!-- mis01 -->
      <td valign=top align=center class=form_title>CO fumi secchi<br> ppm
 <if @coimtgen.regione@ eq "MARCHE">
  <if @cont_rend@ eq "S">
     <if @combustibile@ eq "5" or @combustibile@ eq "8" or @combustibile@ eq "4" or @combustibile@ eq "9" or @combustibile@ eq "3" or @combustibile@ eq "1">@ast;noquote@</if>
  </if>
 </if>
 <else>
 <if @cont_rend@ eq "S" and @conbustibile_solido@ eq "N">@ast;noquote@</if><!-- mis01 -->
 </else>
      </td>

      <td valign=top align=center class=form_title>CO corretto. <br>(ppm)
 <if @coimtgen.regione@ eq "MARCHE">
  <if @cont_rend@ eq "S">
     <if @combustibile@ eq "5" or @combustibile@ eq "8" or @combustibile@ eq "4" or @combustibile@ eq "9" or @combustibile@ eq "3" or @combustibile@ eq "1">@ast;noquote@</if>
  </if>
 </if>
 <else>
 <if @cont_rend@ eq "S" and @conbustibile_solido@ eq "N">@ast;noquote@</if><!-- mis01 -->
 </else>
</td>
      <td valign=top align=center class=form_title>Rend.to di <br>combustione(%)
 <if @coimtgen.regione@ eq "MARCHE">
  <if @cont_rend@ eq "S">
     <if @combustibile@ eq "5" or @combustibile@ eq "8" or @combustibile@ eq "4" or @combustibile@ eq "9" or @combustibile@ eq "3" or @combustibile@ eq "1">@ast;noquote@</if>
  </if>
 </if>
 <else>
 <if @cont_rend@ eq "S" and @conbustibile_solido@ eq "N">@ast;noquote@</if><!-- mis01 -->
 </else>
<br><a href="#" onclick="javascript:window.open('coimaimp-gest-help?caller=rend_comb', 'help', 'scrollbars=yes, esizable=yes, width=520, height=280').moveTo(110,140)"><strong>Vedi nota</strong></a> <!--gac07 aggiunto pop-up su richiesta delle Marche-->
</td>
       <td valign=top align=center class=form_title>Rend.to combustione<br>minimo di legge(%)
 <if @coimtgen.regione@ eq "MARCHE">
  <if @cont_rend@ eq "S">
     <if @combustibile@ eq "5" or @combustibile@ eq "8" or @combustibile@ eq "4" or @combustibile@ eq "9" or @combustibile@ eq "3" or @combustibile@ eq "1">@ast;noquote@</if>
  </if>
 </if>
 <else>
 <if @cont_rend@ eq "S" and @conbustibile_solido@ eq "N">@ast;noquote@</if><!-- mis01 -->
 </else>
</td>
       <td valign=top align=center class=form_title>Modulo termico</td>
   </tr><tr>
<if @multiple_form_prfumi.barra;noquote@ eq "t"> <!-- rom04 if e suo contenuto -->
    <td valign=top align=center>@barra_ann@</td>
</if>
<else>
<td valign=top align=center><formwidget id="portata_comb.@multiple_form_prfumi.conta_prfumi;noquote@">
        <formerror  id="portata_comb.@multiple_form_prfumi.conta_prfumi;noquote@"><br>
        <span class="errori"><%= $formerror(portata_comb.@multiple_form_prfumi.conta_prfumi;noquote@) %></span>
        </formerror>
    </td>
</else>
<if @multiple_form_prfumi.barra2;noquote@ eq "t" > <!-- rom04 if e suo contenuto -->
    <td valign=top align=center>@barra_ann@</td>
</if>
<else>
    <td valign=top align=center><formwidget id="portata_termica_effettiva.@multiple_form_prfumi.conta_prfumi;noquote@">
           <formerror  id="portata_termica_effettiva.@multiple_form_prfumi.conta_prfumi;noquote@"><br>
           <span class="errori"><%= $formerror(portata_termica_effettiva.@multiple_form_prfumi.conta_prfumi;noquote@) %></span>
           </formerror>
    </td>
</else>
    <td valign=top align=center><formwidget id="temp_fumi.@multiple_form_prfumi.conta_prfumi;noquote@">
        <formerror  id="temp_fumi.@multiple_form_prfumi.conta_prfumi;noquote@"><br>
        <span class="errori"><%= $formerror(temp_fumi.@multiple_form_prfumi.conta_prfumi;noquote@) %></span>
        </formerror>
    </td>

    <td valign=top align=center><formwidget id="temp_ambi.@multiple_form_prfumi.conta_prfumi;noquote@">
        <formerror  id="temp_ambi.@multiple_form_prfumi.conta_prfumi;noquote@"><br>
        <span class="errori"><%= $formerror(temp_ambi.@multiple_form_prfumi.conta_prfumi;noquote@) %></span>
        </formerror>
    </td>
    
    <td valign=top align=center><formwidget id="o2.@multiple_form_prfumi.conta_prfumi;noquote@">
        <formerror  id="o2.@multiple_form_prfumi.conta_prfumi;noquote@"><br>
        <span class="errori"><%= $formerror(o2.@multiple_form_prfumi.conta_prfumi;noquote@) %></span>
        </formerror>
    </td>
    
    <td valign=top align=center><formwidget id="co2.@multiple_form_prfumi.conta_prfumi;noquote@">
        <formerror  id="co2.@multiple_form_prfumi.conta_prfumi;noquote@"><br>
        <span class="errori"><%= $formerror(co2.@multiple_form_prfumi.conta_prfumi;noquote@) %></span>
        </formerror>
    </td>

    <td valign=top align=center><formwidget id="bacharach.@multiple_form_prfumi.conta_prfumi;noquote@">/
	<formwidget id="bacharach2.@multiple_form_prfumi.conta_prfumi;noquote@">/
	<formwidget id="bacharach3.@multiple_form_prfumi.conta_prfumi;noquote@">
        <formerror  id="bacharach.@multiple_form_prfumi.conta_prfumi;noquote@"><br>
        <span class="errori"><%= $formerror(bacharach.@multiple_form_prfumi.conta_prfumi;noquote@) %></span>
        </formerror>
    </td>

    <td valign=top align=center><formwidget id="co_fumi_secchi_ppm.@multiple_form_prfumi.conta_prfumi;noquote@">
        <formerror  id="co_fumi_secchi_ppm.@multiple_form_prfumi.conta_prfumi;noquote@"><br>
        <span class="errori"><%= $formerror(co_fumi_secchi_ppm.@multiple_form_prfumi.conta_prfumi;noquote@) %></span>
        </formerror>
    </td>

    <td valign=top align=center><formwidget id="co.@multiple_form_prfumi.conta_prfumi;noquote@">
        <formerror  id="co.@multiple_form_prfumi.conta_prfumi;noquote@"><br>
        <span class="errori"><%= $formerror(co.@multiple_form_prfumi.conta_prfumi;noquote@) %></span>
        </formerror>
    </td>

    <td valign=top align=center><formwidget id="rend_combust.@multiple_form_prfumi.conta_prfumi;noquote@">
        <formerror  id="rend_combust.@multiple_form_prfumi.conta_prfumi;noquote@"><br>
        <span class="errori"><%= $formerror(rend_combust.@multiple_form_prfumi.conta_prfumi;noquote@) %></span>
        </formerror>
    </td>

    <td valign=top align=center><formwidget id="rct_rend_min_legge.@multiple_form_prfumi.conta_prfumi;noquote@">
        <formerror  id="rct_rend_min_legge.@multiple_form_prfumi.conta_prfumi;noquote@"><br>
        <span class="errori"><%= $formerror(rct_rend_min_legge.@multiple_form_prfumi.conta_prfumi;noquote@) %></span>
        </formerror>
    </td>

    <td valign=top align=center><formwidget id="rct_modulo_termico.@multiple_form_prfumi.conta_prfumi;noquote@">
        <formerror  id="rct_modulo_termico.@multiple_form_prfumi.conta_prfumi;noquote@"><br>
        <span class="errori"><%= $formerror(rct_modulo_termico.@multiple_form_prfumi.conta_prfumi;noquote@) %></span>
        </formerror>
    </td>
</tr>
<tr>
  <td colspan=7>&nbsp;</td>
  <td align=center colspan=2><formwidget id="warning_co_corretto.@multiple_form_prfumi.conta_prfumi;noquote@">
      <formerror  id="warning_co_corretto.@multiple_form_prfumi.conta_prfumi;noquote@">
	<span class="errori"><%= $formerror.(warning_co_corretto.@multiple_form_prfumi.conta_prfumi;noquote@) %></span>
      </formerror>
  </td>
</tr>
    </tr></table></td>
    

 </tr>
</multiple>
</if>
<tr><td colspan=2 width=100%>	
<table width=100% border=0>
<tr>
    <td valign=top  align=left class=form_title><label for="rispetta_indice_bacharach">Rispetta l'indice di Bacharach?</label></td>
    <td valign=top align=left><formwidget id="rispetta_indice_bacharach">
        <formerror  id="rispetta_indice_bacharach"><br>
        <span class="errori">@formerror.rispetta_indice_bacharach;noquote@</span>
        </formerror>
    </td>
    <td valign=top align=right class=form_title>CO fumi secchi e senz'aria <=1.000 ppm v/v
<if @coimtgen.regione@ eq "MARCHE">
   <if @cont_rend@ eq "S">
     <if @combustibile@ eq "5" or @combustibile@ eq "8" or @combustibile@ eq "4" or @combustibile@ eq "9" or @combustibile@ eq "3" or @combustibile@ eq "1">@ast;noquote@</if>
   </if>
</if>
<else>
   <if @cont_rend@ eq "S" and @conbustibile_solido@ eq "N">@ast;noquote@</if><!-- mis01 -->
</else>
    </td>
    <td valign=top align=left><formwidget id="co_fumi_secchi">
        <formerror  id="co_fumi_secchi"><br>
        <span class="errori">@formerror.co_fumi_secchi;noquote@</span>
        </formerror>
    </td>
    <td valign=top align=right class=form_title>Rendimento >= rendimento minimo
<if @coimtgen.regione@ eq "MARCHE">
   <if @cont_rend@ eq "S">
     <if @combustibile@ eq "5" or @combustibile@ eq "8" or @combustibile@ eq "4" or @combustibile@ eq "9" or @combustibile@ eq "3" or @combustibile@ eq "1">@ast;noquote@</if>
   </if>
</if>
<else>
   <if @cont_rend@ eq "S" and @conbustibile_solido@ eq "N">@ast;noquote@</if><!-- mis01 -->
</else>
</td>
    <td valign=top align=left><formwidget id="rend_magg_o_ugua_rend_min">
        <formerror  id="rend_magg_o_ugua_rend_min"><br>
        <span class="errori">@formerror.rend_magg_o_ugua_rend_min;noquote@</span>
        </formerror>
    </td>
</tr>
<tr>
  <td>&nbsp;</td>
</tr>
<if @coimtgen.regione@ eq "MARCHE"><!--gac06 aggiunta if e suo contenuto-->
<tr>
<td colspan=2 valign=top  align=left class=form_title><strong>Strumenti utilizzati per i controlli</strong></td>
<td valign=top align=right class=form_title>Analizzatore <if @coimtgen.regione@ eq "MARCHE">
   <if @cont_rend@ eq "S">
     <if @combustibile@ eq "5" or @combustibile@ eq "8" or @combustibile@ eq "4" or @combustibile@ eq "9" or @combustibile@ eq "3" or @combustibile@ eq "1">@ast;noquote@</if>
   </if>
</if>
<else>
   <if @cont_rend@ eq "S" and @conbustibile_solido@ eq "N">@ast;noquote@</if><!-- mis01 -->
</else>
</td>
<td align=left valign=top>
  <formwidget id="cod_strumento_01">
    <formerror  id="cod_strumento_01"><br>
      <span class="errori">@formerror.cod_strumento_01;noquote@</span>
    </formerror>
</td>
<td valign=top align=right class=form_title>Deprimometro</td>
<td align=left valign=top>  <formwidget id="cod_strumento_02">
    <formerror  id="cod_strumento_02"><br>
      <span class="errori">@formerror.cod_strumento_02;noquote@</span>
    </formerror>
</td>
</tr>
</if>
</table>
</td>
</tr>
<!-- gac03 -->
<tr>
<td align=center>
<formwidget id="warning_portata">
<formerror  id="warning_portata">
<span class="errori">@formerror.warning_portata;noquote@</span>
 </formerror>
</td>
</tr>
 <th valign=top align=left class=form_title scope="col">F.CHECK-LIST</th>
 <tr> </tr>
  <td valign=top align=left class=form_title>Elenco dei possibili interventi dei quali va valuta la convenienza economica , che qualora applicabili potrebbero
                                            comportare un miglioramento della prestazione energetica</td>
 </tr>
 <tr><td colspan=2 align=left><table border=0 cellspacing=0 cellpadding=0 border=0>
    <tr>
    <td valign=top align=left class=form_title>Adozione di valvole termostatiche sui corpi scaldanti</td>
    <td valign=top><formwidget id="rct_check_list_1">
        <formerror  id="rct_check_list_1"><br>
        <span class="errori">@formerror.rct_check_list_1;noquote@</span>
        </formerror>
    </td>
    </tr><tr>
</tr><tr>
    <td valign=top align=left class=form_title>Isolamento della rete di distribuzione nei locali non riscaldati</td>
    <td valign=top><formwidget id="rct_check_list_2">
        <formerror  id="rct_check_list_2"><br>
        <span class="errori">@formerror.rct_check_list_2;noquote@</span>
        </formerror>
    </td>
    </tr><tr>
</tr><tr>
    <td valign=top align=left class=form_title>Introduzione di un sistema di trattamento dell'acqua sanitaria e per riscaldamento ove assente</td>
    <td valign=top><formwidget id="rct_check_list_3">
        <formerror  id="rct_check_list_3"><br>
        <span class="errori">@formerror.rct_check_list_3;noquote@</span>
        </formerror>
    </td>
    </tr><tr>
</tr><tr>
    <td valign=top align=left class=form_title>Sostituzione di un sistema di regolazione on/off con un sistema programmabile su piu' livelli di temperatura</td>
    <td valign=top><formwidget id="rct_check_list_4">
        <formerror  id="rct_check_list_4"><br>
        <span class="errori">@formerror.rct_check_list_4;noquote@</span>
        </formerror>
    </td>
    </tr><tr>
 </tr></table></td>

<tr>
    <td><table border=0><tr>
           <td valign=bottom align=left class=form_title><strong>Osservazioni</strong><br><!--<a href="#" onclick="javascript:window.open('coimaimp-gest-help?caller=osservaz', 'help', 'scrollbars=yes, esizable=yes, width=580, height=380').moveTo(110,140)"><strong>Vedi nota</strong></a>--> <!--gac07 aggiunto pop-up su richiesta delle Marche--></td>
         </tr>
         <tr>
           <td valign=top><formwidget id="osservazioni">
               <formerror  id="osservazioni"><br>
               <span class="errori">@formerror.osservazioni;noquote@</span>
               </formerror>

           </td>
         </tr>
         <tr>
             <td valign=bottom align=left class=form_title><strong>Raccomandazioni</strong><br><!--innes<a href="#" onclick="javascript:window.open('coimaimp-gest-help?caller=raccomandaz', 'help', 'scrollbars=yes, esizable=yes, width=580, height=380').moveTo(110,140)"><strong>Vedi nota</strong></a>--> <!--gac07 aggiunto pop-up su richiesta delle Marche--></td>
         </tr>
         <tr>
            <td valign=top><formwidget id="raccomandazioni">
                <formerror  id="raccomandazioni"><br>
                <span class="errori">@formerror.raccomandazioni;noquote@</span>
                </formerror>
            </td>
         </tr>
         <tr>
            <td valign=top align=left class=form_title><strong>Prescrizioni</strong><br><!--<a href="#" onclick="javascript:window.open('coimaimp-gest-help?caller=prescriz', 'help', 'scrollbars=yes, esizable=yes, width=580, height=380').moveTo(110,140)"><strong>Vedi nota</strong></a>--> <!--gac07 aggiunto pop-up su richiesta delle Marche--></td>
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

<!--gac06 commentato per tutti gli enti
<tr>
    <td><table border=0><tr>
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

<tr><td align=right><table border=0 width="100%">
    <tr>
        <td valign=top align=right class=form_title>Data utile interv.</td>
        <td valign=top class=form_title>Anomalia</td>
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
    </tr>
    </multiple>
</table></td></tr>-->
<tr><td><table border=0 width="100%"><tr>
<tr>
    <td width="40%" valign=top align=right class=form_title><strong>L'impianto pu&ograve; funzionare
    <td width="10%" valign=top>  
        <if @vis_desc_contr@ eq f>
                <formwidget id="flag_status">
                <formerror  id="flag_status"><br>
                <span class="errori">@formerror.flag_status;noquote@</span>
                </formerror>
        </if>
        <else>
                <formwidget id="flag_stat">
                <formerror  id="flag_stat"><br>
                <span class="errori">@formerror.flag_stat;noquote@</span>
                </formerror>
        </else>
    </td>
    <td width="30%" valign=top align=right class=form_title>Data scadenza dichiarazione</td>
    <td width="20%" valign=top><formwidget id="data_scadenza_autocert">
        <formerror  id="data_scadenza_autocert"><br>
        <span class="errori">@formerror.data_scadenza_autocert;noquote@</span>
        </formerror>
    </td>
</tr>
</table></td></tr>
<tr><td colspan=2>&nbsp;</td></tr>
<tr><td><table border=0>
<if @coimtgen.regione@ ne "MARCHE">
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
</if>
</table></td></tr>	
<tr><td><table border=0>
<tr>
<if @coimtgen.regione@ ne "MARCHE">
    <td valign=top align=right class=form_title>Tipologia Costo</td>
    <td valign=top><formwidget id="tipologia_costo">
        <formerror  id="tipologia_costo"><br>
        <span class="errori">@formerror.tipologia_costo;noquote@</span>
        </formerror>
    </td>
</if>
<else>
<formwidget   id="tipologia_costo">
</else>
    <td valign=top align=right class=form_title nowrap width=25%>Costo del segno identificativo<if @esente@ eq "f">
                                                                  <if @tipologia_costo@ ne "" or @flag_pagato@ eq "S">
                                                                    @ast;noquote@</if></if></td><!-- mis01 -->
    <td valign=top><formwidget id="costo">&#8364;
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
</tr>
<tr>
  <if @coimtgen.regione@ ne "MARCHE"><!--gac01-->
    <td valign=top align=right class=form_title>Pagato</td>
    <td valign=top><formwidget id="flag_pagato">
        <formerror  id="flag_pagato"><br>
          <span class="errori">@formerror.flag_pagato;noquote@</span>
        </formerror>
    </td>
  </if>
  <else>
    <td valign=top align=right class=form_title>Segno identificativo pagato <span style="color:red">*</span></td><!--mat01--><!--gac01-->
    <td valign=top colspan=3><formwidget id="flag_pagato">
	<!--innes<a href="#" onclick="javascript:window.open('coimaimp-gest-help?caller=flag-pag', 'help', 'scrollbars=yes, esizable=yes, width=580, height=380').moveTo(110,140)"><strong>Vedi nota</strong></a>--> <!--gac01 aggiunto pop-up su richiesta delle Marche-->
        <formerror  id="flag_pagato"><br>
          <span class="errori">@formerror.flag_pagato;noquote@</span>
        </formerror>
    </td>
  </else>
</tr>

<!--gac07 sandro mi ha detto di toglierlo su tutti gli enti    <tr>
        <td valign=top align=right class=form_title>Data scad. pagamento</td>
        <td valign=top><formwidget id="data_scad_pagamento">
            <formerror  id="data_scad_pagamento"><br>
            <span class="errori">@formerror.data_scad_pagamento;noquote@</span>
            </formerror>
        </td>
     </tr>
-->
<if @coimtgen.regione@ eq "MARCHE"><!-- gac07 -->
  <tr>
    <td valign=top align=right class=form_title nowrap>Data del controllo <span style="color:red">*</span></td><!--mat01-->
    <td  valign=top><formwidget id="data_controllo">
        <formerror  id="data_controllo"><br>
        <span class="errori">@formerror.data_controllo;noquote@</span>
        </formerror>
    </td>

    <td valign=top align=right class=form_title>Orario di arrivo presso l'impianto @ast;noquote@</td><!-- mis01 -->
    <td  valign=top><formwidget id="ora_inizio">
        <formerror  id="ora_inizio"><br>
        <span class="errori">@formerror.ora_inizio;noquote@</span>
        </formerror>
    </td>

    <td valign=top align=right class=form_title>Orario di partenza dall'impianto @ast;noquote@</td><!-- mis01 -->
    <td  valign=top><formwidget id="ora_fine">
        <formerror  id="ora_fine"><br>
        <span class="errori">@formerror.ora_fine;noquote@</span>
        </formerror>
    </td>
  </tr>
  </if>
<tr>
  <if @coimtgen.regione@ eq "MARCHE">
    <td valign=top align=right class=form_title nowrap>Data ultima manutenzione ordinaria effettuata @ast_CANCONA;noquote@</td><!--gac07 -->
    <td><formwidget id="data_ultima_manu">
	<formerror  id="data_ultima_manu"><br>
	  <span class="errori">@formerror.data_ultima_manu;noquote@</span>
	</formerror>
    </td>
    </if>
<td valign=top align=right class=form_title nowrap>Si raccomanda un intervento manutentivo entro il @ast_CANCONA;noquote@</td>
        <td><formwidget id="data_prox_manut">
            <formerror  id="data_prox_manut"><br>
            <span class="errori">@formerror.data_prox_manut;noquote@</span>
            </formerror>
        </td>
    </tr></table></td>
</tr>
<tr><td valign=top colspan=2 align=center><formwidget id="msg_rcee">
	<formerror  id="msg_rcee"><br>
            <span class="errori">@formerror.msg_rcee;noquote@</span>
	</formerror>
  </td>
</tr>

<if @funzione@ ne "V">
    <tr><td colspan=1 align=center><formwidget id="submit"></td></tr>
</if>
<else><!--mat01 aggiunto else e contenuto-->
		<tr style="display:none;"><td colspan=1 align=center><formwidget id="submit"></td></tr>

</else>
<!-- Fine della form colorata -->
<%=[iter_form_fine]%>

</formtemplate>
<!--mat01<p>-->
<script><!--mat01 aggiunto script-->
  document.addEventListener("DOMContentLoaded", function() {
      document.querySelectorAll("form input, form textarea, form select").forEach(function(el) {
            el.setAttribute("autocomplete", "off");
      });
  });
</script>


<script>
  document.addEventListener("DOMContentLoaded", function () {
      const tables = document.querySelectorAll("table");

    tables.forEach(function (table) {
          const rows = table.querySelectorAll("tr");

      for (let rowIndex = 0; rowIndex < rows.length; rowIndex++) {
              const currentRow = rows[rowIndex];
	              const titleTds = currentRow.querySelectorAll("td.form_title");

        titleTds.forEach(function (titleTd, columnIndex) {
	          // Salta se già etichettato
		            if (titleTd.querySelector("label")) return;

          let input = null;

          // 1. Prova a trovare input nel td accanto nella stessa riga
	            const siblingTd = titleTd.nextElementSibling;
		              if (siblingTd) {
			                  input = siblingTd.querySelector("[id]");
					            }

          // 2. Se non trovato, cerca nella stessa colonna del tr successivo
	            if (!input && rowIndex + 1 < rows.length) {
		                const nextRow = rows[rowIndex + 1];
				            const nextTds = nextRow.querySelectorAll("td");
					                if (nextTds[columnIndex]) {
							              input = nextTds[columnIndex].querySelector("[id]");
								                  }
										            }

          if (input && input.id) {
	              const label = document.createElement("label");
		                  label.setAttribute("for", input.id);

            while (titleTd.firstChild) {
	                  label.appendChild(titleTd.firstChild);
			              }

            titleTd.appendChild(label);
	              }
		              });
			            }
				        });
					  });
</script>


<!--mat01</center>-->
</div><!--mat01-->

