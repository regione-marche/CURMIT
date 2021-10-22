/*==============================================================*/
/* table coimtprg: Tipi di regolazione singolo ambiente di zona */
/*==============================================================*/

create table coimtprg
     ( cod_tprg      varchar2(08)  not null
     , descrizione   varchar2(100)
     , ordinamento   number(08)
     , data_ins      date
     , utente_ins    varchar2(10)
     , data_mod      date
     , utente_mod    varchar2(10)
     ) tablespace &ts_dat;

create unique index coimtprg_00
    on coimtprg
     ( cod_tprg
     ) tablespace &ts_idx;
