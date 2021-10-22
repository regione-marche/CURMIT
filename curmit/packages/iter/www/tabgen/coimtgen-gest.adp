<master   src="../master">
<property name="title">@page_title;noquote@</property>
<property name="context_bar">@context_bar;noquote@</property>
<property name="riga_vuota">f</property>

<table width=100% cellspacing=0 class=func-menu>
<tr>
   <if @funzione@ eq "I">
      <td width="100%" class=func-menu>&nbsp;</td>
   </if>
   <else>
      <td width="50%" class=@func_v;noquote@>
         <a href="coimtgen-gest?funzione=V&@link_gest;noquote@" class=@func_v;noquote@>Visualizza</a>
      </td>
      <td width="50%" class=@func_m;noquote@>
         <a href="coimtgen-gest?funzione=M&@link_gest;noquote@" class=@func_m;noquote@>Modifica</a>
      </td>
   </else>
</tr>
</table>

<center>
<formtemplate id="@form_name;noquote@">
<formwidget   id="funzione">
<formwidget   id="caller">
<formwidget   id="nome_funz">
<formwidget   id="extra_par">
<formwidget   id="last_cod_tgen">
<formwidget   id="cod_tgen">

<!-- Inizio della form colorata -->
<%=[iter_form_iniz]%>
<tr><td valign=center nowrap align=right class=form_title>Tipo ente</td>
    <td valign=center><formwidget id="flag_ente">
    </td>

    <td valign=center align=right class=form_title>Provincia</td>
    <td valign=center><formwidget id="sigla_prov">
    </td>
</tr>

<tr><td valign=center align=right class=form_title>Comune</td>
    <td valign=center colspan=3><formwidget id="desc_comu">
    </td>
</tr>

<tr><td valign=center align=right class=form_title>Presenza del viario</td>
    <td valign=center colspan=3 nowrap><formwidget id="flag_viario">
    </td>
</tr>

<tr><td valign=center nowrap align=right class=form_title>Validit&agrave; allegati (mesi)</td>
    <td valign=center><formwidget id="valid_mod_h">
        <formerror  id="valid_mod_h"><br>
        <span class="errori">@formerror.valid_mod_h;noquote@</span>
        </formerror>
    </td>
    <td valign=center nowrap align=right class=form_title>Max GG comunicazione allegati</td>
    <td valign=center><formwidget id="gg_comunic_mod_h">
        <formerror  id="gg_comunic_mod_h"><br>
        <span class="errori">@formerror.gg_comunic_mod_h;noquote@</span>
        </formerror>
    </td>
</tr>

<tr>
    <td valign=center nowrap align=right class=form_title>Codice via automatico</td>
    <td valign=center><formwidget id="flag_cod_via_auto">
        <formerror  id="flag_cod_via_auto"><br>
        <span class="errori">@formerror.flag_cod_via_auto;noquote@</span>
        </formerror>
    </td>
</tr>

<tr><td valign=center nowrap align=right class=form_title>GG conferma incontro</td>
    <td valign=center><formwidget id="gg_conferma_inco">
        <formerror  id="gg_conferma_inco"><br>
        <span class="errori">@formerror.gg_conferma_inco;noquote@</span>
        </formerror>
    </td>
    <td valign=center nowrap align=right class=form_title>GG scadenza pagamento dichiarazione</td>
    <td valign=center><formwidget id="gg_scad_pag_mh">
        <formerror  id="gg_scad_pag_mh"><br>
        <span class="errori">@formerror.gg_scad_pag_mh;noquote@</span>
        </formerror>
    </td>
</tr>
<tr><td valign=center nowrap align=right class=form_title>Mesi per evidenza modifica</td>
    <td valign=center><formwidget id="mesi_evidenza_mod">
        <formerror  id="mesi_evidenza_mod"><br>
        <span class="errori">@formerror.mesi_evidenza_mod;noquote@</span>
        </formerror>
    </td>
    <td valign=center nowrap align=right class=form_title>GG scadenza pagamento<br> rapporti ispezione</td>
    <td valign=center><formwidget id="gg_scad_pag_rv">
        <formerror  id="gg_scad_pag_rv"><br>
        <span class="errori">@formerror.gg_scad_pag_rv;noquote@</span>
        </formerror>
    </td>
