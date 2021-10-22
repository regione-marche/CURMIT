/*==============================================================*/
/* table coimnoin: evidenza anomalie per incontri               */
/*==============================================================*/

create table coimnoin
     ( cod_noin    varchar(08) not null
     , descr_noin  varchar(100)
     , data_fine_valid date
     ) tablespace &ts_dat;

create unique index coimnoin_00
    on coimnoin
     ( cod_noin
     ) tablespace &ts_idx;
