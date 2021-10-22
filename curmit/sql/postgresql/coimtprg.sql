/*==============================================================*/
/* table coimtprg: Tipi di regolazione singolo ambiente di zona */
/*==============================================================*/

create table coimtprg
     ( cod_tprg      varchar(08)  not null
     , descrizione   varchar(100)
     , ordinamento   integer
     , data_ins      date
     , utente_ins    varchar(10)
     , data_mod      date
     , utente_mod    varchar(10)
     );

create unique index coimtprg_00
    on coimtprg
     ( cod_tprg
     );
