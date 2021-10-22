-- Tabella Comuni

create table coimcomu
     (cod_comune       varchar2(08) not null
     ,cod_provincia    varchar2(08) not null
     ,denominazione    varchar2(40) not null
     ,flag_val         char(01)
     ,cap              varchar2(05)
     ,id_belfiore      varchar2(04)
     ,cod_istat        varchar2(07)
     ,popolaz_citt     number(07)
     ,popolaz_aimp     number(07)
  ) tablespace &ts_dat;


create unique index coimcomu_00
    on coimcomu
     ( cod_comune
     ) tablespace &ts_idx;

alter table coimcomu 
  add constraint chk_flag_val_coimcomu
check (flag_val in ('T', 'F'));