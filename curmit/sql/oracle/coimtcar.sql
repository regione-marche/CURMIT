/*==============================================================*/
/* table coimtcar : collegamento tecnici - area di competenza   */
/*==============================================================*/

create table coimtcar
     ( cod_area          varchar2(08)  not null
     , cod_opve          varchar2(08)  not null
     , data_ins          date
     , data_mod          date
     , utente            varchar2(10)
     ) tablespace &ts_dat;

create unique index coimtcar_00
    on coimtcar
     ( cod_area
     , cod_opve  
     ) tablespace &ts_idx;
