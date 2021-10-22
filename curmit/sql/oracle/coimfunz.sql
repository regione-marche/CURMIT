/*==============================================================*/
/* table coimfunz: descrizione funzioni                         */
/*==============================================================*/

create table coimfunz
     ( nome_funz      varchar2(50)  not null
     , desc_funz      varchar2(100)
     , tipo_funz      varchar2(20)  not null      
     , dett_funz      varchar2(80)  not null
     , azione         varchar2(80)  not null
     , parametri      varchar2(1000)
     ) tablespace &ts_dat;

create unique index coimfunz_00
    on coimfunz
     ( nome_funz
     , tipo_funz
     , dett_funz
     ) tablespace &ts_idx;
