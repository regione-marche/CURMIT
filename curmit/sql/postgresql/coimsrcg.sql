/*==============================================================*/
/* table coimsrcg: Scheda rapporto centrale gasolio PRTN        */
/*==============================================================*/
create table coimsrcg
     ( cod_cimp                       varchar(08)  not null
     , accesso_esterno                char(01) 
     , piano_grigliato                char(01)
     , intercapedine                  char(01)
     , portaincomb_acc_esterno        char(01)
     , portaincomb_acc_esterno_mag116 char(01)
     , dimensioni_porta               char(01)
     , accesso_interno                char(01)
     , disimpegno                     char(01)
     , struttura_disimp_verificabile  char(01)
     , da_disimpegno_con_lato         char(01)
     , da_disimpegno_senza_lato       char(01)
     , aerazione_disimpegno           char(01)
     , aerazione_tramite_condotto     char(01)
     , porta_disimpegno               char(01)
     , porta_caldaia                  char(01)
     , loc_caldaia_rei_60             char(01)
     , loc_caldaia_rei_120            char(01)
     , valvola_strappo                char(01)
     , interruttore_gasolio           char(01)
     , estintore                      char(01)
     , bocca_di_lupo                  char(01)
     , parete_confinante_esterno      char(01)
     , altezza_locale                 char(01)
     , altezza_230                    char(01)
     , altezza_250                    char(01)
     , distanza_generatori            char(01)
     , distanza_soff_invol_bollit     char(01)
     , distanza_soff_invol_no_bollit  char(01)
     , pavimento_imperm_soglia        char(01)
     , apert_vent_sino_500000         char(01)
     , apert_vent_sino_750000         char(01)
     , apert_vent_sup_750000          char(01)
     , certif_ispels                  char(01)
     , certif_cpi                     char(01)
     , serbatoio_esterno              char(01)
     , serbatoio_interno              char(01)
     , serbatoio_loc_caldaia          char(01)
     , sfiato_reticella_h             char(01)
     , segn_valvola_strappo           char(01)
     , segn_interrut_generale         char(01)
     , segn_estintore                 char(01)
     , segn_centrale_termica          char(01)
     ) ; 

create unique index coimsrcg_00
    on coimsrcg
     ( cod_cimp
     );

alter table coimsrcg 
  add constraint chk_accesso_esterno_coimsrcg 
check (accesso_esterno in ('O', 'S', 'N'));

alter table coimsrcg
  add constraint chk_piano_grigliato_coimsrcg
check (piano_grigliato in ('O', 'S', 'N'));

alter table coimsrcg
  add constraint chk_intercapedine_coimsrcg
check (intercapedine in ('O', 'S', 'N'));

alter table coimsrcg
  add constraint chk_portaincomb_acc_esterno_coimsrcg
check (portaincomb_acc_esterno in ('O', 'S', 'N'));

alter table coimsrcg
  add constraint chk_portaincomb_acc_esterno_mag116_coimsrcg
check (portaincomb_acc_esterno_mag116 in ('O', 'S', 'N'));

alter table coimsrcg
  add constraint chk_dimensioni_porta_coimsrcg
check (dimensioni_porta in ('O', 'S', 'N'));

alter table coimsrcg
  add constraint chk_accesso_interno_coimsrcg
check (accesso_interno in ('O', 'S', 'N'));

alter table coimsrcg
  add constraint chk_disimpegno_coimsrcg
check (disimpegno in ('O', 'S', 'N'));

alter table coimsrcg
  add constraint chk_struttura_disimp_verificabile_coimsrcg
check (struttura_disimp_verificabile in ('O', 'S', 'N'));

alter table coimsrcg
  add constraint chk_da_disimpegno_con_lato_coimsrcg  
check (da_disimpegno_con_lato in ('O', 'S', 'N'));

alter table coimsrcg
  add constraint chk_da_disimpegno_senza_lato_coimsrcg
check (da_disimpegno_senza_lato in ('O', 'S', 'N'));

alter table coimsrcg
  add constraint chk_aerazione_disimpegno_coimsrcg
check (aerazione_disimpegno in ('O', 'S', 'N'));

alter table coimsrcg
  add constraint chk_aerazione_tramite_condotto_coimsrcg
check (aerazione_tramite_condotto in ('O', 'S', 'N'));

alter table coimsrcg
  add constraint chk_porta_disimpegno_coimsrcg
check (porta_disimpegno in ('O', 'S', 'N'));

