/*==============================================================*/
/* table coimcoma: contratti manutentori                        */
/*==============================================================*/

create table coimcoma
     ( cod_impianto     varchar(08)   not null
     , cod_manutentore  varchar(08)   not null
     , data_ini_valid   date          not null
     , data_fin_valid   date  
     , note             varchar(4000)
     , data_ins         date        
     , data_mod         date
     , utente           varchar(10)
     );

create unique index coimcoma_00
    on coimcoma
     ( cod_impianto
     , cod_manutentore
     , data_ini_valid  
     );

create index coimcoma_01
    on coimcoma
     ( cod_manutentore
     , cod_impianto
     );

