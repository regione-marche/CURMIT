/*==============================================================*/
/* table coimutgi : Destinazione utilizzo generatore/impianto   */
/*==============================================================*/

create table coimutgi
     ( cod_utgi       varchar(08) not null
     , descr_utgi     varchar(50) not null
     , data_ins       date
     , data_mod       date
     , utente         varchar(10)
     , descr_e_utgi   varchar(100)
     );

create unique index coimutgi_00
    on coimutgi
     ( cod_utgi
     );
