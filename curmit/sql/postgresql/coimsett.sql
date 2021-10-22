-- Tabella settori Uffici

create table coimsett
     ( id_settore     varchar(20) not null
     , descrizione    varchar(50) not null
   -- codice del responsabile
     , responsabile   varchar(10) not null
     );

create unique index coimsett_00
    on coimsett
     ( id_settore
     );
