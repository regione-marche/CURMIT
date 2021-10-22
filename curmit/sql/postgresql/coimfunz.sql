/*==============================================================*/
/* table coimfunz: descrizione funzioni                         */
/*==============================================================*/

create table coimfunz
     ( nome_funz      varchar(50)  not null
     , desc_funz      varchar(100)
     , tipo_funz      varchar(20)  not null      
     , dett_funz      varchar(80)  not null
     , azione         varchar(80)  not null
     , parametri      varchar(1000)
     ) ;

create unique index coimfunz_00
    on coimfunz
     ( nome_funz
     , tipo_funz
     , dett_funz
     );



