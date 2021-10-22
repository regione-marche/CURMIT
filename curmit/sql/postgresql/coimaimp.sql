/*==============================================================*/
/* table coimaimp: tabella anagrafica impianti                  */
/*==============================================================*/

create table coimaimp
     ( cod_impianto        varchar(08)  not null
     , cod_impianto_est    varchar(20)
     , cod_impianto_prov   varchar(08)
     , descrizione         varchar(50)
    -- provenienza_dati decodificato in coimtppr (1=Archivio fornitore...)
     , provenienza_dati    char(01)   
     , cod_combustibile    varchar(08)
     , cod_potenza         varchar(08)
     -- potenza termica focolare nominale totale
     , potenza             numeric(9,2) 
     -- potenza termica utile nominale totale
     , potenza_utile       numeric(9,2)
     , data_installaz      date         
     , data_attivaz        date
     , data_rottamaz       date
     , note                varchar(4000)
     , stato               char(01)
     , flag_dichiarato     char(01)
     , data_prima_dich     date
     , data_ultim_dich     date
     -- tipologia da tabella coimtpim
     , cod_tpim            varchar(08)
     , consumo_annuo       numeric(9,2)
     , n_generatori        numeric(2)
     -- tariffa 03 = riscald. superiore 100kw
     --         04 = riscald. autonomo e acqua calda
     --         05 = riscald. centralizzato
     --         07 = riscald. centralizzato piccoli condomini
     , stato_conformita    char(01)
     -- codice categoria edificio
     , cod_cted            varchar(08)
     , tariffa             varchar(08)
     , cod_responsabile    varchar(08)
     , flag_resp           char(01)
     , cod_intestatario    varchar(08)
     , flag_intestatario   char(01)
     , cod_proprietario    varchar(08)
     , cod_occupante       varchar(08)
     , cod_amministratore  varchar(08)
     , cod_manutentore     varchar(08)
     , cod_installatore    varchar(08)
     , cod_distributore    varchar(08)
     , cod_progettista     varchar(08)
     , cod_amag            varchar(10)
     , cod_ubicazione      varchar(08)
     , localita            varchar(40)
     , cod_via             varchar(08)
     , toponimo            varchar(20)
     , indirizzo           varchar(100)
     , numero              varchar(08)
     , esponente           varchar(03)
     , scala               varchar(05)
     , piano               varchar(05)
     , interno             varchar(05)
     , cod_comune          varchar(08)
     , cod_provincia       varchar(08)
     , cap                 varchar(05)
--   , cod_catasto         varchar(20) 
     , foglio              varchar(20) -- 2014-05-28
     , cod_tpdu            varchar(08)
     , cod_qua             varchar(08)
     , cod_urb             varchar(08)
     , data_ins            date
     , data_mod            date
     , utente              varchar(10)
     , flag_dpr412         char(01)
     , cod_impianto_dest   varchar(08)
     , anno_costruzione    date
-- marcatura efficienza energetica
     , marc_effic_energ    varchar(10)
     , volimetria_risc     numeric (9,2)
     , gb_x                varchar(50)
     , gb_y                varchar(50)
     , data_scad_dich      date
     , flag_coordinate     varchar(2) default 'NO' not null
     , flag_targa_stampata char(01)
     , cod_impianto_old    varchar(20)
     , portata             numeric(9,2) 
     , palazzo             varchar(100)
     , n_unita_immob       numeric(9,0)
     , cod_tipo_attivita   varchar(8)
     , adibito_a           varchar(500)
     , utente_ins          varchar(10)
     , igni_progressivo    numeric(5,0)
     , cod_iterman         varchar(30)
     , flag_tipo_impianto  varchar(01) -- R=Riscaldamento, T=Teleriscaldamento, C=Cogenerazione, F=Raffreddamento, Blank=Tutti
     , mappale             varchar(20)
     , denominatore        varchar(20)
     , subalterno          varchar(20)
     , cod_distributore_el varchar(08) -- 2014-06-30
     , pdr                 varchar(20) -- 2014-06-30
     , pod                 varchar(20) -- 2014-06-30
     , cod_impianto_princ  varchar(08) -- Codice impianto principale, Simone 2014-09-11
     , cat_catastale	   varchar(20) -- Categoria catastale (per Rimini), Sandro 2014-09-16
     , sezione             varchar(20) -- LucaR. aggiunto su richiesta di Sandro 02/08/2018
     , pres_certificazione char(1)
     , certificazione      varchar(80)
     , tratt_acqua_contenuto                    numeric(10,2)
     , tratt_acqua_durezza                      numeric(9,2)
     , tratt_acqua_clima_tipo                   char(1)
     , tratt_acqua_clima_addolc                 numeric(9,2)
     , tratt_acqua_clima_prot_gelo              char(1)
     , tratt_acqua_clima_prot_gelo_eti          numeric(9,2)
     , tratt_acqua_clima_prot_gelo_eti_perc     numeric(9,2)
     , tratt_acqua_clima_prot_gelo_pro          numeric(9,2)
     , tratt_acqua_clima_prot_gelo_pro_perc     numeric(9,2)
     , tratt_acqua_calda_sanit_tipo             char(1)
     , tratt_acqua_calda_sanit_addolc           numeric(9,2)
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
     , tratt_acqua_raff_spurgo_cond_ing         numeric(10,2)
     , tratt_acqua_raff_spurgo_tara_cond        numeric(10,2)

     , regol_on_off                     char(1)
     , regol_curva_integrata            char(1)

     , regol_curva_indipendente         char(1)
     , regol_curva_ind_iniz_data_inst   date
     , regol_curva_ind_iniz_data_dism   date
     , regol_curva_ind_iniz_fabbricante varchar(30)
     , regol_curva_ind_iniz_modello     varchar(30)
     , regol_curva_ind_iniz_n_punti_reg varchar(20)
     , regol_curva_ind_iniz_n_liv_temp  varchar(20)

     , regol_valv_regolazione           char(1)
     , regol_valv_ind_iniz_data_inst    date
     , regol_valv_ind_iniz_data_dism    date
     , regol_valv_ind_iniz_fabbricante  varchar(30)
     , regol_valv_ind_iniz_modello      varchar(30)
     , regol_valv_ind_iniz_n_vie        varchar(20)
     , regol_valv_ind_iniz_servo_motore varchar(20)

     , regol_sist_multigradino          char(1)
     , regol_sist_inverter              char(1)
     , regol_altri_flag                 char(1)
     , regol_altri_desc_sistema         varchar(400)
     , regol_cod_tprg                   char(1)
     , regol_valv_termostatiche         char(1)
     , regol_valv_due_vie               char(1)
     , regol_valv_tre_vie               char(1)
     , regol_valv_note                  varchar(400)

     , regol_telettura                  char(1)
     , regol_telegestione               char(1)
     , regol_desc_sistema_iniz          varchar(400)
     , regol_data_sost_sistema          date
     , regol_desc_sistema_sost          varchar(400)

     , contab_si_no                     char(1)
     , contab_tipo_contabiliz           char(1) -- R Riscladamento, F Raffrescamento, A acqua calda sanitaria
     , contab_tipo_sistema              char(1) -- D Diretto, I Indiretto
     , contab_desc_sistema_iniz         varchar(400)
     , contab_data_sost_sistema         date
     , contab_desc_sistema_sost         varchar(400)

     , sistem_dist_tipo                 char(1) -- V Verticale --O orizzontale --C canali --A altro 
     , sistem_dist_note_altro           varchar(400)
     , sistem_dist_coibentazione_flag   char(1) -- P Presente -- A Assente
     , sistem_dist_note                 varchar(400)
     , targa                            varchar(16) -- 2016-09-09
     , sistem_emis_tipo                 char(1) -- R Radiatori -- T Termoconvettori -- V Ventilconvettori -- P Pannelli Radianti --B Bocchette -- S Strisce Radianti -- F Travi Fredde -- A Altro
     , sistem_emis_note_altro           varchar(400)
     , data_libretto                    date  --LucaR.08/05/2018 Aggiunto per la stampa del libretto per Regione Marche.
     , tipologia_intervento             varchar(5) --LucaR.18/06/2018 

     );

