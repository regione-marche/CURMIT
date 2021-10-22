/*==============================================================*/
/* table coimdisp: to do                                        */
/*==============================================================*/

create table coimtodo
     ( cod_todo       varchar2(08)   not null
     , cod_impianto   varchar2(08)   not null
-- tipologia
-- 1: da mod. H, 2:da rapp. di verifica, 3: da amministrativo, 4: generico
-- 5: aggiornamento soggetti mod. h, 6: aggiornamento dati da rap. verifica
     , tipologia      varchar2(08)   not null
     , note           varchar2(4000)
     , cod_cimp_dimp  varchar2(08)   not null
     , flag_evasione  char(01)
     , data_evasione  date
     , data_evento    date
     , data_scadenza  date
     , data_ins       date
     , data_mod       date
     , utente         varchar(10)
     ) tablespace &ts_dat;

create unique index coimtodo_00
    on coimtodo
     ( cod_todo
     ) tablespace &ts_idx; 

create index coimtodo_01
    on coimtodo
     ( cod_impianto
     ) tablespace &ts_idx;