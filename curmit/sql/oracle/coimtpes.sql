/*==============================================================*/
/* table coimtpes : Tipi estrazione                             */
/*==============================================================*/

create table coimtpes
     ( cod_tpes       varchar(08) not null
     , descr_tpes     varchar(100) not null
     , data_ins       date
     , data_mod       date
     , utente         varchar(10)
     )  tablespace &ts_dat;

create unique index coimtpes_00
    on coimtpes
     ( cod_tpes
     )) tablespace &ts_idx;