create unique index coimaimp_00
    on coimaimp
     ( cod_impianto
     );

create unique index coimaimp_01
    on coimaimp
     ( cod_impianto_est
     );

create index coimaimp_02
    on coimaimp
     ( cod_responsabile
     );

create index coimaimp_03
    on coimaimp
     ( cod_comune
     , cod_via
     );

create index coimaimp_04
    on coimaimp
     ( indirizzo
     );

create index coimaimp_05
    on coimaimp
     ( cod_comune
     , cod_qua
     );

create index coimaimp_06
    on coimaimp
     ( cod_distributore
     , cod_amag
     );

create index coimaimp_07
    on coimaimp
     ( cod_impianto_prov
     );

create index coimaimp_08
    on coimaimp
     ( cod_intestatario
     );

create index coimaimp_09
    on coimaimp
     ( cod_proprietario
     );

create index coimaimp_10
    on coimaimp
     ( cod_occupante
     );

create index coimaimp_11
    on coimaimp
     ( cod_amministratore
     );

create index coimaimp_14
    on coimaimp
     ( flag_tipo_impianto
     );

create index coimaimp_15
    on coimaimp
     ( cod_impianto_princ
     );

alter table coimaimp
  add constraint chk_flag_dichiarato_coimaimp
check (flag_dichiarato in ('S', 'N', 'C'));

create function coimaimp_upper_pr() returns opaque as '
declare
begin
    new.cod_impianto_est := upper(new.cod_impianto_est);
    new.toponimo         := upper(new.toponimo);
    new.indirizzo        := upper(new.indirizzo);
    return new;
end;
' language 'plpgsql';

create trigger coimaimp_upper_tr
    before insert or update on coimaimp
    for each row
        execute procedure coimaimp_upper_pr();
