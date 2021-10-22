-- Tabella settori Uffici

create table coimsett
     ( id_settore     varchar2(20) not null
     , descrizione    varchar2(50) not null
   -- codice del responsabile
     , responsabile   varchar2(10) not null
     ) tablespace &ts_dat;

create unique index coimsett_00
    on coimsett
     ( id_settore
     ) tablespace &ts_idx;
