-- Tabella dei comuni associati ad un utente

create table coimcout
     (id_utente        varchar(10) not null
     ,cod_comune       varchar(08) not null
     ,data_ins         date
     ,data_mod         date
     ,utente_ins       varchar(10)
     ,utente_mod       varchar(10)
  );


create unique index coimcout_00
    on coimcout
     ( id_utente
     , cod_comune
     );

