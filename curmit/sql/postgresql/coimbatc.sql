/*==============================================================*/
/* table coimbatc: Gestione esecuzione lavori                   */
/*==============================================================*/
create table coimbatc
     ( cod_batc           integer not null
     , nom                varchar(30)
     , flg_stat           char(01)
     , num_comm           integer
     , dat_prev           date
     , ora_prev           time
     , dat_iniz           date
     , ora_iniz           time
     , dat_fine           date
     , ora_fine           time
     -- utente di schedulazione
     , cod_uten_sch       varchar(10)
     -- utente che eventualmente ha interrotto il batch
     , cod_uten_int       varchar(10)
     , nom_prog           varchar(50)
     , par                varchar(1000)
     , note               varchar(4000)
     );

create unique index coimbatc_00
    on coimbatc
     ( cod_batc
     );

alter table coimbatc
  add constraint chk_flg_stat_coimbatc
check (flg_stat in ('A', 'B', 'C', 'D', 'E'));
