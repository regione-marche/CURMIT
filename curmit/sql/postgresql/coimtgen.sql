/*==============================================================*/
/* table coimtgen: tebella dati generali                        */
/*==============================================================*/

create table coimtgen
     ( cod_tgen             varchar(08)    not null
     , valid_mod_h          numeric(08)    not null
     , gg_comunic_mod_h     numeric(08)    
     , flag_ente            char(01)       not null
     , cod_prov             varchar(08)    not null
     , cod_comu             varchar(08)
     , flag_viario          char(01)       not null
     , flag_mod_h_b         char(01)       not null
     , valid_mod_h_b        numeric(08)  
     , gg_comunic_mod_h_b   numeric(08)    
     , data_ins             date 
     , data_mod             date
     , utente_ult           varchar(10)
     , gg_conferma_inco     numeric(08)
     , gg_scad_pag_mh       numeric(03)
     , mesi_evidenza_mod    numeric(02)
     , flag_agg_sogg        char(01)
     , flag_dt_scad         char(01)
     , flag_agg_da_verif    char(01)
     , flag_cod_aimp_auto   char(01)
     , flag_gg_modif_mh     numeric(04)
     , flag_gg_modif_rv     numeric(04)
     , gg_scad_pag_rv       numeric(03)
     , gg_adat_anom_oblig   char(01)
     , gg_adat_anom_autom   char(01)	
     , popolaz_citt_tgen    numeric(07)
     , popolaz_aimp_tgen    numeric(07)
     , flag_aimp_citt_estr  char(01)
     , flag_stat_estr_calc  char(01)
     , flag_cod_via_auto    char(01)
     , link_cap             varchar(500)
     , flag_enti_compet     char(01)
     , flag_master_ente     char(01)
     , gb_x                 varchar(50)
     , gb_y                 varchar(50)
     , delta                varchar(50)
     , google_key           varchar(86)
     , flag_codifica_reg    char(01)
     , flag_pesi            char(01)
     , flag_sanzioni        char(01)
     , flag_avvisi          char(01)
     , flag_mod_gend        char(01)
     , flag_asse_data       char(01)
     , flag_obbligo_canne   char(01)
     , flag_default_contr_fumi char(01)
     , cod_imst_cari_manu   char(01)
     , flag_portafoglio     char(01)
     , numincora            integer        -- 2014-05-28
     , flag_stp_presso_terzo_resp char(01) not null default 'F'
     , flag_portale         char(01)       not null default 'F' -- 2013-12-11
     , flag_gest_coimmode   char(01)       not null default 'F' -- 2014-03-04
     , lun_num_cod_imp_est  numeric(02)    not null default 6   -- 2016-02-04
     , flag_potenza         varchar(50)    not null default 'pot_focolare_nom' -- 2016-02-12
     -- Valori possibili: pot_utile_nom, pot_focolare_nom
     , flag_gest_targa      char(01)       not null default 'F' -- 2016-09-09
     , flag_gest_rcee_legna char(01)       not null default 'F' -- 2017-02-20
     --rom01 Aggiunti campi per la pec.
     , indirizzo_pec        varchar(100) --rom01 2018-03-21
     , nome_utente_pec      varchar(100) --rom01 2018-03-21
     , password_pec         varchar(50)  --rom01 2018-03-21
     , stmp_pec             varchar(50)  --rom01 2018-03-21
     , porta_uscita_pec     varchar(50)  --rom01 2018-03-21
     );

create unique index coimtgen_00
    on coimtgen
     ( cod_tgen
     );