</tr>
<tr><td valign=center nowrap align=right class=form_title>Aggiornamento automatico dei<br>soggetti dell'impianto da RCT</td>
    <td valign=middle><formwidget id="flag_agg_sogg">
        <formerror id="flag_agg_sogg"><br>
        <span class="errori">@formerror.flag_agg_sogg;noquote@</span>
        </formerror>
    </td>
    <td valign=center nowrap align=right class=form_title>Aggiornamento automatico del<br>responsabile, combustibile e potenza<br>dell'impianto da Rapporto di Ispezione</td>
    <td valign=middle><formwidget id="flag_agg_da_verif">
        <formerror  id="flag_agg_da_verif"><br>
        <span class="errori">@formerror.flag_agg_da_verif;noquote@</span>
        </formerror>
    </td>
</tr>
<tr><td valign=center nowrap align=right class=form_title>Inserimenti scadenze</td>
    <td valign=center><formwidget id="flag_dt_scad">
        <formerror  id="flag_dt_scad"><br>
        <span class="errori">@formerror.flag_dt_scad;noquote@</span>
        </formerror>
    </td>
    <td valign=center nowrap align=right class=form_title>Codice impianti automatico</td>
    <td valign=center><formwidget id="flag_cod_aimp_auto">
        <formerror  id="flag_cod_aimp_auto"><br>
        <span class="errori">@formerror.flag_cod_aimp_auto;noquote@</span>
        </formerror>
    </td>
</tr>
<tr><td valign=center nowrap align=right class=form_title>Giorni entro i quali si pu&ograve;<br>modificare un RCT</td>
    <td valign=center><formwidget id="flag_gg_modif_mh">
        <formerror  id="flag_gg_modif_mh"><br>
        <span class="errori">@formerror.flag_gg_modif_mh;noquote@</span>
        </formerror>
    </td>
    <td valign=center nowrap align=right class=form_title>Giorni entro i quali si pu&ograve;<br>modificare un rapporto di ispezione</td>
    <td valign=center><formwidget id="flag_gg_modif_rv">
        <formerror  id="flag_gg_modif_rv"><br>
        <span class="errori">@formerror.flag_gg_modif_rv;noquote@</span>
        </formerror>
    </td>
</tr>

<tr><td valign=center nowrap align=right class=form_title>Inserimento obligatorio della scadenza<br>per la sistemazione delle anomalie</td>
    <td valign=center><formwidget id="gg_adat_anom_oblig">
        <formerror  id="gg_adat_anom_oblig"><br>
        <span class="errori">@formerror.gg_adat_anom_oblig;noquote@</span>
        </formerror>
    </td>
    <td valign=center nowrap align=right class=form_title>Creazione automatica della scadenza<br>per la sistemazione delle anomalie</td>
    <td valign=center><formwidget id="gg_adat_anom_autom">
        <formerror  id="gg_adat_anom_outom"><br>
        <span class="errori">@formerror.gg_adat_anom_autom;noquote@</span>
        </formerror>
    </td>
</tr>

<tr><td valign=center nowrap align=right class=form_title>Popolazione anagrafica dell'ente</td>
    <td valign=center><formwidget id="popolaz_citt_tgen">
        <formerror  id="popolaz_citt_tgen"><br>
        <span class="errori">@formerror.popolaz_citt_tgen;noquote@</span>
        </formerror>
    </td>
    <td valign=center nowrap align=right class=form_title>Popolazione di impianti<br>dell'ente (@conta_impianti;noquote@)</td>
    <td valign=center><formwidget id="popolaz_aimp_tgen">
        <formerror  id="popolaz_aimp_tgen"><br>
        <span class="errori">@formerror.popolaz_aimp_tgen;noquote@</span>
        </formerror>
    </td>
</tr>

