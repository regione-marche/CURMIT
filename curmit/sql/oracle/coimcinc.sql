/*==============================================================*/
/* table coimcinc: campagne incontri                            */
/*==============================================================*/
create table coimcinc
     ( cod_cinc         varchar2(08)  not null
     , descrizione      varchar2(40)
     , data_inizio      date         not null
     , data_fine        date         not null
     , note             varchar2(4000)
     , ctr_estrat_01    number(08)
     , ctr_estrat_02    number(08)
     , ctr_estrat_03    number(08)
     , ctr_estrat_04    number(08)
     , ctr_estrat_05    number(08)
     , ctr_estrat_06    number(08)
     , ctr_estrat_08    number(08)
     , ctr_estrat_09    number(08)
     , stato            char(01)
     , data_ins         date
     , data_mod         date
     , id_utente        varchar2(10)
     , controlli_prev   number(07)
     ) tablespace &ts_dat;

create unique index coimcinc_00
    on coimcinc
     ( cod_cinc
     ) tablespace &ts_idx;

alter table coimcinc
    add constraint chk_stato_coimcinc
check (stato in ('1','2','3'));
-- stato 1 = aperto
-- stato 2 = chiuso
-- stato 3 = preventivato