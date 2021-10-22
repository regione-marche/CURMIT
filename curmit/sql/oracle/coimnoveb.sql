/*==============================================================*/
/* table coimnoveb: tabella allegato IX B                       */
/*==============================================================*/

create table coimnoveb
     ( cod_noveb            varchar2(08)   not null
     , cod_impianto         varchar2(08)   not null
     , cod_manutentore      varchar2(08)
     , data_consegna        date
     , luogo_consegna       varchar2(100)
     , flag_art_3           char(01)
     , flag_art_11          char(01)
     , flag_patente_abil    char(01)
     , flag_art_11_comma_3  char(01)
     , flag_installatore    char(01)
     , flag_responsabile    char(01)
     , n_generatori         number(2)
     , dich_conformita_nr   number(5)
     , data_dich_conform    date
     , flag_libretto_centr  char(01)
     , firma_dichiarante    varchar2(100)
     , data_dichiarazione   date
     , firma_responsabile   varchar2(100)
     , data_ricevuta        date
     , regolamenti_locali   varchar2(100)
     , flag_verif_emis_286  char(01)
     , data_verif_emiss     date
     , risultato_mg_nmc_h   number(2)
     , flag_risult_conforme char(01)
     , data_alleg_libretto  date
     , combustibili         varchar2(100)
     , flag_consegnato      char(01)
     , pot_term_tot_mw      number(9,4)
     , n_prot               varchar2(20)
     , dat_prot             date
     , flag_manutentore     char(01)
     , manu_ord_1           varchar2(300)
     , manu_ord_2           varchar2(300)
     , manu_ord_3           varchar2(300)
     , manu_ord_4           varchar2(300)
     , manu_ord_5           varchar2(300)
     , manu_ord_6           varchar2(300)
     , manu_ord_7           varchar2(300)
     , manu_ord_8           varchar2(300)
     , manu_flag_1          varchar2(300)
     , manu_flag_2          varchar2(300)
     , manu_flag_3          varchar2(300)
     , manu_flag_4          varchar2(300)
     , manu_flag_5          varchar2(300)
     , manu_flag_6          varchar2(300)
     , manu_flag_7          varchar2(300)
     , manu_flag_8          varchar2(300)
     , manu_stra_1          varchar2(300)
     ) tablespace &ts_dat;

create unique index coimnoveb_00
    on coimnoveb
     ( cod_noveb
     ) tablespace &ts_idx;
