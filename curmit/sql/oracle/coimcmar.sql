/*==============================================================*/
/* table coimcmar : associazione comuni area                    */
/*==============================================================*/

create table coimcmar
     ( cod_area    varchar2(08) not null
     , cod_comune  varchar2(08) not null
     , data_ins       date
     , data_mod       date
     , utente         varchar2(10)
     ) tablespace &ts_dat;

create unique index coimcmar_00
    on coimcmar
     ( cod_area
     , cod_comune
     ) tablespace &ts_idx;
