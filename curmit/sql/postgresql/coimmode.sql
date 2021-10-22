/*==============================================================*/
/* table coimmode: Modelli di generatore                        */
/*==============================================================*/

create table coimmode
     ( cod_mode       integer       not null
     , descr_mode     varchar(30)   not null
     , cod_cost       varchar(08)   not null
     , flag_attivo    char(01)      not null -- S=Sì/N=No
     , note           varchar(4000)
     , data_ins       date
     , utente_ins     varchar(10)
     , data_mod       date
     , utente_mod     varchar(10)
     );

create unique index coimmode_00
    on coimmode
     ( cod_mode
     );