<tr><td valign=center nowrap align=right class=form_title>Parametro per il calcolo<br> della statistica estrazioni</td>
    <td valign=center><formwidget id="flag_aimp_citt_estr">
        <formerror  id="flag_aimp_citt_estr"><br>
        <span class="errori">@formerror.flag_aimp_citt_estr;noquote@</span>
        </formerror>
    </td>
    <td valign=center nowrap align=right class=form_title>Calcolo della statistica estrazioni</td>
    <td valign=center><formwidget id="flag_stat_estr_calc">
        <formerror  id="flag_stat_estr_calc"><br>
        <span class="errori">@formerror.flag_stat_estr_calc;noquote@</span>
        </formerror>
    </td>
</tr>

<tr><td valign=center nowrap align=right class=form_title>Link ricerca CAP</td>
    <td valign=center colspan=3><formwidget id="link_cap">
        <formerror  id="link_cap"><br>
        <span class="errori">@formerror.link_cap;noquote@</span>
        </formerror>
    </td>
</tr>

<tr><td valign=center nowrap align=right class=form_title>Utilizzo enti competenti<br> per esiti di ispezione</td>
    <td valign=center><formwidget id="flag_enti_compet">
        <formerror  id="flag_enti_compet"><br>
        <span class="errori">@formerror.flag_enti_compet;noquote@</span>
        </formerror>
    </td>
    <td valign=center nowrap align=right class=form_title>Sfondo col logo dell'ente</td>
    <td valign=center><formwidget id="flag_master_ente">
        <formerror  id="flag_master_ente"><br>
        <span class="errori">@formerror.flag_master_ente;noquote@</span>
        </formerror>
    </td>
</tr>

<tr><td valign=center nowrap align=right class=form_title>Codice impianto creato secondo<br> standard della regione</td>
    <td valign=center><formwidget id="flag_codifica_reg">
        <formerror  id="flag_codifica_reg"><br>
        <span class="errori">@formerror.flag_codifica_reg;noquote@</span>
        </formerror>
    </td>
    <td valign=center nowrap align=right class=form_title>Conteggio automatico pesi all'inserimento<br> di un modello g/h</td>
    <td valign=center><formwidget id="flag_pesi">
        <formerror  id="flag_pesi"><br>
        <span class="errori">@formerror.flag_pesi;noquote@</span>
        </formerror>
    </td>
</tr>

<tr><td valign=center nowrap align=right class=form_title>Sanzioni per rapporti di verifica non a norma</td>
    <td valign=center><formwidget id="flag_sanzioni">
        <formerror  id="flag_sanzioni"><br>
        <span class="errori">@formerror.flag_sanzioni;noquote@</span>
        </formerror>
    </td>
    <td valign=center nowrap align=right class=form_title>Stampa avviso e stampa esito da predisposizione<br> controlli richiama modelli di stampa</td>
    <td valign=center><formwidget id="flag_avvisi">
        <formerror  id="flag_avvisi"><br>
        <span class="errori">@formerror.flag_avvisi;noquote@</span>
        </formerror>
    </td>
