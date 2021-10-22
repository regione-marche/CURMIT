/*==============================================================*/
/* table coimcimp_cnt: tabella controlli                            */
/*==============================================================*/

create table coimcimp_cnt
-- incremento in automatico
     ( cod_cimp               varchar(08)   not null
     , cod_impianto           varchar(08)   not null
     , cod_documento          varchar(08)
-- numero progressivo generatore
     , gen_prog               numeric(08)
-- dati dell'incontro
     , cod_inco               varchar(8)
     , data_controllo         date          not null
     , ora_inizio             varchar(8)
     , ora_fine               varchar(8)
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
     , new1_co_rilevato       numeric(6,2)
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
   );

create unique index coimcimp_cnt_00
    on coimcimp_cnt
     ( cod_cimp
     );

create        index coimcimp_cnt_01
    on coimcimp_cnt 
     ( cod_impianto
     , gen_prog
     , data_controllo
     );

create        index coimcimp_cnt_02
    on coimcimp_cnt 
     ( cod_inco
     );
