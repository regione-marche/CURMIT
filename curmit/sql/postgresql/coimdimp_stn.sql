/*==============================================================*/
/* table coimdimp_stn:			                        */
/*==============================================================*/

create table coimdimp_stn
     ( cod_dimp         varchar(08) not null
     , cod_impianto     varchar(08) not null 
     , data_controllo   date        not null
    -- tolto il not null a 5 campi successivi
     , gen_prog         numeric(08)
     , cod_manutentore  varchar(08)
     , cod_responsabile varchar(08)
     , cod_proprietario varchar(08)
     , cod_occupante    varchar(08)
     , cod_documento    varchar(08)
     , flag_status      char(01)
     , garanzia         char(01)
     , conformita       char(01)
     , lib_impianto     char(01)
     , lib_uso_man      char(01)
     , inst_in_out      char(01)
     , idoneita_locale  char(01)
     , ap_ventilaz      char(01)
     , ap_vent_ostruz   char(01)
     , pendenza         char(01)
     , sezioni          char(01)
     , curve            char(01)
     , lunghezza        char(01)
     , conservazione    char(01)
     , scar_ca_si       char(01)
     , scar_parete      char(01)
     , riflussi_locale  char(01)
     , assenza_perdite  char(01)
     , pulizia_ugelli   char(01)
     , antivento        char(01)
     , scambiatore      char(01)
     , accens_reg       char(01)
     , disp_comando     char(01)
     , ass_perdite      char(01)
     , valvola_sicur    char(01)
     , vaso_esp         char(01)
     , disp_sic_manom   char(01)
     , organi_integri   char(01)
     , circ_aria        char(01)
     , guarn_accop      char(01)
     , assenza_fughe    char(01)
     , coibentazione    char(01)
     , eff_evac_fum     char(01)
     , cont_rend        char(01)
     , pot_focolare_mis numeric(6,2)
     , portata_comb_mis numeric(6,2)
     , temp_fumi        numeric(6,2)
     , temp_ambi        numeric(6,2)
     , o2               numeric(6,2)
     , co2              numeric(6,2)
     , bacharach        numeric(6,2)
     , co               numeric(10,4)
     , rend_combust     numeric(6,2)
     , osservazioni     varchar(4000)
     , raccomandazioni  varchar(4000)
     , prescrizioni     varchar(4000)
     , data_utile_inter date
     , n_prot           varchar(20)
     , data_prot        date
     , delega_resp      varchar(50)
     , delega_manut     varchar(50)
     , num_bollo        varchar(20)    -- non usato, vedi riferimento_pag
     , costo            numeric(6,2)
     , tipologia_costo  varchar(2)
     , riferimento_pag  varchar(100)
     , utente           varchar(10)
     , data_ins         date
     , data_mod         date
     , potenza          numeric(9,2) 
     , flag_pericolosita  char(01) -- (T,F)
     , flag_co_perc       char(01)
     , flag_tracciato     varchar(02)
     , cod_docu_distinta  varchar(08)
     , scar_can_fu        char(01)
     , tiraggio           numeric(9,2)
     , ora_inizio         varchar(08)
     , ora_fine           varchar(08)
     , rapp_contr         char(01)
     , rapp_contr_note    varchar(4000)
     , certificaz         char(01)
     , certificaz_note    varchar(4000)
     , dich_conf          char(01)
     , dich_conf_note     varchar(4000)
     , libretto_bruc      char(01)
     , libretto_bruc_note varchar(4000)
     , prev_incendi       char(01)
     , prev_incendi_note  varchar(4000)
     , lib_impianto_note  varchar(4000)
     , ispesl             char(01)
     , ispesl_note        varchar(4000)
     , data_scadenza      date
     , num_autocert       varchar(20)
     , esame_vis_l_elet   char(01)
     , funz_corr_bruc     char(01)
     , lib_uso_man_note   varchar(4000)
     , volimetria_risc    numeric(9,2)
     , consumo_annuo      numeric(9,2)
     , cod_opmanu         varchar(08)
     , utente_ins         varchar(10)
     , data_arrivo_ente   date
     , fl_firma_tecnico   char(01)
     , fl_firma_resp      char(01)
     , igni_progressivo   integer
     , cod_opmanu_new     varchar(16)
     , consumo_annuo2	  numeric(9,2)
     , stagione_risc	  varchar(40)
     , stagione_risc2	  varchar(40)
     , schemi_funz_idr	  char(01)
     , schemi_funz_ele    char(01)
     , schemi_funz_idr_note	  varchar(4000)
     , schemi_funz_ele_note	  varchar(4000)
     , cod_distributore		  varchar(8)
     , tariffa			  integer
     , importo_tariffa		  numeric(9,2)
     , stato_dich		  char(01)
     , cod_dimp_stn		  varchar(08)
     , motivo_storno		  text
     , cod_cind                  varchar(8)
     , rct_dur_acqua             numeric(10,2)
     , rct_tratt_in_risc         varchar(2)
     , rct_tratt_in_acs          varchar(2)
     , rct_install_interna       varchar(1)
     , rct_install_esterna       varchar(1)
     , rct_canale_fumo_idoneo    varchar(1)
     , rct_sistema_reg_temp_amb  varchar(1)
     , rct_assenza_per_comb      varchar(1)
     , rct_idonea_tenuta         varchar(1)
     , rct_scambiatore_lato_fumi varchar(1)
     , rct_riflussi_comb         varchar(1)
     , rct_uni_10389             varchar(1)
     , rct_rend_min_legge        numeric(10,2)
     , rct_check_list_1          varchar(1)
     , rct_check_list_2          varchar(1)
     , rct_check_list_3          varchar(1)
     , rct_check_list_4          varchar(1)
     , rct_gruppo_termico        varchar(2)
     , rct_valv_sicurezza        varchar(1)
     , fr_linee_ele           varchar(1) --1
     , fr_coibentazione       varchar(1) --2
     , fr_assorb_recupero     varchar(1) --3
     , fr_assorb_fiamma       varchar(1) --4
     , fr_ciclo_compressione  varchar(1) --5
     , fr_assenza_perdita_ref varchar(1) --6
     , fr_leak_detector       varchar(1) --7
     , fr_pres_ril_fughe      varchar(1) --8
     , fr_scambiatore_puliti  varchar(1) --9
     , fr_prova_modalita      varchar(1) --10
     , fr_surrisc             numeric(10,2) --11
     , fr_sottoraff           numeric(10,2) --12
     , fr_tcondens            numeric(10,2) --13
     , fr_tevapor             numeric(10,2) --14
     , fr_t_ing_lato_est      numeric(10,2) --15
     , fr_t_usc_lato_est      numeric(10,2) --16
     , fr_t_ing_lato_ute      numeric(10,2) --17
     , fr_t_usc_lato_ute      numeric(10,2) --18
     , fr_nr_circuito         numeric(10,0) --19
     , fr_check_list_1        varchar(1) --20
     , fr_check_list_2        varchar(1) --21
     , fr_check_list_3        varchar(1)  --22
     , fr_check_list_4        varchar(1) --23 
     , rct_lib_uso_man_comp   varchar(1)
     , rct_modulo_termico     varchar(08) -- 2014-06-27

     , dam_tipo_manutenzione    char(1) -- M=Manutenzione programmata, N=Nuova installazione/ristrutturazione, R=Riattivazione impianto/generatore

     , dam_flag_osservazioni    boolean not null default 'f'
     , dam_flag_raccomandazioni boolean not null default 'f'
     , dam_flag_prescrizioni    boolean not null default 'f'

     , dam_cognome_dichiarante  varchar(100)
     , dam_nome_dichiarante     varchar(100)
     , dam_tipo_tecnico         char(01)     -- In qualita' di A=Affidatario della manutenzione

     , data_prox_manut          date
     , lg_flag_dep_combust_solido char(1)
     , lg_flag_puliz_camino       char(1)
     , lg_flag_sep_gen            char(1)
     , lg_flag_sollecit_termiche  char(1)
     , id_tplg                    integer
     , note_tplg_altro            varchar(4000)
     , lg_condensazione           char(1)
     , lg_vaso_espa               char(1)
     , lg_marcatura_ce            char(1)
     , lg_placca_cam              char(1)
     , lg_caric_comb              char(1)
     , lg_mod_evac_fumi           char(1)
     , lg_aria_comburente         char(1)
     , libretto_manutenz          varchar(2)
     , doc_prev_incendi           char(1)
     , dich_152_presente          char(1)
     , doc_ispesl                 char(1)	
     , tel_stato_coibent_idoneo_imp          char(1) -- ale01 24/03/2017
     , tel_linee_eletr_idonee                char(1) -- ale01 24/03/2017
     , tel_assenza_perdite_circ_idraulico    char(1) -- ale01 24/03/2017
     , tel_potenza_compatibile_dati_prog     char(1) -- ale01 24/03/2017
     , tel_stato_coibent_idoneo_scamb        char(1) -- ale01 24/03/2017
     , tel_disp_regolaz_controll_funzionanti char(1) -- ale01 24/03/2017
     , tel_assenza_trafil_valv_regolaz       char(1) -- ale01 24/03/2017
     , tel_temp_est                          integer -- ale01 24/03/2017
     , tel_temp_mand_prim                    integer -- ale01 24/03/2017
     , tel_temp_rit_prim                     integer -- ale01 24/03/2017
     , tel_potenza_termica                   integer -- ale01 24/03/2017
     , tel_portata_fluido_prim               integer -- ale01 24/03/2017
     , tel_temp_mand_sec                     integer -- ale01 24/03/2017
     , tel_temp_rit_sec                      integer -- ale01 24/03/2017
     , tel_check_coerenza_paramentri         char(1) -- ale01 24/03/2017
     , tel_check_perdite_h2o                 char(1) -- ale01 24/03/2017
     , tel_check_install_involucro           char(1) -- ale01 24/03/2017
     , tel_alimentazione                     char(1) -- ale01 24/03/2017
     , tel_fluido_vett_term_uscita           char(1) -- ale01 24/03/2017
     , cog_capsula_insonorizzata             varchar(1)    --rom01
     , cog_tenuta_circ_idraulico             varchar(1)    --rom01 
     , cog_tenuta_circ_olio                  varchar(1)    --rom01 
     , cog_tenuta_circ_alim_combustibile     varchar(1)    --rom01
     , cog_funzionalita_scambiatore          varchar(1)    --rom01
     , cog_potenza_assorbita_comb            decimal(18,2) --rom01
     , cog_potenza_termica_piena_pot         decimal(18,2) --rom01
     , cog_emissioni_monossido_co            decimal(18,2) --rom01
     , cog_temp_aria_comburente              decimal(18,2) --rom01
     , cog_temp_h2o_uscita                   decimal(18,2) --rom01
     , cog_temp_h2o_ingresso                 decimal(18,2) --rom01
     , cog_potenza_morsetti_gen              decimal(18,2) --rom01
     , cog_temp_h2o_motore                   decimal(18,2) --rom01
     , cog_temp_fumi_valle                   decimal(18,2) --rom01
     , cog_temp_fumi_monte                   decimal(18,2) --rom01
     );

create unique index coimdimp_stn_00
    on coimdimp
     ( cod_dimp
     ); 

create        index coimdimp_stn_01
    on coimdimp
     ( cod_impianto
     , data_controllo
     ); 

create        index coimdimp_stn_02
    on coimdimp
     ( riferimento_pag
     , tipologia_costo
     );
