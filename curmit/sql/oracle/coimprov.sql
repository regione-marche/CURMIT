-- Tabella province

create table coimprov
     (cod_provincia     varchar2(08) not null
     ,denominazione     varchar2(40) not null
     ,cod_regione       varchar2(08) not null
     ,flag_val          char(01)
     ,cod_istat         varchar2(07)
     ,sigla             varchar2(04) not null
     ) tablespace &ts_dat;

create unique index coimprov_00
    on coimprov
     ( cod_provincia
     ) tablespace &ts_idx;

alter table coimprov 
  add constraint chk_flag_val_coimprov
check (flag_val in ('T', 'F'));