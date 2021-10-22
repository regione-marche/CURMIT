/*==============================================================*/
/* table coimsrdg: Scheda rapporto deposito gasolio PRTN        */
/*==============================================================*/
create table coimsrdg
     ( cod_cimp                       varchar(08)  not null
     , loc_escl_deposito_gasolio      char(01) 
     , dep_gasolio_esterno            char(01)
     , accesso_ester_con_porta        char(01)
     , loc_materiale_incombustibile   char(01)
     , non_meno_50_cm                 char(01)
     , soglia_pavimento               char(01)
     , tra_pareti_60_cm               char(01)
     , comun_con_altri_loc            char(01)
     , dep_serb_in_vista_aperto       char(01)
     , tettoia_all_aperto             char(01)
     , bacino_contenimento            char(01)
     , messa_a_terra                  char(01)
     , dep_gasolio_interno_interrato  char(01)
     , porta_solaio_pareti_rei90      char(01)
     , struttura_locale_a_norma       char(01)
     , dep_gasolio_interno            char(01)
     , locale_caratteristiche_rei120  char(01)
     , accesso_esterno                char(01)
     , porta_esterna_incombustibile   char(01)
     , disimpegno                     char(01)
     , accesso_interno                char(01)
     , da_disimp_lato_esterno         char(01)
     , da_disimp_senza_lato_esterno   char(01)
     , aeraz_disimp_05_mq             char(01)
     , aeraz_disimp_condotta          char(01)
     , porta_disimp                   char(01)
     , comunic_con_altri_loc          char(01)
     , porta_deposito                 char(01)
     , porta_deposito_h_2_l_08        char(01)
     , tubo_sfiato                    char(01)
     , selle_50_cm_terra              char(01)
     , pavimento_impermeabile         char(01)
     , tra_serb_e_pareti              char(01)
     , valvola_a_strappo              char(01)
     , interruttore_forza_luce        char(01)
     , estintore                      char(01)
     , parete_conf_esterno            char(01)
     , ventilazione_locale            char(01)
     , segn_valvola_strappo           char(01)
     , segn_inter_forza_luce          char(01)
     , segn_estintore                 char(01)
     ) ; 

create unique index coimsrdg_00
    on coimsrdg
     ( cod_cimp
     );

alter table coimsrdg 
  add constraint chk_loc_escl_deposito_gasolio_coimsrdg 
check (loc_escl_deposito_gasolio in ('O', 'S', 'N'));

alter table coimsrdg
  add constraint chk_dep_gasolio_esterno_coimsrdg
check (dep_gasolio_esterno in ('O', 'S', 'N'));

alter table coimsrdg
  add constraint chk_accesso_ester_con_porta_coimsrdg
check (accesso_ester_con_porta in ('O', 'S', 'N'));

alter table coimsrdg
  add constraint chk_loc_materiale_incombustibile_coimsrdg
check (loc_materiale_incombustibile in ('O', 'S', 'N'));

alter table coimsrdg
  add constraint chk_non_meno_50_cm_coimsrdg
check (non_meno_50_cm in ('O', 'S', 'N'));

alter table coimsrdg
  add constraint chk_soglia_pavimento_coimsrdg
check (soglia_pavimento in ('O', 'S', 'N'));

alter table coimsrdg
  add constraint chk_tra_pareti_60_cm_coimsrdg
check (tra_pareti_60_cm in ('O', 'S', 'N'));

alter table coimsrdg
  add constraint chk_comun_con_altri_loc_coimsrdg
check (comun_con_altri_loc in ('O', 'S', 'N'));

alter table coimsrdg
  add constraint chk_dep_serb_in_vista_aperto_coimsrdg
check (dep_serb_in_vista_aperto in ('O', 'S', 'N'));

alter table coimsrdg
  add constraint chk_tettoia_all_aperto_coimsrdg  
check (tettoia_all_aperto in ('O', 'S', 'N'));

alter table coimsrdg
  add constraint chk_bacino_contenimento_coimsrdg
check (bacino_contenimento in ('O', 'S', 'N'));

alter table coimsrdg
  add constraint chk_messa_a_terra_coimsrdg
check (messa_a_terra in ('O', 'S', 'N'));

alter table coimsrdg
  add constraint chk_dep_gasolio_interno_interrato_coimsrdg
check (dep_gasolio_interno_interrato in ('O', 'S', 'N'));

alter table coimsrdg
  add constraint chk_porta_solaio_pareti_rei90_coimsrdg