alter table coimsrcg
  add constraint chk_porta_caldaia_coimsrcg             
check (porta_caldaia in ('O', 'S', 'N'));

alter table coimsrcg
  add constraint chk_loc_caldaia_rei_60_coimsrcg        
check (loc_caldaia_rei_60 in ('O', 'S', 'N'));

alter table coimsrcg
  add constraint chk_loc_caldaia_rei_120_coimsrcg       
check (loc_caldaia_rei_120 in ('O', 'S', 'N'));

alter table coimsrcg
  add constraint chk_valvola_strappo_coimsrcg           
check (valvola_strappo in ('O', 'S', 'N'));

alter table coimsrcg
  add constraint chk_interruttore_gasolio_coimsrcg      
check (interruttore_gasolio in ('O', 'S', 'N'));

alter table coimsrcg
  add constraint chk_estintore_coimsrcg                 
check (estintore in ('O', 'S', 'N'));

alter table coimsrcg
  add constraint chk_bocca_di_lupo_coimsrcg             
check (bocca_di_lupo in ('O', 'S', 'N'));

alter table coimsrcg
  add constraint chk_parete_confinante_esterno_coimsrcg 
check (parete_confinante_esterno in ('O', 'S', 'N'));

alter table coimsrcg
  add constraint chk_altezza_locale_coimsrcg               
check (altezza_locale in ('O', 'S', 'N'));

alter table coimsrcg
  add constraint chk_altezza_230_coimsrcg                  
check (altezza_230 in ('O', 'S', 'N'));

alter table coimsrcg
  add constraint chk_altezza_250_coimsrcg                  
check (altezza_250 in ('O', 'S', 'N'));

alter table coimsrcg
  add constraint chk_distanza_generatori_coimsrcg          
check (distanza_generatori in ('O', 'S', 'N'));

alter table coimsrcg
  add constraint chk_distanza_soff_invol_bollit_coimsrcg   
check (distanza_soff_invol_bollit in ('O', 'S', 'N'));

alter table coimsrcg
  add constraint chk_distanza_soff_invol_no_bollit_coimsrcg
check (distanza_soff_invol_no_bollit in ('O', 'S', 'N'));

alter table coimsrcg
  add constraint chk_pavimento_imperm_soglia_coimsrcg      
check (pavimento_imperm_soglia in ('O', 'S', 'N'));

alter table coimsrcg
  add constraint chk_apert_vent_sino_500000_coimsrcg       
check (apert_vent_sino_500000 in ('O', 'S', 'N'));

alter table coimsrcg
  add constraint chk_apert_vent_sino_750000_coimsrcg       
check (apert_vent_sino_750000 in ('O', 'S', 'N'));

alter table coimsrcg
  add constraint chk_apert_vent_sup_750000_coimsrcg        
check (apert_vent_sup_750000 in ('O', 'S', 'N'));

alter table coimsrcg
  add constraint chk_certif_ispels_coimsrcg                
check (certif_ispels in ('O', 'S', 'N'));

alter table coimsrcg
  add constraint chk_certif_cpi_coimsrcg                   
check (certif_cpi in ('O', 'S', 'N'));

alter table coimsrcg
  add constraint chk_serbatoio_esterno_coimsrcg            
check (serbatoio_esterno in ('O', 'S', 'N'));

alter table coimsrcg
  add constraint chk_serbatoio_interno_coimsrcg            
check (serbatoio_interno in ('O', 'S', 'N'));

alter table coimsrcg
  add constraint chk_serbatoio_loc_caldaia_coimsrcg        
check (serbatoio_loc_caldaia in ('O', 'S', 'N'));

alter table coimsrcg
  add constraint chk_sfiato_reticella_h_coimsrcg           
check (sfiato_reticella_h in ('O', 'S', 'N'));

alter table coimsrcg
  add constraint chk_segn_valvola_strappo_coimsrcg         
check (segn_valvola_strappo in ('O', 'S', 'N'));

alter table coimsrcg
  add constraint chk_segn_interrut_generale_coimsrcg       
check (segn_interrut_generale in ('O', 'S', 'N'));

alter table coimsrcg
  add constraint chk_segn_estintore_coimsrcg               
check (segn_estintore in ('O', 'S', 'N'));

alter table coimsrcg
  add constraint chk_segn_centrale_termica_coimsrcg
check (segn_centrale_termica in ('O', 'S', 'N'));
