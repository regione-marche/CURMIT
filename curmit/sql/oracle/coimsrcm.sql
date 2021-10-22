/*==============================================================*/
/* table coimsrcm: Scheda rapporto centrale metano  PRTN        */
/*==============================================================*/
create table coimsrcm
     ( cod_cimp                       varchar(08)  not null
     , accesso_esterno                char(01) 
     , se_intercapedine               char(01)
     , intercapedine                  char(01)
     , porta_classe_0                 char(01)
     , porta_con_apertura_esterno     char(01)
     , dimensioni_porta               char(01)
     , acces_interno                  char(01)
     , disimpegno                     char(01)
     , da_disimp_con_lato_est         char(01)
     , da_disimp_rei_30               char(01)
     , da_disimp_rei_60               char(01)
     , aeraz_disimpegno               char(01)
     , condotta_aeraz_disimp          char(01)
     , porta_caldaia_rei_30           char(01)
     , porta_caldaia_rei_60           char(01)
     , valvola_interc_combustibile    char(01)
     , interr_generale_luce           char(01)
     , estintore                      char(01)
     , parete_conf_esterno            char(01)
     , alt_locale_2                   char(01)
     , alt_locale_2_30                char(01)
     , alt_locale_2_60                char(01)
     , alt_locale_2_90                char(01)
     , dispos_di_sicurezza            char(01)
     , ventilazione_qx10              char(01)
     , ventilazione_qx15              char(01)
     , ventilazione_qx20              char(01)
     , ventilazione_qx15_gpl          char(01)
     , ispels                         char(01)
     , cpi                            char(01)
     , valv_interc_comb_segnaletica   char(01)
     , int_gen_luce_segnaletica       char(01)
     , centr_termica_segnaletica      char(01)
     , estintore_segnaletica          char(01)
     , rampa_a_gas_norma              char(01)
     ) tablespace &ts_dat; 

create unique index coimsrcm_00
    on coimsrcm
     ( cod_cimp
     ) tablespace &ts_idx;

alter table coimsrcm 
  add constraint chk_accesso_esterno_coimsrcm_coimsrcm
check (accesso_esterno in ('O', 'S', 'N'));

alter table coimsrcm
  add constraint chk_se_intercapedine_coimsrcm
check (se_intercapedine in ('O', 'S', 'N'));

alter table coimsrcm
  add constraint chk_porta_classe_0_coimsrcm
check (porta_classe_0 in ('O', 'S', 'N'));

alter table coimsrcm
  add constraint chk_porta_con_apertura_esterno_coimsrcm
check (porta_con_apertura_esterno in ('O', 'S', 'N'));

alter table coimsrcm
  add constraint chk_dimensioni_porta_coimsrcm
check (dimensioni_porta in ('O', 'S', 'N'));

alter table coimsrcm
  add constraint chk_acces_interno_coimsrcm
check (acces_interno in ('O', 'S', 'N'));

alter table coimsrcm
  add constraint chk_disimpegno_coimsrcm
check (disimpegno in ('O', 'S', 'N'));

alter table coimsrcm
  add constraint chk_da_disimp_con_lato_est_coimsrcm
check (da_disimp_con_lato_est in ('O', 'S', 'N'));

alter table coimsrcm
  add constraint chk_da_disimp_rei_30_coimsrcm     
check (da_disimp_rei_30 in ('O', 'S', 'N'));

alter table coimsrcm
  add constraint chk_da_disimp_rei_60_coimsrcm
check (da_disimp_rei_60 in ('O', 'S', 'N'));

alter table coimsrcm
  add constraint chk_aeraz_disimpegno_coimsrcm
check (aeraz_disimpegno in ('O', 'S', 'N'));

alter table coimsrcm
  add constraint chk_condotta_aeraz_disimp_coimsrcm
check (condotta_aeraz_disimp in ('O', 'S', 'N'));

alter table coimsrcm
  add constraint chk_porta_caldaia_rei_30_coimsrcm
check (porta_caldaia_rei_30 in ('O', 'S', 'N'));

alter table coimsrcm
  add constraint chk_porta_caldaia_rei_60_coimsrcm
check (porta_caldaia_rei_60 in ('O', 'S', 'N'));

alter table coimsrcm
  add constraint chk_valvola_interc_combustibile_coimsrcm
check (valvola_interc_combustibile in ('O', 'S', 'N'));

alter table coimsrcm
  add constraint chk_interr_generale_luce_coimsrcm
check (interr_generale_luce in ('O', 'S', 'N'));

alter table coimsrcm
  add constraint chk_estintore_coimsrcm  
check (estintore in ('O', 'S', 'N'));

alter table coimsrcm
  add constraint chk_parete_conf_esterno_coimsrcm
check (parete_conf_esterno in ('O', 'S', 'N'));

alter table coimsrcm
  add constraint chk_alt_locale_2_coimsrcm     
check (alt_locale_2 in ('O', 'S', 'N'));

alter table coimsrcm
  add constraint chk_alt_locale_2_30_coimsrcm     
check (alt_locale_2_30 in ('O', 'S', 'N'));

alter table coimsrcm
  add constraint chk_alt_locale_2_60_coimsrcm
check (alt_locale_2_60 in ('O', 'S', 'N'));

alter table coimsrcm
  add constraint chk_alt_locale_2_90_coimsrcm     
check (alt_locale_2_90 in ('O', 'S', 'N'));

alter table coimsrcm
  add constraint chk_dispos_di_sicurezza_coimsrcm 
check (dispos_di_sicurezza in ('O', 'S', 'N'));

alter table coimsrcm
  add constraint chk_ventilazione_qx10_coimsrcm   
check (ventilazione_qx10 in ('O', 'S', 'N'));

alter table coimsrcm
  add constraint chk_ventilazione_qx15_coimsrcm
check (ventilazione_qx15 in ('O', 'S', 'N'));

alter table coimsrcm
  add constraint chk_ventilazione_qx20_coimsrcm
check (ventilazione_qx20 in ('O', 'S', 'N'));

alter table coimsrcm
  add constraint chk_ventilazione_qx15_gpl_coimsrcm
check (ventilazione_qx15_gpl in ('O', 'S', 'N'));

alter table coimsrcm
  add constraint chk_ispels_coimsrcm
check (ispels in ('O', 'S', 'N'));

alter table coimsrcm
  add constraint chk_cpi_coimsrcm
check (cpi in ('O', 'S', 'N'));

alter table coimsrcm
  add constraint chk_valv_interc_comb_segnaletica_coimsrcm
check (valv_interc_comb_segnaletica in ('O', 'S', 'N'));

alter table coimsrcm
  add constraint chk_int_gen_luce_segnaletica_coimsrcm
check (int_gen_luce_segnaletica in ('O', 'S', 'N'));

alter table coimsrcm
  add constraint chk_centr_termica_segnaletica_coimsrcm        
check (centr_termica_segnaletica in ('O', 'S', 'N'));

alter table coimsrcm
  add constraint chk_estintore_segnaletica_coimsrcm
check (estintore_segnaletica in ('O', 'S', 'N'));

alter table coimsrcm
  add constraint chk_rampa_a_gas_norma_coimsrcm
check (rampa_a_gas_norma in ('O', 'S', 'N'));

