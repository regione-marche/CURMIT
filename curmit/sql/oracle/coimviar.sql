/*==============================================================*/
/* table coimviar : vie/comune - area territoriale              */
/*==============================================================*/

create table coimviar
     ( cod_area          varchar2(08)    not null
     , cod_comune        varchar2(08)    not null
     , cod_via           varchar2(08)    not null
     , civico_iniz       varchar2(08)    not null
     , civico_fine       varchar2(08)    not null
     , data_ins          date
     , data_mod          date
     , utente            varchar2(10)
     ) tablespace &ts_dat;

create unique index coimviar_00
    on coimviar
     ( cod_area
     , cod_comune
     , cod_via
     ) tablespace &ts_idx;
