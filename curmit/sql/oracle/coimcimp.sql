/*==============================================================*/
/* table coimcimp: tabella controlli                            */
/*==============================================================*/

create table coimcimp
-- incremento in automatico
     ( cod_cimp               varchar2(08)   not null
     , cod_impianto           varchar2(08)   not null
     , cod_documento          varchar2(08)
-- numero progressivo generatore
     , gen_prog               number(08)
-- dati dell'incontro
     , cod_inco               varchar2(8)
     , data_controllo         date          not null
-- numero del verbale 
     , verb_n                 varchar2(20)
     , data_verb              date
-- codice verificatore
     , cod_opve               varchar2(08)
-- costo della visita
     , costo                  number(9,2)
-- nominativo che presenzia alla visita
     , nominativo_pres        varchar2(4000)
-- controllo documentazione si/no
     , presenza_libretto      varchar2(02)
     , libretto_corretto      varchar2(02)
     , dich_conformita        varchar2(02)
     , libretto_manutenz      varchar2(02)    
-- controlli
     , mis_port_combust       number(9,2)
     , mis_pot_focolare       number(9,2)
     , stato_coiben           varchar2(02)
     , stato_canna_fum        varchar2(02)
     , verifica_dispo         varchar2(02)
     , verifica_areaz         varchar2(02)
     , taratura_dispos        varchar2(02)
     , co_fumi_secchi         number(9,2)
     , ppm                    number(9,2)
     , eccesso_aria_perc      number(9,2)
     , perdita_ai_fumi        number(9,2)
     , rend_comb_conv         number(9,2)
     , rend_comb_min          number(9,2)
-- misure 
     , temp_fumi_1a           number(6,2)
     , temp_fumi_2a           number(6,2)
     , temp_fumi_3a           number(6,2)
     , temp_fumi_md           number(6,2)
     , t_aria_comb_1a         number(6,2)
     , t_aria_comb_2a         number(6,2)
     , t_aria_comb_3a         number(6,2)
     , t_aria_comb_md         number(6,2)
     , temp_mant_1a           number(6,2)
     , temp_mant_2a           number(6,2)
     , temp_mant_3a           number(6,2)
     , temp_mant_md           number(6,2)
     , temp_h2o_out_1a        number(6,2)
     , temp_h2o_out_2a        number(6,2)
     , temp_h2o_out_3a        number(6,2)
     , temp_h2o_out_md        number(6,2)
     , co2_1a                 number(6,2)
     , co2_2a                 number(6,2)
     , co2_3a                 number(6,2)
     , co2_md                 number(6,2)
     , o2_1a                  number(6,2)
     , o2_2a                  number(6,2)
     , o2_3a                  number(6,2)
     , o2_md                  number(6,2)
     , co_1a                  number(10,4)
     , co_2a                  number(10,4)
     , co_3a                  number(10,4)
     , co_md                  number(10,4)
     , indic_fumosita_1a      number(6,2)
     , indic_fumosita_2a      number(6,2)
     , indic_fumosita_3a      number(6,2)
     , indic_fumosita_md      number(6,2)
-- risultati verifica
     , manutenzione_8a        varchar2(02)
     , co_fumi_secchi_8b      varchar2(02)
     , indic_fumosita_8c      varchar2(02)
     , rend_comb_8d           varchar2(02)
     , esito_verifica         varchar2(02) 
-- strumenti di verifica 
     , strumento              varchar2(100)
-- note del verificatore osservazioni/raccomandazioni
     , note_verificatore      varchar2(4000)
-- dichiarazioni del responsabile o delegato
     , note_resp              varchar2(4000)
-- note libere verificatore non conformita'
     , note_conf              varchar2(4000)
     , tipologia_costo        varchar2(2)
     , riferimento_pag        varchar2(20)
-----dati di inserimento
     , utente                 varchar2(10)
     , data_ins               date
     , data_mod               date
     , pot_utile_nom          number(9,2)
     , pot_focolare_nom       number(9,2)
     , cod_combustibile       varchar2(08)
     , cod_responsabile       varchar2(08)
     , flag_cpi               char(1)
     , flag_ispes             char(1)
     , flag_pericolosita      char(01) -- (T,F)
----- dati per personalizzazioni
     , flag_tracciato         varchar2(02)
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
     , new1_lavoro_nom_iniz   number(9,2)
     , new1_lavoro_nom_fine   number(9,2)
     , new1_lavoro_lib_iniz   number(9,2)
     , new1_lavoro_lib_fine   number(9,2)
     , new1_note_manu         varchar2(4000)
     , new1_dimp_pres         char(01)
     , new1_dimp_prescriz     char(01)
     , new1_data_ultima_manu  date
     , new1_data_ultima_anal  date
     , new1_manu_prec_8a      char(01)
     , new1_co_rilevato       number(7,2)
     , new1_flag_peri_8p      char(01)
----- flag divieto d'uso
     , flag_uso               char(01)
     , flag_diffida           char(01)
     , eccesso_aria_perc_2a   number(9,2)
     , eccesso_aria_perc_3a   number(9,2)
     , eccesso_aria_perc_md   number(9,2)
     , n_prot                 varchar2(20)
     , data_prot              date
------------------------------------------
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
     , marca_strum            varchar2(50)
     , modello_strum          varchar2(50)
     , matr_strum             varchar2(50)
     , dt_tar_strum           date
     , indice_aria            number(6,2)
     , perd_cal_sens          number(6,2)
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
     , volumetria             number(9,2)
     , comsumi_ultima_stag    number(9,2)
     , flag_tipo_impianto     varchar2(01) -- 2014-05-27
     , data_284               date        -- 2014-05-28
     , flag_pres_284          char(01)    -- 2014-05-28
     , flag_comp_284          char(01)    -- 2014-05-28

--sim 2015-04-20 Nuovo rapporto di ispezione
     , potenza_effettiva_nom  numeric (10,2)
     , potenza_effettiva_util      numeric (10,2)
     , interna_locale_idoneo       char(1)
     , esterna_generatore_idoneo   char(1)
     , canale_fumo_idoneo          char(1)
     , ventilazione_locali         char(1)
     , areazione_locali	           char(1)
     , ventilazione_locali_mis     numeric (10,2)
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
     ) tablespace &ts_dat;

create unique index coimcimp_00
    on coimcimp
     ( cod_cimp
     ) tablespace &ts_idx;

create        index coimcimp_01
    on coimcimp 
     ( cod_impianto
     , gen_prog
     , data_controllo
     ) tablespace &ts_idx;

create        index coimcimp_02
    on coimcimp 
     ( cod_inco
     ) tablespace &ts_idx;

