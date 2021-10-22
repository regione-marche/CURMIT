/*==============================================================*/
/* table coimqrar: tabella quartier/comune - Area territoriale  */
/*==============================================================*/

create table coimqrar
     ( cod_area         varchar2(08)  not null 
     , cod_comune       varchar2(08)  not null
     , cod_qua          varchar2(08)  not null
     , data_ins         date
     , data_mod         date
     , utente           varchar2(10)  
     ) tablespace &ts_dat;

create unique index coimqrar_00
    on coimqrar
     ( cod_area
     , cod_comune
     , cod_qua
     ) tablespace &ts_idx;

