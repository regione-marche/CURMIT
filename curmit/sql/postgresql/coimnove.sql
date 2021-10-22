/*==============================================================*/
/* table coimnove: tabella allegato IX                          */
/*==============================================================*/

create table coimnove
     ( cod_nove            varchar(08)   not null
     , cod_impianto        varchar(08)   not null
     , cod_manutentore     varchar(08)
     , data_consegna       date
     , luogo_consegna      varchar(100)
     , flag_art_109        char(01)
     , flag_art_11         char(01)
     , flag_installatore   char(01)
     , flag_manutentore    char(01)
     , pot_termica_mw      numeric(9,4)
     , combustibili        varchar(4000)
     , n_focolari          numeric(2)
     , pot_focolari_mw     varchar(4000)
     , n_bruciatori        numeric(2)
     , pot_tipi_bruc       varchar(4000)
     , apparecchi_acc      varchar(4000)
     , n_canali_fumo       numeric(2)
     , sez_min_canali      numeric(9,2)
     , svil_totale         numeric(9,2)
     , aperture_ispez      varchar(4000)
     , n_camini            numeric(2)
     , sez_min_camini      numeric(9,2)
     , altezze_bocche      varchar(4000)
     , durata_impianto     varchar(4000)
     , manut_ordinarie     varchar(4000)
     , manut_straord       varchar(4000)
     , varie               varchar(4000)
     , flag_consegnato     char(01)
     , firma               varchar(100)
     , data_rilascio       date
     );

create unique index coimnove_00
    on coimnove
     ( cod_nove
     );
