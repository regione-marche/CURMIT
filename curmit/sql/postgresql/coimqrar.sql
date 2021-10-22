/*==============================================================*/
/* table coimqrar: tabella quartier/comune - Area territoriale  */
/*==============================================================*/

create table coimqrar
     ( cod_area         varchar(08)  not null 
     , cod_comune       varchar(08)  not null
     , cod_qua          varchar(08)  not null
     , data_ins         date
     , data_mod         date
     , utente           varchar(10)  
     );

create unique index coimqrar_00
    on coimqrar
     ( cod_area
     , cod_comune
     , cod_qua
     );