check (porta_solaio_pareti_rei90 in ('O', 'S', 'N'));

alter table coimsrdg
  add constraint chk_struttura_locale_a_norma_coimsrdg             
check (struttura_locale_a_norma in ('O', 'S', 'N'));

alter table coimsrdg
  add constraint chk_dep_gasolio_interno_coimsrdg        
check (dep_gasolio_interno in ('O', 'S', 'N'));

alter table coimsrdg
  add constraint chk_locale_caratteristiche_rei120_coimsrdg       
check (locale_caratteristiche_rei120 in ('O', 'S', 'N'));

alter table coimsrdg
  add constraint chk_accesso_esterno_coimsrdg           
check (accesso_esterno in ('O', 'S', 'N'));

alter table coimsrdg
  add constraint chk_porta_esterna_incombustibile_coimsrdg      
check (porta_esterna_incombustibile in ('O', 'S', 'N'));

alter table coimsrdg
  add constraint chk_disimpegno_coimsrdg                 
check (disimpegno in ('O', 'S', 'N'));

alter table coimsrdg
  add constraint chk_accesso_interno_coimsrdg             
check (accesso_interno in ('O', 'S', 'N'));

alter table coimsrdg
  add constraint chk_da_disimp_lato_esterno_coimsrdg 
check (da_disimp_lato_esterno in ('O', 'S', 'N'));

alter table coimsrdg
  add constraint chk_da_disimp_senza_lato_esterno_coimsrdg               
check (da_disimp_senza_lato_esterno in ('O', 'S', 'N'));

alter table coimsrdg
  add constraint chk_aeraz_disimp_05_mq_coimsrdg                  
check (aeraz_disimp_05_mq in ('O', 'S', 'N'));

alter table coimsrdg
  add constraint chk_aeraz_disimp_condotta_coimsrdg                  
check (aeraz_disimp_condotta in ('O', 'S', 'N'));

alter table coimsrdg
  add constraint chk_porta_disimp_coimsrdg          
check (porta_disimp in ('O', 'S', 'N'));

alter table coimsrdg
  add constraint chk_comunic_con_altri_loc_coimsrdg   
check (comunic_con_altri_loc in ('O', 'S', 'N'));

alter table coimsrdg
  add constraint chk_porta_deposito_coimsrdg
check (porta_deposito in ('O', 'S', 'N'));

alter table coimsrdg
  add constraint chk_porta_deposito_h_2_l_08_coimsrdg      
check (porta_deposito_h_2_l_08 in ('O', 'S', 'N'));

alter table coimsrdg
  add constraint chk_tubo_sfiato_coimsrdg       
check (tubo_sfiato in ('O', 'S', 'N'));

alter table coimsrdg
  add constraint chk_selle_50_cm_terra_coimsrdg      
check (selle_50_cm_terra in ('O', 'S', 'N'));

alter table coimsrdg
  add constraint chk_pavimento_impermeabile_coimsrdg        
check (pavimento_impermeabile in ('O', 'S', 'N'));

alter table coimsrdg
  add constraint chk_tra_serb_e_pareti_coimsrdg                
check (tra_serb_e_pareti in ('O', 'S', 'N'));

alter table coimsrdg
  add constraint chk_valvola_a_strappo_coimsrdg                   
check (valvola_a_strappo in ('O', 'S', 'N'));

alter table coimsrdg
  add constraint chk_interruttore_forza_luce_coimsrdg            
check (interruttore_forza_luce in ('O', 'S', 'N'));

alter table coimsrdg
  add constraint chk_estintore_coimsrdg            
check (estintore in ('O', 'S', 'N'));

alter table coimsrdg
  add constraint chk_parete_conf_esterno_coimsrdg        
check (parete_conf_esterno in ('O', 'S', 'N'));

alter table coimsrdg
  add constraint chk_ventilazione_locale_coimsrdg           
check (ventilazione_locale in ('O', 'S', 'N'));

alter table coimsrdg
  add constraint chk_segn_valvola_strappo_coimsrdg         
check (segn_valvola_strappo in ('O', 'S', 'N'));

alter table coimsrdg
  add constraint chk_segn_inter_forza_luce_coimsrdg       
check (segn_inter_forza_luce  in ('O', 'S', 'N'));

alter table coimsrdg
  add constraint chk_segn_estintore_coimsrdg               
check (segn_estintore in ('O', 'S', 'N'));
