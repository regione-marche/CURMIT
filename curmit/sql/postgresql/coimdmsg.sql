
-- table coimdmsg: Destinatari dei messaggi

create table coimdmsg
     ( cod_dmsg       integer       not null
     , cod_tmsg       integer       not null
     , utente_dest    varchar(10)   not null
     , flag_letto     boolean       not null default false
     , ts_lettura     timestamp
     , utente_ins     varchar(10)   not null -- solo come informazioni di log
     , ts_ins         timestamp     not null -- solo come informazioni di log
     );

create unique index coimdmsg_00
    on coimdmsg
     ( cod_dmsg
     );
