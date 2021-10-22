/*==============================================================*/
/* table coimcinc: campagne incontri                            */
/*==============================================================*/
create table coimcinc
     ( cod_cinc         varchar(08)  not null
     , descrizione      varchar(40)
     , data_inizio      date         not null
     , data_fine        date         not null
     , note             varchar(4000)
     , ctr_estrat_01    integer
     , ctr_estrat_02    integer
     , ctr_estrat_03    integer
     , ctr_estrat_04    integer
     , ctr_estrat_05    integer
     , ctr_estrat_06    integer
     , ctr_estrat_08    integer
     , ctr_estrat_09    integer
     , stato            char(01)
     , data_ins         date
     , data_mod         date
     , id_utente        varchar(10)
     , controlli_prev   numeric(07)
     );

create unique index coimcinc_00
    on coimcinc
     ( cod_cinc
     );

alter table coimcinc
  add constraint chk_stato_coimcinc
check (stato in ('1', '2', '3'));
-- stato 1 = aperto
-- stato 2 = chiuso
-- stato 3 = preventivata