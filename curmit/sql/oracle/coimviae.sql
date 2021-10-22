/*==============================================================*/
/* table coimviae : viario                                      */
/*==============================================================*/

create table coimviae
     ( cod_via           varchar2(08)    not null
    -- se viario per provincia
     , cod_comune        varchar2(08)
     , descrizione       varchar2(50)    not null
     , descr_topo        varchar2(50)    not null 
     , descr_estesa      varchar2(50)
     ) tablespace &ts_dat;

create unique index coimviae_00
    on coimviae
     ( cod_comune
     , cod_via
     ) tablespace &ts_idx;

create unique index coimviae_01
    on coimviae
     ( cod_comune
     , descr_estesa
     , descr_topo
     ) tablespace &ts_idx;

create or replace trigger coimviae_upper_tr
   before insert or update on coimviae
      for each row
begin
   :new.cod_via          := upper(:new.cod_via);
   :new.descr_topo       := upper(:new.descr_topo);
   :new.descrizione      := upper(:new.descrizione);
   :new.descr_estesa     := upper(:new.descr_estesa);
end coimviae_upper_tr;
/
show errors
