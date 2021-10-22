/*===============================================================*/
/* table coiminco: incontri                                      */
/*===============================================================*/
create table coiminco
     ( cod_inco           varchar2(08)  not null
     , cod_cinc           varchar2(08)  
     , tipo_estrazione    varchar2(08) 
     , cod_impianto       varchar2(08) 
     , data_estrazione    date
     , data_assegn        date
     , cod_opve           varchar2(08)
     , data_verifica      date
     , ora_verifica       varchar2(08)
     , data_avviso_01     date
     , cod_documento_01   varchar2(08)
     , data_avviso_02     date
     , cod_documento_02   varchar2(08)
     , stato              char(01)
     , esito              char(01)
     , note               varchar2(4000)
     , data_ins           date
     , data_mod           date
     , utente             varchar2(10)
     , tipo_lettera       char(01)
     ) tablespace &ts_dat;

create unique index coiminco_00
    on coiminco
     ( cod_inco
     ) tablespace &ts_idx;

create index coiminco_01
    on coiminco
     ( cod_impianto
     , data_estrazione
     ) tablespace &ts_idx;

create unique index coiminco_02
    on coiminco
     ( cod_cinc
     , cod_inco
     ) tablespace &ts_idx;

create index coiminco_03
    on coiminco
     ( cod_opve
     , cod_impianto
     ) tablespace &ts_idx;