</tr>
<tr><td valign=center nowrap align=right class=form_title>Modifica campi generatore da<br>inserimento/modifica modello</td>
    <td valign=center><formwidget id="flag_mod_gend">
        <formerror  id="flag_mod_gend"><br>
        <span class="errori">@formerror.flag_mod_gend;noquote@</span>
        </formerror>
    </td>
    <td valign=center nowrap align=right class=form_title>Visualizza data inizio assegn. (per chi usa l'agenda)</td>
    <td valign=center><formwidget id="flag_asse_data">
        <formerror  id="flag_asse_data"><br>
        <span class="errori">@formerror.flag_asse_data;noquote@</span>
        </formerror>
    </td>
</tr>
<tr><td valign=center nowrap align=right class=form_title>Controllo tipo di canna fumaria<br>su modello obbligatorio</td>
    <td valign=center><formwidget id="flag_obbligo_canne">
        <formerror  id="flag_obbligo_canne"><br>
        <span class="errori">@formerror.flag_obbligo_canne;noquote@</span>
        </formerror>
    </td>
    <td valign=center nowrap align=right class=form_title>Default controllo fumi su modello</td>
    <td valign=center><formwidget id="flag_default_contr_fumi">
        <formerror  id="flag_default_contr_fumi"><br>
        <span class="errori">@formerror.flag_default_contr_fumi;noquote@</span>
        </formerror>
    </td>
</tr>
<tr><td valign=center nowrap align=right class=form_title>Stato annullato dell'impianto<br>(limitazione manutentori)</td>
    <td valign=center><formwidget id="cod_imst_annu_manu">
        <formerror  id="cod_imst_annu_manu"><br>
        <span class="errori">@formerror.cod_imst_annu_manu;noquote@</span>
        </formerror>
    </td>
    <td valign=center nowrap align=right class=form_title>Giorni massimi modifica stato impianti (manut.)</td>
    <td valign=center><formwidget id="max_gg_modimp">
        <formerror  id="max_gg_modimp"><br>
        <span class="errori">@formerror.max_gg_modimp;noquote@</span>
        </formerror>
    </td>
</tr>
<tr><td valign=center nowrap align=right class=form_title>Stato con cui vengono importati<br>gli impianti da caric. manut.</td>
    <td valign=center><formwidget id="cod_imst_cari_manu">
        <formerror  id="cod_imst_cari_manu"><br>
        <span class="errori">@formerror.cod_imst_cari_manu;noquote@</span>
        </formerror>
    </td>
    <td valign=center nowrap align=right class=form_title>N. bollino obbligatorio per tipo pag. 'bollino prepagato'</td>
    <td valign=center><formwidget id="flag_bollino_obb">
        <formerror  id="flag_bollino_obb"><br>
        <span class="errori">@formerror.flag_bollino_obb;noquote@</span>
        </formerror>
    </td>
</tr>
<tr><td valign=center nowrap align=right class=form_title>Inserisci un messaggio di preavviso<br>per insufficienza credito</td>
    <td valign=center><formwidget id="flag_limite_portaf">
        <formerror  id="flag_limite_portaf"><br>
        <span class="errori">@formerror.flag_limite_portaf;noquote@</span>
        </formerror>
    </td>
    <td valign=center nowrap align=right class=form_title>Valore limite credito per messaggio di preavviso</td>
    <td valign=center><formwidget id="valore_limite_portaf">
        <formerror  id="valore_limite_portaf"><br>
        <span class="errori">@formerror.valore_limite_portaf;noquote@</span>
        </formerror>
    </td>
</tr>

<tr><td valign=center nowrap align=right class=form_title>Attiva Multivie</td>
    <td valign=center><formwidget id="flag_multivie">
        <formerror  id="flag_multivie"><br>
        <span class="errori">@formerror.flag_multivie;noquote@</span>
        </formerror>
    </td>
    <td valign=center nowrap align=right class=form_title>Stampa l'indirizzo della ditta di manutenzione<br>per il terzo responsabile</td>
    <td valign=center><formwidget id="flag_stp_presso_terzo_resp">
        <formerror  id="flag_stp_presso_terzo_resp"><br>
        <span class="errori">@formerror.flag_stp_presso_terzo_resp;noquote@</span>
        </formerror>
    </td>
</tr>

<tr><td valign=center nowrap align=right class=form_title>L'istanza è collegata ad iter-portal?</td>
    <td valign=center><formwidget id="flag_portale">
        <formerror  id="flag_portale"><br>
        <span class="errori">@formerror.flag_portale;noquote@</span>
        </formerror>
    </td>
    <td valign=center nowrap align=right class=form_title>Gestione dei modelli di generatore<br>su apposita anagrafica</td>
    <td valign=center><formwidget id="flag_gest_coimmode">
        <formerror  id="flag_gest_coimmode"><br>
        <span class="errori">@formerror.flag_gest_coimmode;noquote@</span>
        </formerror>
    </td>
</tr>

<tr><td valign=center align=right class=form_title>Lungh. del progressivo nel codice impianto</td>
    <td valign=center><formwidget id="lun_num_cod_imp_est">
        <formerror  id="lun_num_cod_imp_est"><br>
        <span class="errori">@formerror.lun_num_cod_imp_est;noquote@</span>
        </formerror>
    </td>
    <td valign=center align=right class=form_title>Potenza da considerare per la fascia di potenza</td>
    <td valign=center><formwidget id="flag_potenza">
        <formerror  id="flag_potenza"><br>
        <span class="errori">@formerror.flag_potenza;noquote@</span>
        </formerror>
    </td>
</tr>

<tr><td valign=center align=right class=form_title>Gestione targa</td>
    <td valign=center><formwidget id="flag_gest_targa">
        <formerror  id="flag_gest_targa"><br>
        <span class="errori">@formerror.flag_gest_targa;noquote@</span>
        </formerror>
    </td>
    <td valign=center align=right class=form_title>Gestione rcee legna</td>
    <td valign=center><formwidget id="flag_gest_rcee_legna">
        <formerror  id="flag_gest_rcee_legna"><br>
        <span class="errori">@formerror.flag_rcee_legna;noquote@</span>
        </formerror>
    </td>
</tr>

<tr><td valign=center align=right class=form_title>Verifica impianti da parte dell'ente</td>
    <td valign=center><formwidget id="flag_verifica_impianti">
        <formerror  id="flag_verifica_impianti"><br>
        <span class="errori">@formerror.flag_verifica_impianti;noquote@</span>
        </formerror>
    </td>
    <td valign=center align=right class=form_title>Indirizzo pec</td>
    <td valign=center><formwidget id="indirizzo_pec">
        <formerror  id="indirizzo_pec"><br>
        <span class="errori">@formerror.indirizzo_pec;noquote@</span>
        </formerror>
    </td>
</tr>

<!-- rom01 inizio -->
<tr><td valign=center align=right class=form_title>Nome Utente pec</td>
    <td valign=center><formwidget id="nome_utente_pec">
        <formerror  id="nome_utente_pec"><br>
        <span class="errori">@formerror.nome_utente_pec;noquote@</span>
        </formerror>
    </td>
    <td valign=center align=right class=form_title>Password pec</td>
    <td valign=center><formwidget id="password_pec">
        <formerror  id="password_pec"><br>
        <span class="errori">@formerror.password_pec;noquote@</span>
        </formerror>
    </td>
</tr>
<tr><td valign=center align=right class=form_title>Singolo log-in per gli operatori</td>
    <td valign=center><formwidget id="flag_single_sign_on">
        <formerror  id="flag_signgle_sign_on"><br>
        <span class="errori">@formerror.flag_single_sign_on;noquote@</span>
        </formerror>
    </td>
    <td valign=center align=right class=form_title>Dati catastali obbligatori</td>
    <td valign=center><formwidget id="flag_obbligo_dati_catastali">
        <formerror  id="flag_obbligo_dati_catastali"><br>
        <span class="errori">@formerror.flag_obbligo_dati_catastali;noquote@</span>
        </formerror>
    </td>
</tr>
<tr><td valign=center align=right class=form_title>STMP pec</td>
    <td valign=center><formwidget id="stmp_pec">
        <formerror  id="stmp_pec"><br>
        <span class="errori">@formerror.stmp_pec;noquote@</span>
        </formerror>
    </td>
    <td valign=center align=right class=form_title>porta Uscita pec</td>
    <td valign=center><formwidget id="porta_uscita_pec">
        <formerror  id="porta_uscita_pec"><br>
        <span class="errori">@formerror.porta_uscita_pec;noquote@</span>
        </formerror>
    </td>
</tr>

<!-- rom01 fine --> 

<tr><td colspan=4>&nbsp;</td></tr>
<if @funzione@ ne "V">
    <tr><td colspan=4 align=center><formwidget id="submit"></td></tr>
</if>

<!-- Fine della form colorata -->
<%=[iter_form_fine]%>

</formtemplate>
<p>
</center>

