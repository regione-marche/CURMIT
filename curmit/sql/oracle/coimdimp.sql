/*==============================================================*/
/* table coimdimp: tabella modelli H                            */
/*==============================================================*/

create table coimdimp
     ( cod_dimp         varchar2(08) not null
     , cod_impianto     varchar2(08) not null 
     , data_controllo   date         not null
    -- tolto il not null a 5 campi successivi
     , gen_prog         number(08)
     , cod_manutentore  varchar2(08)
     , cod_responsabile varchar2(08)
     , cod_proprietario varchar2(08)
     , cod_occupante    varchar2(08)
     , cod_documento    varchar2(08)
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
     , pot_focolare_mis number(6,2)
     , portata_comb_mis number(6,2)
     , temp_fumi        number(6,2)
     , temp_ambi        number(6,2)
     , o2               number(6,2)
     , co2              number(6,2)
     , bacharach        number(6,2)
     , co               number(10,4)
     , rend_combust     number(6,2)
     , osservazioni     varchar2(4000)
     , raccomandazioni  varchar2(4000)
     , prescrizioni     varchar2(4000)
     , data_utile_inter date
     , n_prot           varchar2(20)
     , data_prot        date
     , delega_resp      varchar2(50)
     , delega_manut     varchar2(50)
     , num_bollo        varchar2(20)    -- non usato, vedi riferimento_pag
     , costo            number(6,2)
     , tipologia_costo  varchar2(2)
     , riferimento_pag  varchar2(100) -- Prima del 24/11/2015 era lungo 20 (Sandro)
     , utente           varchar2(10)
     , data_ins         date
     , data_mod         date
     , potenza          number(9,2) 
     , flag_pericolosita char(01) -- (T,F)
     , flag_co_perc     char(01)
     , flag_tracciato   varchar2(02)
     , cod_docu_distinta  varchar2(08)
     , scar_can_fu        char(01)
     , tiraggio           numbe(9,2)
     , ora_inizio         varchar2(08)
     , ora_fine           varchar2(08)
     , rapp_contr         char(01)
     , rapp_contr_note    varchar2(4000)
     , certificaz         char(01)
     , certificaz_note    varchar2(4000)
     , dich_conf          char(01)
     , dich_conf_note     varchar2(4000)
     , libretto_bruc      char(01)
     , libretto_bruc_note varchar2(4000)
     , prev_incendi       char(01)
     , prev_incendi_note  varchar2(4000)
     , lib_impianto_note  varchar2(4000)
     , ispesl             char(01)
     , ispesl_note        varchar2(4000)
     , data_scadenza      date
     , num_autocert       varchar2(20)
     , esame_vis_l_elet   char(01)
     , funz_corr_bruc     char(01)
     , lib_uso_man_note   varchar2(4000)
     , volimetria_risc    number(9,2)
     , consumo_annuo      number(9,2)
     , cod_cind                  varchar(8)
     , rct_dur_acqua             number(10,2)
     , rct_tratt_in_risc         varchar2(2)
     , rct_tratt_in_acs          varchar2(2)
     , rct_install_interna       varchar2(1)
     , rct_install_esterna       varchar2(1)
     , rct_canale_fumo_idoneo    varchar2(1)
     , rct_sistema_reg_temp_amb  varchar2(1)
     , rct_assenza_per_comb      varchar2(1)
     , rct_idonea_tenuta         varchar2(1)
     , rct_scambiatore_lato_fumi varchar2(1)
     , rct_riflussi_comb         varchar2(1)
     , rct_uni_10389             varchar2(1)
     , rct_rend_min_legge        number(10,2)
     , rct_check_list_1          varchar2(1)
     , rct_check_list_2          varchar2(1)
     , rct_check_list_3          varchar2(1)
     , rct_check_list_4          varchar2(1)
     , rct_gruppo_termico        varchar2(2)
     , rct_valv_sicurezza        varchar2(1)

     , fr_linee_ele           varchar2(1) --1
     , fr_coibentazione       varchar2(1) --2
     , fr_assorb_recupero     varchar2(1) --3
     , fr_assorb_fiamma       varchar2(1) --4
     , fr_ciclo_compressione  varchar2(1) --5
     , fr_assenza_perdita_ref varchar2(1) --6
     , fr_leak_detector       varchar2(1) --7
     , fr_pres_ril_fughe      varchar2(1) --8
     , fr_scambiatore_puliti  varchar2(1) --9
     , fr_prova_modalita      varchar2(1) --10
     , fr_surrisc             number(10,2) --11
     , fr_sottoraff           number(10,2) --12
     , fr_tcondens            number(10,2) --13
     , fr_tevapor             number(10,2) --14
     , fr_t_ing_lato_est      number(10,2) --15
     , fr_t_usc_lato_est      number(10,2) --16
     , fr_t_ing_lato_ute      number(10,2) --17
     , fr_t_usc_lato_ute      number(10,2) --18
     , fr_nr_circuito         number(10,0) --19
     , fr_check_list_1        varchar2(01) --20
     , fr_check_list_2        varchar2(01) --21
     , fr_check_list_3        varchar2(01)  --22
     , fr_check_list_4        varchar2(01) --23

     , rct_lib_uso_man_comp   varchar2(01)
     , rct_modulo_termico     varchar2(08) -- 2014-06-27

     , data_prox_manut          date

     ) tablespace &ts_dat;

create unique index coimdimp_00
    on coimdimp
     ( cod_dimp
     ) tablespace &ts_idx; 

create        index coimdimp_01
     on coimdimp
     ( cod_impianto
     , data_controllo
     ) tablespace &ts_idx; 

create        index coimdimp_02
    on coimdimp
     ( riferimento_pag
     , tipologia_costo
     ) tablespace &ts_idx;
