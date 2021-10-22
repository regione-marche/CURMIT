/*==============================================================*/
/* table coimcuar: tabella Area urbana / Area Territoriale      */
/*==============================================================*/

create table coimcuar
     ( cod_area       varchar2(08)  not null
     , cod_comune     varchar2(08)  not null
     , cod_urb        varchar2(08)  not null
     , data_ins       date
     , data_mod       date
     , utente         varchar(10)
     ) tablespace &ts_dat;

create unique index coimcuar_00
    on coimcuar
     ( cod_area
     , cod_comune
     , cod_urb
     ) tablespace &ts_idx;
