/*==============================================================*/
/* table coimcqua : quartiere                                   */
/*==============================================================*/

create table coimcqua
     ( cod_qua        varchar2(08)  not null
     , cod_comune     varchar2(08)  not null
     , descrizione    varchar2(50)  not null
     ) tablespace &ts_dat;

create unique index coimcqua_00
    on coimcqua
     ( cod_comune
     , cod_qua
     ) tablespace &ts_idx;
