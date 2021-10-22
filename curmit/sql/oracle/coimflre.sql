/*==============================================================*/
/* table coimflre: anagrafica fluidi refrigeranti               */
/*==============================================================*/

create table coimflre
     ( cod_flre varchar2(08) not null
     , sigla    varchar2(35) not null
     , fluido   varchar2(50)
     , formula  varchar2(50)
     , data_ins date
     , data_mod date
     , utente   varchar2(10)
     ) tablespace &ts_dat;

create unique index coimflre_00
    on coimflre
     ( cod_flre
     ) tablespace &ts_idx;
