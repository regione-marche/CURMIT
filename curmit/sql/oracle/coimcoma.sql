/*==============================================================*/
/* table coimcoma: contratti manutentori                        */
/*==============================================================*/

create table coimcoma
     ( cod_impianto     varchar2(08)   not null
     , cod_manutentore  varchar2(08)   not null
     , data_ini_valid   date           not null
     , data_fin_valid   date  
     , note             varchar2(4000)
     , data_ins         date        
     , data_mod         date
     , utente           varchar2(10)
     ) tablespace &ts_dat;

create unique index coimcoma_00
    on coimcoma
     ( cod_impianto
     , cod_manutentore
     , data_ini_valid  
     ) tablespace &ts_idx;

create index coimcoma_01
    on coimcoma
     ( cod_manutentore
     , cod_impianto
     ) tablespace &ts_idx;
