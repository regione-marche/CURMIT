/*==============================================================*/
/* table coimpote : classi di potenze nominali                  */
/*==============================================================*/

create table coimpote
     ( cod_potenza    varchar2(08)   not null
     , descr_potenza  varchar2(35)   not null
     , potenza_min    number(6,2)    not null
     , potenza_max    number(6,2)    not null
     , data_ins       date
     , data_mod       date
     , utente         varchar2(10)
     ) tablespace &ts_dat;

create unique index coimpote_00
    on coimpote
     ( cod_potenza
     ) tablespace &ts_idx;
