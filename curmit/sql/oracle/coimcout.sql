-- Tabella comuni associati ad un utente

create table coimcout
     (id_utente        varchar2(10) not null
     ,cod_comune       varchar2(08) not null
     ,data_ins         date
     ,data_mod         date
     ,utente_ins       varchar2(10)
     ,utente_mod       varchar2(10)
  ) tablespace &ts_dat;


create unique index coimcout_00
    on coimcomu
     ( id_utente
     , cod_comune
     ) tablespace &ts_idx;

