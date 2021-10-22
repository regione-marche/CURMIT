
-- table coimtmsg: Testata messaggi

create table coimtmsg
     ( cod_tmsg       integer       not null
     , utente_ins     varchar(10)   not null
     , ts_ins         timestamp     not null
     , oggetto        varchar(100)  not null
     , messaggio      varchar(4000) not null
     , unita_dest     varchar(100)  not null -- serve solo per gestire la modifica
     , utente_mod     varchar(10) -- solo per log
     , ts_mod         timestamp   -- solo per log
     );

create unique index coimtmsg_00
    on coimtmsg
     ( cod_tmsg
     );
