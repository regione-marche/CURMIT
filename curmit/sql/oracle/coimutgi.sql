/*==============================================================*/
/* table coimutgi : Destinazione utilizzo generatore/impianto   */
/*==============================================================*/

create table coimutgi
     ( cod_utgi       varchar2(08) not null
     , descr_utgi     varchar2(50) not null
     , data_ins       date
     , data_mod       date
     , utente         varchar2(10)
     ) tablespace &ts_dat;

create unique index coimutgi_00
    on coimutgi
     ( cod_utgi
     ) tablespace &ts_idx;
