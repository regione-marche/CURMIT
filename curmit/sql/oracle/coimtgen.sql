/*==============================================================*/
/* table coimtgen: tebella dati generali                        */
/*==============================================================*/

create table coimtgen
     ( cod_tgen             varchar2(08) not null
     , valid_mod_h          number(08)   not null
     , gg_comunic_mod_h     number(08)    
     , flag_ente            char(01)     not null
     , cod_prov             varchar2(08) not null
     , cod_comu             varchar2(08)
     , flag_viario          char(01)     not null
     , flag_mod_h_b         char(01)     not null
     , valid_mod_h_b        number(08)    
     , gg_comunic_mod_h_b   number(08)    
     , data_ins             date 
     , data_mod             date
     , utente_ult           varchar2(10)
     , gg_conferma_inco     number(08)
     , gg_scad_pag_mh       number(03) 
     , mesi_evidenza_mod    number(02)
     , flag_agg_sogg        char(01)
     , flag_dt_scad         char(01)
     , flag_agg_da_verif    char(01)
     , flag_cod_aimp_auto   char(01)
     , flag_gg_modif_mh     number(04)
     , flag_gg_modif_rv     number(04)
     , gg_scad_pag_rv       number(03) 
     , gg_adat_anom_oblig   char(01)
     , gg_adat_anom_autom   char(01)	
     , popolaz_citt_tgen    number(07)
     , popolaz_aimp_tgen    number(07)
     , flag_aimp_citt_estr  char(01)
     , flag_stat_estr_calc  char(01)
     , flag_cod_via_auto    char(01)
     , link_cap             varchar(500)
     , flag_enti_compet     char(01)
     , flag_master_ente     char(01)
     , flag_stp_presso_terzo_resp char(01) not null default 'F'
     , flag_portale         char(01)       not null default 'F' -- 2013-12-11
     , flag_gest_coimmode   char(01)       not null default 'F' -- 2014-03-04
     , lun_num_cod_imp_est  number(02)     not null default 6   -- 2016-02-04
     , flag_potenza         varchar(50)    not null default 'pot_focolare_nom' -- 2016-02-12
     -- Valori possibili: pot_utile_nom, pot_focolare_nom
     ) tablespace &ts_dat;

create unique index coimtgen_00
    on coimtgen
     ( cod_tgen
     ) tablespace &ts_idx;
