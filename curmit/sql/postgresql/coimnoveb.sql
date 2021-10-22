/*==============================================================*/
/* table coimnoveb: tabella allegato IX B                       */
/*==============================================================*/

create table coimnoveb
     ( cod_noveb            varchar(08)   not null
     , cod_impianto         varchar(08)   not null
     , cod_manutentore      varchar(08)
     , data_consegna        date
     , luogo_consegna       varchar(100)
     , flag_art_3           char(01)
     , flag_art_11          char(01)
     , flag_patente_abil    char(01)
     , flag_art_11_comma_3  char(01)
     , flag_installatore    char(01)
     , flag_responsabile    char(01)
     , n_generatori         numeric(2)
     , dich_conformita_nr   numeric(5)
     , data_dich_conform    date
     , flag_libretto_centr  char(01)
     , firma_dichiarante    varchar(100)
     , data_dichiarazione   date
     , firma_responsabile   varchar(100)
     , data_ricevuta        date
     , regolamenti_locali   varchar(100)
     , flag_verif_emis_286  char(01)
     , data_verif_emiss     date
     , risultato_mg_nmc_h   numeric(2)
     , flag_risult_conforme char(01)
     , data_alleg_libretto  date
     , combustibili         varchar(100)
     , flag_consegnato      char(01)
     , pot_term_tot_mw      numeric(9,4)
     , n_prot               varchar(20)
     , dat_prot             date
     , flag_manutentore     char(01)
     , manu_ord_1           varchar(300)
     , manu_ord_2           varchar(300)
     , manu_ord_3           varchar(300)
     , manu_ord_4           varchar(300)
     , manu_ord_5           varchar(300)
     , manu_ord_6           varchar(300)
     , manu_ord_7           varchar(300)
     , manu_ord_8           varchar(300)
     , manu_flag_1          varchar(300)
     , manu_flag_2          varchar(300)
     , manu_flag_3          varchar(300)
     , manu_flag_4          varchar(300)
     , manu_flag_5          varchar(300)
     , manu_flag_6          varchar(300)
     , manu_flag_7          varchar(300)
     , manu_flag_8          varchar(300)
     , manu_stra_1          varchar(300)
     , flag_dichiarante     char(1)
     , flag_rispetta_val_min char(1)
     , cognome_dichiarante   varchar(200)
     , nome_dichiarante      varchar(200)
     , flag_tracciato            varchar(10)
     , polveri_totali            decimal(18,2)
     , monossido_carbonio        decimal(18,2)
     , ossidi_azoto              decimal(18,2)
     , ossidi_zolfo              decimal(18,2)
     , carbonio_organico_totale  decimal(18,2)
     , composti_inorganici_cloro decimal(18,2)
     , flag_uni_13284            char(1)
     , flag_uni_14792            char(1)
     , flag_uni_15058            char(1)
     , flag_uni_10393            char(1)
     , flag_uni_12619            char(1)
     , flag_uni_1911             char(1)
     , flag_elettrochimico       char(1)
     , flag_normativa_previgente char(1)
);

create unique index coimnoveb_00
    on coimnoveb
     ( cod_noveb
     );


