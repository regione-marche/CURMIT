/*==============================================================*/
/* table coimcimp: tabella controlli                            */
/*==============================================================*/
-- gab01 14/02/2017 Aggiunti per iterprfi i campi classe_energ
--                  e uni_cen 

-- san01 12/08/2016 Aggiunti per iterprfi Agenzia Fiorentina per l'Energia

create table coimcimp
-- incremento in automatico
     ( cod_cimp               varchar(08)   not null
     , cod_impianto           varchar(08)   not null
     , cod_documento          varchar(08)
-- numero progressivo generatore
     , gen_prog               numeric(08)
-- dati dell'incontro
     , cod_inco               varchar(8)
     , data_controllo         date          not null
-- numero del verbale 
     , verb_n                 varchar(20)
     , data_verb              date
-- codice verificatore
     , cod_opve               varchar(08)
-- costo della visita
     , costo                  numeric(9,2)
-- nominativo che presenzia alla visita
     , nominativo_pres        varchar(4000)

-- controllo documentazione si/no
     , presenza_libretto      varchar(02)
     , libretto_corretto      varchar(02)
     , dich_conformita        varchar(02)
     , libretto_manutenz      varchar(02)
     
-- controlli
     , mis_port_combust       numeric(9,2)
     , mis_pot_focolare       numeric(9,2)
     , stato_coiben           varchar(02)
     , stato_canna_fum        varchar(02)
     , verifica_dispo         varchar(02)
     , verifica_areaz         varchar(02)
     , taratura_dispos        varchar(02)
     
     , co_fumi_secchi         numeric(9,2)
     , ppm                    numeric(9,2)
     , eccesso_aria_perc      numeric(9,2)
     , perdita_ai_fumi        numeric(9,2)
     , rend_comb_conv         numeric(9,2)
     , rend_comb_min          numeric(9,2)

-- misure 
     , temp_fumi_1a           numeric(6,2)
     , temp_fumi_2a           numeric(6,2)
     , temp_fumi_3a           numeric(6,2)
     , temp_fumi_md           numeric(6,2)
     , t_aria_comb_1a         numeric(6,2)
     , t_aria_comb_2a         numeric(6,2)
     , t_aria_comb_3a         numeric(6,2)
     , t_aria_comb_md         numeric(6,2)
     , temp_mant_1a           numeric(6,2)
     , temp_mant_2a           numeric(6,2)
     , temp_mant_3a           numeric(6,2)
     , temp_mant_md           numeric(6,2)
     , temp_h2o_out_1a        numeric(6,2)
     , temp_h2o_out_2a        numeric(6,2)
     , temp_h2o_out_3a        numeric(6,2)
     , temp_h2o_out_md        numeric(6,2)
     , co2_1a                 numeric(6,2)
     , co2_2a                 numeric(6,2)
     , co2_3a                 numeric(6,2)
     , co2_md                 numeric(6,2)
     , o2_1a                  numeric(6,2)
     , o2_2a                  numeric(6,2)
     , o2_3a                  numeric(6,2)
     , o2_md                  numeric(6,2)
     , co_1a                  numeric(10,4)
     , co_2a                  numeric(10,4)
     , co_3a                  numeric(10,4)
     , co_md                  numeric(10,4)
     , indic_fumosita_1a      numeric(6,2)
     , indic_fumosita_2a      numeric(6,2)
     , indic_fumosita_3a      numeric(6,2)
     , indic_fumosita_md      numeric(6,2)

-- risultati verifica
     , manutenzione_8a        varchar(02)
     , co_fumi_secchi_8b      varchar(02)
     , indic_fumosita_8c      varchar(02)
     , rend_comb_8d           varchar(02)
     , esito_verifica         varchar(02) 
 
-- strumenti di verifica 
     , strumento              varchar(100)
-- note del verificatore osservazioni/raccomandazioni
     , note_verificatore      varchar(4000)
-- dichiarazioni del responsabile o delegato
     , note_resp              varchar(4000)
-- note libere verificatore non conformita'
     , note_conf              varchar(4000)
     , tipologia_costo        varchar(2)
     , riferimento_pag        varchar(20)
-----dati di inserimento
     , utente                 varchar(10)
     , data_ins               date
     , data_mod               date
     , pot_utile_nom          numeric(9,2)
     , pot_focolare_nom       numeric(9,2)
     , cod_combustibile       varchar(08)
     , cod_responsabile       varchar(08)
     , flag_cpi               char(1)
     , flag_ispes             char(1)
     , flag_pericolosita      char(01) -- (T,F)
----- dati per personalizzazioni
     , flag_tracciato          varchar(02)
     , new1_data_dimp         date
     , new1_data_paga_dimp    date
     , new1_conf_locale       char(01)
     , new1_conf_accesso      char(01)
     , new1_pres_intercet     char(01)
     , new1_pres_interrut     char(01)
     , new1_asse_mate_estr    char(01)
     , new1_pres_mezzi        char(01)
     , new1_pres_cartell      char(01)
     , new1_disp_regolaz      char(01)
     , new1_foro_presente     char(01)
     , new1_foro_corretto     char(01)
     , new1_foro_accessibile  char(01)
     , new1_canali_a_norma    char(01)
     , new1_lavoro_nom_iniz   numeric(9,2)
     , new1_lavoro_nom_fine   numeric(9,2)
     , new1_lavoro_lib_iniz   numeric(9,2)
     , new1_lavoro_lib_fine   numeric(9,2)
     , new1_note_manu         varchar(4000)
     , new1_dimp_pres         char(01)
     , new1_dimp_prescriz     char(01)
     , new1_data_ultima_manu  date
     , new1_data_ultima_anal  date
     , new1_manu_prec_8a      char(01)
     , new1_co_rilevato       numeric(7,2)
     , new1_flag_peri_8p      char(01)
----- flag divieto d'uso
     , flag_uso		      char(01)
     , flag_diffida           char(01)
     , eccesso_aria_perc_2a   numeric(9,2)
     , eccesso_aria_perc_3a   numeric(9,2)
     , eccesso_aria_perc_md   numeric(9,2)
     , n_prot                 varchar(20)
     , data_prot              date
----- diversi dei dati seguenti non sono utilizzati ma aggiunti a scopo "preventivo"
     , sezioni_corr           char(1)
     , curve_corr             char(1)
     , lungh_corr             char(1)
     , riflussi_loc           char(1)
     , perdite_cond           char(1)
     , disp_funz              char(1)
     , assenza_fughe          char(1)
     , effic_evac             char(1)
     , autodich               char(1)
     , dich_conf              char(1)
     , manut_prog             char(1)
     , marca_strum            varchar(50)
     , modello_strum          varchar(50)
     , matr_strum             varchar(50)
     , dt_tar_strum           date
     , indice_aria            numeric(6,2)
     , perd_cal_sens          numeric(6,2)
     , doc_ispesl             char(1)
     , doc_prev_incendi       char(1)
     , libr_manut_bruc        char(1)
     , ubic_locale_norma      char(1)
     , disp_chius_porta       char(1)
     , spazi_norma            char(1)
     , apert_soffitto         char(1)
     , rubin_manuale_acces    char(1)
     , assenza_app_peric      char(1)
     , rubin_chiuso           char(1)
     , elettrovalv_esterne    char(1)
     , tubaz_press            char(1)
     , tolta_tensione         char(1)
     , termost_esterno        char(1)
     , chiusura_foro          char(1)
     , accens_funz_gen        char(1)
     , pendenza               char(1)
     , ventilaz_lib_ostruz    char(1)
     , disp_reg_cont_pre      char(1)
     , disp_reg_cont_funz     char(1)
     , disp_reg_clim_funz     char(1)
     , conf_imp_elettrico     char(1)
     , volumetria             numeric(9,2)
     , comsumi_ultima_stag    numeric(9,2)
-- ora di inizio e fine del controllo
     , ora_inizio             varchar(8)
     , ora_fine               varchar(8)
     , utente_ins             varchar(10)
     , fl_firma_tecnico       char(01)
     , fl_firma_resp          char(01)
     , costo_nonreg           numeric(9,2)
     , f_comunic_cess         char(01)
     , stampe_analiz_alleg    char(01)
     , fattore_molt           numeric(9,2)
     , note_strum             varchar(4000)
     , prod_h2o_sanit         char(01)
     , note_analisi_no_eff    varchar(2000)
     , altre_difformita       char(01)
     , utente_pres            varchar(100)
     , delegato_ragsoc        varchar(100)
     , delegato_indirizzo     varchar(100)
     , data_arrivo            date
     , note_esamevisivo_locale  varchar(4000)
     , flag_sbocco_tetto      varchar(2)
     , flag_unicig_7129       varchar(2)
     , new1_data_ultima_manu_2  date
     , new1_data_ultima_manu_3  date
     , new1_data_ultima_anal_2  date
     , new1_data_ultima_anal_3  date
     , new1_dimp_pres_2       char(01)
     , new1_dimp_pres_3       char(01)
     , trasf_centr_aut        varchar(100)
     , igni_progressivo       integer
     , scarico_tetto          varchar(2)
     , scarico_parete         varchar(2)
     , cod_noin               varchar(8)
     , cod_sanzione_1         varchar(8)
     , cod_sanzione_2         varchar(8)
     , tiraggio               numeric(9,4)

     , flag_tipo_impianto     varchar(01) -- 2014-05-27
     , data_284               date        -- 2014-05-28
     , flag_pres_284          char(01)    -- 2014-05-28
     , flag_comp_284          char(01)    -- 2014-05-28

--sim 2015-04-20 Nuovo rapporto di ispezione
     , potenza_effettiva_nom       numeric(10,2)
     , potenza_effettiva_util      numeric(10,2)
     , interna_locale_idoneo       char(1)
     , esterna_generatore_idoneo   char(1)
     , canale_fumo_idoneo          char(1)
     , ventilazione_locali         char(1)
     , areazione_locali	           char(1)
     , ventilazione_locali_mis     numeric(10,2)
     , verifica_disp_regolazione   char(1)  -- (P Positiva, A assente , N negativa, F Non funzionate  C non conforrme)
     , frequenza_manut  	   char(1)  -- (S Semestrale, A Annuale , B Biennale, T Altro )
     , rcee_inviato  		   char(1)
     , rcee_osservazioni  	   char(1)
     , rcee_raccomandazioni  	   char(1)
     , misurazione_rendimento      char(1)
     , check_valvole  	           char(1)
     , check_isolamento  	   char(1)
     , check_trattamento  	   char(1)
     , check_regolazione  	   char(1)
     , dimensionamento_gen 	   char(1) -- (S corretto, N Non corretto, C non controllabile)
     , esito_periodicita 	   char(1)
     , mod_verde  		   char(1)
     , mod_rosa 		   char(1)
     , frequenza_manut_altro 	   numeric(4,0)
     , potenza_nom_tot_foc  	   numeric(10,2)
     , potenza_nom_tot_util 	   numeric(10,2)
     , tratt_in_risc        	   char(2)
     , tratt_in_acs         	   char(2)
     , docu_152            	   char(1)
     , auto_adeg_152        	   char(1)
     , dich_152_presente    	   char(1) 
     , delega_pres                 char(1)
     , controllo_cucina            char(1)
     , norm_7a                     char(1)
     , norm_9a                     char(1)
     , norm_9b                     char(1)
     , norm_9c                     char(1)
     , deve_non_messa_norma        char(1)
     , deve_non_rcee               char(1)
     , rimanere_funzione           char(1)
     , pagamento_effettuato        char(1)
     , check_sostituzione          char(1)
     , check_scambiatori           char(1)
     , check_eccesso_aria          char(1)
     , check_altro                 char(1)
     , ass_perdite_comb            char(1)
     , inte_migliorare_re          char(1)
     , rapp_cont_inviato           char(1)
     , rapp_cont_bollino           char(1)
     , rapp_cont_data_compilazione date
     , dur_acqua                   numeric(10,2)
     , locale_persone              char(1)
     , ventilaz_areaz              char(1)
     , miglioramento_energ         varchar(100)
     , manut_pres                  char(1)
     , deve_pagare                 char(1)
     , temp_esterna                numeric(6,2)
     , classe_energ                varchar(100)  --gab01
     , uni_cen                     char(1)       --gab01
     );

create unique index coimcimp_00
    on coimcimp
     ( cod_cimp
     );

create        index coimcimp_01
    on coimcimp 
     ( cod_impianto
     , gen_prog
     , data_controllo
     );

create        index coimcimp_02
    on coimcimp 
     ( cod_inco
     );
