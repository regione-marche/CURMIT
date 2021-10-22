/*==============================================================*/
/* table coimarea : aree geografiche                            */
/*==============================================================*/

create table coimarea
     ( cod_area       varchar(08)  not null
     --tipo: C = raggruppamento di comuni
     --      Q = raggruppamento di quartieri
     --      V = raggruppamento di vie
     --      U = raggruppamento di aree urbane 
     , tipo_01        char(01)      not null 
     , tipo_02        char(01)  
     , descrizione    varchar(50)  not null
     , data_ins       date
     , data_mod       date
     , utente         varchar(10)
     );

create unique index coimarea_00
    on coimarea
     ( cod_area
     );

alter table coimarea
  add constraint chk_tipo_01_coimarea
check (tipo_01 in ('C', 'Q', 'V', 'U'));

--alter table coimarea
--  add constraint chk_tipo_02_coimarea
--check (tipo_02 in ('T', 'M'));