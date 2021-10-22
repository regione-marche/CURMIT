/*==============================================================*/
/* table coimpote : classi di potenze al focolare nominali      */
/*==============================================================*/

create table coimpote
     ( cod_potenza    varchar(08)   not null
     , descr_potenza  varchar(35)   not null
     , potenza_min    numeric(9,2)  not null
     , potenza_max    numeric(9,2)  not null
     , data_ins       date
     , data_mod       date
     , utente         varchar(10)
     );

create unique index coimpote_00
    on coimpote
     ( cod_potenza
     );
