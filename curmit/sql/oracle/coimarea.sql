/*==============================================================*/
/* table coimarea : aree geografiche                            */
/*==============================================================*/

create table coimarea
     ( cod_area       varchar2(08)  not null
     --tipo: C = raggruppamento di comuni
     --      Q = raggruppamento di quartieri
     --      V = raggruppamento di vie
     --      U = raggruppamento di aree urbane 
     , tipo_01        char(01)      not null 
     , tipo_02        char(01)  
     , descrizione    varchar2(50)  not null
     , data_ins       date
     , data_mod       date
     , utente         varchar2(10)
     ) tablespace &ts_dat;

create unique index coimarea_00
    on coimarea
     ( cod_area
     ) tablespace &ts_idx;

alter table coimarea
  add constraint chk_tipo_01_coimarea
check (tipo_01 in ('C', 'Q', 'V', 'U'));

--alter table coimarea
--  add constraint chk_tipo_02_coimarea
--check (tipo_02 in ('T', 'M'));