-- Tabella regioni

create table coimregi
     (cod_regione       varchar2(08) not null
     ,denominazione     varchar2(40) not null
     ,flag_val          char(01)
     ,cod_istat         varchar2(07)
     ) tablespace &ts_dat;

create unique index coimregi_00
    on coimregi
     ( cod_regione
     ) tablespace &ts_idx;

alter table coimregi 
  add constraint chk_flag_val_coimregi
check (flag_val in ('T', 'F'));