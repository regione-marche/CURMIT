/*==============================================================*/
/* table coimmode: Modelli di generatore                        */
/*==============================================================*/

create table coimmode
     ( cod_mode       number(08)     not null
     , descr_mode     varchar2(30)   not null
     , cod_cost       varchar2(08)   not null
     , flag_attivo    char(01)       not null -- S=Sì/N=No
     , note           varchar2(4000)
     , data_ins       date
     , utente_ins     varchar2(10)
     , data_mod       date
     , utente_mod     varchar2(10)
     ) tablespace &ts_dat;

create unique index coimmode_00
    on coimmode
     ( cod_mode
     ) tablespace &ts_idx;
