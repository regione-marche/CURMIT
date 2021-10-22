/*==============================================================*/
/* table coimaimp: tabella anagrafica impianti                  */
/*==============================================================*/

create table coimaimp
     ( cod_impianto       varchar2(08)  not null
     , cod_impianto_est   varchar2(20)
     , cod_impianto_prov  varchar2(08)
     , descrizione        varchar2(50)
    -- provenienza_dati decodificato in coimtppr (1=Archivio fornitore...)
     , provenienza_dati   char(01)   
     , cod_combustibile   varchar2(08)
     , cod_potenza        varchar2(08)
     -- potenza termica focolare nominale totale
     , potenza            number(9,2) 
     -- potenza termica utile nominale totale
     , potenza_utile      number(9,2)
     , data_installaz     date         
     , data_attivaz       date
     , data_rottamaz      date
     , note               varchar2(4000)
     , stato              char(01)
     , flag_dichiarato    char(01)
     , data_prima_dich    date
     , data_ultim_dich    date
     -- tipologia da tabella coimtpim
     , cod_tpim           varchar2(08)
     , consumo_annuo      number(9,2)
     , n_generatori       number(2)
     -- tariffa 03 = riscald. superiore 100kw
     --         04 = riscald. autonomo e acqua calda
     --         05 = riscald. centralizzato
     --         07 = riscald. centralizzato piccoli condomini
     , stato_conformita   char(01)
     -- codice categoria edificio
     , cod_cted           varchar2(08)
     , tariffa            varchar2(08)
     , cod_responsabile   varchar2(08)
     , flag_resp          char(01)
     , cod_intestatario   varchar2(08)
     , flag_intestatario  char(01)
     , cod_proprietario   varchar2(08)
     , cod_occupante      varchar2(08)
     , cod_amministratore varchar2(08)
     , cod_manutentore    varchar2(08)
     , cod_installatore   varchar2(08)
     , cod_distributore   varchar2(08)
     , cod_progettista    varchar2(08)
     , cod_amag           varchar2(10)
     , cod_ubicazione     varchar2(08)
     , localita           varchar2(40)
     , cod_via            varchar2(08)
     , toponimo           varchar2(20)
     , indirizzo          varchar2(100)
     , numero             varchar2(08)
     , esponente          varchar2(03)
     , scala              varchar2(05)
     , piano              varchar2(05)
     , interno            varchar2(03)
     , cod_comune         varchar2(08)
     , cod_provincia      varchar2(08)
     , cap                varchar2(05)
--2014-05-28     , cod_catasto        varchar2(20)
     , foglio             varchar2(20) --2014-05-28
     , cod_tpdu           varchar2(08)
     , cod_qua            varchar2(08)
     , cod_urb            varchar2(08)
     , data_ins           date
     , data_mod           date
     , utente             varchar2(10)
     , flag_dpr412        char(01)
     , cod_impianto_dest  varchar2(08)
     , anno_costruzione   date
-- marcatura efficienza energetica
     , marc_effic_energ   varchar2(10)
     , volimetria_risc    number(9,2)
     , gb_x               varchar2(50)
     , gb_y               varchar2(50)
     , data_scad_dich     date
     , flag_tipo_impianto varchar2(01) -- R=Riscaldamento, T=Teleriscaldamento, C=Cogenerazione, F=Raffreddamento, Blank=Tutti
     , mappale            varchar2(20)
     , denominatore       varchar2(20)
     , subalterno         varchar2(20)
     , cod_distributore_el varchar2(08) -- 2014-06-30
     , pdr                 varchar2(20) -- 2014-06-30
     , pod                 varchar2(20) -- 2014-06-30
     , cod_impianto_princ  varchar2(08) -- Codice impianto principale, Simone 2014-09-11
     , cat_catastale       varchar2(20) -- Categoria catastale (per Rimini), Sandro 2014-09-16
     , pres_certificazione char(1)
     , certificazione      varchar2(80)
     , tratt_acqua_contenuto                    number(10,2)
     , tratt_acqua_durezza                      number(9,2)
     , tratt_acqua_clima_tipo                   char(1)
     , tratt_acqua_clima_addolc                 number(9,2)
     , tratt_acqua_clima_prot_gelo              char(1)
     , tratt_acqua_clima_prot_gelo_eti          number(9,2)
     , tratt_acqua_clima_prot_gelo_eti_perc     number(9,2)
     , tratt_acqua_clima_prot_gelo_pro          number(9,2)
     , tratt_acqua_clima_prot_gelo_pro_perc     number(9,2)
     , tratt_acqua_calda_sanit_tipo             char(1)
     , tratt_acqua_calda_sanit_addolc           number(9,2)
     , tratt_acqua_raff_assente                 char(1)
     , tratt_acqua_raff_tipo_circuito           char(1)
     , tratt_acqua_raff_origine                 char(1)
     , tratt_acqua_raff_filtraz_flag            char(1)
     , tratt_acqua_raff_filtraz_1               char(1)
     , tratt_acqua_raff_filtraz_2               char(1)
     , tratt_acqua_raff_filtraz_3               char(1)
     , tratt_acqua_raff_filtraz_4               char(1)
     , tratt_acqua_raff_tratt_flag              char(1)
     , tratt_acqua_raff_tratt_1                 char(1)
     , tratt_acqua_raff_tratt_2                 char(1)
     , tratt_acqua_raff_tratt_3                 char(1)
     , tratt_acqua_raff_tratt_4                 char(1)
     , tratt_acqua_raff_tratt_5                 char(1)
     , tratt_acqua_raff_cond_flag               char(1)
     , tratt_acqua_raff_cond_1                  char(1)
     , tratt_acqua_raff_cond_2                  char(1)
     , tratt_acqua_raff_cond_3                  char(1)
     , tratt_acqua_raff_cond_4                  char(1)
     , tratt_acqua_raff_cond_5                  char(1)
     , tratt_acqua_raff_cond_6                  char(1)
     , tratt_acqua_raff_spurgo_flag             char(1)
     , tratt_acqua_raff_spurgo_cond_ing         number(10,2)
     , tratt_acqua_raff_spurgo_tara_cond        number(10,2)

     , regol_on_off                     char(1)
     , regol_curva_integrata            char(1)

     , regol_curva_indipendente         char(1)
     , regol_curva_ind_iniz_data_inst   date
     , regol_curva_ind_iniz_data_dism   date
     , regol_curva_ind_iniz_fabbricante varchar2(30)
     , regol_curva_ind_iniz_modello     varchar2(30)
     , regol_curva_ind_iniz_n_punti_reg varchar2(20)
     , regol_curva_ind_iniz_n_liv_temp  varchar2(20)

     , regol_valv_regolazione           char(1)
     , regol_valv_ind_iniz_data_inst    date
     , regol_valv_ind_iniz_data_dism    date
     , regol_valv_ind_iniz_fabbricante  varchar2(30)
     , regol_valv_ind_iniz_modello      varchar2(30)
     , regol_valv_ind_iniz_n_vie        varchar2(20)
     , regol_valv_ind_iniz_servo_motore varchar2(20)

     , regol_sist_multigradino          char(1)
     , regol_sist_inverter              char(1)
     , regol_altri_flag                 char(1)
     , regol_altri_desc_sistema         varchar2(400)
     , regol_cod_tprg                   char(1)
     , regol_valv_termostatiche         char(1)
     , regol_valv_due_vie               char(1)
     , regol_valv_tre_vie               char(1)
     , regol_valv_note                  varchar2(400)

     , regol_telettura                  char(1)
     , regol_telegestione               char(1)
     , regol_desc_sistema_iniz          varchar2(400)
     , regol_data_sost_sistema          date
     , regol_desc_sistema_sost          varchar2(400)

     , contab_si_no                     char(1)
     , contab_tipo_contabiliz           char(1) -- R Riscladamento, F Raffrescamento, A acqua calda sanitaria
     , contab_tipo_sistema              char(1) -- D Diretto, I Indiretto
     , contab_desc_sistema_iniz         varchar2(400)
     , contab_data_sost_sistema         date
     , contab_desc_sistema_sost         varchar2(400)

     ) tablespace &ts_dat;

