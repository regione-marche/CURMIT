/*==============================================================*/
/* table coimtodo: to do                                        */
/*==============================================================*/

create table coimtodo
     ( cod_todo       varchar(08)   not null
     , cod_impianto   varchar(08)   not null
-- tipologia
-- 1: da mod. H, 2:da rapp. di verifica, 3: da amministrativo, 4: generico,
-- 5: aggiornamento soggetti mod. h, 6:aggiornamento dati da rap. di verifica.
     , tipologia      varchar(08)   not null
     , note           varchar(4000)
     , cod_cimp_dimp  varchar(08)   not null
     , flag_evasione  char(01)
     , data_evasione  date
     , data_evento    date
     , data_scadenza  date
     , data_ins       date
     , data_mod       date
     , utente         varchar(10)
     );

create unique index coimtodo_00
    on coimtodo
     ( cod_todo
     ); 

create index coimtodo_01
    on coimtodo
     ( cod_impianto
     ); 