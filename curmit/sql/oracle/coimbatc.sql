/*==============================================================*/
/* table coimbatc: Gestione esecuzione lavori                   */
/*==============================================================*/
create table coimbatc
     ( cod_batc           number(08) not null
     , nom                varchar2(30)
     , flg_stat           char(01)
     , num_comm           number(08)
     , dat_prev           date
     , ora_prev           varchar2(08)
     , dat_iniz           date
     , ora_iniz           varchar2(08)
     , dat_fine           date
     , ora_fine           varchar2(08)
     -- utente di schedulazione
     , cod_uten_sch       varchar2(10)
     -- utente che eventualmente ha interrotto il batch
     , cod_uten_int       varchar2(10)
     , nom_prog           varchar2(50)
     , par                varchar2(1000)
     , note               varchar2(4000)
     ) tablespace &ts_dat;

create unique index coimbatc_00
    on coimbatc
     ( cod_batc
     ) tablespace &ts_idx;

alter table coimbatc
  add constraint chk_flg_stat_coimbatc
check (flg_stat in ('A', 'B', 'C', 'D', 'E'));