create unique index coimaimp_00
    on coimaimp
     ( cod_impianto
     ) tablespace &ts_idx;

create unique index coimaimp_01
    on coimaimp
     ( cod_impianto_est
     ) tablespace &ts_idx;

create index coimaimp_02
    on coimaimp
     ( cod_responsabile
     ) tablespace &ts_idx;

create index coimaimp_03
    on coimaimp
     ( cod_comune
     , cod_via
     ) tablespace &ts_idx;

create index coimaimp_04
    on coimaimp
     ( indirizzo
     ) tablespace &ts_idx;

create index coimaimp_05
    on coimaimp
     ( cod_comune
     , cod_qua
     ) tablespace &ts_idx;

create index coimaimp_06
    on coimaimp
     ( cod_distributore
     , cod_amag
     ) tablespace &ts_idx;

create index coimaimp_07
    on coimaimp
     ( cod_impianto_prov
     ) tablespace &ts_idx;

create index coimaimp_08
    on coimaimp
     ( cod_intestatario
     ) tablespace &ts_idx;

create index coimaimp_09
    on coimaimp
     ( cod_proprietario
     ) tablespace &ts_idx;

create index coimaimp_10
    on coimaimp
     ( cod_occupante
     ) tablespace &ts_idx;

create index coimaimp_11
    on coimaimp
     ( cod_amministratore
     ) tablespace &ts_idx;

create index coimaimp_14
    on coimaimp
     ( flag_tipo_impianto
     ) tablespace &ts_idx;

create index coimaimp_15
    on coimaimp
     ( cod_impianto_princ
     ) tablespace &ts_idx;

alter table coimaimp
  add constraint chk_flag_dichiarato_coimaimp
check (flag_dichiarato in ('S', 'N', 'C'));

create or replace trigger coimaimp_upper_tr
   before insert or update on coimaimp
      for each row
begin
   :new.cod_impianto_est := upper(:new.cod_impianto_est);
   :new.toponimo         := upper(:new.toponimo);
   :new.indirizzo        := upper(:new.indirizzo);
end coimaimp_upper_tr;
/
show errors
